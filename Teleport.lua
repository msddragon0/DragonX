-- ============================================================
-- Teleport.lua – Todas as funções de teleporte
-- ============================================================

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

local function teleportTo(cframe)
    if rootPart then
        rootPart.CFrame = cframe
    end
end

-- Loop para monitorar pedidos de teleporte
while true do
    local drx = getgenv().DRONX
    if drx and drx.TeleportCoords then
        local c = drx.TeleportCoords
        if c.X and c.Y and c.Z then
            teleportTo(CFrame.new(c.X, c.Y, c.Z))
            drx.TeleportCoords = nil -- reseta após teleportar
        end
    end
    task.wait(0.5)
end
