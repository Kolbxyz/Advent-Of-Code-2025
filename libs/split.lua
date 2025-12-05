-- split.lua
return function(inputstr, sep)
    sep = sep or "%s"
    local t = {}

    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end
