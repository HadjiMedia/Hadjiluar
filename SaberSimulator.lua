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
local MiscTab = Window:CreateTab("Misc", nil)



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
local Label = EggTab:CreateLabel("Egg Automation", 4483362458, Color3.fromRGB(255, 255, 255), true) -- Title, Icon, Color, IgnoreTheme
local selectedEgg = "Basic Egg" -- default egg
local autoBuyEgg = false

EggTab:CreateDropdown({
    Name = "Select Egg",
    Options = {
        "Basic Egg",
        "Wooden Egg",
        "Spiky Egg",
        "Frozen Egg",
        "Golden Egg",
        "Rainbow Egg",
        "Void Egg",
        "Mythical Egg",
        "Heavenly Egg",
        "Darkness Egg",
        "Cyber Egg",
        "Galaxy Egg",
        "Shadow Egg"
    },
    CurrentOption = selectedEgg,
    Callback = function(option)
        selectedEgg = option
    end,
})

EggTab:CreateToggle({
    Name = "Auto Buy Selected Egg",
    CurrentValue = false,
    Callback = function(state)
        autoBuyEgg = state
        if autoBuyEgg then
            task.spawn(function()
                while autoBuyEgg do
                    pcall(function()
                        local args = {
                            "BuyEgg",
                            selectedEgg
                        }
                        game:GetService("ReplicatedStorage")
                            :WaitForChild("Events")
                            :WaitForChild("UIAction")
                            :FireServer(unpack(args))
                    end)
                    task.wait(2) -- wait between egg buys (adjust if needed)
                end
            end)
        end
    end,
})

local Button = Tab:CreateButton({
   Name = "Stop Auto Hacthing Egg(Test)",
   Callback = function()
   local args = {
        "StopAutoHatching"
}
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("UIAction"):FireServer(unpack(args))
   end,
})

local autoSwitchEgg = false

EggTab:CreateToggle({
    Name = "Auto Switch Egg",
    CurrentValue = false,
    Callback = function(state)
        autoSwitchEgg = state
        if autoSwitchEgg then
            -- Turn ON
            local args = {
                "ChangeSetting",
                "AutoSwitchEgg"
            }
            game:GetService("ReplicatedStorage")
                :WaitForChild("Events")
                :WaitForChild("UIAction")
                :FireServer(unpack(args))
        else
            -- Turn OFF
            local args = {
                "ChangeSetting",
                "AutoSwitchEgg"
            }
            game:GetService("ReplicatedStorage")
                :WaitForChild("Events")
                :WaitForChild("UIAction")
                :FireServer(unpack(args))
        end
    end,
})

local Label = EggTab:CreateLabel("Pet Automation", 4483362458, Color3.fromRGB(255, 255, 255), true) -- Title, Icon, Color, IgnoreTheme

EggTab:CreateToggle({
    Name = "Auto Equip Best Pets",
    CurrentValue = false,
    Callback = function(state)
        autoEquipBest = state
        if autoEquipBest then
            task.spawn(function()
                while autoEquipBest do
                    pcall(function()
                        local args = {
                            "EquipBestPets"
                        }
                        game:GetService("ReplicatedStorage")
                            :WaitForChild("Events")
                            :WaitForChild("UIAction")
                            :FireServer(unpack(args))
                    end)
                    task.wait(10)
                end
            end)
        end
    end,
})

local Button = EggTab:CreateButton({
   Name = "Unequip All Pets",
   Callback = function()
   local args = {
        "UnequipAllPets"
}
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("UIAction"):FireServer(unpack(args))

   end,
})

local autoCombinePets = false

EggTab:CreateToggle({
    Name = "Auto Combine/Craft Pets",
    CurrentValue = false,
    Callback = function(state)
        autoCombinePets = state
        if autoCombinePets then
            task.spawn(function()
                while autoCombinePets do
                    pcall(function()
                        local args = {
                            "CombineAllPets"
                        }
                        game:GetService("ReplicatedStorage")
                            :WaitForChild("Events")
                            :WaitForChild("UIAction")
                            :FireServer(unpack(args))
                    end)
                    task.wait(10)
                end
            end)
        end
    end,
})

--MISC UTILITIES 🔧
MiscTab:CreateToggle({
        Name = "Infinite Jump",
        CurrentValue = false,
        Callback = function(v) _G.infinjump = v end
})

game:GetService("UserInputService").JumpRequest:Connect(function()
        if _G.infinjump then
                local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
end)

MiscTab:CreateSlider({
        Name = "WalkSpeed",
        Range = {16, 150},
        Increment = 1,
        CurrentValue = 16,
        Callback = function(v)
                local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
                if hum then hum.WalkSpeed = v end
        end
})

MiscTab:CreateSlider({
        Name = "JumpPower",
        Range = {50, 200},
        Increment = 5,
        CurrentValue = 50,
        Callback = function(v)
                local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
                if hum then hum.JumpPower = v end
        end
})

local noclip = false
MiscTab:CreateToggle({
        Name = "No Clip",
        CurrentValue = false,
        Callback = function(v) noclip = v end
})

RunService.Stepped:Connect(function()
        if noclip and LocalPlayer.Character then
                for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide then
                                part.CanCollide = false
                        end
                end
        end
end)

MiscTab:CreateButton({ Name = "Rejoin Server", Callback = function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end })

local currentJobId = game.JobId or "Unavailable"
MiscTab:CreateParagraph({ Title = "Your JobId", Content = currentJobId })

MiscTab:CreateButton({
        Name = "Copy JobId to Clipboard",
        Callback = function()
                if setclipboard then
                        setclipboard(currentJobId)
                        Rayfield:Notify({Title = "Copied", Content = "JobId copied to clipboard!", Duration = 3})
                end
        end
})

MiscTab:CreateInput({
        Name = "Enter JobId to Join",
        PlaceholderText = "Paste JobId here...",
        Callback = function(jobId)
                if jobId ~= "" then
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, jobId, LocalPlayer)
                end
        end
})

MiscTab:CreateButton({
        Name = "Server Hop",
        Callback = function()
                local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"
                local success, result = pcall(function() return HttpService:JSONDecode(game:HttpGet(url)) end)
                if success and result and result.data then
                        for _, server in ipairs(result.data) do
                                if server.playing < server.maxPlayers and server.id ~= currentJobId then
                                        TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                                        break
                                end
                        end
                end
        end
})