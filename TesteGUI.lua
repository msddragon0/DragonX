-- ============================================================
-- TesteGUI.lua – Para diagnosticar se a GUI aparece
-- ============================================================

print("[TESTE] Criando GUI de teste...")

local function criarTeste()
    local guiParent = game:GetService("CoreGui") or game.Players.LocalPlayer.PlayerGui or game:GetService("StarterGui")
    if not guiParent then
        warn("[TESTE] Nenhum pai disponível!")
        return
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "Teste_GUI"
    screenGui.Parent = guiParent

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 100)
    frame.Position = UDim2.new(0.5, -100, 0.5, -50)
    frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    frame.Parent = screenGui

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "TESTE FUNCIONOU!"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = frame

    print("[TESTE] GUI criada com sucesso!")
end

pcall(criarTeste)
