local ImGui = {}

-- Create a ScreenGui
ImGui.ScreenGui = Instance.new("ScreenGui")
ImGui.ScreenGui.Name = "ImGui"
ImGui.ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Helper function to create UI elements
local function createElement(className, properties)
    local element = Instance.new(className)
    for property, value in pairs(properties) do
        element[property] = value
    end
    return element
end

-- Create a window
function ImGui:CreateWindow(name, position, size)
    local frame = createElement("Frame", {
        Name = name,
        Position = UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset),
        Size = UDim2.new(size.X.Scale, size.X.Offset, size.Y.Scale, size.Y.Offset),
        BackgroundColor3 = Color3.new(0.15, 0.15, 0.15),
        BorderSizePixel = 1,
        BorderColor3 = Color3.new(0, 0, 0),
        Parent = self.ScreenGui
    })

    local titleBar = createElement("TextLabel", {
        Text = name,
        Size = UDim2.new(1, 0, 0, 25),
        BackgroundColor3 = Color3.new(0.2, 0.2, 0.2),
        TextColor3 = Color3.new(1, 1, 1),
        Font = Enum.Font.SourceSans,
        TextSize = 18,
        BorderSizePixel = 0,
        Parent = frame
    })

    return frame
end

-- Create a button
function ImGui:CreateButton(parent, text, position, size, callback)
    local button = createElement("TextButton", {
        Text = text,
        Position = UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset),
        Size = UDim2.new(size.X.Scale, size.X.Offset, size.Y.Scale, size.Y.Offset),
        BackgroundColor3 = Color3.new(0.2, 0.2, 0.2),
        TextColor3 = Color3.new(1, 1, 1),
        Font = Enum.Font.SourceSans,
        TextSize = 16,
        BorderSizePixel = 1,
        BorderColor3 = Color3.new(0, 0, 0),
        Parent = parent
    })

    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)

    return button
end

-- Create a label
function ImGui:CreateLabel(parent, text, position, size)
    local label = createElement("TextLabel", {
        Text = text,
        Position = UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset),
        Size = UDim2.new(size.X.Scale, size.X.Offset, size.Y.Scale, size.Y.Offset),
        BackgroundTransparency = 1,
        TextColor3 = Color3.new(1, 1, 1),
        Font = Enum.Font.SourceSans,
        TextSize = 16,
        Parent = parent
    })

    return label
end

return ImGui
