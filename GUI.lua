-- DRONX – Sistema de Chave (Key System)
-- Compatível com Delta, Synapse X, KRNL, etc.

local function criarGUI()
    local guiParent = game:GetService("CoreGui") or game.Players.LocalPlayer.PlayerGui or game:GetService("StarterGui")
    if not guiParent then return warn("[DRONX] Sem pai") end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DRONX_GUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = guiParent

    -- ===== TELA DE CHAVE (KEY) =====
    local keyFrame = Instance.new("Frame")
    keyFrame.Size = UDim2.new(0, 350, 0, 200)
    keyFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
    keyFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    keyFrame.BorderSizePixel = 1
    keyFrame.BorderColor3 = Color3.fromRGB(60, 60, 70)
    keyFrame.Active = true
    keyFrame.Draggable = true
    keyFrame.Parent = screenGui

    local tituloKey = Instance.new("TextLabel")
    tituloKey.Size = UDim2.new(1, 0, 0, 40)
    tituloKey.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    tituloKey.Text = "DRONX - ATIVAÇÃO"
    tituloKey.TextColor3 = Color3.fromRGB(255, 215, 0)
    tituloKey.TextScaled = true
    tituloKey.Font = Enum.Font.GothamBold
    tituloKey.Parent = keyFrame

    local labelKey = Instance.new("TextLabel")
    labelKey.Size = UDim2.new(1, -40, 0, 25)
    labelKey.Position = UDim2.new(0, 20, 0, 50)
    labelKey.BackgroundTransparency = 1
    labelKey.Text = "Digite a chave de ativação:"
    labelKey.TextColor3 = Color3.fromRGB(200, 200, 210)
    labelKey.TextSize = 16
    labelKey.Font = Enum.Font.Gotham
    labelKey.Parent = keyFrame

    -- Campo de entrada (TextBox)
    local inputKey = Instance.new("TextBox")
    inputKey.Size = UDim2.new(0.8, 0, 0, 35)
    inputKey.Position = UDim2.new(0.1, 0, 0, 85)
    inputKey.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    inputKey.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputKey.TextSize = 18
    inputKey.Font = Enum.Font.Gotham
    inputKey.Text = ""
    inputKey.PlaceholderText = "Cole ou digite a chave aqui"
    inputKey.Parent = keyFrame

    -- Botão Verificar
    local btnVerificar = Instance.new("TextButton")
    btnVerificar.Size = UDim2.new(0.4, 0, 0, 35)
    btnVerificar.Position = UDim2.new(0.3, 0, 0, 135)
    btnVerificar.BackgroundColor3 = Color3.fromRGB(30, 120, 200)
    btnVerificar.Text = "Verificar"
    btnVerificar.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnVerificar.TextScaled = true
    btnVerificar.Font = Enum.Font.GothamBold
    btnVerificar.BorderSizePixel = 0
    btnVerificar.Parent = keyFrame

    -- Mensagem de erro/status
    local msgKey = Instance.new("TextLabel")
    msgKey.Size = UDim2.new(1, 0, 0, 25)
    msgKey.Position = UDim2.new(0, 0, 0, 175)
    msgKey.BackgroundTransparency = 1
    msgKey.Text = ""
    msgKey.TextColor3 = Color3.fromRGB(255, 100, 100)
    msgKey.TextSize = 14
    msgKey.Font = Enum.Font.Gotham
    msgKey.Parent = keyFrame

    -- ===== CHAVE VÁLIDA (ALTERE AQUI) =====
    local CHAVE_CORRETA = "DRONX2025" -- Mude para a chave que quiser

    -- ===== GUI PRINCIPAL (SÓ APARECE DEPOIS DA CHAVE) =====
    local guiPrincipal = Instance.new("Frame")
    guiPrincipal.Size = UDim2.new(0, 400, 0, 300)
    guiPrincipal.Position = UDim2.new(0.5, -200, 0.5, -150)
    guiPrincipal.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    guiPrincipal.BorderSizePixel = 1
    guiPrincipal.BorderColor3 = Color3.fromRGB(60, 60, 70)
    guiPrincipal.Active = true
    guiPrincipal.Draggable = true
    guiPrincipal.Visible = false -- começa invisível
    guiPrincipal.Parent = screenGui

    -- Título da GUI principal
    local tituloMain = Instance.new("TextLabel")
    tituloMain.Size = UDim2.new(1, 0, 0, 35)
    tituloMain.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    tituloMain.Text = "DRONX"
    tituloMain.TextColor3 = Color3.fromRGB(255, 215, 0)
    tituloMain.TextScaled = true
    tituloMain.Font = Enum.Font.GothamBold
    tituloMain.Parent = guiPrincipal

    -- Botão Fechar (da GUI principal)
    local fecharMain = Instance.new("TextButton")
    fecharMain.Size = UDim2.new(0, 30, 0, 30)
    fecharMain.Position = UDim2.new(1, -35, 0, 3)
    fecharMain.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    fecharMain.Text = "X"
    fecharMain.TextColor3 = Color3.fromRGB(255, 255, 255)
    fecharMain.TextScaled = true
    fecharMain.Font = Enum.Font.GothamBold
    fecharMain.Parent = guiPrincipal
    fecharMain.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        print("[DRONX] GUI fechada.")
    end)

    -- Área para futuras funções (dentro da GUI principal)
    local areaFunc = Instance.new("Frame")
    areaFunc.Size = UDim2.new(1, -20, 1, -50)
    areaFunc.Position = UDim2.new(0, 10, 0, 45)
    areaFunc.BackgroundTransparency = 1
    areaFunc.Parent = guiPrincipal

    -- Texto de boas-vindas (depois da chave)
    local welcome = Instance.new("TextLabel")
    welcome.Size = UDim2.new(1, 0, 0, 30)
    welcome.Position = UDim2.new(0, 0, 0.4, 0)
    welcome.BackgroundTransparency = 1
    welcome.Text = "Chave validada! Funções disponíveis em breve."
    welcome.TextColor3 = Color3.fromRGB(100, 200, 255)
    welcome.TextSize = 18
    welcome.Font = Enum.Font.Gotham
    welcome.Parent = areaFunc

    -- ===== FUNÇÃO DE VALIDAÇÃO =====
    btnVerificar.MouseButton1Click:Connect(function()
        local chaveDigitada = inputKey.Text
        if chaveDigitada == CHAVE_CORRETA then
            -- Chave correta: esconde tela de key e mostra GUI principal
            keyFrame.Visible = false
            guiPrincipal.Visible = true
            msgKey.Text = ""
            print("[DRONX] Chave validada com sucesso!")
        else
            -- Chave incorreta
            msgKey.Text = "Chave inválida. Tente novamente."
            msgKey.TextColor3 = Color3.fromRGB(255, 100, 100)
            -- Opcional: limpa o campo
            inputKey.Text = ""
        end
    end)

    -- Também valida ao pressionar Enter no campo de texto
    inputKey.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            btnVerificar.MouseButton1Click:Fire()
        end
    end)

    print("[DRONX] Sistema de chave carregado. Aguardando ativação.")
end

pcall(criarGUI)
