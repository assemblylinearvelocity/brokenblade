local base = "https://raw.githubusercontent.com/assemblylinearvelocity/brokenblade/main/"
local AutoQuest = loadstring(game:HttpGet(base .. "Game/Automation/AutoQuest.lua"))()

local box = Tabs.Automation:AddLeftGroupbox("Auto Quest")

box:AddToggle("AutoQuestToggle", {
    Text = "Auto Quest",
    Default = false,
    Callback = function(val)
        if val then
            AutoQuest.start()
        else
            AutoQuest.stop()
        end
    end
})
