local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

local folders = {
    workspace.World.NPC.EnemyTask,
    workspace.World.NPC.BossTask
}

local npcMap = {}

local function getNPCs()
    npcMap = {}
    local list = {}
    for _, folder in ipairs(folders) do
        for _, npc in ipairs(folder:GetChildren()) do
            if npc:IsA("Model") then
                local talk = npc:FindFirstChild("Talk")
                if talk then
                    local prompt = talk:FindFirstChildOfClass("ProximityPrompt")
                    if prompt and prompt.ObjectText ~= "" then
                        local label = prompt.ObjectText
                        npcMap[label] = npc
                        table.insert(list, label)
                    end
                end
            end
        end
    end
    table.sort(list, function(a, b)
        local numA = tonumber(a:match("%d+")) or 0
        local numB = tonumber(b:match("%d+")) or 0
        return numA < numB
    end)
    return list
end

local function teleportToNPC(label)
    local npc = npcMap[label]
    if npc and npc:FindFirstChild("HumanoidRootPart") then
        root.CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
    end
end

return {
    getNPCs = getNPCs,
    teleportToNPC = teleportToNPC
}
