-- ============================================================
-- Iniciar.lua – Loader principal do DRONX
-- Carrega todos os scripts automaticamente.
-- ============================================================

print("[DRONX] Iniciando loader...")

-- Substitua os IDs abaixo pelos IDs reais dos seus scripts no Pastebin
local scripts = {
    ["Config"] = "https://raw.githubusercontent.com/msddragon0/DragonX/refs/heads/main/Config.lua",
    ["GUI"] = "https://raw.githubusercontent.com/msddragon0/DragonX/refs/heads/main/GUI.lua",
    ["Farm"] = "https://raw.githubusercontent.com/msddragon0/DragonX/refs/heads/main/Farm.lua",
    ["Teleport"] = "https://raw.githubusercontent.com/msddragon0/DragonX/refs/heads/main/Teleport.lua"
}

for nome, url in pairs(scripts) do
    print("[DRONX] Carregando " .. nome .. "...")
    local success, err = pcall(function()
        local scriptContent = game:HttpGet(url)
        loadstring(scriptContent)()
    end)
    if not success then
        warn("[DRONX] Erro ao carregar " .. nome .. ": " .. tostring(err))
    else
        print("[DRONX] " .. nome .. " carregado com sucesso.")
    end
    task.wait(0.5) -- Pequeno delay entre cada carregamento
end

print("[DRONX] Todos os scripts carregados. Aguarde a GUI aparecer.")
