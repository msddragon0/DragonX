-- Farm.lua – Auto Farm, Farm Maestria, Farm Boss, Auto Collect, Auto Heal

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

while true do
    local drx = getgenv().DRONX
    if drx and drx.Running then
        local dist = drx.AttackDistance or 40
        local lvl = player.Data.Level.Value

        -- Auto Farm
        if drx.AutoFarm then
            local npc = getClosestNPC(lvl - 5, lvl + 10, dist)
            if npc then attackNPC(npc) end
        end

        -- Farm Maestria (Espada ou Fruta)
        if drx.FarmMaestria or drx.FarmMaestriaFruit then
            local npc = getClosestNPC(lvl - 5, lvl + 10, dist)
            if npc then attackNPC(npc) end
        end

        -- Auto Collect
        if drx.AutoCollect then
            for _, item in pairs(workspace.DroppedItems:GetChildren()) do
                if item:IsA("Model") and item:FindFirstChild("Handle") then
                    if (rootPart.Position - item.Handle.Position).Magnitude < 15 then
                        fireclickdetector(item.Handle.ClickDetector)
                    end
                end
            end
        end

        -- Auto Heal
        if drx.AutoHeal then
            if humanoid.Health / humanoid.MaxHealth < 0.3 then
                local potion = player.Backpack:FindFirstChild("Potion") or character:FindFirstChild("Potion")
                if potion then potion.Activate:FireServer() end
            end
        end

        -- Farm Boss
        if drx.BossFarm and drx.BossName and drx.BossName ~= "" then
            for _, obj in pairs(workspace:GetChildren()) do
                if obj:IsA("Model") and obj.Name:lower():find(drx.BossName:lower()) then
                    if obj:FindFirstChild("Humanoid") and obj.Humanoid.Health > 0 then
                        rootPart.CFrame = obj.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                        while obj.Humanoid.Health > 0 and drx.BossFarm do
                            attackNPC(obj)
                            task.wait(0.5)
                        end
                    end
                end
            end
        end
    end
    task.wait()
end
