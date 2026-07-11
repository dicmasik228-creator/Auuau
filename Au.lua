-- ============================================
-- ПЕРЕВОДЧИК ТЕКСТА (Русский → Другие языки)
-- ============================================

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Создаём GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TranslatorGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = CoreGui

-- Главное окно
local mainFrame = Instance.new("Frame")
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Parent = screenGui

-- Скругление углов
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Заголовок
local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Text = "🌍 Переводчик"
title.Position = UDim2.new(0, 15, 0, 10)
title.Size = UDim2.new(1, -30, 0, 30)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = mainFrame

-- Поле для ввода текста на русском
local inputLabel = Instance.new("TextLabel")
inputLabel.BackgroundTransparency = 1
inputLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
inputLabel.Font = Enum.Font.SourceSans
inputLabel.TextSize = 14
inputLabel.Text = "📝 Введите текст на русском:"
inputLabel.Position = UDim2.new(0, 15, 0, 50)
inputLabel.Size = UDim2.new(1, -30, 0, 20)
inputLabel.TextXAlignment = Enum.TextXAlignment.Left
inputLabel.Parent = mainFrame

local inputBox = Instance.new("TextBox")
inputBox.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.Font = Enum.Font.SourceSans
inputBox.TextSize = 16
inputBox.Text = ""
inputBox.PlaceholderText = "Введите текст..."
inputBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
inputBox.Position = UDim2.new(0, 15, 0, 75)
inputBox.Size = UDim2.new(1, -30, 0, 50)
inputBox.ClearTextOnFocus = false
inputBox.Parent = mainFrame

-- Скругление для поля ввода
local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = inputBox

-- Выбор языка
local langLabel = Instance.new("TextLabel")
langLabel.BackgroundTransparency = 1
langLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
langLabel.Font = Enum.Font.SourceSans
langLabel.TextSize = 14
langLabel.Text = "🌐 Выберите язык перевода:"
langLabel.Position = UDim2.new(0, 15, 0, 135)
langLabel.Size = UDim2.new(1, -30, 0, 20)
langLabel.TextXAlignment = Enum.TextXAlignment.Left
langLabel.Parent = mainFrame

-- Выпадающий список языков
local dropdown = Instance.new("TextButton")
dropdown.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
dropdown.Font = Enum.Font.SourceSans
dropdown.TextSize = 16
dropdown.Text = "🇬🇧 English"
dropdown.Position = UDim2.new(0, 15, 0, 160)
dropdown.Size = UDim2.new(0, 200, 0, 35)
dropdown.Parent = mainFrame

local dropdownCorner = Instance.new("UICorner")
dropdownCorner.CornerRadius = UDim.new(0, 8)
dropdownCorner.Parent = dropdown

-- Список языков (всплывающий)
local langList = Instance.new("ScrollingFrame")
langList.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
langList.BorderSizePixel = 0
langList.Position = UDim2.new(0, 15, 0, 160)
langList.Size = UDim2.new(0, 200, 0, 120)
langList.Visible = false
langList.Parent = mainFrame

local langCorner = Instance.new("UICorner")
langCorner.CornerRadius = UDim.new(0, 8)
langCorner.Parent = langList

local languages = {
    {"🇬🇧 English", "en"},
    {"🇪🇸 Spanish", "es"},
    {"🇫🇷 French", "fr"},
    {"🇩🇪 German", "de"},
    {"🇮🇹 Italian", "it"},
    {"🇵🇹 Portuguese", "pt"},
    {"🇳🇱 Dutch", "nl"},
    {"🇷🇺 Russian", "ru"},
    {"🇯🇵 Japanese", "ja"},
    {"🇰🇷 Korean", "ko"},
    {"🇨🇳 Chinese", "zh"},
    {"🇸🇦 Arabic", "ar"},
}

local selectedLang = "en"
local langButtons = {}

for i, lang in ipairs(languages) do
    local btn = Instance.new("TextButton")
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 14
    btn.Text = lang[1]
    btn.Position = UDim2.new(0, 0, 0, (i-1) * 30)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Parent = langList
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        selectedLang = lang[2]
        dropdown.Text = lang[1]
        langList.Visible = false
    end)
    
    langButtons[i] = btn
end

-- Открытие/закрытие списка
dropdown.MouseButton1Click:Connect(function()
    langList.Visible = not langList.Visible
end)

-- Кнопка перевода
local translateBtn = Instance.new("TextButton")
translateBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
translateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
translateBtn.Font = Enum.Font.SourceSansBold
translateBtn.TextSize = 18
translateBtn.Text = "🔄 Перевести"
translateBtn.Position = UDim2.new(0, 230, 0, 160)
translateBtn.Size = UDim2.new(0, 120, 0, 35)
translateBtn.Parent = mainFrame

local translateCorner = Instance.new("UICorner")
translateCorner.CornerRadius = UDim.new(0, 8)
translateCorner.Parent = translateBtn

-- Поле для результата
local resultLabel = Instance.new("TextLabel")
resultLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
resultLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
resultLabel.Font = Enum.Font.SourceSans
resultLabel.TextSize = 16
resultLabel.Text = "Перевод появится здесь..."
resultLabel.Position = UDim2.new(0, 15, 0, 205)
resultLabel.Size = UDim2.new(1, -30, 0, 75)
resultLabel.TextWrapped = true
resultLabel.TextXAlignment = Enum.TextXAlignment.Left
resultLabel.TextYAlignment = Enum.TextYAlignment.Top
resultLabel.Parent = mainFrame

local resultCorner = Instance.new("UICorner")
resultCorner.CornerRadius = UDim.new(0, 8)
resultCorner.Parent = resultLabel

-- Функция перевода (через бесплатный API)
local function Translate(text, targetLang)
    if text == "" then
        resultLabel.Text = "⚠️ Введите текст для перевода"
        return
    end
    
    resultLabel.Text = "⏳ Перевод..."
    
    local success, response = pcall(function()
        local url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=ru&tl=" .. targetLang .. "&dt=t&q=" .. HttpService:UrlEncode(text)
        return game:HttpGet(url)
    end)
    
    if not success or not response then
        resultLabel.Text = "❌ Ошибка подключения к серверу"
        return
    end
    
    -- Парсим ответ от Google Translate
    local translated = ""
    local data = HttpService:JSONDecode(response)
    if data and data[1] then
        for _, part in pairs(data[1]) do
            if part and part[1] then
                translated = translated .. part[1]
            end
        end
    end
    
    if translated ~= "" then
        resultLabel.Text = "✅ " .. translated
    else
        resultLabel.Text = "❌ Не удалось перевести текст"
    end
end

-- Перевод по клику
translateBtn.MouseButton1Click:Connect(function()
    Translate(inputBox.Text, selectedLang)
end)

-- Перевод по Enter
inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        Translate(inputBox.Text, selectedLang)
    end
end)

-- Кнопка закрытия
local closeBtn = Instance.new("TextButton")
closeBtn.BackgroundTransparency = 1
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.SourceSans
closeBtn.TextSize = 20
closeBtn.Text = "✕"
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Parent = mainFrame

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Возможность перетаскивания
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and input.Position.Y < 50 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

print("✅ Переводчик загружен! Напиши текст на русском и нажми 'Перевести'.")
