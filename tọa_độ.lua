local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

local function getSafeGuiParent()
    local success, result = pcall(function()
        return gethui and gethui() or CoreGui
    end)
    if success and result then
        return result
    end
    return player:WaitForChild("PlayerGui")
end

local guiParent = getSafeGuiParent()

if guiParent:FindFirstChild("BangToaDoPro") then
    guiParent:FindFirstChild("BangToaDoPro"):Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BangToaDoPro"
screenGui.ResetOnSpawn = false 
screenGui.Parent = guiParent

local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Position = UDim2.new(0, 20, 0, 70)
mainFrame.Size = UDim2.new(0, 320, 0, 45)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainFrame.BackgroundTransparency = 0.2
mainFrame.Active = true
mainFrame.Draggable = true 

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 8)
frameCorner.Parent = mainFrame

local textLabel = Instance.new("TextLabel")
textLabel.Parent = mainFrame
textLabel.Position = UDim2.new(0, 10, 0, 0)
textLabel.Size = UDim2.new(0, 235, 1, 0)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.fromRGB(0, 255, 140)
textLabel.Font = Enum.Font.GothamBold
textLabel.TextSize = 14
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.Text = "Đang khởi động..."

local copyBtn = Instance.new("TextButton")
copyBtn.Parent = mainFrame
copyBtn.Position = UDim2.new(1, -68, 0.5, -14)
copyBtn.Size = UDim2.new(0, 60, 0, 28)
copyBtn.BackgroundColor3 = Color3.fromRGB(45, 130, 255)
copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 12
copyBtn.Text = "Copy"

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = copyBtn

local currentPosString = ""

copyBtn.MouseButton1Click:Connect(function()
    if setclipboard and currentPosString ~= "" then
        setclipboard(currentPosString)
        copyBtn.Text = "Đã chép!"
        copyBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
        task.wait(1)
        copyBtn.Text = "Copy"
        copyBtn.BackgroundColor3 = Color3.fromRGB(45, 130, 255)
    end
end)

RunService.RenderStepped:Connect(function()
    local character = player.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")

    if rootPart then
        local pos = rootPart.Position
        textLabel.Text = string.format("X: %.1f | Y: %.1f | Z: %.1f", pos.X, pos.Y, pos.Z)
        currentPosString = string.format("%.1f, %.1f, %.1f", pos.X, pos.Y, pos.Z)
    else
        textLabel.Text = "Đang tải nhân vật..."
    end
end)
