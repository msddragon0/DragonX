-- ============================================================
-- INICIAR.lua – Loader com delay para garantir GUI
-- ============================================================

if getgenv().DRONX_LOADED then
    print("[DRONX] Loader já executado. Ignorando.")
    return
end
getgenv().DRONX_LOADED = true

print("[DRONX] Iniciando loader...")

local scripts = {
    ["Config"] = "https://raw.githubusercontent.com/msddragon0/DragonX/refs/heads/main/Config.lua",
    ["GUI"] = "https://raw.githubusercontent.com/msddragon0/DragonX/refs/heads/main/GUI.lua",
    ["Farm"] = "https://raw.githubusercontent.com/msddragon0/DragonX/refs/heads/main/Farm.lua",
    ["Teleport"] = "https://raw.githubusercontent.com/msddragon0/DragonX/refs/heads/main/Teleport.lua"
}

local function loadScript(url, name)
    for i = 1, 3 do
        local ok, err = pcall(function()
            local content = game:HttpGet(url)
            if content and content ~= "" then
                loadstring(content)()
                print("[DRONX] ✅ " .. name .. " carregado.")
                return true
            end
        end)
        if ok then return true end
        task.wait(1)
    end
    warn("[DRONX] ❌ Falha ao carregar " .. name)
    return false
end

-- Carrega Config primeiro
loadScript(scripts.Config, "Config")
task.wait(0.5)

-- Carrega GUI (com delay extra)
loadScript(scripts.GUI, "GUI")
task.wait(1) -- delay extra para a GUI aparecer

-- Carrega os outros
loadScript(scripts.Farm, "Farm")
task.wait(0.5)
loadScript(scripts.Teleport, "Teleport")

print("[DRONX] Todos os scripts carregados!")
