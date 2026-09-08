-- ============================================================
-- GUI.lua – Interface visual do DRONX
-- ============================================================

local function criarGUI()
    local player = game.Players.LocalPlayer
    local guiParent = game:GetService("CoreGui") or player:WaitForChild("PlayerGui") or game:GetService("StarterGui")
    if not guiParent then return warn("[DRONX] Sem pai para GUI") end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DRONX_GUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = guiParent

    -- Janela principal
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 450)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -225)
    mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    mainFrame.BorderSizePixel = 1
    mainFrame.BorderColor3 = Color3.fromRGB(60, 60, 70)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    -- Título
    local titulo = Instance.new("TextLabel")
    titulo.Size = UDim2.new(1, 0, 0, 35)
    titulo.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    titulo.Text = "DRONX"
    titulo.TextColor3 = Color3.fromRGB(255, 215, 0)
    titulo.TextScaled = true
    titulo.Font = Enum.Font.GothamBold
    titulo.Parent = mainFrame

    -- Botão fechar
    local fecharBtn = Instance.new("TextButton")
    fecharBtn.Size = UDim2.new(0, 30, 0, 30)
    fecharBtn.Position = UDim2.new(1, -35, 0, 3)
    fecharBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    fecharBtn.Text = "X"
    fecharBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    fecharBtn.TextScaled = true
    fecharBtn.Font = Enum.Font.GothamBold
    fecharBtn.Parent = mainFrame
    fecharBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

    -- ====== BARRA DE ABAS ======
    local tabBar = Instance.new("Frame")
    tabBar.Size = UDim2.new(1, -10, 0, 35)
    tabBar.Position = UDim2.new(0, 5, 0, 40)
    tabBar.BackgroundTransparency = 1
    tabBar.Parent = mainFrame

    local tabs = {
        {name = "Farm", id = "farm"},
        {name = "Teleport", id = "teleport"},
        {name = "Config", id = "config"}
    }

    local tabButtons = {}
    local contentFrames = {}

    for i, tab in ipairs(tabs) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.33, -2, 1, -4)
        btn.Position = UDim2.new((i-1)*0.33, 2, 0, 2)
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        btn.Text = tab.name
        btn.TextColor3 = Color3.fromRGB(200, 200, 210)
        btn.TextScaled = true
        btn.Font = Enum.Font.GothamBold
        btn.BorderSizePixel = 0
        btn.Parent = tabBar
        btn.Name = tab.id
        tabButtons[tab.id] = btn

        btn.MouseButton1Click:Connect(function()
            for _, b in pairs(tabButtons) do
                b.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
                b.TextColor3 = Color3.fromRGB(200, 200, 210)
            end
            btn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
            btn.TextColor3 = Color3.fromRGB(18, 18, 22)
            for _, f in pairs(contentFrames) do
                f.Visible = false
            end
            if contentFrames[tab.id] then
                contentFrames[tab.id].Visible = true
            end
        end)
    end

    local function createContentTab(id)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, -10, 1, -90)
        frame.Position = UDim2.new(0, 5, 0, 80)
        frame.BackgroundTransparency = 1
        frame.Visible = false
        frame.Parent = mainFrame
        contentFrames[id] = frame
        return frame
    end

    -- Função checkbox
    local function createCheckbox(parent, y, text, varName)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, -10, 0, 30)
        frame.Position = UDim2.new(0, 5, 0, y)
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
        check.Position = UDim2.new(0.9, 0, 0, 2)
        check.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        check.Text = ""
        check.TextColor3 = Color3.fromRGB(255, 255, 255)
        check.TextScaled = true
        check.Font = Enum.Font.GothamBold
        check.BorderSizePixel = 1
        check.BorderColor3 = Color3.fromRGB(255, 255, 255)
        check.Parent = frame

        local state = getgenv().DRONX[varName] or false
        if state then
            check.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            check.Text = "✓"
        end

        check.MouseButton1Click:Connect(function()
            state = not state
            getgenv().DRONX[varName] = state
            check.BackgroundColor3 = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(100, 100, 100)
            check.Text = state and "✓" or ""
        end)
        return frame
    end

    -- ====== ABA FARM ======
    local farmFrame = createContentTab("farm")
    local fY = 0
    createCheckbox(farmFrame, fY, "Auto Farm", "AutoFarm")
    fY = fY + 35
    createCheckbox(farmFrame, fY, "Farm Maestria", "FarmMaestria")
    fY = fY + 35
    createCheckbox(farmFrame, fY, "Farm Boss", "FarmBoss")
    fY = fY + 35
    createCheckbox(farmFrame, fY, "Auto Coletar Itens", "AutoCollect")
    fY = fY + 35
    createCheckbox(farmFrame, fY, "Cura Automática", "AutoHeal")
    fY = fY + 35

    -- Campo para nome do Boss
    local bossInput = Instance.new("TextBox")
    bossInput.Size = UDim2.new(0.8, 0, 0, 30)
    bossInput.Position = UDim2.new(0.1, 0, 0, fY)
    bossInput.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    bossInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    bossInput.TextSize = 16
    bossInput.Font = Enum.Font.Gotham
    bossInput.PlaceholderText = "Nome do Boss (ex: Don Swan)"
    bossInput.Parent = farmFrame
    fY = fY + 40

    bossInput.FocusLost:Connect(function()
        getgenv().DRONX.BossName = bossInput.Text
    end)

    -- Botão Iniciar/Parar
    local btnFarm = Instance.new("TextButton")
    btnFarm.Size = UDim2.new(0.6, 0, 0, 35)
    btnFarm.Position = UDim2.new(0.2, 0, 0, fY + 10)
    btnFarm.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    btnFarm.Text = "INICIAR FARM"
    btnFarm.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnFarm.TextScaled = true
    btnFarm.Font = Enum.Font.GothamBold
    btnFarm.Parent = farmFrame

    btnFarm.MouseButton1Click:Connect(function()
        getgenv().DRONX.Running = not getgenv().DRONX.Running
        btnFarm.Text = getgenv().DRONX.Running and "PARAR FARM" or "INICIAR FARM"
        btnFarm.BackgroundColor3 = getgenv().DRONX.Running and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(0, 150, 0)
        -- O módulo Farm.lua monitora DRONX.Running
    end)

    -- ====== ABA TELEPORT ======
    local teleFrame = createContentTab("teleport")
    local tY = 0
    local coordInput = Instance.new("TextBox")
    coordInput.Size = UDim2.new(0.8, 0, 0, 30)
    coordInput.Position = UDim2.new(0.1, 0, 0, tY)
    coordInput.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    coordInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    coordInput.TextSize = 16
    coordInput.Font = Enum.Font.Gotham
    coordInput.PlaceholderText = "X, Y, Z (ex: 100, 50, 200)"
    coordInput.Parent = teleFrame
    tY = tY + 40

    local btnTele = Instance.new("TextButton")
    btnTele.Size = UDim2.new(0.6, 0, 0, 35)
    btnTele.Position = UDim2.new(0.2, 0, 0, tY + 10)
    btnTele.BackgroundColor3 = Color3.fromRGB(30, 120, 200)
    btnTele.Text = "TELEPORTAR"
    btnTele.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnTele.TextScaled = true
    btnTele.Font = Enum.Font.GothamBold
    btnTele.Parent = teleFrame

    btnTele.MouseButton1Click:Connect(function()
        local coords = coordInput.Text
        local x, y, z = coords:match("(%d+),%s*(%d+),%s*(%d+)")
        if x and y and z then
            getgenv().DRONX.TeleportCoords = {X = tonumber(x), Y = tonumber(y), Z = tonumber(z)}
        end
    end)

    -- Ilhas rápidas
    local ilhas = {"Marine Fort", "Jungle", "Sky Island"}
    for i, ilha in ipairs(ilhas) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.3, -5, 0, 30)
        btn.Position = UDim2.new(0.05 + (i-1)*0.35, 0, 0, tY + 60)
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        btn.Text = ilha
        btn.TextColor3 = Color3.fromRGB(200, 200, 210)
        btn.TextScaled = true
        btn.Font = Enum.Font.GothamBold
        btn.Parent = teleFrame
        btn.MouseButton1Click:Connect(function()
            local coords = {
                ["Marine Fort"] = CFrame.new(100, 50, 200),
                ["Jungle"] = CFrame.new(-150, 30, 300),
                ["Sky Island"] = CFrame.new(0, 500, 0)
            }
            if coords[ilha] then
                getgenv().DRONX.TeleportCoords = {X = coords[ilha].X, Y = coords[ilha].Y, Z = coords[ilha].Z}
            end
        end)
    end

    -- ====== ABA CONFIG ======
    local configFrame = createContentTab("config")
    local cY = 0
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0, 25)
    distLabel.Position = UDim2.new(0, 0, 0, cY)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = "Distância de ataque: " .. (getgenv().DRONX.AttackDistance or 40)
    distLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
    distLabel.TextSize = 16
    distLabel.Font = Enum.Font.Gotham
    distLabel.Parent = configFrame
    cY = cY + 30

    local distSlider = Instance.new("Frame")
    distSlider.Size = UDim2.new(0.8, 0, 0, 5)
    distSlider.Position = UDim2.new(0.1, 0, 0, cY)
    distSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    distSlider.Parent = configFrame
    cY = cY + 15

    local distFill = Instance.new("Frame")
    distFill.Size = UDim2.new((getgenv().DRONX.AttackDistance or 40) / 80, 0, 1, 0)
    distFill.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    distFill.Parent = distSlider

    local decBtn = Instance.new("TextButton")
    decBtn.Size = UDim2.new(0, 30, 0, 30)
    decBtn.Position = UDim2.new(0.05, 0, 0, cY - 12)
    decBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    decBtn.Text = "-"
    decBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    decBtn.TextScaled = true
    decBtn.Font = Enum.Font.GothamBold
    decBtn.Parent = configFrame

    local incBtn = Instance.new("TextButton")
    incBtn.Size = UDim2.new(0, 30, 0, 30)
    incBtn.Position = UDim2.new(0.85, 0, 0, cY - 12)
    incBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    incBtn.Text = "+"
    incBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    incBtn.TextScaled = true
    incBtn.Font = Enum.Font.GothamBold
    incBtn.Parent = configFrame

    decBtn.MouseButton1Click:Connect(function()
        local d = getgenv().DRONX.AttackDistance
        d = math.max(10, d - 5)
        getgenv().DRONX.AttackDistance = d
        distLabel.Text = "Distância de ataque: " .. d
        distFill.Size = UDim2.new(d / 80, 0, 1, 0)
    end)
    incBtn.MouseButton1Click:Connect(function()
        local d = getgenv().DRONX.AttackDistance
        d = math.min(80, d + 5)
        getgenv().DRONX.AttackDistance = d
        distLabel.Text = "Distância de ataque: " .. d
        distFill.Size = UDim2.new(d / 80, 0, 1, 0)
    end)
    cY = cY + 40

    createCheckbox(configFrame, cY, "Auto Reconectar", "AutoReconnect")
    cY = cY + 35

    -- ====== ATIVA A PRIMEIRA ABA ======
    tabButtons["farm"].MouseButton1Click:Fire()

    print("[DRONX] GUI carregada.")
end

pcall(criarGUI)
