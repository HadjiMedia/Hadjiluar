local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "👨🏿‍🌾 Grow a Garden Script 👩🏻‍🌾",
    LoadingTitle = "🌱 Grow a Garden Script 🌿",
    LoadingSubtitle = "by Hadji",
    Theme = "Default",
    ToggleUIKeybind = Enum.KeyCode.K,

    ConfigurationSaving = {
        Enabled = true,
        FileName = "GAG"
    },

    KeySystem = true,
    KeySettings = {
        Title = "Grow a Garden | Key",
        Subtitle = "Key System",
        Note = "Join the Discord Server to get the key",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = true,
        Key = {"https://pastebin.com/raw/GpkZHNdm"}
    }
})

-- Tabs
local FarmTab = Window:CreateTab("Auto Farm", nil)
local ShopTab = Window:CreateTab("Shop", nil)
local PlayerTab = Window:CreateTab("Local Player", nil)
local MiscTab = Window:CreateTab("Misc", nil)

-- 🌟 PLAYER TAB
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

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- WalkSpeed Slider
PlayerTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 150},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "SpeedSlider",
    Callback = function(value)
        pcall(function()
            Humanoid.WalkSpeed = value
        end)
    end,
})

-- JumpPower Slider
PlayerTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 200},
    Increment = 5,
    Suffix = "Power",
    CurrentValue = 50,
    Flag = "JumpSlider",
    Callback = function(value)
        pcall(function()
            Humanoid.JumpPower = value
        end)
    end,
})

-- No Clip Toggle
local noclip = false

PlayerTab:CreateToggle({
    Name = "No Clip",
    CurrentValue = false,
    Flag = "NoClipToggle",
    Callback = function(value)
        noclip = value
    end,
})

RunService.Stepped:Connect(function()
    if noclip then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

-- 🌟 FARM TAB
FarmTab:CreateLabel("Cooking Event")

-- Auto Submit
local autoSubmit = false
FarmTab:CreateToggle({
    Name = "Auto Submit Held Plant",
    CurrentValue = false,
    Flag = "AutoSubmitToggle",
    Callback = function(Value)
        autoSubmit = Value
    end,
})

-- Auto Cook
local autoCook = false
FarmTab:CreateToggle({
    Name = "Auto Cook Pot",
    CurrentValue = false,
    Flag = "AutoCookToggle",
    Callback = function(Value)
        autoCook = Value
    end,
})

-- Auto Submit to Pig
local autoSubmitP = false
FarmTab:CreateToggle({
    Name = "Auto Submit Held Food to Chris P.",
    CurrentValue = false,
    Flag = "AutoSubmitPToggle",
    Callback = function(Value)
        autoSubmitP = Value
    end,
})

-- Empty Pot Button
FarmTab:CreateButton({
    Name = "Empty Cooking Pot",
    Callback = function()
        game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CookingPotService_RE"):FireServer("EmptyPot")
    end,
})

-- Background Farming Loops
task.spawn(function()
    while true do
        if autoSubmit then
            pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("GameEvents")
                    :WaitForChild("CookingPotService_RE"):FireServer("SubmitHeldPlant")
            end)
        end
        if autoCook then
            pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("GameEvents")
                    :WaitForChild("CookingPotService_RE"):FireServer("CookBest")
            end)
        end
        if autoSubmitP then
            pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("GameEvents")
                    :WaitForChild("SubmitFoodService_RE"):FireServer("SubmitHeldFood")
            end)
        end
        task.wait(0.5)
    end
end)

-- 🌟 SHOP TAB
local seedShopList = {
    "Carrot", "Strawberry", "Blueberry", "Orange Tulip", "Tomato", "Daffodil", "Cauliflower", "Raspberry",
    "Watermelon", "Pumpkin", "Apple", "Bamboo", "Avocado", "Banana", "Pineapple", "Coconut", "Cactus", "Dragon Fruit",
    "Mango", "Grape", "Mushroom", "Pepper", "Cacao", "Beanstalk", "Ember Lily", "Sugar Apple", "Burning Bud",
    "Giant Pinecone", "Elder Strawberry"
}

local selectedSeeds = {}

ShopTab:CreateLabel("🌱 Multi-select seeds to buy")

ShopTab:CreateDropdown({
    Name = "Seed List",
    Options = seedShopList,
    MultipleOptions = true, -- ✅ CORRECT
    Default = {},
    Callback = function(values)
        selectedSeeds = values
    end,
})

-- Auto Buy Toggle
local autoBuyS = false
ShopTab:CreateToggle({
    Name = "✅ Auto Buy Selected Seeds",
    CurrentValue = false,
    Flag = "AutoBuyToggle",
    Callback = function(Value)
        autoBuyS = Value
    end,
})

task.spawn(function()
    while true do
        if autoBuyS and #selectedSeeds > 0 then
            for _, seedName in ipairs(selectedSeeds) do
                pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("GameEvents")
                        :WaitForChild("BuySeedStock"):FireServer(seedName)
                end)
                task.wait(0.25)
            end
        end
        task.wait(1)
    end
end)


--MISC TAB🌟
MiscTab:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local Players = game:GetService("Players")
        local placeId = game.PlaceId
        local player = Players.LocalPlayer

        TeleportService:Teleport(placeId, player)
    end,
})

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- Current JobId (read-only)
local currentJobId = game.JobId or "Unavailable"

-- UI Elements
MiscTab:CreateParagraph({
    Title = "Your JobId",
    Content = currentJobId
})

MiscTab:CreateButton({
    Name = " Copy JobId to Clipboard",
    Callback = function()
        if setclipboard then
            setclipboard(currentJobId)
            print("JobId copied to clipboard!")
        else
            warn("Clipboard not supported in your environment.")
        end
    end
})

MiscTab:CreateInput({
    Name = " Enter JobId to Join",
    PlaceholderText = "Paste JobId here...",
    RemoveTextAfterFocusLost = false,
    Callback = function(inputJobId)
        if inputJobId and inputJobId ~= "" then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, inputJobId, LocalPlayer)
        else
            warn("Invalid JobId entered.")
        end
    end
})

MiscTab:CreateButton({
    Name = " Server Hop",
    Callback = function()
        local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"
        local success, result = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(url))
        end)

        if success and result and result.data then
            for _, server in ipairs(result.data) do
                if server.playing < server.maxPlayers and server.id ~= currentJobId then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                    break
                end
            end
        else
            warn("Server hop failed.")
        end
    end
})