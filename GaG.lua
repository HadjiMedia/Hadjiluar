local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "👨🏿‍🌾 Grow a Garden Script 👩🏻‍🌾",
   Icon = 0,
   LoadingTitle = "👩🏻‍🌾 Grow a Garden Script 👨🏿‍🌾",
   LoadingSubtitle = "by Hadji",
   ShowText = "Rayfield",
   Theme = "Default",

   ToggleUIKeybind = "K",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
 ok     Enabled = true,
      FolderName = nil,
      FileName = "GAG"
   },

   Discord = {
      Enabled = false,
      Invite = "Hadji",
      RememberJoins = true
   },

   KeySystem = true,
   KeySettings = {
      Title = "Grow a Garden | Key",
      Subtitle = "Key System",
      Note = "Join to Discord Server for key",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = true,
      Key = {"https://pastebin.com/raw/GpkZHNdm"}
   }
})

local FarmTab = Window:CreateTab("Auto Farm", nil)
local ShopTab = Window:CreateTab("Shop", nil)
local PlayerTab = Window:CreateTab("Local Player", nil)
local MiscTab = Window:CreateTab("Misc", nil)

-- ✅ Infinite Jump Button (Fixed)
local Button = PlayerTab:CreateButton({
    Name = "Infinite Jump",
    Callback = function()
        _G.infinjump = true
        local UIS = game:GetService("UserInputService")
        local Players = game:GetService("Players")
        local LP = Players.LocalPlayer

        -- Wait until the character and humanoid are fully loaded
        repeat wait() until LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")

        -- Prevent duplicate connections
        if not _G._infJumpConnection then
            _G._infJumpConnection = UIS.JumpRequest:Connect(function()
                if _G.infinjump then
                    local humanoid = LP.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end)
        end
    end,
})



local selectedRecipe = "Reclaimer"
local autoCraft = false

FarmTab:CreateDropdown({
   Name = "Select Recipe",
   Options = {"Reclaimer", "Small Toy", "Anti Bee Egg"},
   CurrentOption = "Reclaimer",
   Callback = function(option)
      selectedRecipe = option
   end,
})

FarmTab:CreateToggle({
   Name = "Auto Craft",
   CurrentValue = false,
   Callback = function(state)
      autoCraft = state
      if autoCraft then
         task.spawn(function()
            while autoCraft do
               local station = workspace:WaitForChild("CraftingTables"):WaitForChild("EventCraftingWorkBench")
               local service = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService")

               -- Set Recipe
               service:FireServer("SetRecipe", station, "GearEventWorkbench", selectedRecipe)
               wait(0.3)

               -- Submit Item (FIXED!)
               service:FireServer("SubmitHeldItemForCrafting", station)
               wait(0.3)

               -- Craft
               service:FireServer("Craft", station, "GearEventWorkbench")
               wait(2)
            end
         end)
      end
   end,
})