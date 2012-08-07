local Join = require('./join')
local timer = require('timer')
local j
local pp = require('utils').prettyPrint

j = Join:new()

local printNum = function (i)
  local printNow = function (cb)
    cb(i, nil, 'cool')
  end

  local printLater = function (next)
    timer.setTimeout(100, function ()
      printNow(next)
    end)
  end

  if not (0 == i % 2) then
    j:add(printNow)
  else
    if not (0 == i % 4) then
      j:add(printLater)
    else
      printLater(j:add())
    end
  end
end

for i = 1, 10 do
  printNum(i)
end

j:when(function (...)
  local arguments = {...}
  for i = 1, #arguments do
    pp(arguments[i])
  end
  print('pass')
end)
