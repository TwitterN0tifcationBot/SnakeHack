local Players = game:GetService("Players")
local player = Players.LocalPlayer
local guiService = game:GetService("GuiService")

local function hideGui()
    guiService.SelectedObject = nil
    for _, screenGui in ipairs(guiService:GetGuiObjectsAtPosition(0, 0)) do
        if screenGui:IsA("ScreenGui") then
            screenGui.Enabled = false
        end
    end
end

local function showGui()
    for _, screenGui in ipairs(guiService:GetGuiObjectsAtPosition(0, 0)) do
        if screenGui:IsA("ScreenGui") then
            screenGui.Enabled = true
        end
    end
end

-- Toggle GUI visibility with a key press (e.g., 'H' key)
local UserInputService = game:GetService("UserInputService")

local function onInputBegan(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.H and not gameProcessed then
        if guiService.SelectedObject then
            showGui()
        else
            hideGui()
        end
    end
end

UserInputService.InputBegan:Connect(onInputBegan)
