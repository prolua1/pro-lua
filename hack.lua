-- ========================================================
-- TUẤN LỌ HUB - PHONG CÁCH REDZ HUB (SỬA LỖI SCALE BẰNG UISCALE)
-- ========================================================

-- 1. TẠO SCREEN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TuanLoRedzHub"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- 2. KHUNG MENU CHÍNH
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 340) -- Cố định kích thước gốc
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = false -- Đổi thành false để UIScale hoạt động tốt hơn
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 9)
MainCorner.Parent = MainFrame

-- [QUAN TRỌNG] TẠO UISCALE ĐỂ PHÓNG TO/THU NHỎ TOÀN BỘ MENU ĐỒNG BỘ
local MenuScale = Instance.new("UIScale")
MenuScale.Scale = 1.0 -- Mặc định là 100%
MenuScale.Parent = MainFrame

-- 3. THANH TIÊU ĐỀ PHÍA TRÊN (TopBar)
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 45, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Tuấn Lọ PRO"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.Parent = TopBar

local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Size = UDim2.new(0, 24, 0, 24)
Logo.Position = UDim2.new(0, 12, 0, 8)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://10850256191"
Logo.Parent = TopBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 40, 0, 40)
MinimizeButton.Position = UDim2.new(1, -40, 0, 0)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Text = "×"
MinimizeButton.TextColor3 = Color3.fromRGB(150, 150, 150)
MinimizeButton.TextSize = 20
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.Parent = TopBar

-- 4. THANH MENU BÊN TRÁI (Sidebar)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 45, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Parent = Sidebar
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Padding = UDim.new(0, 5)
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Khởi tạo danh sách quản lý các trang
local Tabs = {}
local TabButtons = {}

-- Hàm tạo trang mới và nút Icon tương ứng
local function CreateTab(emojiText, order)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = emojiText .. "_Page"
    Page.Size = UDim2.new(1, -60, 1, -55)
    Page.Position = UDim2.new(0, 55, 0, 48)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.CanvasSize = UDim2.new(0, 0, 0, 400)
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 50)
    Page.Visible = false
    Page.Parent = MainFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Page
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 6)

    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(0, 30, 0, 30)
    TabBtn.BackgroundTransparency = 1
    TabBtn.Text = emojiText
    TabBtn.TextSize = 16
    TabBtn.Font = Enum.Font.SourceSansBold
    TabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    TabBtn.LayoutOrder = order
    TabBtn.Parent = Sidebar

    local function KichHoatTab()
        for _, p in pairs(Tabs) do p.Visible = false end
        for _, b in pairs(TabButtons) do b.TextColor3 = Color3.fromRGB(150, 150, 150) end

        Page.Visible = true
        TabBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
    end

    TabBtn.MouseButton1Click:Connect(KichHoatTab)

    table.insert(Tabs, Page)
    table.insert(TabButtons, TabBtn)

    return Page
end

-- 5. HÀM TẠO NÚT CHỨC NĂNG
local function CreateFunctionButton(parentPage, btnText, codeFunction)
    local NewButton = Instance.new("TextButton")
    NewButton.Size = UDim2.new(1, 0, 0, 38)
    NewButton.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    NewButton.Text = "  " .. btnText
    NewButton.TextColor3 = Color3.fromRGB(230, 230, 230)
    NewButton.Font = Enum.Font.SourceSans
    NewButton.TextSize = 14
    NewButton.TextXAlignment = Enum.TextXAlignment.Left
    NewButton.Parent = parentPage
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = NewButton
    
    local Line = Instance.new("Frame")
    Line.Size = UDim2.new(0, 3, 1, 0)
    Line.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    Line.BorderSizePixel = 0
    Line.Parent = NewButton
    local lineCorner = Instance.new("UICorner")
    lineCorner.CornerRadius = UDim.new(0, 4)
    lineCorner.Parent = Line

    NewButton.MouseButton1Click:Connect(codeFunction)
end

-- 6. HÀM TẠO THANH KÉO (SLIDER) CHUẨN KÉO THẢ MƯỢT MÀ
local UserInputService = game:GetService("UserInputService")
local function CreateSlider(parentPage, sliderText, minVal, maxVal, defaultVal, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 50)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    SliderFrame.Parent = parentPage
    
    local sfCorner = Instance.new("UICorner")
    sfCorner.CornerRadius = UDim.new(0, 6)
    sfCorner.Parent = SliderFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 20)
    Label.Position = UDim2.new(0, 10, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Text = sliderText .. ": " .. defaultVal .. "%"
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.Font = Enum.Font.SourceSansBold
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame
    
    local SlideBar = Instance.new("Frame")
    SlideBar.Size = UDim2.new(1, -20, 0, 6)
    SlideBar.Position = UDim2.new(0, 10, 0, 32)
    SlideBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SlideBar.BorderSizePixel = 0
    SlideBar.Parent = SlideBarFrame or SliderFrame
    local sbCorner = Instance.new("UICorner")
    sbCorner.CornerRadius = UDim.new(1, 0)
    sbCorner.Parent = SlideBar
    
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    Fill.BorderSizePixel = 0
    Fill.Parent = SlideBar
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = Fill
    
    local Trigger = Instance.new("TextButton")
    Trigger.Size = UDim2.new(0, 12, 0, 12)
    Trigger.Position = UDim2.new((defaultVal - minVal) / (maxVal - minVal), -6, 0.5, -6)
    Trigger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Trigger.Text = ""
    Trigger.Parent = SlideBar
    local triggerCorner = Instance.new("UICorner")
    triggerCorner.CornerRadius = UDim.new(1, 0)
    triggerCorner.Parent = Trigger
    
    local dragging = false
    Trigger.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    local function updateSlider(input)
        local relativeX = input.Position.X - SlideBar.AbsolutePosition.X
        local percentage = math.clamp(relativeX / SlideBar.AbsoluteSize.X, 0, 1)
        Fill.Size = UDim2.new(percentage, 0, 1, 0)
        Trigger.Position = UDim2.new(percentage, -6, 0.5, -6)
        
        local value = math.round(minVal + (maxVal - minVal) * percentage)
        Label.Text = sliderText .. ": " .. value .. "%"
        callback(value)
    end
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input)
        end
    end)
end

-- ========================================================
-- KÍCH HOẠT VÀ PHÂN CHIA 8 TRANG THEO THỨ TỰ
-- ========================================================

local Tab1_TrangChu   = CreateTab("🏠", 1)
local Tab2_NongDan    = CreateTab("👨‍🌾", 2)
local Tab3_Thuyen     = CreateTab("⛵", 3)
local Tab4_TraiCay    = CreateTab("🍎", 4)
local Tab5_AutoFarm   = CreateTab("⚔️", 5)
local Tab6_DichChuyen = CreateTab("🌀", 6)
local Tab7_CaiDat     = CreateTab("⚙️", 7)
local Tab8_GioHang    = CreateTab("🛒", 8)

Tabs[1].Visible = true
TabButtons[1].TextColor3 = Color3.fromRGB(255, 50, 50)


-- ========================================================
-- PHÂN CHIA CHỨC NĂNG VÀO TỪNG TAB
-- ========================================================

-- 🏠 TAB 1: TRANG CHỦ
CreateFunctionButton(Tab1_TrangChu, "Chào mừng đến với Tuấn Lọ PRO Hub!", function()
    print("Welcome!")
end)

-- Tạo thanh kéo chỉnh cỡ Menu bằng UIScale (Giới hạn từ 50% đến 150% cực kỳ chuẩn xác)
CreateSlider(Tab1_TrangChu, "Độ To Nhỏ Menu", 50, 150, 100, function(percentValue)
    local scaleFactor = percentValue / 100
    -- Thay đổi scale của UIScale thay vì đổi size của Frame vật lý!
    MenuScale.Scale = scaleFactor
end)


-- 👨‍🌾 TAB 2: NÔNG DÂN
CreateFunctionButton(Tab2_NongDan, "Bật Auto Farm Level", function()
    print("Đang farm level...")
end)

-- ⛵ TAB 3: THUYỀN
CreateFunctionButton(Tab3_Thuyen, "Tự động mua thuyền nhanh", function()
    print("Mua thuyền...")
end)

-- 🍎 TAB 4: TRÁI CÂY
CreateFunctionButton(Tab4_TraiCay, "Tự động ăn/nhặt Trái Cây", function()
    print("Nhặt trái cây...")
end)

-- ⚔️ TAB 5: SỨC MẠNH / KIẾM
CreateFunctionButton(Tab5_AutoFarm, "Bật Tự Động Nhặt Rương", function()
    print("Đang nhặt rương...")
end)

-- 🌀 TAB 6: DỊCH CHUYỂN
CreateFunctionButton(Tab6_DichChuyen, "Dịch Chuyển Về Đảo Khởi Đầu", function()
    local player = game.Players.LocalPlayer
    local HRT = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if HRT then
        local currentPlaceId = game.PlaceId
        if currentPlaceId == 275391513 then
            HRT.CFrame = CFrame.new(1003, 16, 1420)
        elseif currentPlaceId == 444227218 then
            HRT.CFrame = CFrame.new(-20, 16, 1000)
        elseif currentPlaceId == 7449423635 then
            HRT.CFrame = CFrame.new(-5020, 315, -3152)
        end
    end
end)

-- ⚙️ TAB 7: CÀI ĐẶT
CreateFunctionButton(Tab7_CaiDat, "Cấu hình tốc độ bay dịch chuyển", function()
    print("Đã chỉnh cấu hình!")
end)

-- 🛒 TAB 8: GIỎ HÀNG
CreateFunctionButton(Tab8_GioHang, "Mua vũ khí/vật phẩm tự động", function()
    print("Đang mở shop...")
end)


-- ========================================================
-- 9. NÚT OPEN DI CHUYỂN ĐƯỢC
-- ========================================================
local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0, 45, 0, 45)
OpenButton.Position = UDim2.new(0, 10, 0.5, -22)
OpenButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
OpenButton.Text = "OPEN"
OpenButton.Font = Enum.Font.SourceSansBold
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.TextSize = 12
OpenButton.Visible = false
OpenButton.Parent = ScreenGui
local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenButton

local draggingOpenBtn = false
local dragInputOpenBtn, dragStartOpenBtn, startPosOpenBtn
local function updateOpenBtn(input)
    local delta = input.Position - dragStartOpenBtn
    OpenButton.Position = UDim2.new(startPosOpenBtn.X.Scale, startPosOpenBtn.X.Offset + delta.X, startPosOpenBtn.Y.Scale, startPosOpenBtn.Y.Offset + delta.Y)
end
OpenButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingOpenBtn = true; dragStartOpenBtn = input.Position; startPosOpenBtn = OpenButton.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then draggingOpenBtn = false end end)
    end
end)
OpenButton.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInputOpenBtn = input end end)
UserInputService.InputChanged:Connect(function(input) if input == dragInputOpenBtn and draggingOpenBtn then updateOpenBtn(input) end end)

MinimizeButton.MouseButton1Click:Connect(function() MainFrame.Visible = false; OpenButton.Visible = true end)
OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = true; OpenButton.Visible = false end)
