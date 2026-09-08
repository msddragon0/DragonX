-- Teleport.lua – Teleporte para coordenadas e ilhas

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

while true do
    local drx = getgenv().DRONX
    if drx and drx.TeleportCoords then
        local c = drx.TeleportCoords
        if c.X and c.Y and c.Z then
            rootPart.CFrame = CFrame.new(c.X, c.Y, c.Z)
            drx.TeleportCoords = nil
        end
    end
    task.wait(0.5)
end
