local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local apps = require("main.keys.user_variables")
local keys = require("main.keys.user_variables").keys
local xrandr = require("main.keys.xrandr")

-- Default Application Keyybindings
awful.keyboard.append_global_keybindings({
    awful.key({keys.mod}, "Return", function()
        awful.spawn(apps.default.terminal)
    end),

    awful.key({keys.mod}, "w", function()
        awful.spawn(apps.default.browser)
    end),

    awful.key({keys.mod}, "n", function()
        awful.spawn(apps.default.file_manager)
    end),

    awful.key({keys.mod}, "f", function()
        awful.spawn.with_shell(apps.default.terminal .. " -e " ..apps.default.term_fm)
    end),

    awful.key({ keys.mod }, "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),
    
    awful.key({keys.mod, keys.alt},"a",function()xrandr.xrandr() end)
})

--AwesomeWM Keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ keys.mod, keys.ctrl }, "r", awesome.restart, { description = "reload awesome", group = "WM" }),
	awful.key({ keys.mod, keys.ctrl }, "q", awesome.quit, { description = "quit awesome", group = "WM" }),
	awful.key({ keys.mod }, "F1", hotkeys_popup.show_help, { description = "show Help", group = "WM" }),
})

--Focus related keybinds
awful.keyboard.append_global_keybindings({
    awful.key({ keys.mod }, "k", function()
		awful.client.focus.bydirection("up")
	end, { description = "focus up", group = "client" }),

    awful.key({ keys.mod }, "j", function()
		awful.client.focus.bydirection("down")
	end, { description = "focus down", group = "client" }),

    awful.key({ keys.mod }, "h", function()
		awful.client.focus.bydirection("left")
	end, { description = "focus left", group = "client" }),

    awful.key({ keys.mod }, "l", function()
		awful.client.focus.bydirection("right")
	end, { description = "focus right", group = "client" }),

     -- Swap layout
    awful.key({ keys.mod}, "space", function () awful.layout.inc(1) end,
    {description = "select next", group = "layout"}),
    awful.key({ keys.mod, keys.shift }, "space", function () awful.layout.inc(-1) end,
    {description = "select previous", group = "layout"}),
     
    --Focus the other screen
    awful.key({ keys.mod, keys.ctrl }, "j", function () awful.screen.focus_relative( 1) end,
    {description = "focus the next screen", group = "screen"}),
    awful.key({keys.mod, keys.ctrl}, "k", function () awful.screen.focus_relative(-1) end,
    {description = "focus the previous screen", group = "screen"}),
})


-- Misc
awful.keyboard.append_global_keybindings({
    awful.key({ keys.mod, keys.ctrl }, "n", function(c)
        awful.client.restore()
        -- Focus restored client
        if c then
            c:activate({ raise = true, context = "key.unminimize" })
        end
    end, { description = "restore minimized", group = "client" }),

    --- Brightness Control
	awful.key({}, "XF86MonBrightnessUp", function()
		awful.spawn("brightnessctl set 5%+ -q", false)
		awesome.emit_signal("widget::brightness")
		awesome.emit_signal("module::brightness_osd:show", true)
	end, { description = "increase brightness", group = "hotkeys" }),
	awful.key({}, "XF86MonBrightnessDown", function()
		awful.spawn("brightnessctl set 5%- -q", false)
		awesome.emit_signal("widget::brightness")
		awesome.emit_signal("module::brightness_osd:show", true)
	end, { description = "decrease brightness", group = "hotkeys" }),

    --- Volume control
	awful.key({}, "XF86AudioRaiseVolume", function()
		awful.spawn("amixer sset Master 5%+", false)
		awesome.emit_signal("widget::volume")
		awesome.emit_signal("module::volume_osd:show", true)
	end, { description = "increase volume", group = "hotkeys" }),
	awful.key({}, "XF86AudioLowerVolume", function()
		awful.spawn("amixer sset Master 5%-", false)
		awesome.emit_signal("widget::volume")
		awesome.emit_signal("module::volume_osd:show", true)
	end, { description = "decrease volume", group = "hotkeys" }),
	awful.key({}, "XF86AudioMute", function()
		awful.spawn("amixer sset Master toggle", false)
	end, { description = "mute volume", group = "hotkeys" }),

})

-- Bindings related to tags
awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { keys.mod },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { keys.mod, keys.ctrl},
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { keys.mod, keys.shift},
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { keys.mod, keys.ctrl, keys.shift },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function (index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    }
})