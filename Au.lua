-- ======================================================
-- SAI SCRIPT INJECTOR v3.0 (MOBILE EDITION)
-- Полностью адаптирован для телефонов
-- ======================================================

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")

-- Проверка на мобильное устройство
local isMobile = GuiService:GetScreenResolution().X < 800

-- ======================================================
-- ГЛАВНЫЙ GUI
-- ======================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SAI_Injector"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderColor3 = Color3.fromRGB(100, 100, 255)
MainFrame.BorderSizePixel = 2
MainFrame.Size = isMobile and UDim2.new(0, 550, 0, 500) or UDim2.new(0, 500, 0, 450)
MainFrame.Position = UDim2.new(0.5, -(isMobile and 275 or 250), 0.5, -(isMobile and 250 or 225))
MainFrame.Active = true
-- Убираем Drag для мобильных (не работает)
if not isMobile then
    MainFrame.Draggable = true
end

-- ======================================================
-- ЗАГОЛОВОК
-- ======================================================
local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.Position = UDim2.new(0, 0, 0, 0)

local Title = Instance.new("TextLabel")
Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -70, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = isMobile and "SAI Injector (Моб.)" or "SAI Script Injector v3.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = isMobile and 16 or 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TitleBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 2)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold

local MinBtn = Instance.new("TextButton")
MinBtn.Parent = TitleBar
MinBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -70, 0, 2)
MinBtn.Text = "_"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 20
MinBtn.Font = Enum.Font.GothamBold

-- ======================================================
-- ПОЛЕ ВВОДА
-- ======================================================
local ScriptBox = Instance.new("TextBox")
ScriptBox.Parent = MainFrame
ScriptBox.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
ScriptBox.BorderColor3 = Color3.fromRGB(60, 60, 150)
ScriptBox.BorderSizePixel = 1
ScriptBox.Size = UDim2.new(0.95, 0, 0.5, 0)
ScriptBox.Position = UDim2.new(0.025, 0, 0.12, 0)
ScriptBox.TextColor3 = Color3.fromRGB(200, 200, 255)
ScriptBox.TextSize = isMobile and 18 or 14
ScriptBox.Font = Enum.Font.SourceSans
ScriptBox.Text = "-- Вставьте сюда ваш скрипт\n-- Например: print('Hello!')"
ScriptBox.TextWrapped = true
ScriptBox.TextXAlignment = Enum.TextXAlignment.Left
ScriptBox.TextYAlignment = Enum.TextYAlignment.Top
ScriptBox.ClearTextOnFocus = true
ScriptBox.MultiLine = true

-- ======================================================
-- КНОПКИ (увеличены для телефона)
-- ======================================================
local btnSizeY = isMobile and 0.12 or 0.08

local ExecuteBtn = Instance.new("TextButton")
ExecuteBtn.Parent = MainFrame
ExecuteBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
ExecuteBtn.BorderColor3 = Color3.fromRGB(0, 200, 80)
ExecuteBtn.Size = isMobile and UDim2.new(0.4, 0, btnSizeY, 0) or UDim2.new(0.3, 0, btnSizeY, 0)
ExecuteBtn.Position = isMobile and UDim2.new(0.025, 0, 0.65, 0) or UDim2.new(0.025, 0, 0.68, 0)
ExecuteBtn.Text = "▶ Выполнить"
ExecuteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteBtn.TextSize = isMobile and 18 or 16
ExecuteBtn.Font = Enum.Font.GothamBold

local ClearBtn = Instance.new("TextButton")
ClearBtn.Parent = MainFrame
ClearBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
ClearBtn.BorderColor3 = Color3.fromRGB(200, 80, 80)
ClearBtn.Size = isMobile and UDim2.new(0.25, 0, btnSizeY, 0) or UDim2.new(0.2, 0, btnSizeY, 0)
ClearBtn.Position = isMobile and UDim2.new(0.45, 0, 0.65, 0) or UDim2.new(0.35, 0, 0.68, 0)
ClearBtn.Text = "Очистить"
ClearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearBtn.TextSize = isMobile and 18 or 16
ClearBtn.Font = Enum.Font.GothamBold

local PasteBtn = Instance.new("TextButton")
PasteBtn.Parent = MainFrame
PasteBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
PasteBtn.BorderColor3 = Color3.fromRGB(80, 150, 255)
PasteBtn.Size = isMobile and UDim2.new(0.25, 0, btnSizeY, 0) or UDim2.new(0.2, 0, btnSizeY, 0)
PasteBtn.Position = isMobile and UDim2.new(0.72, 0, 0.65, 0) or UDim2.new(0.57, 0, 0.68, 0)
PasteBtn.Text = "Вставить"
PasteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PasteBtn.TextSize = isMobile and 18 or 16
PasteBtn.Font = Enum.Font.GothamBold

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = MainFrame
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
ToggleBtn.BorderColor3 = Color3.fromRGB(255, 200, 50)
ToggleBtn.Size = isMobile and UDim2.new(0.3, 0, 0.1, 0) or UDim2.new(0.15, 0, btnSizeY, 0)
ToggleBtn.Position = isMobile and UDim2.new(0.35, 0, 0.90, 0) or UDim2.new(0.8, 0, 0.68, 0)
ToggleBtn.Text = "Скрыть"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = isMobile and 18 or 16
ToggleBtn.Font = Enum.Font.GothamBold

-- ======================================================
-- ЛОГ
-- ======================================================
local LogBox = Instance.new("TextBox")
LogBox.Parent = MainFrame
LogBox.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
LogBox.BorderColor3 = Color3.fromRGB(40, 40, 100)
LogBox.BorderSizePixel = 1
LogBox.Size = UDim2.new(0.95, 0, 0.2, 0)
LogBox.Position = isMobile and UDim2.new(0.025, 0, 0.78, 0) or UDim2.new(0.025, 0, 0.78, 0)
LogBox.TextColor3 = Color3.fromRGB(100, 255, 100)
LogBox.TextSize = isMobile and 14 or 12
LogBox.Font = Enum.Font.SourceSans
LogBox.Text = "[SAI] Готов к работе. Вставьте скрипт и нажмите Выполнить."
LogBox.TextWrapped = true
LogBox.TextXAlignment = Enum.TextXAlignment.Left
LogBox.TextYAlignment = Enum.TextYAlignment.Top
LogBox.ReadOnly = true
LogBox.ClearTextOnFocus = false

-- ======================================================
-- ФУНКЦИОНАЛ (без изменений)
-- ======================================================
local function logMessage(msg, color)
    color = color or Color3.fromRGB(100, 255, 100)
    local timestamp = os.date("[%H:%M:%S] ")
    LogBox.Text = LogBox.Text .. "\n" .. timestamp .. msg
    local lines = {}
    for line in string.gmatch(LogBox.Text, "[^\n]+") do
        table.insert(lines, line)
    end
    if #lines > 50 then
        table.remove(lines, 1)
        LogBox.Text = table.concat(lines, "\n")
    end
    LogBox.TextColor3 = color
end

local function executeScript(code)
    if code == nil or code == "" or code == "-- Вставьте сюда ваш скрипт\n-- Например: print('Hello!')" then
        logMessage("Ошибка: Скрипт пустой!", Color3.fromRGB(255, 100, 100))
        return
    end
    logMessage("Выполнение скрипта...", Color3.fromRGB(255, 255, 100))
    local success, err = pcall(function()
        local func, compileErr = loadstring(code)
        if not func then
            logMessage("Ошибка компиляции: " .. tostring(compileErr), Color3.fromRGB(255, 50, 50))
            return
        end
        func()
        logMessage("✓ Скрипт выполнен успешно!", Color3.fromRGB(100, 255, 100))
    end)
    if not success then
        logMessage("✗ Ошибка выполнения: " .. tostring(err), Color3.fromRGB(255, 50, 50))
    end
end

local function pasteFromClipboard()
    local success, clipboard = pcall(function()
        if getclipboard then
            return getclipboard()
        end
    end)
    if success and clipboard and clipboard ~= "" then
        ScriptBox.Text = clipboard
        logMessage("✓ Скрипт вставлен из буфера (" .. #clipboard .. " символов)", Color3.fromRGB(100, 200, 255))
    else
        logMessage("Вставка недоступна. Введите скрипт вручную.", Color3.fromRGB(255, 200, 100))
    end
end

-- ======================================================
-- ОБРАБОТЧИКИ
-- ======================================================
ExecuteBtn.MouseButton1Click:Connect(function()
    executeScript(ScriptBox.Text)
end)

ClearBtn.MouseButton1Click:Connect(function()
    ScriptBox.Text = ""
    logMessage("Поле очищено.", Color3.fromRGB(200, 200, 200))
end)

PasteBtn.MouseButton1Click:Connect(function()
    pasteFromClipboard()
end)

local isHidden = false
ToggleBtn.MouseButton1Click:Connect(function()
    isHidden = not isHidden
    if isHidden then
        MainFrame.Visible = false
        ToggleBtn.Text = "Показать"
        logMessage("Меню скрыто. Нажмите кнопку 'Показать' для возврата.", Color3.fromRGB(200, 200, 200))
    else
        MainFrame.Visible = true
        ToggleBtn.Text = "Скрыть"
        logMessage("Меню показано.", Color3.fromRGB(200, 200, 200))
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    logMessage("Закрытие инжектора...", Color3.fromRGB(255, 100, 100))
    wait(0.3)
    ScreenGui:Destroy()
end)

local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame.Size = UDim2.new(0, 200, 0, 40)
        MainFrame.Position = UDim2.new(0, 10, 0.9, -40)
        ScriptBox.Visible = false
        ExecuteBtn.Visible = false
        ClearBtn.Visible = false
        PasteBtn.Visible = false
        ToggleBtn.Visible = false
        LogBox.Visible = false
        Title.Text = "SAI [свернуто]"
        MinBtn.Text = "+"
        logMessage("Окно свернуто.", Color3.fromRGB(200, 200, 200))
    else
        MainFrame.Size = isMobile and UDim2.new(0, 550, 0, 500) or UDim2.new(0, 500, 0, 450)
        MainFrame.Position = UDim2.new(0.5, -(isMobile and 275 or 250), 0.5, -(isMobile and 250 or 225))
        ScriptBox.Visible = true
        ExecuteBtn.Visible = true
        ClearBtn.Visible = true
        PasteBtn.Visible = true
        ToggleBtn.Visible = true
        LogBox.Visible = true
        Title.Text = isMobile and "SAI Injector (Моб.)" or "SAI Script Injector v3.0"
        MinBtn.Text = "_"
        logMessage("Окно развернуто.", Color3.fromRGB(200, 200, 200))
    end
end)

-- ======================================================
-- ПРИВЕТСТВИЕ
-- ======================================================
logMessage("========================================", Color3.fromRGB(100, 200, 255))
logMessage(isMobile and "  SAI INJECTOR (MOBILE) ЗАГРУЖЕН" or "  SAI SCRIPT INJECTOR v3.0 ЗАГРУЖЕН", Color3.fromRGB(100, 255, 200))
logMessage("========================================", Color3.fromRGB(100, 200, 255))
logMessage("▶ Вставьте скрипт и нажмите 'Выполнить'", Color3.fromRGB(200, 200, 255))
logMessage("▶ Кнопка 'Скрыть' сворачивает меню", Color3.fromRGB(200, 200, 255))
if isMobile then
    logMessage("▶ Режим телефона: кнопки увеличены", Color3.fromRGB(100, 200, 255))
end
logMessage("========================================", Color3.fromRGB(100, 200, 255))

print("[SAI] Инжектор загружен. Режим: " .. (isMobile and "MOBILE" or "PC"))
