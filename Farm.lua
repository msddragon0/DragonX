-- ============================================================
-- Farm.lua – Auto Farm (CORRIGIDO)
-- ============================================================

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local function getClosestNPC(levelMin, levelMax, distance)
    local closest = nil
    local minDist = math.huge
    for _, npc in pairs(workspace.Enemies:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
            local npcLevel = npc:FindFirstChild("Level") and npc.Level.Value or 0
            if npcLevel >= levelMin and npcLevel <= levelMax then
                local dist = (rootPart.Position - npc.HumanoidRootPart.Position).Magnitude
                if dist < minDist and dist <= distance then
                    minDist = dist
                    closest = npc
                end
            end
        end
    end
    return closest
end

local function attackNPC(npc)
    if not npc or not npc:FindFirstChild("Humanoid") or npc.Humanoid.Health <= 0 then return end
    rootPart.CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
    task.wait(0.1)
    game:GetService("VirtualInputManager"):SendKeyEvent(true, "Q", false, game)
    task.wait(0.1)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, "Q", false, game)
end

-- Loop principal
while true do
    if getgenv().DRONX and getgenv().DRONX.Running then
        if getgenv().DRONX.AutoFarm then
            local npc = getClosestNPC(player.Data.Level.Value - 5, player.Data.Level.Value + 10, getgenv().DRONX.AttackDistance or 40)
            if npc then
                attackNPC(npc)
            else
                -- Se não encontrar NPC, espera um pouco
                task.wait(1)
            end
        end

        if getgenv().DRONX.AutoCollect then
            for _, item in pairs(workspace.DroppedItems:GetChildren()) do
                if item:IsA("Model") and item:FindFirstChild("Handle") then
                    if (rootPart.Position - item.Handle.Position).Magnitude < 15 then
                        fireclickdetector(item.Handle.ClickDetector)
                    end
                end
            end
        end

        if getgenv().DRONX.AutoHeal then
            if humanoid.Health / humanoid.MaxHealth < 0.3 then
                local potion = player.Backpack:FindFirstChild("Potion") or character:FindFirstChild("Potion")
                if potion then
                    potion.Activate:FireServer()
                end
            end
        end
    end
    task.wait()
end
