-- ============================================================
-- GUI.lua – DRONX (LAYOUT CORRIGIDO, SEM UIListLayout)
-- ============================================================

print("[DRONX] Iniciando GUI (layout fixo)...")

local function criarGUI()
    local player = game.Players.LocalPlayer
    if not player then return warn("[DRONX] Sem player") end

    local guiParent = game:GetService("CoreGui") or player:WaitForChild("PlayerGui")
    if not guiParent then return warn("[DRONX] Sem pai") end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DRONX_GUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = guiParent

    -- ====== JANELA PRINCIPAL ======
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 480, 0, 520)
    mainFrame.Position = UDim2.new(0.5, -240, 0.5, -260)
    mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    mainFrame.BorderSizePixel = 1
    mainFrame.BorderColor3 = Color3.fromRGB(60, 60, 70)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    -- ====== TÍTULO E BOTÕES ======
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 35)
    titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    titleBar.Parent = mainFrame

    local titulo = Instance.new("TextLabel")
    titulo.Size = UDim2.new(0.7, 0, 1, 0)
    titulo.Position = UDim2.new(0, 10, 0, 0)
    titulo.BackgroundTransparency = 1
    titulo.Text = "DRONX"
    titulo.TextColor3 = Color3.fromRGB(255, 215, 0)
    titulo.TextScaled = true
    titulo.Font = Enum.Font.GothamBold
    titulo.TextXAlignment = Enum.TextXAlignment.Left
    titulo.Parent = titleBar

    -- Botão Minimizar
    local btnMinimizar = Instance.new("TextButton")
    btnMinimizar.Size = UDim2.new(0, 25, 0, 25)
    btnMinimizar.Position = UDim2.new(1, -65, 0, 5)
    btnMinimizar.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    btnMinimizar.Text = "—"
    btnMinimizar.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnMinimizar.TextScaled = true
    btnMinimizar.Font = Enum.Font.GothamBold
    btnMinimizar.BorderSizePixel = 0
    btnMinimizar.Parent = titleBar

    local minimizado = false
    btnMinimizar.MouseButton1Click:Connect(function()
        minimizado = not minimizado
        if minimizado then
            mainFrame.Size = UDim2.new(0, 480, 0, 35)
            btnMinimizar.Text = "+"
            btnMinimizar.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
        else
            mainFrame.Size = UDim2.new(0, 480, 0, 520)
            btnMinimizar.Text = "—"
            btnMinimizar.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        end
    end)

    -- Botão Fechar
    local btnFechar = Instance.new("TextButton")
    btnFechar.Size = UDim2.new(0, 25, 0, 25)
    btnFechar.Position = UDim2.new(1, -35, 0, 5)
    btnFechar.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    btnFechar.Text = "X"
    btnFechar.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnFechar.TextScaled = true
    btnFechar.Font = Enum.Font.GothamBold
    btnFechar.BorderSizePixel = 0
    btnFechar.Parent = titleBar
    btnFechar.MouseButton1Click:Connect(function() screenGui:Destroy() end)

    -- ====== NOTIFICAÇÕES ======
    local notificacao = Instance.new("Frame")
    notificacao.Size = UDim2.new(0, 300, 0, 40)
    notificacao.Position = UDim2.new(0.5, -150, 0, -50)
    notificacao.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    notificacao.BorderSizePixel = 1
    notificacao.BorderColor3 = Color3.fromRGB(255, 215, 0)
    notificacao.Visible = false
    notificacao.Parent = screenGui

    local notifTexto = Instance.new("TextLabel")
    notifTexto.Size = UDim2.new(1, -10, 1, 0)
    notifTexto.Position = UDim2.new(0, 5, 0, 0)
    notifTexto.BackgroundTransparency = 1
    notifTexto.Text = ""
    notifTexto.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifTexto.TextScaled = true
    notifTexto.Font = Enum.Font.Gotham
    notifTexto.Parent = notificacao

    local function mostrarNotificacao(texto, cor)
        cor = cor or Color3.fromRGB(255, 215, 0)
        notificacao.BorderColor3 = cor
        notifTexto.Text = texto
        notificacao.Position = UDim2.new(0.5, -150, 0, -50)
        notificacao.Visible = true
        local tween = game:GetService("TweenService"):Create(notificacao, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -150, 0, 20)})
        tween:Play()
        tween.Completed:Wait()
        task.wait(3)
        local tween2 = game:GetService("TweenService"):Create(notificacao, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -150, 0, -50)})
        tween2:Play()
        tween2.Completed:Wait()
        notificacao.Visible = false
    end

    -- ====== CONTAINER (sem rolagem, layout fixo) ======
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -10, 1, -45)
    container.Position = UDim2.new(0, 5, 0, 40)
    container.BackgroundTransparency = 1
    container.Parent = mainFrame

    -- Função para criar checkbox (sem UIListLayout)
    local function createCheckbox(parent, y, text, varName)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 30)
        frame.Position = UDim2.new(0, 0, 0, y)
        frame.BackgroundTransparency = 1
        frame.Parent = parent

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.Position = UDim2.new(0, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(220, 220, 230)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextScaled = true
        label.Font = Enum.Font.Gotham
        label.Parent = frame

        local check = Instance.new("TextButton")
        check.Size = UDim2.new(0, 25, 0, 25)
        check.Position = UDim2.new(0.85, 0, 0, 2)
        check.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        check.Text = ""
        check.TextColor3 = Color3.fromRGB(255, 255, 255)
        check.TextScaled = true
        check.Font = Enum.Font.GothamBold
        check.BorderSizePixel = 1
        check.BorderColor3 = Color3.fromRGB(255, 255, 255)
        check.Parent = frame

        local state = getgenv().DRONX and getgenv().DRONX[varName] or false
        if state then
            check.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            check.Text = "✓"
        end

        check.MouseButton1Click:Connect(function()
            state = not state
            if not getgenv().DRONX then getgenv().DRONX = {} end
            getgenv().DRONX[varName] = state
            check.BackgroundColor3 = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(100, 100, 100)
            check.Text = state and "✓" or ""
            mostrarNotificacao(text .. (state and " ativado!" or " desativado!"), state and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0))
        end)
        return frame
    end

    -- ====== LAYOUT FIXO ======
    local y = 0

    -- Título Farm
    local farmTitle = Instance.new("TextLabel")
    farmTitle.Size = UDim2.new(1, 0, 0, 25)
    farmTitle.Position = UDim2.new(0, 0, 0, y)
    farmTitle.BackgroundTransparency = 1
    farmTitle.Text = "⚔️ FARM"
    farmTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
    farmTitle.TextSize = 18
    farmTitle.Font = Enum.Font.GothamBold
    farmTitle.TextXAlignment = Enum.TextXAlignment.Left
    farmTitle.Parent = container
    y = y + 30

    createCheckbox(container, y, "Auto Farm", "AutoFarm")
    y = y + 35
    createCheckbox(container, y, "Farm Maestria", "FarmMaestria")
    y = y + 35
    createCheckbox(container, y, "Auto Coletar Itens", "AutoCollect")
    y = y + 35
    createCheckbox(container, y, "Cura Automática", "AutoHeal")
    y = y + 45

    -- Seção Boss
    local bossTitle = Instance.new("TextLabel")
    bossTitle.Size = UDim2.new(1, 0, 0, 25)
    bossTitle.Position = UDim2.new(0, 0, 0, y)
    bossTitle.BackgroundTransparency = 1
    bossTitle.Text = "👹 BOSS"
    bossTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
    bossTitle.TextSize = 18
    bossTitle.Font = Enum.Font.GothamBold
    bossTitle.TextXAlignment = Enum.TextXAlignment.Left
    bossTitle.Parent = container
    y = y + 30

    local bossDropdown = Instance.new("TextBox")
    bossDropdown.Size = UDim2.new(0.9, 0, 0, 30)
    bossDropdown.Position = UDim2.new(0.05, 0, 0, y)
    bossDropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    bossDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
    bossDropdown.TextSize = 16
    bossDropdown.Font = Enum.Font.Gotham
    bossDropdown.PlaceholderText = "Nome do Boss"
    bossDropdown.Parent = container
    y = y + 40

    local btnBoss = Instance.new("TextButton")
    btnBoss.Size = UDim2.new(0.6, 0, 0, 30)
    btnBoss.Position = UDim2.new(0.2, 0, 0, y)
    btnBoss.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    btnBoss.Text = "CAÇAR BOSS"
    btnBoss.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnBoss.TextScaled = true
    btnBoss.Font = Enum.Font.GothamBold
    btnBoss.Parent = container
    y = y + 40

    btnBoss.MouseButton1Click:Connect(function()
        local nome = bossDropdown.Text
        if nome == "" then
            mostrarNotificacao("Digite o nome do boss!", Color3.fromRGB(255, 200, 0))
            return
        end
        if not getgenv().DRONX then getgenv().DRONX = {} end
        getgenv().DRONX.BossName = nome
        getgenv().DRONX.BossFarm = true
        mostrarNotificacao("Caçando: " .. nome, Color3.fromRGB(0, 200, 0))
    end)

    -- Seção Status
    local statsTitle = Instance.new("TextLabel")
    statsTitle.Size = UDim2.new(1, 0, 0, 25)
    statsTitle.Position = UDim2.new(0, 0, 0, y)
    statsTitle.BackgroundTransparency = 1
    statsTitle.Text = "📊 STATUS"
    statsTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
    statsTitle.TextSize = 18
    statsTitle.Font = Enum.Font.GothamBold
    statsTitle.TextXAlignment = Enum.TextXAlignment.Left
    statsTitle.Parent = container
    y = y + 30

    local statsLabel = Instance.new("TextLabel")
    statsLabel.Size = UDim2.new(1, 0, 0, 25)
    statsLabel.Position = UDim2.new(0, 0, 0, y)
    statsLabel.BackgroundTransparency = 1
    statsLabel.Text = "💰 $1,323,522  |  📊 Lv. 2631"
    statsLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
    statsLabel.TextSize = 16
    statsLabel.Font = Enum.Font.Gotham
    statsLabel.TextXAlignment = Enum.TextXAlignment.Left
    statsLabel.Parent = container
    y = y + 30

    -- Botão Iniciar/Parar
    local btnMain = Instance.new("TextButton")
    btnMain.Size = UDim2.new(0.6, 0, 0, 40)
    btnMain.Position = UDim2.new(0.2, 0, 0, y + 10)
    btnMain.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    btnMain.Text = "▶ INICIAR"
    btnMain.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnMain.TextScaled = true
    btnMain.Font = Enum.Font.GothamBold
    btnMain.Parent = container

    btnMain.MouseButton1Click:Connect(function()
        if not getgenv().DRONX then getgenv().DRONX = {} end
        local running = not getgenv().DRONX.Running
        getgenv().DRONX.Running = running
        btnMain.Text = running and "⏹ PARAR" or "▶ INICIAR"
        btnMain.BackgroundColor3 = running and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(0, 150, 0)
        mostrarNotificacao(running and "Sistemas iniciados!" or "Sistemas parados.", running and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0))
    end)

    -- Ajuste do container (altura fixa)
    container.Size = UDim2.new(1, -10, 0, y + 60)

    print("[DRONX] GUI carregada com layout fixo!")
end

pcall(criarGUI)
