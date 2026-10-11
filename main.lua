-- MAHIHUB V3 RAYFIELD - ANTI BLANK
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MahiHub V3 by mahikchv",
   LoadingTitle = "MahiHub Loading",
   LoadingSubtitle = "by mahikchv",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

local FarmTab = Window:CreateTab("Farm", 4483362458)
local CombatTab = Window:CreateTab("Combat", 4483362458)
local TeleTab = Window:CreateTab("Teleport", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)

getgenv().AF = false
getgenv().FA = false
getgenv().Bones = false

-- AUTO FARM
FarmTab:CreateToggle({
   Name = "Auto Farm Level",
   CurrentValue = false,
   Callback = function(v)
       getgenv().AF = v
       task.spawn(function()
           while getgenv().AF do
               pcall(function()
                   for _,mob in pairs(workspace.Enemies:GetChildren()) do
                       if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,10,0)
                           game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
                       end
                   end
               end)
               task.wait(0.3)
           end
       end)
   end,
})

FarmTab:CreateToggle({
   Name = "Auto Farm Bones",
   CurrentValue = false,
   Callback = function(v)
       getgenv().Bones = v
       task.spawn(function()
           while getgenv().Bones do
               pcall(function()
                   for _,mob in pairs(workspace.Enemies:GetChildren()) do
                       if mob.Name:find("Reborn") or mob.Name:find("Zombie") then
                           if mob.Humanoid.Health > 0 then
                               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,8,0)
                               game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
                           end
                       end
                   end
               end)
               task.wait(0.3)
           end
       end)
   end,
})

CombatTab:CreateToggle({
   Name = "Fast Attack",
   CurrentValue = false,
   Callback = function(v)
       getgenv().FA = v
       task.spawn(function()
           while getgenv().FA do
               pcall(function()
                   local m = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework)
                   if m.activeController then
                       m.activeController.timeToNextAttack = 0
                       m.activeController.hitboxMagnitude = 55
                   end
               end)
               task.wait(0.1)
           end
       end)
   end,
})

TeleTab:CreateButton({ Name = "Teleport to Middle Town", Callback = function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-655,7,1430) end })
TeleTab:CreateButton({ Name = "Teleport to Haunted Castle", Callback = function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9517,142,5528) end })
TeleTab:CreateButton({ Name = "Teleport to Port Town Sea 3", Callback = function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5058,314,-3150) end })

MiscTab:CreateButton({
   Name = "Redeem All Codes",
   Callback = function()
       for _,c in pairs({"VEGGIE10","15B_BESTBROTHERS","KITT_RESET","3BVISITS","UPD20","UPD21","SUB2CAPTAINMAUI"}) do
           pcall(function() game.ReplicatedStorage.Remotes.Redeem:InvokeServer(c) end)
       end
       Rayfield:Notify({ Title = "MahiHub", Content = "Codes Redeemed!", Duration = 3 })
   end,
})

Rayfield:Notify({ Title = "MahiHub V3", Content = "Loaded! by mahikchv", Duration = 5 })
