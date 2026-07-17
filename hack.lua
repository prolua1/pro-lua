-- ========================================================
-- TUẤN LỌ HUB - PHONG CÁCH REDZ HUB (ĐÃ THÊM DROPDOWN CHỌN VŨ KHÍ)
-- ========================================================

-- 1. TẠO SCREEN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TuanLoRedzHub"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- 2. KHUNG MENU CHÍNH
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 340)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 9)
MainCorner.Parent = MainFrame

-- TẠO UISCALE ĐỂ PHÓNG TO/THU NHỎ ĐỒNG BỘ
local MenuScale = Instance.new("UIScale")
MenuScale.Scale = 1.0
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

-- NÚT "×" ĐỂ TẮT HẲN HACK (DESTROY HOÀN TOÀN)
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -40, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(150, 150, 150)
CloseButton.TextSize = 22
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Parent = TopBar

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
    Page.CanvasSize = UDim2.new(0, 0, 0, 450) -- Tăng CanvasSize để chứa thêm Dropdown thoải mái
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

-- 5. HÀM TẠO NÚT CHỨC NĂNG THƯỜNG
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

-- 6. HÀM TẠO NÚT BẬT/TẮT (TOGGLE)
local function CreateToggleButton(parentPage, btnText, defaultState, callback)
    local enabled = defaultState or false
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(1, 0, 0, 38)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    ToggleButton.Text = "  " .. btnText
    ToggleButton.TextColor3 = Color3.fromRGB(230, 230, 230)
    ToggleButton.Font = Enum.Font.SourceSans
    ToggleButton.TextSize = 14
    ToggleButton.TextXAlignment = Enum.TextXAlignment.Left
    ToggleButton.Parent = parentPage
    
    local tbCorner = Instance.new("UICorner")
    tbCorner.CornerRadius = UDim.new(0, 6)
    tbCorner.Parent = ToggleButton
    
    local Line = Instance.new("Frame")
    Line.Size = UDim2.new(0, 3, 1, 0)
    Line.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    Line.BorderSizePixel = 0
    Line.Parent = ToggleButton
    local lineCorner = Instance.new("UICorner")
    lineCorner.CornerRadius = UDim.new(0, 4)
    lineCorner.Parent = Line

    local SwitchFrame = Instance.new("Frame")
    SwitchFrame.Size = UDim2.new(0, 34, 0, 18)
    SwitchFrame.Position = UDim2.new(1, -45, 0.5, -9)
    SwitchFrame.BackgroundColor3 = enabled and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(50, 50, 50)
    SwitchFrame.BorderSizePixel = 0
    SwitchFrame.Parent = ToggleButton
    local sfCorner = Instance.new("UICorner")
    sfCorner.CornerRadius = UDim.new(1, 0)
    sfCorner.Parent = SwitchFrame
    
    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 14, 0, 14)
    Circle.Position = enabled and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Circle.BorderSizePixel = 0
    Circle.Parent = SwitchFrame
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = Circle
    
    ToggleButton.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            SwitchFrame.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            Circle.Position = UDim2.new(1, -16, 0.5, -7)
        else
            SwitchFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Circle.Position = UDim2.new(0, 2, 0.5, -7)
        end
        callback(enabled)
    end)
end

-- 7. HÀM TẠO THANH KÉO (SLIDER)
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
    SlideBar.Parent = SliderFrame
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


-- 8. HÀM TẠO DROPDOWN CHỌN LỰA (MỚI THÊM)
local function CreateDropdown(parentPage, dropdownText, optionsList, defaultOption, callback)
    local isOpened = false
    
    -- Khung tổng chứa toàn bộ Dropdown
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Name = "Dropdown_" .. dropdownText
    DropdownFrame.Size = UDim2.new(1, 0, 0, 38) -- Khi đóng thì cao 38
    DropdownFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    DropdownFrame.ClipsDescendants = true
    DropdownFrame.Parent = parentPage
    
    local dfCorner = Instance.new("UICorner")
    dfCorner.CornerRadius = UDim.new(0, 6)
    dfCorner.Parent = DropdownFrame
    
    -- Đường line đỏ trang trí bên trái
    local Line = Instance.new("Frame")
    Line.Size = UDim2.new(0, 3, 0, 38)
    Line.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    Line.BorderSizePixel = 0
    Line.Parent = DropdownFrame
    local lineCorner = Instance.new("UICorner")
    lineCorner.CornerRadius = UDim.new(0, 4)
    lineCorner.Parent = Line
    
    -- Nút bấm chính để mở/đóng Dropdown
    local MainBtn = Instance.new("TextButton")
    MainBtn.Size = UDim2.new(1, 0, 0, 38)
    MainBtn.BackgroundTransparency = 1
    MainBtn.Text = "  " .. dropdownText .. ": " .. tostring(defaultOption)
    MainBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
    MainBtn.Font = Enum.Font.SourceSansBold
    MainBtn.TextSize = 14
    MainBtn.TextXAlignment = Enum.TextXAlignment.Left
    MainBtn.Parent = DropdownFrame
    
    -- Mũi tên chỉ hướng đóng/mở
    local Arrow = Instance.new("TextLabel")
    Arrow.Size = UDim2.new(0, 30, 0, 38)
    Arrow.Position = UDim2.new(1, -35, 0, 0)
    Arrow.BackgroundTransparency = 1
    Arrow.Text = "▼"
    Arrow.TextColor3 = Color3.fromRGB(150, 150, 150)
    Arrow.TextSize = 12
    Arrow.Parent = MainBtn
    
    -- Khung chứa danh sách các lựa chọn khi xổ xuống
    local OptionsContainer = Instance.new("Frame")
    OptionsContainer.Size = UDim2.new(1, -10, 0, #optionsList * 32)
    OptionsContainer.Position = UDim2.new(0, 5, 0, 42)
    OptionsContainer.BackgroundTransparency = 1
    OptionsContainer.Parent = DropdownFrame
    
    local ocLayout = Instance.new("UIListLayout")
    ocLayout.Parent = OptionsContainer
    ocLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ocLayout.Padding = UDim.new(0, 4)
    
    -- Hàm cập nhật chiều cao của trang chứa Dropdown để không bị đè chữ
    local function UpdatePageLayout()
        local function FindListLayout(obj)
            for _, child in pairs(obj:GetChildren()) do
                if child:IsA("UIListLayout") then return child end
            end
        end
        local layout = FindListLayout(parentPage)
        if layout then
            parentPage.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 30)
        end
    end

    -- Tạo các nút lựa chọn bên trong
    for i, option in ipairs(optionsList) do
        local OptionBtn = Instance.new("TextButton")
        OptionBtn.Size = UDim2.new(1, 0, 0, 28)
        OptionBtn.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
        OptionBtn.Text = tostring(option)
        OptionBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        OptionBtn.Font = Enum.Font.SourceSans
        OptionBtn.TextSize = 13
        OptionBtn.Parent = OptionsContainer
        
        local opCorner = Instance.new("UICorner")
        opCorner.CornerRadius = UDim.new(0, 4)
        opCorner.Parent = OptionBtn
        
        -- Khi người dùng click chọn 1 vũ khí
        OptionBtn.MouseButton1Click:Connect(function()
            MainBtn.Text = "  " .. dropdownText .. ": " .. tostring(option)
            isOpened = false
            Arrow.Text = "▼"
            DropdownFrame.Size = UDim2.new(1, 0, 0, 38) -- Đóng lại
            UpdatePageLayout()
            callback(option) -- Trả dữ liệu vũ khí được chọn về code chính
        end)
    end
    
    -- Click nút chính để toggle đóng/mở Dropdown
    MainBtn.MouseButton1Click:Connect(function()
        isOpened = not isOpened
        if isOpened then
            Arrow.Text = "▲"
            local totalHeight = 42 + (#optionsList * 32)
            DropdownFrame.Size = UDim2.new(1, 0, 0, totalHeight) -- Xổ ra
        else
            Arrow.Text = "▼"
            DropdownFrame.Size = UDim2.new(1, 0, 0, 38) -- Thu lại
        end
        UpdatePageLayout()
    end)
end


-- ========================================================
-- KÍCH HOẠT VÀ PHÂN CHIA 8 TRANG THEO THỨ TỰ
-- ========================================================

local Tab1_TrangChu   = CreateTab("🏠", 1)
local Tab2_Pham    = CreateTab("👨‍🌾", 2)
local Tab3_Thuyen     = CreateTab("⛵", 3)
local Tab4_TraiCay    = CreateTab("🍎", 4)
local Tab5_Combat   = CreateTab("⚔️", 5)
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

CreateSlider(Tab1_TrangChu, "Độ To Nhỏ Menu", 50, 150, 100, function(percentValue)
    local scaleFactor = percentValue / 100
    MenuScale.Scale = scaleFactor
end)


-- 👨‍🌾 TAB 2: NÔNG DÂN (ĐÃ THÊM DROPDOWN VŨ KHÍ PHẠM)
local VuKhiDuocChon = "Melee" -- Biến lưu trữ vũ khí đang chọn mặc định

CreateDropdown(Tab2_NongDan, "Chọn Vũ Khí Farm", {"Melee", "Sword", "Gun", "Fruit"}, "Melee", function(selectedOption)
    VuKhiDuocChon = selectedOption
    print("Bạn đã chọn vũ khí farm là: " .. VuKhiDuocChon)
    -- Chỗ này sau này bạn có thể viết thêm code tự động cầm vũ khí lên để farm
end)

CreateToggleButton(Tab2_NongDan, "Tự Động Đánh Quái (Auto Farm)", false, function(state)
    if state == true then
        print("Đang bật Auto Farm bằng: " .. VuKhiDuocChon)
        -- Code Auto Farm chạy tại đây sẽ sử dụng biến `VuKhiDuocChon` để biết nên dùng gì để đánh
    else
        print("Đã tắt Auto Farm!")
    end
end)


-- ⛵ TAB 3: THUYỀN
CreateFunctionButton(Tab3_Thuyen, "Tự động mua thuyền nhanh", function()
    print("Mua thuyền...")
end)


-- 🍎 TAB 4: TRÁI CÂY
CreateToggleButton(Tab4_TraiCay, "Tự Động Nhặt Trái Ác Quỷ", false, function(state)
    if state == true then
        print("Đang tìm trái...")
    else
        print("Đã dừng!")
    end
end)


-- ⚔️ TAB 5: SỨC MẠNH / KIẾM
CreateToggleButton(Tab5_AutoFarm, "Tự Động Nhặt Rương", false, function(state)
    if state == true then
        print("Đang nhặt rương...")
    else
        print("Đã dừng nhặt rương!")
    end
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
CreateToggleButton(Tab7_CaiDat, "Bật Nhảy Vô Hạn (Infinite Jump)", false, function(state)
    print("Infinite Jump state: ", state)
end)


-- 🛒 TAB 8: GIỎ HÀNG
CreateFunctionButton(Tab8_GioHang, "Mua vũ khí/vật phẩm tự động", function()
    print("Đang mở shop...")
end)


-- ========================================================
-- 9. NÚT OPEN (LUÔN XUẤT HIỆN NGAY TỪ ĐẦU)
-- ========================================================
local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0, 45, 0, 45)
OpenButton.Position = UDim2.new(0, 10, 0.5, -22)
OpenButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
OpenButton.Text = "OPEN"
OpenButton.Font = Enum.Font.SourceSansBold
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.TextSize = 12
OpenButton.Visible = true
OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenButton

-- Logic kéo thả cho nút OPEN
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


-- ========================================================
-- XỬ LÝ ẨN/HIỆN QUA LẠI BẰNG NÚT OPEN VÀ NÚT TẮT HẲN
-- ========================================================

-- Khi click vào nút OPEN: Ẩn/Hiện chéo nhau với Menu chính
OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Khi click nút "×" trên Menu: Xóa sạch hoàn toàn hack ra khỏi game
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
