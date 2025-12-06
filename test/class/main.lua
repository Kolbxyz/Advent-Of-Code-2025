-- test.lua
local people = setmetatable({}, {
    __index = require("test.People"),
    __newindex = function() print("Use self:addPeople({names}, {money}) to add new users.") end
})

-- vars
local bankNames = {
    "Bob",
    "Alice",
    "Frank Leboeuf"
}
local bankAccounts = {
    42,
    -18,
    283
}

-- execution
people:addPeople(bankNames, bankAccounts)
--people:printPeople()
people[2].name = "Boss"
people:printPeople()