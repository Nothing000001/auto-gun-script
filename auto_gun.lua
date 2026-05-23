-- ==========================================
-- Nothing0 Auto Gun
-- NEW GOOPGUN FIX
-- ==========================================
if getgenv().AutoGunLoaded then
    return
end

getgenv().AutoGunLoaded = true

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local scriptActive = true
local holdingMouse = false

if playerGui:FindFirstChild("AutoGunGui") then
    playerGui.AutoGunGui:Destroy()
end

-- ==========================================
-- Nothing0 Hub UI
-- ==========================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("Nothing0Hub") then
    playerGui.Nothing0Hub:Destroy()
end

-- ==========================================
-- MAIN GUI
-- ==========================================

local gui = Instance.new("ScreenGui")
gui.Name = "Nothing0Hub"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 280, 0, 360)
main.Position = UDim2.new(0, 20, 0.5, -180)
main.BackgroundColor3 = Color3.fromRGB(12,12,18)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,12)
corner.Parent = main

-- ==========================================
-- TOP BAR
-- ==========================================

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "Nothing0 Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Parent = main

-- ==========================================
-- TABS
-- ==========================================

local tabs = {
    {"Main", true},
    {"SEE IT", false},
    {"Other", false},
}

for i,tab in pairs(tabs) do

    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0,80,0,32)
    b.Position = UDim2.new(0,10 + ((i-1)*90),0,45)
    b.Text = tab[1]
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.BorderSizePixel = 0

    if tab[2] then
        b.BackgroundColor3 = Color3.fromRGB(100,70,255)
    else
        b.BackgroundColor3 = Color3.fromRGB(25,25,35)
    end

    b.TextColor3 = Color3.new(1,1,1)

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0,8)
    c.Parent = b

    b.Parent = main
end

-- ==========================================
-- SCROLL
-- ==========================================

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1,-10,1,-95)
scroll.Position = UDim2.new(0,5,0,90)
scroll.CanvasSize = UDim2.new(0,0,0,500)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,10)
layout.Parent = scroll

-- ==========================================
-- FUNCTIONS
-- ==========================================

local function createOption(text, enabled, shortcut)

    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1,-10,0,42)
    holder.BackgroundTransparency = 1
    holder.Parent = scroll

    local line = Instance.new("Frame")
    line.Size = UDim2.new(0,2,0,28)
    line.Position = UDim2.new(0,0,0.5,-14)

    if enabled then
        line.BackgroundColor3 = Color3.fromRGB(120,80,255)
    else
        line.BackgroundColor3 = Color3.fromRGB(255,70,70)
    end

    line.BorderSizePixel = 0
    line.Parent = holder

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0,170,1,0)
    label.Position = UDim2.new(0,10,0,0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left

    if shortcut then
        label.Text = text .. " [" .. shortcut .. "]"
    else
        label.Text = text
    end

    if enabled then
        label.TextColor3 = Color3.new(1,1,1)
    else
        label.TextColor3 = Color3.fromRGB(255,80,80)
    end

    label.Parent = holder

    local toggleBg = Instance.new("Frame")
    toggleBg.Size = UDim2.new(0,42,0,22)
    toggleBg.Position = UDim2.new(1,-50,0.5,-11)

    if enabled then
        toggleBg.BackgroundColor3 = Color3.fromRGB(120,80,255)
    else
        toggleBg.BackgroundColor3 = Color3.fromRGB(45,45,55)
    end

    toggleBg.BorderSizePixel = 0
    toggleBg.Parent = holder

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1,0)
    toggleCorner.Parent = toggleBg

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0,18,0,18)
    knob.Position = enabled
        and UDim2.new(1,-20,0.5,-9)
        or UDim2.new(0,2,0.5,-9)

    knob.BackgroundColor3 = Color3.new(1,1,1)
    knob.BorderSizePixel = 0
    knob.Parent = toggleBg

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1,0)
    knobCorner.Parent = knob
end

-- ==========================================
-- OPTIONS
-- ==========================================

createOption("Auto Roll", false)
createOption("Auto Equip Best", false)
createOption("Auto Loot", false)
createOption("Auto Collect Fruits", false)
createOption("Auto Kill", false)

-- TON SCRIPT
createOption("Auto Gun", true, "F1")

createOption("Auto Index", false)
createOption("Auto TP Zone", false)
createOption("Auto Rebirth", false)
createOption("Auto Boss", false)

-- ==========================================
-- TOGGLE SWITCH
-- ==========================================

local switchBg = Instance.new("Frame")
switchBg.Size = UDim2.new(0, 54, 0, 28)
switchBg.Position = UDim2.new(0, 15, 0, 78)
switchBg.BackgroundColor3 = Color3.fromHex("FF4444")
switchBg.BorderSizePixel = 0
switchBg.Parent = frame

local switchBgCorner = Instance.new("UICorner")
switchBgCorner.CornerRadius = UDim.new(1, 0)
switchBgCorner.Parent = switchBg

local switchLabel = Instance.new("TextLabel")
switchLabel.Size = UDim2.new(0, 120, 0, 28)
switchLabel.Position = UDim2.new(0, 78, 0, 78)
switchLabel.BackgroundTransparency = 1
switchLabel.Text = "Press F1 to activate"
switchLabel.TextColor3 = Color3.fromHex("666666")
switchLabel.TextSize = 11
switchLabel.Font = Enum.Font.Gotham
switchLabel.TextXAlignment = Enum.TextXAlignment.Left
switchLabel.Parent = frame

local knob = Instance.new("Frame")
knob.Size = UDim2.new(0, 22, 0, 22)
knob.Position = UDim2.new(0, 3, 0.5, -11)
knob.BackgroundColor3 = Color3.fromHex("FFFFFF")
knob.BorderSizePixel = 0
knob.Parent = switchBg

local knobCorner = Instance.new("UICorner")
knobCorner.CornerRadius = UDim.new(1, 0)
knobCorner.Parent = knob

-- Footer
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 16)
footer.Position = UDim2.new(0, 0, 1, -18)
footer.BackgroundTransparency = 1
footer.Text = "Made by Nothing0"
footer.TextColor3 = Color3.fromHex("666666")
footer.TextSize = 10
footer.Font = Enum.Font.Gotham
footer.Parent = frame

-- ==========================================
-- HOLD FUNCTIONS
-- ==========================================

local function holdMouse()

    if holdingMouse then
        return
    end

    holdingMouse = true

    -- LEFT CLICK HOLD
    VirtualInputManager:SendMouseButtonEvent(
        0,
        0,
        0,
        true,
        game,
        0
    )

    -- RIGHT CLICK HOLD
    VirtualInputManager:SendMouseButtonEvent(
        0,
        0,
        1,
        true,
        game,
        0
    )
end

local function releaseMouse()

    if not holdingMouse then
        return
    end

    holdingMouse = false

    -- LEFT RELEASE
    VirtualInputManager:SendMouseButtonEvent(
        0,
        0,
        0,
        false,
        game,
        0
    )

    -- RIGHT RELEASE
    VirtualInputManager:SendMouseButtonEvent(
        0,
        0,
        1,
        false,
        game,
        0
    )
end

-- ==========================================
-- TOGGLE FUNCTION
-- ==========================================

local tweenInfo = TweenInfo.new(
    0.2,
    Enum.EasingStyle.Quad,
    Enum.EasingDirection.Out
)

local function toggle()

    scriptActive = not scriptActive

    if scriptActive then

        TweenService:Create(knob, tweenInfo, {
            Position = UDim2.new(0, 29, 0.5, -11)
        }):Play()

        TweenService:Create(switchBg, tweenInfo, {
            BackgroundColor3 = Color3.fromHex("00FF00")
        }):Play()

        statusValue.Text = "ON"
        statusValue.TextColor3 = Color3.fromHex("00FF00")

        switchLabel.Text = "Active"
        switchLabel.TextColor3 = Color3.fromHex("00FF00")

        holdMouse()

    else

        TweenService:Create(knob, tweenInfo, {
            Position = UDim2.new(0, 3, 0.5, -11)
        }):Play()

        TweenService:Create(switchBg, tweenInfo, {
            BackgroundColor3 = Color3.fromHex("FF4444")
        }):Play()

        statusValue.Text = "OFF"
        statusValue.TextColor3 = Color3.fromHex("FF4444")

        switchLabel.Text = "Press F1 to activate"
        switchLabel.TextColor3 = Color3.fromHex("666666")

        releaseMouse()
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)

    if input.KeyCode == Enum.KeyCode.F1 and not gameProcessed then
        toggle()
    end

end)

-- ==========================================
-- AUTO ACTIVATE
-- ==========================================

TweenService:Create(knob, tweenInfo, {
    Position = UDim2.new(0, 29, 0.5, -11)
}):Play()

TweenService:Create(switchBg, tweenInfo, {
    BackgroundColor3 = Color3.fromHex("00FF00")
}):Play()

statusValue.Text = "ON"
statusValue.TextColor3 = Color3.fromHex("00FF00")

switchLabel.Text = "Active"
switchLabel.TextColor3 = Color3.fromHex("00FF00")

holdMouse()

-- ==========================================
-- MAIN LOOP
-- ==========================================

RunService.Heartbeat:Connect(function()

    if not scriptActive then
        return
    end

    if not holdingMouse then
        holdMouse()
    end

    -- Fake InputBegan
    pcall(function()

        UserInputService.InputBegan:Fire({
            UserInputType = Enum.UserInputType.MouseButton1
        }, false)

        UserInputService.InputBegan:Fire({
            UserInputType = Enum.UserInputType.MouseButton2
        }, false)

    end)

end)

-- ==========================================
-- AUTO F1 LOOP
-- ==========================================

task.spawn(function()

    local VirtualInputManager =
        game:GetService("VirtualInputManager")

    while true do

        task.wait(300)

        -- F1
        VirtualInputManager:SendKeyEvent(
            true,
            Enum.KeyCode.F1,
            false,
            game
        )

        VirtualInputManager:SendKeyEvent(
            false,
            Enum.KeyCode.F1,
            false,
            game
        )

        print("F1 #1")

        task.wait(10)

        -- F1 encore
        VirtualInputManager:SendKeyEvent(
            true,
            Enum.KeyCode.F1,
            false,
            game
        )

        VirtualInputManager:SendKeyEvent(
            false,
            Enum.KeyCode.F1,
            false,
            game
        )

        print("F1 #2")

    end

end)
