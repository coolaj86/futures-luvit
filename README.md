Futures-Luvit
===

A port of the popular [FuturesJS](https://github.com/coolaj86/futures) to Lua/[Luvit](https://github.com/luvit/luvit).

Sequence
---

Since `then` is a reserved word in Lua, the API has been changed ever so slightly.

    local timer = require('timer')
    local Sequence = require('sequence')
    local s

    s = Sequence:new()
    s:next(function (cb) 
      print('one')
      timer.setTimeout(500, cb)
    end)
    s:next(function (cb) 
      print('two')
    timer.setTimeout(100, cb)
    end)
    s:next(function () 
      print('three')
    end)

**API**

  * `next` - enqueue a function to run once the previous function has called `cb`

Join
---

    local timer = require('timer')
    local Join = require('join')
    local j

    j = Join:new()
    -- poop a new callback if you need one
    timer.setTimeout(100, j:add())
    -- or add callback you've already constructed
    j:add(function (cb)
      timer.setTimeout(100, cb)
    end)
    -- and when all callbacks are done get the arguments back in the right order
    -- Huzzah!
    j:when(function (...)
      pp({...})
    end)

**API**

  * `add` - accepts or poops a callback
  * `when` - enques a final callback to be called once all callbacks have completed

License
===

Copyright AJ ONeal 2012

This project is available under the MIT and Apache v2 licenses.

  * http://www.opensource.org/licenses/mit-license.php
  * http://www.apache.org/licenses/LICENSE-2.0.html
