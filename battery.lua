local wibox = require("wibox")
local awful = require("awful")

battery_widget = wibox.widget.textbox()
battery_widget:set_align("right")

function update_battery(widget)
   local fd = io.popen("acpi | cut -d ',' -f 2")
   local status = fd:read("*all")
   fd:close()

   local bat = status

   widget:set_markup('<span color="#3399ff">'..bat..'</span>')
end

update_battery(battery_widget)

mytimer = timer({ timeout = 10 })
mytimer:connect_signal("timeout", function () update_battery(battery_widget) end)
mytimer:start()

