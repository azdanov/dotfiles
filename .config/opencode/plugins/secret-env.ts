import { Plugin } from "@opencode/plugin";
import { readFileSync } from "node:fs";

// Copies the ~/.secrets/<name> files into the server process environment so
// plugins and providers that read process.env directly (for example
// opencode-kagi-search, which reads KAGI_API_KEY) can find them even when the
// OpenCode service was started without an interactive shell.
const secrets: Record<string, string> = {
  KAGI_API_KEY: "kagi",
  GITHUB_API_KEY: "github",
};

export default Plugin.define({
  id: "secret-env",
  async setup() {
    const home = process.env.HOME ?? "";
    for (const [name, file] of Object.entries(secrets)) {
      if (process.env[name]) continue;
      try {
        const value = readFileSync(`${home}/.secrets/${file}`, "utf8").trim();
        if (value) process.env[name] = value;
      } catch {}
    }
  },
});
