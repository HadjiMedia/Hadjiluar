local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--// Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

--// UI Setup
local Window = Rayfield:CreateWindow({
   Name = "⚔️Saber Simulator - Hadji⚔️",
   Icon = 0,
   LoadingTitle = "⚡Saber Simulator Automation ⚡",
   LoadingSubtitle = "by HadjiZXC",
   Theme = "Default",
   ToggleUIKeybind = "K",

   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil,
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },

   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Hello"}
   }
})

--// Tabs
local FarmTab = Window:CreateTab("Auto Farm", nil)
local ShopTab = Window:CreateTab("Auto Buy", nil)
local BossTab = Window:CreateTab("Auto Boss", nil)
local EggTab = Window:CreateTab("Auto Egg/Pet", nil)
local MiscTab = Window:CreateTab("Misc", nil)

--// FARM AUTOMATION ⚔️
local autoSwing = false
FarmTab:CreateToggle({
    Name = "Auto Swing Saber",
    CurrentValue = false,
    Callback = function(state)
        autoSwing = state
        if autoSwing then
            task.spawn(function()
                while autoSwing do
                    pcall(function()
                        ReplicatedStorage.Events.SwingSaber:FireServer()
                    end)
                    task.wait(0.1)
                end
            end)
        end
    end,
})

local autoSell = false
FarmTab:CreateToggle({
    Name = "Auto Sell",
    CurrentValue = false,
    Callback = function(state)
        autoSell = state
        if autoSell then
            task.spawn(function()
                while autoSell do
                    pcall(function()
                        ReplicatedStorage.Events.SellStrength:FireServer()
                    end)
                    task.wait(0.5)
                end
            end)
        end
    end,
})

local autoClaimReward = false
FarmTab:CreateToggle({
    Name = "Auto Claim Daily Reward",
    CurrentValue = false,
    Callback = function(state)
        autoClaimReward = state
        if autoClaimReward then
            task.spawn(function()
                while autoClaimReward do
                    pcall(function()
                        ReplicatedStorage.Events.UIAction:FireServer("ClaimDailyTimedReward")
                    end)
                    task.wait(300)
                end
            end)
        end
    end,
})

--// SHOP AUTOMATION 🛒
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
                        ReplicatedStorage.Events.UIAction:FireServer("BuyAllWeapons")
                    end)
                    task.wait(30)
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
                        ReplicatedStorage.Events.UIAction:FireServer("BuyAllDNAs")
                    end)
                    task.wait(30)
                end
            end)
        end
    end,
})

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
                        ReplicatedStorage.Events.UIAction:FireServer("BuyAllBossBoosts")
                    end)
                    task.wait(30)
                end
            end)
        end
    end,
})

--// BOSS AUTOMATION 👑
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
                        local bossCFrame = CFrame.new(449.488, 179.962, 120.984)
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = bossCFrame
                        end
                        local boss = workspace.Gameplay.Boss.BossHolder:FindFirstChild("Boss")
                        if boss then
                            LocalPlayer.Character.Cursed.RemoteClick:FireServer({boss})
                        end
                    end)
                    task.wait(0.3)
                end
            end)
        end
    end,
})

--// EGG AUTOMATION 🥚
local AutoHatchEnabled = false
local SelectedEgg = "Basic Egg"

local EggList = {
    "Basic Egg", "Wooden Egg", "Reinforced Egg", "Ancient", "Egg of life",
    "Glory Egg", "Dominus Egg", "Silver Egg", "Golden Egg",
    "Premium Egg", "Class Egg", "Diamond Egg"
}

task.spawn(function()
    while task.wait(1) do
        if AutoHatchEnabled and SelectedEgg then
            ReplicatedStorage.Remotes.HatchEgg:InvokeServer(SelectedEgg, 1)
        end
    end
end)

EggTab:CreateDropdown({
    Name = "🥚 Select Egg to Hatch",
    Options = EggList,
    CurrentOption = SelectedEgg,
    Callback = function(option) SelectedEgg = option end
})

EggTab:CreateToggle({
    Name = "⚙️ Auto Hatch Egg",
    CurrentValue = false,
    Callback = function(value) AutoHatchEnabled = value end
})

EggTab:CreateToggle({
    Name = "Auto Equip Best Pets",
    CurrentValue = false,
    Callback = function(state)
        local autoEquipBest = state
        if autoEquipBest then
            task.spawn(function()
                while autoEquipBest do
                    pcall(function()
                        ReplicatedStorage.Events.UIAction:FireServer("EquipBestPets")
                    end)
                    task.wait(10)
                end
            end)
        end
    end,
})

EggTab:CreateButton({
   Name = "Unequip All Pets",
   Callback = function()
        ReplicatedStorage.Events.UIAction:FireServer("UnequipAllPets")
   end,
})

EggTab:CreateToggle({
    Name = "Auto Combine/Craft Pets",
    CurrentValue = false,
    Callback = function(state)
        local autoCombinePets = state
        if autoCombinePets then
            task.spawn(function()
                while autoCombinePets do
                    pcall(function()
                        ReplicatedStorage.Events.UIAction:FireServer("CombineAllPets")
                    end)
                    task.wait(10)
                end
            end)
        end
    end,
})

--// MISC UTILITIES 🔧
local noclip = false
local infinjump = false

MiscTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(v) infinjump = v end
})

UserInputService.JumpRequest:Connect(function()
    if infinjump then
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
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = v end
    end
})

MiscTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 200},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(v)
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = v end
    end
})

MiscTab:CreateToggle({
    Name = "No Clip",
    CurrentValue = false,
    Callback = function(v) noclip = v end
})

RunService.Stepped:Connect(function()
    if noclip and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

MiscTab:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
})

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