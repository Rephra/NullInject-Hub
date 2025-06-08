-- NullInject Premium - Direct Loader with Minimal GUI
-- Simple loader with basic visual feedback

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Configuration
local SCRIPT_URL = "https://raw.githubusercontent.com/Rephra/NullInject-Hub/main/Nullinject.lua"

-- Create a simple GUI to show loading status
local function createSimpleGUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "NullInjectLoader"
    gui.ResetOnSpawn = false
    gui.Parent = game.CoreGui
    
    -- Background
    local background = Instance.new("Frame")
    background.Name = "Background"
    background.Size = UDim2.new(0, 280, 0, 120)
    background.Position = UDim2.new(0.5, -140, 0.5, -60)
    background.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    background.BorderSizePixel = 0
    background.Parent = gui
    
    -- Rounded corners
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = background
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -20, 0, 30)
    title.Position = UDim2.new(0, 10, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "NullInject Premium"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 18
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = background
    
    -- Status
    local status = Instance.new("TextLabel")
    status.Name = "Status"
    status.Size = UDim2.new(1, -20, 0, 20)
    status.Position = UDim2.new(0, 10, 0, 45)
    status.BackgroundTransparency = 1
    status.Text = "Loading script..."
    status.TextColor3 = Color3.fromRGB(200, 200, 200)
    status.TextSize = 14
    status.Font = Enum.Font.Gotham
    status.TextXAlignment = Enum.TextXAlignment.Left
    status.Parent = background
    
    -- Progress bar background
    local progressBg = Instance.new("Frame")
    progressBg.Name = "ProgressBg"
    progressBg.Size = UDim2.new(1, -20, 0, 10)
    progressBg.Position = UDim2.new(0, 10, 0, 75)
    progressBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    progressBg.BorderSizePixel = 0
    progressBg.Parent = background
    
    local progressBgCorner = Instance.new("UICorner")
    progressBgCorner.CornerRadius = UDim.new(0, 4)
    progressBgCorner.Parent = progressBg
    
    -- Progress bar
    local progress = Instance.new("Frame")
    progress.Name = "Progress"
    progress.Size = UDim2.new(0, 0, 1, 0)
    progress.Position = UDim2.new(0, 0, 0, 0)
    progress.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    progress.BorderSizePixel = 0
    progress.Parent = progressBg
    
    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(0, 4)
    progressCorner.Parent = progress
    
    -- Version
    local version = Instance.new("TextLabel")
    version.Name = "Version"
    version.Size = UDim2.new(1, -20, 0, 20)
    version.Position = UDim2.new(0, 10, 0, 95)
    version.BackgroundTransparency = 1
    version.Text = "v1.0.0"
    version.TextColor3 = Color3.fromRGB(130, 130, 130)
    version.TextSize = 12
    version.Font = Enum.Font.Gotham
    version.TextXAlignment = Enum.TextXAlignment.Left
    version.Parent = background
    
    -- Animation
    TweenService:Create(progress, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0.3, 0, 1, 0)
    }):Play()
    
    return {
        GUI = gui,
        Status = status,
        Progress = progress,
        UpdateProgress = function(percent, text)
            TweenService:Create(progress, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(percent, 0, 1, 0)
            }):Play()
            
            if text then
                status.Text = text
            end
        end,
        Finish = function(success, message)
            if success then
                TweenService:Create(progress, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundColor3 = Color3.fromRGB(50, 200, 100)
                }):Play()
                status.Text = message or "Script loaded successfully!"
            else
                TweenService:Create(progress, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = Color3.fromRGB(200, 50, 50)
                }):Play()
                status.Text = message or "Failed to load script"
            end
            
            wait(2)
            gui:Destroy()
        end
    }
end

-- Load the script
local function loadScript()
    local guiController = createSimpleGUI()
    
    -- Step 1: Connect to server
    guiController.UpdateProgress(0.3, "Connecting to server...")
    wait(0.5)
    
    -- Step 2: Download script
    local success, result = pcall(function()
        return game:HttpGet(SCRIPT_URL)
    end)
    
    if not success then
        guiController.Finish(false, "Error: Failed to connect to server")
        warn("NullInject Error: " .. tostring(result))
        return
    end
    
    guiController.UpdateProgress(0.6, "Script downloaded, executing...")
    wait(0.5)
    
    -- Step 3: Execute script
    local executeSuccess, executeError = pcall(function()
        return loadstring(result)()
    end)
    
    if not executeSuccess then
        guiController.Finish(false, "Error executing script")
        warn("NullInject Error: " .. tostring(executeError))
        return
    end
    
    -- Success
    guiController.UpdateProgress(1, "Script loaded successfully!")
    wait(0.5)
    guiController.Finish(true)
end

-- Execute immediately
loadScript()
