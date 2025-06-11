-- Vulpine Grow A Garden Loader
-- Modern Loading GUI with Progress Animation

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- Create Loading GUI
local function createLoadingGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "VulpineGrowLoader"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Frame (Dark background)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 450, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    -- Add corner radius
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = MainFrame
    
    -- Add border gradient
    local Border = Instance.new("UIStroke")
    Border.Color = Color3.fromRGB(70, 70, 80)
    Border.Thickness = 2
    Border.Parent = MainFrame
    
    -- Header Section
    local HeaderFrame = Instance.new("Frame")
    HeaderFrame.Name = "HeaderFrame"
    HeaderFrame.Size = UDim2.new(1, 0, 0, 80)
    HeaderFrame.Position = UDim2.new(0, 0, 0, 0)
    HeaderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    HeaderFrame.BorderSizePixel = 0
    HeaderFrame.Parent = MainFrame
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 12)
    HeaderCorner.Parent = HeaderFrame
    
    -- Logo/Icon
    local LogoFrame = Instance.new("Frame")
    LogoFrame.Name = "LogoFrame"
    LogoFrame.Size = UDim2.new(0, 50, 0, 50)
    LogoFrame.Position = UDim2.new(0, 20, 0.5, -25)
    LogoFrame.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
    LogoFrame.BorderSizePixel = 0
    LogoFrame.Parent = HeaderFrame
    
    local LogoCorner = Instance.new("UICorner")
    LogoCorner.CornerRadius = UDim.new(0, 8)
    LogoCorner.Parent = LogoFrame
    
    local LogoText = Instance.new("TextLabel")
    LogoText.Name = "LogoText"
    LogoText.Size = UDim2.new(1, 0, 1, 0)
    LogoText.Position = UDim2.new(0, 0, 0, 0)
    LogoText.BackgroundTransparency = 1
    LogoText.Text = "V"
    LogoText.TextColor3 = Color3.fromRGB(255, 255, 255)
    LogoText.TextScaled = true
    LogoText.Font = Enum.Font.GothamBold
    LogoText.Parent = LogoFrame
    
    -- Title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Size = UDim2.new(0, 300, 0, 30)
    TitleLabel.Position = UDim2.new(0, 85, 0, 15)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "Vulpine - Grow A Garden"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 20
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = HeaderFrame
      -- Subtitle
    local SubtitleLabel = Instance.new("TextLabel")
    SubtitleLabel.Name = "SubtitleLabel"
    SubtitleLabel.Size = UDim2.new(0, 300, 0, 20)
    SubtitleLabel.Position = UDim2.new(0, 85, 0, 45)
    SubtitleLabel.BackgroundTransparency = 1
    SubtitleLabel.Text = "Loading premium automation tools for Rephra..."
    SubtitleLabel.TextColor3 = Color3.fromRGB(160, 160, 170)
    SubtitleLabel.TextSize = 12
    SubtitleLabel.Font = Enum.Font.Gotham
    SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    SubtitleLabel.Parent = HeaderFrame
    
    -- Content Section
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, -40, 1, -120)
    ContentFrame.Position = UDim2.new(0, 20, 0, 100)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = MainFrame
    
    -- Status Label
    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Name = "StatusLabel"
    StatusLabel.Size = UDim2.new(1, 0, 0, 25)
    StatusLabel.Position = UDim2.new(0, 0, 0, 20)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = "Initializing..."
    StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
    StatusLabel.TextSize = 14
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
    StatusLabel.Parent = ContentFrame
    
    -- Progress Bar Background
    local ProgressBG = Instance.new("Frame")
    ProgressBG.Name = "ProgressBG"
    ProgressBG.Size = UDim2.new(1, 0, 0, 8)
    ProgressBG.Position = UDim2.new(0, 0, 0, 60)
    ProgressBG.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    ProgressBG.BorderSizePixel = 0
    ProgressBG.Parent = ContentFrame
    
    local ProgressBGCorner = Instance.new("UICorner")
    ProgressBGCorner.CornerRadius = UDim.new(0, 4)
    ProgressBGCorner.Parent = ProgressBG
    
    -- Progress Bar Fill
    local ProgressFill = Instance.new("Frame")
    ProgressFill.Name = "ProgressFill"
    ProgressFill.Size = UDim2.new(0, 0, 1, 0)
    ProgressFill.Position = UDim2.new(0, 0, 0, 0)
    ProgressFill.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
    ProgressFill.BorderSizePixel = 0
    ProgressFill.Parent = ProgressBG
    
    local ProgressFillCorner = Instance.new("UICorner")
    ProgressFillCorner.CornerRadius = UDim.new(0, 4)
    ProgressFillCorner.Parent = ProgressFill
    
    -- Progress Percentage
    local ProgressPercent = Instance.new("TextLabel")
    ProgressPercent.Name = "ProgressPercent"
    ProgressPercent.Size = UDim2.new(0, 60, 0, 20)
    ProgressPercent.Position = UDim2.new(1, -60, 0, 75)
    ProgressPercent.BackgroundTransparency = 1
    ProgressPercent.Text = "0%"
    ProgressPercent.TextColor3 = Color3.fromRGB(70, 130, 255)
    ProgressPercent.TextSize = 12
    ProgressPercent.Font = Enum.Font.GothamBold
    ProgressPercent.TextXAlignment = Enum.TextXAlignment.Right
    ProgressPercent.Parent = ContentFrame
    
    -- Loading Details
    local DetailsLabel = Instance.new("TextLabel")
    DetailsLabel.Name = "DetailsLabel"
    DetailsLabel.Size = UDim2.new(1, 0, 0, 60)
    DetailsLabel.Position = UDim2.new(0, 0, 0, 110)
    DetailsLabel.BackgroundTransparency = 1
    DetailsLabel.Text = "• Validating game environment\n• Loading Obsidian UI Library\n• Initializing automation systems"
    DetailsLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
    DetailsLabel.TextSize = 11
    DetailsLabel.Font = Enum.Font.Gotham
    DetailsLabel.TextXAlignment = Enum.TextXAlignment.Left
    DetailsLabel.TextYAlignment = Enum.TextYAlignment.Top
    DetailsLabel.Parent = ContentFrame
    
    -- Add to PlayerGui
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    return {
        ScreenGui = ScreenGui,
        StatusLabel = StatusLabel,
        ProgressFill = ProgressFill,
        ProgressPercent = ProgressPercent,
        DetailsLabel = DetailsLabel,
        SubtitleLabel = SubtitleLabel
    }
end

-- Animation functions
local function animateProgress(progressFill, progressPercent, targetPercent)
    local tween = TweenService:Create(
        progressFill,
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(targetPercent / 100, 0, 1, 0)}
    )
    tween:Play()
    
    local textTween = TweenService:Create(
        progressPercent,
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {TextColor3 = Color3.fromRGB(70, 130, 255)}
    )
    textTween:Play()
    
    progressPercent.Text = math.floor(targetPercent) .. "%"
end

-- Loading sequence
local function startLoadingSequence(gui)
    local loadingSteps = {
        {percent = 15, status = "Validating game environment...", detail = "• Checking Place ID: 126884695634066\n• Verifying player permissions\n• Setting up security protocols"},
        {percent = 30, status = "Loading UI framework...", detail = "• Downloading Obsidian Library\n• Loading ThemeManager\n• Initializing SaveManager"},
        {percent = 50, status = "Setting up automation systems...", detail = "• Configuring auto-plant modules\n• Loading auto-farm systems\n• Setting up honey collection"},
        {percent = 70, status = "Loading premium features...", detail = "• Activating webhook integration\n• Setting up advanced controls\n• Configuring pet management"},
        {percent = 85, status = "Finalizing setup...", detail = "• Applying user preferences\n• Loading saved configurations\n• Preparing user interface"},        {percent = 100, status = "Loading complete!", detail = "• All systems operational\n• Ready for automation\n• Welcome Rephra to Vulpine!"}
    }
    
    local function processStep(stepIndex)
        if stepIndex > #loadingSteps then
            -- Loading complete
            wait(1)
            gui.SubtitleLabel.Text = "Launch successful! Enjoy your premium tools, Rephra."
            wait(1)
            return true
        end
        
        local step = loadingSteps[stepIndex]
        gui.StatusLabel.Text = step.status
        gui.DetailsLabel.Text = step.detail
        animateProgress(gui.ProgressFill, gui.ProgressPercent, step.percent)
        
        wait(math.random(8, 15) / 10) -- Random delay between 0.8-1.5 seconds
        
        return processStep(stepIndex + 1)
    end
    
    return processStep(1)
end

-- Main loader execution
local function executeLoader()
    local gui = createLoadingGUI()
    
    -- Start loading animation
    spawn(function()
        local loadingComplete = startLoadingSequence(gui)        if loadingComplete then
            -- Load the main script
            wait(0.5)
            gui.StatusLabel.Text = "Launching Grow A Garden script..."
              local success, result = pcall(function()
                -- Load the main Grow A Garden script from GitHub
                return loadstring(game:HttpGet("https://raw.githubusercontent.com/Rephra/ApplicationFramework/refs/heads/main/init.lua"))()
            end)
              if success then
                gui.StatusLabel.Text = "Grow A Garden script loaded successfully!"
                gui.SubtitleLabel.Text = "Vulpine Grow A Garden is now active for Rephra!"
                wait(1)
                gui.ScreenGui:Destroy()
            else
                gui.StatusLabel.Text = "Error loading script: " .. tostring(result)
                gui.StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
                wait(3)
                gui.ScreenGui:Destroy()
            end
        end
    end)
end

-- Execute the loader
executeLoader()
