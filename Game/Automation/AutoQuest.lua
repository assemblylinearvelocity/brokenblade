local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

local running = false
local taskPanel = player.PlayerGui:WaitForChild("Main"):WaitForChild("HomePage"):WaitForChild("TaskPanel")

local function getActiveQuest()
    local taskFrame = taskPanel.Content.Task
    for _, quest in ipairs(taskFrame:GetChildren()) do
        if quest:IsA("Frame") then
            local outline = quest:FindFirstChild("Outline")
            if outline then
                local desc = outline.Task.Description
                local defeated = outline.Defeated
                local enemy = desc.Text:match("Defeat %d+ (.+)"):gsub("s$", "")
                local current, required = defeated.Text:match("Progress (%d+)/(%d+)")
                if enemy and current and required then
                    return {
                        enemy = enemy,
                        current = tonumber(current),
                        required = tonumber(required),
                        defeated = defeated
                    }
                end
            end
        end
    end
    return nil
end

local function findEnemies(name)
    local list = {}
    for _, enemy in ipairs(workspace.EnemyService:GetChildren()) do
        if enemy:IsA("Model") and enemy.Name:find(name, 1, true) then
            table.insert(list, enemy)
        end
    end
    return list
end

local function killEnemy(enemy)
    local hrp = enemy:FindFirstChild("HumanoidRootPart")
    local hum = enemy:FindFirstChildOfClass("Humanoid")
    if hrp and hum and hum.Health > 0 then
        root.CFrame = hrp.CFrame * CFrame.new(0, 0, -3)
        task.wait(0.1)
        hum.Health = 0
        task.wait(0.5)
    end
end

local function run()
    running = true
    while running do
        local quest = getActiveQuest()
        if not quest then
            task.wait(1)
        else
            local enemies = findEnemies(quest.enemy)
            if #enemies == 0 then
                task.wait(1)
            else
                for _, enemy in ipairs(enemies) do
                    if not running then break end
                    local q = getActiveQuest()
                    if not q then break end
                    if q.current >= q.required then break end
                    killEnemy(enemy)
                end
            end
        end
        task.wait(0.5)
    end
end

return {
    start = function()
        if not running then
            task.spawn(run)
        end
    end,
    stop = function()
        running = false
    end,
    isRunning = function()
        return running
    end
}
