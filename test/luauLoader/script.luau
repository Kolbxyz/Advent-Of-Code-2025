-- main.luau
local function main(...)
    local code: number = 84
    local msg = "Ceci est une erreur simulée depuis luau!"

    print("Arguments:", ...)
    print(msg)
    set_error_code(0)
    exit(84)
    print("You won't see this line haha!")
end
