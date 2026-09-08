-- DRONX GUI – SEM CHAVE, SEM COMPLICAÇÕES
-- Apenas a janela com fechar e área de funções vazia.

local function criarGUI()
    local guiParent = game:GetService("CoreGui") or game.Players.LocalPlayer.PlayerGui or game:GetService("StarterGui")
    if not guiParent then return warn("[DRONX] Sem pai") end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DRONX_GUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = guiParent

    -- Janela principal
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 400, 0, 300)
    main.Position = UDim2.new(0.5, -200, 0.5, -150)
    main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    main.BorderSizePixel = 1
    main.BorderColor3 = Color3.fromRGB(60, 60, 70)
    main.Active = true
    main.Draggable = true
    main.Parent = screenGui

    -- Título
    local titulo = Instance.new("TextLabel")
    titulo.Size = UDim2.new(1, 0, 0, 35)
    titulo.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    titulo.Text = "DRONX"
    titulo.TextColor3 = Color3.fromRGB(255, 215, 0)
    titulo.TextScaled = true
    titulo.Font = Enum.Font.GothamBold
    titulo.Parent = main

    -- Botão fechar
    local fechar = Instance.new("TextButton")
    fechar.Size = UDim2.new(0, 30, 0, 30)
    fechar.Position = UDim2.new(1, -35, 0, 3)
    fechar.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    fechar.Text = "X"
    fechar.TextColor3 = Color3.fromRGB(255, 255, 255)
    fechar.TextScaled = true
    fechar.Font = Enum.Font.GothamBold
    fechar.Parent = main
    fechar.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        print("[DRONX] GUI fechada.")
    end)

    -- Área de funções (vazia por enquanto)
    local areaFunc = Instance.new("Frame")
    areaFunc.Size = UDim2.new(1, -20, 1, -50)
    areaFunc.Position = UDim2.new(0, 10, 0, 45)
    areaFunc.BackgroundTransparency = 1
    areaFunc.Parent = main

    -- Texto de boas-vindas
    local welcome = Instance.new("TextLabel")
    welcome.Size = UDim2.new(1, 0, 0, 30)
    welcome.Position = UDim2.new(0, 0, 0.4, 0)
    welcome.BackgroundTransparency = 1
    welcome.Text = "Bem-vindo! Funções em breve."
    welcome.TextColor3 = Color3.fromRGB(100, 200, 255)
    welcome.TextSize = 18
    welcome.Font = Enum.Font.Gotham
    welcome.Parent = areaFunc

    print("[DRONX] GUI carregada – sem chave, sem complicação.")
end

pcall(criarGUI)
