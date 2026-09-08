-- ============================================================
-- INICIAR.lua – Loader principal DRONX (corrigido)
-- Carrega cada script UMA ÚNICA VEZ, sem loops infinitos.
-- ============================================================

print("[DRONX] ========================================")
print("[DRONX] Iniciando loader...")
print("[DRONX] ========================================")

-- Lista de scripts com suas URLs (apenas os que existem)
local scripts = {
    ["Config"] = "https://raw.githubusercontent.com/msddragon0/DragonX/refs/heads/main/Config.lua",
    ["GUI"] = "https://raw.githubusercontent.com/msddragon0/DragonX/refs/heads/main/GUI.lua",
    ["Farm"] = "https://raw.githubusercontent.com/msddragon0/DragonX/refs/heads/main/Farm.lua",
    ["Teleport"] = "https://raw.githubusercontent.com/msddragon0/DragonX/refs/heads/main/Teleport.lua"
}

-- Função para carregar um script com segurança
local function carregarScript(url, nome)
    print("[DRONX] Carregando " .. nome .. "...")
    local sucesso, resultado = pcall(function()
        local conteudo = game:HttpGet(url)
        if conteudo and conteudo ~= "" then
            local func, err = loadstring(conteudo)
            if func then
                func()
                print("[DRONX] ✅ " .. nome .. " carregado com sucesso!")
            else
                warn("[DRONX] ❌ Erro ao compilar " .. nome .. ": " .. tostring(err))
            end
        else
            warn("[DRONX] ❌ " .. nome .. " está vazio ou não encontrado.")
        end
    end)
    if not sucesso then
        warn("[DRONX] ❌ Erro ao baixar " .. nome .. ": " .. tostring(resultado))
    end
    task.wait(0.5) -- pequeno delay para não sobrecarregar
end

-- Carrega cada script da lista (apenas uma vez)
for nome, url in pairs(scripts) do
    carregarScript(url, nome)
end

print("[DRONX] ========================================")
print("[DRONX] ✅ Todos os scripts carregados!")
print("[DRONX] ========================================")
