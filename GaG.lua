-- 🌿 Grow a Garden Script by HadjiZXC ☘️
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
	Name = "Grow a Garden Script - HadjiZXC",
	LoadingTitle = "Grow a Garden Script",
	LoadingSubtitle = "by Hadji",
	Theme = "Default",
	ToggleUIKeybind = Enum.KeyCode.K,
	ConfigurationSaving = {
		Enabled = true,
		FolderName = nil,
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

-- ✅ SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ✅ TABS
local FarmTab = Window:CreateTab("Auto Farm")
local ShopTab = Window:CreateTab("Shop")
local PlayerTab = Window:CreateTab("Local Player")
local TpTab = Window:CreateTab("Teleport Location")
local MiscTab = Window:CreateTab("Misc")

--// All Grow a Garden crops (alphabetical)
local FruitList = {
    "Aloe Vera", "Amber Spine", "Apple", "Artichoke", "Avocado",
    "Badlands Pepper", "Bamboo", "Banana", "Beanstalk", "Bee Balm",
    "Bell Pepper", "Bendboo", "Bitter Melon", "Blood Banana", "Blue Lollipop",
    "Blueberry", "Bone Blossom", "Boneboo", "Broccoli", "Burning Bud",
    "Butternut Squash", "Cacao", "Cactus", "Canary Melon", "Candy Blossom",
    "Candy Sunflower", "Cantaloupe", "Carrot", "Cauliflower", "Celestiberry",
    "Cherry Blossom", "Chocolate Carrot", "Coconut", "Cocovine", "Corn",
    "Cranberry", "Crimson Vine", "Crocus", "Crown Melon", "Cursed Fruit",
    "Daffodil", "Dandelion", "Delphinium", "Dezen", "Dragon Fruit",
    "Dragon Pepper", "Dragon Sapling", "Durian", "Easter Egg", "Eggplant",
    "Elder Strawberry", "Elephant Ears", "Ember Lily", "Enkaku",
    "Feijoa", "Firefly Fern", "Firework Flower", "Fossilight", "Foxglove",
    "Fruitball", "Giant Pinecone", "Glowshroom", "Grand Tomato", "Mushroom",
    "Grape", "Rabbit Flower", "Hibiscus", "Hinomai", "Honeydew",
    "Stardust", "Irish Clover", "Ivy Gourd", "Lemon", "Lime", "Lucky Bamboo",
    "Magic Tulip", "Maple Apple", "Mango", "Monoblooma", "Moonlight Fruit",
    "Onion", "Orange", "Orchid", "Peach", "Pear", "Pepper", "Pineapple",
    "Plum", "Poisonberry", "Pomegranate", "Pumpkin", "Radish", "Rhubarb",
    "Rose", "Sakura Bush", "Shadow Apple", "Sinisterdrip", "Snowflake Bloom",
    "Sorbitree", "Spirit Petal", "Starfruit", "Strawberry", "Sugarglaze",
    "Sunflower", "Sundew", "Sweet Apple", "Taco Fern", "Taro Flower",
    "Tranquil Bloom", "Twisted Tangle", "Veinpetal", "Violet Corn",
    "Watermelon", "Wildflower", "Yam", "Zucchini"
}

local GearList = {
"Watering Can", "Trading Ticket", "Trowel", "Recall Wrench", "Basic Sprinkler", 
"Advance Sprinkler", "Medium Toy", "Medium Treat", "Godly Sprinkler", "Magnifying Glass", 
"Master Sprinkler", "Cleaning Sprinkler", "Cleaning Pet Shard", "Favorite Tool", "Harvest Tool",
"Friendship Pot", "Grandmaster Sprinkler", "Levelup Lollipop"
}

local EggList = {
"Common Egg", "Uncommon Egg", "Rare Egg", "Legendary Egg", "Mythical Egg", "Bug Egg"
}

local SeedShopList = {
    "Carrot", "Strawberry", "Blueberry", "Orange Tulip", "Tomato", "Corn", "Daffodil", "Watermelon",
	"Pumpkin", "Apple", "Bamboo", "Coconut", "Cactus", "Dragon Fruit", "Mango", "Grape", "Mushroom", 
	"Pepper", "Cacao", "Beanstalk", "Ember Lily", "Sugar Apple", "Burning Bud", "Giant Pinecone",
	"Elder Strawberry", "Romanesco"
}

local FallSeed = {
"Turnip", "Parsley", "Meyer Lemon", "Carnival Pumpkin", "Kniphofia", "Golden Peach", "Maple Resin"
}

local FallGear = {
"Firefly Jar", "Sky Lantern", "Maple Leaf Kite", "Leaf Blower", "Maple Syrup", "Maple Sprinkler", "Bonfire", "Harvest Basket", "Maple Leaf Charm", "Golden Acorn"
}

local FallPet = {
"Fall Egg", "Chipmunk", "Red Squirrel", "Marmot", "Sugar Glider", "Space Squirrel"
}

local FallCosmetics = {
"Fall Create", "Fall Leaf Chair", "Maple Flag", "Flying Kite", "Fall Cosmetics"
}

-- 🌟 PLAYER UTILITIES
PlayerTab:CreateToggle({
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

PlayerTab:CreateSlider({
	Name = "WalkSpeed",
	Range = {16, 150},
	Increment = 1,
	CurrentValue = 16,
	Callback = function(v)
		local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
		if hum then hum.WalkSpeed = v end
	end
})

PlayerTab:CreateSlider({
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
PlayerTab:CreateToggle({
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

-- FarmTab with AutoSubmit and Auto Buy logic
FarmTab:CreateLabel("Auto Submit All Plants To Fall Tree")
local autoSubmitPlants = false
FarmTab:CreateToggle({ Name = "Auto Submit All Plants", CurrentValue = false, Callback = function(v) autoSubmitPlants = v end })

task.spawn(function()
    while true do
        if autoSubmitPlants then
            pcall(function() game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("FallMarketEvent"):WaitForChild("SubmitAllPlants"):FireServer() end)
        end
        task.wait(1)
    end
end)

FarmTab:CreateLabel("Auto Submit Held Plants To Fall Tree")
local autoSubmitHeldPlants = false
FarmTab:CreateToggle({ Name = "Auto Submit Held Plants", CurrentValue = false, Callback = function(v) autoSubmitHeldPlants = v end })

task.spawn(function()
    while true do
        if autoSubmitHeldPlants then
            pcall(function() game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("FallMarketEvent"):WaitForChild("SubmitHeldPlant"):FireServer() end)
        end
        task.wait(1)
    end
end)

-- Multi-select Fall items to buy
local selectedFallSeeds, selectedFallGears, selectedFallEggs, selectedFallCosmetics = {}, {}, {}, {}
local autoBuyFS, autoBuyFG, autoBuyFE, autoBuyFC = false, false, false, false

ShopTab:CreateLabel("Fall Event Market Auto Buy")
local Dropdown = ShopTab:CreateDropdown({
    Name = "Fall Seeds",
    Options = FallSeed,
    CurrentValue = {},
    Callback = function(choices)
        selectedFallSeeds = choices
    end
})

ShopTab:CreateToggle({
    Name = "Auto Buy Fall Seeds",
    CurrentValue = false,
    Callback = function(v)
        autoBuyFS = v
    end
})

local Dropdown = ShopTab:CreateDropdown({
    Name = "Fall Gears",
    Options = FallGear,
    CurrentValue = {},
    Callback = function(choices)
        selectedFallGears = choices
    end
})

ShopTab:CreateToggle({
    Name = "Auto Buy Fall Gears",
    CurrentValue = false,
    Callback = function(v)
        autoBuyFG = v
    end
})

local Dropdown = ShopTab:CreateDropdown({
    Name = "Fall Eggs",
    Options = FallPet,
    CurrentValue = {},
    Callback = function(choices)
        selectedFallEggs = choices
    end
})

ShopTab:CreateToggle({
    Name = "Auto Buy Fall Eggs",
    CurrentValue = false,
    Callback = function(v)
        autoBuyFE = v
    end
})

local Dropdown = ShopTab:CreateDropdown({
    Name = "Fall Cosmetics",
    Options = FallCosmetics,
    CurrentValue = {},
    Callback = function(choices)
        selectedFallCosmetics = choices
    end
})

ShopTab:CreateToggle({
    Name = "Auto Buy Fall Cosmetics",
    CurrentValue = false,
    Callback = function(v)
        autoBuyFC = v
    end
})

task.spawn(function()
    while true do
        if autoBuyFS then
            for _, item in ipairs(selectedFallSeeds) do
                pcall(function() ReplicatedStorage.GameEvents.BuyEventShopStock:FireServer(item, 1) end)
                task.wait(0.3)
            end
        end
        if autoBuyFG then
            for _, item in ipairs(selectedFallGears) do
                pcall(function() ReplicatedStorage.GameEvents.BuyEventShopStock:FireServer(item, 1) end)
                task.wait(0.3)
            end
        end
        if autoBuyFE then
            for _, item in ipairs(selectedFallEggs) do
                pcall(function() ReplicatedStorage.GameEvents.BuyEventShopStock:FireServer(item, 1) end)
                task.wait(0.3)
            end
        end
        if autoBuyFC then
            for _, item in ipairs(selectedFallCosmetics) do
                pcall(function() ReplicatedStorage.GameEvents.BuyEventShopStock:FireServer(item, 1) end)
                task.wait(0.3)
            end
        end
        task.wait(0.5)
    end
end)

-- Further enhancements or additions as required

-- UI elements & script finish
Rayfield:Init()

