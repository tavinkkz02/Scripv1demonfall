-- Join Player Script (Nome ou UserId)
-- Uso exclusivo para testes / ambiente privado

-- Serviços
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local localPlayer = Players.LocalPlayer
if not localPlayer then
	warn("Script deve ser executado em jogo")
	return
end

-- ======================
-- UI
-- ======================
local gui = Instance.new("ScreenGui")
gui.Name = "JoinPlayerGui"
gui.ResetOnSpawn = false
gui.Parent = localPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.35, 0.25)
frame.Position = UDim2.fromScale(0.325, 0.35)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.fromScale(1, 0.25)
title.BackgroundTransparency = 1
title.Text = "Teleportar para Jogador"
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255,255,255)

local input = Instance.new("TextBox", frame)
input.Size = UDim2.fromScale(0.9, 0.25)
input.Position = UDim2.fromScale(0.05, 0.35)
input.PlaceholderText = "Nome ou UserId"
input.Text = ""
input.TextScaled = true
input.ClearTextOnFocus = false
input.BackgroundColor3 = Color3.fromRGB(45,45,45)
input.TextColor3 = Color3.fromRGB(255,255,255)

Instance.new("UICorner", input).CornerRadius = UDim.new(0, 8)

local button = Instance.new("TextButton", frame)
button.Size = UDim2.fromScale(0.9, 0.25)
button.Position = UDim2.fromScale(0.05, 0.65)
button.Text = "Entrar no jogador"
button.TextScaled = true
button.BackgroundColor3 = Color3.fromRGB(0,170,255)
button.TextColor3 = Color3.fromRGB(255,255,255)

Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

-- ======================
-- Funções
-- ======================
local function getUserId(inputText)
	if tonumber(inputText) then
		return tonumber(inputText)
	end

	local success, userId = pcall(function()
		return Players:GetUserIdFromNameAsync(inputText)
	end)

	if success then
		return userId
	end

	return nil
end

-- ======================
-- Ação
-- ======================
button.MouseButton1Click:Connect(function()
	local text = input.Text
	if text == "" then
		warn("Nenhum usuário informado")
		return
	end

	local userId = getUserId(text)
	if not userId then
		warn("Usuário inválido")
		return
	end

	local success, placeId, jobId = pcall(function()
		return TeleportService:GetPlayerPlaceInstanceAsync(userId)
	end)

	if not success or not placeId then
		warn("Não foi possível localizar o jogador")
		return
	end

	if jobId and jobId ~= "" then
		TeleportService:TeleportToPlaceInstance(placeId, jobId, localPlayer)
	else
		TeleportService:Teleport(placeId, localPlayer)
	end
end)

print("[JoinPlayer] Script carregado com sucesso")
