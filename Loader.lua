local base = ""

local function load(path)
    local ok, result = pcall(function()
        return loadstring(game:HttpGet(base .. path))()
    end)
    if not ok then
        warn("Loaded, hi:3" .. path .. "\n" .. tostring(result))
    end
end