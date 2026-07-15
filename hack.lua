print " hello "
-- ========================================================
-- SCRIPT TẠO MENU VÀ NHÉT CÁC NÚT CHỨC NĂNG VÀO BÊN TRONG
-- ========================================================

-- 1. TẠO SCREEN GUI (Như cũ)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MyFeatureMenu"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- 2. KHUNG MENU CHÍNH (Như cũ)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- 3. TIÊU ĐỀ MENU (Như cũ)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Text = "  MENU TÍNH NĂNG CỦA TÔI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.Parent = MainFrame

-- 4. NÚT THU GỌN VÀ PHÓNG TO (Như cũ)
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 35, 0, 35)
MinimizeButton.Position = UDim2.new(1, -35, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Parent = MainFrame

local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0, 50, 0, 50)
OpenButton.Position = UDim2.new(0, 10, 0.5, -25)
OpenButton.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
OpenButton.Text = "OPEN"
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.Visible = false
OpenButton.Parent = ScreenGui
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = OpenButton

MinimizeButton.MouseButton1Click:Connect(function() MainFrame.Visible = false; OpenButton.Visible = true end)
OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = true; OpenButton.Visible = false end)

-- ========================================================
-- PHẦN MỚI: NHÉT CÁC NÚT CHỨC NĂNG VÀO ĐÂY
-- ========================================================

-- A. Tạo một "Khung Chứa Nút" (Bỏ vào trong MainFrame, chừa phần tiêu đề ra)
local Container = Instance.new("ScrollingFrame")
Container.Name = "Container"
Container.Size = UDim2.new(1, -20, 1, -55) -- Chiếm toàn bộ chiều rộng, chừa 55 pixel phía trên
Container.Position = UDim2.new(0, 10, 0, 45) -- Cách lề trên 45 pixel (dưới tiêu đề)
Container.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Màu nền nhạt hơn tí
Container.BorderSizePixel = 0
Container.CanvasSize = UDim2.new(0, 0, 0, 300) -- Kích thước vùng cuộn chuột
Container.Parent = MainFrame

-- B. Tạo bộ tự động xếp hàng (UIListLayout) 
-- Cái này giúp các nút bạn tạo ra tự xếp thẳng hàng từ trên xuống dưới, cách nhau 5 pixel
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Container
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5) 

-- C. HÀM TẠO NÚT TÍNH NĂNG NHANH (Để bạn đỡ phải viết lại nhiều lần)
local function CreateFunctionButton(btnText, codeFunction)
    local NewButton = Instance.new("TextButton")
    NewButton.Size = UDim2.new(1, 0, 0, 40) -- Rộng bằng khung chứa, cao 40 pixel
    NewButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    NewButton.Text = btnText
    NewButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    NewButton.Font = Enum.Font.SourceSans
    NewButton.TextSize = 16
    NewButton.Parent = Container -- Nhét nút này vào Khung Chứa (Container)
    
    -- Khi người chơi click vào nút này, nó sẽ chạy hàm chức năng được truyền vào
    NewButton.MouseButton1Click:Connect(codeFunction)
    
    -- Thêm bo góc cho nút nhìn cho chuyên nghiệp
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = NewButton
end

-- D. BẮT ĐẦU NHÉT CÁC CHỨC NĂNG THỰC TẾ VÀO MENU

-- Chức năng 1: Nhặt Rương (Mô phỏng)
CreateFunctionButton("Bật Tự Động Nhặt Rương", function()
    print("Đang kích hoạt chức năng nhặt rương...")
    -- Bạn viết code dịch chuyển đến rương ở đây
end)

-- Chức năng 2: Auto Farm Level (Mô phỏng)
CreateFunctionButton("Bật Auto Farm Level", function()
    print("Đang chạy vòng lặp farm quái...")
    -- Bạn viết code gom quái ở đây
end)

-- Chức năng 3: Dịch chuyển về Đảo Khởi Đầu
CreateFunctionButton("Dịch Chuyển Về Đảo Khởi Đầu", function()
    print("Đang dịch chuyển...")
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        -- Tọa độ hòn đảo xuất phát trong Blox Fruit (Ví dụ minh họa tọa độ 0, 100, 0)
        player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 100, 0)
    end
end)
