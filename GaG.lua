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
local AutoTab = Window:CreateTab("Automatic")
local FarmTab = Window:CreateTab("Event")
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
"Firefly Jar", "Sky Lantern", "Maple Leaf Kite", "Leaf Blower", "Maple Syrup", "Maple Sprinkler", 
"Bonfire", "Harvest Basket", "Maple Leaf Charm", "Golden Acorn"
}

local FallPet = {
"Fall Egg", "Chipmunk", "Red Squirrel", "Marmot", "Sugar Glider", "Space Squirrel"
}

local FallCosmetics = {
"Fall Create", "Fall Leaf Chair", "Maple Flag", "Flying Kite", "Fall Cosmetics"
}

--Automatic Tab
AutoTab:CreateLabel("Auto Sell")
local RS=game:GetService("ReplicatedStorage") local aPet,aHandle,aBag=false,false,false

AutoTab:CreateToggle({Name="Auto Sell Pets",CurrentValue=false,Flag="AutoSellPet",Callback=function(v)aPet=v end})
AutoTab:CreateToggle({Name="Auto Sell Handles",CurrentValue=false,Flag="AutoSellHandle",Callback=function(v)aHandle=v end})
AutoTab:CreateToggle({Name="Auto Sell Backpack",CurrentValue=false,Flag="AutoSellBag",Callback=function(v)aBag=v end})

task.spawn(function()while task.wait(1)do
 if aPet then pcall(function()RS.GameEvents.SellPet_RE:FireServer(Instance.new("Tool"))end)end
 if aHandle then pcall(function()RS.GameEvents.Sell_Item:FireServer()end)end
 if aBag then pcall(function()RS.GameEvents.Sell_Inventory:FireServer()end)end
end end)

AutoTab:CreateLabel("Auto Rebirth/Ascend, Note: Held the required fruit or item to automatic rebirth, sheckles/money must be can buy ascend.")
local RS=game:GetService("ReplicatedStorage") local aReb=false

AutoTab:CreateToggle({Name="Auto Rebirth",CurrentValue=false,Flag="AutoRebirth",Callback=function(v)aReb=v end})

task.spawn(function()while task.wait(1)do
 if aReb then pcall(function()RS.GameEvents.BuyRebirth:FireServer()end)end
end end)

AutoTab:CreateLabel("Auto Feed/Give food to NPC")
local RS=game:GetService("ReplicatedStorage") local selNPC,aFeed=nil,false

AutoTab:CreateDropdown({Name="NPC List",Options={"Sam","Isaac","Eloise","Raphael"},MultipleOptions=false,Default={},Callback=function(v)selNPC=v end})
AutoTab:CreateToggle({Name="Auto Feed NPC",CurrentValue=false,Flag="AutoFeedNPC",Callback=function(v)aFeed=v end})

task.spawn(function()while task.wait(1)do
 if aFeed and selNPC then pcall(function()RS.GameEvents.FeedNPC_RE:FireServer(selNPC)end)end
end end)

AutoTab:CreateLabel("Auto Change Pet Loadout")
local RS=game:GetService("ReplicatedStorage")
local aSwap=false delayTime=5 swapSlots={}
local order={"1","3","2"} -- fixed cycle

AutoTab:CreateInput({Name="Swap Delay (sec)",PlaceholderText="Enter seconds",RemoveTextAfterFocusLost=true,Callback=function(v)delayTime=tonumber(v)or 5 end})
AutoTab:CreateDropdown({Name="Select Loadouts",Options={"1","2","3"},MultipleOptions=false,Default={},Callback=function(v)swapSlots=v end})
AutoTab:CreateToggle({Name="Auto Swap Pets",CurrentValue=false,Flag="AutoSwapPets",Callback=function(v)aSwap=v end})

task.spawn(function()
    while task.wait() do
        if aSwap and #swapSlots>0 then
            for _,slot in ipairs(order) do
                if not aSwap then break end
                for _,sel in ipairs(swapSlots) do
                    if sel==slot then
                        local args={"SwapPetLoadout",tonumber(slot)}
                        pcall(function()RS.GameEvents.PetsService:FireServer(unpack(args))end)
                        task.wait(delayTime)
                    end
                end
            end
        end
    end
end)

AutoTab:CreateLabel("Auto Change Garden Slot")
local RS = game:GetService("ReplicatedStorage")
local aGarden = false
local delayTime = 5
local selSlots = {}

-- Fixed mapping (Garden Slot 1 = 1, Garden Slot 2 = 2)
local slotMap = {
    ["Garden Slot 1"] = 1,
    ["Garden Slot 2"] = 2
}

AutoTab:CreateInput({
    Name = "Garden Delay (sec)",
    PlaceholderText = "Enter seconds",
    RemoveTextAfterFocusLost = true,
    Callback = function(v)
        delayTime = tonumber(v) or 5
    end
})

AutoTab:CreateDropdown({
    Name = "Select Garden Slots",
    Options = {"Garden Slot 1","Garden Slot 2"},
    MultipleOptions = true,
    Default = {},
    Callback = function(v)
        selSlots = v
    end
})

AutoTab:CreateToggle({
    Name = "Auto Change Garden Slot",
    CurrentValue = false,
    Flag = "AutoGarden",
    Callback = function(v) aGarden = v end
})

task.spawn(function()
    while task.wait() do
        if aGarden and #selSlots > 0 then
            for _, slot in ipairs(selSlots) do
                if not aGarden then break end
                local args = {slotMap[slot]}
                pcall(function()
                    RS.GameEvents.SaveSlotService.RequestChangeSlots:FireServer(unpack(args))
                end)
                task.wait(delayTime)
            end
        end
    end
end)




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
	MultipleOptions = true,
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
	MultipleOptions = true,
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
	MultipleOptions = true,
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
	MultipleOptions = true,
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
                pcall(function() ReplicatedStorage.GameEvents.BuyEventShopStock:FireServer(item, 2) end)
                task.wait(0.3)
            end
        end
        if autoBuyFE then
            for _, item in ipairs(selectedFallEggs) do
                pcall(function() ReplicatedStorage.GameEvents.BuyEventShopStock:FireServer(item, 3) end)
                task.wait(0.3)
            end
        end
        if autoBuyFC then
            for _, item in ipairs(selectedFallCosmetics) do
                pcall(function() ReplicatedStorage.GameEvents.BuyEventShopStock:FireServer(item, 4) end)
                task.wait(0.3)
            end
        end
        task.wait(0.5)
    end
end)

local RS, autoBuyS, selectedSeeds = game:GetService("ReplicatedStorage"), false, {}

ShopTab:CreateLabel("Auto Buy Local Shops")
ShopTab:CreateDropdown({Name="Seed List",Options=SeedShopList,MultipleOptions=true,Default={},Callback=function(v)selectedSeeds=v end})
ShopTab:CreateToggle({Name="Auto Buy Selected Seeds",CurrentValue=false,Callback=function(v)autoBuyS=v end})

task.spawn(function()
    while task.wait(1) do
        if autoBuyS then
            for _, s in ipairs(selectedSeeds) do
                pcall(function()
                    local t,n=s:match("^(.-)%s*|%s*(.+)$")
                    if t and n then RS.GameEvents.BuySeedStock:FireServer(t,n) end
                end)
                task.wait(.3)
            end
        end
    end
end)

local gearShopList = GearList -- Assuming GearList is already defined
local eggShopList = EggList -- Assuming EggList is already defined


local selectedGears, selectedEggs = {}, {}, {}
local autoBuyG, autoBuyE = false, false, false

ShopTab:CreateDropdown({ Name = "Gear List", Options = gearShopList, MultipleOptions = true, Default = {}, Callback = function(v) selectedGears = v end })
ShopTab:CreateToggle({ Name = "Auto Buy Selected Gears", CurrentValue = false, Callback = function(v) autoBuyG = v end })

ShopTab:CreateDropdown({ Name = "Egg Shop List", Options = eggShopList, MultipleOptions = true, Default = {}, Callback = function(v) selectedEggs = v end })
ShopTab:CreateToggle({ Name = "Auto Buy Selected Eggs", CurrentValue = false, Callback = function(v) autoBuyE = v end })

task.spawn(function()
	while task.wait(1) do
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
-- Default config name when script loads
Rayfield:SetConfigurationName("Default")
Rayfield:LoadConfiguration()

-- Save button
MiscTab:CreateButton({
    Name = "Save Config",
    Callback = function()
        Rayfield:SaveConfiguration()
        Rayfield:Notify({Title="Config",Content="Configuration saved successfully.",Duration=5})
    end
})

-- Load button
MiscTab:CreateButton({
    Name = "Load Config",
    Callback = function()
        Rayfield:LoadConfiguration()
        Rayfield:Notify({Title="Config",Content="Configuration loaded successfully.",Duration=5})
    end
})

-- Create new config
MiscTab:CreateInput({
    Name = "Create Config",
    PlaceholderText = "Enter config name",
    Callback = function(name)
        if name and name~="" then
            Rayfield:SetConfigurationName(name)
            Rayfield:SaveConfiguration()
            Rayfield:Notify({Title="Config",Content="New configuration '"..name.."' created.",Duration=5})
        else
            Rayfield:Notify({Title="Error",Content="Please enter a valid config name.",Duration=5})
        end
    end
})

-- Delete config notice
MiscTab:CreateInput({
    Name = "Delete Config (Manual)",
    PlaceholderText = "Delete via folder",
    Callback = function()
        Rayfield:Notify({
            Title="Notice",
            Content="Please delete config files manually in your workspace folder.",
            Duration=6
        })
    end
})

	
-- Further enhancements or additions as required

-- UI elements & script finish
Rayfield:Init()

