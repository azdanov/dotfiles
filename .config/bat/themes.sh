#!/usr/bin/env sh
# https://github.com/0xTadash1/bat-into-tokyonight/blob/main/bat-into-tokyonight

set -eu
type bat >/dev/null 2>&1

REPO='https://github.com/AstroNvim/astrotheme.git'
REPO_NAME='astrotheme/'
THEME_DIR='extras/sublime/'

BAT_THEMES_DIR="$(command bat --config-dir)/themes"
[ ! -d "$BAT_THEMES_DIR" ] && mkdir -p "$BAT_THEMES_DIR"

cd "$BAT_THEMES_DIR"
if [ ! -d "$REPO_NAME" ]; then
  # Init
  git clone --no-checkout --depth=1 --filter=blob:none "$REPO"
  cd "$REPO_NAME"
  git sparse-checkout set --no-cone '!/*' "$THEME_DIR"
  git checkout
else
  # Update
  cd "$REPO_NAME"
  git fetch --filter=blob:none
  updates="$(git rev-list HEAD..@{u} -- "$THEME_DIR")"
  [ -n "$updates" ] && git merge --ff-only --log
fi

# Revalidate bat cache with mtime
BAT_THEME_CACHE="$(command bat --cache-dir)/themes.bin"
if [ ! -e "$BAT_THEME_CACHE" ] ||
  [ -n "$(find "$BAT_THEMES_DIR" -name '*.tmTheme' -newer "$BAT_THEME_CACHE")" ]; then
  command bat cache --build
fi
