-- Серверный скрипт (помести в ServerScriptService)
local Players = game:GetService("Players")

local function giveAllItems(player)
    local itemsFolder = game.ReplicatedStorage:FindFirstChild("Items") 
        or game.ServerStorage:FindFirstChild("Items")
    
    if not itemsFolder then
        warn("Папка Items не найдена!")
        return
    end
    
    local backpack = player:FindFirstChild("Backpack")
    if not backpack then return end
    
    for _, item in itemsFolder:GetChildren() do
        if item:IsA("Tool") then
            local clone = item:Clone()
            clone.Parent = backpack
            print("Выдал " .. item.Name .. " игроку " .. player.Name)
        end
    end
end

-- Выдать всем текущим игрокам
for _, player in Players:GetPlayers() do
    task.wait(0.5) -- чтобы инвентарь загрузился
    giveAllItems(player)
end

-- Выдавать новым игрокам
Players.PlayerAdded:Connect(function(player)
    player:WaitForChild("Backpack")
    task.wait(1)
    giveAllItems(player)
end)
