local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

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
