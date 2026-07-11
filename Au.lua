-- ============================================
-- ПОКАЗАТЬ ВСЕ ПЕРЕМЕННЫЕ (для поиска буста)
-- ============================================

local LocalPlayer = game.Players.LocalPlayer

print("=== ИЩЕМ ПЕРЕМЕННЫЕ ДЛЯ БУСТА ===")

-- 1. В персонаже
local char = LocalPlayer.Character
if char then
    print("--- В персонаже ---")
    for i, v in pairs(char:GetChildren()) do
        print(i, v.Name, v.ClassName)
    end
end

-- 2. В leaderstats
local stats = LocalPlayer:FindFirstChild("leaderstats")
if stats then
    print("--- В leaderstats ---")
    for i, v in pairs(stats:GetChildren()) do
        print(i, v.Name, v.ClassName)
    end
end

-- 3. В PlayerGui
local gui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
if gui then
    print("--- В PlayerGui ---")
    for i, v in pairs(gui:GetDescendants()) do
        if v:IsA("NumberValue") or v:IsA("IntValue") or v:IsA("StringValue") or v:IsA("BoolValue") then
            print(i, v.Name, v.ClassName, v.Value)
        end
    end
end

-- 4. В ReplicatedStorage (удалённые события)
local rs = game:GetService("ReplicatedStorage")
print("--- В ReplicatedStorage ---")
for i, v in pairs(rs:GetChildren()) do
    print(i, v.Name, v.ClassName)
end

print("=== ГОТОВО ===")
print("Скопируй вывод сюда, я скажу что делать")
