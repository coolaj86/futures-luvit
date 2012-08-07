local table = require('table')

local Sequence = {}

function Sequence:new()
  local o = {}
  setmetatable(o, self)
  self.__index = self

  self.count = 0
  self.complete = 0
  self.callbacks = {}
  self.stopped = true

  return o
end

function Sequence:cont(...)
  local fn

  function tickle(...)
    if self.stopped then
      print('quit calling next so fast!')
      return
    end

    self.stopped = true
    self:cont(arg)
  end

  if not self.stopped then
    return
  end

  fn = table.remove(self.callbacks, 1)

  if not fn then
    self.stopped = true
  else
    self.stopped = false
    fn(tickle, arg)
  end
end

function Sequence:next(cb)
  table.insert(self.callbacks, cb)
  self:cont()
end

return Sequence
