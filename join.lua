local Join = {}
local table = require('table')
local pp = require('utils').prettyPrint

function Join:new()
  local o = {}
  setmetatable(o, self)
  self.__index = self

  self.count = 0
  self.complete = 0
  self.callbacks = {}
  self.started = false
  self.data = {}

  return o
end

function Join:add(cb)
  if self.started then
    print("No you didn't add a callback after you done joined it all up. No sir. No sir!")
    error()
  end

  local me = self
  self.count = self.count + 1

  local i = self.count

  local function getArgs(...)
    local arguments = {...}
    arguments.n = select('#', ...)
    self.data[i] = arguments
    self.complete = self.complete + 1
    if self.complete == self.count then
      self:winner()
    end
  end

  if cb then
    if not ('function' == type(cb)) and cb.when then
      cb.when(getArgs)
    else
      cb(getArgs)
    end
  else
    return getArgs
  end
end

function Join:winner()
  for i, v in ipairs(self.callbacks) do
    v(unpack(self.data))
  end
end

function Join:when(cb)
  self.started = true
  table.insert(self.callbacks, cb)
end

return Join
