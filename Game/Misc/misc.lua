local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

local folders = {
    workspace.World.NPC.EnemyTask,
    workspace.World.NPC.BossTask
}

local function getLabel(npc)
    local talk = npc:FindFirstChild("Talk")
    if talk then
        local prompt = talk:FindFirstChildOfClass("ProximityPrompt")
        if prompt and prompt.ObjectText ~= "" then
            return prompt.ObjectText
        end
    end
    return npc.Name
end

local npcMap = {}

local function getNPCs()
    npcMap = {}
    local list = {}
    for _, folder in ipairs(folders) do
        for _, npc in ipairs(folder:GetChildren()) do
            if npc:IsA("Model") then
                local label = getLabel(npc)
                npcMap[label] = npc
                table.insert(list, label)
            end
        end
    end
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
