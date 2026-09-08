-- ============================================================
-- Config.lua – Configurações globais e inicialização
-- ============================================================

-- Inicializa as variáveis globais se não existirem
if not getgenv().DRONX then
    getgenv().DRONX = {
        Running = false,
        AutoFarm = false,
        FarmMaestria = false,
        FarmBoss = false,
        BossName = "",
        AutoCollect = false,
        AutoHeal = false,
        TeleportCoords = nil,
        AttackDistance = 40,
        AutoReconnect = false
    }
end

-- Configuração de reconexão automática (exemplo)
if getgenv().DRONX.AutoReconnect then
    game:GetService("Players").LocalPlayer.OnTeleport:Connect(function()
        print("[DRONX] Reconectando...")
        -- Aguarda o jogo recarregar e reinicia os loops se necessário
    end)
end

print("[DRONX] Configurações carregadas. Distância de ataque: " .. getgenv().DRONX.AttackDistance)
