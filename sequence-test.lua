local Sequence = require('./sequence')
local timer = require('timer')
local max = 10
local s
local nums = {}
local table = require('table')

s = Sequence:new()

local printNum = function (i)
  local printNow = function (next)
    table.insert(nums, i)
    next()
  end

  local printLater = function (next)
    timer.setTimeout(100, function ()
      printNow(next)
    end)
  end

  if not (0 == i % 2) then
    s:next(printNow)
  else
    s:next(printLater)
  end
end

for i = 1, max do
  printNum(i)
end

s:next(function ()
  if not (10 == #nums) then
    print('expected 10 numbers but got ' .. #nums)
    error()
  end

  for i = 1, max do
    if not (i == nums[i]) then
      print('expected numbers in order but got ' .. nums[i] .. ' at ' .. i)
      error()
    end
  end

  print('pass')
end)
