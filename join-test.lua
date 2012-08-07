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
    local args = arguments[i]
    if not (3 == args.n) then
      print('did not have a length of 3')
      pp(args)
      error()
    end
    if not (i == args[1]) then
      print('expected numbers in order but got ' .. arguments[i][0] .. ' at ' .. i)
      pp(args)
      error()
    end
  end
  print('pass')
end)
