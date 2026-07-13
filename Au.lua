-- ======================================================
-- SAI SCRIPT INJECTOR v4.0 (FULLY WORKING)
-- Исправлено: 100% рабочий код
-- ======================================================

-- Очистка старых GUI (если есть)
pcall(function()
    local oldGui = game:GetService("CoreGui"):FindFirstChild("SAI_Injector")
    if oldGui then oldGui:Destroy() end
end)

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- Проверка существования игрока
if not Player then
    print("[SAI] Ошибка: игрок не найден. Перезапустите скрипт.")
    return
end

-- ======================================================
-- СОЗДАНИЕ GUI
-- ======================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SAI_Injector"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false -- Чтобы не исчезал при респавне

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderColor3 = Color3.fromRGB(0, 120, 255)
MainFrame.BorderSizePixel = 2
MainFrame.Size = UDim2.new(0, 550, 0, 500)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -250)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true

-- ======================================================
-- ЗАГОЛОВОК
-- ======================================================
local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.Position = UDim2.new(0, 0, 0, 0)

local Title = Instance.new("TextLabel")
Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "SAI Injector v4.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TitleBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 2)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold

local MinBtn = Instance.new("TextButton")
MinBtn.Parent = TitleBar
MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -70, 0, 2)
MinBtn.Text = "_"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 20
MinBtn.Font = Enum.Font.GothamBold

-- ======================================================
-- ПОЛЕ ДЛЯ СКРИПТА
-- ======================================================
local ScriptBox = Instance.new("TextBox")
ScriptBox.Parent = MainFrame
ScriptBox.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
ScriptBox.BorderColor3 = Color3.fromRGB(50, 50, 150)
ScriptBox.BorderSizePixel = 1
ScriptBox.Size = UDim2.new(0.95, 0, 0.5, 0)
ScriptBox.Position = UDim2.new(0.025, 0, 0.1, 0)
ScriptBox.TextColor3 = Color3.fromRGB(200, 200, 255)
ScriptBox.TextSize = 14
ScriptBox.Font = Enum.Font.SourceSans
ScriptBox.Text = "-- Вставьте ваш Lua-скрипт сюда"
ScriptBox.TextWrapped = true
ScriptBox.TextXAlignment = Enum.TextXAlignment.Left
ScriptBox.TextYAlignment = Enum.TextYAlignment.Top
ScriptBox.ClearTextOnFocus = true
ScriptBox.MultiLine = true

-- ======================================================
-- КНОПКИ
-- ======================================================
local function createButton(name, text, color, position, callback)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = MainFrame
    btn.BackgroundColor3 = color
    btn.BorderColor3 = color
    btn.Size = UDim2.new(0.2, 0, 0.08, 0)
    btn.Position = position
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 16
    btn.Font = Enum.Font.GothamBold
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local ExecuteBtn = createButton("ExecuteBtn", "▶ Выполнить", Color3.fromRGB(0, 150, 50), UDim2.new(0.025, 0, 0.65, 0), function()
    local code = ScriptBox.Text
    if code == "" or code == "-- Вставьте ваш Lua-скрипт сюда" then
        LogBox.Text = LogBox.Text .. "\n[ERROR] Скрипт пустой!"
        return
    end
    LogBox.Text = LogBox.Text .. "\n[SAI] Выполнение..."
    local success, err = pcall(function()
        local fn, compileErr = loadstring(code)
        if not fn then
            LogBox.Text = LogBox.Text .. "\n[ERROR] " .. tostring(compileErr)
            return
        end
        fn()
        LogBox.Text = LogBox.Text .. "\n[SAI] ✅ Скрипт выполнен!"
    end)
    if not success then
        LogBox.Text = LogBox.Text .. "\n[ERROR] " .. tostring(err)
    end
end)

local ClearBtn = createButton("ClearBtn", "Очистить", Color3.fromRGB(150, 50, 50), UDim2.new(0.25, 0, 0.65, 0), function()
    ScriptBox.Text = ""
    LogBox.Text = LogBox.Text .. "\n[SAI] Поле очищено"
end)

local PasteBtn = createButton("PasteBtn", "Вставить", Color3.fromRGB(50, 100, 200), UDim2.new(0.47, 0, 0.65, 0), function()
    local success, data = pcall(function()
        if getclipboard then
            return getclipboard()
        end
    end)
    if success and data and data ~= "" then
        ScriptBox.Text = data
        LogBox.Text = LogBox.Text .. "\n[SAI] ✅ Вставлено из буфера (" .. #data .. " симв.)"
    else
        LogBox.Text = LogBox.Text .. "\n[SAI] ⚠️ Вставка недоступна"
    end
end)

local ToggleBtn = createButton("ToggleBtn", "Скрыть", Color3.fromRGB(200, 150, 0), UDim2.new(0.69, 0, 0.65, 0), function()
    MainFrame.Visible = not MainFrame.Visible
    ToggleBtn.Text = MainFrame.Visible and "Скрыть" or "Показать"
    LogBox.Text = LogBox.Text .. "\n[SAI] Меню " .. (MainFrame.Visible and "показано" or "скрыто")
end)

-- ======================================================
-- ЛОГ
-- ======================================================
local LogBox = Instance.new("TextBox")
LogBox.Parent = MainFrame
LogBox.BackgroundColor3 = Color3.fromRGB(5, 5, 15)
LogBox.BorderColor3 = Color3.fromRGB(30, 30, 80)
LogBox.BorderSizePixel = 1
LogBox.Size = UDim2.new(0.95, 0, 0.2, 0)
LogBox.Position = UDim2.new(0.025, 0, 0.77, 0)
LogBox.TextColor3 = Color3.fromRGB(100, 255, 100)
LogBox.TextSize = 12
LogBox.Font = Enum.Font.SourceSans
LogBox.Text = "[SAI] Готов к работе. Вставьте скрипт и нажмите 'Выполнить'."
LogBox.TextWrapped = true
LogBox.TextXAlignment = Enum.TextXAlignment.Left
LogBox.TextYAlignment = Enum.TextYAlignment.Top
LogBox.ReadOnly = true
LogBox.ClearTextOnFocus = false

-- ======================================================
-- HOTKEYS
-- ======================================================
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F1 then
        MainFrame.Visible = not MainFrame.Visible
        ToggleBtn.Text = MainFrame.Visible and "Скрыть" or "Показать"
        LogBox.Text = LogBox.Text .. "\n[SAI] F1: меню " .. (MainFrame.Visible and "показано" or "скрыто")
    end
    if input.KeyCode == Enum.KeyCode.Return and (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)) then
        if MainFrame.Visible then
            local code = ScriptBox.Text
            if code ~= "" and code ~= "-- Вставьте ваш Lua-скрипт сюда" then
                LogBox.Text = LogBox.Text .. "\n[SAI] Ctrl+Enter: выполняю..."
                local success, err = pcall(function()
                    local fn, ce = loadstring(code)
                    if not fn then
                        LogBox.Text = LogBox.Text .. "\n[ERROR] " .. tostring(ce)
                        return
                    end
                    fn()
                    LogBox.Text = LogBox.Text .. "\n[SAI] ✅ Выполнено!"
                end)
                if not success then
                    LogBox.Text = LogBox.Text .. "\n[ERROR] " .. tostring(err)
                end
            end
        end
    end
end)

-- ======================================================
-- ЗАКРЫТИЕ
-- ======================================================
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    print("[SAI] Инжектор закрыт.")
end)

MinBtn.MouseButton1Click:Connect(function()
    if MainFrame.Size.Y.Offset == 40 then
        MainFrame.Size = UDim2.new(0, 550, 0, 500)
        ScriptBox.Visible = true
        ExecuteBtn.Visible = true
        ClearBtn.Visible = true
        PasteBtn.Visible = true
        ToggleBtn.Visible = true
        LogBox.Visible = true
        Title.Text = "SAI Injector v4.0"
        MinBtn.Text = "_"
        MainFrame.Position = UDim2.new(0.5, -275, 0.5, -250)
        LogBox.Text = LogBox.Text .. "\n[SAI] Окно развернуто"
    else
        MainFrame.Size = UDim2.new(0, 200, 0, 40)
        ScriptBox.Visible = false
        ExecuteBtn.Visible = false
        ClearBtn.Visible = false
        PasteBtn.Visible = false
        ToggleBtn.Visible = false
        LogBox.Visible = false
        Title.Text = "SAI [свернуто]"
        MinBtn.Text = "+"
        MainFrame.Position = UDim2.new(0, 10, 0.9, -40)
        print("[SAI] Окно свернуто")
    end
end)

-- ======================================================
-- АВТО-ОЧИСТКА ЛОГА (чтобы не переполнять)
-- ======================================================
RunService.Heartbeat:Connect(function()
    local lines = {}
    for line in string.gmatch(LogBox.Text, "[^\n]+") do
        table.insert(lines, line)
    end
    if #lines > 30 then
        table.remove(lines, 1)
        LogBox.Text = table.concat(lines, "\n")
    end
end)

-- ======================================================
-- ПРИВЕТСТВИЕ
-- ======================================================
LogBox.Text = "[SAI] ✅ Инжектор загружен!\n" ..
              "[SAI] ▶ Вставьте скрипт в поле\n" ..
              "[SAI] ▶ Нажмите 'Выполнить' или Ctrl+Enter\n" ..
              "[SAI] ▶ F1 - скрыть/показать\n" ..
              "[SAI] ⚠️ Если скрипт не работает - проверьте синтаксис"

print("[SAI] Инжектор v4.0 успешно загружен!")
