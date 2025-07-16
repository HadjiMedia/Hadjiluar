local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "👨🏿‍🌾 Grow a Garden Script 👩🏻‍🌾",
    LoadingTitle = "🌱 Grow a Garden Script 🌿",
    LoadingSubtitle = "by Hadji",
    ShowText = "Rayfield UI",
    Theme = "Default",
    ToggleUIKeybind = Enum.KeyCode.K,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "GAG"
    },
    Discord = {
        Enabled = false,
        Invite = "Hadji",
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

-- 🟢 Infinite Jump
PlayerTab:CreateButton({
    Name = "Infinite Jump",
    Callback = function()
        _G.infinjump = true
        local UIS = game:GetService("UserInputService")
        local LP = game:GetService("Players").LocalPlayer

        repeat task.wait() until LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")

        if not _G._infJumpConnection then
            _G._infJumpConnection = UIS.JumpRequest:Connect(function()
                if _G.infinjump then
                    local humanoid = LP.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end)
        end
    end,
})

-- 🛠️ Auto Crafting Setup
local selectedRecipe = "Reclaimer"
local autoCraft = false

FarmTab:CreateDropdown({
    Name = "Select Recipe",
    Options = {"Reclaimer", "Small Toy", "Anti Bee Egg"},
    CurrentOption = selectedRecipe,
    Callback = function(option)
        selectedRecipe = option
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

                        -- Set recipe
                        service:FireServer("SetRecipe", station, "GearEventWorkbench", selectedRecipe)
                        task.wait(0.25)

                        -- Submit held item
                        service:FireServer("SubmitHeldItemForCrafting", station)
                        task.wait(0.25)

                        -- Craft item
                        service:FireServer("Craft", station, "GearEventWorkbench")
                    end)
                    task.wait(2)
                end
            end)
        end
    end,
})