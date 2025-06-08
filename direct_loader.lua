-- NullInject Premium - Direct Loader with Minimal Key System
-- Simple loader with sleek, minimal design

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

-- Configuration
local SCRIPT_URL = "https://raw.githubusercontent.com/Rephra/NullInject-Hub/main/Nullinject.lua"
local KEYS_URL = "https://raw.githubusercontent.com/Rephra/NullInject-Hub/main/keys.txt"

-- Approved keys (fallback if server unavailable)
local APPROVED_KEYS = {
    "NULLINJECT-2024",
    "PREMIUM-ACCESS"
}

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

-- Create key verification GUI
local function createKeyGUI()
    -- Main ScreenGui
    local gui = Instance.new("ScreenGui")
    gui.Name = "NullInjectKeySystem"
    gui.ResetOnSpawn = false
    gui.Parent = game.CoreGui
    
    -- Background frame
    local background = Instance.new("Frame")
    background.Name = "Background"
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    background.BackgroundTransparency = 0.3
    background.BorderSizePixel = 0
    background.Parent = gui
    
    -- Key container
    local container = Instance.new("Frame")
    container.Name = "Container"
    container.Size = UDim2.new(0, 300, 0, 180)
    container.Position = UDim2.new(0.5, -150, 0.5, -90)
    container.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    container.BorderSizePixel = 0
    container.Parent = gui
    
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 8)
    containerCorner.Parent = container
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -40, 0, 30)
    title.Position = UDim2.new(0, 20, 0, 15)
    title.BackgroundTransparency = 1
    title.Text = "NullInject Premium"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 18
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = container
    
    -- Subtitle
    local subtitle = Instance.new("TextLabel")
    subtitle.Name = "Subtitle"
    subtitle.Size = UDim2.new(1, -40, 0, 20)
    subtitle.Position = UDim2.new(0, 20, 0, 45)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "Enter your key below"
    subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
    subtitle.TextSize = 14
    subtitle.Font = Enum.Font.Gotham
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.Parent = container
    
    -- Input background
    local inputBg = Instance.new("Frame")
    inputBg.Name = "InputBackground"
    inputBg.Size = UDim2.new(1, -40, 0, 36)
    inputBg.Position = UDim2.new(0, 20, 0, 75)
    inputBg.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    inputBg.BorderSizePixel = 0
    inputBg.Parent = container
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 6)
    inputCorner.Parent = inputBg
    
    -- Key input
    local keyInput = Instance.new("TextBox")
    keyInput.Name = "KeyInput"
    keyInput.Size = UDim2.new(1, -16, 1, -6)
    keyInput.Position = UDim2.new(0, 8, 0, 3)
    keyInput.BackgroundTransparency = 1
    keyInput.Text = ""
    keyInput.PlaceholderText = "Enter your key..."
    keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
    keyInput.TextSize = 14
    keyInput.Font = Enum.Font.Gotham
    keyInput.Parent = inputBg
    
    -- Status label
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "Status"
    statusLabel.Size = UDim2.new(1, -40, 0, 20)
    statusLabel.Position = UDim2.new(0, 20, 0, 120)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = ""
    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    statusLabel.TextSize = 14
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = container
    
    -- Submit button
    local submitButton = Instance.new("TextButton")
    submitButton.Name = "SubmitButton"
    submitButton.Size = UDim2.new(1, -40, 0, 36)
    submitButton.Position = UDim2.new(0, 20, 1, -56)
    submitButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    submitButton.BorderSizePixel = 0
    submitButton.Text = "VERIFY"
    submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitButton.TextSize = 14
    submitButton.Font = Enum.Font.GothamBold
    submitButton.Parent = container
    
    local submitCorner = Instance.new("UICorner")
    submitCorner.CornerRadius = UDim.new(0, 6)
    submitCorner.Parent = submitButton
    
    -- Animation
    container.Size = UDim2.new(0, 0, 0, 0)
    container.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    local openAnim = TweenService:Create(container, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 300, 0, 180),
        Position = UDim2.new(0.5, -150, 0.5, -90)
    })
    openAnim:Play()
    
    -- Helper function to update status
    local function updateStatus(message, color)
        statusLabel.Text = message
        statusLabel.TextColor3 = color or Color3.fromRGB(255, 100, 100)
    end
    
    -- Verify key function
    local function verifyKey()
        local key = keyInput.Text:gsub("%s+", "")
        
        if key == "" then
            updateStatus("Please enter a key")
            return
        end
        
        updateStatus("Verifying key...", Color3.fromRGB(255, 200, 0))
        submitButton.Text = "VERIFYING..."
        submitButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        
        -- Verify with server
        local validKey = false
        local success, keyData = pcall(function()
            return HttpService:GetAsync(KEYS_URL)
        end)
        
        if success then
            -- Check against server keys
            for line in keyData:gmatch("[^\r\n]+") do
                line = line:gsub("%s+", "")
                if not line:match("^#") and line ~= "" and line:upper() == key:upper() then
                    validKey = true
                    break
                end
            end
        else
            -- Check against fallback keys
            for _, validKey in ipairs(APPROVED_KEYS) do
                if validKey:upper() == key:upper() then
                    validKey = true
                    break
                end
            end
        end
        
        wait(0.5) -- short delay for verification effect
        
        if validKey then
            updateStatus("Key accepted!", Color3.fromRGB(0, 200, 100))
            submitButton.Text = "SUCCESS"
            submitButton.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
            
            wait(1)
            
            -- Close animation
            local closeAnim = TweenService:Create(container, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            })
            closeAnim:Play()
            
            closeAnim.Completed:Connect(function()
                gui:Destroy()
                loadScript()
            end)
        else
            updateStatus("Invalid key")
            submitButton.Text = "VERIFY"
            submitButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
        end
    end
    
    -- Button events
    submitButton.MouseButton1Click:Connect(verifyKey)
    keyInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            verifyKey()
        end
    end)
    
    -- Hover effects
    submitButton.MouseEnter:Connect(function()
        if submitButton.Text == "VERIFY" then
            TweenService:Create(submitButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(108, 121, 255)}):Play()
        end
    end)
    
    submitButton.MouseLeave:Connect(function()
        if submitButton.Text == "VERIFY" then
            TweenService:Create(submitButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(88, 101, 242)}):Play()
        end
    end)
    
    -- Focus effects
    keyInput.Focused:Connect(function()
        TweenService:Create(inputBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
    end)
    
    keyInput.FocusLost:Connect(function()
        TweenService:Create(inputBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
    end)
end

-- Load the script after key verification
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

-- Start with key verification
createKeyGUI()
