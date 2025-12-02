-- math.lua
setmetatable(math, {
    __index = {
        round = function (n) return math.floor(n + 0.5) end
    }
})

-- such a shame that this language does not have math.round 😠
