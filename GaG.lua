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



-- 🛒 SHOP AUTOMATION
local seedShopList = SeedShopList -- Assuming FruitList is already defined
local gearShopList = GearList -- Assuming GearList is already defined
local eggShopList = EggList -- Assuming EggList is already defined


local selectedSeeds, selectedGears, selectedEggs = {}, {}, {}
local autoBuyS, autoBuyG, autoBuyE = false, false, false

ShopTab:CreateLabel("Multi-select seeds to buy")
ShopTab:CreateDropdown({ Name = "Seed List", Options = seedShopList, MultipleOptions = true, Default = {}, Callback = function(v) selectedSeeds = v end })
ShopTab:CreateToggle({ Name = "Auto Buy Selected Seeds", CurrentValue = false, Callback = function(v) autoBuyS = v end })

ShopTab:CreateLabel("Multi-select gears to buy")
ShopTab:CreateDropdown({ Name = "Gear List", Options = gearShopList, MultipleOptions = true, Default = {}, Callback = function(v) selectedGears = v end })
ShopTab:CreateToggle({ Name = "Auto Buy Selected Gears", CurrentValue = false, Callback = function(v) autoBuyG = v end })

ShopTab:CreateLabel("Multi-select eggs to buy")
ShopTab:CreateDropdown({ Name = "Egg Shop List", Options = eggShopList, MultipleOptions = true, Default = {}, Callback = function(v) selectedEggs = v end })
ShopTab:CreateToggle({ Name = "Auto Buy Selected Eggs", CurrentValue = false, Callback = function(v) autoBuyE = v end })

task.spawn(function()
	while task.wait(1) do
		if autoBuyS then for _, item in ipairs(selectedSeeds) do pcall(function() ReplicatedStorage.GameEvents.BuySeedStock:FireServer(item) end) task.wait(0.3) end end
		if autoBuyG then for _, item in ipairs(selectedGears) do pcall(function() ReplicatedStorage.GameEvents.BuyGearStock:FireServer(item) end) task.wait(0.3) end end
		if autoBuyE then for _, item in ipairs(selectedEggs) do pcall(function() ReplicatedStorage.GameEvents.BuyPetEgg:FireServer(item) end) task.wait(0.3) end end
	end
end)

-- 📍 TELEPORT UTILITIES
TpTab:CreateLabel("Tap a button to teleport")
local function teleportTo(cframe)
	local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")
	hrp.CFrame = cframe
end

TpTab:CreateButton({ Name = "Seed Shop", Callback = function() teleportTo(CFrame.new(86.581, 3, -27.003)) end })
TpTab:CreateButton({ Name = "Sell Stuff", Callback = function() teleportTo(CFrame.new(86.585, 3, 0.427)) end })
TpTab:CreateButton({ Name = "Gear Shop", Callback = function() teleportTo(CFrame.new(-284.945, 3, -13.171)) end })
TpTab:CreateButton({ Name = "Pet/Egg Shop", Callback = function() teleportTo(CFrame.new(-283.833, 3, -1.397)) end })
TpTab:CreateButton({ Name = "Cosmetics Shop", Callback = function() teleportTo(CFrame.new(-283.216, 3, -25.605)) end })
TpTab:CreateButton({ Name = "Event", Callback = function() teleportTo(CFrame.new(-103.816, 4.4, -6.888)) end })

-- 🔧 MISC UTILITIES
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

-- 💾 CONFIG SYSTEM
Rayfield:LoadConfiguration()

MiscTab:CreateButton({ Name = "Save Config", Callback = function() Rayfield:SaveConfiguration() end })
MiscTab:CreateButton({ Name = "Load Config", Callback = function() Rayfield:LoadConfiguration() end })
MiscTab:CreateInput({
	Name = "Create Config",
	PlaceholderText = "Enter config name",
	Callback = function(name)
		Rayfield:SetConfigurationName(name)
		Rayfield:SaveConfiguration()
	end
})

MiscTab:CreateInput({
	Name = "Delete Config (Manual)",
	PlaceholderText = "Delete via folder",
	Callback = function()
		Rayfield:Notify({ Title = "Notice", Content = "Please delete config files manually in workspace folder.", Duration = 5 })
	end
})
