local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local function createESP(player)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player.PlayerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 100, 0, 20)
    frame.Position = UDim2.new(0.5, -50, 0.5, -10)
    frame.BackgroundColor3 = Color3.new(1, 0, 0)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Text = player.Name
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.BackgroundTransparency = 1
    textLabel.Parent = frame

    local function updateESP()
        while player.Character and player.Character:FindFirstChild("HumanoidRootPart") do
            local rootPart = player.Character.HumanoidRootPart
            local screenPosition, onScreen = workspace.CurrentCamera:WorldToScreenPoint(rootPart.Position)
            if onScreen then
                frame.Position = UDim2.new(0, screenPosition.X - 50, 0, screenPosition.Y - 10)
            end
            RunService.RenderStepped:Wait()
        end
    end

    coroutine.wrap(updateESP)()
end

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= Players.LocalPlayer then
        createESP(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    if player ~= Players.LocalPlayer then
        createESP(player)
    end
end)
