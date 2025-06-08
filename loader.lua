-- NullInject Premium - Modern Key System Loader
-- Clean version without obfuscation

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

-- Local file paths for offline mode
local KEYS_FILE = "keys.txt"
local SCRIPT_FILE = "Nullinject.lua"

-- GitHub repository URL for online loading
local GITHUB_RAW_URL = "https://raw.githubusercontent.com/rephra/NullInject-Hub/main/Nullinject.lua"

-- Valid keys array (can be updated directly here)
local VALID_KEYS = {
    "REPHRA-2024-PREMIUM",
    "TEST-KEY-12345", 
    "DISCORD-MEMBER-VIP",
    "GITHUB-SUPPORTER-001",
    "EARLY-ACCESS-2024"
}

local gui = nil

-- Debug function to check environment
local function checkEnvironment()
    print("=== NullInject Environment Check ===")
    print("readfile available:", readfile ~= nil)
    print("isfile available:", isfile ~= nil)
    print("loadstring available:", loadstring ~= nil)
    print("HttpService available:", game:GetService("HttpService") ~= nil)
    
    if readfile and isfile then
        print("Checking local files:")
        print("- " .. SCRIPT_FILE .. " exists:", isfile(SCRIPT_FILE))
        print("- " .. KEYS_FILE .. " exists:", isfile(KEYS_FILE))
    else
        print("File system functions not available in this executor")
    end
    
    print("Current workspace:", game:GetService("Workspace").Name)
    print("================================")
end

-- Create modern key system GUI
local function createKeyGUI()
    -- Run environment check for debugging
    checkEnvironment()
    
    if gui then gui:Destroy() end

    -- Load main script function
    local function loadMainScript()
        print("NullInject Premium: Attempting to load main script...")
        
        local scriptContent = nil
        local loadMethod = "unknown"
        
        -- Method 1: Try to read local file using readfile
        if not scriptContent then
            local success, result = pcall(function()
                if readfile and isfile and isfile(SCRIPT_FILE) then
                    return readfile(SCRIPT_FILE)
                end
                return nil
            end)
            
            if success and result and result ~= "" then
                scriptContent = result
                loadMethod = "local file"
                print("NullInject Premium: Script loaded from local file")
            end
        end
        
        -- Method 2: Try to load from GitHub
        if not scriptContent then
            local success, result = pcall(function()
                local HttpService = game:GetService("HttpService")
                return HttpService:GetAsync(GITHUB_RAW_URL)
            end)
            
            if success and result and result ~= "" then
                scriptContent = result
                loadMethod = "GitHub repository"
                print("NullInject Premium: Script loaded from GitHub repository")
            else
                warn("NullInject Premium: Failed to load from GitHub - " .. tostring(result))
            end
        end
        
        -- Method 3: Try alternative local loading
        if not scriptContent then
            local success, result = pcall(function()
                -- Try different approaches to load the script
                local workspace = game:GetService("Workspace")
                local scriptService = game:GetService("ServerScriptService")
                
                -- Look for the script in various locations
                local possiblePaths = {
                    "./Nullinject.lua",
                    "Nullinject.lua",
                    "/workspaces/NullInject-Hub/Nullinject.lua"
                }
                
                for _, path in ipairs(possiblePaths) do
                    if readfile and isfile and isfile(path) then
                        return readfile(path)
                    end
                end
                
                return nil
            end)
            
            if success and result and result ~= "" then
                scriptContent = result
                loadMethod = "alternative local method"
                print("NullInject Premium: Script loaded using alternative local method")
            end
        end
        
        -- Execute the script
        if scriptContent then
            local loadSuccess, loadResult = pcall(function()
                return loadstring(scriptContent)()
            end)
            
            if loadSuccess then
                print("NullInject Premium: Script executed successfully using " .. loadMethod)
            else
                warn("NullInject Premium: Error executing script - " .. tostring(loadResult))
                
                -- Show user-friendly error
                if gui and gui.Parent then
                    local mainFrame = gui:FindFirstChild("MainFrame")
                    if mainFrame then
                        local statusLabel = mainFrame:FindFirstChild("StatusLabel")
                        if statusLabel then
                            statusLabel.Text = "❌ Script execution error. Check console."
                            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
                        end
                    end
                end
            end
        else
            warn("NullInject Premium: Failed to load main script from any source")
            
            -- Show user-friendly error with suggestions
            if gui and gui.Parent then
                local mainFrame = gui:FindFirstChild("MainFrame")
                if mainFrame then
                    local statusLabel = mainFrame:FindFirstChild("StatusLabel")
                    if statusLabel then
                        statusLabel.Text = "❌ Script not found. Check file location or internet connection."
                        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
                    end
                end
            end
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

        -- Validate locally with fallback to file reading
        spawn(function()
            local success = false
            local found = false
            
            -- First try validating against local VALID_KEYS array
            for _, validKey in ipairs(VALID_KEYS) do
                if validKey:upper() == enteredKey:upper() then
                    found = true
                    success = true
                    break
                end
            end
            
            -- If not found in array, try reading from local file
            if not found then
                local fileSuccess, fileResult = pcall(function()
                    if readfile and isfile(KEYS_FILE) then
                        return readfile(KEYS_FILE)
                    end
                    return nil
                end)
                
                if fileSuccess and fileResult then
                    for key in fileResult:gmatch("[^\r\n]+") do
                        key = key:gsub("%s+", ""):gsub("#.*", "") -- Remove whitespace and comments
                        if key ~= "" and key:upper() == enteredKey:upper() then
                            found = true
                            success = true
                            break
                        end
                    end
                end
            end

            wait(1) -- Show validation animation

            if success and found then
                updateStatus("✅ Key validated! Loading script...", Color3.fromRGB(100, 255, 100))
                validateButton.Text = "SUCCESS"
                validateButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
                
                wait(1)
                
                -- Don't destroy GUI immediately in case we need to show error messages
                updateStatus("🔄 Loading main script...", Color3.fromRGB(100, 200, 255))
                
                spawn(function()
                    loadMainScript()
                    -- Only destroy GUI after successful load
                    wait(2)
                    if gui and gui.Parent then
                        gui:Destroy()
                    end
                end)
            else
                updateStatus("❌ Invalid key! Please try again.")
                validateButton.Text = "VALIDATE KEY"
                validateButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
                keyInput.Text = ""
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
