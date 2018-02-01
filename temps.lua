local wibox = require("wibox")
local awful = require("awful")

temps_widget = wibox.widget.textbox()
temps_widget:set_align("right")

function update_temps(widget)
   local fd = io.popen("sensors | grep Package | awk '{ print $4 }'")
   local temps = fd:read("*all")
   fd:close()

   widget:set_markup(string.format('<span color="#FF3300"> '..temps.. ' </span>'))
end

update_temps(temps_widget)

memtimer = timer({ timeout = 10 })
memtimer:connect_signal("timeout", function () update_temps(temps_widget) end)
memtimer:start()
