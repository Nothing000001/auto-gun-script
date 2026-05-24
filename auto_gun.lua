-- ==========================================
-- Nothing0 AUTO GUN FULL RAW
-- ==========================================

if getgenv().AutoGunLoaded then
    return
end

getgenv().AutoGunLoaded = true

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local scriptActive = true
local holdingMouse = false
local minimized = false

-- ==========================================
-- REMOVE OLD GUI
-- ==========================================

if playerGui:FindFirstChild("Nothing0Hub") then
    playerGui.Nothing0Hub:Destroy()
end

-- ==========================================
-- GUI
-- ==========================================

local gui = Instance.new("ScreenGui")
gui.Name = "Nothing0Hub"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 280, 0, 110)
main.Position = UDim2.new(0, 20, 0.5, -55)
main.BackgroundColor3 = Color3.fromRGB(12,12,18)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,12)
corner.Parent = main

-- ==========================================
-- TITLE
-- ==========================================

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-40,0,45)
title.Position = UDim2.new(0,10,0,0)
title.BackgroundTransparency = 1
title.Text = "Nothing0 Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.new(1,1,1)
title.Parent = main

-- ==========================================
-- MINIMIZE BUTTON
-- ==========================================

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.new(0,30,0,30)
minimize.Position = UDim2.new(1,-35,0,8)
minimize.BackgroundColor3 = Color3.fromRGB(25,25,35)
minimize.BorderSizePixel = 0
minimize.Text = "-"
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 18
minimize.TextColor3 = Color3.new(1,1,1)
minimize.Parent = main

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0,8)
minimizeCorner.Parent = minimize

-- ==========================================
-- SCROLL
-- ==========================================

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1,-10,1,-55)
scroll.Position = UDim2.new(0,5,0,50)
scroll.CanvasSize = UDim2.new(0,0,0,100)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,10)
layout.Parent = scroll

-- ==========================================
-- MINIMIZE FUNCTION
-- ==========================================

minimize.MouseButton1Click:Connect(function()

    minimized = not minimized

    if minimized then

        scroll.Visible = false
        main.Size = UDim2.new(0,280,0,45)

        minimize.Text = "+"

    else

        scroll.Visible = true
        main.Size = UDim2.new(0,280,0,110)

        minimize.Text = "-"

    end
end)

-- ==========================================
-- AUTO GUN TOGGLE
-- ==========================================

local autoGunEnabled = true

local holder = Instance.new("Frame")
holder.Size = UDim2.new(1,-10,0,42)
holder.BackgroundTransparency = 1
holder.Parent = scroll

local line = Instance.new("Frame")
line.Size = UDim2.new(0,2,0,28)
line.Position = UDim2.new(0,0,0.5,-14)
line.BackgroundColor3 = Color3.fromRGB(120,80,255)
line.BorderSizePixel = 0
line.Parent = holder

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0,190,1,0)
label.Position = UDim2.new(0,10,0,0)
label.BackgroundTransparency = 1
label.Font = Enum.Font.Gotham
label.TextSize = 14
label.TextXAlignment = Enum.TextXAlignment.Left
label.Text = "Auto Gun [F1]"
label.TextColor3 = Color3.new(1,1,1)
label.Parent = holder

local toggleBg = Instance.new("TextButton")
toggleBg.Size = UDim2.new(0,42,0,22)
toggleBg.Position = UDim2.new(1,-50,0.5,-11)
toggleBg.BackgroundColor3 = Color3.fromRGB(120,80,255)
toggleBg.BorderSizePixel = 0
toggleBg.Text = ""
toggleBg.Parent = holder

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(1,0)
toggleCorner.Parent = toggleBg

local knob = Instance.new("Frame")
knob.Size = UDim2.new(0,18,0,18)
knob.Position = UDim2.new(1,-20,0.5,-9)
knob.BackgroundColor3 = Color3.new(1,1,1)
knob.BorderSizePixel = 0
knob.Parent = toggleBg

local knobCorner = Instance.new("UICorner")
knobCorner.CornerRadius = UDim.new(1,0)
knobCorner.Parent = knob

local function updateToggle()

    if autoGunEnabled then

        toggleBg.BackgroundColor3 =
            Color3.fromRGB(120,80,255)

        knob.Position =
            UDim2.new(1,-20,0.5,-9)

    else

        toggleBg.BackgroundColor3 =
            Color3.fromRGB(45,45,55)

        knob.Position =
            UDim2.new(0,2,0.5,-9)

    end
end

toggleBg.MouseButton1Click:Connect(function()

    autoGunEnabled = not autoGunEnabled
    scriptActive = autoGunEnabled

    updateToggle()

end)

UserInputService.InputBegan:Connect(function(input,gp)

    if gp then return end

    if input.KeyCode == Enum.KeyCode.F1 then

        autoGunEnabled = not autoGunEnabled
        scriptActive = autoGunEnabled

        updateToggle()
    end
end)

updateToggle()

-- ==========================================
-- HOLD FUNCTIONS
-- ==========================================

local function holdMouse()

    if holdingMouse then
        return
    end

    holdingMouse = true

    -- LEFT CLICK
    VirtualInputManager:SendMouseButtonEvent(
        0,
        0,
        0,
        true,
        game,
        0
    )

    -- RIGHT CLICK
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
-- MAIN LOOP
-- ==========================================

RunService.Heartbeat:Connect(function()

    if not scriptActive then

        releaseMouse()
        return
    end

    if not holdingMouse then
        holdMouse()
    end

    -- Fake Inputs
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

        task.wait(10)

        -- F1 AGAIN
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

    end

end)
