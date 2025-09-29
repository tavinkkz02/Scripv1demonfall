-- Script Demonfall COMPLETO: Vida, Stamina, Dinheiro, XP, Auto Kill, Godmode PvE/PvP
local player = game.Players.LocalPlayer

-- Estados
local toggleHealth = false
local toggleStamina = false
local toggleMoney = false
local toggleXP = false
local toggleKill = false
local toggleGodmode = false

-- Funções para pegar elementos
local function getHumanoid()
    return player.Character and player.Character:FindFirstChild("Humanoid")
end

local function getStamina()
    return player:FindFirstChild("Stamina")
end

local function getLeaderstats()
    return player:FindFirstChild("leaderstats")
end

-- GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)

local function createButton(name, pos)
    local btn = Instance.new("TextButton", ScreenGui)
    btn.Size = UDim2.new(0, 150, 0, 40)
    btn.Position = pos
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    return btn
end

local btnHealth = createButton("Ativar Cura", UDim2.new(0.5, -75, 0.45, 0))
local btnStamina = createButton("Ativar Stamina", UDim2.new(0.5, -75, 0.525, 0))
local btnMoney = createButton("Ativar Dinheiro", UDim2.new(0.5, -75, 0.6, 0))
local btnXP = createButton("Ativar XP", UDim2.new(0.5, -75, 0.675, 0))
local btnKill = createButton("Ativar Auto Kill", UDim2.new(0.5, -75, 0.75, 0))
local btnGodmode = createButton("Ativar Godmode", UDim2.new(0.5, -75, 0.825, 0))

local function toggleButton(button, state)
    if state then
        button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        button.Text = "Desativar " .. button.Text:match("Ativar (.+)")
    else
        button.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        button.Text = "Ativar " .. button.Text:match("Desativar (.+)") or button.Text:match("Ativar (.+)")
    end
end

-- Botões
btnHealth.MouseButton1Click:Connect(function() toggleHealth = not toggleHealth toggleButton(btnHealth, toggleHealth) end)
btnStamina.MouseButton1Click:Connect(function() toggleStamina = not toggleStamina toggleButton(btnStamina, toggleStamina) end)
btnMoney.MouseButton1Click:Connect(function() toggleMoney = not toggleMoney toggleButton(btnMoney, toggleMoney) end)
btnXP.MouseButton1Click:Connect(function() toggleXP = not toggleXP toggleButton(btnXP, toggleXP) end)
btnKill.MouseButton1Click:Connect(function() toggleKill = not toggleKill toggleButton(btnKill, toggleKill) end)
btnGodmode.MouseButton1Click:Connect(function() toggleGodmode = not toggleGodmode toggleButton(btnGodmode, toggleGodmode) end)

-- Loop Principal
task.spawn(function()
    while true do
        task.wait(0.3)

        -- Cura automática
        local humanoid = getHumanoid()
        if toggleHealth and humanoid then
            humanoid.Health = humanoid.MaxHealth
        end

        -- Stamina
        local stamina = getStamina()
        if toggleStamina and stamina then
            stamina.Value = stamina.MaxValue
        end

        -- Dinheiro
        if toggleMoney then
            local leaderstats = getLeaderstats()
            if leaderstats and leaderstats:FindFirstChild("Money") then
                leaderstats.Money.Value += 1000
            end
        end

        -- XP
        if toggleXP then
            local leaderstats = getLeaderstats()
            if leaderstats and leaderstats:FindFirstChild("XP") then
                leaderstats.XP.Value += 500
            end
        end

        -- Auto Kill NPC/Demons/Onis
        if toggleKill then
            for _, enemy in pairs(workspace:GetChildren()) do
                if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("Head") then
                    if enemy.Name:match("Demon") or enemy.Name:match("Oni") then
                        enemy.Humanoid.Health = 0
                    end
                end
            end
        end

        -- Godmode PvE/PvP
        if toggleGodmode and humanoid then
            humanoid.Health = humanoid.MaxHealth -- Imortal contra NPC
            humanoid:SetAttribute("Invincible", true) -- Algumas skills verificam atributo
        end

        -- Godmode contra outros jogadores (Slayers)
        if toggleGodmode then
            for _, other in pairs(game.Players:GetPlayers()) do
                if other ~= player then
                    local ohum = other.Character and other.Character:FindFirstChild("Humanoid")
                    if ohum then
                        -- Apenas evita dano, seu humanoid sempre cheio
                        humanoid.Health = humanoid.MaxHealth
                    end
                end
            end
        end
    end
end)
