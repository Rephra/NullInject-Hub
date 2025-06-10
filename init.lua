-- Garden Growth System Loader
-- Simple and reliable loader with GUI

print("🌱 Garden Growth System Starting...")

-- Configuration
local CONFIG = {
    REPO_URL = "https://raw.githubusercontent.com/Rephra/ApplicationFramework/main/engine.lua",
    VERSION = "1.2.8",
    AUTHOR = "Nullinject"
}

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

-- Create GUI Function
local function createLoaderGUI()
    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GardenLoader"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 400, 0, 250)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 45, 25)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    -- Add corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame
    
    -- Add stroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(60, 120, 60)
    stroke.Thickness = 2
    stroke.Parent = mainFrame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 20)
    title.BackgroundTransparency = 1
    title.Text = "🌱 Grow A Garden"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 24
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
      -- Version
    local version = Instance.new("TextLabel")
    version.Name = "Version"
    version.Size = UDim2.new(1, 0, 0, 20)
    version.Position = UDim2.new(0, 0, 0, 70)
    version.BackgroundTransparency = 1
    version.Text = "v" .. CONFIG.VERSION .. " Honey Update by " .. CONFIG.AUTHOR
    version.TextColor3 = Color3.fromRGB(150, 200, 150)
    version.TextSize = 14
    version.Font = Enum.Font.Gotham
    version.Parent = mainFrame
    
    -- Progress Bar Background
    local progressBG = Instance.new("Frame")
    progressBG.Name = "ProgressBG"
    progressBG.Size = UDim2.new(0.8, 0, 0, 8)
    progressBG.Position = UDim2.new(0.1, 0, 0, 130)
    progressBG.BackgroundColor3 = Color3.fromRGB(40, 60, 40)
    progressBG.BorderSizePixel = 0
    progressBG.Parent = mainFrame
    
    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(0, 4)
    progressCorner.Parent = progressBG
    
    -- Progress Bar Fill
    local progressBar = Instance.new("Frame")
    progressBar.Name = "ProgressBar"
    progressBar.Size = UDim2.new(0, 0, 1, 0)
    progressBar.Position = UDim2.new(0, 0, 0, 0)
    progressBar.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    progressBar.BorderSizePixel = 0
    progressBar.Parent = progressBG
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 4)
    fillCorner.Parent = progressBar
    
    -- Status Text
    local statusText = Instance.new("TextLabel")
    statusText.Name = "StatusText"
    statusText.Size = UDim2.new(1, 0, 0, 30)
    statusText.Position = UDim2.new(0, 0, 0, 160)
    statusText.BackgroundTransparency = 1
    statusText.Text = "Preparing soil..."
    statusText.TextColor3 = Color3.fromRGB(200, 240, 200)
    statusText.TextSize = 16
    statusText.Font = Enum.Font.Gotham
    statusText.Parent = mainFrame
    
    -- Percentage Text
    local percentText = Instance.new("TextLabel")
    percentText.Name = "PercentText"
    percentText.Size = UDim2.new(1, 0, 0, 25)
    percentText.Position = UDim2.new(0, 0, 0, 190)
    percentText.BackgroundTransparency = 1
    percentText.Text = "0%"
    percentText.TextColor3 = Color3.fromRGB(50, 200, 50)
    percentText.TextSize = 18
    percentText.Font = Enum.Font.GothamBold
    percentText.Parent = mainFrame
    
    return screenGui, statusText, percentText, progressBar
end

-- Update Progress Function
local function updateProgress(statusText, percentText, progressBar, progress, status)
    if statusText then statusText.Text = status end
    if percentText then percentText.Text = progress .. "%" end
    
    if progressBar then
        local tween = TweenService:Create(
            progressBar,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(progress / 100, 0, 1, 0)}
        )
        tween:Play()
    end
end

-- Main Loader Function
local function startLoader()
    print("Creating garden loader GUI...")
    
    -- Create GUI
    local gui, statusText, percentText, progressBar = createLoaderGUI()
    
    -- Step 1: Initialize
    updateProgress(statusText, percentText, progressBar, 10, "🌿 Connecting to garden framework...")
    wait(0.5)
    
    -- Step 2: Download script
    updateProgress(statusText, percentText, progressBar, 30, "🌱 Downloading garden engine...")
    
    local downloadSuccess, scriptContent = pcall(function()
        return game:HttpGet(CONFIG.REPO_URL)
    end)
    
    if not downloadSuccess then
        updateProgress(statusText, percentText, progressBar, 0, "❌ Garden setup failed!")
        statusText.TextColor3 = Color3.fromRGB(255, 100, 100)
        progressBar.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        print("❌ Error downloading garden script:", scriptContent)
        wait(3)
        gui:Destroy()
        return
    end
    
    updateProgress(statusText, percentText, progressBar, 60, "✅ Garden engine downloaded!")
    print("✅ Downloaded garden script (" .. #scriptContent .. " characters)")
    wait(0.5)
    
    -- Step 3: Compile script
    updateProgress(statusText, percentText, progressBar, 80, "🌿 Preparing garden tools...")
    
    local compileSuccess, compiledScript = pcall(function()
        return loadstring(scriptContent)
    end)
    
    if not compileSuccess or not compiledScript then
        updateProgress(statusText, percentText, progressBar, 0, "❌ Garden tools setup failed!")
        statusText.TextColor3 = Color3.fromRGB(255, 100, 100)
        progressBar.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        print("❌ Error compiling garden script:", compiledScript)
        wait(3)
        gui:Destroy()
        return
    end
    
    updateProgress(statusText, percentText, progressBar, 90, "🌱 Garden tools ready!")
    wait(0.5)
    
    -- Step 4: Execute
    updateProgress(statusText, percentText, progressBar, 100, "🌻 Starting your garden...")
    statusText.TextColor3 = Color3.fromRGB(100, 255, 100)
    wait(1)
    
    -- Execute the script
    local executeSuccess, executeError = pcall(compiledScript)
    
    if executeSuccess then
        updateProgress(statusText, percentText, progressBar, 100, "🌸 Garden is growing!")
        print("🌱 Garden Growth System loaded successfully!")
        wait(2)
    else
        updateProgress(statusText, percentText, progressBar, 0, "❌ Garden failed to grow!")
        statusText.TextColor3 = Color3.fromRGB(255, 100, 100)
        progressBar.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        print("❌ Error starting garden:", executeError)
        wait(3)
    end
    
    -- Clean up GUI
    gui:Destroy()
end

-- Start the loader
startLoader()
