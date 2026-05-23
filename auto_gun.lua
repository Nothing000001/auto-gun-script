-- ==========================================
-- Nothing0 Auto Gun + Slime Aimbot
-- ==========================================

if getgenv().AutoGunLoaded then
    return
end

getgenv().AutoGunLoaded = true

repeat task.wait() until game:IsLoaded()

task.wait(1)

local VirtualInputManager = game:GetService("VirtualInputManager")

-- SHIFT PRESS
VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
task.wait(0.05)
VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

local scriptActive = true
local aimbotEnabled = true

local interval = 0.05
local remainingTime = interval

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
frame.Size = UDim2.new(0, 240, 0, 160)
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
title.Text = "Nothing0 AUTO GUN + AIM BOT"
title.TextColor3 = Color3.fromHex("00FFAA")
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- Status label
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
statusValue.Text = "ON"
statusValue.TextColor3 = Color3.fromHex("00FF00")
statusValue.TextSize = 14
statusValue.Font = Enum.Font.GothamBold
statusValue.TextXAlignment = Enum.TextXAlignment.Left
statusValue.Parent = frame

-- ==========================================
-- AUTO GUN SWITCH
-- ==========================================

local switchBg = Instance.new("Frame")
switchBg.Size = UDim2.new(0, 54, 0, 28)
switchBg.Position = UDim2.new(0, 15, 0, 78)
switchBg.BackgroundColor3 = Color3.fromHex("00FF00")
switchBg.BorderSizePixel = 0
switchBg.Parent = frame

local switchCorner = Instance.new("UICorner")
switchCorner.CornerRadius = UDim.new(1, 0)
switchCorner.Parent = switchBg

local knob = Instance.new("Frame")
knob.Size = UDim2.new(0, 22, 0, 22)
knob.Position = UDim2.new(0, 29, 0.5, -11)
knob.BackgroundColor3 = Color3.fromHex("FFFFFF")
knob.BorderSizePixel = 0
knob.Parent = switchBg

local knobCorner = Instance.new("UICorner")
knobCorner.CornerRadius = UDim.new(1, 0)
knobCorner.Parent = knob

local switchLabel = Instance.new("TextLabel")
switchLabel.Size = UDim2.new(0, 140, 0, 28)
switchLabel.Position = UDim2.new(0, 78, 0, 78)
switchLabel.BackgroundTransparency = 1
switchLabel.Text = "Auto Gun ON (F1)"
switchLabel.TextColor3 = Color3.fromHex("00FF00")
switchLabel.TextSize = 11
switchLabel.Font = Enum.Font.Gotham
switchLabel.TextXAlignment = Enum.TextXAlignment.Left
switchLabel.Parent = frame

-- ==========================================
-- AIMBOT SWITCH
-- ==========================================

local aimbotBg = Instance.new("Frame")
aimbotBg.Size = UDim2.new(0, 54, 0, 28)
aimbotBg.Position = UDim2.new(0, 15, 0, 112)
aimbotBg.BackgroundColor3 = Color3.fromHex("00FF00")
aimbotBg.BorderSizePixel = 0
aimbotBg.Parent = frame

local aimbotCorner = Instance.new("UICorner")
aimbotCorner.CornerRadius = UDim.new(1, 0)
aimbotCorner.Parent = aimbotBg

local aimbotKnob = Instance.new("Frame")
aimbotKnob.Size = UDim2.new(0, 22, 0, 22)
aimbotKnob.Position = UDim2.new(0, 29, 0.5, -11)
aimbotKnob.BackgroundColor3 = Color3.fromHex("FFFFFF")
aimbotKnob.BorderSizePixel = 0
aimbotKnob.Parent = aimbotBg

local aimbotKnobCorner = Instance.new("UICorner")
aimbotKnobCorner.CornerRadius = UDim.new(1, 0)
aimbotKnobCorner.Parent = aimbotKnob

local aimbotLabel = Instance.new("TextLabel")
aimbotLabel.Size = UDim2.new(0, 140, 0, 28)
aimbotLabel.Position = UDim2.new(0, 78, 0, 112)
aimbotLabel.BackgroundTransparency = 1
aimbotLabel.Text = "Aimbot ON (F2)"
aimbotLabel.TextColor3 = Color3.fromHex("00FF00")
aimbotLabel.TextSize = 11
aimbotLabel.Font = Enum.Font.Gotham
aimbotLabel.TextXAlignment = Enum.TextXAlignment.Left
aimbotLabel.Parent = frame

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
-- TOGGLES
-- ==========================================

local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function toggleGun()
    scriptActive = not scriptActive

    if scriptActive then
        TweenService:Create(knob, tweenInfo, {
            Position = UDim2.new(0, 29, 0.5, -11)
        }):Play()

        TweenService:Create(switchBg, tweenInfo, {
            BackgroundColor3 = Color3.fromHex("00FF00")
        }):Play()

        switchLabel.Text = "Auto Gun ON (F1)"
        switchLabel.TextColor3 = Color3.fromHex("00FF00")

        statusValue.Text = "ON"
        statusValue.TextColor3 = Color3.fromHex("00FF00")
    else
        TweenService:Create(knob, tweenInfo, {
            Position = UDim2.new(0, 3, 0.5, -11)
        }):Play()

        TweenService:Create(switchBg, tweenInfo, {
            BackgroundColor3 = Color3.fromHex("FF4444")
        }):Play()

        switchLabel.Text = "Auto Gun OFF (F1)"
        switchLabel.TextColor3 = Color3.fromHex("FF4444")

        statusValue.Text = "OFF"
        statusValue.TextColor3 = Color3.fromHex("FF4444")
    end
end

local function toggleAimbot()
    aimbotEnabled = not aimbotEnabled

    if aimbotEnabled then
        TweenService:Create(aimbotKnob, tweenInfo, {
            Position = UDim2.new(0, 29, 0.5, -11)
        }):Play()

        TweenService:Create(aimbotBg, tweenInfo, {
            BackgroundColor3 = Color3.fromHex("00FF00")
        }):Play()

        aimbotLabel.Text = "Aimbot ON (F2)"
        aimbotLabel.TextColor3 = Color3.fromHex("00FF00")
    else
        TweenService:Create(aimbotKnob, tweenInfo, {
            Position = UDim2.new(0, 3, 0.5, -11)
        }):Play()

        TweenService:Create(aimbotBg, tweenInfo, {
            BackgroundColor3 = Color3.fromHex("FF4444")
        }):Play()

        aimbotLabel.Text = "Aimbot OFF (F2)"
        aimbotLabel.TextColor3 = Color3.fromHex("FF4444")
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.F1 then
        toggleGun()
    end

    if input.KeyCode == Enum.KeyCode.F2 then
        toggleAimbot()
    end
end)

-- ==========================================
-- SLIME AIMBOT
-- ==========================================

local function getClosestSlime()
    local closest = nil
    local shortest = math.huge

    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name == "SlimeBody" then

            local pos, visible =
                Camera:WorldToViewportPoint(v.Position)

            if visible then

                local mousePos =
                    UserInputService:GetMouseLocation()

                local distance =
                    (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude

                if distance < shortest then
                    shortest = distance
                    closest = v
                end
            end
        end
    end

    return closest
end

-- ==========================================
-- AUTO FIRE
-- ==========================================

local function fireGun()
    -- LEFT CLICK
    VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,0)
    VirtualInputManager:SendMouseButtonEvent(0,0,0,false,game,0)

end

-- ==========================================
-- MAIN LOOP
-- ==========================================

RunService.Heartbeat:Connect(function(dt)

    if scriptActive then
        remainingTime = remainingTime - dt

        if remainingTime <= 0 then
            remainingTime = interval
            fireGun()
        end
    end

    if aimbotEnabled then
        local target = getClosestSlime()

        if target then
            Camera.CFrame = Camera.CFrame:Lerp(
                CFrame.new(Camera.CFrame.Position, target.Position),
                0.15
            )
        end
    end
end)
