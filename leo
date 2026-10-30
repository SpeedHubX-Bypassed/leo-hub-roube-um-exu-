
--// LEO HUB - DONATION LOADER
--// Initializer + Donation Popup

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local URL = "https://raw.githubusercontent.com/SpeedHubX-Bypassed/leo-hub-roube-um-exu/refs/heads/main/leo"

local function Notify(title, message)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = message,
            Duration = 4
        })
    end)
end

--// GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LEO_DonationPopup"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false

local parent = CoreGui

pcall(function()
    ScreenGui.Parent = parent
end)

if not ScreenGui.Parent then
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
end

local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Background.BackgroundTransparency = 0.45
Background.BorderSizePixel = 0
Background.Parent = ScreenGui

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Size = UDim2.new(0, 0, 0, 0)
Main.BackgroundColor3 = Color3.fromRGB(17, 17, 23)
Main.BorderSizePixel = 0
Main.Parent = Background

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(135, 65, 220)
Stroke.Thickness = 1.5
Stroke.Parent = Main

local function CreateText(name, text, size, position, color, font)
    local label = Instance.new("TextLabel")
    label.Name = name
    label.Size = size
    label.Position = position
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color
    label.TextSize = 14
    label.Font = font or Enum.Font.Gotham
    label.TextWrapped = true
    label.Parent = Main
    return label
end

--// Title
CreateText(
    "Title",
    "LEO HUB",
    UDim2.new(1, -30, 0, 35),
    UDim2.new(0, 15, 0, 17),
    Color3.fromRGB(180, 115, 255),
    Enum.Font.GothamBold
).TextSize = 23

--// Subtitle
CreateText(
    "Subtitle",
    "SUPORTE AO PROJETO",
    UDim2.new(1, -30, 0, 20),
    UDim2.new(0, 15, 0, 53),
    Color3.fromRGB(150, 150, 165),
    Enum.Font.GothamBold
).TextSize = 11

--// Message
local Message = CreateText(
    "Message",
    "Gostou do LEO HUB?\n\nQuem quiser contribuir para ajudar nas próximas atualizações e melhorias do script, pode enviar uma doação para o nick abaixo:\n\n@armazenatudo\n\nToda contribuição é bem-vinda! Obrigado pelo apoio.",
    UDim2.new(1, -40, 0, 135),
    UDim2.new(0, 20, 0, 85),
    Color3.fromRGB(220, 220, 230),
    Enum.Font.Gotham
)

Message.TextSize = 13

--// Nick
local Nick = Instance.new("TextButton")
Nick.Size = UDim2.new(1, -40, 0, 38)
Nick.Position = UDim2.new(0, 20, 0, 230)
Nick.BackgroundColor3 = Color3.fromRGB(35, 25, 50)
Nick.Text = "armazenatudo  |  COPIAR"
Nick.TextColor3 = Color3.fromRGB(190, 140, 255)
Nick.TextSize = 13
Nick.Font = Enum.Font.GothamBold
Nick.AutoButtonColor = false
Nick.Parent = Main

Instance.new("UICorner", Nick).CornerRadius = UDim.new(0, 7)

Nick.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("armazenatudo")
        Nick.Text = "NICK COPIADO!"
    else
        Nick.Text = "armazenatudo"
    end
end)

--// Continue button
local Continue = Instance.new("TextButton")
Continue.Size = UDim2.new(1, -40, 0, 40)
Continue.Position = UDim2.new(0, 20, 0, 280)
Continue.BackgroundColor3 = Color3.fromRGB(125, 65, 210)
Continue.Text = "CONTINUAR"
Continue.TextColor3 = Color3.fromRGB(255, 255, 255)
Continue.TextSize = 13
Continue.Font = Enum.Font.GothamBold
Continue.AutoButtonColor = false
Continue.Parent = Main

Instance.new("UICorner", Continue).CornerRadius = UDim.new(0, 7)

--// Animation
TweenService:Create(
    Main,
    TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    {Size = UDim2.new(0, 340, 0, 340)}
):Play()

--// Initialize
Continue.MouseButton1Click:Connect(function()

    TweenService:Create(
        Main,
        TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0)}
    ):Play()

    TweenService:Create(
        Background,
        TweenInfo.new(0.25),
        {BackgroundTransparency = 1}
    ):Play()

    task.wait(0.3)
    ScreenGui:Destroy()

    --// Load LEO HUB
    Notify("LEO HUB", "Inicializando script...")

    local success, source = pcall(function()
        return game:HttpGet(URL)
    end)

    if not success or type(source) ~= "string" or source == "" then
        Notify("LEO HUB", "Erro ao baixar o script.")
        warn("[LEO HUB] Download error:", source)
        return
    end

    local compiled, result = pcall(function()
        return loadstring(source)
    end)

    if not compiled or type(result) ~= "function" then
        Notify("LEO HUB", "Erro ao compilar o script.")
        warn("[LEO HUB] Compile error:", result)
        return
    end

    local executed, err = pcall(result)

    if not executed then
        Notify("LEO HUB", "Erro ao executar o script.")
        warn("[LEO HUB] Execution error:", err)
    end
end)
