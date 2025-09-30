-- Auto Farm Demonfall (baseado no script P e K)
-- Ativar/Desativar com a tecla "L"

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local UserInputService = game:GetService("UserInputService")

-- Coordenadas salvas (do seu script original)
local farmSpots = {
    CFrame.new(7059.66162, 1752.28027, 1347.04773, 0.986482978, 0, 0.163863763, 0, 1, 0, -0.163863763, 0, 0.986482978),
    CFrame.new(716.606628, 755.253113, -2310.99023, -0.727340341, 0, 0.686276913, 0, 1, 0, -0.686276913, 0, -0.727340341)
}

-- Variável de controle
local farming = false

-- Função de ataque básico (simula clique do mouse)
local function atacar()
    local VirtualUser = game:GetService("VirtualUser")
    VirtualUser:ClickButton1(Vector2.new())
end

-- Função do Auto Farm
local function autoFarm()
    while farming do
        for _, spot in ipairs(farmSpots) do
            if not farming then break end
            
            -- Atualiza personagem e rootPart
            character = player.Character or player.CharacterAdded:Wait()
            rootPart = character:WaitForChild("HumanoidRootPart")
            
            -- Teleporta
            rootPart.CFrame = spot
            task.wait(1)
            
            -- Ataca inimigos por alguns segundos
            for i = 1, 5 do
                if not farming then break end
                atacar()
                task.wait(0.5)
            end
        end
    end
end

-- Ativar/Desativar com tecla "L"
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.L then
        farming = not farming
        if farming then
            print("Auto Farm ATIVADO")
            task.spawn(autoFarm)
        else
            print("Auto Farm DESATIVADO")
        end
    end
end)
