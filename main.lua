-- MahiHub V2 FIX FINAL
local ok, Fluent = pcall(function() return loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))() end)
if not ok then warn("Fluent gagal load") return end

local Window = Fluent:CreateWindow({
    Title = "MahiHub",
    SubTitle = "by mahikchv",
    TabWidth = 130,
    Size = UDim2.fromOffset(450, 350),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main" }),
    Tele = Window:AddTab({ Title = "Teleport" })
}

Tabs.Main:AddButton({
    Title = "Test Tombol Work!",
    Callback = function()
        Fluent:Notify({ Title = "MahiHub", Content = "Tombol Work 100%!", Duration = 3 })
    end
})

Tabs.Tele:AddButton({
    Title = "Teleport to Middle Town",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-655, 7, 1430)
    end
})

Window:SelectTab(1)
Fluent:Notify({ Title = "MahiHub V2", Content = "UI Berhasil Muncul!", Duration = 4 })
