local wibox = require("wibox")
local awful = require("awful")

activeram_widget = wibox.widget.textbox()
activeram_widget:set_align("right")

function update_activeram(widget)
   local fd = io.popen("free -h | awk '/Mem:/ { print $3 }'")
   local ram = fd:read("*all")
   fd:close()

   widget:set_markup(string.format('<span color="#9933ff">'..ram.. '</span>'))
end

update_activeram(activeram_widget)

memtimer = timer({ timeout = 10 })
memtimer:connect_signal("timeout", function () update_activeram(activeram_widget) end)
memtimer:start()
