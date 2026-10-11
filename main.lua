
-- MAHIHUB V3.1 FINAL FIX - 100% WORK DI LING
pcall(function()
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    
    local Window = Fluent:CreateWindow({
        Title = "MahiHub V3.1",
        SubTitle = "by mahikchv",
        TabWidth = 120,
        Size = UDim2.fromOffset(500, 400),
        Acrylic = false,
        Theme = "Dark",
        MinimizeKey = Enum.KeyCode.LeftControl
    })
    
    local Tabs = {
        Farm = Window:AddTab({ Title = "Farm", Icon = "" }),
        Combat = Window:AddTab({ Title = "Combat", Icon = "" }),
        Tele = Window:AddTab({ Title = "Teleport", Icon = "" }),
        Misc = Window:AddTab({ Title = "Misc", Icon = "" })
    }
    
    getgenv().AF = false
    getgenv().FA = false
    
    Tabs.Farm:AddToggle("AF", {
        Title = "Auto Farm Level",
        Default = false,
        Callback = function(v)
            getgenv().AF = v
            task.spawn(function()
                while getgenv().AF do
                    pcall(function()
                        for _,mob in pairs(workspace.Enemies:GetChildren()) do
                            if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,10,3)
                                game:GetService("VirtualUser"):CaptureController()
                                game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
                                task.wait(0.2)
                            end
                        end
                    end)
                    task.wait(0.5)
                end
            end)
        end
    })
    
    Tabs.Farm:AddToggle("Bones", {
        Title = "Auto Farm Bones",
        Default = false,
        Callback = function(v)
            getgenv().Bones = v
            task.spawn(function()
                while getgenv().Bones do
                    pcall(function()
                        for _,mob in pairs(workspace.Enemies:GetChildren()) do
                            if mob.Name:find("Reborn") or mob.Name:find("Zombie") or mob.Name:find("Demonic") then
                                if mob.Humanoid.Health > 0 then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,10,3)
                                    game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
                                end
                            end
                        end
                    end)
                    task.wait(0.3)
                end
            end)
        end
    })
    
    Tabs.Combat:AddToggle("FA", {
        Title = "Fast Attack",
        Default = false,
        Callback = function(v)
            getgenv().FA = v
            task.spawn(function()
                while getgenv().FA do
                    pcall(function()
                        local cf = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework)
                        if cf.activeController then
                            cf.activeController.timeToNextAttack = 0
                            cf.activeController.hitboxMagnitude = 60
                        end
                    end)
                    task.wait(0.1)
                end
            end)
        end
    })
    
    Tabs.Tele:AddButton({ Title = "Middle Town", Callback = function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-655,7,1430) end })
    Tabs.Tele:AddButton({ Title = "Haunted Castle (Bones)", Callback = function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9517,142,5528) end })
    Tabs.Tele:AddButton({ Title = "Sea 3 Port", Callback = function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5058,314,-3150) end })
    
    Tabs.Misc:AddButton({
        Title = "Redeem All Codes",
        Callback = function()
            local codes = {"VEGGIE10","15B_BESTBROTHERS","KITT_RESET","3BVISITS","UPD20","UPD21","SUB2CAPTAINMAUI","Enyu_is_Pro","Magicbus","JCWK","Starcodeheo","Bluxxy","FUDD10","THEGREATACE","SUB2GAMERROBOT_EXP1","BIGNEWS"}
            for _,c in pairs(codes) do pcall(function() game.ReplicatedStorage.Remotes.Redeem:InvokeServer(c) end) end
        end
    })
    
    Window:SelectTab(1)
    Fluent:Notify({ Title = "MahiHub", Content = "V3.1 Loaded - by mahikchv", Duration = 5 })
end)
