import { readFileSync } from "node:fs";

// Copies ~/.secrets/<name> files into the Pi process environment so config
// values that read process.env directly resolve even when Pi was started
// without an interactive shell (so fish conf.d/00-secrets.fish never ran).
// Module evaluation happens before providers authenticate and before MCP
// servers connect, so `${KAGI_API_KEY}` in mcp.json/models.json and child
// shells (read, bash, edit, write tools) all see these values.
// Already-set variables win, so an explicit export still overrides the file.
const secrets: Record<string, string> = {
  KAGI_API_KEY: "kagi",
  GITHUB_API_KEY: "github",
};

const home = process.env.HOME ?? "";
for (const [name, file] of Object.entries(secrets)) {
  if (process.env[name]) continue;
  try {
    const value = readFileSync(`${home}/.secrets/${file}`, "utf8").trim();
    if (value) process.env[name] = value;
  } catch {
    // Missing or unreadable secret file: leave the variable unset.
  }
}

export default function () {}
