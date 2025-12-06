-- People.lua
local personMethods = require('test.Person')

local peopleMethods = {}

function peopleMethods:printPeople()
    for _, v in pairs(self) do
        print(string.format("%s: %d$", v.name or "?", v.getMoney() or 0))
    end
end

function peopleMethods:addPeople(names, money)
    for i, _ in pairs(names) do
        rawset(self, i, personMethods.new(names[i]))
        self[i]:transaction(money[i])
    end
end

return peopleMethods
