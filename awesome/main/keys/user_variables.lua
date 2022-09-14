-- local filesysytem = require("gears.filesystem")
--local config_dir = filesysytem.get_configuration_dir()

return {
    --Default applicatons
    default = {
        terminal = "alacritty",
        browser = "firefox",
        file_manager = "thunar",
        term_fm = "lf",
        power_manger = "xfce4-power-manager",
        app_launcher = "dmenu_run",
        code_editor = "codium",
        editor = "nvim",
    },

    keys = {
        mod = "Mod4",
        alt = "Mod1",
        ctrl = "Control",
        shift = "Shift",
    }
}
