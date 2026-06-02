local base = "https://raw.githubusercontent.com/assemblylinearvelocity/brokenblade/main/"
local Misc = loadstring(game:HttpGet(base .. "Game/Misc/misc.lua"))()

local box = Tabs.Misc:AddLeftGroupbox("Quest Teleporter")

box:AddDropdown("QuestNPC", {
    Text = "Select NPC",
    Values = Misc.getNPCs(),
    Default = 1
})

box:AddButton("Teleport", function()
    local selected = Options.QuestNPC.Value
    if selected then
        Misc.teleportToNPC(selected)
    end
end)
