-- NullInject Premium - Modern Key System Loader (HTTPS Version)
-- Requires internet connection and HTTP access

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

-- Configuration URLs
local KEYS_URL = "https://raw.githubusercontent.com/Rephra/NullInject-Hub/main/keys.txt"
local SCRIPT_URL = "https://raw.githubusercontent.com/Rephra/NullInject-Hub/main/Nullinject.lua"

local gui = nil

-- Create modern key system GUI
local function createKeyGUI()
    if gui then gui:Destroy() end

    -- Load main script function
    local function loadMainScript()
        local success, result = pcall(function()
            return HttpService:GetAsync(SCRIPT_URL)
        end)
        
        if success then
            local loadSuccess, loadResult = pcall(function()
                return loadstring(result)()
            end)
            if not loadSuccess then
                warn("NullInject Premium: Error loading main script - " .. tostring(loadResult))
            end
        else
            warn("NullInject Premium: Failed to fetch main script - " .. tostring(result))
        end
    end

    -- Main ScreenGui
    gui = Instance.new("ScreenGui")
    gui.Name = "NullInjectPremiumKeySystem"
    gui.ResetOnSpawn = false
    gui.Parent = game.CoreGui

    -- Background blur overlay
    local background = Instance.new("Frame")
    background.Name = "Background"
    background.Size = UDim2.new(1, 0, 1, 0)
    background.Position = UDim2.new(0, 0, 0, 0)
    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    background.BackgroundTransparency = 0.4
    background.BorderSizePixel = 0
    background.Parent = gui

    -- Main container frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 400, 0, 450)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -225)
    mainFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = gui

    -- Rounded corners
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = mainFrame

    -- Close button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 24, 0, 24)
    closeButton.Position = UDim2.new(1, -34, 0, 10)
    closeButton.BackgroundTransparency = 1
    closeButton.Text = "✕"
    closeButton.TextColor3 = Color3.fromRGB(160, 160, 160)
    closeButton.TextSize = 16
    closeButton.Font = Enum.Font.GothamSemibold
    closeButton.Parent = mainFrame

    -- Logo icon
    local logoFrame = Instance.new("Frame")
    logoFrame.Name = "LogoFrame"  
    logoFrame.Size = UDim2.new(0, 60, 0, 60)
    logoFrame.Position = UDim2.new(0.5, -30, 0, 50)
    logoFrame.BackgroundTransparency = 1
    logoFrame.Parent = mainFrame

    local triangleIcon = Instance.new("TextLabel")
    triangleIcon.Name = "TriangleIcon"
    triangleIcon.Size = UDim2.new(1, 0, 1, 0)
    triangleIcon.Position = UDim2.new(0, 0, 0, 0)
    triangleIcon.BackgroundTransparency = 1
    triangleIcon.Text = "▽"
    triangleIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    triangleIcon.TextScaled = true
    triangleIcon.Font = Enum.Font.GothamBold
    triangleIcon.Parent = logoFrame

    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(0, 300, 0, 40)
    titleLabel.Position = UDim2.new(0.5, -150, 0, 120)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "NullInject Premium"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 24
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.Parent = mainFrame

    -- Subtitle
    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Name = "Subtitle"
    subtitleLabel.Size = UDim2.new(0, 300, 0, 20)
    subtitleLabel.Position = UDim2.new(0.5, -150, 0, 160)
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.Text = "Enter your premium key to continue"
    subtitleLabel.TextColor3 = Color3.fromRGB(140, 140, 140)
    subtitleLabel.TextSize = 14
    subtitleLabel.Font = Enum.Font.Gotham
    subtitleLabel.TextXAlignment = Enum.TextXAlignment.Center
    subtitleLabel.Parent = mainFrame

    -- Key input frame
    local inputFrame = Instance.new("Frame")
    inputFrame.Name = "InputFrame"
    inputFrame.Size = UDim2.new(0, 340, 0, 50)
    inputFrame.Position = UDim2.new(0.5, -170, 0, 200)
    inputFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    inputFrame.BorderSizePixel = 0
    inputFrame.Parent = mainFrame

    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 8)
    inputCorner.Parent = inputFrame

    -- Key icon
    local keyIcon = Instance.new("TextLabel")
    keyIcon.Name = "KeyIcon"
    keyIcon.Size = UDim2.new(0, 20, 0, 20)
    keyIcon.Position = UDim2.new(0, 15, 0.5, -10)
    keyIcon.BackgroundTransparency = 1
    keyIcon.Text = "🔐"
    keyIcon.TextColor3 = Color3.fromRGB(160, 160, 160)
    keyIcon.TextSize = 16
    keyIcon.Font = Enum.Font.Gotham
    keyIcon.Parent = inputFrame

    -- Key input
    local keyInput = Instance.new("TextBox")
    keyInput.Name = "KeyInput"
    keyInput.Size = UDim2.new(1, -50, 1, -10)
    keyInput.Position = UDim2.new(0, 45, 0, 5)
    keyInput.BackgroundTransparency = 1
    keyInput.Text = ""
    keyInput.PlaceholderText = "Enter your premium key..."
    keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
    keyInput.TextSize = 14
    keyInput.Font = Enum.Font.Gotham
    keyInput.TextXAlignment = Enum.TextXAlignment.Left
    keyInput.Parent = inputFrame

    -- Status label
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "StatusLabel"
    statusLabel.Size = UDim2.new(0, 340, 0, 20)
    statusLabel.Position = UDim2.new(0.5, -170, 0, 275)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = ""
    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    statusLabel.TextSize = 14
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextXAlignment = Enum.TextXAlignment.Center
    statusLabel.Parent = mainFrame

    -- Validate button
    local validateButton = Instance.new("TextButton")
    validateButton.Name = "ValidateButton"
    validateButton.Size = UDim2.new(0, 340, 0, 45)
    validateButton.Position = UDim2.new(0.5, -170, 0, 305)
    validateButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    validateButton.BorderSizePixel = 0
    validateButton.Text = "VALIDATE KEY"
    validateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    validateButton.TextSize = 16
    validateButton.Font = Enum.Font.GothamBold
    validateButton.Parent = mainFrame

    local validateCorner = Instance.new("UICorner")
    validateCorner.CornerRadius = UDim.new(0, 8)
    validateCorner.Parent = validateButton

    -- Get key button
    local getKeyButton = Instance.new("TextButton")
    getKeyButton.Name = "GetKeyButton"
    getKeyButton.Size = UDim2.new(0, 160, 0, 35)
    getKeyButton.Position = UDim2.new(0.5, -80, 0, 370)
    getKeyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    getKeyButton.BorderSizePixel = 0
    getKeyButton.Text = "Get Premium Key"
    getKeyButton.TextColor3 = Color3.fromRGB(160, 160, 160)
    getKeyButton.TextSize = 14
    getKeyButton.Font = Enum.Font.Gotham
    getKeyButton.Parent = mainFrame

    local getKeyCorner = Instance.new("UICorner")
    getKeyCorner.CornerRadius = UDim.new(0, 6)
    getKeyCorner.Parent = getKeyButton

    -- Helper functions
    local function updateStatus(message, color)
        statusLabel.Text = message
        statusLabel.TextColor3 = color or Color3.fromRGB(255, 100, 100)
    end

    -- Validate key function
    local function validateKey()
        local enteredKey = keyInput.Text:gsub("%s+", "")
        
        if enteredKey == "" then
            updateStatus("❌ Please enter a key!")
            return
        end

        updateStatus("🔄 Validating key...", Color3.fromRGB(255, 200, 100))
        validateButton.Text = "VALIDATING..."
        validateButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120)

        -- Fetch and validate from GitHub
        spawn(function()
            local success, result = pcall(function()
                return HttpService:GetAsync(KEYS_URL)
            end)

            wait(1) -- Show validation animation

            if success then
                local found = false
                for key in result:gmatch("[^\r\n]+") do
                    key = key:gsub("%s+", "")
                    if key:upper() == enteredKey:upper() then
                        found = true
                        break
                    end
                end
                
                if found then
                    updateStatus("✅ Key validated! Loading script...", Color3.fromRGB(100, 255, 100))
                    validateButton.Text = "SUCCESS"
                    validateButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
                    
                    wait(1)
                    gui:Destroy()
                    loadMainScript()
                else
                    updateStatus("❌ Invalid key! Please try again.")
                    validateButton.Text = "VALIDATE KEY"
                    validateButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
                    keyInput.Text = ""
                end
            else
                updateStatus("❌ Connection failed. Please check your internet connection.")
                validateButton.Text = "VALIDATE KEY"
                validateButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
            end
        end)
    end

    -- Event connections
    validateButton.MouseButton1Click:Connect(validateKey)
    
    keyInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            validateKey()
        end
    end)

    getKeyButton.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard("https://discord.gg/yourinvitehere")
            updateStatus("📋 Discord invite copied!", Color3.fromRGB(100, 255, 100))
        else
            updateStatus("📋 Join Discord: discord.gg/yourinvitehere", Color3.fromRGB(100, 200, 255))
        end
    end)

    closeButton.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    -- Hover effects
    validateButton.MouseEnter:Connect(function()
        if validateButton.Text == "VALIDATE KEY" then
            TweenService:Create(validateButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(108, 121, 255)}):Play()
        end
    end)

    validateButton.MouseLeave:Connect(function()
        if validateButton.Text == "VALIDATE KEY" then
            TweenService:Create(validateButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(88, 101, 242)}):Play()
        end
    end)

    getKeyButton.MouseEnter:Connect(function()
        TweenService:Create(getKeyButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
    end)

    getKeyButton.MouseLeave:Connect(function()
        TweenService:Create(getKeyButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
    end)

    closeButton.MouseEnter:Connect(function()
        TweenService:Create(closeButton, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 100, 100)}):Play()
    end)

    closeButton.MouseLeave:Connect(function()
        TweenService:Create(closeButton, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(160, 160, 160)}):Play()
    end)

    -- Input focus effects
    keyInput.Focused:Connect(function()
        TweenService:Create(inputFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
        TweenService:Create(keyIcon, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(88, 101, 242)}):Play()
    end)

    keyInput.FocusLost:Connect(function()
        TweenService:Create(inputFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
        TweenService:Create(keyIcon, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(160, 160, 160)}):Play()
    end)

    -- Entrance animation
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    local entranceAnimation = TweenService:Create(
        mainFrame,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {
            Size = UDim2.new(0, 400, 0, 450),
            Position = UDim2.new(0.5, -200, 0.5, -225)
        }
    )
    entranceAnimation:Play()
end

-- Initialize the key system
createKeyGUI()
