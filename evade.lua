-- // MENU LƯỚT + BAY + XUYÊN TƯỜNG + TÀNG HÌNH CHO HUB TUẤN LỌ //
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game.Players
local player = Players.LocalPlayer

-- Xóa menu cũ nếu chạy lại nhiều lần
if CoreGui:FindFirstChild("TuanLoEvadeMenu") then
    CoreGui.TuanLoEvadeMenu:Destroy()
end

-- 1. Tạo ScreenGui chính
local EvadeGui = Instance.new("ScreenGui")
EvadeGui.Name = "TuanLoEvadeMenu"
EvadeGui.Parent = CoreGui
EvadeGui.ResetOnSpawn = false

-- 2. Tạo khung nền Menu (Main Frame) - tăng chiều cao để đủ chỗ cho nút mới
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 200, 0, 240)
MainFrame.Position = UDim2.new(0.4, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = EvadeGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Tiêu đề Menu
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -30, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "MENU AN TOÀN & COMBAT"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

-- Nút Thu Gọn (-)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
MinimizeBtn.Position = UDim2.new(1, -28, 0, 3)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 14
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.Parent = MainFrame

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 4)
MinCorner.Parent = MinimizeBtn

-- Hàm tạo nút bấm nhanh gọn
local function CreateToggleButton(name, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.85, 0, 0, 35)
    btn.Position = UDim2.new(0.075, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    btn.Text = name .. ": TẮT"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = MainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    return btn
end

-- Tạo các nút tính năng
local ToggleEvadeBtn = CreateToggleButton("Lướt Phím Z", 40)
local ToggleFlyBtn = CreateToggleButton("Tính Năng Bay", 80)
local ToggleNoclipBtn = CreateToggleButton("Xuyên Tường", 120)
local ToggleInvisBtn = CreateToggleButton("Tàng Hình", 160)

-- // TRẠNG THÁI & LOGIC //
local evadeEnabled = false
local flyEnabled = false
local noclipEnabled = false
local invisEnabled = false
local isMinimized = false

-- Logic Thu Gọn / Mở Rộng
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        ToggleEvadeBtn.Visible = false
        ToggleFlyBtn.Visible = false
        ToggleNoclipBtn.Visible = false
        ToggleInvisBtn.Visible = false
        MainFrame:TweenSize(UDim2.new(0, 200, 0, 30), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        MinimizeBtn.Text = "+"
    else
        MainFrame:TweenSize(UDim2.new(0, 200, 0, 240), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        task.wait(0.1)
        ToggleEvadeBtn.Visible = true
        ToggleFlyBtn.Visible = true
        ToggleNoclipBtn.Visible = true
        ToggleInvisBtn.Visible = true
        MinimizeBtn.Text = "-"
    end
end)

-- 1. Logic Lướt Phím Z
ToggleEvadeBtn.MouseButton1Click:Connect(function()
    evadeEnabled = not evadeEnabled
    ToggleEvadeBtn.BackgroundColor3 = evadeEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
    ToggleEvadeBtn.Text = "Lướt Phím Z: " .. (evadeEnabled and "BẬT" or "TẮT")
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if evadeEnabled and input.KeyCode == Enum.KeyCode.Z then
        local character = player.Character
        if not character then return end
        local root = character:FindFirstChild("HumanoidRootPart")
        if root then
            local targetCFrame = root.CFrame * CFrame.new(0, 0, -25)
            local tween = TweenService:Create(root, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = targetCFrame})
            tween:Play()
        end
    end
end)

-- 2. Logic Bay (Fly)
local bg, bv
ToggleFlyBtn.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    ToggleFlyBtn.BackgroundColor3 = flyEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
    ToggleFlyBtn.Text = "Tính Năng Bay: " .. (flyEnabled and "BẬT" or "TẮT")
    
    local character = player.Character
    if not character then return end
    local root = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    
    if flyEnabled then
        if root and humanoid then
            humanoid.PlatformStand = true
            bg = Instance.new("BodyGyro", root)
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = root.CFrame
            
            bv = Instance.new("BodyVelocity", root)
            bv.velocity = Vector3.new(0, 0.1, 0)
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            
            task.spawn(function()
                while flyEnabled and character and root and humanoid and root.Parent do
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

-- 3. Logic Xuyên Tường (Noclip)
ToggleNoclipBtn.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    ToggleNoclipBtn.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
    ToggleNoclipBtn.Text = "Xuyên Tường: " .. (noclipEnabled and "BẬT" or "TẮT")
end)

RunService.Stepped:Connect(function()
    if noclipEnabled then
        local character = player.Character
        if character then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- 4. Logic Tàng Hình (Invisibility)
ToggleInvisBtn.MouseButton1Click:Connect(function()
    invisEnabled = not invisEnabled
    ToggleInvisBtn.BackgroundColor3 = invisEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
    ToggleInvisBtn.Text = "Tàng Hình: " .. (invisEnabled and "BẬT" or "TẮT")
    
    local character = player.Character
    if character then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Transparency = invisEnabled and 1 or 0
            elseif part:IsA("Decal") then
                part.Transparency = invisEnabled and 1 or 0
            end
            -- Ẩn luôn phụ kiện/tóc/quần áo nếu muốn tàng hình sạch sẽ
            if part:IsA("Accessory") then
                local handle = part:FindFirstChild("Handle")
                if handle then
                    handle.Transparency = invisEnabled and 1 or 0
                end
            end
        end
    end
end)
