-- DRAGONX – SOMENTE GUI (SEM LÓGICA)
local gui = Instance.new("ScreenGui")
gui.Name = "DragonX_GUI"
gui.Parent = game:GetService("CoreGui") or game.Players.LocalPlayer.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 420, 0, 580)
frame.Position = UDim2.new(0.5, -210, 0.5, -290)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
frame.BorderSizePixel = 1
frame.BorderColor3 = Color3.fromRGB(60, 60, 70)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local titulo = Instance.new("TextLabel")
titulo.Size = UDim2.new(1, 0, 0, 50)
titulo.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
titulo.Text = "DRAGONX"
titulo.TextColor3 = Color3.fromRGB(255, 215, 0)
titulo.TextScaled = true
titulo.Font = Enum.Font.GothamBold
titulo.Parent = frame

local fechar = Instance.new("TextButton")
fechar.Size = UDim2.new(0, 30, 0, 30)
fechar.Position = UDim2.new(1, -35, 0, 10)
fechar.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
fechar.Text = "X"
fechar.TextColor3 = Color3.fromRGB(255, 255, 255)
fechar.TextScaled = true
fechar.Font = Enum.Font.GothamBold
fechar.Parent = frame
fechar.MouseButton1Click:Connect(function() gui:Destroy() end)

local container = Instance.new("Frame")
container.Size = UDim2.new(1, -20, 1, -60)
container.Position = UDim2.new(0, 10, 0, 55)
container.BackgroundTransparency = 1
container.Parent = frame

-- Textos fixos
local textos = {
    {texto = "Derrote 8 campeões da ilha", y = 0, cor = Color3.fromRGB(220,220,230)},
    {texto = "Campão da ilha  0/8", y = 28, cor = Color3.fromRGB(200,200,210)},
    {texto = "$15,300  |  Status", y = 60, cor = Color3.fromRGB(255,215,0)},
    {texto = "139,000,000 EXP  |  Itens", y = 90, cor = Color3.fromRGB(255,255,200)},
    {texto = "$1,319,352", y = 230, cor = Color3.fromRGB(255,215,0)},
    {texto = "Lv. 2631  |  68,186,597 / 146,996,907", y = 258, cor = Color3.fromRGB(200,200,255)},
}

for _, info in ipairs(textos) do
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 25)
    lbl.Position = UDim2.new(0, 0, 0, info.y)
    lbl.BackgroundTransparency = 1
    lbl.Text = info.texto
    lbl.TextColor3 = info.cor
    lbl.TextSize = 18
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = container
end

-- Botões Fechar (interno) e Loja
local btnFrame = Instance.new("Frame")
btnFrame.Size = UDim2.new(1, 0, 0, 40)
btnFrame.Position = UDim2.new(0, 0, 0, 125)
btnFrame.BackgroundTransparency = 1
btnFrame.Parent = container

local btnFechar = Instance.new("TextButton")
btnFechar.Size = UDim2.new(0.4, -10, 1, 0)
btnFechar.Position = UDim2.new(0, 0, 0, 0)
btnFechar.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
btnFechar.Text = "Fechar"
btnFechar.TextColor3 = Color3.fromRGB(255, 255, 255)
btnFechar.TextScaled = true
btnFechar.Font = Enum.Font.GothamBold
btnFechar.BorderSizePixel = 0
btnFechar.Parent = btnFrame
btnFechar.MouseButton1Click:Connect(function() gui:Destroy() end)

local btnLoja = Instance.new("TextButton")
btnLoja.Size = UDim2.new(0.4, -10, 1, 0)
btnLoja.Position = UDim2.new(0.6, 10, 0, 0)
btnLoja.BackgroundColor3 = Color3.fromRGB(30, 120, 200)
btnLoja.Text = "Loja"
btnLoja.TextColor3 = Color3.fromRGB(255, 255, 255)
btnLoja.TextScaled = true
btnLoja.Font = Enum.Font.GothamBold
btnLoja.BorderSizePixel = 0
btnLoja.Parent = btnFrame

-- Separador
local sep = Instance.new("Frame")
sep.Size = UDim2.new(0.9, 0, 0, 2)
sep.Position = UDim2.new(0.05, 0, 0, 170)
sep.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
sep.BorderSizePixel = 0
sep.Parent = container

-- Barras (Vida e Energy)
local function barra(y, label, maxVal, curVal, cor)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 22)
    f.Position = UDim2.new(0, 0, 0, y)
    f.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    f.BorderSizePixel = 1
    f.BorderColor3 = Color3.fromRGB(40, 40, 45)
    f.ClipsDescendants = true
    f.Parent = container

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0.3, 0, 1, 0)
    l.Position = UDim2.new(0, 4, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = label
    l.TextColor3 = Color3.fromRGB(220,220,230)
    l.TextSize = 16
    l.Font = Enum.Font.Gotham
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(curVal/maxVal, 0, 1, 0)
    fill.BackgroundColor3 = cor
    fill.BorderSizePixel = 0
    fill.Parent = f

    local v = Instance.new("TextLabel")
    v.Size = UDim2.new(0.6, 0, 1, 0)
    v.Position = UDim2.new(0.4, 0, 0, 0)
    v.BackgroundTransparency = 1
    v.Text = curVal .. " / " .. maxVal
    v.TextColor3 = Color3.fromRGB(255,255,255)
    v.TextSize = 16
    v.Font = Enum.Font.Gotham
    v.TextXAlignment = Enum.TextXAlignment.Right
    v.Parent = f
end

barra(290, "Vida", 11770, 11770, Color3.fromRGB(200,40,40))
barra(316, "Energy", 14095, 14095, Color3.fromRGB(40,150,255))

-- Núcleo de Energia
local core = Instance.new("Frame")
core.Size = UDim2.new(0.6, 0, 0, 25)
core.Position = UDim2.new(0.2, 0, 0, 344)
core.BackgroundColor3 = Color3.fromRGB(40,40,50)
core.BorderSizePixel = 1
core.BorderColor3 = Color3.fromRGB(80,80,100)
core.Parent = container

local coreLbl = Instance.new("TextLabel")
coreLbl.Size = UDim2.new(1, 0, 1, 0)
coreLbl.BackgroundTransparency = 1
coreLbl.Text = "Núcleo de Energia"
coreLbl.TextColor3 = Color3.fromRGB(180,220,255)
coreLbl.TextScaled = true
coreLbl.Font = Enum.Font.GothamBold
coreLbl.Parent = core

print("[DRAGONX] GUI carregada – sem lógica de farm.")
