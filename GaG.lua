local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "👨🏿‍🌾 Grow a Garden Script 👩🏻‍🌾",
   Icon = 0,
   LoadingTitle = "🌱 Grow a Garden Script 🌿",
   LoadingSubtitle = "by Hadji",
   ShowText = "Rayfield",
   Theme = "Default",
   ToggleUIKeybind = "K",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = true,
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
      Note = "Join the Discord Server to get the key",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = true,
      Key = {"https://pastebin.com/raw/GpkZHNdm"} -- Correct way to list key link
   }
})

-- Tabs
local FarmTab = Window:CreateTab("Auto Farm", nil)
local ShopTab = Window:CreateTab("Shop", nil)
local PlayerTab = Window:CreateTab("Local Player", nil)
local MiscTab = Window:CreateTab("Misc", nil)

-- 🔄 Infinite Jump (Toggle)
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

-- 🔧 Auto submit cook
local autoSubmit = false

YourTab:CreateToggle({
    Name = "Auto Submit Held Plant",
    CurrentValue = false,
    Callback = function(Value)
        autoSubmit = Value
    end,
})

task.spawn(function()
    while true do
        if autoSubmit then
            local args = { "SubmitHeldPlant" }
            game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CookingPotService_RE"):FireServer(unpack(args))
        end
        task.wait(0.5)
    end
end)