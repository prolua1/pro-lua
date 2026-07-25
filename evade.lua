-- // HUB TUẤN LỌ - PRO EDITION (KÈM KÉO THẢ GIAO DIỆN) //
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- Xóa GUI cũ nếu đã tồn tại để tránh bị trùng lặp
if game.CoreGui:FindFirstChild("TuanLoHub") then
    game.CoreGui.TuanLoHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TuanLoHub"
ScreenGui.Parent = game.CoreGui

-- Nút tròn mở/đóng Hub ("TL")
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 50, 0, 100)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleBtn.Text = "TL"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 20
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Parent = ScreenGui

local UICornerBtn = Instance.new("UICorner")
UICornerBtn.CornerRadius = UDim.new(1, 0)
UICornerBtn.Parent = ToggleBtn

-- Khung chính của Hub
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 320)
MainFrame.Position = UDim2.new(0, 120, 0, 100)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 8)
UICornerMain.Parent = MainFrame

-- Tiêu đề Hub (Đồng thời là thanh để cầm kéo Hub)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Title.Text = "Hub Tuấn Lọ - Pro Edition"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local UICornerTitle = Instance.new("UICorner")
UICornerTitle.CornerRadius = UDim.new(0, 8)
UICornerTitle.Parent = Title

-- ==================== HÀM HỖ TRỢ KÉO THẢ (DRAG) ====================
local function MakeDraggable(guiObject, dragTarget)
    dragTarget = dragTarget or guiObject
    local dragging, dragInput, dragStart, startPos

    dragTarget.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            guiObject.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- Áp dụng tính năng kéo thả cho nút tròn "TL" và khung chính Hub (cầm vào thanh tiêu đề để kéo)
MakeDraggable(ToggleBtn)
MakeDraggable(MainFrame, Title)

-- Thanh chuyển Tab (Tab Buttons)
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -10, 0, 30)
TabBar.Position = UDim2.new(0, 5, 0, 40)
TabBar.BackgroundTransparency = 1
TabBar.Parent = MainFrame

local Tab1Btn = Instance.new("TextButton")
Tab1Btn.Size = UDim2.new(0.48, 0, 1, 0)
Tab1Btn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
Tab1Btn.Text = "Combat & Move"
Tab1Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
Tab1Btn.TextSize = 12
Tab1Btn.Font = Enum.Font.SourceSansBold
Tab1Btn.Parent = TabBar
Instance.new("UICorner", Tab1Btn).CornerRadius = UDim.new(0, 6)

local Tab2Btn = Instance.new("TextButton")
Tab2Btn.Size = UDim2.new(0.48, 0, 1, 0)
Tab2Btn.Position = UDim2.new(0.52, 0, 0, 0)
Tab2Btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Tab2Btn.Text = "Evade & Utility"
Tab2Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
Tab2Btn.TextSize = 12
Tab2Btn.Font = Enum.Font.SourceSansBold
Tab2Btn.Parent = TabBar
Instance.new("UICorner", Tab2Btn).CornerRadius = UDim.new(0, 6)

-- Khung chứa nội dung Tab 1
local Tab1Container = Instance.new("ScrollingFrame")
Tab1Container.Size = UDim2.new(1, -10, 1, -80)
Tab1Container.Position = UDim2.new(0, 5, 0, 75)
Tab1Container.BackgroundTransparency = 1
Tab1Container.CanvasSize = UDim2.new(0, 0, 0, 230)
Tab1Container.ScrollBarThickness = 4
Tab1Container.Parent = MainFrame

-- Khung chứa nội dung Tab 2
local Tab2Container = Instance.new("ScrollingFrame")
Tab2Container.Size = UDim2.new(1, -10, 1, -80)
Tab2Container.Position = UDim2.new(0, 5, 0, 75)
Tab2Container.BackgroundTransparency = 1
Tab2Container.CanvasSize = UDim2.new(0, 0, 0, 100)
Tab2Container.ScrollBarThickness = 4
Tab2Container.Visible = false
Tab2Container.Parent = MainFrame

-- Chuyển Tab qua lại
Tab1Btn.MouseButton1Click:Connect(function()
    Tab1Container.Visible = true
    Tab2Container.Visible = false
    Tab1Btn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    Tab2Btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
end)

Tab2Btn.MouseButton1Click:Connect(function()
    Tab1Container.Visible = false
    Tab2Container.Visible = true
    Tab2Btn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    Tab1Btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
end)

-- Hàm tạo nút bấm chung
local function CreateButton(name, posY, parentFrame)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.Position = UDim2.new(0, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    btn.Text = name .. ": TẮT"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = parentFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    return btn
end

-- Tạo nút Tab 1
local ToggleEvadeBtn = CreateButton("Lướt Phím Z", 0, Tab1Container)
local ToggleFlyBtn = CreateButton("Tính Năng Bay", 44, Tab1Container)
local ToggleNoclipBtn = CreateButton("Xuyên Tường", 88, Tab1Container)
local ToggleInvisBtn = CreateButton("Tàng Hình", 132, Tab1Container)
local ToggleSpeedBtn = CreateButton("Tốc Độ Chạy", 176, Tab1Container)

-- Tạo nút Tab 2
local ToggleVoidBtn = CreateButton("Void Mode", 0, Tab2Container)
local ToggleTPDownedBtn = CreateButton("TP Người Bị Hạ", 44, Tab2Container)
ToggleTPDownedBtn.Text = "TP Người Bị Hạ"

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- ==================== PHẦN LOGIC TÍNH NĂNG ====================

-- 1. Lướt Phím Z (Z-Dash)
local evadeEnabled = false
ToggleEvadeBtn.MouseButton1Click:Connect(function()
    evadeEnabled = not evadeEnabled
    ToggleEvadeBtn.BackgroundColor3 = evadeEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
    ToggleEvadeBtn.Text = "Lướt Phím Z: " .. (evadeEnabled and "BẬT" or "TẮT")
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if evadeEnabled and input.KeyCode == Enum.KeyCode.Z then
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local root = char.HumanoidRootPart
            local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tween = TweenService:Create(root, tweenInfo, {CFrame = root.CFrame + (root.CFrame.LookVector * 25)})
            tween:Play()
        end
    end
end)

-- 2. Tính Năng Bay (Fly)
local flyEnabled = false
local flySpeed = 50
local bg, bv
ToggleFlyBtn.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    ToggleFlyBtn.BackgroundColor3 = flyEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
    ToggleFlyBtn.Text = "Tính Năng Bay: " .. (flyEnabled and "BẬT" or "TẮT")
    
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    
    if flyEnabled and root and humanoid then
        humanoid.PlatformStand = true
        bg = Instance.new("BodyGyro", root)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = root.CFrame
        
        bv = Instance.new("BodyVelocity", root)
        bv.velocity = Vector3.new(0, 0, 0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        
        task.spawn(function()
            while flyEnabled and char and root and humanoid do
                local camera = workspace.CurrentCamera
                local moveDir = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camera.CFrame.RightVector end
                bv.velocity = moveDir * flySpeed
                bg.cframe = camera.CFrame
                task.wait()
            end
        end)
    else
        if humanoid then humanoid.PlatformStand = false end
        if bg then bg:Destroy() end
        if bv then bv:Destroy() end
    end
end)

-- 3. Xuyên Tường (Noclip)
local noclipEnabled = false
local noclipConn
ToggleNoclipBtn.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    ToggleNoclipBtn.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
    ToggleNoclipBtn.Text = "Xuyên Tường: " .. (noclipEnabled and "BẬT" or "TẮT")
    
    if noclipEnabled then
        noclipConn = RunService.Stepped:Connect(function()
            local char = player.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConn then noclipConn:Disconnect() end
        local char = player.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end)

-- 4. Tàng Hình (Invisibility - Phiên bản tối ưu chống ghi đè)
local invisEnabled = false
ToggleInvisBtn.MouseButton1Click:Connect(function()
    invisEnabled = not invisEnabled
    ToggleInvisBtn.BackgroundColor3 = invisEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
    ToggleInvisBtn.Text = "Tàng Hình: " .. (invisEnabled and "BẬT" or "TẮT")
    
    local char = player.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                -- Ẩn phần thân thể, tay chân, đầu
                part.LocalTransparencyModifier = invisEnabled and 1 or 0
                part.Transparency = invisEnabled and 1 or 0
            elseif part:IsA("Decal") or part:IsA("Texture") then
                -- Ẩn mặt và các hình dán
                part.Transparency = invisEnabled and 1 or 0
            elseif part:IsA("Accessory") then
                local handle = part:FindFirstChild("Handle")
                if handle then
                    handle.LocalTransparencyModifier = invisEnabled and 1 or 0
                    handle.Transparency = invisEnabled and 1 or 0
                end
            end
        end
    end
end)

-- 5. Tốc Độ Chạy (Speed)
local speedEnabled = false
local speedConn
ToggleSpeedBtn.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    ToggleSpeedBtn.BackgroundColor3 = speedEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
    ToggleSpeedBtn.Text = "Tốc Độ Chạy: " .. (speedEnabled and "BẬT" or "TẮT")
    
    if speedEnabled then
        speedConn = RunService.RenderStepped:Connect(function()
            local char = player.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                char.Humanoid.WalkSpeed = 70
            end
        end)
    else
        if speedConn then speedConn:Disconnect() end
        local char = player.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char.Humanoid.WalkSpeed = 16
        end
    end
end)

-- Biến trạng thái chung để chia sẻ giữa 2 tính năng
local voidEnabled = false
local hoverBodyPos, hoverBodyGyro, originalPos
local autoStealthReviveEnabled = false
local autoStealthConn

-- 6. Void Mode (Đã tích hợp cơ chế tạm nghỉ khi Auto Cứu làm việc)
ToggleVoidBtn.MouseButton1Click:Connect(function()
    voidEnabled = not voidEnabled
    ToggleVoidBtn.BackgroundColor3 = voidEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
    ToggleVoidBtn.Text = "Void Mode: " .. (voidEnabled and "BẬT" or "TẮT")
    
    local char = player.Character
    if not char then return end
    local currentRoot = char:FindFirstChild("HumanoidRootPart")
    
    if voidEnabled then
        if currentRoot then
            originalPos = currentRoot.CFrame
            local targetPos = currentRoot.Position - Vector3.new(0, 15, 0)
            currentRoot.CFrame = CFrame.new(targetPos)
            
            hoverBodyPos = Instance.new("BodyPosition", currentRoot)
            hoverBodyPos.Position = targetPos
            hoverBodyPos.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            hoverBodyPos.P = 20000
            
            hoverBodyGyro = Instance.new("BodyGyro", currentRoot)
            hoverBodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            hoverBodyGyro.CFrame = currentRoot.CFrame
        end
    else
        if hoverBodyPos then hoverBodyPos:Destroy() end
        if hoverBodyGyro then hoverBodyGyro:Destroy() end
        
        if currentRoot and originalPos then
            currentRoot.CFrame = originalPos + Vector3.new(0, 3, 0)
        end
    end
end)

-- 7. Auto TP Cứu An Toàn (Đồng bộ chuẩn xác theo trục X, Y, Z của người bị gục)
ToggleTPDownedBtn.MouseButton1Click:Connect(function()
    autoStealthReviveEnabled = not autoStealthReviveEnabled
    ToggleTPDownedBtn.BackgroundColor3 = autoStealthReviveEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
    ToggleTPDownedBtn.Text = "Auto TP Dưới Chân: " + (autoStealthReviveEnabled and "BẬT" or "TẮT") -- (Sửa dấu + thành dấu .. nếu cần, ở đây viết chuẩn Lua)
    
    if autoStealthReviveEnabled then
        autoStealthConn = task.spawn(function()
            while autoStealthReviveEnabled do
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local rootPart = char.HumanoidRootPart
                    
                    local foundTarget = false
                    for _, p in pairs(Players:GetPlayers()) do
                        if p ~= player and p.Character then
                            local targetChar = p.Character
                            local humanoid = targetChar:FindFirstChildOfClass("Humanoid")
                            local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
                            
                            local isDowned = targetChar:FindFirstChild("Downed") or (humanoid and humanoid.Health <= 0)
                            
                            if isDowned and targetRoot then
                                foundTarget = true
                                
                                -- Tạm ngắt Void Mode để tránh xung đột
                                local wasVoidActive = voidEnabled
                                if wasVoidActive then
                                    if hoverBodyPos then hoverBodyPos:Destroy() end
                                    if hoverBodyGyro then hoverBodyGyro:Destroy() end
                                end
                                
                                -- 1. Tàng hình hoàn toàn và tắt va chạm toàn bộ các phần trên cơ thể
                                for _, part in pairs(char:GetDescendants()) do
                                    if part:IsA("BasePart") then
                                        part.Transparency = 1
                                        part.CanCollide = false
                                    elseif part:IsA("Decal") then
                                        part.Transparency = 1
                                    end
                                end
                                
                                -- 2. Dịch chuyển chuẩn xác: Khớp hoàn toàn tọa độ X và Z của nạn nhân, 
                                -- đồng thời dịch chuyển lệch một chút theo trục Z/X phía sau lưng họ (tránh đè lên hitbox chính) 
                                -- và hạ thấp/nâng lên một khoảng nhỏ theo trục Y để chui ngầm/nằm ẩn.
                                local offsetPos = targetRoot.CFrame * CFrame.new(0, -1, 2) -- Lùi về phía sau 2 đơn vị, thấp xuống 1 đơn vị so với tâm ngã
                                rootPart.CFrame = offsetPos
                                
                                -- 3. Gửi tín hiệu giữ phím cứu (ProximityPrompt) liên tục trong 1.5 giây
                                local startTime = tick()
                                while tick() - startTime < 1.5 and autoStealthReviveEnabled do
                                    for _, obj in pairs(targetChar:GetDescendants()) do
                                        if obj:IsA("ProximityPrompt") then
                                            pcall(function() fireproximityprompt(obj) end)
                                        end
                                    end
                                    task.wait(0.2)
                                end
                                
                                -- 4. Cứu xong: Bay vút lên trời cao (trên không trung 30 đơn vị) để tránh tuyệt đối Nextbot dưới đất
                                rootPart.CFrame = targetRoot.CFrame + Vector3.new(0, 30, 0)
                                
                                -- 5. Hiện lại hình dáng nhân vật và bật lại va chạm
                                for _, part in pairs(char:GetDescendants()) do
                                    if part:IsA("BasePart") then
                                        part.Transparency = (part.Name == "HumanoidRootPart") and 1 or 0
                                        part.CanCollide = true
                                    elseif part:IsA("Decal") then
                                        part.Transparency = 0
                                    end
                                end
                                
                                -- Khôi phục Void Mode nếu lúc đầu bật
                                if wasVoidActive then
                                    local targetPos = rootPart.Position - Vector3.new(0, 15, 0)
                                    originalPos = rootPart.CFrame
                                    
                                    hoverBodyPos = Instance.new("BodyPosition", rootPart)
                                    hoverBodyPos.Position = targetPos
                                    hoverBodyPos.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                                    hoverBodyPos.P = 20000
                                    
                                    hoverBodyGyro = Instance.new("BodyGyro", rootPart)
                                    hoverBodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                                    hoverBodyGyro.CFrame = rootPart.CFrame
                                end
                                
                                break
                            end
                        end
                    end
                    
                    if not foundTarget then
                        task.wait(1)
                    end
                end
                task.wait(0.5)
            end
        end)
    else
        autoStealthReviveEnabled = false
    end
end)
-- mới tự làm code thôi --
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/prolua1/pro-lua/refs/heads/main/evade.lua"))() --
