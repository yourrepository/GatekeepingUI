-- Simple Roblox ImGui-style UI Library
local ImGui = {}

-- Create a table to track open windows
ImGui.Windows = {}

-- Helper function to create GUI elements
local function createElement(className, properties)
    local element = Instance.new(className)
    for prop, value in pairs(properties) do
        element[prop] = value
    end
    return element
end

-- Begin a new window
function ImGui:Begin(name, position, size)
    -- Check if the window already exists
    local window = self.Windows[name]
    if not window then
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = name
        screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

        local frame = createElement("Frame", {
            Name = "MainFrame",
            Position = UDim2.new(0, position.X, 0, position.Y),
            Size = UDim2.new(0, size.X, 0, size.Y),
            BackgroundColor3 = Color3.fromRGB(45, 45, 45),
            BorderSizePixel = 0,
        })
        frame.Parent = screenGui

        self.Windows[name] = {
            ScreenGui = screenGui,
            Frame = frame,
            YOffset = 10
        }
    end
    return self.Windows[name].Frame
end

-- End the current window
function ImGui:End(name)
    local window = self.Windows[name]
    if window then
        window.YOffset = 10 -- Reset Y offset for the next frame
    end
end

-- Add a text label to the window
function ImGui:Text(name, text)
    local window = self.Windows[name]
    if window then
        local label = createElement("TextLabel", {
            Size = UDim2.new(1, -20, 0, 20),
            Position = UDim2.new(0, 10, 0, window.YOffset),
            BackgroundTransparency = 1,
            Text = text,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = Enum.Font.SourceSans,
            TextSize = 18,
        })
        label.Parent = window.Frame

        window.YOffset = window.YOffset + 25 -- Update Y offset for next element
    end
end

-- Add a button to the window
function ImGui:Button(name, buttonText, callback)
    local window = self.Windows[name]
    if window then
        local button = createElement("TextButton", {
            Size = UDim2.new(1, -20, 0, 30),
            Position = UDim2.new(0, 10, 0, window.YOffset),
            BackgroundColor3 = Color3.fromRGB(65, 65, 65),
            Text = buttonText,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Font = Enum.Font.SourceSans,
            TextSize = 18,
            AutoButtonColor = false,
        })
        button.Parent = window.Frame

        button.MouseButton1Click:Connect(function()
            if callback then
                callback()
            end
        end)

        window.YOffset = window.YOffset + 35 -- Update Y offset for next element
    end
end

-- Destroy a window
function ImGui:Destroy(name)
    local window = self.Windows[name]
    if window then
        window.ScreenGui:Destroy()
        self.Windows[name] = nil
    end
end

return ImGui
