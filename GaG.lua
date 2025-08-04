local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
	Name = "🌿Grow a Garden Script - HadjiZXC☘️",
	LoadingTitle = "🍃Grow a Garden Script🌱",
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

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Tabs
local FarmTab = Window:CreateTab("Auto Farm")
local ShopTab = Window:CreateTab("Shop")
local PlayerTab = Window:CreateTab("Local Player")
local TpTab = Window:CreateTab("Teleport Location")
local MiscTab = Window:CreateTab("Misc")

-- 🌟 PLAYER UTILITIES
PlayerTab:CreateToggle({
	Name = "Infinite Jump",
	CurrentValue = false,
	Callback = function(value)
		_G.infinjump = value
	end,
})

local infJumpConnection
infJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
	if _G.infinjump then
		local char = LocalPlayer.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
	end
end)

PlayerTab:CreateSlider({
	Name = "WalkSpeed",
	Range = {16, 150},
	Increment = 1,
	CurrentValue = 16,
	Callback = function(Value)
		local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
		if hum then hum.WalkSpeed = Value end
	end,
})

PlayerTab:CreateSlider({
	Name = "JumpPower",
	Range = {50, 200},
	Increment = 5,
	CurrentValue = 50,
	Callback = function(Value)
		local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
		if hum then hum.JumpPower = Value end
	end,
})

local noclip = false
PlayerTab:CreateToggle({
	Name = "No Clip",
	CurrentValue = false,
	Callback = function(Value)
		noclip = Value
	end,
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

--FARM AUTOMATION

FarmTab:CreateLabel("Cooking Event")

local autoSubmit, autoCook, autoSubmitP = false, false, false

FarmTab:CreateToggle({ Name = "Auto Submit Held Plant", CurrentValue = false, Callback = function(v) autoSubmit = v end })
FarmTab:CreateToggle({ Name = "Auto Cook Pot", CurrentValue = false, Callback = function(v) autoCook = v end })
FarmTab:CreateToggle({ Name = "Auto Submit Held Food to Chris P.", CurrentValue = false, Callback = function(v) autoSubmitP = v end })

FarmTab:CreateButton({
	Name = "Empty Cooking Pot",
	Callback = function()
		ReplicatedStorage.GameEvents.CookingPotService_RE:FireServer("EmptyPot")
	end
})

task.spawn(function()
	while task.wait(0.5) do
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
	end
end)

-- 🛒 SHOP AUTOMATION
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
	Callback = function(Value)
		autoBuyS = Value
	end,
})

task.spawn(function()
	while task.wait(1) do
		if autoBuyS and #selectedSeeds > 0 then
			for _, seed in ipairs(selectedSeeds) do
				pcall(function()
					ReplicatedStorage.GameEvents.BuySeedStock:FireServer(seed)
				end)
				task.wait(0.3)
			end
		end
	end
end)

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local gearShopList = {
	"Watering Can", "Trading Ticket", "Trowel", "Recall Wrench", "Basic Sprinkler", "Advance Sprinkler", "Medium Toy", "Medium Treat",
	"Godly Sprinkler", "Magnifying Glass", "Master Sprinkler", "Cleaning Spray", "Favorite Tool", "Harvest Tool", "Friendship Pot", "Grandmaster Sprinkler", "Levelup Lollipop"
}

local selectedGears = {}

ShopTab:CreateLabel("Multi-select gears to buy")

ShopTab:CreateDropdown({
	Name = "Gear List",
	Options = gearShopList,
	MultipleOptions = true,
	Default = {},
	Callback = function(values)
		selectedGears = values
	end,
})

local autoBuyG = false

ShopTab:CreateToggle({
	Name = "Auto Buy Selected Gears",
	CurrentValue = false,
	Callback = function(Value)
		autoBuyG = Value
	end,
})

task.spawn(function()
	while task.wait(1) do
		if autoBuyG and #selectedGears > 0 then
			for _, gear in ipairs(selectedGears) do
				pcall(function()
					ReplicatedStorage.GameEvents.BuyGearStock:FireServer(gear)
				end)
				task.wait(0.3)
			end
		end
	end
end)

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local eggShopList = {
	"Common Egg", "Common Summer Egg", "Rare Summer Egg", "Mythical Egg", "Paradise Egg", "Bug Egg"
}

local selectedEggs = {} -- corrected variable name

ShopTab:CreateLabel("Multi-select eggs to buy")

ShopTab:CreateDropdown({
	Name = "Egg Shop List",
	Options = eggShopList,
	MultipleOptions = true,
	Default = {},
	Callback = function(values)
		selectedEggs = values
	end,
})

local autoBuyE = false -- renamed properly

ShopTab:CreateToggle({
	Name = "Auto Buy Selected Eggs",
	CurrentValue = false,
	Callback = function(Value)
		autoBuyE = Value
	end,
})

task.spawn(function()
	while task.wait(1) do
		if autoBuyE and #selectedEggs > 0 then
			for _, egg in ipairs(selectedEggs) do
				pcall(function()
					ReplicatedStorage.GameEvents.BuyPetEgg:FireServer(egg)
				end)
				task.wait(0.3)
			end
		end
	end
end)

--📍TELEPORT UTILITIES 
TpTab:CreateLabel("Tap a button to teleport")

TpTab:CreateButton({
    Name = "Seed Shop",
    Callback = function()
        local position = Vector3.new(86.58995056152344, 2.999999761581421, -27.003969192504883)
        ReplicatedStorage.GameEvents.TeleportPlayer:FireServer(position)
    end,
})

TpTab:CreateButton({
    Name = "Sell Stuff",
    Callback = function()
        local position = Vector3.new(86.57794952392578, 2.999999761581421, 0.4267956614494324)
        ReplicatedStorage.GameEvents.TeleportPlayer:FireServer(position)
    end,
})

TpTab:CreateButton({
    Name = "Gear Shop",
    Callback = function()
        local position = Vector3.new(-285.40802001953125, 2.999999761581421, -13.9779052734375)
        ReplicatedStorage.GameEvents.TeleportPlayer:FireServer(position)
    end,
})

TpTab:CreateButton({
    Name = "Pet/Egg Shop",
    Callback = function()
        local position = Vector3.new(-285.3355712890625, 2.999999761581421, -1.7066423892974854)
        ReplicatedStorage.GameEvents.TeleportPlayer:FireServer(position)
    end,
})

TpTab:CreateButton({
    Name = "Cosmetics Shop",
    Callback = function()
        local position = Vector3.new(-284.695068359375, 2.999999761581421, -25.885393142700195)
        ReplicatedStorage.GameEvents.TeleportPlayer:FireServer(position)
    end,
})

TpTab:CreateButton({
    Name = "Event",
    Callback = function()
        local position = Vector3.new(-103.05644989013672, 4.3999834060668945, -7.719189643859863)
        ReplicatedStorage.GameEvents.TeleportPlayer:FireServer(position)
    end,
})

-- 🔧 MISC UTILITIES
MiscTab:CreateButton({
	Name = "Rejoin Server",
	Callback = function()
		TeleportService:Teleport(game.PlaceId, LocalPlayer)
	end
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
			Rayfield:Notify({Title = "Copied", Content = "JobId copied to clipboard!", Duration = 3})
		end
	end
})

MiscTab:CreateInput({
	Name = "Enter JobId to Join",
	PlaceholderText = "Paste JobId here...",
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