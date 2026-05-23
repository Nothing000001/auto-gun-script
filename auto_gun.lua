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
-- GUI
-- ==========================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoGunGui"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 125)
frame.Position = UDim2.new(0, 20, 0, 20)
frame.BackgroundColor3 = Color3.fromHex("121212")
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

-- Top bar
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 4)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromHex("00FFAA")
topBar.BorderSizePixel = 0
topBar.Parent = frame

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 8)
topBarCorner.Parent = topBar

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.Position = UDim2.new(0, 0, 0, 8)
title.BackgroundTransparency = 1
title.Text = "Nothing0 AUTO GUN"
title.TextColor3 = Color3.fromHex("00FFAA")
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- Status
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 80, 0, 20)
statusLabel.Position = UDim2.new(0, 15, 0, 48)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status"
statusLabel.TextColor3 = Color3.fromHex("FFFFFF")
statusLabel.TextSize = 13
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = frame

local statusValue = Instance.new("TextLabel")
statusValue.Size = UDim2.new(0, 60, 0, 20)
statusValue.Position = UDim2.new(0, 130, 0, 48)
statusValue.BackgroundTransparency = 1
statusValue.Text = "OFF"
statusValue.TextColor3 = Color3.fromHex("FF4444")
statusValue.TextSize = 14
statusValue.Font = Enum.Font.GothamBold
statusValue.TextXAlignment = Enum.TextXAlignment.Left
statusValue.Parent = frame

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
