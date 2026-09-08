-- ============================================================
-- GUI.lua – DRONX (VERSÃO CORRIGIDA COM LOGS)
-- ============================================================

print("[DRONX] Iniciando criação da GUI...")

local function criarGUI()
    print("[DRONX] Entrou na função criarGUI()")
    
    local player = game.Players.LocalPlayer
    if not player then
        warn("[DRONX] Sem player!")
        return
    end

    -- Tenta CoreGui, se falhar usa PlayerGui
    local guiParent = game:GetService("CoreGui")
    if not guiParent then
        guiParent = player:WaitForChild("PlayerGui")
    end
    if not guiParent then
        warn("[DRONX] Sem pai para GUI!")
        return
    end
    print("[DRONX] Pai da GUI:", guiParent.Name)

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DRONX_GUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = guiParent
    print("[DRONX] ScreenGui criada e parenteada.")

    -- ====== JANELA PRINCIPAL ======
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 480, 0, 500)
    mainFrame.Position = UDim2.new(0.5, -240, 0.5, -250)
    mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    mainFrame.BorderSizePixel = 1
    mainFrame.BorderColor3 = Color3.fromRGB(60, 60, 70)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Visible = true  -- FORÇA VISÍVEL
    mainFrame.Parent = screenGui
    print("[DRONX] Frame principal criado e visível.")

    -- ====== TÍTULO ======
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 35)
    titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    titleBar.Parent = mainFrame

    local titulo = Instance.new("TextLabel")
    titulo.Size = UDim2.new(0.8, 0, 1, 0)
    titulo.Position = UDim2.new(0, 10, 0, 0)
    titulo.BackgroundTransparency = 1
    titulo.Text = "DRONX"
    titulo.TextColor3 = Color3.fromRGB(255, 215, 0)
    titulo.TextScaled = true
    titulo.Font = Enum.Font.GothamBold
    titulo.TextXAlignment = Enum.TextXAlignment.Left
    titulo.Parent = titleBar

    -- Botão Fechar
    local btnFechar = Instance.new("TextButton")
    btnFechar.Size = UDim2.new(0, 30, 0, 30)
    btnFechar.Position = UDim2.new(1, -35, 0, 3)
    btnFechar.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    btnFechar.Text = "X"
    btnFechar.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnFechar.TextScaled = true
    btnFechar.Font = Enum.Font.GothamBold
    btnFechar.Parent = titleBar
    btnFechar.MouseButton1Click:Connect(function() screenGui:Destroy() end)

    -- ====== CONTAINER (com rolagem) ======
    local container = Instance.new("ScrollingFrame")
    container.Size = UDim2.new(1, -10, 1, -45)
    container.Position = UDim2.new(0, 5, 0, 40)
    container.BackgroundTransparency = 1
    container.ScrollBarThickness = 5
    container.Parent = mainFrame
    print("[DRONX] ScrollingFrame criado.")

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = container

    -- ====== TEXTO DE TESTE ======
    local testLabel = Instance.new("TextLabel")
    testLabel.Size = UDim2.new(1, 0, 0, 30)
    testLabel.BackgroundTransparency = 1
    testLabel.Text = "✅ GUI carregada com sucesso!"
    testLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    testLabel.TextSize = 20
    testLabel.Font = Enum.Font.GothamBold
    testLabel.Parent = container

    -- Ajuste do CanvasSize para a rolagem
    container.CanvasSize = UDim2.new(0, 0, 0, 200)

    print("[DRONX] GUI criada com sucesso! Ela DEVE aparecer agora.")
end

-- Executa com proteção
local ok, err = pcall(criarGUI)
if not ok then
    warn("[DRONX] ERRO ao criar GUI: " .. tostring(err))
else
    print("[DRONX] criarGUI() executou sem erros.")
end
