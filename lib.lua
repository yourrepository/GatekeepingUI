-- Simple Roblox ImGui Styled UI Library
local ImGui = {}

-- Create a new ScreenGui
function ImGui:CreateScreenGui()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ImGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    return screenGui
end

-- Create a draggable frame
function ImGui:CreateWindow(name, position, size)
    local window = Instance.new("Frame")
    window.Name = name or "Window"
    window.Size = size or UDim2.new(0, 300, 0, 200)
    window.Position = position or UDim2.new(0.5, -150, 0.5, -100)
    window.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    window.BorderSizePixel = 0
    window.AnchorPoint = Vector2.new(0.5, 0.5)

    -- Draggable header
    local header = Instance.new("TextLabel")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 25)
    header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    header.Text = name or "Window"
    header.TextColor3 = Color3.new(1, 1, 1)
    header.Font = Enum.Font.SourceSans
    header.TextSize = 18
    header.BorderSizePixel = 0
    header.Parent = window

    -- Enable dragging
    local dragging = false
    local dragStart, startPos

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = window.Position
        end
    end)

    header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            window.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    return window
end

-- Create a button
function ImGui:CreateButton(parent, text, position, size, callback)
    local button = Instance.new("TextButton")
    button.Size = size or UDim2.new(0, 100, 0, 30)
    button.Position = position or UDim2.new(0, 10, 0, 10)
    button.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    button.Text = text or "Button"
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 16
    button.BorderSizePixel = 0
    button.Parent = parent

    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)

    return button
end

-- Create a label
function ImGui:CreateLabel(parent, text, position, size)
    local label = Instance.new("TextLabel")
    label.Size = size or UDim2.new(0, 200, 0, 30)
    label.Position = position or UDim2.new(0, 10, 0, 50)
    label.BackgroundTransparency = 1
    label.Text = text or "Label"
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 16
    label.Parent = parent

    return label
end

-- Example usage
local gui = ImGui:CreateScreenGui()
local window = ImGui:CreateWindow("Example Window")
window.Parent = gui

ImGui:CreateButton(window, "Click Me", UDim2.new(0, 10, 0, 40), UDim2.new(0, 100, 0, 30), function()
    print("Button clicked!")
end)

ImGui:CreateLabel(window, "Hello, ImGui!", UDim2.new(0, 10, 0, 80))

return ImGui
