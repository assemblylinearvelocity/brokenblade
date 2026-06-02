local base = "https://raw.githubusercontent.com/assemblylinearvelocity/brokenblade/main/"

local function load(path)
    local ok, result = pcall(function()
        return loadstring(game:HttpGet(base .. path))()
    end)
    if not ok then
        warn("Failed to load: " .. path .. "\n" .. tostring(result))
    end
    return result
end

local Library = load("ObsidianLib/Library.lua")
local SaveManager = load("ObsidianLib/addons/SaveManager.lua")
local ThemeManager = load("ObsidianLib/addons/ThemeManager.lua")

local Window = Library:CreateWindow({
    Title = "Broken Blade",
    Footer = "v1.0",
    Center = true,
    AutoShow = true,
})

local Tabs = {
    Main = Window:AddTab("Main"),
    Misc = Window:AddTab("Misc"),
    Automation = Window:AddTab("Automation"),
    Exploits = Window:AddTab("Exploits"),
    Settings = Window:AddTab("Settings"),
}

getgenv().Window = Window
getgenv().Tabs = Tabs
getgenv().Options = Library.Options
getgenv().Toggles = Library.Toggles

load("Menu/MainT.lua")
load("Menu/MiscT.lua")
load("Menu/AutomationT.lua")
load("Menu/ExploitsT.lua")

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()

ThemeManager:ApplyToTab(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

SaveManager:LoadAutoloadConfig()
