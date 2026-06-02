local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

local folders = {
    workspace.World.NPC.EnemyTask,
    workspace.World.NPC.BossTask
}

local function getNPCs()
    local list = {}
    for _, folder in ipairs(folders) do
        for _, npc in ipairs(folder:GetChildren()) do
            if npc:IsA("Model") then
                table.insert(list, npc.Name)
            end
        end
    end
    return list
end

local function teleportToNPC(name)
    for _, folder in ipairs(folders) do
        local npc = folder:FindFirstChild(name)
        if npc and npc:FindFirstChild("HumanoidRootPart") then
            root.CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
            return
        end
    end
end

return {
    getNPCs = getNPCs,
    teleportToNPC = teleportToNPC
}
