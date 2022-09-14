local awful = require("awful")
local keys = require("main.keys.user_variables").keys
client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({
    --kill a client
    awful.key({ keys.mod }, "q", function()
      client.focus:kill()
    end),
    --Toggle fullscreen
    awful.key({ keys.mod, keys.shift }, "f",
      function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end),
    --Toggle floating mode
    awful.key({ keys.mod, keys.ctrl }, "space", awful.client.floating.toggle),

    --Center window
    awful.key({ keys.mod }, "c", function(c)
      awful.placement.centered(c, { honor_workarea = true, honor_padding = true })
    end),

    --Swap with master
    awful.key({ keys.mod, keys.shift }, "Return", function(c) c:swap(awful.client.getmaster()) end),

    awful.key({ keys.mod }, "o", function(c) c:move_to_screen() end),

    awful.key({ keys.mod }, "t", function(c) c.ontop = not c.ontop end),

    -- Minimize focus window
    awful.key({ keys.mod, keys.shift }, "n",
      function(c)

        c.minimized = true
      end,
      { description = "minimize", group = "client" }),


    awful.key({ keys.mod }, "m",
      function(c)
        c.maximized = not c.maximized
        c:raise()
      end,
      { description = "(un)maximize", group = "client" }),

    awful.key({ keys.mod, keys.ctrl }, "m",
      function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
      end,
      { description = "(un)maximize vertically", group = "client" }),

    awful.key({ keys.mod, keys.shift }, "m",
      function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
      end,
      { description = "(un)maximize horizontally", group = "client" }),
  })
end
)

