-- Config.lua – Configurações gerais (distância, reconectar)

while true do
    local drx = getgenv().DRONX
    if drx and drx.AutoReconnect then
        if not game.Players.LocalPlayer:FindFirstChild("Data") then
            print("[DRONX] Tentando reconectar...")
            -- Aqui você pode colocar lógica de reconexão
        end
    end
    task.wait(5)
end
