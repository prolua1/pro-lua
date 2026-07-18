--[[
    ========================================================================
        TUAN LO PRO HUB - BẢN ĐỎ PREMIUM (V5.1 - OPTIMIZED DROPDOWN UI)
        [ĐÃ NÂNG CẤP HIỆU ỨNG THU GỌN BREATHING GLOW CHUYÊN NGHIỆP]
    ========================================================================
]]

local LPH_Name = "Tuan Lo Pro Hub"
local LPH_Developer = "Tuan Lo Developer"
local LPH_Version = "v5.1 Premium"

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local MainGui = Instance.new("ScreenGui")
MainGui.Name = "LPH_" .. tostring(math.random(100000, 999999))
MainGui.ResetOnSpawn = false
MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling 

if gethui then MainGui.Parent = gethui()
elseif syn and syn.protect_gui then syn.protect_gui(MainGui) MainGui.Parent = game:GetService("CoreGui")
else pcall(function() MainGui.Parent = game:GetService("CoreGui") end) end

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
    MainFrame.Parent = MainGui
    MakeDraggable(MainFrame)

    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
    local MainStroke = Instance.new("UIStroke", MainFrame) MainStroke.Color = Color3.fromRGB(255, 30, 30) MainStroke.Thickness = 1.5

    local HubScale = Instance.new("UIScale")
    HubScale.Scale = 1.0
    HubScale.Parent = MainFrame

    -- ==========================================================
    -- NÚT THU GỌN CAO CẤP (MINIMIZE BUTTON PREMIUM)
    -- ==========================================================
    local MinimizeBtn = Instance.new("ImageButton")
    MinimizeBtn.Size = UDim2.new(0, 0, 0, 0)
    MinimizeBtn.Position = UDim2.new(0, 20, 0, 20)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(20, 8, 8)
    MinimizeBtn.Image = "rbxassetid://10747373999" 
    MinimizeBtn.ImageColor3 = Color3.fromRGB(255, 50, 50)
    MinimizeBtn.ImageTransparency = 0.3
    MinimizeBtn.Visible = false
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
    MiniText.Parent = MinimizeBtn
    
    local MiniTextStroke = Instance.new("UIStroke", MiniText)
    MiniTextStroke.Color = Color3.fromRGB(150, 0, 0)
    MiniTextStroke.Thickness = 1.5

    task.spawn(function()
        while true do
            if MinimizeBtn.Visible then
                ApplyTween(MiniStroke, {Thickness = 3.5, Color = Color3.fromRGB(255, 0, 0)}, 0.8):Play()
                ApplyTween(MinimizeBtn, {BackgroundColor3 = Color3.fromRGB(35, 10, 10)}, 0.8):Play()
                ApplyTween(MiniText, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.8):Play()
                task.wait(0.8)
                ApplyTween(MiniStroke, {Thickness = 1.5, Color = Color3.fromRGB(160, 20, 20)}, 0.8):Play()
                ApplyTween(MinimizeBtn, {BackgroundColor3 = Color3.fromRGB(15, 6, 6)}, 0.8):Play()
                ApplyTween(MiniText, {TextColor3 = Color3.fromRGB(200, 150, 150)}, 0.8):Play()
                task.wait(0.8)
            else
                task.wait(0.5)
            end
        end
    end)

    MinimizeBtn.MouseEnter:Connect(function()
        ApplyTween(MinimizeBtn, {Size = UDim2.new(0, 56, 0, 56)}, 0.15):Play()
        ApplyTween(MiniStroke, {Color = Color3.fromRGB(255, 80, 80)}, 0.15):Play()
    end)
    MinimizeBtn.MouseLeave:Connect(function()
        ApplyTween(MinimizeBtn, {Size = UDim2.new(0, 50, 0, 50)}, 0.15):Play()
    end)

    -- TITLE BAR
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 45)
    TitleBar.BackgroundColor3 = Color3.fromRGB(25, 12, 12)
    TitleBar.BorderSizePixel = 0
    TitleBar.ZIndex = 2
    TitleBar.Parent = MainFrame

    local HubIcon = Instance.new("ImageLabel")
    HubIcon.Size = UDim2.new(0, 24, 0, 24)
    HubIcon.Position = UDim2.new(0, 15, 0.5, -12)
    HubIcon.BackgroundTransparency = 1
    HubIcon.Image = "rbxassetid://10747373999"
    HubIcon.ImageColor3 = Color3.fromRGB(255, 30, 30)
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
    TitleText.Parent = TitleBar

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 26, 0, 26)
    CloseBtn.Position = UDim2.new(1, -36, 0.5, -13)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(60, 25, 25)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Text = "-"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 14
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
    TabScroll.CanvasSize = UDim2.new(0, 0, 0, 350)
    TabScroll.ScrollBarThickness = 2
    TabScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 30, 30)
    TabScroll.ZIndex = 2
    TabScroll.Parent = MainFrame

    local TabListLayout = Instance.new("UIListLayout") TabListLayout.Parent = TabScroll TabListLayout.Padding = UDim.new(0, 4) TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -150, 1, -55)
    ContentContainer.Position = UDim2.new(0, 145, 0, 50)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.ZIndex = 1
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
        TabPage.ClipsDescendants = false 
        TabPage.ZIndex = 2
        TabPage.Parent = ContentContainer
        
        local PageLayout = Instance.new("UIListLayout", TabPage)
        PageLayout.Padding = UDim.new(0, 8)
        PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        
        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 20)
        end)

        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(0, 130, 0, 36)
        TabBtn.BackgroundColor3 = Color3.fromRGB(28, 16, 16)
        TabBtn.Text = ""
        TabBtn.ZIndex = 3
        TabBtn.Parent = TabScroll
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

        local TabIcon = Instance.new("ImageLabel")
        TabIcon.Size = UDim2.new(0, 18, 0, 18)
        TabIcon.Position = UDim2.new(0, 8, 0.5, -9)
        TabIcon.BackgroundTransparency = 1
        TabIcon.Image = "rbxassetid://" .. tostring(iconId)
        TabIcon.ImageColor3 = Color3.fromRGB(150, 150, 150)
        TabIcon.ZIndex = 4
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
        TabLabel.ZIndex = 4
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
        
        -- TOGGLE
        local function AddToggle(name, toggleIconId, callback)
            local state = false
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, -6, 0, 40)
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 15, 15)
            ToggleFrame.ZIndex = 3 
            ToggleFrame.Parent = TabPage
            Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 6)

            local ToggleIcon = Instance.new("ImageLabel")
            ToggleIcon.Size = UDim2.new(0, 20, 0, 20)
            ToggleIcon.Position = UDim2.new(0, 12, 0.5, -10)
            ToggleIcon.BackgroundTransparency = 1
            ToggleIcon.Image = "rbxassetid://" .. tostring(toggleIconId)
            ToggleIcon.ImageColor3 = Color3.fromRGB(200, 150, 150)
            ToggleIcon.ZIndex = 4
            ToggleIcon.Parent = ToggleFrame

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -100, 1, 0)
            Label.Position = UDim2.new(0, 42, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Font = Enum.Font.GothamBold
            Label.Text = name
            Label.TextColor3 = Color3.fromRGB(240, 210, 210)
            Label.TextSize = 12
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.ZIndex = 4
            Label.Parent = ToggleFrame

            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Size = UDim2.new(0, 42, 0, 22)
            ToggleBtn.Position = UDim2.new(1, -54, 0.5, -11)
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 40, 40)
            ToggleBtn.Text = ""
            ToggleBtn.ZIndex = 4
            ToggleBtn.Parent = ToggleFrame
            Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

            local Indicator = Instance.new("Frame")
            Indicator.Size = UDim2.new(0, 16, 0, 16)
            Indicator.Position = UDim2.new(0, 3, 0.5, -8)
            Indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Indicator.BorderSizePixel = 0
            Indicator.ZIndex = 5
            Indicator.Parent = ToggleBtn
            Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)

            ToggleBtn.MouseButton1Click:Connect(function()
                state = not state
                ApplyTween(ToggleBtn, {BackgroundColor3 = state and Color3.fromRGB(255, 30, 30) or Color3.fromRGB(60, 40, 40)}, 0.15):Play()
                ApplyTween(Indicator, {Position = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)}, 0.15):Play()
                ApplyTween(ToggleIcon, {ImageColor3 = state and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(200, 150, 150)}, 0.15):Play()
                task.spawn(callback, state)
            end)
        end

        -- SLIDER
        local function AddSlider(name, sliderIconId, min, max, default, callback)
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Size = UDim2.new(1, -6, 0, 50)
            SliderFrame.BackgroundColor3 = Color3.fromRGB(25, 15, 15)
            SliderFrame.ZIndex = 3
            SliderFrame.Parent = TabPage
            Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 6)

            local SliderIcon = Instance.new("ImageLabel")
            SliderIcon.Size = UDim2.new(0, 20, 0, 20)
            SliderIcon.Position = UDim2.new(0, 12, 0, 8)
            SliderIcon.BackgroundTransparency = 1
            SliderIcon.Image = "rbxassetid://" .. tostring(sliderIconId)
            SliderIcon.ImageColor3 = Color3.fromRGB(200, 150, 150)
            SliderIcon.ZIndex = 4
            SliderIcon.Parent = SliderFrame

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -120, 0, 20)
            Label.Position = UDim2.new(0, 42, 0, 8)
            Label.BackgroundTransparency = 1
            Label.Font = Enum.Font.GothamBold
            Label.Text = name
            Label.TextColor3 = Color3.fromRGB(240, 210, 210)
            Label.TextSize = 12
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.ZIndex = 4
            Label.Parent = SliderFrame

            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Size = UDim2.new(0, 60, 0, 20)
            ValueLabel.Position = UDim2.new(1, -72, 0, 8)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Font = Enum.Font.GothamBold
            ValueLabel.Text = tostring(default)
            ValueLabel.TextColor3 = Color3.fromRGB(255, 30, 30)
            ValueLabel.TextSize = 12
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            ValueLabel.ZIndex = 4
            ValueLabel.Parent = SliderFrame

            local SliderBar = Instance.new("TextButton")
            SliderBar.Size = UDim2.new(1, -24, 0, 6)
            SliderBar.Position = UDim2.new(0, 12, 0, 34)
            SliderBar.BackgroundColor3 = Color3.fromRGB(60, 40, 40)
            SliderBar.Text = ""
            SliderBar.AutoButtonColor = false
            SliderBar.ZIndex = 4
            SliderBar.Parent = SliderFrame
            Instance.new("UICorner", SliderBar).CornerRadius = UDim.new(1, 0)

            local SliderFill = Instance.new("Frame")
            SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
            SliderFill.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
            SliderFill.BorderSizePixel = 0
            SliderFill.ZIndex = 5
            SliderFill.Parent = SliderBar
            Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)

            local dragging = false
            local function UpdateSlider(input)
                local percentage = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                local value = math.floor(min + (max - min) * percentage)
                ValueLabel.Text = tostring(value)
                ApplyTween(SliderFill, {Size = UDim2.new(percentage, 0, 1, 0)}, 0.05):Play()
                task.spawn(callback, value)
            end

            SliderBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true UpdateSlider(input)
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    UpdateSlider(input)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
        end

        -- DROPDOWN
        local function AddDropdown(name, list, default, callback)
            local isOpened = false
            
            local DropdownFrame = Instance.new("Frame")
            DropdownFrame.Size = UDim2.new(1, -6, 0, 40) 
            DropdownFrame.BackgroundColor3 = Color3.fromRGB(25, 15, 15)
            DropdownFrame.ClipsDescendants = false 
            DropdownFrame.ZIndex = 10 
            DropdownFrame.Parent = TabPage
            Instance.new("UICorner", DropdownFrame).CornerRadius = UDim.new(0, 6)

            local DropLabel = Instance.new("TextLabel")
            DropLabel.Size = UDim2.new(0, 150, 0, 40)
            DropLabel.Position = UDim2.new(0, 12, 0, 0)
            DropLabel.BackgroundTransparency = 1
            DropLabel.Font = Enum.Font.GothamBold
            DropLabel.Text = name
            DropLabel.TextColor3 = Color3.fromRGB(240, 210, 210)
            DropLabel.TextSize = 12
            DropLabel.TextXAlignment = Enum.TextXAlignment.Left
            DropLabel.ZIndex = 11
            DropLabel.Parent = DropdownFrame

            local MainBtn = Instance.new("TextButton")
            MainBtn.Size = UDim2.new(1, -180, 0, 28)
            MainBtn.Position = UDim2.new(1, -12, 0, 6)
            MainBtn.AnchorPoint = Vector2.new(1, 0) 
            MainBtn.BackgroundColor3 = Color3.fromRGB(40, 22, 22)
            MainBtn.Font = Enum.Font.GothamBold
            MainBtn.Text = default .. "  ▼"
            MainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            MainBtn.TextSize = 11
            MainBtn.ZIndex = 11
            MainBtn.Parent = DropdownFrame
            Instance.new("UICorner", MainBtn).CornerRadius = UDim.new(0, 4)

            local Container = Instance.new("Frame")
            Container.Size = UDim2.new(1, -180, 0, 0) 
            Container.Position = UDim2.new(1, -12, 0, 36) 
            Container.AnchorPoint = Vector2.new(1, 0)
            Container.BackgroundColor3 = Color3.fromRGB(30, 15, 15)
            Container.BorderSizePixel = 0
            Container.ClipsDescendants = true 
            Container.ZIndex = 50 
            Container.Parent = DropdownFrame
            
            local ContainerStroke = Instance.new("UIStroke", Container) ContainerStroke.Color = Color3.fromRGB(255, 30, 30) ContainerStroke.Thickness = 1 ContainerStroke.Transparency = 1
            Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 4)
            
            local UIList = Instance.new("UIListLayout", Container)
            UIList.Padding = UDim.new(0, 2)

            for _, option in ipairs(list) do
                local OptBtn = Instance.new("TextButton")
                OptBtn.Size = UDim2.new(1, 0, 0, 26)
                OptBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
                OptBtn.BackgroundTransparency = 0.1
                OptBtn.Font = Enum.Font.GothamMedium
                OptBtn.Text = option
                OptBtn.TextColor3 = Color3.fromRGB(240, 240, 240)
                OptBtn.TextSize = 11
                OptBtn.ZIndex = 51
                OptBtn.Parent = Container

                OptBtn.MouseButton1Click:Connect(function()
                    MainBtn.Text = option .. "  ▼"
                    isOpened = false
                    DropdownFrame.ZIndex = 10
                    ApplyTween(Container, {Size = UDim2.new(1, -180, 0, 0)}, 0.15):Play()
                    ContainerStroke.Transparency = 1
                    task.spawn(callback, option)
                end)
            end

            MainBtn.MouseButton1Click:Connect(function()
                isOpened = not isOpened
                if isOpened then
                    DropdownFrame.ZIndex = 100 
                    local targetHeight = (#list * 26) + ((#list - 1) * 2)
                    ApplyTween(Container, {Size = UDim2.new(1, -180, 0, targetHeight)}, 0.18):Play()
                    ContainerStroke.Transparency = 0.2
                    MainBtn.Text = default .. "  ▲"
                else
                    DropdownFrame.ZIndex = 10
                    ApplyTween(Container, {Size = UDim2.new(1, -180, 0, 0)}, 0.15):Play()
                    ContainerStroke.Transparency = 1
                    MainBtn.Text = default .. "  ▼"
                end
            end)
        end

        -- HÀM THÊM BOX THÔNG TIN SERVER VÀO TABPAGE
        local function AddServerMonitorBox()
            local MonitorFrame = Instance.new("Frame")
            MonitorFrame.Size = UDim2.new(1, -6, 0, 160)
            MonitorFrame.BackgroundColor3 = Color3.fromRGB(20, 10, 10)
            MonitorFrame.ZIndex = 3
            MonitorFrame.Parent = TabPage
            Instance.new("UICorner", MonitorFrame).CornerRadius = UDim.new(0, 6)
            local BoxStroke = Instance.new("UIStroke", MonitorFrame) BoxStroke.Color = Color3.fromRGB(150, 20, 20) BoxStroke.Thickness = 1

            local ServerTimeText = Instance.new("TextLabel")
            ServerTimeText.Size = UDim2.new(1, -20, 0, 25)
            ServerTimeText.Position = UDim2.new(0, 12, 0, 8)
            ServerTimeText.BackgroundTransparency = 1
            ServerTimeText.Font = Enum.Font.GothamBold
            ServerTimeText.Text = "⏳ Đang quét dữ liệu server..."
            ServerTimeText.TextColor3 = Color3.fromRGB(255, 215, 0)
            ServerTimeText.TextSize = 12
            ServerTimeText.TextXAlignment = Enum.TextXAlignment.Left
            ServerTimeText.ZIndex = 4
            ServerTimeText.Parent = MonitorFrame

            local MoonStateText = Instance.new("TextLabel")
            MoonStateText.Size = UDim2.new(1, -20, 0, 25)
            MoonStateText.Position = UDim2.new(0, 12, 0, 33)
            MoonStateText.BackgroundTransparency = 1
            MoonStateText.Font = Enum.Font.GothamBold
            MoonStateText.Text = "🌙 Tình hình trăng: Đang kiểm tra..."
            MoonStateText.TextColor3 = Color3.fromRGB(200, 200, 255)
            MoonStateText.TextSize = 12
            MoonStateText.TextXAlignment = Enum.TextXAlignment.Left
            MoonStateText.ZIndex = 4
            MoonStateText.Parent = MonitorFrame

            local IslandStatusText = Instance.new("TextLabel")
            IslandStatusText.Size = UDim2.new(1, -20, 0, 90)
            IslandStatusText.Position = UDim2.new(0, 12, 0, 62)
            IslandStatusText.BackgroundTransparency = 1
            IslandStatusText.Font = Enum.Font.GothamMedium
            IslandStatusText.Text = ""
            IslandStatusText.TextColor3 = Color3.fromRGB(240, 240, 240)
            IslandStatusText.TextSize = 11
            IslandStatusText.TextXAlignment = Enum.TextXAlignment.Left
            IslandStatusText.TextYAlignment = Enum.TextYAlignment.Top
            IslandStatusText.LineHeight = 1.3
            IslandStatusText.ZIndex = 4
            IslandStatusText.Parent = MonitorFrame

            local Lighting = game:GetService("Lighting")
            task.spawn(function()
                while true do
                    local t = workspace.DistributedGameTime
                    local hours = math.floor(t / 3600)
                    local mins = math.floor((t % 3600) / 60)
                    local secs = math.floor(t % 60)
                    ServerTimeText.Text = string.format("⏳ Thời gian Server: %02d giờ %02d phút %02d giây", hours, mins, secs)

                    local clockTime = Lighting.ClockTime
                    if clockTime >= 5 and clockTime <= 18 then
                        MoonStateText.Text = "☀️ Tình hình trăng: Ban ngày (Không có trăng)"
                        MoonStateText.TextColor3 = Color3.fromRGB(255, 180, 50)
                    else
                        if Lighting:AttributeValueWithDefault("FullMoonActive", false) == true then
                            MoonStateText.Text = "🌕 TRĂNG TRÒN (FULL MOON ĐANG HOẠT ĐỘNG!)"
                            MoonStateText.TextColor3 = Color3.fromRGB(255, 50, 50)
                        else
                            MoonStateText.Text = "🌙 Tình hình trăng: Ban đêm (Trăng thường)"
                            MoonStateText.TextColor3 = Color3.fromRGB(200, 200, 255)
                        end
                    end

                    local islands = { Mirage = "❌ Chưa xuất hiện", Kitsune = "❌ Chưa xuất hiện", Dragon = "❌ Chưa xuất hiện", Leviathan = "❌ Chưa xuất hiện" }
                    for _, object in pairs(workspace:GetChildren()) do
                        if object.Name == "Mirage Island" or object:FindFirstChild("MirageIsland") then
                            islands.Mirage = "✅ ĐÃ XUẤT HIỆN!"
                        elseif object.Name == "Kitsune Island" or string.find(string.lower(object.Name), "kitsune") then
                            islands.Kitsune = "✅ ĐÃ XUẤT HIỆN!"
                        elseif string.find(string.lower(object.Name), "leviathan") or workspace:FindFirstChild("Leviathan") then
                            islands.Leviathan = "✅ ĐÃ XUẤT HIỆN!"
                        elseif string.find(string.lower(object.Name), "dragon") then
                            islands.Dragon = "✅ ĐÃ XUẤT HIỆN!"
                        end
                    end

                    IslandStatusText.Text = string.format(
                        "🏝️ Đảo Bí Ẩn (Mirage):  %s\n" ..
                        "🦊 Đảo Cáo (Kitsune):  %s\n" ..
                        "🐉 Đảo Rồng:  %s\n" ..
                        "🌊 Đảo Leviathan:  %s",
                        islands.Mirage, islands.Kitsune, islands.Dragon, islands.Leviathan
                    )
                    task.wait(1)
                end
            end)
        end

        return {Select = Select, AddToggle = AddToggle, AddSlider = AddSlider, AddDropdown = AddDropdown, AddServerMonitorBox = AddServerMonitorBox, ScaleObject = HubScale}
    end

    -- KHỞI TẠO CÁC CỬA SỔ CHÍNH
    local Tab1 = CreateTab("🏠 Trang chủ ", 10747373999)
    local Tab2 = CreateTab("👨‍🌾 Pham      ", 10747383471)
    local Tab3 = CreateTab("⛵ Event biển", 10747362071)
    local Tab4 = CreateTab("🍎 Trái cây  ", 10747371971)
    local Tab5 = CreateTab("⚔️ Combat    ", 10747373999)
    local Tab6 = CreateTab("🌀 Dịch      ", 10747383471)
    local Tab7 = CreateTab("⚙️ Cài đặt    ", 10747362071)
    local Tab8 = CreateTab("🛒 Cửa hàng  ", 10747371971)
    local Tab9 = CreateTab("🏰 Dungeon    ", 10747373999)

    Tab1.Select()
  
  Tab4.AddToggle("Auto nhặt trái ác quỷ ", 10747371971, function(TrangThai)
    if TrangThai then
        print(" Đang nhặt trái ác quỷ...")
        -- Đoạn code xử lý auto raid của bạn nhét ở đây
    else
        print("Đã nhặt trái ác quỷ .")
    end
end)
      Tab4.AddToggle("Auto lưu trái ác quỷ ", 10747371971, function(TrangThai)
    if TrangThai then
        print(" Đang lưu trái ác quỷ...")
        -- Đoạn code xử lý auto raid của bạn nhét ở đây
    else
        print("Đã lưu trái ác quỷ .")
    end
end)
  local DanhSachRaid = {"Lửa", "Băng", "Trấn Động", "Ánh Sáng", "Bóng Tối", "Phật Tổ", "Dung Nham"}
local RaidDaChon = "Flame"

Tab4.AddDropdown("Chọn Loại Raid:", DanhSachRaid, RaidDaChon, function(LuaChon)
    RaidDaChon = LuaChon
    print("Đã chọn Raid trái:", RaidDaChon)
end)
    local DanhSachVuKhi = {"Kiếm (Sword)", "Trái Ác Quỷ (Fruit)", "Súng (Gun)", "Cận Chiến (Melee)"}
    local VuKhiDaChon = "Kiếm (Sword)" 

    Tab2.AddDropdown("Chọn Công Cụ Farm:", DanhSachVuKhi, VuKhiDaChon, function(LuaChon)
        VuKhiDaChon = LuaChon
    end)

    Tab2.AddToggle("Bật Auto Farm ", 10747373999, function(TrangThai) end)
    Tab2.AddToggle("Bật Auto Farm Xương", 10747373999, function(v) end)
    Tab2.AddToggle("Bật Auto Farm Nguyên Liệu", 10747373999, function(v) end)

    -- CHUYỂN NÚT NHẬN CODE SANG TAB 8 (CỬA HÀNG)
    Tab8.AddToggle("Tự Động Nhận Code", 10747373999, function(v) end)
    
    -- GIỮ LẠI KHU VỰC THEO DÕI SERVER TẠI TAB 1
    Tab1.AddServerMonitorBox()

    Tab7.AddSlider("Kích Thước Giao Diện Hub (%)", 10747362071, 50, 150, 100, function(value)
        HubScale.Scale = value / 100
    end)
end

PlayWelcomeSplash(function()
    LoadMainMenu()
end)
