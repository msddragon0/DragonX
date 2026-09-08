-- ============================================================
-- GUI.lua – DRONX COMPLETO (FUNCIONAL E TESTADO)
-- ============================================================

print("[DRONX] Carregando GUI...")

local function criarGUI()
    local player = game.Players.LocalPlayer
    if not player then return warn("[DRONX] Sem player") end

    local guiParent = game:GetService("CoreGui")
    if not guiParent then guiParent = player:WaitForChild("PlayerGui") end
    if not guiParent then return warn("[DRONX] Sem pai para GUI") end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DRONX_GUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = guiParent

    -- Frame principal
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 450, 0, 400)
    main.Position = UDim2.new(0.5, -225, 0.5, -200)
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
    fechar.MouseButton1Click:Connect(function() screenGui:Destroy() end)

    -- Container
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -10, 1, -45)
    container.Position = UDim2.new(0, 5, 0, 40)
    container.BackgroundTransparency = 1
    container.Parent = main

    -- Título "FARM"
    local farmTitle = Instance.new("TextLabel")
    farmTitle.Size = UDim2.new(1, 0, 0, 25)
    farmTitle.BackgroundTransparency = 1
    farmTitle.Text = "⚔️ FARM"
    farmTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
    farmTitle.TextSize = 18
    farmTitle.Font = Enum.Font.GothamBold
    farmTitle.TextXAlignment = Enum.TextXAlignment.Left
    farmTitle.Parent = container

    -- Função checkbox simplificada
    local function checkbox(parent, y, text, var)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 30)
        frame.Position = UDim2.new(0, 0, 0, y)
        frame.BackgroundTransparency = 1
        frame.Parent = parent

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(220,220,230)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextScaled = true
        label.Font = Enum.Font.Gotham
        label.Parent = frame

        local check = Instance.new("TextButton")
        check.Size = UDim2.new(0, 25, 0, 25)
        check.Position = UDim2.new(0.9, 0, 0, 2)
        check.BackgroundColor3 = Color3.fromRGB(100,100,100)
        check.Text = ""
        check.TextColor3 = Color3.fromRGB(255,255,255)
        check.TextScaled = true
        check.Font = Enum.Font.GothamBold
        check.BorderSizePixel = 1
        check.BorderColor3 = Color3.fromRGB(255,255,255)
        check.Parent = frame

        if getgenv().DRONX and getgenv().DRONX[var] then
            check.BackgroundColor3 = Color3.fromRGB(0,200,0)
            check.Text = "✓"
        end

        check.MouseButton1Click:Connect(function()
            local state = not (getgenv().DRONX and getgenv().DRONX[var] or false)
            if not getgenv().DRONX then getgenv().DRONX = {} end
            getgenv().DRONX[var] = state
            check.BackgroundColor3 = state and Color3.fromRGB(0,200,0) or Color3.fromRGB(100,100,100)
            check.Text = state and "✓" or ""
        end)
        return frame
    end

    checkbox(container, 30, "Auto Farm", "AutoFarm")
    checkbox(container, 65, "Farm Maestria", "FarmMaestria")
    checkbox(container, 100, "Auto Coletar Itens", "AutoCollect")
    checkbox(container, 135, "Cura Automática", "AutoHeal")

    -- Botão INICIAR
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.6, 0, 0, 40)
    btn.Position = UDim2.new(0.2, 0, 0, 175)
    btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    btn.Text = "▶ INICIAR"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = container

    btn.MouseButton1Click:Connect(function()
        if not getgenv().DRONX then getgenv().DRONX = {} end
        local running = not getgenv().DRONX.Running
        getgenv().DRONX.Running = running
        btn.Text = running and "⏹ PARAR" or "▶ INICIAR"
        btn.BackgroundColor3 = running and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(0, 150, 0)
    end)

    print("[DRONX] GUI carregada com sucesso!")
end

pcall(criarGUI)
