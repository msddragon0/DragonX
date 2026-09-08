-- ============================================================
-- INICIAR.lua – Loader principal com diagnóstico
-- ============================================================

print("[DRONX] ========================================")
print("[DRONX] Iniciando loader...")
print("[DRONX] ========================================")

-- Lista de scripts
local scripts = {
    ["Config"] = "https://raw.githubusercontent.com/msddragon0/DragonX/refs/heads/main/Config.lua",
    ["GUI"] = "https://raw.githubusercontent.com/msddragon0/DragonX/refs/heads/main/GUI.lua",
    ["Farm"] = "https://raw.githubusercontent.com/msddragon0/DragonX/refs/heads/main/Farm.lua",
    ["Teleport"] = "https://raw.githubusercontent.com/msddragon0/DragonX/refs/heads/main/Teleport.lua"
}

local function carregarScript(url, nome)
    print("[DRONX] Carregando " .. nome .. "...")
    local success, resultado = pcall(function()
        local conteudo = game:HttpGet(url)
        if conteudo and conteudo ~= "" then
            print("[DRONX] " .. nome .. " baixado (" .. string.len(conteudo) .. " caracteres)")
            local func, erro = loadstring(conteudo)
            if func then
                func()
                print("[DRONX] ✅ " .. nome .. " executado com sucesso!")
            else
                warn("[DRONX] ❌ Erro ao compilar " .. nome .. ": " .. tostring(erro))
            end
        else
            warn("[DRONX] ❌ " .. nome .. " está vazio ou não foi encontrado.")
        end
    end)
    if not success then
        warn("[DRONX] ❌ Erro ao carregar " .. nome .. ": " .. tostring(resultado))
    end
    task.wait(0.3)
end

-- Carrega todos os scripts
for nome, url in pairs(scripts) do
    carregarScript(url, nome)
end

print("[DRONX] ========================================")
print("[DRONX] Todos os scripts foram carregados!")
print("[DRONX] ========================================")
