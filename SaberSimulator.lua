--✅ Rayfield UI Setup local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({ Name = "Saber Simulator Automation - HadjiZXC", LoadingTitle = "Saber Simulator Script", Theme = "Default", ConfigurationSaving = { Enabled = true, FolderName = "SaberSimAuto", FileName = "AutoSettings" }, Discord = { Enabled = false }, KeySystem = false })

--📁 Tabs local FarmTab = Window:CreateTab("Auto Farm") local ShopTab = Window:CreateTab("Shop") local BossTab = Window:CreateTab("Boss") local EggTab = Window:CreateTab("Egg")

--⚔️ Auto Farm (Claim Daily Timed Reward) local claimDaily = false FarmTab:CreateToggle({ Name = "Auto Claim Daily Reward (5min Cooldown)", CurrentValue = false, Callback = function(state) claimDaily = state while claimDaily do local args = {"ClaimDailyTimedReward"} game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("UIAction"):FireServer(unpack(args)) task.wait(300) -- 5 minutes cooldown end end })

--🛍️ Auto Shop ShopTab:CreateToggle({ Name = "Auto Buy All Sabers", CurrentValue = false, Callback = function(value) while value do local args = {"BuyAllWeapons"} game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("UIAction"):FireServer(unpack(args)) task.wait(60) end end })

ShopTab:CreateToggle({ Name = "Auto Buy All DNA", CurrentValue = false, Callback = function(value) while value do local args = {"BuyAllDNAs"} game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("UIAction"):FireServer(unpack(args)) task.wait(30) end end })

--🥚 Pet Automation Label EggTab:CreateLabel("Pet Automation", 4483362458, Color3.fromRGB(255, 255, 255), false)

--🥚 Auto Equip Best Pet local autoEquipBest = false EggTab:CreateToggle({ Name = "Auto Equip Best Pet", CurrentValue = false, Callback = function(state) autoEquipBest = state while autoEquipBest do local args = {"EquipBestPets"} game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("UIAction"):FireServer(unpack(args)) task.wait(60) end end })

--🥚 Auto Combine Pets local autoCombinePets = false EggTab:CreateToggle({ Name = "Auto Combine Pets", CurrentValue = false, Callback = function(state) autoCombinePets = state while autoCombinePets do local args = {"CombineAllPets"} game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("UIAction"):FireServer(unpack(args)) task.wait(60) end end })

--🥚 Auto Switch Egg Toggle local autoSwitchEgg = false EggTab:CreateToggle({ Name = "Auto Switch Egg", CurrentValue = false, Callback = function(state) autoSwitchEgg = state local args = {"ChangeSetting", "AutoSwitchEgg"} game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("UIAction"):FireServer(unpack(args)) end })

--🥚 Dropdown Egg Selection & Auto Buy local selectedEgg = "Wooden Egg" EggTab:CreateDropdown({ Name = "Select Egg", Options = {"Wooden Egg", "Ice Egg", "Fire Egg", "Golden Egg", "Crystal Egg", "Rainbow Egg", "Darkness Egg"}, CurrentOption = "Wooden Egg", Callback = function(option) selectedEgg = option end })

local autoBuyEgg = false EggTab:CreateToggle({ Name = "Auto Buy Selected Egg", CurrentValue = false, Callback = function(state) autoBuyEgg = state while autoBuyEgg do local args = {"BuyEgg", selectedEgg} game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("UIAction"):FireServer(unpack(args)) task.wait(5) end end })

