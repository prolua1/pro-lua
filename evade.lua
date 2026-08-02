-- // HUB TUẤN LỌ - PRO EDITION (FULL TÍNH NĂNG + VOID AFK THÔNG MINH) //
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

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
MainFrame.Size = UDim2.new(0, 260, 0, 370)
MainFrame.Position = UDim2.new(0, 120, 0, 100)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 8)
UICornerMain.Parent = MainFrame

-- Tiêu đề Hub
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
    local dragging, dragStart, startPos

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

MakeDraggable(ToggleBtn)
MakeDraggable(MainFrame, Title)

-- Thanh chuyển Tab
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
Tab1Container.CanvasSize = UDim2.new(0, 0, 0, 280)
Tab1Container.ScrollBarThickness = 4
Tab1Container.Parent = MainFrame

-- Khung chứa nội dung Tab 2
local Tab2Container = Instance.new("ScrollingFrame")
Tab2Container.Size = UDim2.new(1, -10, 1, -80)
Tab2Container.Position = UDim2.new(0, 5, 0, 75)
Tab2Container.BackgroundTransparency = 1
Tab2Container.CanvasSize = UDim2.new(0, 0, 0, 150)
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
local ToggleSummerBtn = CreateButton("Lụm Điểm Mùa Hè", 220, Tab1Container)

-- Tạo nút Tab 2
local ToggleVoidBtn = CreateButton("Void Mode", 0, Tab2Container)
local ToggleTPDownedBtn = CreateButton("TP Người Bị Hạ", 44, Tab2Container)
local ToggleDodgeNetbotBtn = CreateButton("Auto Né Netbot", 88, Tab2Container)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- ==================== PHẦN LOGIC TÍNH NĂNG ====================

-- 1. Lướt Phím Z
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

-- 2. Tính Năng Bay
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

-- 3. Xuyên Tường
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

-- 4. Tàng Hình
local invisEnabled = false
ToggleInvisBtn.MouseButton1Click:Connect(function()
    invisEnabled = not invisEnabled
    ToggleInvisBtn.BackgroundColor3 = invisEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
    ToggleInvisBtn.Text = "Tàng Hình: " .. (invisEnabled and "BẬT" or "TẮT")
    
    local char = player.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.LocalTransparencyModifier = invisEnabled and 1 or 0
                part.Transparency = invisEnabled and 1 or 0
            elseif part:IsA("Decal") or part:IsA("Texture") then
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

-- 5. Tốc Độ Chạy
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

-- 6. Lụm Điểm Mùa Hè
local summerEnabled = false
local summerConn
ToggleSummerBtn.MouseButton1Click:Connect(function()
    summerEnabled = not summerEnabled
    ToggleSummerBtn.BackgroundColor3 = summerEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
    ToggleSummerBtn.Text = "Lụm Điểm Mùa Hè: " .. (summerEnabled and "BẬT" or "TẮT")
    
    if summerEnabled then
        summerConn = task.spawn(function()
            while summerEnabled do
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local rootPart = char.HumanoidRootPart
                    local foundAny = false
                    
                    for _, obj in pairs(Workspace:GetDescendants()) do
                        if not summerEnabled then break end
                        
                        local targetPart = nil
                        if obj:IsA("BasePart") then
                            targetPart = obj
                        elseif obj:IsA("Model") then
                            targetPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                        end
                        
                        if targetPart then
                            local nameLower = string.lower(obj.Name)
                            if string.find(nameLower, "summer") or string.find(nameLower, "point") or string.find(nameLower, "token") or string.find(nameLower, "coin") or string.find(nameLower, "item") then
                                foundAny = true
                                rootPart.CFrame = targetPart.CFrame + Vector3.new(0, 1, 0)
                                
                                for _, prompt in pairs(obj:GetDescendants()) do
                                    if prompt:IsA("ProximityPrompt") then
                                        pcall(function() fireproximityprompt(prompt) end)
                                    end
                                end
                                task.wait(0.25)
                            end
                        end
                    end
                    
                    if not foundAny then
                        task.wait(1)
                    end
                end
                task.wait(0.2)
            end
        end)
    else
        summerEnabled = false
    end
end)

-- Biến trạng thái chung Void Mode & Auto Re-apply khi đổi map/respawn
local voidEnabled = false
local hoverBodyPos, hoverBodyGyro, originalPos
local respawnVoidConn

local function ApplyVoidMode()
    local char = player.Character
    if not char then return end
    local currentRoot = char:WaitForChild("HumanoidRootPart", 5)
    
    if voidEnabled and currentRoot then
        task.wait(0.5) -- Chờ map load ổn định
        originalPos = currentRoot.CFrame
        -- Tăng độ sâu xuống -35 studs (lòng đất cực kỳ sâu và an toàn)
        local targetPos = currentRoot.Position - Vector3.new(0, 45, 0)
        currentRoot.CFrame = CFrame.new(targetPos)
        
        if hoverBodyPos then hoverBodyPos:Destroy() end
        if hoverBodyGyro then hoverBodyGyro:Destroy() end
        
        hoverBodyPos = Instance.new("BodyPosition", currentRoot)
        hoverBodyPos.Position = targetPos
        hoverBodyPos.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        hoverBodyPos.P = 20000
        
        hoverBodyGyro = Instance.new("BodyGyro", currentRoot)
        hoverBodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        hoverBodyGyro.CFrame = currentRoot.CFrame
    end
end

-- 7. Void Mode (Tăng độ sâu -35 và tự động bật lại khi qua map mới)
ToggleVoidBtn.MouseButton1Click:Connect(function()
    voidEnabled = not voidEnabled
    ToggleVoidBtn.BackgroundColor3 = voidEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
    ToggleVoidBtn.Text = "Void Mode: " .. (voidEnabled and "BẬT" or "TẮT")
    
    if voidEnabled then
        ApplyVoidMode()
        -- Lắng nghe sự kiện đổi map / hồi sinh để tự động kéo xuống Void lại cho AFK
        if not respawnVoidConn then
            respawnVoidConn = player.CharacterAdded:Connect(function()
                if voidEnabled then
                    task.defer(ApplyVoidMode)
                end
            end)
        end
    else
        if hoverBodyPos then hoverBodyPos:Destroy() end
        if hoverBodyGyro then hoverBodyGyro:Destroy() end
        
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") and originalPos then
            char.HumanoidRootPart.CFrame = originalPos + Vector3.new(0, 3, 0)
        end
        if respawnVoidConn then
            respawnVoidConn:Disconnect()
            respawnVoidConn = nil
        end
    end
end)

-- 8. Auto TP Cứu
local autoStealthReviveEnabled = false
local autoStealthConn
ToggleTPDownedBtn.MouseButton1Click:Connect(function()
    autoStealthReviveEnabled = not autoStealthReviveEnabled
    ToggleTPDownedBtn.BackgroundColor3 = autoStealthReviveEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
    ToggleTPDownedBtn.Text = "TP Người Bị Hạ: " .. (autoStealthReviveEnabled and "BẬT" or "TẮT")
    
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
                                local wasVoidActive = voidEnabled
                                if wasVoidActive then
                                    if hoverBodyPos then hoverBodyPos:Destroy() end
                                    if hoverBodyGyro then hoverBodyGyro:Destroy() end
                                end
                                
                                for _, part in pairs(char:GetDescendants()) do
                                    if part:IsA("BasePart") then
                                        part.Transparency = 1
                                        part.CanCollide = false
                                    elseif part:IsA("Decal") then
                                        part.Transparency = 1
                                    end
                                end
                                
                                rootPart.CFrame = targetRoot.CFrame * CFrame.new(0, 0, -2)
                                
                                local startTime = tick()
                                while tick() - startTime < 2 and autoStealthReviveEnabled do
                                    for _, obj in pairs(targetChar:GetDescendants()) do
                                        if obj:IsA("ProximityPrompt") then
                                            pcall(function() fireproximityprompt(obj) end)
                                        end
                                    end
                                    task.wait(0.2)
                                end
                                
                                rootPart.CFrame = targetRoot.CFrame - Vector3.new(0, 3, 0)
                                
                                for _, part in pairs(char:GetDescendants()) do
                                    if part:IsA("BasePart") then
                                        part.Transparency = (part.Name == "HumanoidRootPart") and 1 or 0
                                        part.CanCollide = true
                                    elseif part:IsA("Decal") then
                                        part.Transparency = 0
                                    end
                                end
                                
                                if wasVoidActive then
                                    local targetPos = rootPart.Position - Vector3.new(0, 35, 0)
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
                    if not foundTarget then task.wait(1) end
                end
                task.wait(0.5)
            end
        end)
    else
        autoStealthReviveEnabled = false
    end
end)

-- 9. Auto Né Netbot
local dodgeNetbotEnabled = false
local dodgeConn
ToggleDodgeNetbotBtn.MouseButton1Click:Connect(function()
    dodgeNetbotEnabled = not dodgeNetbotEnabled
    ToggleDodgeNetbotBtn.BackgroundColor3 = dodgeNetbotEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
    ToggleDodgeNetbotBtn.Text = "Auto Né Netbot: " .. (dodgeNetbotEnabled and "BẬT" or "TẮT")
    
    if dodgeNetbotEnabled then
        dodgeConn = RunService.RenderStepped:Connect(function()
            local char = player.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            local rootPart = char.HumanoidRootPart
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            
            for _, obj in pairs(Workspace:GetDescendants()) do
                if not dodgeNetbotEnabled then break end
                if obj:IsA("Model") and obj ~= char then
                    local isPlayer = Players:GetPlayerFromCharacter(obj)
                    if not isPlayer then
                        local enemyRoot = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
                        local enemyHumanoid = obj:FindFirstChildOfClass("Humanoid")
                        
                        if enemyRoot and enemyHumanoid then
                            local success, distance = pcall(function()
                                return (rootPart.Position - enemyRoot.Position).Magnitude
                            end)
                            
                            if success and distance and distance < 50 then
                                if distance < 25 then
                                    local diff = rootPart.Position - enemyRoot.Position
                                    if diff.Magnitude > 0 then
                                        local dodgeDir = diff.Unit
                                        rootPart.CFrame = rootPart.CFrame + (dodgeDir * 8)
                                        
                                        if humanoid then
                                            humanoid.WalkSpeed = 35
                                            task.delay(0.3, function()
                                                if humanoid and not speedEnabled then
                                                    humanoid.WalkSpeed = 16
                                                end
                                            end)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    else
        if dodgeConn then dodgeConn:Disconnect() end
    end
end)
-- mới tự làm code thôi --
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/prolua1/pro-lua/refs/heads/main/evade.lua"))() --
