-- MahiHub by mahikchv
loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()(function()
local Fluent=Fluent local Window=Fluent:CreateWindow({Title="MahiHub",SubTitle="by mahikchv",TabWidth=120,Size=UDim2.fromOffset(480,340),Acrylic=true,Theme="Dark"})
local Tab=Window:AddTab({Title="Main",Icon="box"})
getgenv().AF=false
function farm() spawn(function() while getgenv().AF do pcall(function() for _,v in pairs(workspace.Enemies:GetChildren()) do if v:FindFirstChild("Humanoid") and v.Humanoid.Health>0 then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=v.HumanoidRootPart.CFrame*CFrame.new(0,10,0) game.VirtualUser:CaptureController() game.VirtualUser:ClickButton1(Vector2.new(0,0)) end end end) wait(0.15) end end) end
Tab:AddToggle("Farm",{Title="Auto Farm Level",Default=false,Callback=function(a) getgenv().AF=a if a then farm() end end})
Fluent:Notify({Title="MahiHub",Content="Loaded!",Duration=3})
end)()
