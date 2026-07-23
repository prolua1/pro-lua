-- // HUB TUẤN LỌ - COMBAT & AN TOÀN //
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game.Players
local player = Players.LocalPlayer

-- Xóa menu cũ nếu chạy lại nhiều lần
if CoreGui:FindFirstChild("TuanLoHub") then
    CoreGui.TuanLoHub:Destroy()
end

-- 1. Tạo ScreenGui chính
local HubGui = Instance.new("ScreenGui")
HubGui.Name = "TuanLoHub"
HubGui.Parent = CoreGui
HubGui.ResetOnSpawn = false

-- 2. Nút tròn mở/tắt Hub ngoài màn hình
local CircleBtn = Instance.new("TextButton")
CircleBtn.Name = "CircleButton"
CircleBtn.Size = UDim2.new(0, 50, 0, 50)
CircleBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
CircleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
CircleBtn.Text = "TL"
CircleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CircleBtn.TextSize = 16
CircleBtn.Font = Enum.Font.SourceSansBold
CircleBtn.Draggable = true
CircleBtn.Parent = HubGui

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = CircleBtn

local CircleStroke = Instance.new("UIStroke")
CircleStroke.Color = Color3.fromRGB(0, 170, 255)
CircleStroke.Thickness = 2
CircleStroke.Parent = CircleBtn

-- 3. Khung Menu Chính (Main Frame) - Thu gọn kích thước vừa đủ chứa các nút tính năng
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 280)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = HubGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Tiêu đề Hub
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -30, 0, 35)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "MENU AN TOÀN & COMBAT"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 12
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

-- Nút Thu Gọn (-)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 26, 0, 26)
MinimizeBtn.Position = UDim2.new(1, -32, 0, 4)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 14
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.Parent = MainFrame

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 4)
MinCorner.Parent = MinimizeBtn

-- Logic Nút Tròn Bật/Tắt Toàn Bộ Hub
local isOpen = true
CircleBtn.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    MainFrame.Visible = isOpen
    CircleStroke.Color = isOpen and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(255, 0, 0)
end)

MinimizeBtn.MouseButton1Click:Connect(function()
    isOpen = false
    MainFrame.Visible = false
    CircleStroke.Color = Color3.fromRGB(255, 0, 0)
end)

-- // KHUNG CHỨA CÁC NÚT TÍNH NĂNG COMBAT //
local CombatHolder = Instance.new("Frame")
CombatHolder.Size = UDim2.new(1, -20, 0, 225)
CombatHolder.Position = UDim2.new(0, 10, 0, 45)
CombatHolder.BackgroundTransparency = 1
CombatHolder.Parent = MainFrame

local function CreateToggleButton(name, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.Position = UDim2.new(0, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    btn.Text = name .. ": TẮT"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = CombatHolder

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    return btn
end

local ToggleEvadeBtn = CreateToggleButton("Lướt Phím Z", 0)
local ToggleFlyBtn = CreateToggleButton("Tính Năng Bay", 44)
local ToggleNoclipBtn = CreateToggleButton("Xuyên Tường", 88)
local ToggleInvisBtn = CreateToggleButton("Tàng Hình", 132)
local ToggleSpeedBtn = CreateToggleButton("Tốc Độ Chạy", 176)

-- // LOGIC TÍNH NĂNG COMBAT & AN TOÀN //
local evadeEnabled = false
local flyEnabled = false
local noclipEnabled = false
local invisEnabled = false
local speedEnabled = false

-- 1. Lướt phím Z
ToggleEvadeBtn.MouseButton1Click:Connect(function()
    evadeEnabled = not evadeEnabled
    ToggleEvadeBtn.BackgroundColor3 = evadeEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
    ToggleEvadeBtn.Text = "Lướt Phím Z: " .. (evadeEnabled and "BẬT" or "TẮT")
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if evadeEnabled and input.KeyCode == Enum.KeyCode.Z then
        local currentRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if currentRoot then
            local targetCFrame = currentRoot.CFrame * CFrame.new(0, 0, -25)
            local tween = TweenService:Create(currentRoot, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = targetCFrame})
            tween:Play()
        end
    end
end)

-- 2. Bay
local bg, bv
ToggleFlyBtn.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    ToggleFlyBtn.BackgroundColor3 = flyEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
    ToggleFlyBtn.Text = "Tính Năng Bay: " .. (flyEnabled and "BẬT" or "TẮT")
    
    local char = player.Character
    if not char then return end
    local currentRoot = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    
    if flyEnabled then
        if currentRoot and humanoid then
            humanoid.PlatformStand = true
            bg = Instance.new("BodyGyro", currentRoot)
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = currentRoot.CFrame
            
            bv = Instance.new("BodyVelocity", currentRoot)
            bv.velocity = Vector3.new(0, 0.1, 0)
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            
            task.spawn(function()
                while flyEnabled and char and currentRoot and humanoid and currentRoot.Parent do
                    local camera = workspace.CurrentCamera
                    local moveDir = Vector3.new()
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camera.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camera.CFrame.RightVector end
                    bv.velocity = moveDir * 80
                    bg.cframe = camera.CFrame
                    task.wait()
                end
            end)
        end
    else
        if humanoid then humanoid.PlatformStand = false end
        if bg then bg:Destroy() end
        if bv then bv:Destroy() end
    end
end)

-- 3. Xuyên tường
ToggleNoclipBtn.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    ToggleNoclipBtn.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
    ToggleNoclipBtn.Text = "Xuyên Tường: " .. (noclipEnabled and "BẬT" or "TẮT")
end)

RunService.Stepped:Connect(function()
    if noclipEnabled then
        local char = player.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- 4. Tàng hình
ToggleInvisBtn.MouseButton1Click:Connect(function()
    invisEnabled = not invisEnabled
    ToggleInvisBtn.BackgroundColor3 = invisEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
    ToggleInvisBtn.Text = "Tàng Hình: " .. (invisEnabled and "BẬT" or "TẮT")
    
    local char = player.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Transparency = invisEnabled and 1 or 0
            elseif part:IsA("Decal") then
                part.Transparency = invisEnabled and 1 or 0
            end
            if part:IsA("Accessory") then
                local handle = part:FindFirstChild("Handle")
                if handle then handle.Transparency = invisEnabled and 1 or 0 end
            end
        end
    end
end)

-- 5. Tốc độ chạy
ToggleSpeedBtn.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    ToggleSpeedBtn.BackgroundColor3 = speedEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
    ToggleSpeedBtn.Text = "Tốc Độ Chạy: " .. (speedEnabled and "BẬT" or "TẮT")
end)

RunService.RenderStepped:Connect(function()
    if speedEnabled then
        local char = player.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid.WalkSpeed = 120 end
        end
    end
end)
-- mới tự làm code thôi --
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/prolua1/pro-lua/refs/heads/main/evade.lua"))() --
