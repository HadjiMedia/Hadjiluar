-- // Zacky Source (Rayfield UI Remake)

-- ============================================================
-- LOAD THE LIBRARY
-- ============================================================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- ============================================================
-- CREATE WINDOW
-- ============================================================
local Window = Rayfield:CreateWindow({
    Name = "Grow a Garden 2",
    LoadingTitle = "Zacky Source",
    LoadingSubtitle = "by Zack1211",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil,
        FileName = "ZackyGarden"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = false,
})

-- ============================================================
-- SERVICES
-- ============================================================
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- ============================================================
-- PREVENT MULTIPLE LOOPS RUNNING (KILL OLD THREADS)
-- ============================================================
if getgenv and getgenv() then
    if getgenv().PHCzackRunningId then
        getgenv().PHCzackRunningId = getgenv().PHCzackRunningId + 1
    else
        getgenv().PHCzackRunningId = 1
    end
end
local currentThreadId = (getgenv and getgenv().PHCzackRunningId) or 1

local Networking = nil
pcall(function()
    Networking = require(ReplicatedStorage.SharedModules.Networking)
end)

-- ============================================================
-- OPTIONS & LISTS
-- ============================================================
local FruitList = { "Buttercup", "Pineapple", "Grape", "Apple", "Carrot", "Strawberry", "Blueberry", "Tomato", "Pumpkin", "Bamboo", "Mushroom", "Coconut", "Cactus", "Mango", "Cherry", "Sunflower", "Acorn", "Beanstalk", "Poison Apple", "Venus Fly Trap", "Thorn Rose", "Pomegranate", "Lotus", "Romanesco", "Baby Cactus", "Glow Mushroom", "Ghost Pepper", "Poison Ivy", "Horned Melon", "Corn", "Pinetree", "Banana", "Tulip", "Dragon Fruit", "Dragon's Breath", "Moon Bloom", "Green Bean", "Venom Spitter", "Hypnobloom" }
local MutationList = { "Gold", "Rainbow", "Electric", "Solarflare", "Frozen", "Bloodlit", "Chained", "Pizza", "Starstruck", "Aurora" }
local GearList = { "Common Watering Can", "Common Sprinkler", "Sign", "Megaphone", "Lantern", "Uncommon Sprinkler", "Rare Sprinkler", "Legendary Sprinkler", "Super Sprinkler", "Trowel", "Speed Mushroom", "Jump Mushroom", "Gnome", "Shrink Mushroom", "Supersize Mushroom", "Invisibility Mushroom", "Teleporter", "Legendary Pet Teleporter", "Mythic Pet Teleporter", "Super Pet Teleporter", "Super Watering Can", "Basic Pot", "Flashbang", "Player Magnet", "Grappling Hook", "Wheelbarrow", "Strawberry Sniper" }
local PropList = { "Light Crate", "Arch Crate", "Bench Crate", "Bridge Crate", "Seesaw Crate", "Sign Crate", "Teleporter Pad Crate", "Ladder Crate", "Fence Crate", "Owner Door Crate", "Conveyor Crate", "Spring Crate", "Roleplay Crate", "Bear Trap Crate" }
local PetList = { "Raccoon", "Robin", "Frog", "Bunny", "Deer", "Owl", "Bee", "Unicorn", "GoldenDragonfly", "Monkey", "BlackDragon", "IceSerpent", "Bear" }

local Options = {
    AutoShovel = false,
    ShovelFruits = {},
    ShovelExceptionMulti = "None",
    
    AutoHarvest = false,
    FilterMutations = false,
    HarvestFruits = {},
    HarvestMutations = {},
    
    AutoBuyAllSeeds = false,
    AutoBuySeeds = false,
    BuySeeds = {},
    
    AutoBuyAllGears = false,
    AutoBuyGears = false,
    BuyGears = {},
    
    AutoBuyAllProps = false,
    AutoBuyProps = false,
    BuyProps = {},
    
    AutoPlant = false,
    PlantSeeds = {},
    
    AutoBuyPets = false,
    BuyPets = {},
    
    AutoCollectBest = false,
    AutoSell = false,
    
    AutoEventDrops = false,
    AutoMeteor = false,
    AutoGnome = false,
    AutoWildPet = false,
    AutoSheckle = false,
    
    WebhookUrl = "",
    WebhookPets = {}
}

-- ============================================================
-- TABS
-- ============================================================
local MainTab    = Window:CreateTab("MAIN", nil)
local FarmTab    = Window:CreateTab("FARM", nil)
local EventsTab  = Window:CreateTab("EVENTS", nil)
local MiscTab    = Window:CreateTab("MISC", nil)
local VisualsTab = Window:CreateTab("VISUALS", nil)

-- ============================================================
-- MAIN TAB
-- ============================================================
MainTab:CreateSection("Player Tweaks")

MainTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 200},
    Increment = 1,
    CurrentValue = 16,
    Flag = "WalkSpeedSlider",
    Callback = function(v)
        local c = LocalPlayer.Character
        if c and c:FindFirstChild("Humanoid") then
            c.Humanoid.WalkSpeed = v
        end
    end,
})

MainTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 300},
    Increment = 1,
    CurrentValue = 50,
    Flag = "JumpPowerSlider",
    Callback = function(v)
        local c = LocalPlayer.Character
        if c and c:FindFirstChild("Humanoid") then
            c.Humanoid.JumpPower = v
        end
    end,
})

_G.PHCzack_InfJump = false
MainTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfJumpToggle",
    Callback = function(on)
        _G.PHCzack_InfJump = on
    end,
})

if not _G.PHCzack_IJConn then
    _G.PHCzack_IJConn = game:GetService("UserInputService").JumpRequest:Connect(function()
        if _G.PHCzack_InfJump then
            local c = LocalPlayer.Character
            if c and c:FindFirstChild("Humanoid") then
                c.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end)
end

MainTab:CreateSection("Utilities")

MainTab:CreateButton({
    Name = "Reset Character",
    Callback = function()
        local c = LocalPlayer.Character
        if c and c:FindFirstChild("Humanoid") then c.Humanoid.Health = 0 end
    end,
})

MainTab:CreateButton({
    Name = "Rejoin Game",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end,
})

-- ============================================================
-- FARM TAB
-- ============================================================
FarmTab:CreateSection("Auto Shovel")

FarmTab:CreateToggle({
    Name = "Auto Shovel",
    CurrentValue = false,
    Flag = "AutoShovelToggle",
    Callback = function(v) Options.AutoShovel = v end,
})

FarmTab:CreateDropdown({
    Name = "Shovel Fruits Filter",
    Options = FruitList,
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "ShovelFruitsDrop",
    Callback = function(selected) Options.ShovelFruits = selected end,
})

FarmTab:CreateDropdown({
    Name = "Shovel Exception (Keep Multipliers)",
    Options = {"None", "2x", "3x", "4x", "4.5x", "5x", "5.5x", "6x"},
    CurrentOption = "None",
    MultipleOptions = false,
    Flag = "ShovelExceptionDrop",
    Callback = function(selected) Options.ShovelExceptionMulti = selected end,
})

FarmTab:CreateSection("Harvesting")

FarmTab:CreateToggle({
    Name = "Auto Harvest Selected Fruits",
    CurrentValue = false,
    Flag = "AutoHarvestToggle",
    Callback = function(v) Options.AutoHarvest = v end,
})

FarmTab:CreateToggle({
    Name = "Filter by Mutations",
    CurrentValue = false,
    Flag = "FilterMutationsToggle",
    Callback = function(v) Options.FilterMutations = v end,
})

FarmTab:CreateDropdown({
    Name = "Harvest Fruits Filter",
    Options = FruitList,
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "HarvestFruitsDrop",
    Callback = function(selected) Options.HarvestFruits = selected end,
})

FarmTab:CreateDropdown({
    Name = "Harvest Mutations Filter",
    Options = MutationList,
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "HarvestMutationsDrop",
    Callback = function(selected) Options.HarvestMutations = selected end,
})

FarmTab:CreateSection("Auto Purchase Shop Items")

FarmTab:CreateToggle({
    Name = "Auto Buy All Seeds",
    CurrentValue = false,
    Flag = "AutoBuyAllSeeds",
    Callback = function(v) Options.AutoBuyAllSeeds = v end,
})
FarmTab:CreateToggle({
    Name = "Auto Buy Selected Seeds",
    CurrentValue = false,
    Flag = "AutoBuySeeds",
    Callback = function(v) Options.AutoBuySeeds = v end,
})
FarmTab:CreateDropdown({
    Name = "Seeds Selection",
    Options = FruitList,
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "BuySeedsDrop",
    Callback = function(selected) Options.BuySeeds = selected end,
})

FarmTab:CreateToggle({
    Name = "Auto Buy All Gears",
    CurrentValue = false,
    Flag = "AutoBuyAllGears",
    Callback = function(v) Options.AutoBuyAllGears = v end,
})
FarmTab:CreateToggle({
    Name = "Auto Buy Selected Gears",
    CurrentValue = false,
    Flag = "AutoBuyGears",
    Callback = function(v) Options.AutoBuyGears = v end,
})
FarmTab:CreateDropdown({
    Name = "Gears Selection",
    Options = GearList,
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "BuyGearsDrop",
    Callback = function(selected) Options.BuyGears = selected end,
})

FarmTab:CreateToggle({
    Name = "Auto Buy All Props",
    CurrentValue = false,
    Flag = "AutoBuyAllProps",
    Callback = function(v) Options.AutoBuyAllProps = v end,
})
FarmTab:CreateToggle({
    Name = "Auto Buy Selected Props",
    CurrentValue = false,
    Flag = "AutoBuyProps",
    Callback = function(v) Options.AutoBuyProps = v end,
})
FarmTab:CreateDropdown({
    Name = "Props Selection",
    Options = PropList,
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "BuyPropsDrop",
    Callback = function(selected) Options.BuyProps = selected end,
})

FarmTab:CreateSection("Planting")

FarmTab:CreateToggle({
    Name = "Auto Plant Selected Seeds",
    CurrentValue = false,
    Flag = "AutoPlantToggle",
    Callback = function(v) Options.AutoPlant = v end,
})

FarmTab:CreateDropdown({
    Name = "Seeds to Plant",
    Options = FruitList,
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "PlantSeedsDrop",
    Callback = function(selected) Options.PlantSeeds = selected end,
})

FarmTab:CreateSection("Wild Pets Shop")

FarmTab:CreateToggle({
    Name = "Auto Buy Selected Wild Pets",
    CurrentValue = false,
    Flag = "AutoBuyPetsToggle",
    Callback = function(v) Options.AutoBuyPets = v end,
})

FarmTab:CreateDropdown({
    Name = "Pets Filter",
    Options = PetList,
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "BuyPetsDrop",
    Callback = function(selected) Options.BuyPets = selected end,
})

FarmTab:CreateSection("General Economy")

FarmTab:CreateToggle({
    Name = "Auto Collect Best Fruit",
    CurrentValue = false,
    Flag = "AutoCollectBestToggle",
    Callback = function(v) Options.AutoCollectBest = v end,
})

FarmTab:CreateToggle({
    Name = "Auto Sell All Fruits",
    CurrentValue = false,
    Flag = "AutoSellToggle",
    Callback = function(v) Options.AutoSell = v end,
})

-- ============================================================
-- EVENTS TAB
-- ============================================================
EventsTab:CreateSection("Auto Collect Event Drops")

EventsTab:CreateToggle({
    Name = "Auto Event Drops (Teleport/Fly)",
    CurrentValue = false,
    Flag = "AutoEventDropsToggle",
    Callback = function(v) Options.AutoEventDrops = v end,
})

EventsTab:CreateToggle({
    Name = "Auto Collect Starfall Meteors",
    CurrentValue = false,
    Flag = "AutoMeteorToggle",
    Callback = function(v) Options.AutoMeteor = v end,
})

EventsTab:CreateToggle({
    Name = "Auto Collect Gnomes",
    CurrentValue = false,
    Flag = "AutoGnomeToggle",
    Callback = function(v) Options.AutoGnome = v end,
})

EventsTab:CreateToggle({
    Name = "Auto Collect Wild Pets",
    CurrentValue = false,
    Flag = "AutoWildPetToggle",
    Callback = function(v) Options.AutoWildPet = v end,
})

EventsTab:CreateToggle({
    Name = "Auto Collect Sheckles",
    CurrentValue = false,
    Flag = "AutoSheckleToggle",
    Callback = function(v) Options.AutoSheckle = v end,
})

-- ============================================================
-- MISC TAB
-- ============================================================
MiscTab:CreateSection("Weather Tracker")

local WeatherLabel = MiscTab:CreateLabel("Status: Waiting...")
MiscTab:CreateLabel("All Weathers occur randomly per cycle.")

MiscTab:CreateSection("Discord Integration")

MiscTab:CreateInput({
    Name = "Webhook URL",
    PlaceholderText = "Paste your webhook link...",
    RemoveTextAfterFocusLost = false,
    Callback = function(text) Options.WebhookUrl = text end,
})

MiscTab:CreateDropdown({
    Name = "Alert on Selected Pets Spawning",
    Options = PetList,
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "WebhookPetsDrop",
    Callback = function(selected) Options.WebhookPets = selected end,
})

-- ============================================================
-- VISUALS TAB
-- ============================================================
VisualsTab:CreateSection("Graphics & Environment")

VisualsTab:CreateToggle({
    Name = "Fullbright",
    CurrentValue = false,
    Flag = "FullbrightToggle",
    Callback = function(on)
        game:GetService("Lighting").Brightness = on and 10 or 1
    end,
})

VisualsTab:CreateSlider({
    Name = "Field of View",
    Range = {70, 120},
    Increment = 1,
    CurrentValue = 70,
    Flag = "FOVModifier",
    Callback = function(v)
        workspace.CurrentCamera.FieldOfView = v
    end,
})

-- ============================================================
-- AUTOMATION LOOPS & MECHANICS
-- ============================================================
local function tableContains(tbl, val)
    if not tbl then return false end
    for _, v in pairs(tbl) do
        if v == val then return true end
    end
    return false
end

local function SmartFly(targetCFrame, toggleCheck)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return false end
    local root = char.HumanoidRootPart
    
    while true do
        if getgenv and getgenv().PHCzackRunningId and getgenv().PHCzackRunningId ~= currentThreadId then
            root.Anchored = false
            return false
        end
        if toggleCheck and not toggleCheck() then
            root.Anchored = false
            return false
        end
        
        local currentPos = root.Position
        local endPos = targetCFrame.Position
        local dist = (endPos - currentPos).Magnitude
        
        if dist < 5 then
            root.CFrame = targetCFrame
            root.Anchored = false
            return true
        end
        
        local burstDist = math.min(50, dist)
        local burstTime = burstDist / 30
        
        local nextPos = currentPos + (endPos - currentPos).Unit * burstDist
        
        root.Anchored = true
        local tweenInfo = TweenInfo.new(burstTime, Enum.EasingStyle.Linear)
        local tween = game:GetService("TweenService"):Create(root, tweenInfo, {CFrame = CFrame.new(nextPos) * targetCFrame.Rotation})
        tween:Play()
        tween.Completed:Wait()
        
        if dist > 55 then
            local rayOrigin = root.Position + Vector3.new(0, 10, 0)
            local rayDirection = Vector3.new(0, -500, 0)
            local rayParams = RaycastParams.new()
            rayParams.FilterDescendantsInstances = {char}
            rayParams.FilterType = Enum.RaycastFilterType.Exclude
            local hit = workspace:Raycast(rayOrigin, rayDirection, rayParams)
            if hit then
                root.CFrame = CFrame.new(hit.Position + Vector3.new(0, 3, 0))
            end
            root.Anchored = false
            task.wait(1)
        end
    end
end

task.spawn(function()
    while task.wait(1) do
        if getgenv and getgenv().PHCzackRunningId and getgenv().PHCzackRunningId ~= currentThreadId then
            break
        end

        if not Networking then continue end
        
        local plotId = LocalPlayer:GetAttribute("PlotId")
        local plants = nil
        if plotId and workspace.Gardens:FindFirstChild("Plot" .. tostring(plotId)) then
            plants = workspace.Gardens["Plot" .. tostring(plotId)]:FindFirstChild("Plants")
        end
        
        if plants then
            for _, plant in ipairs(plants:GetChildren()) do
                local seedName = plant:GetAttribute("SeedName")
                local mutation = plant:GetAttribute("Mutation")
                
                -- Auto Shovel logic
                if Options.AutoShovel and seedName and tableContains(Options.ShovelFruits, seedName) then
                    local shouldShovel = true
                    if Options.ShovelExceptionMulti and Options.ShovelExceptionMulti ~= "None" then
                        local limitStr = Options.ShovelExceptionMulti:gsub("x", "")
                        local limitMulti = tonumber(limitStr) or 0
                        if limitMulti > 0 then
                            local sizeMulti = plant:GetAttribute("SizeMulti") or 1
                            local corePartName = plant:GetAttribute("CorePartName") or plant:GetAttribute("SeedName")
                            
                            local fruitsFolder = plant:FindFirstChild("Fruits")
                            if fruitsFolder then
                                local bestSize = 0
                                local bestFruit = nil
                                for _, f in ipairs(fruitsFolder:GetChildren()) do
                                    local fSize = f:GetAttribute("SizeMulti") or 0
                                    if fSize >= bestSize then
                                        bestSize = fSize
                                        bestFruit = f
                                    end
                                end
                                if bestFruit then
                                    sizeMulti = bestSize
                                    if bestFruit:GetAttribute("CorePartName") then
                                        corePartName = bestFruit:GetAttribute("CorePartName")
                                    end
                                end
                            end

                            if corePartName and corePartName:match(" Seed$") then
                                corePartName = corePartName:gsub(" Seed$", "")
                            end

                            if sizeMulti >= limitMulti then
                                shouldShovel = false
                            end

                            if not plant:FindFirstChild("Fruits") or #plant.Fruits:GetChildren() == 0 then
                                shouldShovel = false
                            end
                            
                            if shouldShovel then
                                Rayfield:Notify({
                                    Title = "Auto Shovel Loop",
                                    Content = string.format("Shoveled %s (%.2fx multi, Target limit: %s)", tostring(corePartName), sizeMulti, tostring(Options.ShovelExceptionMulti)),
                                    Duration = 3,
                                    Image = 4483362458,
                                })
                            end
                        end
                    end
                    
                    if shouldShovel then
                        local char = LocalPlayer.Character
                        if char then
                            local shovel = char:FindFirstChildOfClass("Tool")
                            if not (shovel and shovel:GetAttribute("Shovel")) then
                                local backpack = LocalPlayer:FindFirstChild("Backpack")
                                if backpack then
                                    for _, tool in ipairs(backpack:GetChildren()) do
                                        if tool:IsA("Tool") and tool:GetAttribute("Shovel") then
                                            local humanoid = char:FindFirstChild("Humanoid")
                                            if humanoid then
                                                humanoid:EquipTool(tool)
                                                shovel = tool
                                            end
                                            break
                                        end
                                    end
                                end
                            end
                            if shovel then
                                local shovelName = shovel:GetAttribute("Shovel") or shovel.Name
                                local fruitsFolder = plant:FindFirstChild("Fruits")
                                if fruitsFolder then
                                    for _, fruit in ipairs(fruitsFolder:GetChildren()) do
                                        Networking.Shovel.UseShovel:Fire(plant.Name, fruit.Name, shovelName, shovel)
                                    end
                                else
                                    Networking.Shovel.UseShovel:Fire(plant.Name, "", shovelName, shovel)
                                end
                            end
                        end
                    end
                end
                
                -- Auto Harvest logic
                if Options.AutoHarvest and seedName and tableContains(Options.HarvestFruits, seedName) then
                    local shouldHarvest = true
                    if Options.FilterMutations then
                        if not mutation or not tableContains(Options.HarvestMutations, mutation) then
                            shouldHarvest = false
                        end
                    end
                    if shouldHarvest then
                        local harvestPlantId = plant:GetAttribute("PlantId")
                        if harvestPlantId then
                            local fruitsFolder = plant:FindFirstChild("Fruits")
                            if fruitsFolder and #fruitsFolder:GetChildren() > 0 then
                                for _, fruit in ipairs(fruitsFolder:GetChildren()) do
                                    local harvestFruitId = fruit:GetAttribute("FruitId")
                                    if harvestFruitId then
                                        Networking.Garden.CollectFruit:Fire(harvestPlantId, harvestFruitId)
                                    end
                                end
                            else
                                Networking.Garden.CollectFruit:Fire(harvestPlantId, "")
                            end
                        end
                    end
                end
            end
        end
        
        -- Auto Plant Seeds
        if Options.AutoPlant and Options.PlantSeeds and #Options.PlantSeeds > 0 then
            local plotId = LocalPlayer:GetAttribute("PlotId")
            local plot = plotId and workspace.Gardens:FindFirstChild("Plot" .. tostring(plotId))
            if plot and plot:FindFirstChild("Visual") then
                local plantArea = plot.Visual:FindFirstChild("PlantAreaColumn1") or plot.Visual:FindFirstChild("GardenZonePart")
                if plantArea then
                    local char = LocalPlayer.Character
                    if char then
                        local seedTool = char:FindFirstChildOfClass("Tool")
                        if not (seedTool and tableContains(Options.PlantSeeds, seedTool.Name)) then
                            local backpack = LocalPlayer:FindFirstChild("Backpack")
                            if backpack then
                                for _, tool in ipairs(backpack:GetChildren()) do
                                    if tool:IsA("Tool") and tableContains(Options.PlantSeeds, tool.Name) then
                                        local humanoid = char:FindFirstChild("Humanoid")
                                        if humanoid then
                                            humanoid:EquipTool(tool)
                                            seedTool = tool
                                        end
                                        break
                                    end
                                end
                            end
                        end
                        if seedTool then
                            local size = plantArea.Size
                            local cframe = plantArea.CFrame
                            local rx = (math.random() - 0.5) * size.X
                            local rz = (math.random() - 0.5) * size.Z
                            local randomPos = cframe * Vector3.new(rx, size.Y/2, rz)
                            Networking.Plant.PlantSeed:Fire(randomPos, seedTool.Name, seedTool)
                        end
                    end
                end
            end
        end
        
        -- Auto Shop Buyers
        if Options.AutoBuyAllSeeds then
            for _, itemName in ipairs(FruitList) do Networking.SeedShop.PurchaseSeed:Fire(itemName) end
        elseif Options.AutoBuySeeds and Options.BuySeeds then
            for _, itemName in ipairs(Options.BuySeeds) do Networking.SeedShop.PurchaseSeed:Fire(itemName) end
        end
        
        if Options.AutoBuyAllGears then
            for _, itemName in ipairs(GearList) do Networking.GearShop.PurchaseGear:Fire(itemName) end
        elseif Options.AutoBuyGears and Options.BuyGears then
            for _, itemName in ipairs(Options.BuyGears) do Networking.GearShop.PurchaseGear:Fire(itemName) end
        end
        
        if Options.AutoBuyAllProps then
            for _, itemName in ipairs(PropList) do Networking.CrateShop.PurchaseCrate:Fire(itemName) end
        elseif Options.AutoBuyProps and Options.BuyProps then
            for _, itemName in ipairs(Options.BuyProps) do Networking.CrateShop.PurchaseCrate:Fire(itemName) end
        end
        
        -- Auto Wild Pets Purchaser
        if Options.AutoBuyPets and Options.BuyPets then
            local spawns = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("WildPetSpawns")
            if spawns then
                for _, wildPet in ipairs(spawns:GetChildren()) do
                    local petName = wildPet.Name:match("WildPet_(.-)_WildPet")
                    if petName and tableContains(Options.BuyPets, petName) then
                        local prompt = wildPet:FindFirstChild("RootPart") and wildPet.RootPart:FindFirstChildOfClass("ProximityPrompt")
                        if prompt then
                            local char = LocalPlayer.Character
                            if char and char:FindFirstChild("HumanoidRootPart") then
                                local origCFrame = char.HumanoidRootPart.CFrame
                                local success = SmartFly(wildPet.RootPart.CFrame, function() return Options.AutoBuyPets end)
                                if success then
                                    char.HumanoidRootPart.Anchored = false
                                    task.wait(3)
                                    prompt.HoldDuration = 0
                                    fireproximityprompt(prompt)
                                    task.wait(0.5)
                                    fireproximityprompt(prompt)
                                    task.wait(1)
                                    SmartFly(origCFrame, function() return Options.AutoBuyPets end)
                                end
                                char.HumanoidRootPart.Anchored = false
                            end
                        end
                    end
                end
            end
        end
        
        if Options.AutoSell then
            Networking.NPCS.SellAll:Fire()
        end
        
        -- Weather Label Interface Controller
        local wv = game:GetService("ReplicatedStorage"):FindFirstChild("WeatherValues")
        if wv then
            local ts = DateTime.now().UnixTimestamp
            local activeWeathers = {}
            for _, weatherName in ipairs({"Rain", "Lightning", "Rainbow", "Snowfall", "Starfall", "Aurora"}) do
                local endTime = wv:GetAttribute(weatherName .. "_EndTime") or 0
                local playing = wv:GetAttribute(weatherName .. "_Playing")
                local timeLeft = endTime - ts
                if playing and timeLeft > 0 then
                    table.insert(activeWeathers, weatherName .. " (" .. tostring(timeLeft) .. "s)")
                end
            end
            
            local activePhase = workspace:GetAttribute("ActivePhase") or "Unknown"
            if #activeWeathers > 0 then
                pcall(function() WeatherLabel:Set("Phase: " .. activePhase .. " | Active: " .. table.concat(activeWeathers, ", ")) end)
            else
                pcall(function() WeatherLabel:Set("Phase: " .. activePhase .. " | No active event weather.") end)
            end
        end

        -- Teleportation Drops Auto Collectors
        if Options.AutoEventDrops then
            local list = {}
            for _, v in ipairs(workspace:GetChildren()) do table.insert(list, v) end
            local dropsFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Drops")
            if dropsFolder then
                for _, v in ipairs(dropsFolder:GetChildren()) do table.insert(list, v) end
            end
            local droppedItems = workspace:FindFirstChild("DroppedItems")
            if droppedItems then
                for _, v in ipairs(droppedItems:GetChildren()) do table.insert(list, v) end
            end
            local packSpawns = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("SeedPackSpawnServerLocations")
            if packSpawns then
                for _, v in ipairs(packSpawns:GetChildren()) do table.insert(list, v) end
            end
            
            for _, drop in ipairs(list) do
                if drop.Name:match("Gold") or drop.Name:match("Rainbow") or drop.Name:match("Pot") or drop.Name:match("Meteor") or drop.Name:match("Seed") or drop.Name:match("Drop") then
                    local prompt = drop:FindFirstChildOfClass("ProximityPrompt") or (drop:FindFirstChild("ProximityPromptPart") and drop.ProximityPromptPart:FindFirstChildOfClass("ProximityPrompt"))
                    if not prompt then
                        for _, desc in ipairs(drop:GetDescendants()) do
                            if desc:IsA("ProximityPrompt") then
                                prompt = desc
                                break
                            end
                        end
                    end
                    
                    if prompt then
                        local char = LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            local rootPart = prompt.Parent:IsA("BasePart") and prompt.Parent or (drop:IsA("Model") and drop.PrimaryPart) or drop:FindFirstChildWhichIsA("BasePart") or (drop:IsA("BasePart") and drop)
                            if rootPart then
                                local origCFrame = char.HumanoidRootPart.CFrame
                                local success = SmartFly(rootPart.CFrame, function() return Options.AutoEventDrops end)
                                if success then
                                    char.HumanoidRootPart.Anchored = false
                                    task.wait(0.2)
                                    prompt.HoldDuration = 0
                                    fireproximityprompt(prompt)
                                    task.wait(1)
                                    SmartFly(origCFrame, function() return Options.AutoEventDrops end)
                                end
                                char.HumanoidRootPart.Anchored = false
                            end
                        end
                    end
                end
            end
        end
        
        if Options.AutoGnome then
            local gnomes = workspace:FindFirstChild("Gnomes")
            if gnomes then
                for _, gnome in ipairs(gnomes:GetChildren()) do
                    if gnome:GetAttribute("Owner") == LocalPlayer.Name then
                        Networking.Place.RemoveGnome:Fire(gnome)
                    end
                end
            end
        end
    end
end)

-- Pet Hook Integration Loop
local petsFolder = workspace:FindFirstChild("Pets")
if petsFolder then
    petsFolder.ChildAdded:Connect(function(pet)
        if Options.WebhookUrl ~= "" and tableContains(Options.WebhookPets, pet.Name) then
            pcall(function()
                local requestFn = (syn and syn.request) or (http and http.request) or request
                if requestFn then
                    requestFn({
                        Url = Options.WebhookUrl,
                        Method = "POST",
                        Headers = {["Content-Type"] = "application/json"},
                        Body = HttpService:JSONEncode({
                            content = "🚨 Rare Pet Spawned in Garden Horizon: **" .. pet.Name .. "**!"
                        })
                    })
                end
            end)
        end
    end)
end
