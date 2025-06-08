-- NullInject Premium - Direct Loader (No File Dependencies)
-- This version loads the script directly without file system dependencies

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

-- Direct GitHub raw URL for the main script
local SCRIPT_URL = "https://raw.githubusercontent.com/rephra/NullInject-Hub/main/Nullinject.lua"

-- Valid keys (embedded directly)
local VALID_KEYS = {
    "REPHRA-2024-PREMIUM",
    "TEST-KEY-12345", 
    "DISCORD-MEMBER-VIP",
    "GITHUB-SUPPORTER-001",
    "EARLY-ACCESS-2024"
}

-- Simple key validation and script loading
local function validateAndLoad(key)
    -- Validate key
    local keyValid = false
    local cleanKey = key:gsub("%s+", ""):upper()
    
    for _, validKey in ipairs(VALID_KEYS) do
        if validKey:upper() == cleanKey then
            keyValid = true
            break
        end
    end
    
    if not keyValid then
        warn("❌ Invalid key provided")
        return false
    end
    
    print("✅ Key validated successfully")
    
    -- Load and execute main script
    local success, result = pcall(function()
        return HttpService:GetAsync(SCRIPT_URL)
    end)
    
    if success and result then
        print("✅ Script downloaded successfully")
        local execSuccess, execResult = pcall(function()
            return loadstring(result)()
        end)
        
        if execSuccess then
            print("✅ NullInject Premium loaded successfully!")
            return true
        else
            warn("❌ Script execution failed:", execResult)
            return false
        end
    else
        warn("❌ Failed to download script:", result)
        return false
    end
end

-- Example usage:
-- validateAndLoad("REPHRA-2024-PREMIUM")

print("🔑 NullInject Direct Loader Ready")
print("📋 Available keys:", table.concat(VALID_KEYS, ", "))
print("💡 Usage: validateAndLoad('YOUR-KEY-HERE')")
