-- ============================================================
-- GUI.lua – DRONX COMPLETO (COM LOGS E CORREÇÕES)
-- ============================================================

print("[DRONX] Iniciando criação da GUI completa...")

local function criarGUI()
    print("[DRONX] Passo 1: Obtendo jogador...")
    local player = game.Players.LocalPlayer
    if not player then
        warn("[DRONX] Sem player!")
        return
    end

    print("[DRONX] Passo 2: Obtendo pai da GUI...")
    local guiParent = game:GetService("CoreGui")
    if not guiParent then
        guiParent = player:WaitForChild("PlayerGui")
    end
    if not guiParent then
        warn("[DRONX] Sem pai para GUI!")
        return
    end
    print("[DRONX] Pai da GUI:", guiParent.Name)

    print("[DRONX] Passo 3: Criando ScreenGui...")
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DRONX_GUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = guiParent

    -- ====== JANELA PRINCIPAL ======
    print("[DRONX] Passo 4: Criando Frame principal...")
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 480, 0, 500)
    mainFrame.Position = UDim2.new(0.5, -240, 0.5, -250)
    mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    mainFrame.BorderSizePixel = 1
    mainFrame.BorderColor3 = Color3.fromRGB(60, 60, 70)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Visible = true
    mainFrame.Parent = screenGui
    print("[DRONX] Frame principal criado e visível.")

    -- ====== TÍTULO E BOTÕES ======
    print("[DRONX] Passo 5: Criando barra de título...")
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

    -- Botão Minimizar (bolinha verde)
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

    -- Botão Fechar (vermelho)
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
    btnFechar.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        print("[DRONX] GUI fechada.")
    end)

    -- Variável de estado do minimizar
    local minimizado = false
    btnMinimizar.MouseButton1Click:Connect(function()
        minimizado = not minimizado
        if minimizado then
            mainFrame.Size = UDim2.new(0, 480, 0, 35)
            btnMinimizar.Text = "+"
            btnMinimizar.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
        else
            mainFrame.Size = UDim2.new(0, 480, 0, 500)
            btnMinimizar.Text = "—"
            btnMinimizar.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        end
    end)

    -- ====== NOTIFICAÇÕES ======
    print("[DRONX] Passo 6: Criando sistema de notificações...")
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
        local tween = game:GetService("TweenService"):Create(notificacao, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, -150, 0, 20)})
        tween:Play()
        tween.Completed:Wait()
        task.wait(3)
        local tween2 = game:GetService("TweenService"):Create(notificacao, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, -150, 0, -50)})
        tween2:Play()
        tween2.Completed:Wait()
        notificacao.Visible = false
    end

    -- ====== CONTAINER COM ROLAGEM ======
    print("[DRONX] Passo 7: Criando ScrollingFrame...")
    local container = Instance.new("ScrollingFrame")
    container.Size = UDim2.new(1, -10, 1, -45)
    container.Position = UDim2.new(0, 5, 0, 40)
    container.BackgroundTransparency = 1
    container.ScrollBarThickness = 5
    container.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90)
    container.Parent = mainFrame
    container.CanvasSize = UDim2.new(0, 0, 0, 600) -- altura fixa para rolagem

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = container

    -- ====== FUNÇÃO PARA CRIAR CHECKBOX ======
    local function createCheckbox(parent, text, varName)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 30)
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

        local state = false
        if getgenv().DRONX and getgenv().DRONX[varName] then
            state = getgenv().DRONX[varName]
        end
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
            if state then
                mostrarNotificacao(text .. " ativado!", Color3.fromRGB(0, 200, 0))
            else
                mostrarNotificacao(text .. " desativado!", Color3.fromRGB(200, 0, 0))
            end
        end)
        return frame
    end

    -- ====== SEÇÃO FARM ======
    print("[DRONX] Passo 8: Criando seção Farm...")
    local farmSection = Instance.new("Frame")
    farmSection.Size = UDim2.new(1, 0, 0, 0)
    farmSection.BackgroundTransparency = 1
    farmSection.Parent = container

    local farmTitle = Instance.new("TextLabel")
    farmTitle.Size = UDim2.new(1, 0, 0, 25)
    farmTitle.BackgroundTransparency = 1
    farmTitle.Text = "⚔️ FARM"
    farmTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
    farmTitle.TextSize = 18
    farmTitle.Font = Enum.Font.GothamBold
    farmTitle.TextXAlignment = Enum.TextXAlignment.Left
    farmTitle.Parent = farmSection

    createCheckbox(farmSection, "Auto Farm", "AutoFarm")
    createCheckbox(farmSection, "Farm Maestria", "FarmMaestria")
    createCheckbox(farmSection, "Auto Coletar Itens", "AutoCollect")
    createCheckbox(farmSection, "Cura Automática", "AutoHeal")

    -- ====== SEÇÃO BOSS ======
    print("[DRONX] Passo 9: Criando seção Boss...")
    local bossSection = Instance.new("Frame")
    bossSection.Size = UDim2.new(1, 0, 0, 0)
    bossSection.BackgroundTransparency = 1
    bossSection.Parent = container

    local bossTitle = Instance.new("TextLabel")
    bossTitle.Size = UDim2.new(1, 0, 0, 25)
    bossTitle.BackgroundTransparency = 1
    bossTitle.Text = "👹 BOSS"
    bossTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
    bossTitle.TextSize = 18
    bossTitle.Font = Enum.Font.GothamBold
    bossTitle.TextXAlignment = Enum.TextXAlignment.Left
    bossTitle.Parent = bossSection

    local bossDropdown = Instance.new("TextBox")
    bossDropdown.Size = UDim2.new(0.9, 0, 0, 30)
    bossDropdown.Position = UDim2.new(0.05, 0, 0, 0)
    bossDropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    bossDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
    bossDropdown.TextSize = 16
    bossDropdown.Font = Enum.Font.Gotham
    bossDropdown.PlaceholderText = "Digite o nome do Boss"
    bossDropdown.Parent = bossSection

    local btnBoss = Instance.new("TextButton")
    btnBoss.Size = UDim2.new(0.6, 0, 0, 30)
    btnBoss.Position = UDim2.new(0.2, 0, 0, 40)
    btnBoss.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    btnBoss.Text = "CAÇAR BOSS"
    btnBoss.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnBoss.TextScaled = true
    btnBoss.Font = Enum.Font.GothamBold
    btnBoss.Parent = bossSection

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

    -- ====== SEÇÃO STATUS ======
    print("[DRONX] Passo 10: Criando seção Status...")
    local statsSection = Instance.new("Frame")
    statsSection.Size = UDim2.new(1, 0, 0, 0)
    statsSection.BackgroundTransparency = 1
    statsSection.Parent = container

    local statsTitle = Instance.new("TextLabel")
    statsTitle.Size = UDim2.new(1, 0, 0, 25)
    statsTitle.BackgroundTransparency = 1
    statsTitle.Text = "📊 STATUS"
    statsTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
    statsTitle.TextSize = 18
    statsTitle.Font = Enum.Font.GothamBold
    statsTitle.TextXAlignment = Enum.TextXAlignment.Left
    statsTitle.Parent = statsSection

    local statsLabel = Instance.new("TextLabel")
    statsLabel.Size = UDim2.new(1, 0, 0, 25)
    statsLabel.BackgroundTransparency = 1
    statsLabel.Text = "💰 $1,323,522  |  📊 Lv. 2631"
    statsLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
    statsLabel.TextSize = 16
    statsLabel.Font = Enum.Font.Gotham
    statsLabel.TextXAlignment = Enum.TextXAlignment.Left
    statsLabel.Parent = statsSection

    -- ====== BOTÃO INICIAR/PARAR ======
    print("[DRONX] Passo 11: Criando botão principal...")
    local btnMain = Instance.new("TextButton")
    btnMain.Size = UDim2.new(0.6, 0, 0, 40)
    btnMain.Position = UDim2.new(0.2, 0, 0, 0)
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
        if running then
            mostrarNotificacao("Todos os sistemas iniciados!", Color3.fromRGB(0, 200, 0))
        else
            mostrarNotificacao("Todos os sistemas parados.", Color3.fromRGB(200, 0, 0))
        end
    end)

    -- ====== FINALIZAÇÃO ======
    print("[DRONX] Passo 12: GUI completa criada com sucesso!")
    print("[DRONX] A janela DEVE estar visível agora.")
end

-- Executa com proteção e logs
local ok, err = pcall(criarGUI)
if not ok then
    warn("[DRONX] ERRO FATAL na criação da GUI: " .. tostring(err))
else
    print("[DRONX] criarGUI() executou sem erros.")
end
