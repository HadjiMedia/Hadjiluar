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

-- All Grow a Garden crops (alphabetical) 
local FruitList = { "Aloe Vera", "Amber Spine", "Apple", "Artichoke", "Avocado",
	"Badlands Pepper", "Bamboo", "Banana", "Beanstalk", "Bee Balm", "Bell Pepper",
	"Bendboo", "Bitter Melon", "Blood Banana", "Blue Lollipop", "Blueberry", "Bone Blossom",
	"Boneboo", "Broccoli", "Burning Bud", "Butternut Squash", "Cacao", "Cactus", "Canary Melon",
	"Candy Blossom", "Candy Sunflower", "Cantaloupe", "Carrot", "Cauliflower", "Celestiberry",
	"Cherry Blossom", "Chocolate Carrot", "Coconut", "Cocovine", "Corn", "Cranberry", 
	"Crimson Vine", "Crocus", "Crown Melon", "Cursed Fruit", "Daffodil", "Dandelion", "Delphinium", 
	"Dezen", "Dragon Fruit", "Dragon Pepper", "Dragon Sapling", "Durian", "Easter Egg", "Eggplant",
	"Elder Strawberry", "Elephant Ears", "Ember Lily", "Enkaku", "Feijoa", "Firefly Fern", "Firework Flower",
	"Fossilight", "Foxglove", "Fruitball", "Giant Pinecone", "Glowshroom", "Grand Tomato", "Mushroom", "Grape", 
	"Rabbit Flower", "Hibiscus", "Hinomai", "Honeydew", "Stardust", "Irish Clover", "Ivy Gourd", "Lemon", "Lime", 
	"Lucky Bamboo", "Magic Tulip", "Maple Apple", "Mango", "Monoblooma", "Moonlight Fruit", "Onion", "Orange", "Orchid", 
	"Peach", "Pear", "Pepper", "Pineapple", "Plum", "Poisonberry", "Pomegranate", "Pumpkin", "Radish", "Rhubarb", "Rose", 
	"Sakura Bush", "Shadow Apple", "Sinisterdrip", "Snowflake Bloom", "Sorbitree", "Spirit Petal", "Starfruit", "Strawberry", 
	"Sugarglaze", "Sunflower", "Sundew", "Sweet Apple", "Taco Fern", "Taro Flower", "Tranquil Bloom", "Twisted Tangle",
	"Veinpetal", "Violet Corn", "Watermelon", "Wildflower", "Yam", "Zucchini" }

local GearList={"Watering Can","Trading Ticket","Trowel","Recall Wrench","Basic Sprinkler","Advance Sprinkler","Medium Toy","Medium Treat","Godly Sprinkler","Magnifying Glass","Master Sprinkler","Cleaning Sprinkler","Cleaning Pet Shard","Favorite Tool","Harvest Tool","Friendship Pot","Grandmaster Sprinkler","Levelup Lollipop"}
local EggList={"Common Egg","Uncommon Egg","Rare Egg","Legendary Egg","Mythical Egg","Bug Egg"}
local SeedShopList={"Carrot","Strawberry","Blueberry","Orange Tulip","Tomato","Corn","Daffodil","Watermelon","Pumpkin","Apple","Bamboo","Coconut","Cactus","Dragon Fruit","Mango","Grape","Mushroom","Pepper","Cacao","Beanstalk","Ember Lily","Sugar Apple","Burning Bud","Giant Pinecone","Elder Strawberry","Romanesco"}

local FallSeed = { "Turnip", "Parsley", "Meyer Lemon", "Carnival Pumpkin", "Kniphofia", "Golden Peach", "Maple Resin" }

local FallGear = { "Firefly Jar", "Sky Lantern", "Maple Leaf Kite", "Leaf Blower", "Maple Syrup", "Maple Sprinkler", "Bonfire", 
	"Harvest Basket", "Maple Leaf Charm", "Golden Acorn" } 

local FallPet = { "Fall Egg", "Chipmunk", "Red Squirrel", "Marmot", "Sugar Glider", "Space Squirrel" }

local FallCosmetics = { "Fall Create", "Fall Leaf Chair", "Maple Flag", "Flying Kite", "Fall Cosmetics" }

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
local aSwap=false delayTime=5 swapSlots={} local order={"1","2","3"}
AutoTab:CreateInput({Name="Swap Delay (sec)",PlaceholderText="Enter seconds",RemoveTextAfterFocusLost=true,Callback=function(v)delayTime=tonumber(v)or 5 end})
AutoTab:CreateDropdown({Name="Select Loadouts",Options={"1","2","3"},MultipleOptions=true,Default={},Callback=function(v)swapSlots=v end})
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
local selectedSeeds,selectedGears,selectedEggs={}, {}, {} local autoBuyS,autoBuyG,autoBuyE=false,false,false
ShopTab:CreateLabel("Auto Buy Shops")
ShopTab:CreateDropdown({Name="Seed List",Options=SeedShopList,MultipleOptions=true,Default={},Callback=function(v)selectedSeeds=v end})
ShopTab:CreateToggle({Name="Auto Buy Seeds",CurrentValue=false,Callback=function(v)autoBuyS=v end})
ShopTab:CreateDropdown({Name="Gear List",Options=GearList,MultipleOptions=true,Default={},Callback=function(v)selectedGears=v end})
ShopTab:CreateToggle({Name="Auto Buy Gears",CurrentValue=false,Callback=function(v)autoBuyG=v end})
ShopTab:CreateDropdown({Name="Egg List",Options=EggList,MultipleOptions=true,Default={},Callback=function(v)selectedEggs=v end})
ShopTab:CreateToggle({Name="Auto Buy Eggs",CurrentValue=false,Callback=function(v)autoBuyE=v end})

task.spawn(function()while task.wait(1)do
 if autoBuyS then for _,s in ipairs(selectedSeeds)do pcall(function()ReplicatedStorage.GameEvents.BuySeedStock:FireServer(s)end)task.wait(.3)end end
 if autoBuyG then for _,g in ipairs(selectedGears)do pcall(function()ReplicatedStorage.GameEvents.BuyGearStock:FireServer(g)end)task.wait(.3)end end
 if autoBuyE then for _,e in ipairs(selectedEggs)do pcall(function()ReplicatedStorage.GameEvents.BuyPetEgg:FireServer(e)end)task.wait(.3)end end
end end)

-- 🌟 PLAYER UTILITIES
PlayerTab:CreateToggle({Name="Infinite Jump",CurrentValue=false,Callback=function(v)_G.infinjump=v end})
game:GetService("UserInputService").JumpRequest:Connect(function()if _G.infinjump then local hum=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping)end end end)

PlayerTab:CreateSlider({Name="WalkSpeed",Range={16,150},Increment=1,CurrentValue=16,Callback=function(v)local hum=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")if hum then hum.WalkSpeed=v end end})
PlayerTab:CreateSlider({Name="JumpPower",Range={50,200},Increment=5,CurrentValue=50,Callback=function(v)local hum=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")if hum then hum.JumpPower=v end end})

local noclip=false
PlayerTab:CreateToggle({Name="No Clip",CurrentValue=false,Callback=function(v)noclip=v end})
RunService.Stepped:Connect(function()if noclip and LocalPlayer.Character then for _,p in ipairs(LocalPlayer.Character:GetDescendants())do if p:IsA("BasePart") and p.CanCollide then p.CanCollide=false end end end end)

-- 📱 Mobile Fly GUI (Tap to show/hide)
local Player=game.Players.LocalPlayer
local UIS=game:GetService("UserInputService")
local RunService=game:GetService("RunService")
local ScreenGui=Instance.new("ScreenGui",Player:WaitForChild("PlayerGui"))
ScreenGui.ResetOnSpawn=false

local toggleBtn=Instance.new("TextButton",ScreenGui)
toggleBtn.Size=UDim2.new(0,100,0,40)
toggleBtn.Position=UDim2.new(0,20,0.8,0)
toggleBtn.Text="Fly Menu"
toggleBtn.BackgroundColor3=Color3.fromRGB(30,30,30)
toggleBtn.TextColor3=Color3.fromRGB(255,255,255)

local flyFrame=Instance.new("Frame",ScreenGui)
flyFrame.Size=UDim2.new(0,200,0,250)
flyFrame.Position=UDim2.new(0,20,0.45,0)
flyFrame.BackgroundColor3=Color3.fromRGB(20,20,20)
flyFrame.Visible=false

-- Fly Variables
local flying=false
local flySpeed=3
local ctrl={f=0,b=0,l=0,r=0,u=0,d=0}

-- Movement Buttons
local function makeBtn(name,pos,callback)
    local b=Instance.new("TextButton",flyFrame)
    b.Size=UDim2.new(0,80,0,40)
    b.Position=pos
    b.Text=name
    b.BackgroundColor3=Color3.fromRGB(40,40,40)
    b.TextColor3=Color3.fromRGB(255,255,255)
    b.MouseButton1Click:Connect(callback)
end

-- Toggle Fly
makeBtn("Toggle Fly",UDim2.new(0,60,0,10),function()
    flying=not flying
    local char=Player.Character or Player.CharacterAdded:Wait()
    local hrp=char:WaitForChild("HumanoidRootPart")

    if flying then
        local bg=Instance.new("BodyGyro",hrp)
        bg.P=9e4 bg.MaxTorque=Vector3.new(9e9,9e9,9e9) bg.CFrame=hrp.CFrame
        local bv=Instance.new("BodyVelocity",hrp)
        bv.Velocity=Vector3.new(0,0.1,0) bv.MaxForce=Vector3.new(9e9,9e9,9e9)

        task.spawn(function()
            while flying and hrp and hrp.Parent do task.wait()
                local cam=workspace.CurrentCamera.CFrame
                local move=(cam.LookVector*(ctrl.f+ctrl.b))+(cam.RightVector*(ctrl.l+ctrl.r))+Vector3.new(0,ctrl.u+ctrl.d,0)
                bv.Velocity=move*flySpeed
                bg.CFrame=cam
            end
            if hrp:FindFirstChild("BodyGyro") then hrp.BodyGyro:Destroy() end
            if hrp:FindFirstChild("BodyVelocity") then hrp.BodyVelocity:Destroy() end
        end)
    end
end)

-- Movement Buttons
makeBtn("Up",UDim2.new(0,60,0,60),function() ctrl.u=1 task.delay(0.2,function()ctrl.u=0 end) end)
makeBtn("Down",UDim2.new(0,60,0,110),function() ctrl.d=-1 task.delay(0.2,function()ctrl.d=0 end) end)
makeBtn("Forward",UDim2.new(0,60,0,160),function() ctrl.f=1 task.delay(0.2,function()ctrl.f=0 end) end)
makeBtn("Back",UDim2.new(0,60,0,210),function() ctrl.b=-1 task.delay(0.2,function()ctrl.b=0 end) end)
makeBtn("Left",UDim2.new(0,0,0,185),function() ctrl.l=-1 task.delay(0.2,function()ctrl.l=0 end) end)
makeBtn("Right",UDim2.new(0,120,0,185),function() ctrl.r=1 task.delay(0.2,function()ctrl.r=0 end) end)

-- Speed Buttons
makeBtn("Speed+",UDim2.new(0,0,0,10),function() flySpeed=flySpeed+1 end)
makeBtn("Speed-",UDim2.new(0,120,0,10),function() flySpeed=math.max(1,flySpeed-1) end)

-- Toggle Show/Hide GUI (1 tap show, 2 tap hide)
local tapTime=0
toggleBtn.MouseButton1Click:Connect(function()
    local now=tick()
    if now-tapTime<0.4 then
        flyFrame.Visible=false -- double tap → hide
    else
        flyFrame.Visible=not flyFrame.Visible -- single tap → toggle show
    end
    tapTime=now
end)

-- 📍 TELEPORT UTILITIES
TpTab:CreateLabel("Tap a button to teleport") 
local function teleportTo(cframe) 
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait() 
local hrp = char:WaitForChild("HumanoidRootPart") hrp.CFrame = cframe end

TpTab:CreateButton({ Name = "Seed Shop", Callback = function() teleportTo(CFrame.new(86.581, 3, -27.003)) end }) 
TpTab:CreateButton({ Name = "Sell Stuff", Callback = function() teleportTo(CFrame.new(86.585, 3, 0.427)) end }) 
TpTab:CreateButton({ Name = "Gear Shop", Callback = function() teleportTo(CFrame.new(-284.945, 3, -13.171)) end }) 
TpTab:CreateButton({ Name = "Pet/Egg Shop", Callback = function() teleportTo(CFrame.new(-283.833, 3, -1.397)) end }) 
TpTab:CreateButton({ Name = "Cosmetics Shop", Callback = function() teleportTo(CFrame.new(-283.216, 3, -25.605)) end }) 
TpTab:CreateButton({ Name = "Event", Callback = function() teleportTo(CFrame.new(-103.816, 4.4, -6.888)) end })

-- 🔧 MISC UTILITIES
MiscTab:CreateButton({ Name = "Rejoin Server", Callback = function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end })
local currentJobId = game.JobId or "Unavailable" MiscTab:CreateParagraph({ Title = "Your JobId", Content = currentJobId })
MiscTab:CreateButton({ Name = "Copy JobId to Clipboard", Callback = function() if setclipboard then setclipboard(currentJobId) Rayfield:Notify({Title = "Copied", Content = "JobId copied to clipboard!", Duration = 3}) end end }) 
MiscTab:CreateInput({ Name = "Enter JobId to Join", PlaceholderText = "Paste JobId here...", Callback = function(jobId) if jobId ~= "" then TeleportService:TeleportToPlaceInstance(game.PlaceId, jobId, LocalPlayer) end end })
MiscTab:CreateButton({ Name = "Server Hop", Callback = function() local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100" local success, result = pcall(function() return HttpService:JSONDecode(game:HttpGet(url)) end) if success and result and result.data then for _, server in ipairs(result.data) do if server.playing < server.maxPlayers and server.id ~= currentJobId then TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer) break end end end end }) 

-- 💾 CONFIG SYSTEM
-- Default config name when script loads Rayfield:SetConfigurationName("Default") Rayfield:LoadConfiguration() -- Save button 
MiscTab:CreateButton({ Name = "Save Config", Callback = function() Rayfield:SaveConfiguration() Rayfield:Notify({Title="Config",Content="Configuration saved successfully.",Duration=5}) end }) -- Load button 
MiscTab:CreateButton({ Name = "Load Config", Callback = function() Rayfield:LoadConfiguration() Rayfield:Notify({Title="Config",Content="Configuration loaded successfully.",Duration=5}) end }) -- Create new config
MiscTab:CreateInput({ Name = "Create Config", PlaceholderText = "Enter config name", Callback = function(name) if name and name~="" then Rayfield:SetConfigurationName(name) Rayfield:SaveConfiguration() Rayfield:Notify({Title="Config",Content="New configuration '"..name.."' created.",Duration=5}) else Rayfield:Notify({Title="Error",Content="Please enter a valid config name.",Duration=5}) end end }) -- Delete config notice
MiscTab:CreateInput({ Name = "Delete Config (Manual)", PlaceholderText = "Delete via folder", Callback = function() Rayfield:Notify({ Title="Notice", Content="Please delete config files manually in your workspace folder.", Duration=6 }) end }) -- Further enhancements or additions as required -- UI elements & script finish Rayfield:Init()
