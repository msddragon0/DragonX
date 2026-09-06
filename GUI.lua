-- DRAGONX – VERSÃO DE DEPURAÇÃO PARA EMULADOR
-- Este script tenta criar a GUI e mostra prints para saber onde falha.

print("[DRAGONX] Iniciando script...")

-- Função principal com proteção
local function criarGUI()
    print("[DRAGONX] Tentando criar GUI...")

    -- 1. Tenta CoreGui
    local sucesso, pai = pcall(function()
        return game:GetService("CoreGui")
    end)
    if not sucesso or not pai then
        print("[DRAGONX] CoreGui falhou, tentando PlayerGui...")
        sucesso, pai = pcall(function()
            return game.Players.LocalPlayer:WaitForChild("PlayerGui")
        end)
    end
    if not sucesso or not pai then
        print("[DRAGONX] PlayerGui falhou, tentando StarterGui...")
        sucesso, pai = pcall(function()
            return game:GetService("StarterGui")
        end)
    end
    if not sucesso or not pai then
        print("[DRAGONX] ERRO: Nenhum pai disponível para a GUI.")
        return
    end
    print("[DRAGONX] Pai definido:", pai.Name)

    -- 2. Cria a ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DragonX_GUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = pai
    print("[DRAGONX] ScreenGui criada e parenteada.")

    -- 3. Cria o frame principal
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 350, 0, 450)
    mainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    mainFrame.BorderSizePixel = 1
    mainFrame.BorderColor3 = Color3.fromRGB(60, 60, 70)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    print("[DRAGONX] Frame principal criado.")

    -- 4. Título
    local titulo = Instance.new("TextLabel")
    titulo.Size = UDim2.new(1, 0, 0, 35)
    titulo.Position = UDim2.new(0, 0, 0, 0)
    titulo.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    titulo.Text = "DRAGONX"
    titulo.TextColor3 = Color3.fromRGB(255, 215, 0)
    titulo.TextSize = 26
    titulo.Font = Enum.Font.GothamBold
    titulo.Parent = mainFrame

    -- 5. Botão fechar
    local fecharBtn = Instance.new("TextButton")
    fecharBtn.Size = UDim2.new(0, 28, 0, 28)
    fecharBtn.Position = UDim2.new(1, -32, 0, 3)
    fecharBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    fecharBtn.Text = "X"
    fecharBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    fecharBtn.TextSize = 18
    fecharBtn.Font = Enum.Font.GothamBold
    fecharBtn.Parent = mainFrame
    fecharBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        print("[DRAGONX] GUI fechada manualmente.")
    end)

    -- 6. Container para os textos
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -20, 1, -50)
    container.Position = UDim2.new(0, 10, 0, 40)
    container.BackgroundTransparency = 1
    container.Parent = mainFrame
    print("[DRAGONX] Container criado.")

    -- 7. Função auxiliar para texto
    local function addText(parent, texto, y, cor, tam)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, 0, 0, 22)
        lbl.Position = UDim2.new(0, 0, 0, y)
        lbl.BackgroundTransparency = 1
        lbl.Text = texto
        lbl.TextColor3 = cor or Color3.fromRGB(255, 255, 255)
        lbl.TextSize = tam or 16
        lbl.Font = Enum.Font.Gotham
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = parent
        return lbl
    end

    local yPos = 0
    addText(container, "Derrote 8 campeões da ilha", yPos, Color3.fromRGB(220,220,230), 16)
    yPos = yPos + 25
    addText(container, "Campão da ilha  0/8", yPos, Color3.fromRGB(200,200,210), 16)
    yPos = yPos + 28
    addText(container, "$15,300  |  Status", yPos, Color3.fromRGB(255,215,0), 16)
    yPos = yPos + 25
    addText(container, "139,000,000 EXP  |  Itens", yPos, Color3.fromRGB(255,255,200), 16)
    yPos = yPos + 30

    -- 8. Botões Fechar (interno) e Loja
    local btnFrame = Instance.new("Frame")
    btnFrame.Size = UDim2.new(1, 0, 0, 32)
    btnFrame.Position = UDim2.new(0, 0, 0, yPos)
    btnFrame.BackgroundTransparency = 1
    btnFrame.Parent = container
    yPos = yPos + 36

    local btnFechar = Instance.new("TextButton")
    btnFechar.Size = UDim2.new(0.4, -10, 1, 0)
    btnFechar.Position = UDim2.new(0, 0, 0, 0)
    btnFechar.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
    btnFechar.Text = "Fechar"
    btnFechar.TextColor3 = Color3.fromRGB(255,255,255)
    btnFechar.TextSize = 18
    btnFechar.Font = Enum.Font.GothamBold
    btnFechar.Parent = btnFrame
    btnFechar.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        print("[DRAGONX] GUI fechada pelo botão interno.")
    end)

    local btnLoja = Instance.new("TextButton")
    btnLoja.Size = UDim2.new(0.4, -10, 1, 0)
    btnLoja.Position = UDim2.new(0.6, 10, 0, 0)
    btnLoja.BackgroundColor3 = Color3.fromRGB(30, 120, 200)
    btnLoja.Text = "Loja"
    btnLoja.TextColor3 = Color3.fromRGB(255,255,255)
    btnLoja.TextSize = 18
    btnLoja.Font = Enum.Font.GothamBold
    btnLoja.Parent = btnFrame

    -- 9. Separador
    local sep = Instance.new("Frame")
    sep.Size = UDim2.new(0.9, 0, 0, 2)
    sep.Position = UDim2.new(0.05, 0, 0, yPos)
    sep.BackgroundColor3 = Color3.fromRGB(60,60,70)
    sep.BorderSizePixel = 0
    sep.Parent = container
    yPos = yPos + 10

    -- 10. Estatísticas
    addText(container, "$1,319,352", yPos, Color3.fromRGB(255,215,0), 20)
    yPos = yPos + 26
    addText(container, "Lv. 2631  |  68,186,597 / 146,996,907", yPos, Color3.fromRGB(200,200,255), 16)
    yPos = yPos + 30

    -- 11. Barras simplificadas
    local function addBar(parent, y, label, maxVal, curVal, cor)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 18)
        frame.Position = UDim2.new(0, 0, 0, y)
        frame.BackgroundColor3 = Color3.fromRGB(30,30,35)
        frame.BorderSizePixel = 1
        frame.BorderColor3 = Color3.fromRGB(50,50,55)
        frame.Parent = parent

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0.3, 0, 1, 0)
        lbl.Position = UDim2.new(0, 4, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = label
        lbl.TextColor3 = Color3.fromRGB(220,220,230)
        lbl.TextSize = 14
        lbl.Font = Enum.Font.Gotham
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = frame

        local fill = Instance.new("Frame")
        local percent = math.min(1, curVal / maxVal)
        fill.Size = UDim2.new(percent, 0, 1, 0)
        fill.BackgroundColor3 = cor
        fill.BorderSizePixel = 0
        fill.Parent = frame

        local val = Instance.new("TextLabel")
        val.Size = UDim2.new(0.6, 0, 1, 0)
        val.Position = UDim2.new(0.4, 0, 0, 0)
        val.BackgroundTransparency = 1
        val.Text = tostring(curVal) .. " / " .. tostring(maxVal)
        val.TextColor3 = Color3.fromRGB(255,255,255)
        val.TextSize = 14
        val.Font = Enum.Font.Gotham
        val.TextXAlignment = Enum.TextXAlignment.Right
        val.Parent = frame
    end

    addBar(container, yPos, "Vida", 11770, 11770, Color3.fromRGB(200,40,40))
    yPos = yPos + 22
    addBar(container, yPos, "Energy", 14095, 14095, Color3.fromRGB(40,150,255))
    yPos = yPos + 24

    -- 12. Núcleo de Energia
    local core = Instance.new("Frame")
    core.Size = UDim2.new(0.6, 0, 0, 24)
    core.Position = UDim2.new(0.2, 0, 0, yPos)
    core.BackgroundColor3 = Color3.fromRGB(40,40,50)
    core.BorderSizePixel = 1
    core.BorderColor3 = Color3.fromRGB(80,80,100)
    core.Parent = container

    local coreLbl = Instance.new("TextLabel")
    coreLbl.Size = UDim2.new(1, 0, 1, 0)
    coreLbl.BackgroundTransparency = 1
    coreLbl.Text = "Núcleo de Energia"
    coreLbl.TextColor3 = Color3.fromRGB(180,220,255)
    coreLbl.TextSize = 18
    coreLbl.Font = Enum.Font.GothamBold
    coreLbl.Parent = core

    print("[DRAGONX] GUI criada com sucesso! Verifique se ela apareceu na tela.")
end

-- Executa com pcall para capturar erros
local status, erro = pcall(criarGUI)
if not status then
    print("[DRAGONX] ERRO na execução:", erro)
    warn("ERRO DRAGONX: " .. tostring(erro))
else
    print("[DRAGONX] Script finalizado sem erros.")
end
