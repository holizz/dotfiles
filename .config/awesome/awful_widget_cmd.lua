---------------------------------------------------------------------------
-- @author Julien Danjou &lt;julien@danjou.info&gt;
-- @copyright 2009 Julien Danjou
-- @release v3.4.8
---------------------------------------------------------------------------

local setmetatable = setmetatable
local io = io
local capi = { widget = widget,
               timer = timer }

--- Text clock widget.
module("awful.widget.cmd")

--- Create a cmd widget. It draws the time it is in a textbox.
-- @param args Standard arguments for textbox widget.
-- @param timeout How often update the time. Default is 60.
-- @return A textbox widget.
function new(args, command, timeout)
  local args = args or {}
  local timeout = timeout or 60
  args.type = "textbox"
  local w = capi.widget(args)
  local timer = capi.timer { timeout = timeout }
  w.text = io.popen(command):read()
  timer:add_signal("timeout", function() w.text = io.popen(command):read() end)
  timer:start()
  return w
end

function cmd(command)
  return io.popen(command):read()
end

setmetatable(_M, { __call = function(_, ...) return new(...) end })
