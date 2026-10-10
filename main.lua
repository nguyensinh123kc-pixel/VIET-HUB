
-- VIET HUB | Giao dien mau tim
-- Ban giao dien mau cho Roblox Studio / game ban co quyen chinh sua

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "VIETHUB"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local function make(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local main = make("Frame", {
    Size = UDim2.fromOffset(500, 330),
    Position = UDim2.new(0.5, -250, 0.5, -165),
    BackgroundColor3 = Color3.fromRGB(22, 19, 32),
    BorderSizePixel = 0
}, gui)
make("UICorner", {CornerRadius = UDim.new(0, 12)}, main)
make("UIStroke", {Color = Color3.fromRGB(130, 80, 220), Thickness = 1.5}, main)

local header = make("Frame", {
    Size = UDim2.new(1, 0, 0, 48),
    BackgroundColor3 = Color3.fromRGB(45, 30, 68),
    BorderSizePixel = 0
}, main)
make("UICorner", {CornerRadius = UDim.new(0, 12)}, header)

make("TextLabel", {
    Size = UDim2.new(1, -110, 1, 0),
    Position = UDim2.fromOffset(14, 0),
    BackgroundTransparency = 1,
    Text = "VIET HUB  |  v1.0",
    TextColor3 = Color3.fromRGB(230, 210, 255),
    TextSize = 18,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
}, header)

local mini = make("TextButton", {
    Size = UDim2.fromOffset(32, 30),
    Position = UDim2.new(1, -76, 0, 9),
    BackgroundColor3 = Color3.fromRGB(90, 60, 130),
    Text = "_",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 18,
    Font = Enum.Font.GothamBold
}, header)
make("UICorner", {CornerRadius = UDim.new(0, 7)}, mini)

local close = make("TextButton", {
    Size = UDim2.fromOffset(32, 30),
    Position = UDim2.new(1, -38, 0, 9),
    BackgroundColor3 = Color3.fromRGB(155, 55, 85),
    Text = "X",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 14,
    Font = Enum.Font.GothamBold
}, header)
make("UICorner", {CornerRadius = UDim.new(0, 7)}, close)

local tabs = make("Frame", {
    Size = UDim2.new(0, 130, 1, -60),
    Position = UDim2.fromOffset(10, 55),
    BackgroundColor3 = Color3.fromRGB(31, 26, 43),
    BorderSizePixel = 0
}, main)
make("UICorner", {CornerRadius = UDim.new(0, 8)}, tabs)

local content = make("Frame", {
    Size = UDim2.new(1, -160, 1, -65),
    Position = UDim2.fromOffset(150, 55),
    BackgroundColor3 = Color3.fromRGB(29, 25, 39),
    BorderSizePixel = 0
}, main)
make("UICorner", {CornerRadius = UDim.new(0, 8)}, content)

local pageTitle = make("TextLabel", {
    Size = UDim2.new(1, -20, 0, 35),
    Position = UDim2.fromOffset(10, 8),
    BackgroundTransparency = 1,
    Text = "Trang chu",
    TextColor3 = Color3.fromRGB(220, 195, 255),
    TextSize = 17,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
}, content)

local info = make("TextLabel", {
    Size = UDim2.new(1, -20, 0, 90),
    Position = UDim2.fromOffset(10, 50),
    BackgroundTransparency = 1,
    Text = "Chao mung den voi VIET HUB!\nGiao dien da san sang.",
    TextColor3 = Color3.fromRGB(225, 225, 235),
    TextSize = 14,
    Font = Enum.Font.Gotham,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top
}, content)

local pages = {
    ["Trang chu"] = "Chao mung den voi VIET HUB!\nGiao dien da san sang.",
    ["Cong cu"] = "Khu vuc cong cu.\nThem tinh nang cho game ban quan ly tai day.",
    ["Cai dat"] = "VIET HUB v1.0\nGiao dien tieng Viet - chu de tim den."
}

local selected
local function showPage(name)
    pageTitle.Text = name
    info.Text = pages[name]
    selected = name
    for _, item in ipairs(tabs:GetChildren()) do
        if item:IsA("TextButton") then
            item.BackgroundColor3 = item.Text == name
                and Color3.fromRGB(105, 65, 160)
                or Color3.fromRGB(48, 39, 63)
        end
    end
end

for _, name in ipairs({"Trang chu", "Cong cu", "Cai dat"}) do
    local button = make("TextButton", {
        Size = UDim2.new(1, -12, 0, 42),
        Position = UDim2.fromOffset(6, 8 + (_ - 1) * 49),
        BackgroundColor3 = Color3.fromRGB(48, 39, 63),
        Text = name,
        TextColor3 = Color3.fromRGB(245, 240, 255),
        TextSize = 13,
        Font = Enum.Font.GothamSemibold
    }, tabs)
    make("UICorner", {CornerRadius = UDim.new(0, 7)}, button)
    button.Activated:Connect(function()
        showPage(name)
    end)
end

local minimized = false
mini.Activated:Connect(function()
    minimized = not minimized
    content.Visible = not minimized
    tabs.Visible = not minimized
    main.Size = minimized and UDim2.fromOffset(500, 48)
        or UDim2.fromOffset(500, 330)
    mini.Text = minimized and "+" or "_"
end)

close.Activated:Connect(function()
    gui:Destroy()
end)

-- Keo giao dien bang chuot hoac cam ung
local dragging, dragStart, startPos
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

showPage("Trang chu")
