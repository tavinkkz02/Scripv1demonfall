-- Demonfall Script Menu v1
-- Autor: tavinkkz02
-- AVISO: Use por sua conta e risco!
-- Discord: tavinkkz02

-- Estados
local scriptEnabled = true
local autoMoney = false
local autoXP = false
local autoItem = false
local godMode = false

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DemonfallScriptMenu"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 320, 0, 260)
Frame.Position = UDim2.new(0.5, -160, 0.5, -130)
Frame.BackgroundColor3 = Color3.fromRGB(33,33,33)
Frame.BorderSizePixel = 0
Frame.Visible = true
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "Demonfall Script Menu"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Parent = Frame

local function addButton(text, y, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 36)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(44,44,44)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansSemibold
    btn.TextSize = 20
    btn.Text = text
    btn.Parent = Frame
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local autoMoneyBtn = addButton("Ativar Auto Money [OFF]", 50, function()
    autoMoney = not autoMoney
    autoMoneyBtn.Text = "Ativar Auto Money ["..(autoMoney and "ON" or "OFF").."]"
end)
local autoXPBtn = addButton("Ativar Auto Farm XP [OFF]", 90, function()
    autoXP = not autoXP
    autoXPBtn.Text = "Ativar Auto Farm XP ["..(autoXP and "ON" or "OFF").."]"
end)
local autoItemBtn = addButton("Ativar Auto Farm Itens [OFF]", 130, function()
    autoItem = not autoItem
    autoItemBtn.Text = "Ativar Auto Farm Itens ["..(autoItem and "ON" or "OFF").."]"
end)
local godModeBtn = addButton("Ativar GodMode [OFF]", 170, function()
    godMode = not godMode
    godModeBtn.Text = "Ativar GodMode ["..(godMode and "ON" or "OFF").."]"
end)

local closeBtn = addButton("Minimizar Menu", 210, function()
    Frame.Visible = false
end)

-- Hotkey F5 para abrir/minimizar
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.F5 then
        Frame.Visible = not Frame.Visible
    end
end)

-- Funções principais (ADAPTE para Demonfall se necessário)
spawn(function()
    while true do
        if autoMoney and scriptEnabled then
            -- Exemplo fictício, adapte para Demonfall!
            -- game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer("AddMoney", 1000)
        end
        wait(1)
    end
end)

spawn(function()
    while true do
        if autoXP and scriptEnabled then
            for _, mob in pairs(workspace:GetChildren()) do
                if mob.Name == "Oni" or mob.Name == "Demon" then
                    if mob:FindFirstChild("HumanoidRootPart") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,2,0)
                        -- Simule ataque (adapte para método correto)
                        for i=1,5 do
                            -- game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Attack", mob)
                            wait(0.2)
                        end
                        wait(1)
                    end
                end
            end
        end
        wait(2)
    end
end)

spawn(function()
    local items = {
        "Chifre de Demônio", "Copo de cobre", "Anel Dourado",
        "Jarra de prata", "Coroa de ouro", "Jarra de bronze"
    }
    while true do
        if autoItem and scriptEnabled then
            for _, obj in pairs(workspace:GetDescendants()) do
                if table.find(items, obj.Name) then
                    if obj:IsA("Tool") or obj:IsA("Part") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                        wait(0.5)
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 0)
                        wait(0.5)
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 1)
                    end
                end
            end
        end
        wait(3)
    end
end)

spawn(function()
    while true do
        if godMode and scriptEnabled then
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.Health = char.Humanoid.MaxHealth
            end
        end
        wait(1)
    end
end)

-- FIM
