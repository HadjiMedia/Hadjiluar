local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "🌿Grow a Garden Script - HadjiZXC☘️",
    LoadingTitle = "🍃Grow a Garden Script🌱",
    LoadingSubtitle = "by Hadji",
    Theme = "Default",
    ToggleUIKeybind = Enum.KeyCode.K,

    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil, -- Optional: set to a string to store config in subfolder
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

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Tabs
local FarmTab = Window:CreateTab("Auto Farm")
local ShopTab = Window:CreateTab("Shop")
local PlayerTab = Window:CreateTab("Local Player")
local MiscTab = Window:CreateTab("Misc")

-- Player Tab
PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(value)
        _G.infinjump = value
        local UIS = game:GetService("UserInputService")

        if not _G._infJumpConnection then
            _G._infJumpConnection = UIS.JumpRequest:Connect(function()
                if _G.infinjump then
                    local char = LocalPlayer.Character
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
                end
            end)
        end
    end,
})

PlayerTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 150},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "WalkSpeedSlider",
    Callback = function(Value)
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = Value end
    end,
})

PlayerTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 200},
    Increment = 5,
    Suffix = "Power",
    CurrentValue = 50,
    Flag = "JumpPowerSlider",
    Callback = function(Value)
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = Value end
    end,
})

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
    if noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Farm Tab

FarmTab:CreateLabel("Automatic Service")
AutoTab:CreateToggle({
    Name = "Auto Plant Held Seed",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().AutoPlant = Value

        task.spawn(function()
            while getgenv().AutoPlant do
                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                local rootPart = character:FindFirstChild("HumanoidRootPart")

                if rootPart then
                    -- Assuming you have a way to get the held seed, like from the player's inventory or UI
                    local heldSeed = player:FindFirstChild("HeldSeed")  -- Adjust this to how you track the held seed

                    if heldSeed then
                        local args = {
                            rootPart.Position,  -- Plant where the player stands
                            heldSeed.Value      -- Use the current held seed (adjust according to your setup)
                        }

                        game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Plant_RE"):FireServer(unpack(args))
                    end
                end

                task.wait(2) -- Adjust delay between plant attempts
            end
        end)
    end
})



FarmTab:CreateLabel("Cooking Event")

local autoSubmit = false
FarmTab:CreateToggle({
    Name = "Auto Submit Held Plant",
    CurrentValue = false,
    Flag = "AutoSubmitToggle",
    Callback = function(Value) autoSubmit = Value end,
})

local autoCook = false
FarmTab:CreateToggle({
    Name = "Auto Cook Pot",
    CurrentValue = false,
    Flag = "AutoCookToggle",
    Callback = function(Value) autoCook = Value end,
})

local autoSubmitP = false
FarmTab:CreateToggle({
    Name = "Auto Submit Held Food to Chris P.",
    CurrentValue = false,
    Flag = "AutoSubmitPToggle",
    Callback = function(Value) autoSubmitP = Value end,
})

FarmTab:CreateButton({
    Name = "Empty Cooking Pot",
    Callback = function()
        ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("CookingPotService_RE"):FireServer("EmptyPot")
    end,
})

task.spawn(function()
    while true do
        if autoSubmit then
            pcall(function()
                ReplicatedStorage.GameEvents.CookingPotService_RE:FireServer("SubmitHeldPlant")
            end)
        end
        if autoCook then
            pcall(function()
                ReplicatedStorage.GameEvents.CookingPotService_RE:FireServer("CookBest")
            end)
        end
        if autoSubmitP then
            pcall(function()
                ReplicatedStorage.GameEvents.SubmitFoodService_RE:FireServer("SubmitHeldFood")
            end)
        end
        task.wait(0.5)
    end
end)



-- Shop Tab
local seedShopList = {
    "Carrot", "Strawberry", "Blueberry", "Orange Tulip", "Tomato", "Daffodil", "Cauliflower", "Raspberry",
    "Watermelon", "Pumpkin", "Apple", "Bamboo", "Avocado", "Banana", "Pineapple", "Coconut", "Cactus", "Dragon Fruit",
    "Mango", "Grape", "Mushroom", "Pepper", "Cacao", "Beanstalk", "Ember Lily", "Sugar Apple", "Burning Bud",
    "Giant Pinecone", "Elder Strawberry"
}

local selectedSeeds = {}

ShopTab:CreateLabel("Multi-select seeds to buy")

ShopTab:CreateDropdown({
    Name = "Seed List",
    Options = seedShopList,
    MultipleOptions = true,
    Default = {},
    Callback = function(values)
        selectedSeeds = values
    end,
})

local autoBuyS = false
ShopTab:CreateToggle({
    Name = "Auto Buy Selected Seeds",
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
                    ReplicatedStorage.GameEvents.BuySeedStock:FireServer(seedName)
                end)
                task.wait(0.25)
            end
        end
        task.wait(1)
    end
end)

-- Misc Tab
MiscTab:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end,
})

local currentJobId = game.JobId or "Unavailable"

MiscTab:CreateParagraph({
    Title = "Your JobId",
    Content = currentJobId
})

MiscTab:CreateButton({
    Name = "Copy JobId to Clipboard",
    Callback = function()
        if setclipboard then
            setclipboard(currentJobId)
            print("JobId copied to clipboard!")
        else
            warn("Clipboard not supported.")
        end
    end,
})

MiscTab:CreateInput({
    Name = "Enter JobId to Join",
    PlaceholderText = "Paste JobId here...",
    RemoveTextAfterFocusLost = false,
    Callback = function(inputJobId)
        if inputJobId and inputJobId ~= "" then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, inputJobId, LocalPlayer)
        else
            warn("Invalid JobId entered.")
        end
    end,
})

MiscTab:CreateButton({
    Name = "Server Hop",
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
    end,
})