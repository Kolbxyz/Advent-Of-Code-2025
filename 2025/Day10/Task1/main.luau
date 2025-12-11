--!strict
-- main.luau
-- vars
local file : string = require("./input")

-- types
type LightState = { number }
type Button = { number }

-- funcs
local function patternToMatrix(pattern: string): LightState
    local ret = {}
    for i = 1, #pattern do
        local char = pattern:sub(i, i)
        table.insert(ret, char == "#" and 1 or 0)
    end
    return ret
end

local function buttonsToMatrix(buttons: string): Button
    local ret = {}

    for _, v in ipairs(string.split(buttons, ",")) do
        table.insert(ret, tonumber(v) + 1)
    end
    return ret
end

local function applyButtonPress(state: LightState, button: Button): LightState
    local newState = table.clone(state)

    for _, idx in ipairs(button) do
        newState[idx] = bit32.bxor(newState[idx], 1) -- I could do "1 - newState[idx]" but XOR is cooler 😎
    end
    return newState
end

local function statesEqual(state1, state2): boolean
    for i = 1, #state1 do
        if state1[i] ~= state2[i] then
            return false
        end
    end
    return true
end

local function findMinPresses(buttonMatrix, patternMatrix): number
    local numButtons = #buttonMatrix
    local initialState = table.create(#patternMatrix, 0)

    local minPresses = math.huge
    local function tryButtons(btnIdx, currentState, pressCount)
        if pressCount >= minPresses then
            return
        end
        if btnIdx > numButtons then
            if statesEqual(currentState, patternMatrix) then
                minPresses = math.min(minPresses, pressCount)
            end
            return
        end
        tryButtons(btnIdx + 1, currentState, pressCount) -- Option 1
        local newState = applyButtonPress(currentState, buttonMatrix[btnIdx]) -- Option 2
        tryButtons(btnIdx + 1, newState, pressCount + 1)
    end
    tryButtons(1, initialState, 0)
    return minPresses
end

local function parse(fileContent : string?)
    local patternMatrix = {}
    local buttonMatrix = {}

    assert(fileContent, "Invalid file provided")
    for _, line : string in ipairs(string.split(fileContent, "\n")) do
        if not line:match("%S") then continue end
        local pattern = patternToMatrix(line:match("%[(.-)%]"))
        local buttons = {}

        for v in line:gmatch("%((.-)%)") do
            table.insert(buttons, buttonsToMatrix(v))
        end
        table.insert(patternMatrix, pattern)
        table.insert(buttonMatrix, buttons)
    end
    return patternMatrix, buttonMatrix
end

local function just_do_all_the_computation_and_print_the_result(file)
    local patternMatrix, buttonMatrix = parse(file)
    local totalPresses = 0

    for i = 1, #patternMatrix do
        local minPresses = findMinPresses(buttonMatrix[i], patternMatrix[i])
        totalPresses += minPresses
    end
    print(totalPresses)
end

just_do_all_the_computation_and_print_the_result(file)
