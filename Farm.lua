-- ============================================================
-- Farm.lua – TODAS as funções de farm em um só script
-- Contém: Auto Farm, Farm Maestria, Farm Boss, Auto Collect, Auto Heal
-- ============================================================

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

-- ====== FUNÇÕES AUXILIARES ======
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

local function coletarItens()
    for _, item in pairs(workspace.DroppedItems:GetChildren()) do
        if item:IsA("Model") and item:FindFirstChild("Handle") then
            if (rootPart.Position - item.Handle.Position).Magnitude < 15 then
                fireclickdetector(item.Handle.ClickDetector)
            end
        end
    end
end

local function curar()
    if humanoid.Health / humanoid.MaxHealth < 0.3 then
        local potion = player.Backpack:FindFirstChild("Potion") or character:FindFirstChild("Potion")
        if potion then
            potion.Activate:FireServer()
        end
    end
end

local function atacarBoss(bossName)
    if not bossName or bossName == "" then return end
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Model") and obj.Name:lower():find(bossName:lower()) then
            if obj:FindFirstChild("Humanoid") and obj.Humanoid.Health > 0 then
                rootPart.CFrame = obj.HumanoidRootPart.CFrame
                while obj.Humanoid.Health > 0 and getgenv().DRONX.Running and getgenv().DRONX.FarmBoss do
                    attackNPC(obj)
                    task.wait(0.5)
                end
            end
        end
    end
end

-- ====== LOOP PRINCIPAL ======
while true do
    local drx = getgenv().DRONX
    if drx and drx.Running then
        -- Auto Farm
        if drx.AutoFarm then
            local npc = getClosestNPC(player.Data.Level.Value - 5, player.Data.Level.Value + 10, drx.AttackDistance or 40)
            if npc then attackNPC(npc) end
        end

        -- Farm Maestria
        if drx.FarmMaestria then
            local npc = getClosestNPC(player.Data.Level.Value - 5, player.Data.Level.Value + 10, drx.AttackDistance or 40)
            if npc then attackNPC(npc) end
        end

        -- Farm Boss
        if drx.FarmBoss and drx.BossName then
            atacarBoss(drx.BossName)
        end

        -- Auto Collect
        if drx.AutoCollect then
            coletarItens()
        end

        -- Auto Heal
        if drx.AutoHeal then
            curar()
        end
    end
    task.wait()
end
