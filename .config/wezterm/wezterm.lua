local wezterm = require("wezterm")

local catppuccin = require("colors/catppuccin")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

catppuccin.apply_to_config(config, {
    sync = true,
    sync_flavours = {
        light = "latte",
        dark = "macchiato",
    },
    accent = "sapphire",
    flavour = "macchiato",
})

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.font = wezterm.font("CaskaydiaCove Nerd Font")
config.font_size = 14.0
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
    left = 4,
    right = 4,
    top = 4,
    bottom = 0,
}
config.initial_rows = 35
config.initial_cols = 120

local act = wezterm.action
config.mouse_bindings = {
    {
        event = { Down = { streak = 1, button = { WheelUp = 1 } } },
        mods = "NONE",
        action = wezterm.action.ScrollByLine(-3),
        alt_screen = false,
    },
    {
        event = { Down = { streak = 1, button = { WheelDown = 1 } } },
        mods = "NONE",
        action = wezterm.action.ScrollByLine(3),
        alt_screen = false,
    },
}

return config
