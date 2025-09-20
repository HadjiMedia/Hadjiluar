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

-- Service Map (shortcuts)
local Services = {
    Pets = ReplicatedStorage.GameEvents.PetsService,
    FeedNPC = ReplicatedStorage.GameEvents.FeedNPC_RE,
    Rebirth = ReplicatedStorage.GameEvents.BuyRebirth,
    SellPet = ReplicatedStorage.GameEvents.SellPet_RE,
    SellItem = ReplicatedStorage.GameEvents.Sell_Item,
    SellBag = ReplicatedStorage.GameEvents.Sell_Inventory,
    BuySeed = ReplicatedStorage.GameEvents.BuySeedStock,
    BuyGear = ReplicatedStorage.GameEvents.BuyGearStock,
    BuyEgg = ReplicatedStorage.GameEvents.BuyPetEgg,
    BuyEvent = ReplicatedStorage.GameEvents.BuyEventShopStock,
    FallAll = ReplicatedStorage.GameEvents.FallMarketEvent.SubmitAllPlants,
    FallHeld = ReplicatedStorage.GameEvents.FallMarketEvent.SubmitHeldPlant
}

-- ✅ TABS
local AutoTab = Window:CreateTab("Automatic")
local FarmTab = Window:CreateTab("Event")
local ShopTab = Window:CreateTab("Shop")
local PlayerTab = Window:CreateTab("Local Player")
local TpTab = Window:CreateTab("Teleport Location")
local MiscTab = Window:CreateTab("Misc")

--// SELL
AutoTab:CreateLabel("Auto Sell")
local aPet,aHandle,aBag=false,false,false
AutoTab:CreateToggle({Name="Auto Sell Pets",CurrentValue=false,Flag="AutoSellPet",Callback=function(v)aPet=v end})
AutoTab:CreateToggle({Name="Auto Sell Handles",CurrentValue=false,Flag="AutoSellHandle",Callback=function(v)aHandle=v end})
AutoTab:CreateToggle({Name="Auto Sell Backpack",CurrentValue=false,Flag="AutoSellBag",Callback=function(v)aBag=v end})

task.spawn(function()while task.wait(1)do
 if aPet then pcall(function()Services.SellPet:FireServer(Instance.new("Tool"))end)end
 if aHandle then pcall(function()Services.SellItem:FireServer()end)end
 if aBag then pcall(function()Services.SellBag:FireServer()end)end
end end)

--// REBIRTH
AutoTab:CreateLabel("Auto Rebirth/Ascend")
local aReb=false
AutoTab:CreateToggle({Name="Auto Rebirth",CurrentValue=false,Flag="AutoRebirth",Callback=function(v)aReb=v end})
task.spawn(function()while task.wait(1)do if aReb then pcall(function()Services.Rebirth:FireServer()end)end end end)

--// FEED NPC
AutoTab:CreateLabel("Auto Feed NPC")
local selNPC,aFeed=nil,false
AutoTab:CreateDropdown({Name="NPC List",Options={"Sam","Isaac","Eloise","Raphael"},MultipleOptions=false,Default={},Callback=function(v)selNPC=v end})
AutoTab:CreateToggle({Name="Auto Feed NPC",CurrentValue=false,Flag="AutoFeedNPC",Callback=function(v)aFeed=v end})
task.spawn(function()while task.wait(1)do if aFeed and selNPC then pcall(function()Services.FeedNPC:FireServer(selNPC)end)end end end)

--// PET LOADOUT SWAP
AutoTab:CreateLabel("Auto Change Pet Loadout")
local aSwap=false delayTime=5 swapSlots={} local order={"1","3","2"}
AutoTab:CreateInput({Name="Swap Delay (sec)",PlaceholderText="Enter seconds",RemoveTextAfterFocusLost=true,Callback=function(v)delayTime=tonumber(v)or 5 end})
AutoTab:CreateDropdown({Name="Select Loadouts",Options={"1","2","3"},MultipleOptions=false,Default={},Callback=function(v)swapSlots=v end})
AutoTab:CreateToggle({Name="Auto Swap Pets",CurrentValue=false,Flag="AutoSwapPets",Callback=function(v)aSwap=v end})
task.spawn(function()while task.wait()do if aSwap and #swapSlots>0 then for _,slot in ipairs(order)do if not aSwap then break end for _,sel in ipairs(swapSlots)do if sel==slot then local args={"SwapPetLoadout",tonumber(slot)} pcall(function()Services.Pets:FireServer(unpack(args))end) task.wait(delayTime) end end end end end end)

--// GARDEN SLOT (keep original, no refactor)
local aGarden, delayTime, selSlots = false, 5, {}
local slotMap = {["Garden Slot 1"]="inC2R",["Garden Slot 2"]="DEFAULT"}
AutoTab:CreateLabel("Auto Change Garden Slot")
AutoTab:CreateInput({Name="Garden Delay (sec)",PlaceholderText="Enter seconds",RemoveTextAfterFocusLost=true,Callback=function(v)delayTime=tonumber(v)or 5 end})
AutoTab:CreateDropdown({Name="Select Garden Slots",Options={"Garden Slot 1","Garden Slot 2"},MultipleOptions=true,Default={},Callback=function(v)selSlots=v end})
AutoTab:CreateToggle({Name="Auto Change Garden Slot",CurrentValue=false,Flag="AutoGarden",Callback=function(v)aGarden=v end})
task.spawn(function()while task.wait()do if aGarden and #selSlots>0 then for _,slot in ipairs(selSlots)do if not aGarden then break end local args={slotMap[slot]} if args[1]then pcall(function()ReplicatedStorage.GameEvents.SaveSlotService.RequestChangeSlots:FireServer(unpack(args))end)end task.wait(delayTime)end end end end)

--// FALL TREE EVENT
FarmTab:CreateLabel("Auto Submit All Plants To Fall Tree")
local autoSubmitPlants=false
FarmTab:CreateToggle({Name="Auto Submit All Plants",CurrentValue=false,Callback=function(v)autoSubmitPlants=v end})
task.spawn(function()while true do if autoSubmitPlants then pcall(function()Services.FallAll:FireServer()end)end task.wait(1)end end)

FarmTab:CreateLabel("Auto Submit Held Plants To Fall Tree")
local autoSubmitHeldPlants=false
FarmTab:CreateToggle({Name="Auto Submit Held Plants",CurrentValue=false,Callback=function(v)autoSubmitHeldPlants=v end})
task.spawn(function()while true do if autoSubmitHeldPlants then pcall(function()Services.FallHeld:FireServer()end)end task.wait(1)end end)

--// SHOPS
local selectedSeeds,selectedGears,selectedEggs={}, {}, {}
local autoBuyS,autoBuyG,autoBuyE=false,false,false
ShopTab:CreateLabel("Auto Buy Shops")
ShopTab:CreateDropdown({Name="Seed List",Options=SeedShopList,MultipleOptions=true,Default={},Callback=function(v)selectedSeeds=v end})
ShopTab:CreateToggle({Name="Auto Buy Seeds",CurrentValue=false,Callback=function(v)autoBuyS=v end})
ShopTab:CreateDropdown({Name="Gear List",Options=GearList,MultipleOptions=true,Default={},Callback=function(v)selectedGears=v end})
ShopTab:CreateToggle({Name="Auto Buy Gears",CurrentValue=false,Callback=function(v)autoBuyG=v end})
ShopTab:CreateDropdown({Name="Egg List",Options=EggList,MultipleOptions=true,Default={},Callback=function(v)selectedEggs=v end})
ShopTab:CreateToggle({Name="Auto Buy Eggs",CurrentValue=false,Callback=function(v)autoBuyE=v end})

task.spawn(function()while task.wait(1)do
 if autoBuyS then for _,s in ipairs(selectedSeeds)do pcall(function()Services.BuySeed:FireServer(s)end)task.wait(.3)end end
 if autoBuyG then for _,g in ipairs(selectedGears)do pcall(function()Services.BuyGear:FireServer(g)end)task.wait(.3)end end
 if autoBuyE then for _,e in ipairs(selectedEggs)do pcall(function()Services.BuyEgg:FireServer(e)end)task.wait(.3)end end
end end)
