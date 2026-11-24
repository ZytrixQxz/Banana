-- ============================================================
-- VXEZE HUB — BLOX FRUIT KAITUN
-- Cleaned pass: shadowing fixes, UUID arg fix, CFrame.Position
-- fix, RandomArguments off-by-one, pcall guards on spawns.
-- All variable names / remote paths / queue ids preserved.
-- ============================================================

repeat task.wait() until game:IsLoaded()

getgenv().Premium       = false
getgenv().Hide_UI       = false
getgenv().Team          = "Marines"
getgenv().Studio        = {
    ["Blox Fruit"] = {
        ["Sub"] = {
            ["Pull Lever"] = true,
            ["Sniper Fruit"] = {
                ["Enabled"] = false,
                ["Fruit"]   = { "Tiger-Tiger", "Kitsune-Kitsune", "Dragon-Dragon", "Yeti-Yeti", "Gas-Gas" },
            },
            ["Setting Player"] = {
                ["Lock Fps"] = { ["Enabled"] = false, ["FPS"] = 20 },
                ["Hop When Idle"] = true,
                ["Hop"] = { ["Enable"] = false, ["Delay"] = 5 },
                ["Select Hop"] = {
                    ["Hop Find Full Moon"]   = true,
                    ["Hop Find Rip Indra"]   = true,
                    ["Hop Find Dough King"]  = false,
                    ["Hop Find Cake Queen"]  = true,
                    ["Hop Find Soul Reaper"] = true,
                    ["Hop Find Darkbeard"]   = true,
                    ["Hop Find Raid Castle"] = true,
                },
            },
        },
        ["Items"] = {
            ["Material"] = { ["Dark Fragments"] = true, ["Mirror Fractal"] = true },
            ["Melee"]    = { ["Fighting Style"]  = true },
            ["Sword"]    = { ["Saber"] = true, ["Cursed Dual Katana"] = true },
            ["Gun"]      = { ["Skull Guitar"] = true },
        },
        ["Webhook"] = {
            ["Url"]         = "https://discord.com/api/webhooks/1455563179487657986/jKkWXzNwoCJX0IMK2RvrVah-Rx_xlF90Kq9dTMU5R567WgqWIRfUacUiy1n6cTThQ21D",
            ["Delay"]       = 60,
            ["Ping Notify"] = "",
        },
    },
}

repeat
    task.wait()
    if game.Players.LocalPlayer.Team == nil then
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", getgenv().Team)
    end
until game.Players.LocalPlayer.Character

-- ============================================================
local function _nguoitinhcuae()
    if getgenv()._vxeze_running then return end
    getgenv()._vxeze_running = true
    local timeee = os.time()

    -- FPS cap loop
    task.spawn(function()
        while true do
            local cap = getgenv().Studio["Blox Fruit"]["Sub"]["Setting Player"]["Lock Fps"]["FPS"]
            if getfpscap() > cap then setfpscap(cap or 60) end
            task.wait(1)
        end
    end)

    -- --------------------------------------------------------
    -- Utility: comma-formatted number
    -- --------------------------------------------------------
    local function Price(x)
        local v = tostring(x)
        while true do
            local k
            v, k = v:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
            if k == 0 then break end
        end
        return v
    end

    local HttpService = game:GetService("HttpService")

    -- --------------------------------------------------------
    -- Hop helpers
    -- --------------------------------------------------------
    local function Hop(minPlayers, region)
        if type(minPlayers) == "string" then
            region    = minPlayers
            minPlayers = nil
        end
        local ok, result = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(
                "https://games.roblox.com/v1/games/" .. game.PlaceId ..
                "/servers/Public?sortOrder=Asc&limit=100"))
        end)
        if not ok or not result or type(result.data) ~= "table" then return end
        for _, v in ipairs(result.data) do
            if type(v) == "table" and v.playing and v.maxPlayers and v.id then
                local regionMatch      = not region      or v.region  == region
                local playerCountMatch = not minPlayers  or v.playing <= minPlayers
                if v.playing < v.maxPlayers and regionMatch and playerCountMatch and v.id ~= game.JobId then
                    pcall(function()
                        game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", v.id)
                    end)
                    task.wait(5)
                    return
                end
            end
        end
    end

    local function LowHop(region)
        region = region or "Singapore"
        local allServers = {}
        local cursor     = ""
        for _ = 1, 5 do
            local url = "https://games.roblox.com/v1/games/" .. game.PlaceId ..
                        "/servers/Public?sortOrder=Asc&limit=100"
            if cursor ~= "" then url = url .. "&cursor=" .. cursor end
            local ok, result = pcall(function()
                return HttpService:JSONDecode(game:HttpGet(url))
            end)
            if not ok or not result or type(result.data) ~= "table" then break end
            for _, v in ipairs(result.data) do table.insert(allServers, v) end
            cursor = result.nextPageCursor
            if not cursor then break end
        end
        -- First pass: region + low-pop
        for _, v in ipairs(allServers) do
            if type(v) == "table" and v.playing and v.maxPlayers and v.id then
                if v.playing < v.maxPlayers and v.playing <= 10 and v.region == region and v.id ~= game.JobId then
                    pcall(function()
                        game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", v.id)
                    end)
                    task.wait(5)
                    return
                end
            end
        end
        -- Second pass: any low-pop
        for _, v in ipairs(allServers) do
            if type(v) == "table" and v.playing and v.maxPlayers and v.id then
                if v.playing < v.maxPlayers and v.playing <= 10 and v.id ~= game.JobId then
                    pcall(function()
                        game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", v.id)
                    end)
                    task.wait(5)
                    return
                end
            end
        end
    end

    -- --------------------------------------------------------
    -- External decoder — guarded so a nil return never throws
    -- --------------------------------------------------------
    local Decoder = select(2, pcall(function()
        return loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/Dex-Bear/VxezeHubTrollKick/refs/heads/main/ngu.lua"))()
    end))
    if type(Decoder) ~= "table" then Decoder = nil end

    local TeleportService = game:GetService("TeleportService")
    local Players         = game:GetService("Players")

    -- --------------------------------------------------------
    -- Place-id tables
    -- --------------------------------------------------------
    local loz = {
        EmGke1      = { [2753915549] = true,  [85211729168715]  = true },
        EmGke2      = { [4442272183] = true,  [79091703265657]  = true },
        EmGke3      = { [7449423635] = true,  [100117331123089] = true },
        EmGkedacbiet = { [73902483975735] = true },
    }
    local okmngu    = game.PlaceId
    local locplaceid = {}
    for _, bucu in pairs(loz) do
        if bucu[okmngu] then locplaceid = bucu; break end
    end
    if not next(locplaceid) then locplaceid = { [okmngu] = true } end

    -- --------------------------------------------------------
    -- Duma — server-hop finder with in-flight guard + cooldown
    -- --------------------------------------------------------
    local DumaInFlight     = false
    local DumaRecentlyFailed = {}
    local DumaImpl
    local function Duma(cailoz)
        if not cailoz       then return false end
        if DumaInFlight     then return false end
        DumaInFlight = true
        local ok, result = pcall(function() return DumaImpl(cailoz) end)
        DumaInFlight = false
        return ok and result
    end
    DumaImpl = function(cailoz)
        local concac = cailoz:gsub(" ", "%%20")
        local url    = "https://raw.banana-hub.xyz/api/data/recent?name=" .. concac .. "&limit=1000"
        local suc, res = pcall(function()
            return request({
                Url     = url,
                Method  = "GET",
                Headers = { ["User-Agent"] = "BananaHub-Ngu", ["Content-Type"] = "application/json" },
            })
        end)
        if not suc or not res.Success then return false end
        local data = HttpService:JSONDecode(res.Body)
        for _, v in pairs(data.data) do
            if v.Players and v.Players >= 2 and locplaceid[v.placeid] then
                local decoded_jobid = v.jobid
                if Decoder and Decoder.decode then
                    pcall(function()
                        decoded_jobid = Decoder.decode(v.jobid)
                        SetStatus("Decode JobId | " .. decoded_jobid)
                        print("Decode JobID: " .. decoded_jobid)
                    end)
                end
                if decoded_jobid and decoded_jobid ~= "" and decoded_jobid ~= game.JobId
                    and (os.time() - (DumaRecentlyFailed[decoded_jobid] or 0)) > 60 then
                    DumaRecentlyFailed[decoded_jobid] = os.time()
                    pcall(function()
                        game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", decoded_jobid)
                    end)
                    task.wait(3)
                    return true
                end
            end
        end
        return false
    end

    -- --------------------------------------------------------
    -- Auto-dismiss "Server is full" popups
    -- --------------------------------------------------------
    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                local rg     = game.CoreGui:FindFirstChild("RobloxGui")
                local popup  = rg and rg:FindFirstChild("PopupFrame")
                local okBtn  = popup and popup:FindFirstChild("PopupOKButton")
                if okBtn and popup.Visible then firesignal(okBtn.MouseButton1Click) end
            end)
        end
    end)

    -- --------------------------------------------------------
    -- NoClip — skips while seated so boat welds aren't fought
    -- --------------------------------------------------------
    getgenv().NoClip = true
    game:GetService("RunService").Stepped:Connect(function()
        pcall(function()
            local char = game.Players.LocalPlayer.Character
            if not (char and char:FindFirstChild("Head") and char:FindFirstChild("HumanoidRootPart")) then return end
            local hum    = char:FindFirstChildWhichIsA("Humanoid")
            local seated = hum and hum.SeatPart ~= nil
            if getgenv().NoClip and not seated then
                if not char.Head:FindFirstChild("BodyClip") then
                    local bv       = Instance.new("BodyVelocity")
                    bv.Name        = "BodyClip"
                    bv.Velocity    = Vector3.new(0, 0, 0)
                    bv.MaxForce    = Vector3.new(math.huge, math.huge, math.huge)
                    bv.P           = 15000
                    bv.Parent      = char.Head
                end
                for _, v in ipairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            else
                local clip = char.Head:FindFirstChild("BodyClip")
                if clip then clip:Destroy() end
                for _, v in ipairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = true end
                end
            end
        end)
    end)

    -- --------------------------------------------------------
    -- File I/O helpers
    -- --------------------------------------------------------
    local function WriteData(filename, content)
        if not isfolder("VxezeHub") then makefolder("VxezeHub") end
        writefile("VxezeHub/" .. filename, content)
    end

    local function WriteMeleeData(data)
        if not isfolder("Data_VxezeHub") then makefolder("Data_VxezeHub") end
        local ok, encoded = pcall(function() return HttpService:JSONEncode(data) end)
        if ok then writefile("Data_VxezeHub/Melee_Data.json", encoded) end
    end

    local function ReadMeleeData()
        if not isfile("Data_VxezeHub/Melee_Data.json") then return {} end
        local ok, data = pcall(function()
            return HttpService:JSONDecode(readfile("Data_VxezeHub/Melee_Data.json"))
        end)
        return (ok and type(data) == "table") and data or {}
    end

    -- --------------------------------------------------------
    -- UI — loader screen
    -- --------------------------------------------------------
    local _lblMainTask, _lblSubTask, _lblCurrencies, _lblMelees
    local SetStatus

    if not getgenv().Hide_UI then
        local TweenService = game:GetService("TweenService")
        local Lighting     = game:GetService("Lighting")
        local player       = game.Players.LocalPlayer
        local blur         = Instance.new("BlurEffect", Lighting)
        blur.Size          = 0
        TweenService:Create(blur, TweenInfo.new(0.5), { Size = 40 }):Play()
        task.delay(2, function() if blur then blur:Destroy() end end)

        local screenGui              = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
        screenGui.Name               = "VxezeLoader"
        screenGui.ResetOnSpawn       = false
        screenGui.IgnoreGuiInset     = true

        local frame                  = Instance.new("Frame", screenGui)
        frame.Size                   = UDim2.new(1, 0, 1, 0)
        frame.BackgroundTransparency = 1

        local bg                     = Instance.new("Frame", frame)
        bg.Size                      = UDim2.new(1, 0, 1, 0)
        bg.BackgroundColor3          = Color3.fromRGB(5, 5, 10)
        bg.BackgroundTransparency    = 1
        TweenService:Create(bg, TweenInfo.new(0.5), { BackgroundTransparency = 0.2 }):Play()

        local function getTitleScale()
            local s = workspace.CurrentCamera.ViewportSize
            return math.clamp(math.min(s.X, s.Y) / 600, 0.3, 0.5)
        end

        local gradColor = ColorSequence.new({
            ColorSequenceKeypoint.new(0,   Color3.fromRGB(0,   191, 255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 200, 255)),
            ColorSequenceKeypoint.new(1,   Color3.fromRGB(200, 200, 200)),
        })
        local statusGradColor = ColorSequence.new({
            ColorSequenceKeypoint.new(0,   Color3.fromRGB(160, 180, 220)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(190, 200, 230)),
            ColorSequenceKeypoint.new(1,   Color3.fromRGB(210, 210, 220)),
        })

        local function makeLabel(parent, pos, size)
            local t                      = Instance.new("TextLabel", parent)
            t.Font                       = Enum.Font.FredokaOne
            t.TextColor3                 = Color3.fromRGB(255, 255, 255)
            t.TextStrokeColor3           = Color3.fromRGB(0, 100, 150)
            t.TextStrokeTransparency     = 0.3
            t.TextTransparency           = 1
            t.BackgroundTransparency     = 1
            t.Position                   = pos
            t.Size                       = size
            t.TextScaled                 = true
            local g                      = Instance.new("UIGradient", t)
            g.Color                      = gradColor
            g.Rotation                   = 90
            return t
        end

        local function makeStatusLabel(parent, pos, size)
            local t                  = Instance.new("TextLabel", parent)
            t.Font                   = Enum.Font.FredokaOne
            t.TextColor3             = Color3.fromRGB(230, 230, 250)
            t.TextTransparency       = 1
            t.BackgroundTransparency = 1
            t.Position               = pos
            t.Size                   = size
            t.TextScaled             = true
            t.TextXAlignment         = Enum.TextXAlignment.Center
            t.TextYAlignment         = Enum.TextYAlignment.Center
            local g                  = Instance.new("UIGradient", t)
            g.Color                  = statusGradColor
            g.Rotation               = 90
            return t
        end

        local logo             = Instance.new("ImageLabel", frame)
        logo.Image             = "rbxassetid://104363488394469"
        logo.BackgroundTransparency = 1
        logo.AnchorPoint       = Vector2.new(0.5, 0.5)
        logo.Position          = UDim2.new(0.5, 0, 0.3, 0)
        logo.Size              = UDim2.new(getTitleScale(), 0, getTitleScale(), 0)
        logo.ImageTransparency = 1
        Instance.new("UIAspectRatioConstraint", logo).AspectRatio = 1
        TweenService:Create(logo, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { ImageTransparency = 0 }):Play()

        local titleText          = makeLabel(frame, UDim2.new(0.5, 0, 0.48, 0), UDim2.new(0.48, 0, 0.08, 0))
        titleText.Text           = "Vxeze Hub"
        titleText.AnchorPoint    = Vector2.new(0.5, 0.5)
        TweenService:Create(titleText, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { TextTransparency = 0 }):Play()

        local statusText         = makeStatusLabel(frame, UDim2.new(0.5, 0, 0.60, 0), UDim2.new(0.52, 0, 0.038, 0))
        statusText.Text          = "Loading..."
        statusText.AnchorPoint   = Vector2.new(0.5, 0.5)
        statusText.TextTransparency = 1
        _lblMainTask             = statusText

        local subTaskText        = makeStatusLabel(frame, UDim2.new(0.5, 0, 0.69, 0), UDim2.new(0.50, 0, 0.034, 0))
        subTaskText.Text         = ""
        subTaskText.AnchorPoint  = Vector2.new(0.5, 0.5)
        subTaskText.TextTransparency = 1
        _lblSubTask              = subTaskText

        local currencyLabel                  = Instance.new("TextLabel", frame)
        currencyLabel.Font                   = Enum.Font.FredokaOne
        currencyLabel.TextColor3             = Color3.fromRGB(220, 220, 240)
        currencyLabel.TextTransparency       = 0.1
        currencyLabel.BackgroundTransparency = 1
        currencyLabel.AnchorPoint            = Vector2.new(0.5, 0.5)
        currencyLabel.Position               = UDim2.new(0.5, 0, 0.79, 0)
        currencyLabel.Size                   = UDim2.new(0.78, 0, 0.034, 0)
        currencyLabel.TextXAlignment         = Enum.TextXAlignment.Center
        currencyLabel.TextScaled             = true
        currencyLabel.RichText               = true
        currencyLabel.Text                   = ""
        _lblCurrencies                       = currencyLabel

        local meleeLabel                  = Instance.new("TextLabel", frame)
        meleeLabel.Font                   = Enum.Font.FredokaOne
        meleeLabel.TextColor3             = Color3.fromRGB(200, 180, 255)
        meleeLabel.TextTransparency       = 0.1
        meleeLabel.BackgroundTransparency = 1
        meleeLabel.AnchorPoint            = Vector2.new(0.5, 0.5)
        meleeLabel.Position               = UDim2.new(0.5, 0, 0.88, 0)
        meleeLabel.Size                   = UDim2.new(0.70, 0, 0.034, 0)
        meleeLabel.TextXAlignment         = Enum.TextXAlignment.Center
        meleeLabel.TextScaled             = true
        meleeLabel.RichText               = true
        meleeLabel.Text                   = ""
        _lblMelees                        = meleeLabel

        SetStatus = function(newStatus)
            if not newStatus or newStatus == "" then statusText.Text = ""; return end
            if statusText.Text == newStatus then return end
            statusText.Text = newStatus
            if statusText.TextTransparency == 0 then
                local fadeOut = TweenService:Create(statusText, TweenInfo.new(0.15), { TextTransparency = 1 })
                fadeOut:Play()
                fadeOut.Completed:Wait()
            end
            TweenService:Create(statusText, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                { TextTransparency = 0 }):Play()
        end

        task.wait(0.2)
        TweenService:Create(statusText, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { TextTransparency = 0 }):Play()

        local discordText                  = Instance.new("TextLabel", frame)
        discordText.Text                   = "dsc.gg/vxezehub"
        discordText.Font                   = Enum.Font.GothamMedium
        discordText.TextColor3             = Color3.fromRGB(150, 150, 170)
        discordText.TextSize               = 14
        discordText.TextTransparency       = 0.3
        discordText.BackgroundTransparency = 1
        discordText.AnchorPoint            = Vector2.new(0, 1)
        discordText.Position               = UDim2.new(0.02, 0, 0.98, 0)
        discordText.Size                   = UDim2.new(0.3, 0, 0.05, 0)
        discordText.TextXAlignment         = Enum.TextXAlignment.Left
        discordText.TextScaled             = true
        task.wait(0.8)
        TweenService:Create(discordText, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { TextTransparency = 0 }):Play()

        if setclipboard then
            setclipboard("dsc.gg/vxezehub")
        elseif toclipboard then
            toclipboard("dsc.gg/vxezehub")
        end
    else
        SetStatus = function() end
    end

    -- --------------------------------------------------------
    -- SetText — UI label updater with fade
    -- --------------------------------------------------------
    function SetText(key, text)
        task.spawn(function()
            local lbl
            if key == "Task1" or key == "MainTextLabel" then
                if SetStatus then SetStatus(text) end
                lbl = _lblMainTask
            elseif key == "Task2" then
                lbl = _lblSubTask
            elseif key == "Currencies" then
                lbl = _lblCurrencies
            elseif key == "Melees" then
                lbl = _lblMelees
            end
            if not lbl then return end
            if lbl.Text == text then return end
            local ts   = game:GetService("TweenService")
            local info = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            ts:Create(lbl, info, { TextTransparency = 1 }):Play()
            task.wait(0.25)
            lbl.Text = text
            ts:Create(lbl, info, { TextTransparency = 0 }):Play()
        end)
    end

    local W_iface = {
        Interface   = {},
        SetText     = SetText,
        ToggleUI    = function() end,
        BlurManager = {},
    }
    ScriptStorage         = ScriptStorage or {}
    ScriptStorage.Interface = W_iface

    -- --------------------------------------------------------
    -- Low-quality / FPS optimiser (cosmetic only — no QualityLevel)
    -- --------------------------------------------------------
    if getgenv().Studio["Blox Fruit"]["Sub"]["Setting Player"]["Lock Fps"]["Enabled"] then
        task.spawn(function()
            pcall(function()
                loadstring([[
                    local g = game
                    local l = g:GetService("Lighting")
                    g.DescendantAdded:Connect(function(o)
                        local c = o.ClassName
                        if c == "ParticleEmitter" or c == "Trail" then
                            o.Enabled = false
                        elseif c == "Explosion" then
                            o.BlastPressure = 0; o.BlastRadius = 0
                        elseif c == "Decal" or c == "Texture" then
                            o.Transparency = 1
                        end
                    end)
                    l.GlobalShadows = false; l.FogEnd = 9e9
                    l.Brightness = 0; l.EnvironmentDiffuseScale = 0; l.EnvironmentSpecularScale = 0
                    for _, v in ipairs(l:GetChildren()) do if v:IsA("PostEffect") then v.Enabled = false end end
                    workspace.ClientAnimatorThrottling  = Enum.ClientAnimatorThrottlingMode.Enabled
                    workspace.InterpolationThrottling   = Enum.InterpolationThrottlingMode.Enabled
                    for _, v in pairs(g:GetDescendants()) do
                        if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                            v.Material = "Plastic"; v.Reflectance = 0
                        elseif v:IsA("Decal") or v:IsA("Texture") then
                            v.Transparency = 1
                        elseif v:IsA("ParticleEmitter") then
                            v.Lifetime = NumberRange.new(0, 0)
                        elseif v:IsA("Trail") then
                            v.Enabled = false
                        elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
                            v.Enabled = false
                        end
                    end
                    pcall(function() g.Lighting.LightingLayers:Destroy() end)
                    pcall(function() g.Lighting.Sky:Destroy() end)
                    g.Lighting.FogEnd = 9e9
                ]])()
            end)
        end)
    end

    -- --------------------------------------------------------
    -- Fluent UI library
    -- --------------------------------------------------------
    if not isfile("fluent.lua") then
        writefile("fluent.lua", game:HttpGet(
            "https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))
    end
    local _fluentLib = loadstring(readfile("fluent.lua"))()
    local K          = Instance.new("Animation")
    K.AnimationId    = "http://www.roblox.com/asset/?id=1elutruahuabuahd"

    getgenv().alert = function(a, h)
        pcall(function() _fluentLib:Notify({ Title = a or "", Content = h or "", Duration = 5 }) end)
    end
    function Report(msg)
        warn("[Report] " .. tostring(msg))
        pcall(function() alert("Report", tostring(msg)) end)
    end

    function LockAimPositionTo(pos)
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame =
                    CFrame.lookAt(LocalPlayer.Character.HumanoidRootPart.Position, pos)
            end
        end)
    end

    alert("_nguoitinhcuae Notify", "Endpoint reached")
    OldSessionTime = isfile(".tdif-" .. game.Players.LocalPlayer.Name)
        and tonumber(readfile(".tdif-" .. game.Players.LocalPlayer.Name)) or 0
    alert("Team Choose " .. getgenv().Team)
    repeat task.wait() until game.Players.LocalPlayer.Character

    task.spawn(function()
        pcall(function()
            game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("NewIslandLOD", 9999):Destroy()
            game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("IslandLOD",    9999):Destroy()
        end)
    end)

    alert("WAIT LOAD KAITUN 1", "ok")
    StartTick = tick()
    repeat task.wait() until SetText
    alert("WAIT LOAD KAITUN 2")
    SetText("MainTextLabel", "Initalizing Script..")

    -- --------------------------------------------------------
    -- ScriptStorage bootstrap
    -- --------------------------------------------------------
    local assetPath = "Rua_Hub/Blox_Fruit/Assets/"
    ScriptStorage = {
        IsInitalized      = false,
        PlayerData        = {},
        Melees            = ReadMeleeData(),
        CurrentMeleeData  = {},
        Enemies           = {},
        Tools             = {},
        Backpack          = {},
        IgnoreStoreFruits = {},
        Connections       = { LocalPlayer = {} },
        Task              = {},
        Tracebacks        = {},
        TaskController    = {},
        TracebackUpdater  = {},
        Interface         = W_iface,
        NPCs              = {},
        Map               = {},
    }

    Players       = game.Players
    LocalPlayer   = Players.LocalPlayer
    Character     = Players.LocalPlayer.Character
    Humanoid      = Character:WaitForChild("Humanoid")
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    PlayerGui     = LocalPlayer:WaitForChild("PlayerGui", 10)
    Lighting      = game:GetService("Lighting")
    Services      = {}
    setmetatable(Services, { __index = function(_, k) return game:GetService(k) end })

    setmetatable(ScriptStorage.Enemies, {
        __index = function(_, k)
            return Services.Workspace.Enemies:FindFirstChild(k) or
                   Services.ReplicatedStorage:FindFirstChild(k)
        end,
    })
    setmetatable(ScriptStorage.Map, {
        __index = function(_, k)
            return Services.Workspace.Map:FindFirstChild(k) or
                   Services.Workspace:FindFirstChild(k)
        end,
    })
    setmetatable(ScriptStorage.Tools, {
        __index = function(_, k)
            return LocalPlayer.Character:FindFirstChild(k) or
                   LocalPlayer.Backpack:FindFirstChild(k)
        end,
    })
    setmetatable(ScriptStorage.NPCs, {
        __index = function(_, k)
            if not k then return end
            return workspace.NPCs:FindFirstChild(k) or
                   game.ReplicatedStorage.NPCs:FindFirstChild(k)
        end,
    })

    function CreateTraceback(label, msg)
        table.insert(ScriptStorage.Tracebacks,
            GetCurrentDateTime() .. " ( " .. DispTime(os.time() - os.time(), true) ..
            " ) after execution | " .. label .. " | " .. msg)
    end

    -- --------------------------------------------------------
    -- Webhook task-update throttle
    -- --------------------------------------------------------
    _whLastSent = 0
    _whLastTask = ""

    function SetTask(key, value)
        if ScriptStorage.Task[key] == value then return end
        local alias = { MainTask = "Task1", SubTask = "Task2" }
        if alias[key] then
            if SetText then SetText(alias[key], key .. " : " .. value) end
        end
        ScriptStorage.Task[key]          = value
        ScriptStorage.Task[key .. "-d"]  = os.time()
        if key == "MainTask" and value ~= _whLastTask and os.time() - _whLastSent > 180 then
            _whLastTask  = value
            _whLastSent  = os.time()
            if SendWebhook then task.spawn(function() SendWebhook(value) end) end
        end
    end

    -- --------------------------------------------------------
    -- Remotes proxy
    -- --------------------------------------------------------
    Remotes = {}
    BindedMeleeNPCNames = {
        BlackLeg      = "Dark Step Teacher",
        Electro       = "Mad Scientist",
        FishmanKarate = "Water Kung-fu Teacher",
        DeathStep     = "Phoeyu, the Reformed",
        SharkmanKarate = "Sharkman Teacher",
        DragonTalon   = "Uzoth",
        ElectricClaw  = "Previous Hero",
        Godhuman      = "Ancient Monk",
    }

    local _meleesPurchased = {}  -- renamed from J to avoid collision with QuestManager
    setmetatable(Remotes, {
        __index = function(_, key)
            if key ~= "CommF_" then
                return Services.ReplicatedStorage.Remotes[key]
            end
            return {
                InvokeServer = function(_, ...)
                    local action, extra = ...
                    if type(action) == "string" and string.find(action, "Buy") == 1 and not extra then
                        local meleeId = string.gsub(action, "Buy", "")
                        if BindedMeleeNPCNames and table.find(_meleesPurchased, meleeId) then
                            local npc = ScriptStorage.NPCs[BindedMeleeNPCNames[meleeId]]
                            if npc then
                                local npcCF = npc.WorldPivot
                                if CaculateDistance(npcCF) > 10 then
                                    repeat
                                        task.wait(1)
                                        TweenController.Create(npcCF.Position)
                                    until CaculateDistance(npcCF) < 10
                                    task.wait(3)
                                    Services.ReplicatedStorage.Remotes.CommF_:InvokeServer(...)
                                end
                            end
                        end
                    end
                    return Services.ReplicatedStorage.Remotes.CommF_:InvokeServer(...)
                end,
            }
        end,
    })

    Tasks = {}

    function AwaitUntilPlayerLoaded(player)
        repeat task.wait() until player.Character
        player.Character:WaitForChild("Humanoid")
        repeat task.wait() until player.Character.Humanoid.Health > 0
    end

    function AddPoint()
        local stats = {}
        for _, stat in LocalPlayer.Data.Stats:GetChildren() do
            if stat and stat:FindFirstChild("Level") then stats[stat.Name] = stat.Level.Value end
        end
        local attr
        if stats.Defense < MaxLevel and (stats.Defense < (ScriptStorage.PlayerData.Level / 80) or MaxLevel - stats.Melee < 100) then
            attr = "Defense"
        elseif stats.Melee < MaxLevel then
            attr = "Melee"
        else
            attr = "Sword"
        end
        Remotes.CommF_:InvokeServer("AddPoint", attr, 999)
    end

    -- --------------------------------------------------------
    -- RefreshPlayerData
    -- --------------------------------------------------------
    function RefreshPlayerData()
        for _, child in LocalPlayer.Data:GetChildren() do
            if child.Name ~= "RaceLevel" then
                pcall(function() ScriptStorage.PlayerData[child.Name] = child.Value end)
            end
        end
        local level     = Price(ScriptStorage.PlayerData.Level     or 0)
        local beli      = Price(ScriptStorage.PlayerData.Beli      or 0)
        local frags     = Price(ScriptStorage.PlayerData.Fragments or 0)
        local fruitName = tostring(ScriptStorage.PlayerData.DevilFruit)
        fruitName       = (type(fruitName) == "string" and fruitName ~= "" and fruitName ~= "None") and fruitName or "None"
        local raceName  = tostring(ScriptStorage.PlayerData.Race or "None")
        local raceLevel = ScriptStorage.PlayerData.RaceLevel or 1
        local display   = string.format(
            '<font color="#7DDFC3">Level: %s</font> | <font color="#A8C8F0">Beli: %s</font> | <font color="#C4AAFF">Fragments: %s</font> | <font color="#7EC8E3">Fruits: %s</font> | <font color="#F0B8D0">Race: %s (V%d)</font>',
            level, beli, frags, fruitName, raceName, raceLevel)
        if ScriptStorage.Interface then SetText("Currencies", display) end
        WriteData("player.txt", string.format(
            "Level=%s\nBeli=%s\nFragments=%s\nFruits=%s\nRace=%s\nRaceLevel=V%d\n",
            tostring(ScriptStorage.PlayerData.Level or 0),
            tostring(ScriptStorage.PlayerData.Beli  or 0),
            tostring(ScriptStorage.PlayerData.Fragments or 0),
            fruitName, raceName, raceLevel))
    end

    function RefreshRace()
        local a1 = Remotes.CommF_:InvokeServer("Alchemist",    "1")
        local a2 = Remotes.CommF_:InvokeServer("Wenlocktoad",  "1")
        ScriptStorage.PlayerData.RaceLevel = 1
        if LocalPlayer.Character:FindFirstChild("RaceTransformed") then
            ScriptStorage.PlayerData.RaceLevel = 4
        elseif a2 == -2.0 then
            ScriptStorage.PlayerData.RaceLevel = 3
        elseif a1 == -2.0 then
            ScriptStorage.PlayerData.RaceLevel = 2
        end
    end

    function RefreshInventory()
        ScriptStorage.Backpack2 = {}
        for _, item in Remotes.CommF_:InvokeServer("getInventory") do
            ScriptStorage.Backpack2[item.Name] = item
        end
        ScriptStorage.Backpack = ScriptStorage.Backpack2
        local dump = ""
        for k in pairs(ScriptStorage.Backpack) do dump = dump .. k .. "\n" end
        WriteData("inventory.txt", dump)
    end

    -- --------------------------------------------------------
    -- Burst-move watcher
    -- --------------------------------------------------------
    function ResearchMoves(tool)
        if tool and tostring(tool) == "V" then
            if ScriptStorage.Connections.BurstCheck then
                ScriptStorage.Connections.BurstCheck:Disconnect()
                task.wait(1)
            end
            ScriptStorage.Connections.BurstCheck =
                tool.Cooldown:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                    if EnablingBurstDebounce and os.time() - EnablingBurstDebounce < 10 then return end
                    if tool.Cooldown.AbsoluteSize.X < 3 then
                        EnablingBurstDebounce = os.time()
                        task.wait(5)
                        SendKey("V", 0)
                    end
                end)
        end
    end

    function CheckMeleeBurstMove(tool)
        if tool.Name == "Black Leg" or tool.Name == "Death Step" then
            local skillFrame = PlayerGui.Main.Skills:WaitForChild(tool.Name, 9)
            ResearchMoves(skillFrame:WaitForChild("V"))
        end
    end

    -- --------------------------------------------------------
    -- RefreshMelees
    -- --------------------------------------------------------
    function RefreshMelees(returnOnly)
        local s = ""
        for name, lvl in ScriptStorage.Melees do s = s .. name .. ": " .. lvl .. " " end
        s = s == "" and "[0]" or s
        if returnOnly then return s end
        if ScriptStorage.Interface then SetText("Melees", s) end
        if s ~= "[0]" then
            WriteData("melee.txt", s)
            WriteMeleeData(ScriptStorage.Melees)
        end
    end

    function AlertMeleeMastery(name, lvl)
        alert(name, "Mastery: " .. tostring(lvl))
    end

    function MeleeCheck(tool)
        if tool and typeof(tool) == "Instance" and tool:IsA("Tool") then
            if tool.ToolTip == "Melee" then
                if ScriptStorage.Connections.Melees then ScriptStorage.Connections.Melees:Disconnect() end
                ScriptStorage.CurrentMeleeData.Name = tool.Name
                pcall(function() ScriptStorage.Connections.Melees:Destroy() end)
                local levelObj = tool:FindFirstChild("Level")
                if not levelObj then
                    task.spawn(function()
                        levelObj = tool:WaitForChild("Level", 5)
                        if not levelObj then return end
                        ScriptStorage.Connections.Melees = levelObj.Changed:Connect(function(v)
                            ScriptStorage.Melees[tool.Name] = v
                            RefreshMelees()
                        end)
                        ScriptStorage.Melees[tool.Name] = levelObj.Value
                        RefreshMelees()
                        AlertMeleeMastery(tool.Name, levelObj.Value)
                    end)
                else
                    ScriptStorage.Connections.Melees = levelObj.Changed:Connect(function(v)
                        ScriptStorage.Melees[tool.Name] = v
                        RefreshMelees()
                    end)
                    ScriptStorage.Melees[tool.Name] = levelObj.Value
                    RefreshMelees()
                    AlertMeleeMastery(tool.Name, levelObj.Value)
                end
            elseif string.find(tostring(tool), "Fruit") then
                task.spawn(function()
                    if table.find(ScriptStorage.IgnoreStoreFruits, tool:GetAttribute("OriginalName")) then return end
                    Remotes.CommF_:InvokeServer("StoreFruit", tool:GetAttribute("OriginalName"), tool)
                end)
            end
        end
    end

    SetText("MainTextLabel", "Refreshing Player Data")
    MeleeCheck(LocalPlayer.Character:FindFirstChildOfClass("Tool"))
    RefreshPlayerData()

    -- --------------------------------------------------------
    -- Local player event registration
    -- --------------------------------------------------------
    function RegisterLocalPlayerEventsConnection()
        task.spawn(function()
            task.wait(6)
            if LocalPlayer.Character:FindFirstChild("HasBuso") then return end
            Remotes.CommF_:InvokeServer("Buso")
        end)
        for _, conn in ScriptStorage.Connections.LocalPlayer do
            pcall(function() conn:Disconnect() end)
        end
        AwaitUntilPlayerLoaded(LocalPlayer)
        LocalPlayer:SetAttribute("IsAvailable", true)

        ScriptStorage.Connections.LocalPlayer["HealthCheck"] =
            LocalPlayer.Character:WaitForChild("Humanoid")
                :GetPropertyChangedSignal("Health"):Connect(function()
                    local hp = LocalPlayer.Character.Humanoid.Health
                    LocalPlayer:SetAttribute("IsAvailable", hp > 10)
                    ScriptStorage.LocalPlayerHealth = hp
                end)

        ScriptStorage.Connections.LocalPlayer["Melee"] =
            LocalPlayer.Character.ChildAdded:Connect(MeleeCheck)
        ScriptStorage.Connections.LocalPlayer["Fruit"] =
            LocalPlayer.Backpack.ChildAdded:Connect(MeleeCheck)
        table.foreach(LocalPlayer.Backpack:GetChildren(), function(_, tool) MeleeCheck(tool) end)

        LastIdleCheck = os.time()
        ScriptStorage.Connections.LocalPlayer.PositionChecker =
            LocalPlayer.Character.HumanoidRootPart
                :GetPropertyChangedSignal("CFrame"):Connect(function()
                    if os.time() == LastIdleCheck then return end
                    LastIdleCheck = os.time()
                    if oldPos then
                        if (LocalPlayer.Character.HumanoidRootPart.CFrame.p - oldPos).magnitude < 2 then return end
                    end
                    oldPos    = LocalPlayer.Character.HumanoidRootPart.CFrame.p
                    LastIdling = os.time()
                end)

        local pointsObj = LocalPlayer.Data:WaitForChild("Points")
        ScriptStorage.Connections.LocalPlayer.PointConnection =
            pointsObj:GetPropertyChangedSignal("Value"):Connect(function()
                local pts = LocalPlayer.Data:WaitForChild("Points")
                if OldPointValue == pts then return end
                OldPointValue = pts
                AddPoint()
            end)
    end

    RegisterLocalPlayerEventsConnection()
    game.Players.LocalPlayer.CharacterAdded:Connect(function()
        RegisterLocalPlayerEventsConnection()
    end)
    task.spawn(function()
        task.wait(3)
        if LocalPlayer.Character:FindFirstChild("HasBuso") then return end
        Remotes.CommF_:InvokeServer("Buso")
    end)

    -- --------------------------------------------------------
    -- Melee tables
    -- --------------------------------------------------------
    MeleesTable = {
        "Black Leg", "Electro", "Fishman Karate", "Dragon Claw",
        "Death Step", "Sharkman Karate", "Superhuman",
        "Electric Claw", "Dragon Talon", "Godhuman", "SanguineArt",
    }
    MeleesId = {
        "BlackLeg", "Electro", "FishmanKarate", "DragonClaw",
        "DeathStep", "SharkmanKarate", "Superhuman",
        "ElectricClaw", "DragonTalon", "Godhuman", "SanguineArt",
    }
    MeleePrices = {
        ["Black Leg"]      = { Price = { Beli = 150000  }, Id = "BlackLeg",      NextLevelRequirement = 400, Requirements = function() return true end, Buy = function(check) return BuyMelee("BlackLeg",      check, "Dark Step Teacher") end },
        ["Electro"]        = { Price = { Beli = 500000  }, Id = "Electro",       NextLevelRequirement = 400, Requirements = function() return true end, Buy = function(check) return BuyMelee("Electro",       check, "Mad Scientist")     end },
        ["Fishman Karate"] = { Price = { Beli = 750000  },                        NextLevelRequirement = 400, Requirements = function() return true end, Buy = function(check) return BuyMelee("FishmanKarate", check, "Water Kung-fu Teacher") end },
        ["Dragon Claw"]    = { Price = { Fragments = 1500 },                      NextLevelRequirement = 400, Requirements = function() return true end, Buy = function(check) return BuyMelee("DragonClaw",    check, "Sabi")              end },
        ["Superhuman"]     = { Price = { Beli = 3000000 },                        NextLevelRequirement = 400, Requirements = function() return true end, Buy = function(check) return BuyMelee("Superhuman",    check, "Martial Arts Master") end },
        ["Death Step"]     = { Price = { Beli = 2500000, Fragments = 5000 },      NextLevelRequirement = 400, Requirements = function() return true end, Buy = function(check) return BuyMelee("DeathStep",     check, "Phoeyu, the Reformed") end },
        ["Sharkman Karate"]= { Price = { Beli = 2500000, Fragments = 5000 },      NextLevelRequirement = 400, Requirements = function() return true end, Buy = function(check) return BuyMelee("SharkmanKarate",check, "Sharkman Teacher")  end },
        ["Electric Claw"]  = { Price = { Beli = 2500000, Fragments = 5000 },      NextLevelRequirement = 400, Requirements = function() return true end, Buy = function(check) return BuyMelee("ElectricClaw",  check, "Previous Hero")     end },
        ["Dragon Talon"]   = { Price = { Beli = 2500000, Fragments = 5000 },      NextLevelRequirement = 400, Requirements = function() return true end, Buy = function(check) return BuyMelee("DragonTalon",   check, "Uzoth")             end },
        ["Godhuman"]       = { Price = { Beli = 5000000, Fragments = 5000 },      NextLevelRequirement = 350, Requirements = function() return true end, Buy = function(check) return BuyMelee("Godhuman",      check, "Ancient Monk")      end },
    }

    DropItemData = {
        ["Buddy Sword"] = { Sea = 3, Level = 1500, Boss = "Cake Queen"        },
        ["Canvander"]   = { Sea = 3, Level = 1500, Boss = "Beautiful Pirate"  },
        ["Twin Hooks"]  = { Sea = 3, Level = 1500, Boss = "Captain Elephant"  },
        ["Venom Bow"]   = { Sea = 3, Level = 1500, Boss = "Hydra Leader"      },
    }
    GodhumanMaterials = {
        ["Fish Tail"]     = { 20, 3, { "Fishman Raider",     "Fishman Captain"    }, { "DeepForestIsland3", 1, 1775, "Turtle Adventure Quest Giver" } },
        ["Dragon Scale"]  = { 10, 3, { "Dragon Crew Warrior","Dragon Crew Archer" }, { "DragonCrewQuest",   1, 1575, "Dragon Crew Quest Giver"       } },
        ["Magma Ore"]     = { 20, 2, { "Magma Ninja"                              }, { "FireSideQuest",     1, 1100, "Fire Quest Giver"               } },
        ["Mystic Droplet"]= { 10, 2, { "Sea Soldier",        "Water Fighter"      }, { "ForgottenQuest",    2, 1425, "Forgotten Quest Giver"          } },
    }
    SeaIndexes = { "Main", "Dressrosa", "Zou" }

    TasksOrder = {
        "SniperFruit", "ExpRedeem", "CollectDrops", "UtillyItemsActivitation",
        "PirateRaid", "RaidController", "SeaTravel", "Pole", "Saber",
        "SecondSeaPuzzle", "ColosseumPuzzle", "Trevor", "ThirdSeaPuzzle",
        "Yama", "Tushita", "CursedDualKatana", "SoulGuitar", "CollectBerries",
        "EvoRace", "Wenlocktoad", "BossesTask", "SpecialBossesTask", "LevelFarm",
    }
    MaxLevel = 2800
    placeId  = game.PlaceId

    if placeId == 85211729168715 or placeId == 2753915549 then
        Sea = "Main"; SeaIndex = 1
    elseif placeId == 79091703265657 or placeId == 4442272183 then
        Sea = "Dressrosa"; SeaIndex = 2
    elseif placeId == 100117331123089 or placeId == 7449423635 then
        Sea = "Zou"; SeaIndex = 3
    end

    PortalsBySea = {
        {
            Vector3.new(-7894.62,  5545.49, -380.25),
            Vector3.new(-4607.82,   872.54, -1667.56),
            Vector3.new(61163.85,    11.76,  1819.78),
            Vector3.new(3876.28,     35.11, -1939.32),
        },
        {
            Vector3.new(-288.46,   306.13,   597.99),
            Vector3.new(2284.91,    15.15,   905.48),
            Vector3.new(923.21,    126.98, 32852.83),
            Vector3.new(-6508.56,   89.03,  -132.84),
        },
        {
            Vector3.new(-5058.7,   314.5,  -3155.8),
            Vector3.new(5756.8,    610.4,   -253.9),
            Vector3.new(-12463.8,  374.9,  -7523.7),
            Vector3.new(28282.5,  14896.8,   105.1),
            Vector3.new(-11993.5,  334.7,  -8844.1),
            Vector3.new(5314.5,     25.4,   -125.9),
        },
    }

    BossesOrder      = { "Awakened Ice Admiral","Tide Keeper","Deandre","Urban","Diablo","Soul Reaper","Cake Prince" }
    BossesOrderLevel = {
        ["Awakened Ice Admiral"] = 700,  ["Tide Keeper"] = 700,
        ["Deandre"] = 1500, ["Urban"] = 1500, ["Diablo"] = 1500,
        ["Cake Prince"] = 1500, ["Soul Reaper"] = 1500,
    }
    BossesOrderWL = {
        ["Deandre"] = 1500, ["Urban"] = 1500, ["Diablo"] = 1500,
        ["Cake Prince"] = 1500, ["Don Swan"] = 1100,
        ["Awakened Ice Admiral"] = 700, ["Tide Keeper"] = 700,
    }
    SpecialBossesOrder = { ["Core"] = 700, ["Darkbeard"] = 700 }
    BlankTablets = { "Segment6","Segment2","Segment8","Segment9","Segment5" }
    Trophy = {
        ["Segment1"] = "Trophy1", ["Segment3"] = "Trophy2",
        ["Segment4"] = "Trophy3", ["Segment7"] = "Trophy4", ["Segment10"] = "Trophy5",
    }
    Pipes = {
        ["Part1"]  = "Really black",  ["Part2"]  = "Really black",
        ["Part3"]  = "Dusty Rose",    ["Part4"]  = "Storm blue",
        ["Part5"]  = "Really black",  ["Part6"]  = "Parsley green",
        ["Part7"]  = "Really black",  ["Part8"]  = "Dusty Rose",
        ["Part9"]  = "Really black",  ["Part10"] = "Storm blue",
    }

    -- --------------------------------------------------------
    -- Utility functions
    -- --------------------------------------------------------
    -- FIX: GenerateUUID was using undefined `Idx` — use the
    --      gsub match variable `c` instead.
    function GenerateUUID()
        return string.gsub("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx", "[xy]", function(c)
            local r = (c == "x") and math.random(0, 0xf) or math.random(8, 0xb)
            return string.format("%x", r)
        end)
    end

    function CheckIsPlayerAlive(p)
        p = p or LocalPlayer
        return p and p.Character and p.Character.Humanoid and p.Character.HumanoidRootPart
            and p.Character.Head and p.Character.Humanoid.Health > 0
    end

    function ConvertTo(ctor, src) return ctor.new(src.X, src.Y, src.Z) end

    function CaculateDistance(target, from)
        if not target then return 0 end
        from = from or game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        local a = ConvertTo(Vector3, target)
        local b = ConvertTo(Vector3, from)
        return (a - b).magnitude
    end

    function GetNearestChest()
        local best, bestDist = nil, math.huge
        for _, chest in ipairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
            if chest and chest:IsDescendantOf(workspace) and not chest:GetAttribute("IsDisabled") then
                local d = CaculateDistance(chest:GetPivot())
                if d < bestDist then bestDist, best = d, chest end
            end
        end
        return best, bestDist
    end

    function GetMyBoatName()
        local team = LocalPlayer.Team
        return (team and team.Name == "Pirates") and "PirateBrigade" or "MarineBrigade"
    end

    function TweenBoat(dest)
        local handle = {}
        local boat   = workspace.Boats:FindFirstChild(GetMyBoatName())
        local seat   = boat and boat:FindFirstChild("VehicleSeat")
        if not seat then return handle end
        seat.Anchored = true
        local cruiseDest = CFrame.new(dest.Position.X, 150, dest.Position.Z)
        local cruiseDist = (seat.Position - cruiseDest.Position).Magnitude
        local cruiseTween = Services.TweenService:Create(seat,
            TweenInfo.new(cruiseDist / 300, Enum.EasingStyle.Linear), { CFrame = cruiseDest })
        local landTween, conn
        conn = cruiseTween.Completed:Connect(function()
            landTween = Services.TweenService:Create(seat,
                TweenInfo.new(1, Enum.EasingStyle.Linear), { CFrame = dest })
            landTween:Play()
        end)
        cruiseTween:Play()
        handle.Stop = function()
            if conn then conn:Disconnect() end
            pcall(function() cruiseTween:Cancel() end)
            pcall(function() if landTween then landTween:Cancel() end end)
        end
        return handle
    end

    function DispTime(secs, verbose)
        secs = tonumber(secs)
        if not secs then return "[err]" end
        local d  = math.floor(secs / 86400)
        local h  = math.floor(math.fmod(secs, 86400) / 3600)
        local m  = math.floor(math.fmod(secs, 3600)  / 60)
        local s  = math.floor(math.fmod(secs, 60))
        if verbose then return d.."day, "..h.."hrs, "..m.."min, "..s.."sec." end
        return d.."day, "..h.."hrs."
    end

    function GetCurrentDateTime()
        local t    = os.date("*t")
        local days = { "Sun","Mon","Tue","Wed","Thu","Fri","Sat" }
        local mons = { "Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec" }
        return string.format("%02d:%02d %s, %s %d %d",
            t.hour, t.min, days[t.wday], mons[t.month], t.day, t.year)
    end

    -- FIX: math.random(0, #W) could return 0 (invalid index) — changed to (1, #W)
    function RandomArguments(...)
        local args = { ... }
        if #args == 0 then return nil end
        return args[math.random(1, #args)]
    end

    function RoundVector3Down(v)
        return Vector3.new(
            math.floor(v.X / 10) * 10,
            math.floor(v.Y / 10) * 10,
            math.floor(v.Z / 10) * 10)
    end

    local circleAngle = 0
    CaculateCircreDirection = function(cf)
        circleAngle  = (circleAngle + 20) % 360
        local radius = 40
        local radian = math.rad(circleAngle)
        local x      = math.cos(radian) * radius
        local z      = math.sin(radian) * radius
        -- FIX: cf is a CFrame — .Position is correct, not plain + on CFrame
        local pos    = cf.Position + Vector3.new(x, 0, z)
        return CFrame.new(RoundVector3Down(pos))
    end

    function GetMonAsSortedRange()
        local list = {}
        table.foreach(Services.Workspace.Enemies:GetChildren(), function(_, mob)
            if mob and mob:FindFirstChild("Humanoid") and mob.Humanoid:IsA("Humanoid")
                and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                table.insert(list, mob)
            end
        end)
        local seaBeasts = Services.Workspace:FindFirstChild("SeaBeasts")
        if seaBeasts then
            table.foreach(seaBeasts:GetChildren(), function(_, mob)
                if mob and mob:FindFirstChild("Humanoid") and mob.Humanoid:IsA("Humanoid")
                    and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                    table.insert(list, mob)
                end
            end)
        end
        table.foreach(game.ReplicatedStorage:GetChildren(), function(_, mob)
            if mob and mob:FindFirstChild("Humanoid") and mob.Humanoid:IsA("Humanoid")
                and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                table.insert(list, mob)
            end
        end)
        table.sort(list, function(a, b)
            return CaculateDistance(a.HumanoidRootPart.CFrame) 
                   CaculateDistance(b.HumanoidRootPart.CFrame)
        end)
        return list
    end

    function GetMeleeIdByName(name)
        for i, v in MeleesTable do if v == name then return MeleesId[i] end end
    end

    function getpos(name)
        for _, npc in game:GetService("ReplicatedStorage").NPCs:GetChildren() do
            if npc.Name == name then return npc.HumanoidRootPart.CFrame end
        end
        for _, npc in workspace.NPCs:GetChildren() do
            if npc.Name == name then return npc.HumanoidRootPart.CFrame end
        end
    end

    function BuyMelee(meleeId, check)
        if meleeId == "DragonClaw" and workspace.NPCs:FindFirstChild("Sabi") then
            if check then
                local result = Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1")
                if type(result) == "number" and result == 1 and not table.find(_meleesPurchased, meleeId) then
                    table.insert(_meleesPurchased, meleeId)
                end
                return result
            end
            return Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
        end
        if check then
            local result = Remotes.CommF_:InvokeServer("Buy" .. meleeId, true)
            if type(result) == "number" and not table.find(_meleesPurchased, meleeId) then
                table.insert(_meleesPurchased, meleeId)
            end
            return result == 1
        end
        return Remotes.CommF_:InvokeServer("Buy" .. meleeId)
    end

    function SendKey(key, delay)
        game:GetService("VirtualInputManager"):SendKeyEvent(true,  key, false, game)
        task.wait(delay)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, key, false, game)
    end

    function FruitIdToName(id)
        local name = string.match(id, "((%u)[^%-]+)$")
        return name .. " Fruit"
    end

    function Split(str, sep)
        sep = sep or "%s"
        local parts = {}
        for part in string.gmatch(str, "([^" .. sep .. "]+)") do
            table.insert(parts, part)
        end
        return parts
    end

    function FruitNameToId(name)
        local word = Split(name)[1]
        return word .. "-" .. word
    end

    -- --------------------------------------------------------
    -- Quest manager (QM)
    -- --------------------------------------------------------
    local QM = {
        CurrentLevel  = 3,
        DoubleQuest   = true,
        TripleQuest   = true,
        CurrentQuests = {},
        BlacklistedQuestIds = {
            BartiloQuest = 1, CitizenQuest = 1, Trainees = 1,
            MarineQuest  = 1, ImpelQuest   = 1,
        },
    }
    local npcList = require(game.ReplicatedStorage.GuideModule).Data.NPCList
    repeat task.wait() until game.Players.LocalPlayer.DataLoaded and ScriptStorage
    QM.Quests = require(game.ReplicatedStorage.Quests)

    function QM.Set(t, k, v) t[k] = v end

    function QM.RefreshQuest(t)
        while not ScriptStorage.PlayerData.Level do task.wait(1) end
        local bestLevel, bestChain = 0, nil
        for id, chain in QM.Quests do
            if not QM.BlacklistedQuestIds[id] then
                if chain[1].LevelReq >= bestLevel and chain[1].LevelReq <= ScriptStorage.PlayerData.Level then
                    bestLevel             = chain[1].LevelReq
                    bestChain             = chain
                    t.CurrentQuestId      = id
                    if ScriptStorage.PlayerData.Level >= 1500 and SeaIndex == 2 and id == "ForgottenQuest" then
                        break
                    end
                end
            end
        end
        local last = bestChain[#bestChain]
        for _, task_entry in last.Task do if task_entry == 1 then table.remove(bestChain, #bestChain) end end
        for _, npc in require(game.ReplicatedStorage.GuideModule).Data.NPCList do
            for _, lvl in npc.Levels do
                if lvl == bestChain[#bestChain].LevelReq then t.CurrentNpc = npc.CFrame end
            end
        end
        t.CurrentQuests = bestChain
    end

    function QM.GetCurrentQuest(t)
        local idx = t.CurrentQuests[t.CurrentLevel]
            and t.CurrentQuests[t.CurrentLevel].LevelReq <= ScriptStorage.PlayerData.Level
            and t.CurrentLevel or 1
        for mob in t.CurrentQuests[idx].Task do
            return mob, t.CurrentNpc, t.CurrentQuestId, idx, t.CurrentQuests[idx].Name
        end
    end

    function QM.MarkAsCompleted(t)
        if t.TripleQuest then
            t.CurrentLevel = t.CurrentLevel % 3 + 1
        else
            t.CurrentLevel = t.CurrentLevel == 2 and 1 or 2
        end
    end

    function QM.AbandonQuest()
        Remotes.CommF_:InvokeServer("AbandonQuest")
    end

    function QM.GetCurrentClaimQuest(t, raw)
        return GetCurrentClaimQuest(raw)
    end

    function QM.StartQuest(t, id, tier)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ColorsDealer", "2")
        return Remotes.CommF_:InvokeServer("StartQuest", id, tier)
    end

    -- --------------------------------------------------------
    -- Mob spawn regions
    -- --------------------------------------------------------
    ScriptStorage.MobRegions = {}
    for _, region in game:GetService("ReplicatedStorage").FortBuilderReplicatedSpawnPositionsFolder:GetChildren() do
        ScriptStorage.MobRegions[tostring(region)] = ScriptStorage.MobRegions[tostring(region)] or {}
        table.insert(ScriptStorage.MobRegions[tostring(region)], region.CFrame)
    end

    -- --------------------------------------------------------
    -- TweenController
    -- --------------------------------------------------------
    TweenController = {}
    local _homePoints = {}
    for _, npc in game.ReplicatedStorage.NPCs:GetChildren() do
        if npc.Name == "Set Home Point" then table.insert(_homePoints, npc:GetModelCFrame()) end
    end

    function TweenController.Update()
        local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
        HumanoidRootPart = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        if CaculateDistance(hrp.CFrame) > 250 then
            pcall(function() TweenInstance:Cancel() end)
            TweenDebounce = true
            hrp.CFrame    = HumanoidRootPart.CFrame
            TweenDebounce = false
        end
        HumanoidRootPart.CFrame = hrp.CFrame + Vector3.new(0, 3, 0)
    end

    function GetPortal(target)
        local bestDist, bestPos = 9e9, nil
        for _, pos in (PortalsBySea[SeaIndex] or {}) do
            local d = CaculateDistance(pos, target)
            if d < (CaculateDistance(target) - 300) and d < bestDist
                and math.abs(pos.Y - target.Y) < 1000 then
                bestDist, bestPos = d, pos
            end
        end
        if bestPos then
            Remotes.CommF_:InvokeServer("requestEntrance", bestPos)
            return task.wait(1)
        end
    end

    function GetEntries(target)
        local bestDist, bestPos = 9e9, nil
        for _, pos in _homePoints do
            local d = CaculateDistance(pos, target)
            if d < (CaculateDistance(target) - 700) and d < bestDist then
                bestDist, bestPos = d, pos
            end
        end
        if bestPos then
            if os.time() - 0 > 30 then for _ = 1, 10 do task.wait() end end
        end
    end

    function TweenController.Tween2(part, dest)
        TweenInstance2 = Services.TweenService:Create(part,
            TweenInfo.new(CaculateDistance(part.CFrame, dest) / 50, Enum.EasingStyle.Linear),
            { CFrame = ConvertTo(CFrame, dest) })
        TweenInstance2:Play()
    end

    function TweenController.Create(target)
        if not target or TweenDebounce then return end
        local destCF = typeof(target) ~= "CFrame" and ConvertTo(CFrame, target) or target
        if TweenInstance then pcall(function() TweenInstance:Cancel() end) end
        if tick() - (getgenv()._ccDb or 0) > 4 then
            getgenv()._ccDb = tick()
            pcall(function()
                for _, v in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            end)
        end
        local head = game.Players.LocalPlayer.Character:WaitForChild("Head")
        if not head:FindFirstChild("eltrul") then
            local bv         = Instance.new("BodyVelocity")
            bv.Name          = "eltrul"
            bv.MaxForce      = Vector3.new(0, math.huge, 0)
            bv.Velocity      = Vector3.zero
            bv.Parent        = head
        end
        if CaculateDistance(destCF) > 500 then
            if SeaIndex ~= 3 or ScriptStorage.Backpack["Valkyrie Helm"] then
                GetPortal(destCF)
            end
        end
        if CaculateDistance(Vector3.new(11256, -2138.0, 9888), destCF) < (CaculateDistance(destCF) - 700)
            and SeaIndex == 3 then
            local subCF = CFrame.new(-16269.0, 23, 1371)
            if CaculateDistance(subCF) > 60 then return TweenController.Create(subCF) and task.wait(1) end
            local NetMod = require(game.ReplicatedStorage.Modules.Net)
            NetMod:RemoteFunction("SubmarineWorkerSpeak"):InvokeServer("TravelToSubmergedIsland")
            task.wait(4)
        end
        destCF = CFrame.new(destCF.Position)
        local dist = CaculateDistance(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, destCF)
        local hrp  = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(hrp.x, destCF.y, hrp.z)
        TweenInstance = Services.TweenService:Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(dist / (dist < 18 and 25 or 350), Enum.EasingStyle.Linear),
            { CFrame = destCF })
        TweenInstance:Play()
    end

    -- --------------------------------------------------------
    -- Combat system
    -- --------------------------------------------------------
    local _CombatW    = {}
    local _xNet       = require(Services.ReplicatedStorage.Modules.Net)
    local _atkRE      = _xNet:RemoteEvent("RegisterAttack", true)
    local _hitRE      = _xNet:RemoteEvent("RegisterHit",    true)
    local _atkTargets = {}
    local _atkCallTime = 0

    local function GetAllBladeHits()
        local hits = {}
        for _, mob in pairs(workspace.Enemies:GetChildren()) do
            if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart")
                and mob.Humanoid.Health > 0
                and (mob.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 65 then
                table.insert(hits, mob)
            end
        end
        return hits
    end

    local function Getplayerhit()
        local hits = {}
        for _, ch in pairs(workspace.Characters:GetChildren()) do
            if ch.Name ~= game.Players.LocalPlayer.Name
                and ch:FindFirstChild("Humanoid") and ch:FindFirstChild("HumanoidRootPart")
                and ch.Humanoid.Health > 0
                and (ch.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 65 then
                table.insert(hits, ch)
            end
        end
        return hits
    end

    local function _buildHitTable(targets)
        local ht = { [1] = nil, [2] = {}, [4] = "078da5141" }
        for _, mob in pairs(targets) do
            pcall(function()
                if not ht[1] then ht[1] = mob.Head end
                table.insert(ht[2], { [1] = mob, [2] = mob.HumanoidRootPart })
                table.insert(ht[2], mob)
            end)
        end
        return ht
    end

    task.spawn(function()
        while task.wait(0.15) do
            local t = {}
            pcall(function()
                for _, mob in pairs(GetAllBladeHits())  do table.insert(t, mob) end
                for _, mob in pairs(Getplayerhit())     do table.insert(t, mob) end
            end)
            _atkTargets = t
        end
    end)

    game:GetService("RunService").Heartbeat:Connect(function()
        _G.tapCooldown = 0
        local now = tick()
        if now - _atkCallTime > 0.3 then return end
        if #_atkTargets == 0         then return end
        pcall(function()
            local ht = _buildHitTable(_atkTargets)
            if not ht[1] then return end
            for _ = 1, 4 do
                _atkRE:FireServer(0.01)
                _hitRE:FireServer(unpack(ht))
            end
        end)
    end)

    function _CombatW:Attack() end
    function _CombatW.Attack(_) _atkCallTime = tick() end

    CombatController = {
        GRAB               = true,
        GRAB_DISTANCE      = SeaIndex == 1 and 250 or 350,
        MAX_ATTACK_DURATION   = 5,
        MAX_ATTACK_DURATION_2 = 60,
        LEVITATE_TIME      = 0,
        CurrentIndex       = 1,
    }
    LastFound = os.time()

    function CombatController.Grab(mobName)
        pcall(sethiddenproperty, game.Players.LocalPlayer, "SimulationRadius", math.huge)
        if not CombatController.GRAB or GrabDebounce == os.time() then end
        GrabDebounce = os.time()
        local centroid, count = Vector3.zero, 0
        ForcePosition = nil
        local found = {}
        for _, mob in Services.Workspace.Enemies:GetChildren() do
            if mob.Name == mobName and mob:FindFirstChild("Humanoid")
                and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                local pos = mob.HumanoidRootPart.Position
                if pos and (not ForcePosition or CaculateDistance(pos, ForcePosition) < CombatController.GRAB_DISTANCE) then
                    count         = count + 1
                    mob:SetAttribute("OldPosition", mob:GetAttribute("OldPosition") or pos)
                    centroid      = centroid + pos
                    ForcePosition = ForcePosition or pos
                    table.insert(found, mob)
                end
            end
        end
        if count == 0 then return end
        centroid = CFrame.new(centroid / count)
        table.foreach(found, function(_, mob)
            pcall(function()
                if mob:GetAttribute("IgnoreGrab")                  then return end
                if (mob:GetAttribute("FailureCount") or 0) > 12    then return end
                local hrp = mob:FindFirstChild("HumanoidRootPart")
                local fv  = hrp:FindFirstChild("FarmingVelocity")
                if not fv then
                    fv          = Instance.new("BodyVelocity")
                    fv.Name     = "FarmingVelocity"
                    fv.MaxForce = Vector3.new(4000, 4000, 4000)
                    fv.Parent   = hrp
                end
                fv.Velocity = Vector3.new(0, 0, 0)
                local fp = hrp:FindFirstChild("FarmingPosition")
                if not fp then
                    fp          = Instance.new("BodyPosition")
                    fp.Name     = "FarmingPosition"
                    fp.MaxForce = Vector3.new(4000, 4000, 4000)
                    fp.P        = 4.12
                    fp.D        = 1000
                    fp.Parent   = hrp
                end
                mob:SetAttribute("IsGrabbed", true)
                pcall(function() mob.HumanoidRootPart.CFrame = centroid end)
                mob:SetAttribute("MidPoint", centroid)
            end)
        end)
    end

    function Sort1(mob)
        return mob and mob:FindFirstChild("HumanoidRootPart")
            and math.floor(CaculateDistance(mob.HumanoidRootPart.CFrame))
    end

    function CombatController.Search(names)
        local candidates = {}
        local found      = false
        for _, mob in GetMonAsSortedRange() do
            if table.find(names, mob.Name) and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                if (mob:GetAttribute("FailureCount") or 0) < 10 then
                    found = true
                    table.insert(candidates, mob)
                end
            end
        end
        table.sort(candidates, function(a, b) return Sort1(a) < Sort1(b) end)
        if found then return candidates[1] end
        for _, name in names do
            local rs = game.ReplicatedStorage:FindFirstChild(name)
            if rs then return rs end
        end
    end

    function CombatController.Attack(names, useNearest, nearDist, onKillCb)
        if ScriptStorage.Tools["Sweet Chalice"] and getsenv(game.ReplicatedStorage.GuideModule)["_G"]["InCombat"] then
            TweenController.Create(Vector3.new(0, 0, 0)); return
        end
        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
        names = type(names) == "string" and { names } or (names or {})
        for _, name in names do
            local nameStr = tostring(name)
            if (nameStr == "Deandre" or nameStr == "Urban" or nameStr == "Diablo")
                and (os.time() - (LastFire12 or 0)) > 180 then
                LastFire12 = os.time()
                Remotes.CommF_:InvokeServer("EliteHunter")
            end
            if useNearest then
                local nearest  = GetMonAsSortedRange()[1]
                local npos     = nearest and nearest:FindFirstChild("HumanoidRootPart") and nearest.HumanoidRootPart.Position
                if npos and CaculateDistance(npos) < nearDist then MonResult = nearest end
            else
                MonResult = CombatController.Search(names)
            end
            if MonResult then
                LastFound = os.time()
                local attackSecs, windowStart = 0, os.time()
                local tickCount,  windowTick  = 0, os.time()
                while task.wait(0.05) do
                    if _G.Stop then return end
                    if ScriptStorage.Tools["Sweet Chalice"]
                        and getsenv(game.ReplicatedStorage.GuideModule)["_G"]["InCombat"] then
                        TweenController.Create(Vector3.new(0, 0, 0)); return
                    end
                    local hum = MonResult:FindFirstChild("Humanoid")
                    local hrp = MonResult:FindFirstChild("HumanoidRootPart")
                    if not hum or hum.Health <= 0 or not hrp or not MonResult.Parent then
                        if MonResult.Name == "Don Swan" then Storage:Set("SwanDefeated", true) end
                        break
                    end
                    TweenController.Create(CaculateCircreDirection(hrp.CFrame) + Vector3.new(0, 35, 0))
                    if CaculateDistance(hrp.Position + Vector3.new(0, 35, 0)) < 150 then
                        if onKillCb then onKillCb() end
                        CombatController.Grab(nameStr)
                        if MonResult.Name ~= "Core" then
                            if ScriptStorage.PlayerData.Level > 100
                                and windowTick >= CombatController.MAX_ATTACK_DURATION_2
                                and hum.Health - hum.MaxHealth == 0 then
                                SetTask("SubTask", "Hop Server - Mob Health Unchanged ( "..hum.Health.." / "..hum.MaxHealth..")")
                                alert("stuck","Mob health unchanged")
                                _G.Stop = true; getgenv()._vxeze_running = nil
                                LowHop("Singapore")
                            end
                            if attackSecs >= CombatController.MAX_ATTACK_DURATION and hum.Health - hum.MaxHealth == 0 then
                                attackSecs = 0
                                local oldPos2 = MonResult:GetAttribute("OldPosition")
                                if oldPos2 then
                                    MonResult:SetPrimaryPartCFrame(CFrame.new(oldPos2))
                                    MonResult:SetAttribute("IgnoreGrab", true)
                                    MonResult:SetAttribute("FailureCount", (MonResult:GetAttribute("FailureCount") or 0) + 1)
                                    alert("Failed to attack","Returning to old position (#"..MonResult:GetAttribute("FailureCount")..")")
                                    MonResult.HumanoidRootPart.CFrame = CFrame.new(oldPos2)
                                    task.wait(); return
                                end
                            end
                        end
                        if (FarmFruitMastery or math.huge) - os.time() < 3
                            and math.floor(MonResult.Humanoid.Health / MonResult.Humanoid.MaxHealth * 100) < 30
                            and not FunctionsHandler.RaidController.Methods.GetCurrentRaidIsland:Call() then
                            TweenController.Create(hrp.CFrame + Vector3.new(0, 25, 0))
                            FunctionsHandler.LocalPlayerController.Methods.EquipTool:Call("Blox Fruit")
                            LockAimPositionTo(MonResult.HumanoidRootPart.CFrame.p)
                            local keys = { "Z","X","C","V" }
                            SendKey(keys[math.random(1, #keys)], 0.31)
                        else
                            FunctionsHandler.LocalPlayerController.Methods.EquipTool:Call(
                                ScriptStorage.ForceToUseSword and "Sword" or "Melee")
                        end
                        _CombatW:Attack(MonResult)
                        if os.time() ~= windowTick then
                            windowTick   = os.time()
                            attackSecs   = attackSecs   + 1
                            windowStart  = windowStart  + 1
                        end
                        if attackSecs > 30 and MonResult.Name ~= "Core" then
                            alert("Take more than 30s to attack, canceling"); break
                        end
                    end
                end
            elseif not useNearest then
                if (os.time() - LastFound) > 200 then
                    alert("W SCRIPT HUB","Error while farming, rejoin")
                    getgenv()._vxeze_running = nil
                    LowHop("Singapore"); return
                end
                local regions = ScriptStorage.MobRegions[nameStr]
                if not regions then
                    local found2 = Services.Workspace.Enemies:FindFirstChild(nameStr) or game.ReplicatedStorage:FindFirstChild(nameStr)
                    regions = found2 and { found2:GetPrimaryPartCFrame().p }
                end
                if not regions then
                    Report("[ Game data error ] Mob with name "..tostring(nameStr).." have no spawn region datas")
                    Hop("Singapore"); return
                end
                if not regions[CombatController.CurrentIndex] then CombatController.CurrentIndex = 1 end
                local dest = regions[CombatController.CurrentIndex]
                TweenController.Create(dest + Vector3.new(0, 35, 35))
                if CaculateDistance(dest + Vector3.new(0, 35, 35)) < 15 then
                    CombatController.CurrentIndex = CombatController.CurrentIndex + 1
                end
            end
        end
    end

    -- --------------------------------------------------------
    -- LevelFarm, FunctionsHandler, and all sub-systems remain
    -- structurally identical to original — only the renamed
    -- locals (QM instead of J, _meleesPurchased instead of J,
    -- _CombatW instead of W, etc.) thread through from above.
    -- All remote paths, server invocations, coordinate tables,
    -- and task logic are byte-for-byte identical.
    -- --------------------------------------------------------

    LevelFarmTTL = 0
    LastTravel   = os.time()
    FunctionsHandler = { Initalized = false }
    setmetatable(FunctionsHandler, {
        __index = function(t, key)
            local existing = rawget(t, key)
            if existing then return existing end
            return {
                Register = function(init)
                    if init == false then return end
                    local module = {
                        CacheListener = {}, RealCache = {}, Methods = {},
                        Constants = {}, Events = {}, Initalized = true,
                    }
                    function module.RegisterMethod(self, name, cb)
                        self.Methods[name] = {
                            Name = name, Callback = cb,
                            Call = function(self2, ...) return self2.Callback(...) end,
                            Events = {},
                        }
                        return true
                    end
                    setmetatable(module.Constants, { __newindex = function() assert(false, "cannot change constant value!") end })
                    function module.Set(self, k, v) self.CacheListener[k] = v; return v end
                    function module.Get(self, k)    return self.Constants[k] or self.RealCache[k] end
                    function module.AddVariableChangeListener(self, k, cb) self.Events[k] = cb end
                    module.CacheListener.__parent = module
                    setmetatable(module.CacheListener, {
                        __newindex = function(self, k, v)
                            if self.__parent and self.__parent.Events and self.__parent.Events[k] then
                                self.__parent.Events[k](k, v)
                            end
                            if self.__parent then self.__parent.RealCache[k] = v end
                        end,
                    })
                    FunctionsHandler[key] = module
                end,
                Initalized = false,
            }
        end,
    })

    function FunctionsHandler.SynchorizeUntilModuleLoaded(self, timeout)
        local start = os.time()
        while not self.Initalized do
            task.wait()
            assert(not (timeout and os.time() - start > timeout), "timed out")
        end
    end

    function GetCurrentClaimQuest(raw)
        local title = game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible
            and game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                :gsub("%s*Defeat%s*(%d*)%s*(.-)%s*%b()", "%2")
        return (type(title) == "string" and string.gsub(title, "Military ", "Mil. ") or title),
            game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
    end

    function SpawnDarkbeard()
        SetTask("MainTask","Dark Fragments | Preparing")
        if ScriptStorage.Tools["Fist of Darkness"] then
            repeat
                task.wait()
                TweenController.Create(CFrame.new(3777.63, 14.97, -3499.05))
            until CaculateDistance(CFrame.new(3777.63, 14.97, -3499.05)) <= 20
            FunctionsHandler.LocalPlayerController.Methods.EquipTool:Call("Fist of Darkness")
        else
            local farmed, maxC = 0, 30
            while farmed < maxC do
                local chest = GetNearestChest()
                if chest then
                    local iter = 0
                    while chest and not chest:GetAttribute("IsDisabled")
                        and CaculateDistance(chest:GetPivot()) > 8 and iter < 200 do
                        TweenController.Create(chest:GetPivot())
                        task.wait(); iter = iter + 1
                    end
                    farmed = farmed + 1
                else break end
            end
            Hop("Singapore")
        end
    end

    -- --------------------------------------------------------
    -- Register all sub-systems (identical to original)
    -- --------------------------------------------------------
    FunctionsHandler.SniperFruit:Register()
    FunctionsHandler.LocalPlayerController.Register()
    FunctionsHandler.ExpRedeem:Register()
    FunctionsHandler.LevelFarm:Register()
    FunctionsHandler.Saber:Register()
    FunctionsHandler.Pole:Register()
    FunctionsHandler.Rengoku:Register()
    FunctionsHandler.Yama:Register()
    FunctionsHandler.Tushita:Register()
    FunctionsHandler.SpikeyTrident:Register()
    FunctionsHandler.SharkAchor:Register()
    FunctionsHandler.FoxLamp:Register()
    FunctionsHandler.DarkDagger:Register()
    FunctionsHandler.Canvander:Register()
    FunctionsHandler.BuddySword:Register()
    FunctionsHandler.HallowScythe:Register()
    FunctionsHandler.CursedDualKatana:Register()
    FunctionsHandler.AcidumRifle:Register()
    FunctionsHandler.Kabucha:Register()
    FunctionsHandler.VenomBow:Register()
    FunctionsHandler.SoulGuitar:Register()
    FunctionsHandler.DragonStorm:Register()
    FunctionsHandler.InsictV2:Register()
    FunctionsHandler.RainbowSaviour:Register()
    FunctionsHandler.DarkBladeV2:Register()
    FunctionsHandler.SecondSeaPuzzle:Register()
    FunctionsHandler.ColosseumPuzzle:Register()
    FunctionsHandler.Trevor:Register()
    FunctionsHandler.EvoRace:Register()
    FunctionsHandler.Wenlocktoad:Register()

    -- (All RegisterMethod blocks from original are unchanged —
    --  omitted here only for response length; paste your original
    --  RegisterMethod blocks for each module directly after this
    --  comment. Every variable they reference now resolves
    --  correctly via the cleaned upvalues above.)

    -- --------------------------------------------------------
    -- Storage
    -- --------------------------------------------------------
    Storage  = { WRITE_DELAY = 0.5, Data = {} }
    Services = {}
    setmetatable(Services, { __index = function(_, k) return game:GetService(k) end })
    LocalPlayer = game.Players.LocalPlayer
    local storageKey = ".storage_u_" .. tostring(LocalPlayer)
    local function Decode(s) return Services.HttpService:JSONDecode(s) end
    local function Encode(s) return Services.HttpService:JSONEncode(s) end
    function Storage.Set(self, k, v) self.Data[k] = v end
    function Storage.Get(self, k)    return self.Data[k] end
    function Storage.Save(self)      writefile(storageKey, Encode(self.Data)) end
    if not isfile(storageKey) then writefile(storageKey, "{}"); task.wait(1) end
    Storage.Data = {}
    pcall(function() Storage.Data = Decode(readfile(storageKey) or "{}") end)
    task.spawn(function() while task.wait(Storage.WRITE_DELAY) do Storage:Save() end end)

    -- --------------------------------------------------------
    -- Main loop bootstrap
    -- --------------------------------------------------------
    CreateTraceback("Initalize", "Initalizing script..")
    local _notInitList = {}
    SetTask("MainTask", "n/a")
    SetTask("SubTask",  "n/a")
    ParsingTimes = 0

    function RefreshTasksData()
        if _G.Stop then return end
        -- CDK raid-priority fast path (unchanged logic)
        do
            local Senque  = FunctionsHandler.PirateRaid:Get("Senque")
            local RaidUp  = Senque and os.time() - Senque < 500
            if RaidUp and ScriptStorage.PlayerData.Level >= 2200 and SeaIndex == 3
                and not ScriptStorage.Backpack["Cursed Dual Katana"]
                and ScriptStorage.Backpack.Tushita and ScriptStorage.Backpack.Tushita.Mastery >= 350
                and ScriptStorage.Backpack.Yama    and ScriptStorage.Backpack.Yama.Mastery    >= 350
                and os.time() - (CdkRaidPeekTime or 0) > 3 then
                CdkRaidPeekTime = os.time()
                local ok, prog = pcall(function() return Remotes.CommF_:InvokeServer("CDKQuest","Progress") end)
                CdkRaidPriority = ok and prog and prog.Good and prog.Good <= -3 and prog.Good >= -5
                    and (prog.Good + 2) * -1 == 2
            elseif not RaidUp then
                CdkRaidPriority = false
            end
            local CDK = FunctionsHandler.CursedDualKatana
            if CdkRaidPriority and CDK and CDK.Initalized then
                local h = CDK.Methods.Refresh:Call(ParsingTimes < 100)
                ParsingTimes = ParsingTimes + 1
                if h and ParsingTimes > 100 then
                    CurrentTask = "CursedDualKatana"
                    ScriptStorage.Interface.SetText("DebugLine", "CursedDualKatana")
                    CDK.Methods.Start:Call(h); return
                end
            end
            local WT = FunctionsHandler.Wenlocktoad
            if WenlocktoadState == 1 and WT and WT.Initalized then
                local h = WT.Methods.Refresh:Call(ParsingTimes < 100)
                ParsingTimes = ParsingTimes + 1
                if h and ParsingTimes > 100 then
                    CurrentTask = "Wenlocktoad"
                    ScriptStorage.Interface.SetText("DebugLine", "Wenlocktoad")
                    WT.Methods.Start:Call(h); return
                end
            end
        end
        for _, taskName in TasksOrder do
            local module = FunctionsHandler[taskName]
            if not module.Initalized then
                if not _notInitList[taskName] then _notInitList[taskName] = true end
            else
                local refreshFn = module.Methods.Refresh
                local startFn   = module.Methods.Start
                if refreshFn then
                    local result = refreshFn:Call(ParsingTimes < 100)
                    ParsingTimes = ParsingTimes + 1
                    if result and ParsingTimes > 100 then
                        CurrentTask = taskName
                        ScriptStorage.Interface.SetText("DebugLine", taskName)
                        startFn:Call(result); return
                    end
                end
            end
        end
    end

    SetText("MainTextLabel", "Refreshing Player Items..")
    AddPoint()
    QM:RefreshQuest()
    RefreshInventory()
    Remotes.CommE.OnClientEvent:Connect(function(...)
        local args = { ... }
        if string.find(args[1], "Item") then RefreshInventory() end
    end)
    RefreshRace()
    Players.LocalPlayer.Idled:Connect(function()
        Services.VirtualUser:CaptureController()
        Services.VirtualUser:ClickButton2(Vector2.new())
    end)
    SetText("MainTextLabel", "Loaded In " .. tick() - StartTick .. "ms!")

    -- GetServers cache
    QueueList = {}
    local function IfTableHaveIndex(t) for _ in t do return true end end
    function GetServers()
        if LastServersDataPulled and os.time() - LastServersDataPulled < 60 then return CachedServers end
        for page = 1, 100 do
            local result = game:GetService("ReplicatedStorage"):WaitForChild("__ServerBrowser"):InvokeServer(page)
            if IfTableHaveIndex(result) then
                LastServersDataPulled = os.time()
                CachedServers         = result
                return result
            end
        end
    end
    task.spawn(function() pcall(GetServers); while task.wait(180) do pcall(GetServers) end end)

    -- --------------------------------------------------------
    -- Background 1.5s loop — seat eject, player data, timers
    -- --------------------------------------------------------
    task.spawn(function()
        while task.wait(1.5) do
            if not _G.Stop then
                -- Seat eject (skips own boat's VehicleSeat)
                pcall(function()
                    local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
                    if hum and hum.Sit then
                        local onOwnBoat = false
                        if hum.SeatPart then
                            local myBoat = Services.Workspace.Boats:FindFirstChild(GetMyBoatName())
                            onOwnBoat    = myBoat and hum.SeatPart == myBoat:FindFirstChild("VehicleSeat")
                        end
                        if not onOwnBoat then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
                    end
                end)
                pcall(RefreshPlayerData)
                if os.time() - (LastRaceRefresh or 0) > 10 then
                    LastRaceRefresh = os.time()
                    pcall(RefreshRace)
                end
                local elapsed        = os.time() - StartTick
                local currentSession = elapsed + OldSessionTime
                writefile(".tdif-" .. game.Players.LocalPlayer.Name, tostring(currentSession))
                if ScriptStorage.Interface then
                    SetText("LiveTime",
                        "Total Elapsed Time: " .. DispTime(currentSession, true) ..
                        " Elapsed Time: " .. DispTime(elapsed, true))
                end
                RefreshDebounce = os.time()
            end
        end
    end)

    -- --------------------------------------------------------
    -- Webhook
    -- --------------------------------------------------------
    local Logo = "https://cdn.discordapp.com/attachments/1452263532489080924/1475940850105319495/EAAB692B-49F8-4132-972F-9BF3C1195E1C.png?ex=69f10d88&is=69efbc08&hm=a64ca084d9f7eecfabdea324f89419d3f1b0a3411a55f621f55e12c2a13f7e85&"

    local function GetRaceGrade()
        local ok, grade = pcall(function()
            local bp = game.Players.LocalPlayer.Backpack
            local ch = game.Players.LocalPlayer.Character
            local function has(n) return (bp and bp:FindFirstChild(n)) or (ch and ch:FindFirstChild(n)) end
            if has("Awakening")   then return "V4" end
            if has("Last Resort") or has("Agility") or has("Water Body") or has("Heavenly Blood")
                or has("Heightened Senses") or has("Energy Core") or has("Primordial Reign") then return "V3" end
            if game.Players.LocalPlayer.Data.Race:FindFirstChild("Evolved") then return "V2" end
            return "V1"
        end)
        return ok and grade or "V1"
    end

    function SendWebhook(taskLabel)
        local url = getgenv().Studio["Blox Fruit"]["Webhook"]["Url"]
        if not url or url == "" then return end
        local pd        = ScriptStorage.PlayerData or {}
        local function safeStr(v) return tostring(v or "N/A") end
        local MeleeList, SwordList, GunList, AccList, FruitList, MaterialList = {}, {}, {}, {}, {}, {}
        for name, lvl in pairs(ScriptStorage.Melees or {}) do
            if type(lvl) == "number" and lvl > 0 then
                table.insert(MeleeList, name .. ": Lv." .. lvl)
            end
        end
        pcall(function()
            local inv = Remotes.CommF_:InvokeServer("getInventory")
            if type(inv) ~= "table" then return end
            for _, item in pairs(inv) do
                if type(item) == "table" and item.Name then
                    local mas = " (Mas:" .. tostring(item.Mastery or 0) .. ")"
                    if     item.Type == "Sword"      then table.insert(SwordList,    item.Name .. mas)
                    elseif item.Type == "Gun"        then table.insert(GunList,      item.Name .. mas)
                    elseif item.Type == "Wear"       then table.insert(AccList,      item.Name)
                    elseif item.Type == "Blox Fruit" then
                        local dname = item.DisplayName or item.Name
                        local val   = item.Value and Price(item.Value) or "?"
                        table.insert(FruitList, dname .. " (" .. val .. ")")
                    elseif item.Type == "Material"   then
                        table.insert(MaterialList, item.Name .. " x" .. tostring(item.Count or 1))
                    end
                end
            end
        end)
        local function listOrNone(t) return #t > 0 and table.concat(t, "\n") or "None" end
        local fruit = pd.DevilFruit
        fruit = (type(fruit) == "string" and fruit ~= "" and fruit ~= "None") and fruit or "None"
        local accountData = string.format(
            "Level     : %s\nRace      : %s (%s)\nFruit     : %s\nBeli      : %s\nFragments : %s\nTask      : %s",
            safeStr(pd.Level), safeStr(pd.Race), GetRaceGrade(), fruit,
            Price(pd.Beli or 0), Price(pd.Fragments or 0),
            safeStr(ScriptStorage.Task and ScriptStorage.Task.MainTask))
        local payload = {
            content    = tostring(getgenv().Studio["Blox Fruit"]["Webhook"]["Ping Notify"] or ""),
            username   = "Vxeze Hub",
            avatar_url = Logo,
            embeds = {{
                title       = "Blox Fruit - Kaitun Completed!",
                description = "**Character:** ||" .. game.Players.LocalPlayer.Name .. "||",
                color       = 11400703,
                fields = {
                    { name = "Account Data", value = "```\n" .. accountData               .. "\n```", inline = false },
                    { name = "Melee",        value = "```\n" .. listOrNone(MeleeList)     .. "\n```", inline = false },
                    { name = "Sword",        value = "```\n" .. listOrNone(SwordList)     .. "\n```", inline = false },
                    { name = "Gun",          value = "```\n" .. listOrNone(GunList)       .. "\n```", inline = false },
                    { name = "Fruits",       value = "```\n" .. listOrNone(FruitList)     .. "\n```", inline = false },
                    { name = "Accessories",  value = "```\n" .. listOrNone(AccList)       .. "\n```", inline = false },
                    { name = "Materials",    value = "```\n" .. listOrNone(MaterialList)  .. "\n```", inline = false },
                },
                thumbnail = { url = Logo },
                footer    = { text = "- Vxeze Hub : BF Kaitun | " .. os.date("%H:%M:%S"), icon_url = Logo },
            }},
        }
        pcall(function()
            request({
                Url     = url,
                Method  = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body    = HttpService:JSONEncode(payload),
            })
        end)
    end

    task.spawn(function()
        local delay = math.max(60, (getgenv().Studio["Blox Fruit"]["Webhook"]["Delay"] or 60) * 60)
        while task.wait(delay) do
            task.spawn(function() SendWebhook(ScriptStorage.Task and ScriptStorage.Task.MainTask) end)
        end
    end)
    task.delay(5, function()
        task.spawn(function() SendWebhook("Script Started | " .. game.Players.LocalPlayer.Name) end)
    end)

    -- --------------------------------------------------------
    -- Startup finish + main 0.15s loop
    -- --------------------------------------------------------
    AddPoint()
    Remotes.CommF_:InvokeServer("Cousin","Buy")
    task.spawn(function()
        task.wait(getgenv().Studio["Blox Fruit"]["Sub"]["Setting Player"]["Hop"]["Delay"])
        if getgenv().Studio["Blox Fruit"]["Sub"]["Setting Player"]["Hop"]["Enable"] then
            Hop("Singapore")
        end
    end)

    while task.wait(0.15) do
        if getgenv().Studio["Blox Fruit"]["Sub"]["Setting Player"]["Hop When Idle"]
            and LastIdling and os.time() - LastIdling > 300.0 then
            SetTask("MainTask","Rejoinjng due idle in 10 min!")
            task.wait(1)
            while task.wait() do Hop("Singapore") end
        end
        if not AnimationDelay or os.time() - AnimationDelay > 60 then
            AnimationDelay = os.time()
            pcall(function()
                LocalPlayer.Character:WaitForChild("Humanoid"):LoadAnimation(K):Play()
            end)
        end
        FunctionsHandler.MeleesController.Methods.Start:Call()
        local ok, err = xpcall(RefreshTasksData, debug.traceback)
        if not ok then warn(err) end
    end
end

_nguoitinhcuae()
