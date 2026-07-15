print " hello "
-- ========================================================
-- SCRIPT TẠO MENU VÀ NHÉT CÁC NÚT CHỨC NĂNG VÀO BÊN TRONG
-- ========================================================

-- 1. TẠO SCREEN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MyFeatureMenu"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- 2. KHUNG MENU CHÍNH
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
-- Thêm bo góc cho Khung Menu Chính (MainFrame)
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12) -- Số 12 là độ bo tròn góc, bạn có thể tăng lên 15 nếu muốn tròn hơn
MainCorner.Parent = MainFrame
-- ========================================================
-- 3. TIÊU ĐỀ MENU & LOGO THƯƠNG HIỆU (CẬP NHẬT)
-- ========================================================

-- A. Tạo chữ tiêu đề (Dịch sang phải một chút để nhường chỗ cho Logo)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Text = "       Tuấn Lọ PRO " 
Title.TextColor3 = Color3.fromRGB(255, 255, 0) 
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.Parent = MainFrame

-- B. Tạo khung chứa LOGO (Hình ảnh)
local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Size = UDim2.new(0, 25, 0, 25) -- Kích thước logo là 25x25 pixel (nhỏ gọn)
Logo.Position = UDim2.new(0, 8, 0, 5) -- Đặt ở góc trái, căn giữa thanh tiêu đề
Logo.BackgroundTransparency = 1 -- Làm trong suốt nền của ảnh
Logo.BorderSizePixel = 0

-- DÁN ID ẢNH LOGO CỦA BẠN VÀO ĐÂY:
-- (Dưới đây là một ID ảnh quả chuối mặc định của Roblox để bạn test thử)
Logo.Image = "rbxassetid://10850259160" 

Logo.Parent = MainFrame
-- 4. NÚT THU GỌN VÀ PHÓNG TO
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
-- ========================================================
-- CODE GIÚP NÚT OPEN CÓ THỂ KÉO THẢ DI CHUYỂN
-- ========================================================
local UserInputService = game:GetService("UserInputService")
local draggingOpenBtn = false
local dragInputOpenBtn, dragStartOpenBtn, startPosOpenBtn

local function updateOpenBtn(input)
    local delta = input.Position - dragStartOpenBtn
    OpenButton.Position = UDim2.new(
        startPosOpenBtn.X.Scale, 
        startPosOpenBtn.X.Offset + delta.X, 
        startPosOpenBtn.Y.Scale, 
        startPosOpenBtn.Y.Offset + delta.Y
    )
end

OpenButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingOpenBtn = true
        dragStartOpenBtn = input.Position
        startPosOpenBtn = OpenButton.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingOpenBtn = false
            end
        end)
    end
end)

OpenButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInputOpenBtn = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInputOpenBtn and draggingOpenBtn then
        updateOpenBtn(input)
    end
end)

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
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Container
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5) 

-- C. HÀM TẠO NÚT TÍNH NĂNG NHANH
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

-- Chức năng 3: Dịch chuyển về Đảo Khởi Đầu (Tự động nhận diện Sea)
CreateFunctionButton("Dịch Chuyển Về Đảo Khởi Đầu", function()
    local player = game.Players.LocalPlayer
    local HRT = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    
    if HRT then
        local currentPlaceId = game.PlaceId -- Lấy ID của Server hiện tại để check xem bạn đang ở Sea mấy
        
        if currentPlaceId == 275391513 then
            -- BẠN ĐANG Ở SEA 1 (Tọa độ Đảo Khởi Đầu Marine/Pirate Starter)
            print("Đã nhận diện Sea 1. Đang dịch chuyển...")
            HRT.CFrame = CFrame.new(1003, 16, 1420) -- Tọa độ khởi đầu đảo Pirate Sea 1
            
        elseif currentPlaceId == 444227218 then
            -- BẠN ĐANG Ở SEA 2 (Tọa độ Đảo Khởi Đầu Sea 2 - Kingdom of Rose)
            print("Đã nhận diện Sea 2. Đang dịch chuyển...")
            HRT.CFrame = CFrame.new(-20, 16, 1000) -- Tọa độ bến cảng khởi đầu Sea 2
            
        elseif currentPlaceId == 7449423635 then
            -- BẠN ĐANG Ở SEA 3 (Tọa độ Đảo Khởi Đầu Sea 3 - Castle on the Sea)
            print("Đã nhận diện Sea 3. Đang dịch chuyển...")
            HRT.CFrame = CFrame.new(-5020, 315, -3152) -- Tọa độ Lâu đài trên biển Sea 3
            
        else
            -- Trường hợp bạn đang ở các server minigame hoặc phòng chờ đặc biệt
            print("Không nhận diện được ID Sea này! Dịch chuyển về mặc định...")
            HRT.CFrame = CFrame.new(0, 100, 0)
        end
    end
end)
