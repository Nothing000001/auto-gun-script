-- ==========================================
-- NOTHING0 BACKGROUND AUTO GUN
-- ==========================================
-- IMPORTANT :
-- Roblox Lua NE PEUT PAS vraiment cliquer
-- hors focus fenêtre.
--
-- MAIS ce script :
-- ✔ garde le hold
-- ✔ réduit les pertes focus
-- ✔ auto recover
-- ✔ fonctionne mieux en alt-tab
-- ==========================================

if getgenv().Nothing0BG then
    return
end

getgenv().Nothing0BG = true

repeat task.wait() until game:IsLoaded()

-- ==========================================
-- SERVICES
-- ==========================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local GuiService = game:GetService("GuiService")

local player = Players.LocalPlayer

-- ==========================================
-- SETTINGS
-- ==========================================

local scriptActive = true
local holding = false

local BurstAmount = 3
local BurstDelay = 0.01

-- ==========================================
-- GUI REMOVE
-- ==========================================

if player.PlayerGui:FindFirstChild("Nothing0Hub") then
    player.PlayerGui.Nothing0Hub:Destroy()
end

-- ==========================================
-- GUI
-- ==========================================

local gui = Instance.new("ScreenGui")
gui.Name = "Nothing0Hub"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0,260,0,100)
main.Position = UDim2.new(0,20,0.5,-50)
main.BackgroundColor3 = Color3.fromRGB(15,15,20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,10)
corner.Parent = main

-- TITLE

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-40,0,40)
title.Position = UDim2.new(0,10,0,0)
title.BackgroundTransparency = 1
title.Text = "Nothing0 Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.new(1,1,1)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

-- MINIMIZE

local mini = Instance.new("TextButton")
mini.Size = UDim2.new(0,28,0,28)
mini.Position = UDim2.new(1,-35,0,6)
mini.Text = "-"
mini.Font = Enum.Font.GothamBold
mini.TextSize = 18
mini.TextColor3 = Color3.new(1,1,1)
mini.BackgroundColor3 = Color3.fromRGB(30,30,40)
mini.BorderSizePixel = 0
mini.Parent = main

local minic = Instance.new("UICorner")
minic.CornerRadius = UDim.new(0,8)
minic.Parent = mini

-- HOLDER

local holder = Instance.new("Frame")
holder.Size = UDim2.new(1,-20,0,40)
holder.Position = UDim2.new(0,10,0,50)
holder.BackgroundTransparency = 1
holder.Parent = main

-- LABEL

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0,170,1,0)
label.BackgroundTransparency = 1
label.Text = "Auto Gun [F1]"
label.Font = Enum.Font.Gotham
label.TextSize = 14
label.TextColor3 = Color3.new(1,1,1)
label.TextXAlignment = Enum.TextXAlignment.Left
label.Parent = holder

-- TOGGLE

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0,45,0,24)
toggle.Position = UDim2.new(1,-50,0.5,-12)
toggle.BackgroundColor3 = Color3.fromRGB(120,80,255)
toggle.Text = ""
toggle.BorderSizePixel = 0
toggle.Parent = holder

local tc = Instance.new("UICorner")
tc.CornerRadius = UDim.new(1,0)
tc.Parent = toggle

local knob = Instance.new("Frame")
knob.Size = UDim2.new(0,18,0,18)
knob.Position = UDim2.new(1,-20,0.5,-9)
knob.BackgroundColor3 = Color3.new(1,1,1)
knob.BorderSizePixel = 0
knob.Parent = toggle

local kc = Instance.new("UICorner")
kc.CornerRadius = UDim.new(1,0)
kc.Parent = knob

-- ==========================================
-- MINIMIZE
-- ==========================================

local minimized = false

mini.MouseButton1Click:Connect(function()

    minimized = not minimized

    if minimized then

        holder.Visible = false
        main.Size = UDim2.new(0,260,0,40)

        mini.Text = "+"

    else

        holder.Visible = true
        main.Size = UDim2.new(0,260,0,100)

        mini.Text = "-"
    end
end)

-- ==========================================
-- TOGGLE
-- ==========================================

local function update()

    if scriptActive then

        toggle.BackgroundColor3 =
            Color3.fromRGB(120,80,255)

        knob.Position =
            UDim2.new(1,-20,0.5,-9)

    else

        toggle.BackgroundColor3 =
            Color3.fromRGB(40,40,50)

        knob.Position =
            UDim2.new(0,2,0.5,-9)
    end
end

toggle.MouseButton1Click:Connect(function()

    scriptActive = not scriptActive
    update()

end)

UserInputService.InputBegan:Connect(function(input,gp)

    if gp then return end

    if input.KeyCode == Enum.KeyCode.F1 then

        scriptActive = not scriptActive
        update()
    end
end)

update()

-- ==========================================
-- HOLD FUNCTIONS
-- ==========================================

local function hold()

    if holding then
        return
    end

    holding = true

    -- LEFT
    VirtualInputManager:SendMouseButtonEvent(
        0,0,0,true,game,0
    )

    -- RIGHT
    VirtualInputManager:SendMouseButtonEvent(
        0,0,1,true,game,0
    )
end

local function release()

    if not holding then
        return
    end

    holding = false

    -- LEFT
    VirtualInputManager:SendMouseButtonEvent(
        0,0,0,false,game,0
    )

    -- RIGHT
    VirtualInputManager:SendMouseButtonEvent(
        0,0,1,false,game,0
    )
end

-- ==========================================
-- BURST FIRE
-- ==========================================

local function burst()

    for i = 1, BurstAmount do

        VirtualInputManager:SendMouseButtonEvent(
            0,0,0,true,game,0
        )

        VirtualInputManager:SendMouseButtonEvent(
            0,0,0,false,game,0
        )

        task.wait(BurstDelay)
    end
end

-- ==========================================
-- BACKGROUND RECOVERY
-- ==========================================

task.spawn(function()

    while true do

        task.wait(1)

        pcall(function()

            GuiService.SelectedObject = nil

            if scriptActive then
                hold()
            end
        end)
    end
end)

-- ==========================================
-- MAIN LOOP
-- ==========================================

RunService.Heartbeat:Connect(function()

    if not scriptActive then

        release()
        return
    end

    if not holding then
        hold()
    end

    -- KEEP INPUT ALIVE
    pcall(function()

        UserInputService.InputBegan:Fire({
            UserInputType =
                Enum.UserInputType.MouseButton1
        }, false)

        UserInputService.InputBegan:Fire({
            UserInputType =
                Enum.UserInputType.MouseButton2
        }, false)

    end)

    burst()

end)

print("NOTHING0 BACKGROUND AUTO GUN LOADED")
