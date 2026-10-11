-- MAHIHUB V3 - FULL FITUR LIKE OTHER HUBS by mahikchv
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "MahiHub V3",
    SubTitle = "by mahikchv | PREMIUM",
    TabWidth = 130,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Farm = Window:AddTab({ Title = "Farm" }),
    Sea = Window:AddTab({ Title = "Sea Event" }),
    Combat = Window:AddTab({ Title = "Combat" }),
    Tele = Window:AddTab({ Title = "Teleport" }),
    ESP = Window:AddTab({ Title = "ESP" }),
    Misc = Window:AddTab({ Title = "Misc" })
}

-- GLOBALS
getgenv().AutoFarm = false
getgenv().FastAttack = false
getgenv().AutoBones = false
getgenv().AutoMastery = false
getgenv().BringMob = true

-- FUNGSI BRING MOB (BIAR MUSUH KUMPUL)
spawn(function()
    while task.wait(0.2) do
        if getgenv().BringMob then
            pcall(function()
                for _,v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 350 then
                            v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,10,5)
                            v.HumanoidRootPart.CanCollide = false
                            v.Humanoid.WalkSpeed = 0
                        end
                    end
                end
            end)
        end
    end
end)

-- 1. AUTO FARM LEVEL + QUEST
Tabs.Farm:AddToggle("AutoFarm", {
    Title = "Auto Farm Level (Auto Quest)",
    Default = false,
    Callback = function(v)
        getgenv().AutoFarm = v
        spawn(function()
            while getgenv().AutoFarm do
                pcall(function()
                    local quest = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetQuest")
                    if quest == "" or quest == nil then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", game.Players.LocalPlayer.Data.Level.Value)
                    end
                    for _,mob in pairs(workspace.Enemies:GetChildren()) do
                        if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and string.find(mob.Name, quest) or true then
                            repeat
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,12,0)
                                game:GetService("VirtualUser"):CaptureController()
                                game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
                                task.wait(0.15)
                            until not getgenv().AutoFarm or mob.Humanoid.Health <= 0
                        end
                    end
                end)
                task.wait(0.3)
            end
        end)
    end
})

Tabs.Farm:AddToggle("AutoBones", {
    Title = "Auto Farm Bones [Haunted Castle]",
    Default = false,
    Callback = function(v)
        getgenv().AutoBones = v
        spawn(function()
            while getgenv().AutoBones do
                pcall(function()
                    for _,mob in pairs(workspace.Enemies:GetChildren()) do
                        if string.find(mob.Name, "Reborn") or string.find(mob.Name, "Living Zombie") or string.find(mob.Name, "Demonic Soul") then
                            if mob.Humanoid.Health > 0 then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,10,3)
                                game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
                            end
                        end
                    end
                end)
                task.wait(0.2)
            end
        end)
    end
})

Tabs.Farm:AddToggle("AutoMastery", {
    Title = "Auto Farm Mastery (Equip Tool)",
    Default = false,
    Callback = function(v)
        getgenv().AutoMastery = v
        spawn(function()
            while getgenv().AutoMastery do
                pcall(function()
                    for _,mob in pairs(workspace.Enemies:GetChildren()) do
                        if mob.Humanoid.Health > 0 then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,10,3)
                            game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
                            task.wait(0.1)
                        end
                    end
                end)
                task.wait(0.2)
            end
        end)
    end
})

-- 2. COMBAT
Tabs.Combat:AddToggle("FastAtk", {
    Title = "Fast Attack (No Delay)",
    Default = false,
    Callback = function(v)
        getgenv().FastAttack = v
        spawn(function()
            while getgenv().FastAttack do
                pcall(function()
                    local m = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework)
                    m.activeController.timeToNextAttack = 0
                    m.activeController.hitboxMagnitude = 60
                    m.activeController.blocking = false
                    m.activeController.increment = 3
                end)
                task.wait(0.05)
            end
        end)
    end
})

Tabs.Combat:AddToggle("BringMob", { Title = "Bring Mob (Kumpulin Musuh)", Default = true, Callback = function(v) getgenv().BringMob = v end })
Tabs.Combat:AddToggle("NoClip", { Title = "No Clip", Default = false, Callback = function(v) getgenv().NoClip = v spawn(function() while getgenv().NoClip do pcall(function() for _,p in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end) task.wait(0.2) end end) end })

-- 3. TELEPORT
local Islands = {
    ["Middle Town"] = Vector3.new(-655,7,1430),
    ["Jungle"] = Vector3.new(-1240,6,385),
    ["Pirate Village"] = Vector3.new(-1120,4,3850),
    ["Desert"] = Vector3.new(1080,6,1290),
    ["Frozen Village"] = Vector3.new(1140,7,118
