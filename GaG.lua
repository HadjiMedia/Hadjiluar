local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "👨🏿‍🌾 Grow a Garden Script 👩🏻‍🌾",
    LoadingTitle = "🌱 Grow a Garden Script 🌿",
    LoadingSubtitle = "by Hadji",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil, -- Optional: set folder name
        FileName = "GAG"
    },
    Discord = {
        Enabled = true,
        Invite = "Hadji", -- Discord invite code only (no URL)
        RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
        Title = "Grow a Garden | Key",
        Subtitle = "Key System",
        Note = "Join the Discord Server to get the key",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = true,
        KeyLink = "https://pastebin.com/raw/GpkZHNdm"
    }
})

-- Tabs
local FarmTab = Window:CreateTab("Auto Farm", nil)
local ShopTab = Window:CreateTab("Shop", nil)
local PlayerTab = Window:CreateTab("Local Player", nil)
local MiscTab = Window:CreateTab("Misc", nil)

-- 🔄 Infinite Jump (Toggle)
PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(value)
        _G.infinjump = value
        local UIS = game:GetService("UserInputService")
        local LP = game:GetService("Players").LocalPlayer

        repeat task.wait() until LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")

        if not _G._infJumpConnection then
            _G._infJumpConnection = UIS.JumpRequest:Connect(function()
                if _G.infinjump then
                    local humanoid = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end)
        end
    end,
})

-- 🔧 Auto Craft Setup
local selectedRecipe = "Reclaimer"
local autoCraft = false
local craftDelay = 2

FarmTab:CreateDropdown({
    Name = "Select Recipe",
    Options = {"Reclaimer", "Small Toy", "Anti Bee Egg"},
    CurrentOption = selectedRecipe,
    Callback = function(option)
        selectedRecipe = option
    end,
})

FarmTab:CreateSlider({
    Name = "Craft Delay (seconds)",
    Range = {0.5, 5},
    Increment = 0.5,
    CurrentValue = craftDelay,
    Callback = function(value)
        craftDelay = value
    end,
})

FarmTab:CreateToggle({
    Name = "Auto Craft",
    CurrentValue = false,
    Callback = function(state)
        autoCraft = state
        if autoCraft then
            task.spawn(function()
                while autoCraft do
                    pcall(function()
                        local station = workspace:WaitForChild("CraftingTables"):WaitForChild("EventCraftingWorkBench")
                        local service = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService")

                        service:FireServer("SetRecipe", station, "GearEventWorkbench", selectedRecipe)
                        task.wait(0.25)

                        service:FireServer("SubmitHeldItemForCrafting", station)
                        task.wait(0.25)

                        service:FireServer("Craft", station, "GearEventWorkbench")
                    end)
                    task.wait(craftDelay)
                end
            end)
        end
    end,
})