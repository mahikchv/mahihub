-- MAHIHUB V3.2 - FIXED FARM by mahikchv
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MahiHub V3.2 FIXED",
   LoadingTitle = "MahiHub",
   LoadingSubtitle = "by mahikchv - Fixed Farm",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

local FarmTab = Window:CreateTab("Farm", 4483362458)
local CombatTab = Window:CreateTab("Combat", 4483362458)
local TeleTab = Window:CreateTab("Teleport", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)

getgenv().AF = false
getgenv().FA = false
getgenv().BM = true

-- ANTI AFK + BRING MOB LOOP
task.spawn(function()
    while task.wait(0.2) do
        pcall(function()
            if getgenv().BM and getgenv().AF then
                for _,v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 400 then
                            v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,10,0)
                            v.HumanoidRootPart.CanCollide = false
                            v.Humanoid.WalkSpeed = 0
                            v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                        end
                    end
                end
            end
        end)
    end
end)

-- FAST ATTACK FIX
CombatTab:CreateToggle({
   Name = "Fast Attack [WAJIB ON]",
   CurrentValue = false,
   Callback = function(v)
       getgenv().FA = v
       task.spawn(function()
           while getgenv().FA do
               pcall(function()
                   local ac = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework).activeController
                   if ac and ac.equipped then
                       ac.timeToNextAttack = 0
                       ac.hitboxMagnitude = 60
                       ac.increment = 3
                   end
               end)
               task.wait(0.05)
           end
       end)
   end,
})

CombatTab:CreateToggle({ Name = "Bring Mob (Biar Gak Mental)", CurrentValue = true, Callback = function(v) getgenv().BM = v end })

-- AUTO FARM LEVEL YANG BENER
FarmTab:CreateToggle({
   Name = "Auto Farm Level [FIXED]",
   CurrentValue = false,
   Callback = function(v)
       getgenv().AF = v
       task.spawn(function()
           while getgenv().AF do
               pcall(function()
                   -- auto equip sword
                   local char = game.Players.LocalPlayer.Character
                   if not char:FindFirstChildOfClass("Tool") then
                       for _,tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                           if tool:IsA("Tool") then
                               char.Humanoid:EquipTool(tool)
                               break
                           end
                       end
                   end
                   -- cari musuh
                   local nearest, dist = nil, math.huge
                   for _,mob in pairs(workspace.Enemies:GetChildren()) do
                       if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                           local d = (char.HumanoidRootPart.Position - mob.HumanoidRootPart.Position).Magnitude
                           if d < dist then dist = d nearest = mob end
                       end
                   end
                   if nearest then
                       char.HumanoidRootPart.CFrame = nearest.HumanoidRootPart.CFrame * CFrame.new(0,12,2)
                       game:GetService("VirtualUser"):CaptureController()
                       game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
                   end
               end)
               task.wait(0.15)
           end
       end)
   end,
})

FarmTab:CreateToggle({
   Name = "Auto Farm Bones [FIXED]",
   CurrentValue = false,
   Callback = function(v)
       getgenv().Bones = v
       task.spawn(function()
           while getgenv().Bones do
               pcall(function()
                   for _,mob in pairs(workspace.Enemies:GetChildren()) do
                       if mob.Name:find("Reborn") or mob.Name:find("Living Zombie") or mob.Name:find("Demonic Soul") or mob.Name:find("Posessed Mummy") then
                           if mob.Humanoid.Health > 0 then
                               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,10,0)
                               game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
                               break
                           end
                       end
                   end
               end)
               task.wait(0.2)
           end
       end)
   end,
})

-- TELEPORT
TeleTab:CreateButton({ Name = "Middle Town", Callback = function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-655,7,1430) end })
TeleTab:CreateButton({ Name = "Haunted Castle", Callback = function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9517,142,5528) end })
TeleTab:CreateButton({ Name = "Port Town Sea 3", Callback = function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5058,314,-3150) end })
TeleTab:CreateButton({ Name = "Bones Shop (Death King)", Callback = function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9517,142,5528) game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9500, 172, 6078) end })

MiscTab:CreateButton({
   Name = "Redeem Codes",
   Callback = function()
       for _,c in pairs({"VEGGIE10","15B_BESTBROTHERS","KITT_RESET","3BVISITS","UPD20","UPD21","SUB2CAPTAINMAUI","Enyu_is_Pro","Magicbus"}) do
           pcall(function() game.ReplicatedStorage.Remotes.Redeem:InvokeServer(c) end)
       end
   end,
})

Rayfield:Notify({ Title = "MahiHub V3.2", Content = "Fixed Farm Loaded!", Duration = 4 })
