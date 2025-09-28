-- Roblox Hack Menu GUI Script

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local guiService = game:GetService("GuiService")

-- Create the main GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 300)
mainFrame.Position = UDim2.new(0.5, -100, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
mainFrame.BorderSizePixel = 1
mainFrame.Parent = screenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Text = "Hack Menu"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.BackgroundColor3 = Color3.new(0, 0, 0)
titleLabel.TextScaled = true
titleLabel.Parent = mainFrame

-- Infinite Jump Button
local jumpButton = Instance.new("TextButton")
jumpButton.Size = UDim2.new(1, 0, 0, 50)
jumpButton.Position = UDim2.new(0, 0, 0, 50)
jumpButton.Text = "Infinite Jump"
jumpButton.TextColor3 = Color3.new(1, 1, 1)
jumpButton.BackgroundColor3 = Color3.new(0, 0, 0)
jumpButton.TextScaled = true
jumpButton.Parent = mainFrame

jumpButton.MouseButton1Click:Connect(function()
    local function onJumpRequest(input, gameProcessed)
        if input.KeyCode == Enum.KeyCode.Space and not gameProcessed then
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end

    UserInputService.JumpRequest:Connect(onJumpRequest)
end)

-- Flight Button
local flightButton = Instance.new("TextButton")
flightButton.Size = UDim2.new(1, 0, 0, 50)
flightButton.Position = UDim2.new(0, 0, 0, 100)
flightButton.Text = "Flight"
flightButton.TextColor3 = Color3.new(1, 1, 1)
flightButton.BackgroundColor3 = Color3.new(0, 0, 0)
flightButton.TextScaled = true
flightButton.Parent = mainFrame

flightButton.MouseButton1Click:Connect(function()
    local function onInputBegan(input, gameProcessed)
        if input.KeyCode == Enum.KeyCode.E and not gameProcessed then
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, 50, 0)
            bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            bodyVelocity.Parent = humanoid.RootPart
        end
    end

    local function onInputEnded(input, gameProcessed)
        if input.KeyCode == Enum.KeyCode.E and not gameProcessed then
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local bodyVelocity = humanoid.RootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
        end
    end

    UserInputService.InputBegan:Connect(onInputBegan)
    UserInputService.InputEnded:Connect(onInputEnded)
end)

-- ESP Button
local espButton = Instance.new("TextButton")
espButton.Size = UDim2.new(1, 0, 0, 50)
espButton.Position = UDim2.new(0, 0, 0, 150)
espButton.Text = "ESP"
espButton.TextColor3 = Color3.new(1, 1, 1)
espButton.BackgroundColor3 = Color3.new(0, 0, 0)
espButton.TextScaled = true
espButton.Parent = mainFrame

espButton.MouseButton1Click:Connect(function()
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
end)

-- Hide GUI Button
local hideGuiButton = Instance.new("TextButton")
hideGuiButton.Size = UDim2.new(1, 0, 0, 50)
hideGuiButton.Position = UDim2.new(0, 0, 0, 200)
hideGuiButton.Text = "Hide GUI"
hideGuiButton.TextColor3 = Color3.new(1, 1, 1)
hideGuiButton.BackgroundColor3 = Color3.new(0, 0, 0)
hideGuiButton.TextScaled = true
hideGuiButton.Parent = mainFrame

hideGuiButton.MouseButton1Click:Connect(function()
    guiService.SelectedObject = nil
    for _, screenGui in ipairs(guiService:GetGuiObjectsAtPosition(0, 0)) do
        if screenGui:IsA("ScreenGui") then
            screenGui.Enabled = false
        end
    end
end)
