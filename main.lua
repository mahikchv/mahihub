-- -- MahiHub V2 FIX by mahikchv
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "MahiHub V2",
    SubTitle = "by mahikchv",
    TabWidth = 120,
    Size = UDim2.fromOffset(480, 360),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "swords" }),
    Tele = Window:AddTab({ Title = "Teleport", Icon = "map" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "box" })
}

getgenv().AF = false
getgenv().Fast = false

Tabs.Main:AddToggle("AF", {
    Title = "Auto Farm Level",
    Default = false,
    Callback = function(v)
        getgenv().AF = v
        spawn(function()
            while getgenv().AF do
                pcall(function()
                    for _, mob in pairs(workspace.Enemies:GetChildren()) do
                        if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,10,2)
                            game:GetService("VirtualUser"):CaptureController()
                            game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
                            task.wait(0.2)
                        end
                    end
                end)
                task.wait(0.2)
            end
        end)
    end
})

Tabs.Main:AddToggle("Fast", {
    Title = "Fast Attack",
    Default = false,
    Callback = function(v)
        getgenv().Fast = v
        spawn(function()
            while getgenv().Fast do
                pcall(function()
                    local m = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework)
                    m.activeController.timeToNextAttack = 0
                    m.activeController.hitboxMagnitude = 60
                end)
                task.wait(0.1)
            end
        end)
    end
})

Tabs.Tele:AddButton({
    Title = "Teleport to Sea 3",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5058, 314, -3150)
    end
})

Tabs.Misc:AddButton({
    Title = "Redeem Codes",
    Callback = function()
        local codes = {"VEGGIE10","15B_BESTBROTHERS","KITT_RESET"}
        for _,c in pairs(codes) do
            pcall(function() game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(c) end)
        end
    end
})

Window:SelectTab(1)
Fluent:Notify({ Title = "MahiHub", Content = "Loaded! by mahikchv", Duration = 4 })
print("MahiHub V2 Loaded")
