-- ============================================================
-- INICIAR.lua – Loader principal do DRONX (CORRIGIDO)
-- ============================================================

-- Impede execução múltipla (evita loop infinito)
if getgenv().DRONX_LOADED then
    print("[DRONX] Loader já foi executado. Ignorando...")
    return
end
getgenv().DRONX_LOADED = true

print("[DRONX] ========================================")
print("[DRONX] Iniciando loader...")
print("[DRONX] ========================================")

-- Lista de scripts com suas URLs
local scripts = {
    ["Config"] = "https://raw.githubusercontent.com/msddragon0/DragonX/refs/heads/main/Config.lua",
    ["GUI"] = "https://raw.githubusercontent.com/msddragon0/DragonX/refs/heads/main/GUI.lua",
    ["Farm"] = "https://raw.githubusercontent.com/msddragon0/DragonX/refs/heads/main/Farm.lua",
    ["Teleport"] = "https://raw.githubusercontent.com/msddragon0/DragonX/refs/heads/main/Teleport.lua"
}

-- Função para carregar um script com tentativas
local function carregarScript(url, nome)
    local tentativas = 3
    for i = 1, tentativas do
        local success, result = pcall(function()
            print("[DRONX] Tentando carregar " .. nome .. " (tentativa " .. i .. "/" .. tentativas .. ")...")
            local content = game:HttpGet(url)
            if content and content ~= "" then
                print("[DRONX] " .. nome .. " baixado (" .. string.len(content) .. " caracteres)")
                local fn, err = loadstring(content)
                if fn then
                    fn()
                    print("[DRONX] ✅ " .. nome .. " carregado com sucesso!")
                    return true
                else
                    warn("[DRONX] ❌ Erro ao compilar " .. nome .. ": " .. tostring(err))
                    return false
                end
            else
                warn("[DRONX] ❌ " .. nome .. " está vazio ou não foi encontrado.")
                return false
            end
        end)
        if success and result == true then
            return true
        else
            warn("[DRONX] ❌ Falha ao carregar " .. nome .. ": " .. tostring(result))
            task.wait(1) -- espera 1 segundo antes de tentar novamente
        end
    end
    warn("[DRONX] ❌ Falha definitiva ao carregar " .. nome .. " após " .. tentativas .. " tentativas.")
    return false
end

-- Carrega cada script (ordem importante: Config primeiro, depois GUI, depois os outros)
local ordem = {"Config", "GUI", "Farm", "Teleport"}
for _, nome in ipairs(ordem) do
    local url = scripts[nome]
    if url then
        carregarScript(url, nome)
    else
        warn("[DRONX] ❌ URL não encontrada para " .. nome)
    end
    task.wait(0.5) -- pequeno delay entre carregamentos
end

print("[DRONX] ========================================")
print("[DRONX] Todos os scripts carregados!")
print("[DRONX] ========================================")
