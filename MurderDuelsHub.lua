
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "MurderDuelsHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(250, 205)
frame.Position = UDim2.new(0.5, -125, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextButton")
title.Size = UDim2.new(1, 0, 0, 42)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
title.Text = "MURDER DUELS HUB  -  MOVE"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 14
title.Parent = frame

local function button(name, y)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.88, 0, 0, 38)
    b.Position = UDim2.new(0.06, 0, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.TextSize = 14
    b.Text = name .. " : OFF"
    b.Parent = frame

    Instance.new("UICorner", b)

    local active = false
    b.MouseButton1Click:Connect(function()
        active = not active
        b.Text = name .. (active and " : ON" or " : OFF")
        b.BackgroundColor3 = active
            and Color3.fromRGB(30, 115, 75)
            or Color3.fromRGB(45, 45, 60)
    end)
end

button("Auto Shoot (Demo)", 55)
button("Player ESP (Demo)", 100)

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.new(0.4, 0, 0, 30)
minimize.Position = UDim2.new(0.06, 0, 0, 150)
minimize.Text = "MINIMIZE"
minimize.Parent = frame

local close = Instance.new("TextButton")
close.Size = UDim2.new(0.4, 0, 0, 30)
close.Position = UDim2.new(0.54, 0, 0, 150)
close.Text = "CLOSE"
close.Parent = frame

minimize.MouseButton1Click:Connect(function()
    for _, v in ipairs(frame:GetChildren()) do
        if v ~= title then
            v.Visible = not v.Visible
        end
    end
end)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Arrastrar desde la barra superior
local dragging = false
local startPos
local startInput

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        startInput = input.Position
        startPos = frame.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement
    ) then
        local delta = input.Position - startInput
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
