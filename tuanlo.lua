local LPH_Name = "Tuan Lo Pro Hub"
local LPH_Developer = "Tuan Lo Developer"
local LPH_Version = "v8.5.0 Ultimate Bring Pro"

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local VirtualInputManager = game:GetService("VirtualInputManager")

pcall(function()
    if game.CoreGui:FindFirstChild("TuanLoHub_Custom") then
        game.CoreGui.TuanLoHub_Custom:Destroy()
    end
end)

local MainGui = Instance.new("ScreenGui")
MainGui.Name = "TuanLoHub_Custom"
MainGui.ResetOnSpawn = false
MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling 
MainGui.IgnoreGuiInset = true

pcall(function()
    if gethui then MainGui.Parent = gethui()
    elseif syn and syn.protect_gui then syn.protect_gui(MainGui) MainGui.Parent = game:GetService("CoreGui")
    else MainGui.Parent = game:GetService("CoreGui") end
end)

local blackScreenFrame = Instance.new("Frame")
blackScreenFrame.Size = UDim2.new(1, 0, 1, 0)
blackScreenFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
blackScreenFrame.BorderSizePixel = 0
blackScreenFrame.Visible = false
blackScreenFrame.ZIndex = 0
blackScreenFrame.Parent = MainGui

local function ApplyTween(object, properties, duration)
    return TweenService:Create(object, TweenInfo.new(duration, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), properties)
end

local function MakeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true dragStart = input.Position startPos = frame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    frame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local function PlayWelcomeSplash(OnSplashFinished)
    local SplashFrame = Instance.new("Frame")
    SplashFrame.Size = UDim2.new(1, 0, 1, 0)
    SplashFrame.BackgroundColor3 = Color3.fromRGB(15, 5, 5)
    SplashFrame.BackgroundTransparency = 1
    SplashFrame.ZIndex = 9999
    SplashFrame.Parent = MainGui

    local SplashText = Instance.new("TextLabel")
    SplashText.Size = UDim2.new(1, 0, 0, 60)
    SplashText.Position = UDim2.new(0, 0, 0.5, -30)
    SplashText.BackgroundTransparency = 1
    SplashText.Font = Enum.Font.FredokaOne
    SplashText.Text = "Chào mừng đến với Tuấn Lọ Hub"
    SplashText.TextColor3 = Color3.fromRGB(255, 255, 255)
    SplashText.TextSize = 28
    SplashText.TextTransparency = 1
    SplashText.Parent = SplashFrame

    local TextStroke = Instance.new("UIStroke")
    TextStroke.Color = Color3.fromRGB(255, 0, 0)
    TextStroke.Thickness = 2
    TextStroke.Transparency = 1
    TextStroke.Parent = SplashText

    ApplyTween(SplashFrame, {BackgroundTransparency = 0.15}, 0.6):Play()
    ApplyTween(SplashText, {TextTransparency = 0}, 0.6):Play()
    ApplyTween(TextStroke, {Transparency = 0.2}, 0.6):Play()
    task.wait(1.2)
    ApplyTween(SplashFrame, {BackgroundTransparency = 1}, 0.4):Play()
    ApplyTween(SplashText, {TextTransparency = 1}, 0.4):Play()
    ApplyTween(TextStroke, {Transparency = 1}, 0.4):Play()
    task.wait(0.4)
    SplashFrame:Destroy()
    OnSplashFinished()
end

local function LoadMainMenu()
    local BaseWidth = 560
    local BaseHeight = 360

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, BaseWidth, 0, BaseHeight)
    MainFrame.Position = UDim2.new(0.5, -BaseWidth/2, 0.5, -BaseHeight/2)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 10)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.ZIndex = 10
    MainFrame.Parent = MainGui
    MakeDraggable(MainFrame)

    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
    local MainStroke = Instance.new("UIStroke", MainFrame) MainStroke.Color = Color3.fromRGB(255, 30, 30) MainStroke.Thickness = 1.5

    local HubScale = Instance.new("UIScale")
    HubScale.Scale = 1.0
    HubScale.Parent = MainFrame

    local MinimizeBtn = Instance.new("ImageButton")
    MinimizeBtn.Size = UDim2.new(0, 0, 0, 0)
    MinimizeBtn.Position = UDim2.new(0, 20, 0, 20)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(20, 8, 8)
    MinimizeBtn.Image = "rbxassetid://10747373999" 
    MinimizeBtn.ImageColor3 = Color3.fromRGB(255, 50, 50)
    MinimizeBtn.ImageTransparency = 0.3
    MinimizeBtn.Visible = false
    MinimizeBtn.ZIndex = 15
    MinimizeBtn.Parent = MainGui
    MakeDraggable(MinimizeBtn)

    Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(1, 0)
    local MiniStroke = Instance.new("UIStroke", MinimizeBtn) 
    MiniStroke.Color = Color3.fromRGB(255, 30, 30) 
    MiniStroke.Thickness = 2

    local MiniText = Instance.new("TextLabel")
    MiniText.Size = UDim2.new(1, 0, 1, 0)
    MiniText.BackgroundTransparency = 1
    MiniText.Font = Enum.Font.FredokaOne
    MiniText.Text = "TLP"
    MiniText.TextColor3 = Color3.fromRGB(255, 230, 230)
    MiniText.TextSize = 13
    MiniText.ZIndex = 16
    MiniText.Parent = MinimizeBtn
    
    local MiniTextStroke = Instance.new("UIStroke", MiniText)
    MiniTextStroke.Color = Color3.fromRGB(150, 0, 0)
    MiniTextStroke.Thickness = 1.5

    MinimizeBtn.MouseEnter:Connect(function()
        ApplyTween(MinimizeBtn, {Size = UDim2.new(0, 56, 0, 56)}, 0.15):Play()
        ApplyTween(MiniStroke, {Color = Color3.fromRGB(255, 80, 80)}, 0.15):Play()
    end)
    MinimizeBtn.MouseLeave:Connect(function()
        ApplyTween(MinimizeBtn, {Size = UDim2.new(0, 50, 0, 50)}, 0.15):Play()
    end)

    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 45)
    TitleBar.BackgroundColor3 = Color3.fromRGB(25, 12, 12)
    TitleBar.BorderSizePixel = 0
    TitleBar.ZIndex = 11
    TitleBar.Parent = MainFrame

    local HubIcon = Instance.new("ImageLabel")
    HubIcon.Size = UDim2.new(0, 24, 0, 24)
    HubIcon.Position = UDim2.new(0, 15, 0.5, -12)
    HubIcon.BackgroundTransparency = 1
    HubIcon.Image = "rbxassetid://10747373999"
    HubIcon.ImageColor3 = Color3.fromRGB(255, 30, 30)
    HubIcon.ZIndex = 12
    HubIcon.Parent = TitleBar

    local TitleText = Instance.new("TextLabel")
    TitleText.Size = UDim2.new(1, -260, 1, 0) 
    TitleText.Position = UDim2.new(0, 48, 0, 0)
    TitleText.BackgroundTransparency = 1
    TitleText.Font = Enum.Font.FredokaOne
    TitleText.Text = LPH_Name .. " — " .. LPH_Version
    TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleText.TextSize = 14
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.ZIndex = 12
    TitleText.Parent = TitleBar

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 26, 0, 26)
    CloseBtn.Position = UDim2.new(1, -36, 0.5, -13)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(60, 25, 25)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Text = "-"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 14
    CloseBtn.ZIndex = 12
    CloseBtn.Parent = TitleBar
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

    local UptimeText = Instance.new("TextLabel")
    UptimeText.Size = UDim2.new(0, 160, 1, 0)
    UptimeText.Position = UDim2.new(1, -210, 0, 0)
    UptimeText.BackgroundTransparency = 1
    UptimeText.Font = Enum.Font.GothamBold
    UptimeText.Text = "Server Uptime: 00:00:00"
    UptimeText.TextColor3 = Color3.fromRGB(255, 80, 80) 
    UptimeText.TextSize = 11
    UptimeText.TextXAlignment = Enum.TextXAlignment.Right
    UptimeText.ZIndex = 12
    UptimeText.Parent = TitleBar

    task.spawn(function()
        while task.wait(1) do
            local totalSeconds = math.floor(workspace.DistributedGameTime)
            local hours = math.floor(totalSeconds / 3600)
            local minutes = math.floor((totalSeconds % 3600) / 60)
            local seconds = totalSeconds % 60
            UptimeText.Text = string.format("Server Uptime: %02d:%02d:%02d", hours, minutes, seconds)
        end
    end)

    CloseBtn.MouseButton1Click:Connect(function()
        ApplyTween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}, 0.25):Play()
        task.wait(0.2)
        MainFrame.Visible = false 
        MinimizeBtn.Visible = true
        ApplyTween(MinimizeBtn, {Size = UDim2.new(0, 50, 0, 50)}, 0.25):Play()
    end)
    
    MinimizeBtn.MouseButton1Click:Connect(function()
        ApplyTween(MinimizeBtn, {Size = UDim2.new(0, 0, 0, 0)}, 0.2):Play()
        task.wait(0.15)
        MinimizeBtn.Visible = false 
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, BaseWidth, 0, BaseHeight)
        ApplyTween(MainFrame, {BackgroundTransparency = 0}, 0.25):Play()
    end)

    local TabScroll = Instance.new("ScrollingFrame")
    TabScroll.Size = UDim2.new(0, 140, 1, -45)
    TabScroll.Position = UDim2.new(0, 0, 0, 45)
    TabScroll.BackgroundColor3 = Color3.fromRGB(20, 12, 12)
    TabScroll.BorderSizePixel = 0
    TabScroll.CanvasSize = UDim2.new(0, 0, 0, 400)
    TabScroll.ScrollBarThickness = 2
    TabScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 30, 30)
    TabScroll.ZIndex = 11
    TabScroll.Parent = MainFrame

    local TabListLayout = Instance.new("UIListLayout") TabListLayout.Parent = TabScroll TabListLayout.Padding = UDim.new(0, 4) TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -150, 1, -55)
    ContentContainer.Position = UDim2.new(0, 145, 0, 50)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.ClipsDescendants = true
    ContentContainer.ZIndex = 11
    ContentContainer.Parent = MainFrame

    local activeTab = nil

    local function CreateTab(tabName, iconId)
        local TabPage = Instance.new("ScrollingFrame")
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.BorderSizePixel = 0
        TabPage.Visible = false
        TabPage.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabPage.ScrollBarThickness = 3
        TabPage.ScrollBarImageColor3 = Color3.fromRGB(255, 30, 30)
        TabPage.ClipsDescendants = true
        TabPage.ZIndex = 11
        TabPage.Parent = ContentContainer
        
        local PageLayout = Instance.new("UIListLayout", TabPage)
        PageLayout.Padding = UDim.new(0, 8)
        PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        
        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 15)
        end)

        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(0, 130, 0, 36)
        TabBtn.BackgroundColor3 = Color3.fromRGB(28, 16, 16)
        TabBtn.Text = ""
        TabBtn.ZIndex = 12
        TabBtn.Parent = TabScroll
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

        local TabIcon = Instance.new("ImageLabel")
        TabIcon.Size = UDim2.new(0, 18, 0, 18)
        TabIcon.Position = UDim2.new(0, 8, 0.5, -9)
        TabIcon.BackgroundTransparency = 1
        TabIcon.Image = "rbxassetid://" .. tostring(iconId)
        TabIcon.ImageColor3 = Color3.fromRGB(150, 150, 150)
        TabIcon.ZIndex = 13
        TabIcon.Parent = TabBtn

        local TabLabel = Instance.new("TextLabel")
        TabLabel.Size = UDim2.new(1, -34, 1, 0)
        TabLabel.Position = UDim2.new(0, 30, 0, 0)
        TabLabel.BackgroundTransparency = 1
        TabLabel.Font = Enum.Font.GothamBold
        TabLabel.Text = tabName
        TabLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
        TabLabel.TextSize = 11
        TabLabel.TextXAlignment = Enum.TextXAlignment.Left
        TabLabel.ZIndex = 13
        TabLabel.Parent = TabBtn

        local function Select()
            if activeTab then
                activeTab.Page.Visible = false
                ApplyTween(activeTab.Button, {BackgroundColor3 = Color3.fromRGB(28, 16, 16)}, 0.15):Play()
                ApplyTween(activeTab.Icon, {ImageColor3 = Color3.fromRGB(150, 150, 150)}, 0.15):Play()
                ApplyTween(activeTab.Label, {TextColor3 = Color3.fromRGB(180, 180, 180)}, 0.15):Play()
            end
            activeTab = {Page = TabPage, Button = TabBtn, Icon = TabIcon, Label = TabLabel}
            TabPage.Visible = true
            ApplyTween(TabBtn, {BackgroundColor3 = Color3.fromRGB(60, 15, 15)}, 0.15):Play()
            ApplyTween(TabIcon, {ImageColor3 = Color3.fromRGB(255, 30, 30)}, 0.15):Play()
            ApplyTween(TabLabel, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.15):Play()
        end

        TabBtn.MouseButton1Click:Connect(Select)
        
        local function AddToggle(name, toggleIconId, defaultState, callback)
            local state = defaultState or false
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, -8, 0, 38)
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 15, 15)
            ToggleFrame.ZIndex = 12
            ToggleFrame.Parent = TabPage
            Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 6)

            local ToggleIcon = Instance.new("ImageLabel")
            ToggleIcon.Size = UDim2.new(0, 18, 0, 18)
            ToggleIcon.Position = UDim2.new(0, 10, 0.5, -9)
            ToggleIcon.BackgroundTransparency = 1
            ToggleIcon.Image = "rbxassetid://" .. tostring(toggleIconId)
            ToggleIcon.ImageColor3 = state and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(200, 150, 150)
            ToggleIcon.ZIndex = 13
            ToggleIcon.Parent = ToggleFrame

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -95, 1, 0)
            Label.Position = UDim2.new(0, 38, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Font = Enum.Font.GothamBold
            Label.Text = name
            Label.TextColor3 = Color3.fromRGB(240, 210, 210)
            Label.TextSize = 11
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.ZIndex = 13
            Label.Parent = ToggleFrame

            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Size = UDim2.new(0, 40, 0, 20)
            ToggleBtn.Position = UDim2.new(1, -48, 0.5, -10)
            ToggleBtn.BackgroundColor3 = state and Color3.fromRGB(255, 30, 30) or Color3.fromRGB(60, 40, 40)
            ToggleBtn.Text = ""
            ToggleBtn.ZIndex = 13
            ToggleBtn.Parent = ToggleFrame
            Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

            local Indicator = Instance.new("Frame")
            Indicator.Size = UDim2.new(0, 14, 0, 14)
            Indicator.Position = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
            Indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Indicator.BorderSizePixel = 0
            Indicator.ZIndex = 14
            Indicator.Parent = ToggleBtn
            Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)

            ToggleBtn.MouseButton1Click:Connect(function()
                state = not state
                ApplyTween(ToggleBtn, {BackgroundColor3 = state and Color3.fromRGB(255, 30, 30) or Color3.fromRGB(60, 40, 40)}, 0.15):Play()
                ApplyTween(Indicator, {Position = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)}, 0.15):Play()
                ApplyTween(ToggleIcon, {ImageColor3 = state and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(200, 150, 150)}, 0.15):Play()
                task.spawn(callback, state)
            end)

            if state then
                task.spawn(callback, true)
            end
        end

        return {Select = Select, AddToggle = AddToggle, Page = TabPage}
    end

    local Tab1 = CreateTab("🏠 Trang chủ", 10747373999)
    local Tab2 = CreateTab("⚡ All Hack", 10747383471)
    local Tab3 = CreateTab("🎮 Hack Evade", 10747362071)
    local Tab4 = CreateTab("🔪 Hack MM2", 10747384350)
    local Tab5 = CreateTab("💪 Strongest BB", 10747381084)

    Tab1.Select()

    -- TAB 1: TRANG CHỦ
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, -8, 0, 50)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(25, 15, 15)
    SliderFrame.ZIndex = 12
    SliderFrame.Parent = Tab1.Page
    Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 6)

    local SliderIcon = Instance.new("ImageLabel")
    SliderIcon.Size = UDim2.new(0, 18, 0, 18)
    SliderIcon.Position = UDim2.new(0, 10, 0, 8)
    SliderIcon.BackgroundTransparency = 1
    SliderIcon.Image = "rbxassetid://10747373999"
    SliderIcon.ImageColor3 = Color3.fromRGB(200, 150, 150)
    SliderIcon.ZIndex = 13
    SliderIcon.Parent = SliderFrame

    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Size = UDim2.new(1, -60, 0, 20)
    SliderLabel.Position = UDim2.new(0, 38, 0, 7)
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Font = Enum.Font.GothamBold
    SliderLabel.Text = "Kích Thước Menu"
    SliderLabel.TextColor3 = Color3.fromRGB(240, 210, 210)
    SliderLabel.TextSize = 11
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    SliderLabel.ZIndex = 13
    SliderLabel.Parent = SliderFrame

    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0, 40, 0, 20)
    ValueLabel.Position = UDim2.new(1, -45, 0, 7)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Text = "1.0x"
    ValueLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    ValueLabel.TextSize = 11
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.ZIndex = 13
    ValueLabel.Parent = SliderFrame

    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(1, -24, 0, 6)
    SliderBar.Position = UDim2.new(0, 12, 0, 34)
    SliderBar.BackgroundColor3 = Color3.fromRGB(50, 30, 30)
    SliderBar.BorderSizePixel = 0
    SliderBar.ZIndex = 13
    SliderBar.Parent = SliderFrame
    Instance.new("UICorner", SliderBar).CornerRadius = UDim.new(1, 0)

    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new(0.5, 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
    SliderFill.BorderSizePixel = 0
    SliderFill.ZIndex = 14
    SliderFill.Parent = SliderBar
    Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)

    local SliderButton = Instance.new("TextButton")
    SliderButton.Size = UDim2.new(1, 0, 1, 0)
    SliderButton.BackgroundTransparency = 1
    SliderButton.Text = ""
    SliderButton.ZIndex = 15
    SliderButton.Parent = SliderBar

    local draggingSlider = false
    local minScale, maxScale = 0.5, 1.5

    local function UpdateSlider(input)
        local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
        SliderFill.Size = UDim2.new(pos, 0, 1, 0)
        local currentScale = minScale + (pos * (maxScale - minScale))
        HubScale.Scale = currentScale
        ValueLabel.Text = string.format("%.1fx", currentScale)
    end

    SliderButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = true
            UpdateSlider(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateSlider(input)
        end
    end)

    -- TAB 2: ALL HACK
    local flyEnabled = false
    local flySpeed = 50
    local bg, bv
    Tab2.AddToggle("Tính Năng Bay", 10747383471, false, function(state)
        flyEnabled = state
        local char = LocalPlayer.Character
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

    local invisEnabled = false
    Tab2.AddToggle("Tàng Hình", 10747383471, false, function(state)
        invisEnabled = state
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = invisEnabled and 1 or 0
                elseif part:IsA("Decal") then
                    part.Transparency = invisEnabled and 1 or 0
                end
            end
        end
    end)

    local evadeEnabled = false
    Tab2.AddToggle("Lướt Phím Z", 10747383471, false, function(state)
        evadeEnabled = state
    end)

    UserInputService.InputBegan:Connect(function(input)
        if evadeEnabled and input.KeyCode == Enum.KeyCode.Z then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local root = char.HumanoidRootPart
                local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local tween = TweenService:Create(root, tweenInfo, {CFrame = root.CFrame + (root.CFrame.LookVector * 25)})
                tween:Play()
            end
        end
    end)

    local noclipEnabled = false
    local noclipConn
    Tab2.AddToggle("Xuyên Tường (Noclip)", 10747383471, false, function(state)
        noclipEnabled = state
        if noclipEnabled then
            noclipConn = RunService.Stepped:Connect(function()
                local char = LocalPlayer.Character
                if char then
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = false end
                    end
                end
            end)
        else
            if noclipConn then noclipConn:Disconnect() end
            local char = LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = true end
                end
            end
        end
    end)

    local infJumpEnabled = false
    local infJumpConn
    Tab2.AddToggle("Nhảy Trên Không Vô Hạn", 10747383471, false, function(state)
        infJumpEnabled = state
        if infJumpEnabled then
            infJumpConn = UserInputService.JumpRequest:Connect(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChildOfClass("Humanoid") then
                    char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        else
            if infJumpConn then infJumpConn:Disconnect() end
        end
    end)

    local fullbrightEnabled = false
    local fbConn
    Tab2.AddToggle("Nhìn Sáng (Fullbright)", 10747383471, false, function(state)
        fullbrightEnabled = state
        if fullbrightEnabled then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            fbConn = RunService.RenderStepped:Connect(function()
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = false
            end)
        else
            if fbConn then fbConn:Disconnect() end
            Lighting.Brightness = 1
            Lighting.GlobalShadows = true
        end
    end)

    local blackScreenEnabled = false
    Tab2.AddToggle("Black Screen (Treo máy)", 10747383471, false, function(state)
        blackScreenEnabled = state
        blackScreenFrame.Visible = blackScreenEnabled
    end)

    local antiAfkConn
    Tab2.AddToggle("Anti AFK (Chống treo máy)", 10747383471, true, function(state)
        if state then
            local vu = game:GetService("VirtualUser")
            antiAfkConn = LocalPlayer.Idled:Connect(function()
                pcall(function()
                    vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                    task.wait(1)
                    vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                end)
            end)
        else
            if antiAfkConn then antiAfkConn:Disconnect(); antiAfkConn = nil end
        end
    end)

    -- TAB 3: HACK EVADE
    local voidEnabled = false
    local hoverBodyPos, hoverBodyGyro, originalPos, voidFixedPosition
    local respawnVoidConn

    local function ApplyVoidMode()
        local char = LocalPlayer.Character
        if not char then return end
        local currentRoot = char:WaitForChild("HumanoidRootPart", 5)
        if voidEnabled and currentRoot then
            task.wait(0.3)
            originalPos = currentRoot.CFrame
            voidFixedPosition = currentRoot.Position + Vector3.new(3000, 2000, 0)
            currentRoot.CFrame = CFrame.new(voidFixedPosition)
            if hoverBodyPos then hoverBodyPos:Destroy() end
            if hoverBodyGyro then hoverBodyGyro:Destroy() end
            hoverBodyPos = Instance.new("BodyPosition", currentRoot)
            hoverBodyPos.Position = voidFixedPosition
            hoverBodyPos.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            hoverBodyPos.P = 25000
            hoverBodyGyro = Instance.new("BodyGyro", currentRoot)
            hoverBodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            hoverBodyGyro.CFrame = currentRoot.CFrame
        end
    end

    Tab3.AddToggle("Void Mode (X: 3000 | Cao: 2000)", 10747362071, false, function(state)
        voidEnabled = state
        if voidEnabled then
            ApplyVoidMode()
            if not respawnVoidConn then
                respawnVoidConn = LocalPlayer.CharacterAdded:Connect(function()
                    if voidEnabled then task.defer(ApplyVoidMode) end
                end)
            end
        else
            if hoverBodyPos then hoverBodyPos:Destroy() end
            if hoverBodyGyro then hoverBodyGyro:Destroy() end
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") and originalPos then
                char.HumanoidRootPart.CFrame = originalPos + Vector3.new(0, 2, 0)
            end
            if respawnVoidConn then respawnVoidConn:Disconnect(); respawnVoidConn = nil end
        end
    end)

    local autoMapEnabled = false
    Tab3.AddToggle("Auto Chọn Map (Ưu tiên Map Khó/Cứng)", 10747362071, false, function(state)
        autoMapEnabled = state
        task.spawn(function()
            while autoMapEnabled do
                task.wait(0.2)
                pcall(function()
                    local gui = LocalPlayer:FindFirstChild("PlayerGui")
                    if gui then
                        for _, screen in ipairs(gui:GetChildren()) do
                            if screen:IsA("ScreenGui") and (screen.Name:lower():find("vote") or screen.Name:lower():find("map")) then
                                for _, desc in ipairs(screen:GetDescendants()) do
                                    if desc:IsA("TextButton") or desc:IsA("ImageButton") then
                                        local txt = desc.Name:lower()
                                        for _, child in ipairs(desc:GetDescendants()) do
                                            if child:IsA("TextLabel") then
                                                txt = txt .. " " .. child.Text:lower()
                                            end
                                        end
                                        if txt:find("expert") or txt:find("hard") or txt:find("chuyên gia") or txt:find("khó") then
                                            for _, conn in ipairs(getconnections(desc.MouseButton1Click)) do
                                                conn:Fire()
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end)

    -- TAB 4: HACK MM2
    local mm2EspEnabled = false
    local mm2EspConns = {}

    local function updateMm2Roles()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local highlight = p.Character:FindFirstChild("MM2_Highlight")
                if not highlight and mm2EspEnabled then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "MM2_Highlight"
                    highlight.Adornee = p.Character
                    highlight.Parent = p.Character
                end
                
                if highlight then
                    highlight.Enabled = mm2EspEnabled
                    local backpack = p:FindFirstChild("Backpack")
                    local char = p.Character
                    local isMurderer = (backpack and backpack:FindFirstChild("Knife")) or (char and char:FindFirstChild("Knife"))
                    local isSheriff = (backpack and (backpack:FindFirstChild("Gun") or backpack:FindFirstChild("Revolver"))) or (char and (char:FindFirstChild("Gun") or char:FindFirstChild("Revolver")))
                    
                    if isMurderer then
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    elseif isSheriff then
                        highlight.FillColor = Color3.fromRGB(0, 100, 255)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    else
                        highlight.FillColor = Color3.fromRGB(0, 255, 0)
                        highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
                    end
                end
            end
        end
    end

    Tab4.AddToggle("ESP Vai Trò MM2", 10747384350, false, function(state)
        mm2EspEnabled = state
        if mm2EspEnabled then
            table.insert(mm2EspConns, RunService.RenderStepped:Connect(updateMm2Roles))
        else
            for _, conn in ipairs(mm2EspConns) do conn:Disconnect() end
            mm2EspConns = {}
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("MM2_Highlight") then
                    p.Character.MM2_Highlight:Destroy()
                end
            end
        end
    end)

    local gunDropEspEnabled = false
    local gunDropConn
    Tab4.AddToggle("ESP Súng Rơi", 10747384350, false, function(state)
        gunDropEspEnabled = state
        if gunDropEspEnabled then
            gunDropConn = RunService.RenderStepped:Connect(function()
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj.Name == "GunDrop" and obj:IsA("BasePart") then
                        local billboard = obj:FindFirstChild("GunBillboard")
                        if not billboard then
                            billboard = Instance.new("BillboardGui")
                            billboard.Name = "GunBillboard"
                            billboard.Size = UDim2.new(0, 100, 0, 40)
                            billboard.StudsOffset = Vector3.new(0, 2, 0)
                            billboard.AlwaysOnTop = true
                            billboard.Parent = obj
                            
                            local text = Instance.new("TextLabel")
                            text.Size = UDim2.new(1, 0, 1, 0)
                            text.BackgroundTransparency = 1
                            text.Font = Enum.Font.FredokaOne
                            text.Text = "🔫 SÚNG RƠI!"
                            text.TextColor3 = Color3.fromRGB(255, 255, 0)
                            text.TextSize = 14
                            text.Parent = billboard
                        end
                    end
                end
            end)
        else
            if gunDropConn then gunDropConn:Disconnect() end
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj.Name == "GunDrop" then
                    local bb = obj:FindFirstChild("GunBillboard")
                    if bb then bb:Destroy() end
                end
            end
        end
    end)

    local autoFarmCoins = false
    Tab4.AddToggle("Auto Farm Coin", 10747384350, false, function(state)
        autoFarmCoins = state
        task.spawn(function()
            while autoFarmCoins do
                task.wait(0.5)
                pcall(function()
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        local root = char.HumanoidRootPart
                        local coinContainer = Workspace:FindFirstChild("CoinContainer") or Workspace:FindFirstChild("Normal")
                        if coinContainer then
                            for _, coin in ipairs(coinContainer:GetChildren()) do
                                if not autoFarmCoins then break end
                                local coinPart = coin:FindFirstChild("CoinVisual") or coin:FindFirstChild("BasePart") or coin
                                if coinPart and coinPart:IsA("BasePart") then
                                    root.CFrame = coinPart.CFrame + Vector3.new(0, 1, 0)
                                    task.wait(0.1)
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end)

    -- TAB 5: STRONGEST BATTLEGROUNDS (ESP + GOM NGƯỜI CHƠI BẢN VIP + AUTO KILL)
    local sbbEspEnabled = false
    local sbbEspConns = {}

    local function updateSbbEsp()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local highlight = p.Character:FindFirstChild("SBB_Highlight")
                local billboard = p.Character:FindFirstChild("SBB_Billboard")
                
                if sbbEspEnabled then
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "SBB_Highlight"
                        highlight.Adornee = p.Character
                        highlight.FillColor = Color3.fromRGB(255, 50, 50)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.Parent = p.Character
                    end
                    if not billboard and p.Character:FindFirstChild("Head") then
                        billboard = Instance.new("BillboardGui")
                        billboard.Name = "SBB_Billboard"
                        billboard.Size = UDim2.new(0, 120, 0, 50)
                        billboard.StudsOffset = Vector3.new(0, 3, 0)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = p.Character

                        local txt = Instance.new("TextLabel")
                        txt.Name = "Info"
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1
                        txt.Font = Enum.Font.GothamBold
                        txt.TextColor3 = Color3.fromRGB(255, 255, 255)
                        txt.TextSize = 12
                        txt.Parent = billboard
                    end
                    
                    if billboard and p.Character:FindFirstChild("Head") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = math.floor((p.Character.Head.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
                        local txtLabel = billboard:FindFirstChild("Info")
                        if txtLabel then
                            txtLabel.Text = p.Name .. "\n[" .. dist .. "m]"
                        end
                    end
                else
                    if highlight then highlight:Destroy() end
                    if billboard then billboard:Destroy() end
                end
            end
        end
    end

    Tab5.AddToggle("ESP Địch + Khoảng Cách", 10747381084, false, function(state)
        sbbEspEnabled = state
        if sbbEspEnabled then
            table.insert(sbbEspConns, RunService.RenderStepped:Connect(updateSbbEsp))
        else
            for _, conn in ipairs(sbbEspConns) do conn:Disconnect() end
            sbbEspConns = {}
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Character then
                    if p.Character:FindFirstChild("SBB_Highlight") then p.Character.SBB_Highlight:Destroy() end
                    if p.Character:FindFirstChild("SBB_Billboard") then p.Character.SBB_Billboard:Destroy() end
                end
            end
        end
    end)

    -- [NÂNG CẤP PRO] GOM TẤT CẢ NGƯỜI CHƠI (KHÓA CHẶT, KHÔNG LỎ)
    local bringAllEnabled = false
    local bringConnection = nil
    Tab5.AddToggle("🧲 Gom Tất Cả Người Chơi (Pro)", 10747381084, false, function(state)
        bringAllEnabled = state
        if bringAllEnabled then
            bringConnection = RunService.RenderStepped:Connect(function()
                local myChar = LocalPlayer.Character
                if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                    local myPos = myChar.HumanoidRootPart.CFrame
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and p.Character then
                            local root = p.Character:FindFirstChild("HumanoidRootPart")
                            local hum = p.Character:FindFirstChildOfClass("Humanoid")
                            if root and hum and hum.Health > 0 then
                                -- Đóng băng chuyển động của địch để ép đứng im trước mặt bạn
                                hum.PlatformStand = true
                                root.CFrame = myPos * CFrame.new(0, 0, -3.5)
                                root.Velocity = Vector3.new(0, 0, 0)
                            end
                        end
                    end
                end
            end)
        else
            if bringConnection then bringConnection:Disconnect() bringConnection = nil end
            -- Trả lại trạng thái bình thường cho mọi người khi tắt
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local hum = p.Character:FindFirstChildOfClass("Humanoid")
                    if hum then hum.PlatformStand = false end
                end
            end
        end
    end)

    -- [NÂNG CẤP PRO] AUTO KILL NGƯỜI CHƠI BỊ GOM
    local autoKillGomEnabled = false
    Tab5.AddToggle("⚔️ Auto Kill Người Chơi Bị Gom", 10747381084, false, function(state)
        autoKillGomEnabled = state
        task.spawn(function()
            while autoKillGomEnabled do
                task.wait(0.03)
                pcall(function()
                    local char = LocalPlayer.Character
                    if char then
                        local tool = char:FindFirstChildOfClass("Tool")
                        if tool then
                            tool:Activate()
                        end
                    end
                end)
            end
        end)
    end)

    local originalTransparency = {}
    local function setInvisibility(state)
        local char = LocalPlayer.Character
        if not char then return end
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                if state then
                    if part:IsA("BasePart") then originalTransparency[part] = part.Transparency end
                    part.Transparency = 1
                else
                    if part:IsA("BasePart") then part.Transparency = originalTransparency[part] or 0 end
                    part.Transparency = 0
                end
            end
        end
    end

    local autoTrashKillEnabled = false
    Tab5.AddToggle("🗑️ Auto Trash Kill (Tàng Hình)", 10747381084, false, function(state)
        autoTrashKillEnabled = state
        setInvisibility(state)
        
        task.spawn(function()
            while autoTrashKillEnabled do
                task.wait(0.2)
                pcall(function()
                    local char = LocalPlayer.Character
                    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                    local myRoot = char.HumanoidRootPart
                    
                    local targetPlayer = nil
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and p.Character then
                            local hum = p.Character:FindFirstChildOfClass("Humanoid")
                            if hum and hum.Health > 0 and (hum.Health / hum.MaxHealth) <= 0.4 then
                                targetPlayer = p
                                break
                            end
                        end
                    end
                    
                    if targetPlayer and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local tRoot = targetPlayer.Character.HumanoidRootPart
                        local heldTrash = char:FindFirstChildOfClass("Tool")
                        
                        if heldTrash and (heldTrash.Name:lower():find("trash") or heldTrash.Name:lower():find("bin") or heldTrash.Name:lower():find("garbage")) then
                            myRoot.CFrame = tRoot.CFrame * CFrame.new(0, 0, 3)
                            heldTrash:Activate()
                        else
                            local nearestTrash = nil
                            local shortestDist = math.huge
                            
                            for _, obj in ipairs(Workspace:GetDescendants()) do
                                if obj:IsA("BasePart") then
                                    local name = obj.Name:lower()
                                    if name:find("trash") or name:find("bin") or name:find("garbage") or name:find("dumpster") then
                                        local dist = (myRoot.Position - obj.Position).Magnitude
                                        if dist < shortestDist then
                                            shortestDist = dist
                                            nearestTrash = obj
                                        end
                                    end
                                end
                            end

                            if nearestTrash then
                                myRoot.CFrame = nearestTrash.CFrame
                                task.wait(0.05)
                                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                                task.wait(0.02)
                                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                                task.wait(0.02)
                                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                            end
                        end
                    end
                end)
            end
            if not autoTrashKillEnabled then setInvisibility(false) end
        end)
    end)

    local autoDodgeEnabled = false
    Tab5.AddToggle("Auto Dash / Dodge (Né Đòn Tự Động)", 10747381084, false, function(state)
        autoDodgeEnabled = state
        task.spawn(function()
            while autoDodgeEnabled do
                task.wait(0.2)
                pcall(function()
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        local myRoot = char.HumanoidRootPart
                        for _, p in ipairs(Players:GetPlayers()) do
                            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                                local targetRoot = p.Character.HumanoidRootPart
                                if (myRoot.Position - targetRoot.Position).Magnitude < 6 then
                                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
                                    task.wait(0.05)
                                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
                                    task.wait(0.5)
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end)
end

PlayWelcomeSplash(LoadMainMenu)
