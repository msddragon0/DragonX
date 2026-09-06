-- DRAGONX GUI – APENAS VISUAL (SEM FUNÇÕES DE JOGO E SEM OPÇÕES)
-- Baseado na imagem fornecida. Pronto para receber checkboxes e botões depois.

local function criarGUI()
    local guiParent = game:GetService("CoreGui") or game.Players.LocalPlayer.PlayerGui or game:GetService("StarterGui")
    if not guiParent then return warn("[DRAGONX] Nenhum pai disponível") end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DragonX_GUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = guiParent

    -- Frame principal
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 420, 0, 600)
    main.Position = UDim2.new(0.5, -210, 0.5, -300)
    main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    main.BorderSizePixel = 1
    main.BorderColor3 = Color3.fromRGB(60, 60, 70)
    main.Active = true
    main.Draggable = true
    main.Parent = screenGui

    -- Título
    local titulo = Instance.new("TextLabel")
    titulo.Size = UDim2.new(1, 0, 0, 50)
    titulo.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    titulo.Text = "DRAGONX"
    titulo.TextColor3 = Color3.fromRGB(255, 215, 0)
    titulo.TextScaled = true
    titulo.Font = Enum.Font.GothamBold
    titulo.Parent = main

    -- Botão fechar (X)
    local fechar = Instance.new("TextButton")
    fechar.Size = UDim2.new(0, 30, 0, 30)
    fechar.Position = UDim2.new(1, -35, 0, 10)
    fechar.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    fechar.Text = "X"
    fechar.TextColor3 = Color3.fromRGB(255, 255, 255)
    fechar.TextScaled = true
    fechar.Font = Enum.Font.GothamBold
    fechar.Parent = main
    fechar.MouseButton1Click:Connect(function() screenGui:Destroy() end)

    -- Container para todos os elementos
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -20, 1, -60)
    container.Position = UDim2.new(0, 10, 0, 55)
    container.BackgroundTransparency = 1
    container.Parent = main

    -- Função auxiliar para textos
    local function txt(parent, texto, y, cor, tam, align)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, 0, 0, 25)
        lbl.Position = UDim2.new(0, 0, 0, y)
        lbl.BackgroundTransparency = 1
        lbl.Text = texto
        lbl.TextColor3 = cor or Color3.fromRGB(255,255,255)
        lbl.TextSize = tam or 18
        lbl.Font = Enum.Font.Gotham
        lbl.TextXAlignment = align or Enum.TextXAlignment.Left
        lbl.Parent = parent
        return lbl
    end

    -- Função auxiliar para barras
    local function barra(parent, y, label, maxVal, curVal, cor1)
        local f = Instance.new("Frame")
        f.Size = UDim2.new(1, 0, 0, 22)
        f.Position = UDim2.new(0, 0, 0, y)
        f.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        f.BorderSizePixel = 1
        f.BorderColor3 = Color3.fromRGB(40, 40, 45)
        f.ClipsDescendants = true
        f.Parent = parent

        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(0.25, 0, 1, 0)
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
        fill.BackgroundColor3 = cor1
        fill.BorderSizePixel = 0
        fill.Parent = f

        local v = Instance.new("TextLabel")
        v.Size = UDim2.new(0.65, 0, 1, 0)
        v.Position = UDim2.new(0.35, 0, 0, 0)
        v.BackgroundTransparency = 1
        v.Text = curVal .. " / " .. maxVal
        v.TextColor3 = Color3.fromRGB(255,255,255)
        v.TextSize = 16
        v.Font = Enum.Font.Gotham
        v.TextXAlignment = Enum.TextXAlignment.Right
        v.Parent = f
    end

    -- ===== ELEMENTOS VISUAIS =====
    local y = 0

    -- Linha 1: Objetivo (Derrote 8 campeões da... Campão da ilha 0/8)
    txt(container, "Derrote 8 campeões da", y, Color3.fromRGB(220,220,230), 18)
    y = y + 22
    txt(container, "Campão da ilha  0/8", y, Color3.fromRGB(200,200,210), 18)
    y = y + 30

    -- Linha: $15,300 | Status
    local line1 = Instance.new("Frame")
    line1.Size = UDim2.new(1, 0, 0, 25)
    line1.Position = UDim2.new(0, 0, 0, y)
    line1.BackgroundTransparency = 1
    line1.Parent = container
    y = y + 28

    local coin = Instance.new("TextLabel")
    coin.Size = UDim2.new(0.4, 0, 1, 0)
    coin.BackgroundTransparency = 1
    coin.Text = "$15,300"
    coin.TextColor3 = Color3.fromRGB(255,215,0)
    coin.TextSize = 18
    coin.Font = Enum.Font.GothamBold
    coin.TextXAlignment = Enum.TextXAlignment.Left
    coin.Parent = line1

    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(0.4, 0, 1, 0)
    status.Position = UDim2.new(0.6, 0, 0, 0)
    status.BackgroundTransparency = 1
    status.Text = "Status"
    status.TextColor3 = Color3.fromRGB(100,200,255)
    status.TextSize = 18
    status.Font = Enum.Font.GothamBold
    status.TextXAlignment = Enum.TextXAlignment.Right
    status.Parent = line1

    -- Linha: 139,000,000 EXP | Itens
    local line2 = Instance.new("Frame")
    line2.Size = UDim2.new(1, 0, 0, 25)
    line2.Position = UDim2.new(0, 0, 0, y)
    line2.BackgroundTransparency = 1
    line2.Parent = container
    y = y + 28

    local exp = Instance.new("TextLabel")
    exp.Size = UDim2.new(0.6, 0, 1, 0)
    exp.BackgroundTransparency = 1
    exp.Text = "139,000,000 EXP"
    exp.TextColor3 = Color3.fromRGB(255,255,200)
    exp.TextSize = 18
    exp.Font = Enum.Font.Gotham
    exp.TextXAlignment = Enum.TextXAlignment.Left
    exp.Parent = line2

    local itens = Instance.new("TextLabel")
    itens.Size = UDim2.new(0.3, 0, 1, 0)
    itens.Position = UDim2.new(0.7, 0, 0, 0)
    itens.BackgroundTransparency = 1
    itens.Text = "Itens"
    itens.TextColor3 = Color3.fromRGB(200,200,255)
    itens.TextSize = 18
    itens.Font = Enum.Font.GothamBold
    itens.TextXAlignment = Enum.TextXAlignment.Right
    itens.Parent = line2

    -- Botão "Fechar" (interno) e "Loja"
    local btnFrame = Instance.new("Frame")
    btnFrame.Size = UDim2.new(1, 0, 0, 40)
    btnFrame.Position = UDim2.new(0, 0, 0, y)
    btnFrame.BackgroundTransparency = 1
    btnFrame.Parent = container
    y = y + 44

    local btnFechar = Instance.new("TextButton")
    btnFechar.Size = UDim2.new(0.4, -10, 1, 0)
    btnFechar.Position = UDim2.new(0, 0, 0, 0)
    btnFechar.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
    btnFechar.Text = "Fechar"
    btnFechar.TextColor3 = Color3.fromRGB(255,255,255)
    btnFechar.TextScaled = true
    btnFechar.Font = Enum.Font.GothamBold
    btnFechar.BorderSizePixel = 0
    btnFechar.Parent = btnFrame
    btnFechar.MouseButton1Click:Connect(function() screenGui:Destroy() end)

    local btnLoja = Instance.new("TextButton")
    btnLoja.Size = UDim2.new(0.4, -10, 1, 0)
    btnLoja.Position = UDim2.new(0.6, 10, 0, 0)
    btnLoja.BackgroundColor3 = Color3.fromRGB(30, 120, 200)
    btnLoja.Text = "Loja"
    btnLoja.TextColor3 = Color3.fromRGB(255,255,255)
    btnLoja.TextScaled = true
    btnLoja.Font = Enum.Font.GothamBold
    btnLoja.BorderSizePixel = 0
    btnLoja.Parent = btnFrame

    -- Separador (linha horizontal)
    local sep = Instance.new("Frame")
    sep.Size = UDim2.new(0.9, 0, 0, 2)
    sep.Position = UDim2.new(0.05, 0, 0, y)
    sep.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    sep.BorderSizePixel = 0
    sep.Parent = container
    y = y + 10

    -- Estatísticas (Menu)
    txt(container, "$1,319,352", y, Color3.fromRGB(255,215,0), 22)
    y = y + 28
    txt(container, "Lv. 2631", y, Color3.fromRGB(200,200,255), 18)
    y = y + 28

    -- Vida e Energia (barras)
    barra(container, y, "Vida", 11770, 11770, Color3.fromRGB(200,40,40))
    y = y + 26
    barra(container, y, "Energia", 14095, 14095, Color3.fromRGB(40,150,255))
    y = y + 30

    -- Separador antes do Núcleo
    local sep2 = Instance.new("Frame")
    sep2.Size = UDim2.new(0.9, 0, 0, 2)
    sep2.Position = UDim2.new(0.05, 0, 0, y)
    sep2.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    sep2.BorderSizePixel = 0
    sep2.Parent = container
    y = y + 10

    -- Núcleo de Energia (título)
    txt(container, "Núcleo de Energia", y, Color3.fromRGB(180,220,255), 20)
    y = y + 28

    -- Informações do Núcleo (textos fixos)
    local infoNucleo = {
        "Maestria 600 (MAX)",
        "1,892,346 / 1,892,346 (2x)",
        "SUPERHUMANO",
        "Ataque da Besta Coruja [Z]",
        "Maes. 110",
        "Estrondo [X]",
        "Tiro do Conquistador [C]"
    }
    for _, texto in ipairs(infoNucleo) do
        txt(container, texto, y, Color3.fromRGB(200,200,210), 16)
        y = y + 22
    end

    -- Ajuste final do container
    container.Size = UDim2.new(1, -20, 0, y + 10)
    print("[DRAGONX] GUI visual carregada. Aguardando comandos para opções.")
end

pcall(criarGUI)
