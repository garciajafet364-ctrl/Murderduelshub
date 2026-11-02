local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local gui = Instance.new("ScreenGui")
gui.Name = "MurderDuelsHub"
gui.ResetOnSpawn = false
gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 230, 0, 190)
frame.Position = UDim2.new(0.5, -115, 0.5, -95)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 27)
frame.Active = true
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 42)
title.BackgroundTransparency = 1
title.Text = "MURDER DUELS HUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 17
title.Parent = frame

local function makeButton(name, y)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.85, 0, 0, 38)
    button.Position = UDim2.new(0.075, 0, 0, y)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 58)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 14
    button.Text = name .. " : OFF"
    button.Parent = frame

    Instance.new("UICorner", button)

    local enabled = false

    button.MouseButton1Click:Connect(function()
        enabled = not enabled
        button.Text = name .. (enabled and " : ON" or " : OFF")
    end)
end

makeButton("Auto Shoot (Demo)", 55)
makeButton("Player ESP (Demo)", 100)

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 25, 0, 25)
close.Position = UDim2.new(1, -30, 0, 5)
close.Text = "X"
close.Parent = frame

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Movimiento táctil y con mouse
local dragging = false
local dragStart, startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement
    ) then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
