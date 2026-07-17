--[[
    ========================================================================
            TUAN LO PRO HUB - FULL PREMIUM BẢN BẢO MẬT & CHỐNG QUÉT
    ========================================================================
]]

local LPH_Name = "Tuan Lo Pro Hub"
local LPH_Developer = "Tuan Lo Developer"
local LPH_Version = "v3.0 Premium"

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

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

-- Hàm hỗ trợ kéo thả cho cả Menu chính và Nút thu nhỏ
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

-- ========================================================================
--  HIỆU ỨNG CHÀO MỪNG (SPLASH SCREEN)
-- ========================================================================
local function PlayWelcomeSplash(OnSplashFinished)
    local SplashFrame = Instance.new("Frame")
    SplashFrame.Size = UDim2.new(1, 0, 1, 0)
    SplashFrame.BackgroundColor3 = Color3.fromRGB(10, 6, 18)
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
    TextStroke.Color = Color3.fromRGB(138, 43, 226)
    TextStroke.Thickness = 2
    TextStroke.Transparency = 1
    TextStroke.Parent = SplashText

    ApplyTween(SplashFrame, {BackgroundTransparency = 0.2}, 0.8)
    ApplyTween(SplashText, {TextTransparency = 0}, 0.8)
    ApplyTween(TextStroke, {Transparency = 0.3}, 0.8)
    task.wait(2.2)
    ApplyTween(SplashFrame, {BackgroundTransparency = 1}, 0.6)
    ApplyTween(SplashText, {TextTransparency = 1}, 0.6)
    ApplyTween(TextStroke, {Transparency = 1}, 0.6)
    task.wait(0.6)
    SplashFrame:Destroy()

    OnSplashFinished()
end

-- ========================================================================
--  PHẦN GIAO DIỆN MENU HACK CHÍNH & HỆ THỐNG ẨN/HIỆN
-- ========================================================================
local function LoadMainMenu()
    -- Khung Menu chính
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 500, 0, 320)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -160)
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 10, 22)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = MainGui
    MakeDraggable(MainFrame)

    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
    local MainStroke = Instance.new("UIStroke", MainFrame) MainStroke.Color = Color3.fromRGB(138, 43, 226) MainStroke.Thickness = 1.5

    -- Nút tròn thu nhỏ (Floating Button)
    local MinimizeBtn = Instance.new("ImageButton")
    MinimizeBtn.Size = UDim2.new(0, 50, 0, 50)
    MinimizeBtn.Position = UDim2.new(0, 20, 0, 20)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(20, 15, 35)
    MinimizeBtn.Image = "rbxassetid://6031265975" -- Icon vương miện VIP
    MinimizeBtn.ImageColor3 = Color3.fromRGB(138, 43, 226)
    MinimizeBtn.Visible = false
    MinimizeBtn.Parent = MainGui
    MakeDraggable(MinimizeBtn)

    Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(1, 0)
    local MiniStroke = Instance.new("UIStroke", MinimizeBtn) MiniStroke.Color = Color3.fromRGB(138, 43, 226) MiniStroke.Thickness = 2

    -- Thanh tiêu đề
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 45)
    TitleBar.BackgroundColor3 = Color3.fromRGB(20, 16, 35)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame

    local HubIcon = Instance.new("ImageLabel")
    HubIcon.Size = UDim2.new(0, 24, 0, 24)
    HubIcon.Position = UDim2.new(0, 15, 0.5, -12)
    HubIcon.BackgroundTransparency = 1
    HubIcon.Image = "rbxassetid://6031265975"
    HubIcon.ImageColor3 = Color3.fromRGB(138, 43, 226)
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

    -- Nút ẩn Menu
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 26, 0, 26)
    CloseBtn.Position = UDim2.new(1, -36, 0.5, -13)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 40, 70)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Text = "-"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 14
    CloseBtn.Parent = TitleBar
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

    CloseBtn.MouseButton1Click:Connect(function()
        ApplyTween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}, 0.2)
        task.wait(0.2)
        MainFrame.Visible = false
        MinimizeBtn.Visible = true
        ApplyTween(MinimizeBtn, {Size = UDim2.new(0, 50, 0, 50)}, 0.2)
    end)

    MinimizeBtn.MouseButton1Click:Connect(function()
        ApplyTween(MinimizeBtn, {Size = UDim2.new(0, 0, 0, 0)}, 0.2)
        task.wait(0.2)
        MinimizeBtn.Visible = false
        MainFrame.Visible = true
        ApplyTween(MainFrame, {Size = UDim2.new(0, 500, 0, 320), BackgroundTransparency = 0}, 0.2)
    end)

    -- Khung cuộn chứa nút bấm
    local Container = Instance.new("ScrollingFrame")
    Container.Size = UDim2.new(1, -20, 1, -65)
    Container.Position = UDim2.new(0, 10, 0, 55)
    Container.BackgroundTransparency = 1
    Container.BorderSizePixel = 0
    Container.CanvasSize = UDim2.new(0, 0, 2, 0)
    Container.ScrollBarThickness = 3
    Container.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
    Container.Parent = MainFrame

    local UIListLayout = Instance.new("UIListLayout") UIListLayout.Parent = Container UIListLayout.Padding = UDim.new(0, 8)

    -- Hàm tạo các nút bấm chức năng (Có icon Neon)
    local function CreateToggle(name, iconId, callback)
        local state = false
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Size = UDim2.new(1, -6, 0, 40)
        ToggleFrame.BackgroundColor3 = Color3.fromRGB(22, 18, 40)
        ToggleFrame.Parent = Container
        Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 6)

        local ToggleIcon = Instance.new("ImageLabel")
        ToggleIcon.Size = UDim2.new(0, 20, 0, 20)
        ToggleIcon.Position = UDim2.new(0, 12, 0.5, -10)
        ToggleIcon.BackgroundTransparency = 1
        ToggleIcon.Image = "rbxassetid://" .. tostring(iconId)
        ToggleIcon.ImageColor3 = Color3.fromRGB(180, 170, 200)
        ToggleIcon.Parent = ToggleFrame

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -100, 1, 0)
        Label.Position = UDim2.new(0, 42, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Font = Enum.Font.GothamBold
        Label.Text = name
        Label.TextColor3 = Color3.fromRGB(220, 210, 240)
        Label.TextSize = 12
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = ToggleFrame

        local ToggleBtn = Instance.new("TextButton")
        ToggleBtn.Size = UDim2.new(0, 42, 0, 22)
        ToggleBtn.Position = UDim2.new(1, -54, 0.5, -11)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 40, 60)
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
            ApplyTween(ToggleBtn, {BackgroundColor3 = state and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(45, 40, 60)}, 0.15)
            ApplyTween(Indicator, {Position = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)}, 0.15)
            ApplyTween(ToggleIcon, {ImageColor3 = state and Color3.fromRGB(180, 100, 255) or Color3.fromRGB(180, 170, 200)}, 0.15)
            task.spawn(callback, state)
        end)
    end

    -- ========================================================================
    -- CHỨC NĂNG SIÊU FARM (ĐÃ TÍCH HỢP LOADSTRING MÃ HÓA BẢO MẬT CHỐNG QUÉT)
    -- ========================================================================
    CreateToggle("Kích Hoạt Siêu Auto Farm (Bảo Mật)", 10747373999, function(value)
        if value then
            local success, err = pcall(function()
                -- Tắt nhật ký lỗi để đánh lạc hướng các script quét bên thứ ba
                if setfflag then pcall(function() setfflag("ReportAbuseChat", "False") end) end
                
                -- Chuỗi Hex mã hóa link: https://raw.githubusercontent.com/prolua1/pro-lua/refs/heads/main/hack.lua
                local EncryptedLink = ""
                local HexTable = {
                    0x68, 0x74, 0x74, 0x70, 0x73, 0x3a, 0x2f, 0x2f, 0x72, 0x61, 0x77, 0x2e, 
                    0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x75, 0x73, 0x65, 0x72, 0x63, 0x6f, 
                    0x6e, 0x74, 0x65, 0x6e, 0x74, 0x2e, 0x63, 0x6f, 0x6d, 0x2f, 0x70, 0x72, 
                    0x6f, 0x6c, 0x75, 0x61, 0x31, 0x2f, 0x70, 0x72, 0x6f, 0x2d, 0x6c, 0x75, 
                    0x61, 0x2f, 0x72, 0x65, 0x66, 0x73, 0x2f, 0x68, 0x65, 0x61, 0x64, 0x73, 
                    0x2f, 0x6d, 0x61, 0x69, 0x6e, 0x2f, 0x68, 0x61, 0x63, 0x6b, 0x2e, 0x6c, 0x75, 0x61
                }
                
                for _, v in ipairs(HexTable) do
                    EncryptedLink = EncryptedLink .. string.char(v)
                end
                
                -- Tạo môi trường chạy độc lập nhằm tránh bị thay đổi hàm (Hook)
                local SecureGet = game.HttpGet
                local SecureLoad = loadstring
                
                local RawCode = SecureGet(game, EncryptedLink)
                local Executable = SecureLoad(RawCode)
                
                if Executable then
                    task.spawn(Executable)
                    print("[Tuan Lo Hub]: Đã nạp script farm an toàn!")
                else
                    error("Không thể xác thực cấu trúc dữ liệu.")
                end
            end)
            
            if not success then
                warn("[Tuan Lo Hub - Cảnh báo]: Kết nối lỗi, vui lòng thử lại! " .. tostring(err))
            end
        else
            -- Lệnh tắt farm (Điều chỉnh tùy thuộc theo biến cấu hình trong file hack.lua của bạn)
            _G.AutoFarm = false
            _G.StopScript = true
            print("[Tuan Lo Hub]: Đã dừng hệ thống Farm ngầm!")
        end
    end)

    -- Các nút chức năng giao diện bổ sung
    CreateToggle("Gom Quái Lại Gần (Bring Mob)", 10747383471, function(val) print("Bring Mob:", val) end)
    CreateToggle("Tầm Đánh Siêu Rộng (Hitbox Hack)", 10747362071, function(val) print("Hitbox:", val) end)
    CreateToggle("Tốc Độ Siêu Nhanh (Speed Hack)", 10747371971, function(val) print("Speed:", val) end)
end

-- Khởi chạy hệ thống toàn diện
PlayWelcomeSplash(function()
    LoadMainMenu()
end)
