local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--Loader

local Window = Rayfield:CreateWindow({
   Name = "⚔️Saber Simulator - Hadji⚔️",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "⚡Saber Simulator Automation ⚡",
   LoadingSubtitle = "by HadjiZXC",
   ShowText = "", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

--Tab
local FarmTab = Window:CreateTab("Auto Farm", nil)
local ShopTab = Window:CreateTab("Auto Buy", nil)
local BossTab = Window:CreateTab("Auto Boss", nil)
local EggTab = Window:CreateTab("Auto Egg/Pet", nil)


--FARM AUTOMATION⚔️
FarmTab:CreateToggle({
    Name = "Auto Swing Saber",
    CurrentValue = false,
    Callback = function(state)
        autoSwing = state
        if autoSwing then
            swingConnection = task.spawn(function()
                while autoSwing do
                    pcall(function()
                        game:GetService("ReplicatedStorage")
                            :WaitForChild("Events")
                            :WaitForChild("SwingSaber")
                            :FireServer()
                    end)
                    task.wait(0.1)
                end
            end)
        else
            autoSwing = false
        end
    end,
})

local autoSell = false
local sellConnection

FarmTab:CreateToggle({
    Name = "Auto Sell",
    CurrentValue = false,
    Callback = function(state)
        autoSell = state
        if autoSell then
            sellConnection = task.spawn(function()
                while autoSell do
                    pcall(function()
                        game:GetService("ReplicatedStorage")
                            :WaitForChild("Events")
                            :WaitForChild("SellStrength")
                            :FireServer()
                    end)
                    task.wait(0.5) -- Adjust delay as needed
                end
            end)
        else
            autoSell = false
        end
    end,
})

autoClaimReward = false

FarmTab:CreateToggle({
    Name = "Auto Claim Daily Reward",
    CurrentValue = false,
    Callback = function(state)
        autoClaimReward = state
        if autoClaimReward then
            task.spawn(function()
                while autoClaimReward do
                    pcall(function()
                        local args = {
                            "ClaimDailyTimedReward"
                        }
                        game:GetService("ReplicatedStorage")
                            :WaitForChild("Events")
                            :WaitForChild("UIAction")
                            :FireServer(unpack(args))
                    end)
                    task.wait(300) -- Claim cooldown; adjust if needed
                end
            end)
        end
    end,
})

--SHOP AUTOMATION🛒

local autoBuySabers = false

ShopTab:CreateToggle({
    Name = "Auto Buy All Sabers",
    CurrentValue = false,
    Callback = function(state)
        autoBuySabers = state
        if autoBuySabers then
            task.spawn(function()
                while autoBuySabers do
                    pcall(function()
                        local args = {
                            "BuyAllWeapons"
                        }
                        game:GetService("ReplicatedStorage")
                            :WaitForChild("Events")
                            :WaitForChild("UIAction")
                            :FireServer(unpack(args))
                    end)
                    task.wait(30) -- Adjust delay as needed
                end
            end)
        end
    end,
})

local autoBuyDNAs = false

ShopTab:CreateToggle({
    Name = "Auto Buy All DNAs",
    CurrentValue = false,
    Callback = function(state)
        autoBuyDNAs = state
        if autoBuyDNAs then
            task.spawn(function()
                while autoBuyDNAs do
                    pcall(function()
                        local args = {
                            "BuyAllDNAs"
                        }
                        game:GetService("ReplicatedStorage")
                            :WaitForChild("Events")
                            :WaitForChild("UIAction")
                            :FireServer(unpack(args))
                    end)
                    task.wait(30) -- 30-second cooldown
                end
            end)
        end
    end,
})

-- Auto Buy Boss Boosts Toggle
local autoBuyBoosts = false

ShopTab:CreateToggle({
    Name = "Auto Buy Boss Boosts",
    CurrentValue = false,
    Callback = function(state)
        autoBuyBoosts = state
        if autoBuyBoosts then
            task.spawn(function()
                while autoBuyBoosts do
                    pcall(function()
                        local args = {
                            "BuyAllBossBoosts"
                        }
                        game:GetService("ReplicatedStorage")
                            :WaitForChild("Events")
                            :WaitForChild("UIAction")
                            :FireServer(unpack(args))
                    end)
                    task.wait(30) -- 30-second interval
                end
            end)
        end
    end,
})

--BOSS AUTOMATION👨🏿
-- Auto Hit Boss Toggle
local autoBossHit = false

BossTab:CreateToggle({
    Name = "Auto Hit Boss",
    CurrentValue = false,
    Callback = function(state)
        autoBossHit = state
        if autoBossHit then
            task.spawn(function()
                while autoBossHit do
                    pcall(function()
                        -- Teleport to boss CFrame
                        local bossCFrame = CFrame.new(
                            449.488251, 179.962845, 120.98494, 
                            -0.65304935, 0, 0.757315397, 
                            0, 1, 0, 
                            -0.757315397, 0, -0.65304935
                        )
                        local char = game.Players.LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = bossCFrame
                        end

                        -- Auto hit boss
                        local boss = workspace:WaitForChild("Gameplay"):WaitForChild("Boss"):WaitForChild("BossHolder"):FindFirstChild("Boss")
                        if boss then
                            local args = { { boss } }
                            game:GetService("Players").LocalPlayer.Character
                                :WaitForChild("Cursed")
                                :WaitForChild("RemoteClick")
                                :FireServer(unpack(args))
                        end
                    end)
                    task.wait(0.3) -- Adjust hit delay if needed
                end
            end)
        end
    end,
})

--EGG AUTOMATION🥚
