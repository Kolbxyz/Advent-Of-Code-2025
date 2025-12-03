-- Person.lua
local methods = {
    new = function(name)
        local self = {}
        local money = 0
        self.name = name

        function self.getMoney()
            return money
        end

        function self.transaction(_, amount)
            money = money + amount
        end

        return setmetatable({}, {
            __index = self,
            __newindex = function() print("You cannot directly modify users.") end
        })
    end,
}

return setmetatable(methods, {__index = methods})
