-- ========================================================
-- TUẤN LỌ HUB - PHONG CÁCH REDZ HUB (CÓ CHỨC NĂNG CHUYỂN TÁB)
-- ========================================================

-- 1. TẠO SCREEN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TuanLoRedzHub"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- 2. KHUNG MENU CHÍNH
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 320)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 9)
MainCorner.Parent = MainFrame

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
Title.TextColor3 = Color3.fromRGB(255, 50, 50) -- Đỏ đặc trưng Redz
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
SidebarLayout.Padding = UDim.new(0, 8)
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Khởi tạo danh sách quản lý các trang
local Tabs = {}
local TabButtons = {}
local currentTab = nil

-- Hàm tạo trang mới và nút Icon tương ứng
local function CreateTab(emojiText, order)
    -- A. Tạo khung chứa chức năng riêng cho trang này (Mặc định ẩn đi)
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

    -- B. Tạo nút bấm Icon trên thanh Sidebar
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(0, 35, 0, 35)
    TabBtn.BackgroundTransparency = 1
    TabBtn.Text = emojiText
    TabBtn.TextSize = 20
    TabBtn.Font = Enum.Font.SourceSansBold
    TabBtn.TextColor3 = Color3.fromRGB(150, 150, 150) -- Mặc định màu xám
    TabBtn.LayoutOrder = order
    TabBtn.Parent = Sidebar

    -- C. Xử lý logic khi bấm vào nút chuyển trang
    local function KichHoatTab()
        -- Ẩn trang hiện tại, đổi màu nút cũ thành xám
        for _, p in pairs(Tabs) do p.Visible = false end
        for _, b in pairs(TabButtons) do b.TextColor3 = Color3.fromRGB(150, 150, 150) end

        -- Hiện trang mới được chọn, đổi nút sang màu đỏ phát sáng
        Page.Visible = true
        TabBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
    end

    TabBtn.MouseButton1Click:Connect(KichHoatTab)

    table.insert(Tabs, Page)
    table.insert(TabButtons, TabBtn)

    -- Trả về khung Page để chúng ta nhét nút chức năng vào đúng trang đó
    return Page
end

-- 5. HÀM TẠO NÚT CHỨC NĂNG TRONG TỪNG TRANG
local function CreateFunctionButton(parentPage, btnText, codeFunction)
    local NewButton = Instance.new("TextButton")
    NewButton.Size = UDim2.new(1, 0, 0, 38)
    NewButton.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    NewButton.Text = "  " .. btnText
    NewButton.TextColor3 = Color3.fromRGB(230, 230, 230)
    NewButton.Font = Enum.Font.SourceSans
    NewButton.TextSize = 14
    NewButton.TextXAlignment = Enum.TextXAlignment.Left
    NewButton.Parent = parentPage -- Nhét vào đúng trang được chỉ định
    
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

-- ========================================================
-- KÍCH HOẠT VÀ PHÂN CHIA CÁC TRANG (TABS)
-- ========================================================

-- Tạo 3 trang chính và lưu vào 3 biến riêng biệt
local TrangChu = CreateTab("🏠", 1)
local AutoFarm = CreateTab("⚔️", 2)
local DichChuyen = CreateTab("🌀", 3)

-- Mặc định khi mở Hub lên sẽ hiển thị Trang Chủ trước
Tabs[1].Visible = true
TabButtons[1].TextColor3 = Color3.fromRGB(255, 50, 50)


-- ========================================================
-- DÁN CHỨC NĂNG VÀO ĐÚNG TỪNG TRANG THEO ICON
-- ========================================================

-- 🏠 CÁC NÚT Ở TRANG CHỦ
CreateFunctionButton(TrangChu, "Chào mừng bạn đến với Tuấn Lọ PRO Hub!", function()
    print("Thông tin Hub")
end)

-- ⚔️ CÁC NÚT Ở TRANG AUTO FARM
CreateFunctionButton(AutoFarm, "Bật Tự Động Nhặt Rương", function()
    print("Đang nhặt rương...")
end)

CreateFunctionButton(AutoFarm, "Bật Auto Farm Level", function()
    print("Đang farm...")
end)

-- 🌀 CÁC NÚT Ở TRANG DỊCH CHUYỂN
CreateFunctionButton(DichChuyen, "Dịch Chuyển Về Đảo Khởi Đầu", function()
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


-- ========================================================
-- 7. NÚT OPEN DI CHUYỂN ĐƯỢC (Giữ nguyên cấu trúc cũ)
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

local UserInputService = game:GetService("UserInputService")
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
