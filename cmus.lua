local wibox = require("wibox")
local awful = require("awful")

cmus_widget = wibox.widget.textbox()
cmus_widget:set_align("right")

function update_cmus(widget)
   local fd = io.popen("/home/empress/Git/python/cmus.py")
   local status = fd:read("*all")
   fd:close()

   local cmus = status

   widget:set_text(cmus)
end

update_cmus(cmus_widget)

mytimer = timer({ timeout = 10 })
mytimer:connect_signal("timeout", function () update_cmus(cmus_widget) end)
mytimer:start()
