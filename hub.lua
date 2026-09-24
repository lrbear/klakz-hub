-- 1. GitHub Bağlantılı Özel Key Ekranı
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("KlakzKeySystem") then
    CoreGui.KlakzKeySystem:Destroy()
end

local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "KlakzKeySystem"
KeyGui.Parent = CoreGui

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 320, 0, 180)
KeyFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = KeyGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 8)
KeyCorner.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.BackgroundTransparency = 1
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.Text = "Klakz Hub - Online Key (Orion)"
KeyTitle.TextSize = 16
KeyTitle.Font = Enum.Font.SourceSansBold
KeyTitle.Parent = KeyFrame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0.8, 0, 0, 40)
TextBox.Position = UDim2.new(0.1, 0, 0, 55)
TextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderText = "GitHub'daki key'i yazın..."
TextBox.Text = ""
TextBox.TextSize = 14
TextBox.Font = Enum.Font.SourceSans
TextBox.Parent = KeyFrame

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 6)
BoxCorner.Parent = TextBox

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.8, 0, 0, 40)
SubmitBtn.Position = UDim2.new(0.1, 0, 0, 110)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Text = "Key'i Kontrol Et"
SubmitBtn.TextSize = 14
SubmitBtn.Font = Enum.Font.SourceSansBold
SubmitBtn.Parent = KeyFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = SubmitBtn

-- Key Doğrulama (GitHub'dan çekerek)
SubmitBtn.MouseButton1Click:Connect(function()
    SubmitBtn.Text = "Kontrol Ediliyor..."
    
    local githubKeyUrl = "https://raw.githubusercontent.com/lrbear/klakz-hub/refs/heads/main/key.txt"
    
    local success, remoteKey = pcall(function()
        return game:HttpGet(githubKeyUrl)
    end)
    
    if success and remoteKey then
        remoteKey = remoteKey:gsub("%s+", "")
        local userInput = TextBox.Text:gsub("%s+", "")
        
        if userInput == remoteKey then
            KeyGui:Destroy()
            
            -- Orion Library Kütüphanesini Yükleme
            local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

            local Window = OrionLib:MakeWindow({
                Name = "Klakz Hub | Pro Edition",
                HidePremium = false,
                SaveConfig = true,
                ConfigFolder = "KlakzHubOrion",
                IntroText = "Klakz Hub Yükleniyor..."
            })

            -- 1. Scriptler Sekmesi
            local MainTab = Window:MakeTab({
                Name = "Scriptler",
                Icon = "rbxassetid://4483345998",
                PremiumOnly = false
            })

            MainTab:AddParagraph("Arama ve Filtreleme", "Aşağıdaki kutuya aradığın scriptin adını yazarak filtreleyebilirsin.")

            -- Dinamik Arama Kutusu (Textbox)
            local allScriptButtons = {}
            
            MainTab:AddTextbox({
                Name = "Script Ara...",
                Default = "",
                TextDisappear = false,
                Callback = function(Value)
                    local searchText = Value:lower()
                    for name, btnObj in pairs(allScriptButtons) do
                        if name:find(searchText) or searchText == "" then
                            btnObj.Visible = true
                        else
                            btnObj.Visible = false
                        end
                    end
                end
            })

            MainTab:AddParagraph("Dans Scriptleri", "Popüler FE dans menüleri.")

            local function registerButton(name, btnObject)
                allScriptButtons[name:lower()] = btnObject
            end

            local btn1 = MainTab:AddButton({
                Name = "Nothing Emotes (FE Dans Menüsü)",
                Callback = function()
                    pcall(function()
                        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Nothing-Emotes-FE-228521"))()
                    end)
                end,
            })
            registerButton("Nothing Emotes (FE Dans Menüsü)", btn1)

            MainTab:AddParagraph("Genel Scriptler", "Yararlı harici araçlar.")

            local btn2 = MainTab:AddButton({
                Name = "Infinite Yield (Admin) - Bakımda",
                Callback = function()
                    pcall(function()
                        loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Infinite%20Yield.lua"))()
                    end)
                end,
            })
            registerButton("Infinite Yield (Admin) - Bakımda", btn2)

            local btn3 = MainTab:AddButton({
                Name = "Speed / Araç Scripti",
                Callback = function()
                    pcall(function()
                        loadstring(game:HttpGet("https://obj.wearedevs.net/s/6a91b2ad9d49ace16dd83221.lua"))()
                    end)
                end,
            })
            registerButton("Speed / Araç Scripti", btn3)

            MainTab:AddParagraph("Oyun Scriptleri", "Oyuna özel özel scriptler.")

            local games = {
                {Name = "Be a NPC or DIE!", Url = "https://rawscripts.net/raw/FIRE-Be-NPC-or-DIE!-OP-Script-26413"},
                {Name = "1CutGrassAdventure", Url = "https://raw.githubusercontent.com/gumanba/Scripts/main/1CutGrassAdventure"},
                {Name = "Muscle Legends", Url = "https://raw.githubusercontent.com/ikzzz1444/Script/main/moonveil2.lua"},
                {Name = "Heroes RNG", Url = "https://raw.githubusercontent.com/gumanba/Scripts/main/HeroesRNG"},
                {Name = "+1 Strength to Grow Your Arm", Url = "https://raw.githubusercontent.com/gumanba/Scripts/main/1StrengthtoGrowYourArm"},
                {Name = "2Player Evolution Tycoon", Url = "https://raw.githubusercontent.com/gumanba/Scripts/main/2PLAYEREvolutionTycoon"},
                {Name = "Murders vs Sheriff", Url = "https://pastebin.com/raw/uZGr28ym"}
            }

            for _, gameInfo in ipairs(games) do
                local gameBtn = MainTab:AddButton({
                    Name = gameInfo.Name,
                    Callback = function()
                        pcall(function()
                            loadstring(game:HttpGet(gameInfo.Url))()
                        end)
                    end,
                })
                registerButton(gameInfo.Name, gameBtn)
            end

            -- 2. Oyuncu Sekmesi
            local PlayerTab = Window:MakeTab({
                Name = "Oyuncu & Dünya",
                Icon = "rbxassetid://4483345998",
                PremiumOnly = false
            })

            PlayerTab:AddSlider({
                Name = "Karakter Hızı (WalkSpeed)",
                Min = 16,
                Max = 250,
                Default = 16,
                Color = Color3.fromRGB(255,255,255),
                Increment = 1,
                ValueName = "Hız",
                Callback = function(Value)
                    pcall(function()
                        game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = Value
                    end)
                end,
            })

            PlayerTab:AddSlider({
                Name = "Zıplama Gücü (JumpPower)",
                Min = 50,
                Max = 300,
                Default = 50,
                Color = Color3.fromRGB(255,255,255),
                Increment = 1,
                ValueName = "Güç",
                Callback = function(Value)
                    pcall(function()
                        local humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid
                        humanoid.UseJumpPower = true
                        humanoid.JumpPower = Value
                    end)
                end,
            })

            PlayerTab:AddSlider({
                Name = "Görüş Açısı (FOV)",
                Min = 70,
                Max = 120,
                Default = 70,
                Color = Color3.fromRGB(255,255,255),
                Increment = 1,
                ValueName = "FOV",
                Callback = function(Value)
                    pcall(function()
                        workspace.CurrentCamera.FieldOfView = Value
                    end)
                end,
            })

            -- Fly (Uçma) Toggle
            local flying = false
            local flyConnection
            PlayerTab:AddToggle({
                Name = "Uçma (Fly)",
                Default = false,
                Callback = function(Value)
                    flying = Value
                    local player = game:GetService("Players").LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()
                    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
                    
                    if flying then
                        local bv = Instance.new("BodyVelocity")
                        bv.Name = "KlakzFlyVelocity"
                        bv.Parent = humanoidRootPart
                        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                        bv.Velocity = Vector3.new(0, 0, 0)
                        
                        local bg = Instance.new("BodyGyro")
                        bg.Name = "KlakzFlyGyro"
                        bg.Parent = humanoidRootPart
                        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                        
                        flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
                            if not flying then return end
                            local camera = workspace.CurrentCamera
                            bv.Velocity = camera.CFrame.LookVector * 50
                            bg.CFrame = camera.CFrame
                        end)
                    else
                        if flyConnection then flyConnection:Disconnect() end
                        if humanoidRootPart:FindFirstChild("KlakzFlyVelocity") then humanoidRootPart.KlakzFlyVelocity:Destroy() end
                        if humanoidRootPart:FindFirstChild("KlakzFlyGyro") then humanoidRootPart.KlakzFlyGyro:Destroy() end
                    end
                end,
            })

            -- Noclip Toggle
            local noclipEnabled = false
            local noclipConnection
            PlayerTab:AddToggle({
                Name = "Duvarlardan Geçme (Noclip)",
                Default = false,
                Callback = function(Value)
                    noclipEnabled = Value
                    local player = game:GetService("Players").LocalPlayer
                    
                    if noclipEnabled then
                        noclipConnection = game:GetService("RunService").Stepped:Connect(function()
                            if noclipEnabled and player.Character then
                                for _, part in pairs(player.Character:GetDescendants()) do
                                    if part:IsA("BasePart") and part.CanCollide then
                                        part.CanCollide = false
                                    end
                                end
                            end
                        end)
                    else
                        if noclipConnection then
                            noclipConnection:Disconnect()
                        end
                    end
                end,
            })

            -- Fullbright Toggle
            PlayerTab:AddToggle({
                Name = "Gece Görüşü (Fullbright)",
                Default = false,
                Callback = function(Value)
                    pcall(function()
                        local lighting = game:GetService("Lighting")
                        if Value then
                            lighting.Brightness = 2
                            lighting.ClockTime = 14
                            lighting.FogEnd = 100000
                            lighting.GlobalShadows = false
                        else
                            lighting.Brightness = 1
                            lighting.ClockTime = 0
                            lighting.GlobalShadows = true
                        end
                    end)
                end,
            })

            -- Click TP Toggle
            local clickTpEnabled = false
            local mouse = game:GetService("Players").LocalPlayer:GetMouse()
            PlayerTab:AddToggle({
                Name = "Click TP (Ctrl + Fare ile Işınlan)",
                Default = false,
                Callback = function(Value)
                    clickTpEnabled = Value
                end,
            })

            mouse.Button1Down:Connect(function()
                if clickTpEnabled and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
                    pcall(function()
                        local char = game:GetService("Players").LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
                        end
                    end)
                end
            end)

            -- Fling Butonu
            PlayerTab:AddButton({
                Name = "Fling (Yakınındakileri Fırlat)",
                Callback = function()
                    pcall(function()
                        local player = game:GetService("Players").LocalPlayer
                        local character = player.Character
                        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                        if not rootPart then return end
                        
                        local bav = Instance.new("BodyAngularVelocity")
                        bav.Name = "FlingVelocity"
                        bav.Parent = rootPart
                        bav.MaxTorque = Vector3.new(0, math.huge, 0)
                        bav.AngularVelocity = Vector3.new(0, 99999, 0)
                        
                        task.wait(0.5)
                        bav:Destroy()
                    end)
                end,
            })

            -- 3. Ayarlar Sekmesi
            local SettingsTab = Window:MakeTab({
                Name = "Ayarlar",
                Icon = "rbxassetid://6023426915",
                PremiumOnly = false
            })

            SettingsTab:AddDropdown({
                Name = "Arayüz Teması",
                Default = "Default",
                Options = {"Default", "Dark", "Blood", "Ocean", "Serenity"},
                Callback = function(Value)
                    pcall(function()
                        OrionLib:SetTheme(Value)
                    end)
                end,
            })

            local fpsConnection
            SettingsTab:AddToggle({
                Name = "FPS Göstergesi (Ekranın Köşesinde)",
                Default = false,
                Callback = function(Value)
                    if Value then
                        local CoreGui = game:GetService("CoreGui")
                        if not CoreGui:FindFirstChild("KlakzFPS") then
                            local FpsGui = Instance.new("ScreenGui")
                            FpsGui.Name = "KlakzFPS"
                            FpsGui.Parent = CoreGui
                            
                            local FpsLabel = Instance.new("TextLabel")
                            FpsLabel.Name = "FpsText"
                            FpsLabel.Size = UDim2.new(0, 100, 0, 30)
                            FpsLabel.Position = UDim2.new(0, 10, 0, 10)
                            FpsLabel.BackgroundTransparency = 0.5
                            FpsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                            FpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                            FpsLabel.TextSize = 14
                            FpsLabel.Font = Enum.Font.SourceSansBold
                            FpsLabel.Parent = FpsGui
                            
                            local RunService = game:GetService("RunService")
                            local lastUpdate = tick()
                            local frames = 0
                            
                            fpsConnection = RunService.RenderStepped:Connect(function()
                                frames = frames + 1
                                local now = tick()
                                if now - lastUpdate >= 1 then
                                    local fps = math.floor(frames / (now - lastUpdate))
                                    FpsLabel.Text = "FPS: " .. fps
                                    frames = 0
                                    lastUpdate = now
                                end
                            end)
                        end
                    else
                        if fpsConnection then
                            fpsConnection:Disconnect()
                            fpsConnection = nil
                        end
                        local CoreGui = game:GetService("CoreGui")
                        if CoreGui:FindFirstChild("KlakzFPS") then
                            CoreGui.KlakzFPS:Destroy()
                        end
                    end
                end,
            })

            SettingsTab:AddButton({
                Name = "Made in Turkey",
                Callback = function()
                    local chatSuccess = pcall(function()
                        game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("Made in Turkey")
                    end)
                    if not chatSuccess then
                        pcall(function()
                            game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer("Made in Turkey", "All")
                        end)
                    end
                end,
            })

            SettingsTab:AddButton({
                Name = "Bildirim Testi",
                Callback = function()
                    OrionLib:MakeNotification({
                        Title = "Klakz Hub",
                        Content = "Bildirim sistemi aktif ve sorunsuz çalışıyor!",
                        Image = "rbxassetid://4483345998",
                        Time = 5
                    })
                end,
            })

            OrionLib:Init()
        else
            SubmitBtn.Text = "Key'i Kontrol Et"
            TextBox.Text = ""
            TextBox.PlaceholderText = "Yanlış Key!"
        end
    else
        SubmitBtn.Text = "Key'i Kontrol Et"
        TextBox.PlaceholderText = "Bağlantı Hatası!"
    end
end)
