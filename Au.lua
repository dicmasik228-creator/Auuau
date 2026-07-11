-- ============================================
-- ВЫДАЧА БУСТА X3 (Бесплатно)
-- ============================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Функция для поиска значения буста
local function FindBoostValue()
    local char = LocalPlayer.Character
    if not char then return nil end
    
    -- Ищем в персонаже
    for _, child in pairs(char:GetChildren()) do
        if child.Name:lower():find("boost") or child.Name:lower():find("charge") or child.Name:lower():find("multiplier") then
            return child
        end
    end
    
    -- Ищем в leaderstats
    local stats = LocalPlayer:FindFirstChild("leaderstats")
    if stats then
        for _, child in pairs(stats:GetChildren()) do
            if child.Name:lower():find("boost") or child.Name:lower():find("charge") or child.Name:lower():find("multiplier") then
                return child
            end
        end
    end
    
    -- Ищем в PlayerGui (могут быть скрытые переменные)
    local gui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if gui then
        for _, child in pairs(gui:GetDescendants()) do
            if child:IsA("NumberValue") or child:IsA("IntValue") then
                if child.Name:lower():find("boost") or child.Name:lower():find("charge") or child.Name:lower():find("multiplier") then
                    return child
                end
            end
        end
    end
    
    return nil
end

-- Функция для выдачи буста
local function GiveBoost3x()
    local boostValue = FindBoostValue()
    
    if boostValue then
        -- Если это NumberValue или IntValue
        if boostValue:IsA("NumberValue") or boostValue:IsA("IntValue") then
            boostValue.Value = 3 -- Устанавливаем x3
            print("✅ Буст x3 выдан! (" .. boostValue.Name .. " = " .. boostValue.Value .. ")")
            return true
        end
        
        -- Если это StringValue (может хранить текст)
        if boostValue:IsA("StringValue") then
            boostValue.Value = "3x"
            print("✅ Буст x3 выдан! (" .. boostValue.Name .. " = 3x)")
            return true
        end
        
        -- Если это BoolValue
        if boostValue:IsA("BoolValue") then
            boostValue.Value = true
            print("✅ Буст активирован! (" .. boostValue.Name .. " = true)")
            return true
        end
    end
    
    -- Если не нашли переменную, пробуем через удалённое событие
    local rs = game:GetService("ReplicatedStorage")
    local remote = rs:FindFirstChild("GiveBoost") or rs:FindFirstChild("SetBoost") or rs:FindFirstChild("BoostMultiplier")
    if remote then
        pcall(function()
            remote:FireServer(3)
            remote:FireServer("3x")
            remote:FireServer("Charge boost 3x 10 mins")
        end)
        print("✅ Отправлен запрос на выдачу буста x3")
        return true
    end
    
    print("❌ Не удалось найти переменную для буста")
    return false
end

-- Выдаём буст
GiveBoost3x()

-- Создаём кнопку для повторной выдачи
local function CreateBoostButton()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BoostGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("CoreGui")
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 150, 0, 40)
    button.Position = UDim2.new(0, 10, 0, 60)
    button.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 14
    button.Text = "⚡ Выдать x3 буст"
    button.BorderSizePixel = 0
    button.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        GiveBoost3x()
    end)
end

task.spawn(CreateBoostButton)

print("⚡ Нажми кнопку для выдачи буста x3")
