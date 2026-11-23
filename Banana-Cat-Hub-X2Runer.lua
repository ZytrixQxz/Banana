-- Compat (Delta/Android): executores sem "syn" nao quebram mais em syn.request
local syn = type(syn) == "table" and syn or {}
local Features = {}
local blackScreen, blackScreen2, HttpService, rejectWhitelist, nextEntry2, nextEntry3, nextEntry
local logPrefix, hasEntry, entryKey, hasEntry2, entryValue, entryKey2, hasEntry3, entryValue2
local result, entryKey3, hasEntry4, entryValue3, entryKey4, hasEntry5, entryValue4, entryKey5
local hasEntry6, entryValue5, entryKey6, hasEntry7, entryValue6, entryKey7, hasEntry8, entryKey8
local entryKey9, hasEntry9, entryValue7, entryKey10, hasEntry10, entryValue8, entryKey11, hasEntry11
local entryValue9, entryKey12, hasEntry12, entryValue10, hasEntry13, entryKey13, hasEntry14
local entryKey14, entryValue11, hasEntry15, hasEntry22, hasEntry32, hasEntry42, entryValue22
local entryValue32, entryKey15, entryValue42, entryValue52, entryKey22, result2, createToggle
local createToggle2, tweenService
local Runtime = {}

-- The key system is disabled; keep a correctly sized internal value for legacy checks.
if type(getgenv) == "function" then
    local env = getgenv()
    if not env.Key or env.Key == "" then
        env.Key = string.rep("0", 24)
    end
end
if not _G.Key or _G.Key == "" then
    _G.Key = string.rep("0", 24)
end

local function createIterator(iterator, state, control)
    return coroutine.wrap(function()
        for key, value in iterator, state, control do
            coroutine.yield(true, key, value)
        end
    end)
end

Runtime.iterationResults = {}
do
    Runtime.features = {}

    -- Key verification disabled: local authorization for the script owner.
    function Features.verifyWhitelistSession()
        local sharedState, sharedState2, sharedState3, sharedState4, sharedState5, sharedState6 = {}, {}, {}, {}, {}, {}
        local value = bit32.band(Runtime.guardState18, 4294967295)
        local value2 = bit32.band(Runtime.numberValue6, 4294967295)
        local value3 = bit32.band(value, 65535)
        local value4 = bit32.rshift(value, 16)
        local value5 = bit32.band(value2, 65535)
        local guardState20 = bit32.band(value3 * value5 + bit32.lshift(bit32.band(
            value3 * bit32.rshift(value2, 16) + value4 * value5, 65535
        ), 16), 4294967295)
        local val = Runtime.encodeHex(289181186, Runtime.transformWhitelistField(
            "c6949ccd512754b94f27f4029fc0acc15de67945a0d401721f1c2abe46c4a8c3",
            "val", "val", Runtime.whitelistKey .. Runtime.hardwareId
        ))
        Runtime.verificationResponse = {
            Body = game:GetService("HttpService"):JSONEncode({success = true, val = val}),
            StatusCode = 200
        }
        Runtime.verificationError = nil
        Runtime.guardState20 = guardState20
        Runtime.guardKey = 4201837151
        Runtime.guardState19 = Runtime.guardState20 // 26
        return sharedState, sharedState2, sharedState3, sharedState4, sharedState5, sharedState6,
            0, true, nil, nil, true
    end

    -- Initialize settings
    function Features.initializeSettings()
        local genv = getgenv()
        local genv2 = getgenv()
        local genv3 = getgenv()
        Runtime.guardState21 = Runtime.guardState19 - Runtime.guardKey
        genv.__BF_BOOT_STAGE = "Before bootstrap"
        genv2.__BF_BOOT_ERRORS = {}
        genv3.__BF_BOOT_RECENT = {}

        getgenv().__BF_BOOT_SAVE = function()
            pcall(function()
                local numberValue = 3019189147
                local numberValue2 = 4226521538
                if not isfolder("Banana Cat Hub") then
                    makefolder("Banana Cat Hub")
                end
                local bfBootErrors = getgenv().__BF_BOOT_ERRORS
                local bfBootRecent = getgenv().__BF_BOOT_RECENT
                local value = writefile
                local text = [[Last startup marker: %s
Elapsed: %.1fs | PlaceId: %s | JobId: %s | Executor: %s

Client errors during startup (may include game scripts):
%s

Recent output, oldest first (last 60 lines, E=error W=warn):
%s]]
                local format = ("Last startup marker: %s\010Elapsed: %.1fs | PlaceId: %s | JobId: %s | Executor: %s\010\010Client errors during startup (may include game scripts):\010%s\010\010Recent output, oldest first (last 60 lines, E=error W=warn):\010%s").format
                local text2 = tostring(getgenv().__BF_BOOT_STAGE)
                local numberValue3
                if getgenv().__BF_T0 then
                    numberValue3 = os.clock() - getgenv().__BF_T0 or 0
                else
                    numberValue3 = 0
                end
                local text3 = tostring(game.PlaceId)
                local text4 = tostring(game.JobId)
                local value2 = tostring
                local value3 = select(1, identifyexecutor())
                local value4 = value2(value3 or "?")
                local text5
                if #bfBootErrors > 0 then
                    text5 = table.concat(bfBootErrors, "\n\n") or "(none)"
                else
                    text5 = "(none)"
                end
                local text6
                if not (#bfBootRecent > 0) then
                    text6 = "(none)"
                    value(
                        "Banana Cat Hub/StartupError.txt",
                        format(text, text2, numberValue3, text3, text4, value4, text5, text6)
                    )
                    return
                end
                text6 = table.concat(bfBootRecent, "\n") or "(none)"
                value(
                    "Banana Cat Hub/StartupError.txt",
                    format(text, text2, numberValue3, text3, text4, value4, text5, text6)
                )
            end)
        end

        getgenv().__BF_BOOT_SAVE()
        local genv4 = getgenv()
        local genv5 = getgenv()
        Runtime.now = os.clock()
        genv4.__BF_T0 = Runtime.now
        genv5.__BF_TIMES = {}

        getgenv().__BF_MARK = function(inputValue)
            local bfTimes = getgenv().__BF_TIMES
            bfTimes[#bfTimes + 1] = ("%6.2fs  %s"):format(os.clock() - getgenv().__BF_T0, inputValue)
            pcall(writefile, "Banana Cat Hub/StartupTiming.txt", table.concat(bfTimes, "\n"))
        end

        Runtime.guardKey27 = Runtime.guardKey + 3790572595
        getgenv().__BF_MARK("script start")
        local genv6 = getgenv()
        local genv7 = getgenv()
        local genv8 = getgenv()

        local handler = function()

        end

        local handler2 = function()

        end

        genv6.__BF_PROGRESS = handler
        genv7.__BF_PROGRESS_CLOSE = handler2
        genv8.__BF_PROGRESS_DONE = nil

        local handler3 = function()
            local numberValue = 3877586245
            local numberValue2 = 541401674
            local numberValue3 = 54730228
            local TweenService = game:GetService("TweenService")
            local CoreGui
            if typeof(gethui) ~= "function" then
                CoreGui = game:GetService("CoreGui")
            else
                CoreGui = gethui()
                if not CoreGui then
                    CoreGui = game:GetService("CoreGui")
                end
            end
            local bananaCatLoading = CoreGui:FindFirstChild("BananaCatLoading")
            if bananaCatLoading then
                bananaCatLoading:Destroy()
            end

            local handler4 = function(inputValue, inputValue2, inputValue3, parent)
                local instance = Instance.new(inputValue)
                local value, value2, value3 = pairs(inputValue3)
                local b_1 = 2
                local nextEntry4 = createIterator(value, value2, value3)
                local hasEntry16, entryKey16, entryValue12 = nextEntry4()
                if hasEntry16 then
                    local value4 = entryKey16
                    local value5 = entryValue12
                    while true do
                        instance[value4] = value5
                        local hasEntry17, entryKey17, entryValue13 = nextEntry4()
                        if not hasEntry17 then
                            break
                        end
                        value4 = entryKey17
                        value5 = entryValue13
                    end
                end
                local value4
                nextEntry4 = value4
                local value5
                local value6 = value5
                local value7
                local value8 = value7
                local b_0
                b_1 = b_0
                instance.Parent = parent
                return instance
            end

            local numberValue4 = 506598587

            local handler5 = function(inputValue, inputValue2, inputValue3, inputValue4)
                local tween = TweenService:Create(
                    inputValue,
                    TweenInfo.new(inputValue2, inputValue4 or Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                    inputValue3
                )
                if numberValue4 + 323608175 == 227019298 then
                    numberValue4 = bit32.bxor(numberValue4, 4070878237)
                end
                tween:Play()
            end

            local color = Color3.new(0.55686277151107788, 0.55686277151107788, 0.57647061347961426)
            local numberValue5 = numberValue + 2583408844
            numberValue4 = 386844895
            local ScreenGui = handler4("ScreenGui", 162918983, {
                Name = "BananaCatLoading",
                IgnoreGuiInset = true,
                ResetOnSpawn = false,
                DisplayOrder = 1000,
            })

            local handler6 = function(inputValue, inputValue2, inputValue3)
                local value, value2, value3 = ipairs(inputValue)
                local b_1 = 2
                local nextEntry4 = createIterator(value, value2, value3)
                local hasEntry16, entryKey16, entryValue12 = nextEntry4()
                if not hasEntry16 then
                    return
                end
                do
                    local value4 = entryValue12
                    while true do
                        local data
                        if value4:IsA("TextLabel") then
                            data = {TextTransparency = inputValue2}
                        else
                            data = {BackgroundTransparency = inputValue2}
                        end
                        handler5(value4, inputValue3, data)
                        local hasEntry17, entryKey17, entryValue13 = nextEntry4()
                        if hasEntry17 then
                            value4 = entryValue13
                            continue
                        end
                        break
                    end
                end
            end

            local Frame = handler4("Frame", 162918983, {
                AnchorPoint = Vector2.new(0.5, 0),
                Position = UDim2.new(0.5, 0, 0, 18),
                Size = UDim2.new(0, 110, 0, 28),
                BackgroundColor3 = Color3.new(0, 0, 0),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ClipsDescendants = true,
            }, ScreenGui)
            local UICorner = handler4("UICorner", 162918983, {CornerRadius = UDim.new(0, 14)}, Frame)
            local UIStroke = handler4("UIStroke", 162918983, {Color = Color3.new(1, 1, 1), Transparency = 1, Thickness = 1}, Frame)
            local data = {}
            local value = bit32.band(numberValue2, numberValue5)
            data.AnchorPoint = Vector2.new(0, 0.5)
            data.Position = UDim2.new(0, 16, 0.5, 0)
            data.Size = UDim2.new(0, 7, 0, 7)
            data.BackgroundColor3 = Color3.new(0.039215687662363052, 0.51764708757400513, 1)
            data.BackgroundTransparency = 1
            local numberValue6 = numberValue3 + value
            data.BorderSizePixel = 0
            local Frame2 = handler4("Frame", 162918983, data, Frame)
            handler4("UICorner", 162918983, {CornerRadius = UDim.new(1, 0)}, Frame2)
            local TextLabel = handler4("TextLabel", 162918983, {
                Position = UDim2.new(0, 32, 0, 0),
                Size = UDim2.new(1, -40, 1, 0),
                BackgroundTransparency = 1,
                TextTransparency = 1,
                Text = "Banana Loading UI Progress",
                Font = Enum.Font.GothamMedium,
                TextSize = 13,
                TextColor3 = Color3.new(1, 1, 1),
                TextXAlignment = Enum.TextXAlignment.Left,
            }, Frame)
            local Frame3 = handler4("Frame", 162918983, {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Size = UDim2.new(0, 292, 0, 56),
                BackgroundTransparency = 1,
            }, Frame)
            local numberValue7 = numberValue5 + numberValue6
            local TextLabel2 = handler4("TextLabel", 162918983, {
                Position = UDim2.new(0, 18, 0, 9),
                Size = UDim2.new(0, 210, 0, 20),
                BackgroundTransparency = 1,
                TextTransparency = 1,
                Text = "Banana Loading UI Progress",
                Font = Enum.Font.GothamSemibold,
                TextSize = 14,
                TextColor3 = Color3.new(1, 1, 1),
                TextXAlignment = Enum.TextXAlignment.Left,
            }, Frame3)
            local TextLabel3 = handler4("TextLabel", 162918983, {
                Position = UDim2.new(0, 214, 0, 9),
                Size = UDim2.new(0, 60, 0, 20),
                BackgroundTransparency = 1,
                TextTransparency = 1,
                Text = "0%",
                Font = Enum.Font.GothamMedium,
                TextSize = 13,
                TextColor3 = color,
                TextXAlignment = Enum.TextXAlignment.Right,
            }, Frame3)
            local Frame4 = handler4("Frame", 162918983, {
                Position = UDim2.new(0, 18, 0, 38),
                Size = UDim2.new(0, 256, 0, 4),
                BackgroundColor3 = Color3.new(0.22745098173618317, 0.22745098173618317, 0.23529411852359772),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
            }, Frame3)
            local Frame5 = handler4("Frame", 162918983, {
                Size = UDim2.new(0.019999999552965164, 0, 1, 0),
                BackgroundColor3 = Color3.new(1, 1, 1),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
            }, Frame4)
            handler4("UICorner", 162918983, {CornerRadius = UDim.new(1, 0)}, Frame4)
            local numberValue8 = value - 2214463702 + numberValue7
            handler4("UICorner", 162918983, {CornerRadius = UDim.new(1, 0)}, Frame5)
            local data2 = {Frame2, TextLabel}
            local data3 = {TextLabel2, TextLabel3, Frame4, Frame5}
            ScreenGui.Parent = CoreGui
            handler5(
                Frame,
                0.55,
                {Size = UDim2.new(0, 236, 0, 36), BackgroundTransparency = 0},
                Enum.EasingStyle.Back
            )
            local value2 = bit32.band(numberValue7, 3164798330)
            handler5(UICorner, 0.55, {CornerRadius = UDim.new(0, 18)})
            handler5(UIStroke, 0.55, {Transparency = 0.86})
            handler6(data2, 0, 0.4)
            local condition = false
            task.spawn(function()
                while ScreenGui.Parent do
                    if not condition then
                        handler5(Frame2, 0.8, {BackgroundTransparency = 0.65})
                        task.wait(0.8)
                        if not condition then
                            handler5(Frame2, 0.8, {BackgroundTransparency = 0})
                        end
                        task.wait(0.8)
                        continue
                    end
                    break
                end
            end)
            local now = os.clock()
            local condition2 = false
            local condition3 = false

            local handler7 = function()
                while ScreenGui.Parent do
                    if not condition3 then
                        task.wait(1)
                        if not condition2 and (not condition3 and os.clock() - now > 48) then
                            if not condition then
                                getgenv().__BF_PROGRESS(0)
                            end
                            condition2 = true
                            local value3 = TextLabel2
                            local value4 = TextLabel3
                            TextLabel2.Text = "Stalled. See StartupError.txt"
                            value3.TextSize = 12
                            value4.TextColor3 = Color3.new(1, 0.62352943420410156, 0.039215687662363052)
                        end
                        continue
                    end
                    break
                end
            end

            task.spawn(handler7)
            local numberValue9 = numberValue8 + 484051506

            local handler8 = function(inputValue)
                local numberValue10 = 3724671619
                local value3 = inputValue
                now = os.clock()
                if condition2 then
                    condition2 = false
                    local value4 = TextLabel2
                    local value5 = TextLabel3
                    local value6 = color
                    TextLabel2.Text = "Banana Loading UI Progress"
                    value4.TextSize = 14
                    value5.TextColor3 = value6
                end
                if not condition then
                    condition = true
                    handler6(data2, 1, 0.15)
                    handler5(Frame, 0.55, {Size = UDim2.new(0, 310, 0, 60)}, Enum.EasingStyle.Back)
                    handler5(UICorner, 0.55, {CornerRadius = UDim.new(0, 26)})
                    local numberValue11 = 395440303

                    local handler9 = function()
                        handler5(TextLabel2, 0.35, {TextTransparency = 0})
                        handler5(TextLabel3, 0.35, {TextTransparency = 0})
                        handler5(Frame4, 0.35, {BackgroundTransparency = 0})
                        handler5(Frame5, 0.35, {BackgroundTransparency = 0})
                    end

                    numberValue11 = 496785630
                    task.delay(0.2, handler9)
                end
                TextLabel3.Text = value3 .. "%"
                return "Z"
            end

            numberValue9 = 503856431
            getgenv().__BF_PROGRESS = handler8

            getgenv().__BF_PROGRESS_CLOSE = function()
                local genv9 = getgenv()
                local genv10 = getgenv()

                local handler9 = function()

                end

                local handler10 = function()

                end

                genv9.__BF_PROGRESS = handler9
                genv10.__BF_PROGRESS_CLOSE = handler10
                condition3 = true
                local value3 = TextLabel2
                local value4 = TextLabel3
                local value5 = color
                TextLabel2.Text = "Banana Loading UI Progress"
                value3.TextSize = 14
                value4.TextColor3 = value5
                TextLabel3.Text = "Ready"
                handler5(Frame5, 0.3, {Size = UDim2.new(1, 0, 1, 0)})
                task.delay(0.7, function()
                    handler6(data3, 1, 0.25)
                    handler6(data2, 1, 0.25)
                    handler5(Frame, 0.45, {Size = UDim2.new(0, 110, 0, 28), BackgroundTransparency = 1})
                    handler5(UICorner, 0.45, {CornerRadius = UDim.new(0, 14)})
                    handler5(UIStroke, 0.45, {Transparency = 1})
                    task.delay(0.6, function()
                        ScreenGui:Destroy()
                    end)
                end)
            end
        end

        pcall(handler3)
        pcall(function()
            local numberValue = 525384568
            if getgenv().__BF_BOOT_LOG_CONNECTION then
                getgenv().__BF_BOOT_LOG_CONNECTION:Disconnect()
            end
            if getgenv().__BF_BOOT_TRACE_CONNECTION then
                getgenv().__BF_BOOT_TRACE_CONNECTION:Disconnect()
            end
            local genv9 = getgenv()
            local error = game:GetService("ScriptContext").Error
            local numberValue2 = 62324742

            local handler4 = function(inputValue, inputValue2, inputValue3)
                local bfBootErrors = getgenv().__BF_BOOT_ERRORS
                local numberValue3 = #bfBootErrors + 1
                local text = tostring(getgenv().__BF_BOOT_STAGE)
                local text2 = tostring(inputValue)
                local text3 = tostring(inputValue2)
                local fullName
                if inputValue3 then
                    fullName = inputValue3:GetFullName() or "?"
                else
                    fullName = "?"
                end
                bfBootErrors[numberValue3] = "[Trace] After " .. text .. ":\n" .. text2 .. "\n" .. text3 .. "\nScript: " .. fullName
                if #bfBootErrors > 100 then
                    table.remove(bfBootErrors, 1)
                end
                getgenv().__BF_BOOT_SAVE()
            end

            numberValue2 = 216687120
            genv9.__BF_BOOT_TRACE_CONNECTION = error:Connect(handler4)
            local genv10 = getgenv()
            local bfBootWatch = getgenv().__BF_BOOT_WATCH
            bit32.band(numberValue, 793207186)
            genv10.__BF_BOOT_WATCH = (bfBootWatch or 0) + 1
            local bfBootWatch2 = getgenv().__BF_BOOT_WATCH
            local value = nil
            local now = os.clock()
            task.spawn(function()
                while getgenv().__BF_BOOT_WATCH == bfBootWatch2 do
                    if not getgenv().__BF_LOADED then
                        task.wait(5)
                        if value ~= getgenv().__BF_BOOT_STAGE then
                            local bfBootStage = getgenv().__BF_BOOT_STAGE
                            local now2 = os.clock()
                            value = bfBootStage
                            now = now2
                        elseif os.clock() - now >= 20 then
                            local bfBootRecent = getgenv().__BF_BOOT_RECENT
                            local numberValue3 = #bfBootRecent + 1
                            local value2 = tostring
                            bfBootRecent[numberValue3] = ("[HANG?] %.0fs without a new stage after: %s"):format(os.clock() - now, value2(value))
                            getgenv().__BF_BOOT_SAVE()
                            now = os.clock()
                        end
                        continue
                    end
                    break
                end
            end)
            local genv11 = getgenv()
            local messageOut = game:GetService("LogService").MessageOut
            local numberValue3 = 322479168

            local handler5 = function(inputValue, inputValue2)
                local numberValue4 = 1638129561
                local value2 = inputValue
                local value3 = inputValue2
                local bfBootRecent = getgenv().__BF_BOOT_RECENT
                local numberValue5 = #bfBootRecent + 1
                local value4 = bit32.band((bit32.band(numberValue3, 4294967295)), 65535)
                bit32.band(20055 * value4 + bit32.lshift(
                    bit32.band(20055 * bit32.rshift((bit32.band(numberValue3, 4294967295)), 16) + 31983 * value4, 65535),
                    16
                ), 4294967295)
                local text
                if value3 == Enum.MessageType.MessageError then
                    text = "E "
                elseif value3 ~= Enum.MessageType.MessageWarning then
                    text = "  "
                else
                    text = "W "
                end
                bfBootRecent[numberValue5] = text .. string.sub(tostring(value2), 1, 300)
                if #bfBootRecent > 60 then
                    table.remove(bfBootRecent, 1)
                end
                if string.find(value2, "[Banana Cat Hub] Loading ", 1, true) then
                    getgenv().__BF_BOOT_STAGE = value2
                    getgenv().__BF_MARK(value2)
                    local value5 = string.match(value2, "Loading %d+_[%w_]+%.lua %((%d+)%%%)")
                    if (string.match(value2, "Loading %d+_[%w_]+%.lua %((%d+)%%%)")) then
                        local value6 = pcall
                        local bfProgress = getgenv().__BF_PROGRESS
                        value6(bfProgress, getgenv().__BF_PROGRESS_DONE or 0)
                        local genv12 = getgenv()
                        local value7 = bit32.bor(numberValue4, numberValue3)
                        genv12.__BF_PROGRESS_DONE = tonumber(value5)
                    end
                else
                    if value3 ~= Enum.MessageType.MessageError then
                        return
                    end
                    local bfBootErrors = getgenv().__BF_BOOT_ERRORS
                    bfBootErrors[#bfBootErrors + 1] = "After " .. tostring(getgenv().__BF_BOOT_STAGE) .. ":\n" .. tostring(value2)
                    local numberValue6 = 1874996650
                    if #bfBootErrors > 100 then
                        table.remove(bfBootErrors, 1)
                    end
                end
                getgenv().__BF_BOOT_SAVE()
            end

            numberValue3 = 241300019
            genv11.__BF_BOOT_LOG_CONNECTION = messageOut:Connect(handler5)
        end)
        print("[Banana Cat Hub] Loading 00_bootstrap.lua (6%)")
        Settings = {}
        local value = game
        HttpService = value:GetService("HttpService")
        FolderName = "Banana Cat Hub"
        SaveFileNameGame = "-BloxFruitBNNC.json"
        SaveFileName = game.Players.LocalPlayer.Name .. SaveFileNameGame

        local handler4 = function(inputValue, inputValue2, inputValue3)
            if inputValue3 ~= nil then
                Settings[inputValue] = Settings[inputValue] or ({})
                Settings[inputValue][inputValue2] = inputValue3
            elseif inputValue ~= nil then
                Settings[inputValue] = inputValue2
            end
            if not isfolder(FolderName) then
                makefolder(FolderName)
            end
            writefile(FolderName .. "/" .. SaveFileName, HttpService:JSONEncode(Settings))
        end

        SaveSettings = handler4
        local config = getgenv().Config
        return genv, genv2, genv3, genv4, genv5, genv6, genv7, genv8, handler, handler2, handler3, value, handler4, config
    end

    -- Normalize settings
    function Features.normalizeSettings()
        function ReadSetting()
            local ok, result3 = pcall(function()
                if not isfolder(FolderName) then
                    makefolder(FolderName)
                end
                return HttpService:JSONDecode(readfile(FolderName .. "/" .. SaveFileName))
            end)
            if ok then
                return result3
            end
            SaveSettings()
            return ReadSetting()
        end

        Settings = ReadSetting()
        local value = Settings
        getgenv().Settings = Settings

        function PrepareMultiSelectList(inputValue, inputValue2, inputValue3)
            local hasEntry16, entryKey16, hasEntry23, entryKey23, hasEntry33, entryKey32
            local value2, value3, data, nextEntry4, value4, value5, condition
            local data2 = {}
            local value6, value7, value8, value9, b_1, value10
            do
                local value11 = inputValue
                value2 = inputValue2
                value3 = inputValue3
                data = {}
                local value12, value13, value14 = pairs(value11)
                local b_1Result = 1
                nextEntry4 = createIterator(value12, value13, value14)
                hasEntry16, entryKey16 = nextEntry4()
                value6, value7, value8, value9, b_1, value10 = value11, value12, value13, value14, b_1Result, hasEntry16
            end
            if value10 then
                value4 = entryKey16
                while true do
                    local value11
                    if value2 then
                        local value12
                        value5 = value2[value4]
                        if value2[value4] ~= nil then
                            local value13
                            data[value4] = value2[value4]
                            hasEntry23, entryKey23 = nextEntry4()
                            if hasEntry23 then
                                value4 = entryKey23
                                continue
                            end
                        else
                            local value13
                            if value3 then
                                condition = true
                            else
                                condition = false
                            end
                            local value14
                            data[value4] = condition
                            hasEntry33, entryKey32 = nextEntry4()
                            if hasEntry33 then
                                value4 = entryKey32
                                continue
                            end
                        end
                    else
                        local value12
                        value5 = value2
                        if value2 ~= nil then
                            local value13
                            data[value4] = value2
                            hasEntry23, entryKey23 = nextEntry4()
                            if hasEntry23 then
                                value4 = entryKey23
                                continue
                            end
                        else
                            local value13
                            if value3 then
                                condition = true
                            else
                                condition = false
                            end
                            local value14
                            data[value4] = condition
                            hasEntry33, entryKey32 = nextEntry4()
                            if hasEntry33 then
                                value4 = entryKey32
                                continue
                            end
                        end
                    end
                    break
                end
            end
            return data
        end

        function EnsureAllTrueDefaults(inputValue, inputValue2)
            if type(Settings[inputValue]) ~= "table" then
                Settings[inputValue] = {}
            end
            local value2, value3, value4 = ipairs(inputValue2)
            local condition = false
            local b_1 = 2
            local nextEntry4 = createIterator(value2, value3, value4)
            while true do
                local hasEntry16, entryKey16, entryValue12 = nextEntry4()
                if hasEntry16 then
                    local value5 = entryValue12
                    local exitReason = nil
                    while true do
                        if Settings[inputValue][value5] ~= nil then
                            exitReason = 1
                        else
                            Settings[inputValue][value5] = true
                            condition = true
                            local hasEntry17, entryKey17, entryValue13 = nextEntry4()
                            if hasEntry17 then
                                value5 = entryValue13
                                continue
                            end
                        end
                        break
                    end
                    if exitReason == 1 then
                        continue
                    end
                end
                break
            end
            local value5
            nextEntry4 = value5
            local value6
            local value7 = value6
            local value8
            local value9 = value8
            local b_0
            b_1 = b_0
            if not condition then
                return
            end
            do
                local value10, value11, value12 = pairs(Settings[inputValue])
                b_1 = 2
                nextEntry4 = createIterator(value10, value11, value12)
                local hasEntry16, entryKey16, entryValue12 = nextEntry4()
                if hasEntry16 then
                    local value13 = entryKey16
                    local value14 = entryValue12
                    while true do
                        SaveSettings(inputValue, value13, value14)
                        local hasEntry17, entryKey17, entryValue13 = nextEntry4()
                        if not hasEntry17 then
                            break
                        end
                        value13 = entryKey17
                        value14 = entryValue13
                    end
                end
                return
            end
        end

        return value
    end

    -- Initialize shop page
    function Features.initializeShopPage()
        nextEntry3 = Runtime.value644
        Runtime.q02 = Runtime.value645
        Runtime.n02 = Runtime.value646
        Runtime.b02 = Runtime.value647

        getgenv().__BF_SHOW_UI = function()
            local value, value2, value3 = ipairs(Runtime.data11)
            local b_1 = 2
            local nextEntry4 = createIterator(value, value2, value3)
            while true do
                local hasEntry16, entryKey16, entryValue12 = nextEntry4()
                if hasEntry16 then
                    local value4 = entryValue12
                    local exitReason = nil
                    while true do
                        if value4.Parent then
                            value4.Enabled = true
                            local hasEntry17, entryKey17, entryValue13 = nextEntry4()
                            if hasEntry17 then
                                value4 = entryValue13
                                continue
                            end
                        else
                            exitReason = 1
                        end
                        break
                    end
                    if exitReason == 1 then
                        continue
                    end
                end
                break
            end
        end

        task.delay(120, getgenv().__BF_SHOW_UI)
        Runtime.guardState = bit32.bor(Runtime.guardState23, Runtime.numberValue11)
        pcall(result2.CreateNoti, {
            Title = "Banana Cat Hub",
            Desc = "Loading... the menu will appear when ready.",
            ShowTime = 5,
        })
        print("[Banana Cat Hub] Loading 01_shop.lua (12%)")
        PageShop = Main.CreatePage({Page_Name = "Shop", Page_Title = "Shop"})
        local options = result2.Options
        getgenv().Options = result2.Options
        SectionShopMisc = PageShop.CreateSection("Misc Shop")

        local handler = function(inputValue, inputValue2, inputValue3)
            if not inputValue and inputValue3 then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer(inputValue2, true)
                return
            end
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer(inputValue, inputValue2, inputValue3)
        end

        Remote = handler
        getgenv().tablefruitausea3 = {}
        local value = bit32.lshift(Runtime.guardKey28, 21)
        whitelistedfruit = {}
        TableDevilFruit = {}
        Runtime.n02 = 1
        Runtime.q02 = 5
        nextEntry3 = 0
        return options, handler, value
    end

    -- Load fruit and world data
    function Features.loadFruitAndWorldData()
        local sharedState, sharedState2 = {}, {}
        nextEntry3 = Runtime.value644
        Runtime.q02 = Runtime.value645
        Runtime.n02 = Runtime.value646
        Runtime.b02 = Runtime.value647
        getgenv().tablefruitausea3["Dragon (East)-Dragon (East)"] = 15000000
        getgenv().tablefruitausea3["Dragon (West)-Dragon (West)"] = 15000000
        ItemId = require(game.ReplicatedStorage.Economy.ItemId)

        function CheckFruitReal(y)
            local value, response, value2 = next, game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits", false)
            for k, value3 in value, response, value2 do
                if value3.Name == y then
                    return value3
                end
            end
        end

        SkinFruit = {}
        sharedState.value = {
            Ectoplasm = {[getgenv().CheckPlaceId2] = "TravelDressrosa"},
            ["Magma Ore"] = {[getgenv().CheckPlaceId2] = "TravelDressrosa"},
            Leather = {[getgenv().CheckPlaceId] = "TravelZou"},
            ["Scrap Metal"] = {[getgenv().CheckPlaceId] = "TravelZou"},
            ["Angel Wings"] = {[getgenv().CheckPlaceId3] = "TravelMain"},
        }
        local data = {[getgenv().CheckPlaceId] = "TravelZou"}
        sharedState2.value = bit32.bor(Runtime.guardState - 4293857663, 4293857663)
        sharedState.value["Fish Tail"] = data
        sharedState.value["Radioactive Material"] = {[getgenv().CheckPlaceId2] = "TravelDressrosa"}
        sharedState.value["Vampire Fang"] = {[getgenv().CheckPlaceId2] = "TravelDressrosa"}
        sharedState.value["Mystic Droplet"] = {[getgenv().CheckPlaceId2] = "TravelDressrosa"}
        sharedState.value["Mini Tusk"] = {[getgenv().CheckPlaceId] = "TravelZou"}
        sharedState.value.Gunpowder = {[getgenv().CheckPlaceId] = "TravelZou"}
        sharedState.value["Demonic Wisp"] = {[getgenv().CheckPlaceId] = "TravelZou"}
        sharedState.value["Dragon Scale"] = {[getgenv().CheckPlaceId] = "TravelZou"}
        sharedState.value["Conjured Cocoa"] = {[getgenv().CheckPlaceId] = "TravelZou"}
        local data2 = {}
        local genv = getgenv()
        local value = bit32.band(sharedState2.value, 752408535)
        data2[genv.CheckPlaceId] = "TravelZou"
        sharedState.value.Bones = data2
        NameWorldMaterials = sharedState.value
        Runtime.numberValue = 601179800
        Runtime.guardKey2 = 0
        NameMaterials = {
            Ectoplasm = {
                "Ship Deckhand",
                "Ship Engineer",
                "Ship Steward",
                "Ship Officer",
                "Cursed Captain",
            },
            ["Magma Ore"] = {"Lava Pirate", "Magma Ninja"},
            Leather = {"Jungle Pirate", "Musketeer Pirate"},
            ["Scrap Metal"] = {"Jungle Pirate"},
            ["Angel Wings"] = {"God's Guard", "Shanda", "Royal Squad", "Royal Soldier"},
            ["Fish Tail"] = {"Fishman Raider", "Fishman Captain"},
            ["Radioactive Material"] = {"Factory Staff"},
            ["Vampire Fang"] = {"Vampire"},
            ["Mystic Droplet"] = {"Sea Soldier", "Water Fighter"},
            ["Mini Tusk"] = {"Mythological Pirate"},
            Gunpowder = {"Pistol Billionaire"},
            ["Demonic Wisp"] = {"Demonic Soul"},
            ["Dragon Scale"] = {"Dragon Crew Archer", "Dragon Crew Warrior"},
            ["Conjured Cocoa"] = {"Cocoa Warrior", "Chocolate Bar Battler"},
            Bones = {"Reborn Skeleton", "Demonic Soul", "Living Zombie", "Posessed Mummy"},
        }
        Runtime.guardState2 = value - Runtime.numberValue
        TableMaterials = {}
        local value2 = next
        local value3 = NameMaterials
        Runtime.b02 = 2
        nextEntry3 = createIterator(value2, value3, nil)
        hasEntry, entryKey7 = nextEntry3()
        return sharedState, sharedState2, data, data2, genv, value, value2, value3, hasEntry
    end

    -- Initialize shop options
    function Features.initializeShopOptions()
        nextEntry3 = Runtime.value644
        Runtime.q02 = Runtime.value645
        Runtime.n02 = Runtime.value646
        Runtime.b02 = Runtime.value647
        SectionShopMisc.CreateButton({Title = "Redeem Code"}, function()
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("SUB2GAMERROBOT_EXP1")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("StrawHatMaine")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("Sub2OfficialNoobie")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("THEGREATACE")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("SUB2NOOBMASTER123")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("Sub2Daigrock")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("Axiore")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("TantaiGaming")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("Bluxxy")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("STRAWHATMAINE")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("3BVISITS")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("UPD16")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("Sub2Fer999")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("Enyu_is_Pro")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("JCWK")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("StarcodeHEO")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("MagicBUS")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("KittGaming")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("Sub2CaptainMaui")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("CODESLIDE")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("NOOB2ADMIN")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("NOEXPLOIT")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("FIGHT4FRUIT")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("EARN_FRUITS")
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer("EXP_5B")
        end)
        SectionShopMisc.CreateButton({Title = "Teleport Old World"}, function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({"TravelMain"}))
        end)

        local handler = function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({"TravelDressrosa"}))
        end

        SectionShopMisc.CreateButton({Title = "Teleport New World"}, handler)
        SectionShopMisc.CreateButton({Title = "Teleport Thid Sea"}, function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({"TravelZou"}))
        end)
        SectionShopMisc.CreateButton({Title = "Buy Dual Flintlock"}, function()
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Dual Flintlock")
        end)
        SectionShopMisc.CreateButton({Title = "Buy Cannon"}, function()
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Cannon")
        end)
        SectionShopMisc.CreateButton({Title = "Reroll Race"}, function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2")
        end)
        SectionShopMisc.CreateButton({Title = "Reset Stats"}, function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "1")
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2")
        end)
        SectionShopMisc.CreateButton({Title = "Buy Race Cyborg"}, function()
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CyborgTrainer", "Buy")
        end)

        local handler2 = function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm", "BuyCheck", 4)
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm", "Change", 4)
        end

        SectionShopMisc.CreateButton({Title = "Buy Race Ghoul"}, handler2)
        SectionShopFighting = PageShop.CreateSection("Fighting Shop")
        Runtime.data7 = {}
        Runtime.guardKey5 = Runtime.guardKey2 // 143 // 147
        getgenv().notsave = Runtime.data7
        Runtime.data = {
            BuyBlackLeg = "Dark Step Teacher",
            BuySuperhuman = "Martial Arts Master",
            BuySharkmanKarate = "Sharkman Teacher",
            DragonClaw = "Sabi",
            BuyDragonTalon = "Uzoth",
            BuyElectro = "Mad Scientist",
            BuyFishmanKarate = "Water Kung-fu Teacher",
            BuyDeathStep = "Phoeyu, the Reformed",
            BuyGodhuman = "Ancient Monk",
            BuyElectricClaw = "Previous Hero",
            BuySanguineArt = "Shafi",
        }
        local value = game
        NPCManager = require(value:GetService("ReplicatedStorage").NPCManager)

        function DetectNpc(y)
            local humanoidRootPart = Runtime.localPlayer2.Character and Runtime.localPlayer2.Character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then
                return
            end
            local value2, data, numberValue, x = next, {workspace.NPCs, game:GetService("ReplicatedStorage").NPCs}, 1 / 0
            for k, value3 in value2, data, nil do
                local value4, children, value5 = next, value3:GetChildren()
                for k2, value6 in value4, children, value5 do
                    if value6:GetAttribute("NPCLoaded") and (value6:GetAttribute("NPCReady") and (value6.Name == y and value6:FindFirstChild("HumanoidRootPart"))) then
                        k = (humanoidRootPart.Position - value6.HumanoidRootPart.Position).Magnitude
                        if (humanoidRootPart.Position - value6.HumanoidRootPart.Position).Magnitude < numberValue then
                            numberValue, x = (humanoidRootPart.Position - value6.HumanoidRootPart.Position).Magnitude, value6
                        end
                    end
                end
            end
            if not x then
                return NPCManager.getNPCsByName(y)[1]._modelState._instance
            end
            return x, numberValue
        end

        local value2 = table.pack(bit32.band(Runtime.guardState2 - Runtime.numberValue, 4294967295))
        local value3 = table.pack(bit32.band(Runtime.numberValue, 4294967295))
        local value4 = table.pack(bit32.band(value2[1], 65535))
        local value5 = table.pack(bit32.rshift(value2[1], 16))
        local value6 = table.pack(bit32.band(value3[1], 65535))
        bit32.band(
            value4[1] * value6[1] + bit32.lshift(bit32.band(value4[1] * bit32.rshift(value3[1], 16) + value5[1] * value6[1], 65535), 16),
            4294967295
        )

        local handler3 = function(inputValue)
            if inputValue then
                spawn(function()
                    while Runtime.data7["Black Leg"] do
                        if task.wait() then
                            local ok, result3 = pcall(function()
                                local value7 = DetectNpc(Runtime.data.BuyBlackLeg)
                                if Runtime.localPlayer2:DistanceFromCharacter(value7.HumanoidRootPart.Position) < 8 then
                                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBlackLeg")
                                end
                                local cFrame = value7.HumanoidRootPart.CFrame
                                getgenv().BackupTween(cFrame * CFrame.new(0, 4, 4))
                            end)
                            if result3 then
                                print(result3)
                            end
                            continue
                        end
                        break
                    end
                end)
            end
            Runtime.data7["Black Leg"] = inputValue
        end

        SectionShopFighting.CreateToggle({Title = "Black Leg", Desc = nil, Default = false}, handler3)
        SectionShopFighting.CreateToggle({Title = "Fishman Karate", Desc = nil, Default = false}, function(enabled)
            if enabled then
                spawn(function()
                    while Runtime.data7["Fishman Karate"] do
                        if task.wait() then
                            local ok, result3 = pcall(function()
                                local value7 = DetectNpc(Runtime.data.BuyFishmanKarate)
                                if Runtime.localPlayer2:DistanceFromCharacter(value7.HumanoidRootPart.Position) < 8 then
                                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
                                end
                                local cFrame = value7.HumanoidRootPart.CFrame
                                local cframe = CFrame.new
                                getgenv().BackupTween(cFrame * cframe(0, 4, 4))
                            end)
                            if result3 then
                                print(result3)
                            end
                            continue
                        end
                        break
                    end
                end)
            end
            Runtime.data7["Fishman Karate"] = enabled
        end)
        Runtime.genv = Runtime.numberValue
        return handler, handler2, value, value2, value3, value4, value5, value6, handler3
    end

    -- Initialize status and server pages
    function Features.initializeStatusAndServerPages()
        local sharedState, sharedState2 = {}, {}
        local sharedState3, sharedState4 = {}, {}
        local sharedState5 = {}
        local sharedState6 = {}
        sharedState5.value = Runtime.genv
        SectionShopFighting.CreateToggle({Title = "Electro", Desc = nil, Default = false}, function(enabled)
            if enabled then
                spawn(function()
                    while Runtime.data7.Electro do
                        if task.wait() then
                            pcall(function()
                                local value = DetectNpc(Runtime.data.BuyElectro)
                                if Runtime.localPlayer2:DistanceFromCharacter(value.HumanoidRootPart.Position) < 8 then
                                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectro")
                                end
                                local cFrame = value.HumanoidRootPart.CFrame
                                getgenv().BackupTween(cFrame * CFrame.new(0, 4, 4))
                            end)
                            continue
                        end
                        break
                    end
                end)
            end
            Runtime.data7.Electro = enabled
        end)

        local handler25 = function(dragonClaw)
            if dragonClaw then
                spawn(function()
                    while Runtime.data7.DragonClaw do
                        if task.wait() then
                            pcall(function()
                                local value = DetectNpc(Runtime.data.DragonClaw)
                                if Runtime.localPlayer2:DistanceFromCharacter(value.HumanoidRootPart.Position) < 8 then
                                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer(
                                        "BlackbeardReward",
                                        "DragonClaw",
                                        "1"
                                    )
                                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer(
                                        "BlackbeardReward",
                                        "DragonClaw",
                                        "2"
                                    )
                                end
                                local cFrame = value.HumanoidRootPart.CFrame
                                getgenv().BackupTween(cFrame * CFrame.new(0, 4, 4))
                            end)
                            continue
                        end
                        break
                    end
                end)
            end
            Runtime.data7.DragonClaw = dragonClaw
        end

        SectionShopFighting.CreateToggle({Title = "Dragon Breath", Desc = nil, Default = false}, handler25)
        SectionShopFighting.CreateToggle({Title = "SuperHuman", Desc = nil, Default = false}, function(enabled)
            if enabled then
                spawn(function()
                    while Runtime.data7.SuperHuman do
                        if task.wait() then
                            pcall(function()
                                local value = DetectNpc(Runtime.data.BuySuperhuman)
                                if Runtime.localPlayer2:DistanceFromCharacter(value.HumanoidRootPart.Position) < 8 then
                                    Remote("BuySuperhuman")
                                end
                                local cFrame = value.HumanoidRootPart.CFrame
                                getgenv().BackupTween(cFrame * CFrame.new(0, 4, 4))
                            end)
                            continue
                        end
                        break
                    end
                end)
            end
            Runtime.data7.SuperHuman = enabled
        end)
        local createToggle3 = SectionShopFighting.CreateToggle
        local data11 = {Title = "Death Step", Desc = nil}
        sharedState6.value = bit32.band(Runtime.guardKey5, sharedState5.value)
        data11.Default = false

        local handler26 = function(inputValue)
            if inputValue then
                spawn(function()
                    while Runtime.data7["Death Step"] do
                        if task.wait() then
                            pcall(function()
                                local value = DetectNpc(Runtime.data.BuyDeathStep)
                                if Runtime.localPlayer2:DistanceFromCharacter(value.HumanoidRootPart.Position) < 8 then
                                    Remote("BuyDeathStep")
                                end
                                local cFrame = value.HumanoidRootPart.CFrame
                                getgenv().BackupTween(cFrame * CFrame.new(0, 4, 4))
                            end)
                            continue
                        end
                        break
                    end
                end)
            end
            Runtime.data7["Death Step"] = inputValue
        end

        createToggle3(data11, handler26)
        SectionShopFighting.CreateToggle({Title = "Sharkman Karate", Desc = nil, Default = false}, function(enabled)
            if enabled then
                spawn(function()
                    while Runtime.data7["Sharkman Karate"] do
                        if task.wait() then
                            pcall(function()
                                local value = DetectNpc(Runtime.data.BuySharkmanKarate)
                                if Runtime.localPlayer2:DistanceFromCharacter(value.HumanoidRootPart.Position) < 8 then
                                    Remote("BuySharkmanKarate")
                                end
                                local cFrame = value.HumanoidRootPart.CFrame
                                getgenv().BackupTween(cFrame * CFrame.new(0, 4, 4))
                            end)
                            continue
                        end
                        break
                    end
                end)
            end
            Runtime.data7["Sharkman Karate"] = enabled
        end)
        local createToggle4 = SectionShopFighting.CreateToggle
        local data12 = {Title = "Electric Claw", Desc = nil}
        sharedState.value = bit32.bor(sharedState6.value, 75127078)
        data12.Default = false
        createToggle4(data12, function(inputValue)
            if inputValue then
                spawn(function()
                    while Runtime.data7["Electric Claw"] do
                        if task.wait() then
                            pcall(function()
                                local value = DetectNpc(Runtime.data.BuyElectricClaw)
                                if Runtime.localPlayer2:DistanceFromCharacter(value.HumanoidRootPart.Position) < 8 then
                                    Remote("BuyElectricClaw")
                                end
                                local cFrame = value.HumanoidRootPart.CFrame
                                getgenv().BackupTween(cFrame * CFrame.new(0, 4, 4))
                            end)
                            continue
                        end
                        break
                    end
                end)
            end
            Runtime.data7["Electric Claw"] = inputValue
        end)

        local handler27 = function(inputValue)
            if inputValue then
                spawn(function()
                    while Runtime.data7["Dragon Talon"] do
                        if task.wait() then
                            pcall(function()
                                local value = DetectNpc(Runtime.data.BuyDragonTalon)
                                if Runtime.localPlayer2:DistanceFromCharacter(value.HumanoidRootPart.Position) < 8 then
                                    Remote("BuyDragonTalon")
                                end
                                local cFrame = value.HumanoidRootPart.CFrame
                                getgenv().BackupTween(cFrame * CFrame.new(0, 4, 4))
                            end)
                            continue
                        end
                        break
                    end
                end)
            end
            Runtime.data7["Dragon Talon"] = inputValue
        end

        SectionShopFighting.CreateToggle({Title = "Dragon Talon", Desc = nil, Default = false}, handler27)
        sharedState3.value = SectionShopFighting.CreateToggle
        sharedState4.value = {Title = "God Human", Desc = nil}
        Runtime.iterationResults.value = bit32.band(sharedState5.value, 4294967295)
        local value = table.pack(bit32.band((bit32.band(sharedState5.value, 4294967295)), 65535))
        sharedState2.value = bit32.band(value[1] * 24367 + bit32.lshift(
            bit32.band(value[1] * 0 + bit32.rshift((bit32.band(sharedState5.value, 4294967295)), 16) * 24367, 65535),
            16
        ), 4294967295)
        sharedState4.value.Default = false

        local handler28 = function(inputValue)
            if inputValue then
                spawn(function()
                    while Runtime.data7["God Human"] do
                        if task.wait() then
                            pcall(function()
                                local value2 = DetectNpc(Runtime.data.BuyGodhuman)
                                if Runtime.localPlayer2:DistanceFromCharacter(value2.HumanoidRootPart.Position) < 8 then
                                    Remote("BuyGodhuman")
                                end
                                local cFrame = value2.HumanoidRootPart.CFrame
                                getgenv().BackupTween(cFrame * CFrame.new(0, 4, 4))
                            end)
                            continue
                        end
                        break
                    end
                end)
            end
            Runtime.data7["God Human"] = inputValue
        end

        sharedState3.value(sharedState4.value, handler28)
        local sharedState7 = {}

        local handler29 = function(inputValue)
            if inputValue then
                spawn(function()
                    while Runtime.data7["Sanguine Art"] do
                        if task.wait() then
                            pcall(function()
                                local value2 = DetectNpc(Runtime.data.BuySanguineArt)
                                if Runtime.localPlayer2:DistanceFromCharacter(value2.HumanoidRootPart.Position) < 8 then
                                    Remote("BuySanguineArt")
                                end
                                local cFrame = value2.HumanoidRootPart.CFrame
                                getgenv().BackupTween(cFrame * CFrame.new(0, 4, 4))
                            end)
                            continue
                        end
                        break
                    end
                end)
            end
            Runtime.data7["Sanguine Art"] = inputValue
        end

        SectionShopFighting.CreateToggle({Title = "Sanguine Art", Desc = nil, Default = false}, handler29)
        SectionShopAbilities = PageShop.CreateSection("Abilities Shop")
        SectionShopAbilities.CreateButton({Title = "Skyjump [ $10,000 Beli ]"}, function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
        end)
        sharedState7.value = sharedState2.value + 75127078

        local handler30 = function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
        end

        SectionShopAbilities.CreateButton({Title = "Buso Haki [ $25,000 Beli ]"}, handler30)

        local handler31 = function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk", "Buy")
        end

        SectionShopAbilities.CreateButton({Title = "Observation haki [ $750,000 Beli ]"}, handler31)

        local handler32 = function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Soru")
        end

        SectionShopAbilities.CreateButton({Title = "Soru [ $100,000 Beli ]"}, handler32)
        local sharedState8 = {}
        print("[Banana Cat Hub] Loading 02_status_server.lua (18%)")
        PageStatusAndServer = Main.CreatePage({Page_Name = "Status And Server", Page_Title = "Status And Server"})
        SectionStatus = PageStatusAndServer.CreateSection("Status")
        TimerLabel = SectionStatus.CreateLabel({Title = "Timer"})
        local createLabel = SectionStatus.CreateLabel
        local data13 = {}
        sharedState8.value = bit32.band(sharedState.value, 75127078)
        data13.Title = "Timer Server"
        TimerServerLabel = createLabel(data13)
        NextTimerServerLabel = SectionStatus.CreateLabel({Title = "Next Time Spawn Fist of Darkness or God's Chalice"})
        StatusEliteHunter = SectionStatus.CreateLabel({Title = "Elite"})
        StatusTyrant = SectionStatus.CreateLabel({Title = "Eyes Summon Tyrant"})
        StatusKatakuri = SectionStatus.CreateLabel({Title = "Summon Katakuri"})
        Statusspy = SectionStatus.CreateLabel({Title = "Status SPY"})
        local createLabel2 = SectionStatus.CreateLabel
        local data14 = {}
        local value21 = bit32.bor(sharedState8.value, sharedState7.value)
        data14.Title = "Mirage"
        StatusMirage = createLabel2(data14)
        StatusPrehistoricIsland = SectionStatus.CreateLabel({Title = "Prehistoric Island"})
        Runtime.guardState3 = value21
        StatusFrozenDimension = SectionStatus.CreateLabel({Title = "Frozen Dimension"})
        StatusMoon = SectionStatus.CreateLabel({Title = "Moon"})
        StatusGear = SectionStatus.CreateLabel({Title = "Acient One Status"})
        SectionServer = PageStatusAndServer.CreateSection("Server")
        SectionServer.CreateButton({Title = "Open Gui Server Browser (Low Player and Ping)"}, function()
            local handler, handler2, handler3, handler4, handler5, handler6, handler7, handler8
            local handler9, handler10, handler11, handler12, handler13, handler14, handler15
            local handler16, handler17, handler18, handler19, handler20, handler21, handler22
            local handler23, handler24
            local guardKey = 4010785821
            local numberValue6 = 340775297
            local value2 = game
            local guardState = 2307775998
            local getService = game.GetService
            local value20 = game.GetService(value2, "HttpService")
            game:GetService("TeleportService")
            local value3 = game
            local getService2 = game.GetService
            local value22 = game.GetService(value3, "Players")
            local value4 = game
            local getService3 = game.GetService
            local value5 = game.GetService(value4, "TweenService")
            local placeId = game.PlaceId
            local request2 = syn.request or http_request
            if game.CoreGui:FindFirstChild("SB_UI") then
                game.CoreGui.SB_UI:Destroy()
            end
            local numberValue = guardKey // 7
            local data9 = {
                servers = {},
                cursor = nil,
                finished = false,
                lastUpdate = 0,
                pages = 0,
            }
            local data8 = {
                CACHE_TIME = 60,
                MAX_SHOW = 50,
                PAGE_DELAY = 5,
                RETRY_MAX = 4,
                RETRY_BASE = 2,
                RETRY_JITTER = 5,
                RATE_COOLDOWN = 30,
            }
            local numberValue3 = numberValue6 + guardState + guardState
            local data10 = {
                BG = Color3.new(0.039215687662363052, 0.043137256056070328, 0.062745101749897),
                SURFACE = Color3.new(0.050980392843484879, 0.054901961237192154, 0.078431375324726105),
                ROW = Color3.new(0.062745101749897, 0.066666670143604279, 0.10196078568696976),
                ROW_HOVER = Color3.new(0.078431375324726105, 0.086274512112140656, 0.13725490868091583),
                ROW_TOP = Color3.new(0.039215687662363052, 0.086274512112140656, 0.13333334028720856),
                BORDER = Color3.new(0.10980392247438431, 0.12156862765550613, 0.18823529779911041),
                BORDER_HOV = Color3.new(0, 0.31372550129890442, 0.47058823704719543),
                CYAN = Color3.new(0, 0.83137255907058716, 1),
                CYAN_DIM = Color3.new(0, 0.31372550129890442, 0.47058823704719543),
                GREEN = Color3.new(0, 0.80000001192092896, 0.40000000596046448),
                GREEN_GLOW = Color3.new(0, 1, 0.53333336114883423),
                AMBER = Color3.new(1, 0.66666668653488159, 0),
                RED = Color3.new(1, 0.26666668057441711, 0.3333333432674408),
                TEXT_PRI = Color3.new(0.90980392694473267, 0.91764706373214722, 0.94117647409439087),
                TEXT_SEC = Color3.new(0.31372550129890442, 0.35294118523597717, 0.47058823704719543),
                TEXT_DIM = Color3.new(0.17647059261798859, 0.20392157137393951, 0.32156863808631897),
            }

            function handler8(inputValue, inputValue2, parent)
                local instance = Instance.new(inputValue)
                local value23, value24, value25 = pairs(inputValue2 or ({}))
                local b_1 = 2
                local nextEntry4 = createIterator(value23, value24, value25)
                local hasEntry16, entryKey16, entryValue12 = nextEntry4()
                if hasEntry16 then
                    local value26 = entryKey16
                    local value27 = entryValue12
                    while true do
                        instance[value26] = value27
                        local hasEntry17, entryKey17, entryValue13 = nextEntry4()
                        if not hasEntry17 then
                            break
                        end
                        value26 = entryKey17
                        value27 = entryValue13
                    end
                end
                local value26
                nextEntry4 = value26
                local value27
                local value28 = value27
                local value29
                local value30 = value29
                local b_0
                b_1 = b_0
                if parent then
                    instance.Parent = parent
                    return instance
                end
                return instance
            end

            function handler9(inputValue, inputValue2)
                return handler8("UICorner", {CornerRadius = UDim.new(0, inputValue)}, inputValue2)
            end

            function handler4(inputValue, inputValue2, inputValue3, inputValue4)
                return handler8(
                    "UIStroke",
                    {Thickness = inputValue, Color = inputValue2, Transparency = inputValue3 or 0},
                    inputValue4
                )
            end

            function handler5(inputValue, inputValue2, inputValue3, inputValue4, inputValue5)
                local value23 = value5
                local create = value5.Create
                local tweenInfo = TweenInfo.new
                local value24
                if inputValue3 then
                    if inputValue4 then
                        inputValue5 = inputValue5 or Enum.EasingDirection.Out
                    else
                        inputValue4 = Enum.EasingStyle.Quad
                        if not inputValue5 then
                            inputValue5 = Enum.EasingDirection.Out
                            value24 = create(
                                value23,
                                inputValue,
                                tweenInfo(inputValue3, inputValue4, inputValue5),
                                inputValue2
                            )
                            value24:Play()
                            return
                        end
                    end
                else
                    inputValue3 = 0.15
                    if inputValue4 then
                        if not inputValue5 then
                            inputValue5 = Enum.EasingDirection.Out
                            value24 = create(
                                value23,
                                inputValue,
                                tweenInfo(inputValue3, inputValue4, inputValue5),
                                inputValue2
                            )
                            value24:Play()
                            return
                        end
                    else
                        inputValue4 = Enum.EasingStyle.Quad
                        if not inputValue5 then
                            inputValue5 = Enum.EasingDirection.Out
                            value24 = create(
                                value23,
                                inputValue,
                                tweenInfo(inputValue3, inputValue4, inputValue5),
                                inputValue2
                            )
                            value24:Play()
                            return
                        end
                    end
                end
                create(value23, inputValue, tweenInfo(inputValue3, inputValue4, inputValue5), inputValue2):Play()
            end

            function handler10(inputValue, inputValue2, inputValue3)
                inputValue.MouseEnter:Connect(function()
                    handler5(inputValue, {BackgroundColor3 = inputValue3})
                end)
                inputValue.MouseLeave:Connect(function()
                    handler5(inputValue, {BackgroundColor3 = inputValue2})
                end)
            end

            local guardKey2 = numberValue + 2167665576

            function handler3()
                local retryJitter = data8.RETRY_JITTER
                return math.random() * retryJitter
            end

            local ScreenGui = handler8("ScreenGui", {
                Name = "SB_UI",
                ResetOnSpawn = false,
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                IgnoreGuiInset = true,
            }, game.CoreGui)
            local Frame5 = handler8("Frame", {
                Name = "Window",
                Size = UDim2.new(0, 580, 0, 500),
                Position = UDim2.new(0.5, -290, 0.5, -250),
                BackgroundColor3 = data10.SURFACE,
                BorderSizePixel = 0,
                ClipsDescendants = true,
            }, ScreenGui)
            handler9(4, Frame5)
            handler4(1, data10.BORDER, 0, Frame5)
            local value6 = nil
            local position = nil
            local position2 = nil
            local inputBegan = Frame5.InputBegan
            local numberValue2 = 498687599

            function handler(targetRoot)
                if targetRoot.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    return
                end
                value6 = true
                position = targetRoot.Position
                position2 = Frame5.Position
            end

            numberValue2 = 236368964
            Frame5.InputBegan.Connect(inputBegan, handler)
            Frame5.InputEnded:Connect(function(input)
                if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    return
                end
                value6 = false
            end)
            game:GetService("UserInputService").InputChanged:Connect(function(input)
                if not value6 then
                    return
                end
                if not (input.UserInputType == Enum.UserInputType.MouseMovement) then
                    return
                end
                do
                    local numberValue14 = input.Position - position
                    Frame5.Position = UDim2.new(
                        position2.X.Scale,
                        position2.X.Offset + numberValue14.X,
                        position2.Y.Scale,
                        position2.Y.Offset + numberValue14.Y
                    )
                    return
                end
            end)
            local data = {Size = UDim2.new(1, 0, 0, 52), BackgroundColor3 = data10.BG}
            local value7 = bit32.band(guardState // numberValue3, 4294967295)
            local value8 = bit32.band(guardKey2, 4294967295)
            local value9 = bit32.band((bit32.band(guardState // numberValue3, 4294967295)), 65535)
            local value10 = bit32.band((bit32.band(guardKey2, 4294967295)), 65535)
            local guardState2 = bit32.band((bit32.band((bit32.band(guardState // numberValue3, 4294967295)), 65535)) * (bit32.band((bit32.band(guardKey2, 4294967295)), 65535)) + bit32.lshift(bit32.band(
                (bit32.band((bit32.band(guardState // numberValue3, 4294967295)), 65535)) * bit32.rshift((bit32.band(guardKey2, 4294967295)), 16) + (bit32.rshift((bit32.band(guardState // numberValue3, 4294967295)), 16)) * (bit32.band((bit32.band(guardKey2, 4294967295)), 65535)),
                65535
            ), 16), 4294967295)
            data.BorderSizePixel = 0
            local Frame = handler8("Frame", data, Frame5)
            local data2 = {
                Size = UDim2.new(0, 300, 0, 18),
                Position = UDim2.new(0, 18, 0, 9),
                BackgroundTransparency = 1,
                Text = "SERVER BROWSER",
                TextColor3 = data10.TEXT_PRI,
                Font = Enum.Font.GothamBold,
                TextSize = 13,
            }
            local left = Enum.TextXAlignment.Left
            local guardKey3 = bit32.band(guardKey2, 1876256121)
            data2.TextXAlignment = Enum.TextXAlignment.Left
            handler8("TextLabel", data2, Frame)
            local numberValue4 = numberValue3 + guardState2 + 4218129807
            handler8("TextLabel", {
                Size = UDim2.new(0, 360, 0, 14),
                Position = UDim2.new(0, 18, 0, 30),
                BackgroundTransparency = 1,
                Text = "CACHE PAGE  ·  LOAD MORE  ·  LOWEST PLAYER / PING",
                TextColor3 = data10.TEXT_DIM,
                Font = Enum.Font.Gotham,
                TextSize = 10,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, Frame)
            local guardKey4 = guardKey3 + 4218129807
            local TextButton = handler8("TextButton", {
                Size = UDim2.new(0, 28, 0, 28),
                Position = UDim2.new(1, -42, 0, 12),
                BackgroundColor3 = Color3.new(0.10196078568696976, 0.050980392843484879, 0.050980392843484879),
                BorderSizePixel = 0,
                Text = "X",
                TextColor3 = data10.RED,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
            }, Frame)
            handler9(3, TextButton)
            handler10(
                TextButton,
                Color3.new(0.10196078568696976, 0.050980392843484879, 0.050980392843484879),
                Color3.new(0.23529411852359772, 0.078431375324726105, 0.078431375324726105)
            )
            TextButton.MouseButton1Click:Connect(function()
                ScreenGui:Destroy()
            end)
            local guardState3 = 4218129807 - numberValue4
            local Frame2 = handler8("Frame", {
                Size = UDim2.new(1, 0, 0, 42),
                Position = UDim2.new(0, 0, 0, 52),
                BackgroundColor3 = Color3.new(0.043137256056070328, 0.047058824449777603, 0.066666670143604279),
                BorderSizePixel = 0,
            }, Frame5)
            local Frame7 = handler8("Frame", {
                Size = UDim2.new(0, 6, 0, 6),
                Position = UDim2.new(0, 14, 0.5, -3),
                BackgroundColor3 = data10.TEXT_DIM,
                BorderSizePixel = 0,
            }, Frame2)
            handler9(99, Frame7)
            local numberValue5 = numberValue4 + guardState3
            local TextLabel2 = handler8("TextLabel", {
                Size = UDim2.new(1, -300, 1, 0),
                Position = UDim2.new(0, 26, 0, 0),
                BackgroundTransparency = 1,
                Text = "READY",
                TextColor3 = data10.TEXT_SEC,
                Font = Enum.Font.Gotham,
                TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, Frame2)
            local refreshLabel = handler8("TextButton", {
                Size = UDim2.new(0, 82, 0, 26),
                Position = UDim2.new(1, -270, 0.5, -13),
                BackgroundColor3 = Color3.new(0.054901961237192154, 0.086274512112140656, 0.15686275064945221),
                BorderSizePixel = 0,
                Text = "REFRESH",
                TextColor3 = Color3.new(0.39215686917304993, 0.54901963472366333, 0.78431373834609985),
                Font = Enum.Font.GothamBold,
                TextSize = 10,
            }, Frame2)
            handler9(3, refreshLabel)
            handler10(
                refreshLabel,
                Color3.new(0.054901961237192154, 0.086274512112140656, 0.15686275064945221),
                Color3.new(0.039215687662363052, 0.11764705926179886, 0.21568627655506134)
            )
            local data3 = {
                Size = UDim2.new(0, 82, 0, 26),
                Position = UDim2.new(1, -182, 0.5, -13),
                BackgroundColor3 = Color3.new(0.062745101749897, 0.12549020349979401, 0.094117648899555206),
                BorderSizePixel = 0,
                Text = "LOAD MORE",
                TextColor3 = data10.GREEN,
            }
            local font = Enum.Font
            local guardKey5 = bit32.band(guardKey4 // numberValue5, numberValue5)
            data3.Font = Enum.Font.GothamBold
            data3.TextSize = 10
            local waitLabel = handler8("TextButton", data3, Frame2)
            handler9(3, waitLabel)
            local value11 = bit32.band(numberValue6, 4294967295)
            local value12 = bit32.band((bit32.band(numberValue6, 4294967295)), 65535)
            local value13 = bit32.band(bit32.bnot(numberValue6), 4294967295)
            local value14 = bit32.band((bit32.band(bit32.bnot(numberValue6), 4294967295)), 65535)
            local numberValue7 = 2383662432 + numberValue5 + (bit32.band(13041 * (bit32.band((bit32.band(numberValue6, 4294967295)), 65535)) + bit32.lshift(bit32.band(
                13041 * bit32.rshift((bit32.band(numberValue6, 4294967295)), 16) + 24791 * (bit32.band((bit32.band(numberValue6, 4294967295)), 65535)),
                65535
            ), 16), 4294967295)) + bit32.band(13041 * (bit32.band((bit32.band(bit32.bnot(numberValue6), 4294967295)), 65535)) + bit32.lshift(bit32.band(
                13041 * bit32.rshift((bit32.band(bit32.bnot(numberValue6), 4294967295)), 16) + 24791 * (bit32.band((bit32.band(bit32.bnot(numberValue6), 4294967295)), 65535)),
                65535
            ), 16), 4294967295)
            handler10(
                waitLabel,
                Color3.new(0.062745101749897, 0.12549020349979401, 0.094117648899555206),
                Color3.new(0.039215687662363052, 0.18823529779911041, 0.10980392247438431)
            )
            local guardState4 = numberValue7
            local TextButton2 = handler8("TextButton", {
                Size = UDim2.new(0, 82, 0, 26),
                Position = UDim2.new(1, -94, 0.5, -13),
                BackgroundColor3 = Color3.new(0.14901961386203766, 0.070588238537311554, 0.070588238537311554),
                BorderSizePixel = 0,
                Text = "RESET",
                TextColor3 = data10.RED,
                Font = Enum.Font.GothamBold,
                TextSize = 10,
            }, Frame2)
            handler9(3, TextButton2)
            handler10(
                TextButton2,
                Color3.new(0.14901961386203766, 0.070588238537311554, 0.070588238537311554),
                Color3.new(0.23529411852359772, 0.078431375324726105, 0.078431375324726105)
            )
            local guardKey6 = bit32.bor(guardKey5, guardState4)
            local Frame3 = handler8("Frame", {
                Size = UDim2.new(1, 0, 0, 24),
                Position = UDim2.new(0, 0, 0, 94),
                BackgroundColor3 = Color3.new(0.043137256056070328, 0.047058824449777603, 0.066666670143604279),
                BorderSizePixel = 0,
            }, Frame5)

            function handler2(inputValue, inputValue2, inputValue3)
                handler8("TextLabel", {
                    Size = UDim2.new(0, inputValue3, 1, 0),
                    Position = UDim2.new(0, inputValue2, 0, 0),
                    BackgroundTransparency = 1,
                    Text = inputValue,
                    TextColor3 = data10.TEXT_DIM,
                    Font = Enum.Font.GothamBold,
                    TextSize = 9,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, Frame3)
            end

            handler2("#", 14, 28)
            handler2("JOB ID", 42, 170)
            local numberValue8 = numberValue7 + guardState4
            handler2("PLAYERS", 220, 80)
            handler2("PING", 310, 60)
            local ScrollingFrame = handler8("ScrollingFrame", {
                Size = UDim2.new(1, -8, 1, -172),
                Position = UDim2.new(0, 4, 0, 118),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ScrollBarThickness = 3,
                ScrollBarImageColor3 = data10.CYAN_DIM,
                CanvasSize = UDim2.new(0, 0, 0, 0),
            }, Frame5)
            local UIListLayout = handler8(
                "UIListLayout",
                {Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder},
                ScrollingFrame
            )
            handler8("UIPadding", {
                PaddingTop = UDim.new(0, 6),
                PaddingLeft = UDim.new(0, 4),
                PaddingRight = UDim.new(0, 4),
                PaddingBottom = UDim.new(0, 6),
            }, ScrollingFrame)
            local data4 = {
                Size = UDim2.new(1, 0, 0, 30),
                Position = UDim2.new(0, 0, 1, -30),
                BackgroundColor3 = Color3.new(0.039215687662363052, 0.043137256056070328, 0.058823529630899429),
            }
            local guardKey7 = bit32.rshift(guardKey6, 6)
            data4.BorderSizePixel = 0
            local Frame4 = handler8("Frame", data4, Frame5)
            local numberValue9 = numberValue8 + 3646169239
            local guardState5 = numberValue8 + 3646169239
            local TextLabel5 = handler8("TextLabel", {
                Size = UDim2.new(0.5, 0, 1, 0),
                Position = UDim2.new(0, 14, 0, 0),
                BackgroundTransparency = 1,
                Text = "PLACE · " .. tostring(placeId),
                TextColor3 = data10.TEXT_DIM,
                Font = Enum.Font.Gotham,
                TextSize = 9,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, Frame4)
            local numberValue10 = numberValue9 + guardKey7
            local TextLabel4 = handler8("TextLabel", {
                Size = UDim2.new(0.5, -14, 1, 0),
                Position = UDim2.new(0.5, 0, 0, 0),
                BackgroundTransparency = 1,
                Text = "SHOWING 0 / 0",
                TextColor3 = data10.TEXT_DIM,
                Font = Enum.Font.Gotham,
                TextSize = 9,
                TextXAlignment = Enum.TextXAlignment.Right,
            }, Frame4)
            local data5 = {
                Size = UDim2.new(1, 0, 1, -52),
                Position = UDim2.new(0, 0, 0, 52),
                BackgroundColor3 = data10.SURFACE,
                BackgroundTransparency = 0.05,
                ZIndex = 20,
            }
            local value15 = bit32.band(guardState5, 4294967295)
            local value16 = bit32.band((bit32.band(guardState5, 4294967295)), 65535)
            local value17 = bit32.band((bit32.band((bit32.band(guardState5, 4294967295)), 65535)) * 7790 + bit32.lshift(bit32.band(
                (bit32.band((bit32.band(guardState5, 4294967295)), 65535)) * 0 + bit32.rshift((bit32.band(guardState5, 4294967295)), 16) * 7790,
                65535
            ), 16), 4294967295)
            data5.Visible = false
            local Frame9 = handler8("Frame", data5, Frame5)
            local TextLabel6 = handler8("TextLabel", {
                Size = UDim2.new(1, -20, 0, 36),
                Position = UDim2.new(0, 10, 0.5, 10),
                BackgroundTransparency = 1,
                Text = "SCANNING SERVERS...",
                TextColor3 = data10.CYAN,
                Font = Enum.Font.GothamBold,
                TextSize = 10,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextWrapped = true,
                ZIndex = 21,
            }, Frame9)
            local data6 = {
                Size = UDim2.new(1, -8, 0, 28),
                Position = UDim2.new(0, 4, 0, 118),
                BackgroundColor3 = Color3.new(0.14901961386203766, 0.094117648899555206, 0.023529412224888802),
                BorderSizePixel = 0,
            }
            local guardState7 = bit32.bor(value17, 1811094654)
            data6.ZIndex = 15
            data6.Visible = false
            local Frame8 = handler8("Frame", data6, Frame5)
            handler9(3, Frame8)
            handler4(1, data10.AMBER, 0.4, Frame8)
            local numberValue11 = numberValue10 - 267514945
            local TextLabel3 = handler8("TextLabel", {
                Size = UDim2.new(1, -12, 1, 0),
                Position = UDim2.new(0, 6, 0, 0),
                BackgroundTransparency = 1,
                Text = "⏳ 429 RATE LIMITED — WAITING...",
                TextColor3 = data10.AMBER,
                Font = Enum.Font.GothamBold,
                TextSize = 10,
                TextXAlignment = Enum.TextXAlignment.Center,
                ZIndex = 16,
            }, Frame8)
            local value19 = guardState7 + 401743256

            function handler15(text)
                value19 = 3708859743
                TextLabel3.Text = text
                Frame8.Visible = true
                ScrollingFrame.Position = UDim2.new(0, 4, 0, 150)
                ScrollingFrame.Size = UDim2.new(1, -8, 1, -204)
            end

            function handler16()
                Frame8.Visible = false
                ScrollingFrame.Position = UDim2.new(0, 4, 0, 118)
                ScrollingFrame.Size = UDim2.new(1, -8, 1, -172)
            end

            local Frame6 = handler8("Frame", {
                Size = UDim2.new(0, 360, 0, 36),
                Position = UDim2.new(0.5, -180, 1, -50),
                BackgroundColor3 = Color3.new(0.039215687662363052, 0.10196078568696976, 0.15686275064945221),
                BorderSizePixel = 0,
                ZIndex = 30,
                Visible = false,
            }, Frame5)
            handler9(3, Frame6)
            local data7 = {
                Size = UDim2.new(1, -12, 1, 0),
                Position = UDim2.new(0, 6, 0, 0),
                BackgroundTransparency = 1,
                Text = "READY",
                TextColor3 = data10.CYAN,
            }
            local value18 = Enum
            value19 = bit32.bxor(value19, 50246895)
            data7.Font = Enum.Font.GothamBold
            data7.TextSize = 10
            data7.TextWrapped = true
            local guardState6 = guardState7 + numberValue11
            data7.ZIndex = 31
            local TextLabel = handler8("TextLabel", data7, Frame6)
            local thread = nil

            function handler20(text, textColor3)
                if thread then
                    task.cancel(thread)
                end
                TextLabel.Text = text
                TextLabel.TextColor3 = textColor3 or data10.CYAN
                Frame6.Visible = true
                thread = task.delay(3.5, function()
                    Frame6.Visible = false
                end)
            end

            function handler21(text, backgroundColor3)
                TextLabel2.Text = text
                Frame7.BackgroundColor3 = backgroundColor3 or data10.TEXT_DIM
            end

            function handler17(inputValue)
                local value23 = ({
                    RATE_LIMIT = "429 RATE LIMITED — TOO MANY REQUESTS",
                    FORBIDDEN = "403 FORBIDDEN — ACCESS BLOCKED",
                    UNAUTHORIZED = "401 UNAUTHORIZED",
                    SERVER_ERROR = "5xx ROBLOX SERVER ERROR",
                    NETWORK_ERROR = "NETWORK / EXECUTOR ERROR",
                    INVALID_JSON = "INVALID JSON RESPONSE",
                    EMPTY_BODY = "EMPTY RESPONSE BODY",
                })[inputValue]
                if value23 then
                    return value23
                end
                return "REQUEST FAILED: " .. tostring(inputValue)
            end

            function handler14(inputValue, inputValue2)
                local numberValue14 = 2172936233
                local value23 = inputValue
                local value24 = inputValue2
                local numberValue15 = 0
                local numberValue16 = 1
                local numberValue17 = data8.RETRY_MAX + 0
                local numberValue18 = -1
                numberValue18 += 1
                local value25, exitReason, numberValue19, value26, ok, result3, statusCode
                local numberValue20, retryBase, text, amber, amber2, numberValue21, ok2, result4
                local ok3, exitReason2, exitReason3
                if numberValue18 <= data8.RETRY_MAX + 0 then
                    value25 = numberValue18
                    exitReason = nil
                    exitReason2 = nil
                    while true do
                        numberValue19 = 368987844

                        function value26()
                            return request2({
                                Url = value23,
                                Method = "GET",
                                Headers = {["User-Agent"] = "Mozilla/5.0", Accept = "application/json"},
                            })
                        end

                        numberValue19 = 461999587
                        ok, result3 = pcall(value26)
                        if not ok then
                            break
                        end
                        if not result3 then
                            exitReason2 = 1
                            break
                        end
                        statusCode = result3.StatusCode
                        if not result3.StatusCode then
                            exitReason2 = 2
                            break
                        end
                        if result3.StatusCode ~= 429 then
                            exitReason2 = 3
                            break
                        end
                        numberValue15 += 1
                        if data8.RETRY_MAX <= value25 then
                            exitReason2 = 4
                            break
                        end
                        if numberValue15 >= 2 then
                            numberValue20 = data8.RATE_COOLDOWN + handler3()
                        else
                            retryBase = data8.RETRY_BASE
                            numberValue20 = math.pow(retryBase, value25 + 1) + handler3()
                        end
                        text = string.format(
                            "⏳ 429 RATE LIMITED — WAITING %.0fs THEN RETRYING (%d/%d)",
                            numberValue20,
                            value25 + 1,
                            data8.RETRY_MAX
                        )
                        if value24 then
                            handler15(text)
                            Frame9.Visible = false
                        else
                            Frame9.Visible = true
                            TextLabel6.Text = text
                        end
                        amber = data10.AMBER
                        handler21("RATE LIMITED — WAITING " .. math.floor(numberValue20) .. "s", amber)
                        amber2 = data10.AMBER
                        handler20(string.format("⏳ 429 — RETRYING IN %.0fs", numberValue20), amber2)
                        warn(string.format(
                            "[ServerBrowser] 429 — waiting %.1fs (attempt %d/%d)",
                            numberValue20,
                            value25 + 1,
                            data8.RETRY_MAX
                        ))
                        numberValue21 = math.floor(numberValue20)
                        task.spawn(function()
                            while numberValue21 > 0 do
                                task.wait(1)
                                numberValue21 -= 1
                                local text2 = string.format(
                                    "⏳ 429 RATE LIMITED — %.0fs REMAINING (%d/%d)",
                                    numberValue21,
                                    value25 + 1,
                                    data8.RETRY_MAX
                                )
                                if value24 then
                                    if Frame8.Visible then
                                        TextLabel3.Text = (string.format(
                                            "⏳ 429 RATE LIMITED — %.0fs REMAINING (%d/%d)",
                                            numberValue21,
                                            value25 + 1,
                                            data8.RETRY_MAX
                                        ))
                                    end
                                elseif Frame9.Visible then
                                    TextLabel6.Text = (string.format(
                                        "⏳ 429 RATE LIMITED — %.0fs REMAINING (%d/%d)",
                                        numberValue21,
                                        value25 + 1,
                                        data8.RETRY_MAX
                                    ))
                                end
                            end
                        end)
                        task.wait(numberValue20)
                        if value24 then
                            handler16()
                        end
                        numberValue18 += numberValue16
                        if numberValue16 <= 0 then
                            if not (numberValue18 >= numberValue17) then
                                exitReason2 = 5
                                break
                            end
                        else
                            if not (numberValue18 <= numberValue17) then
                                exitReason2 = 5
                                break
                            end
                        end
                        value25 = numberValue18
                    end
                    if exitReason2 == 1 then
                        exitReason = 1
                        do
                            return nil, "NETWORK_ERROR"
                        end
                    end
                    if exitReason2 == 2 then
                        statusCode = result3.Status
                        if result3.Status then
                            exitReason3 = nil
                            while true do
                                if statusCode ~= 429 then
                                    exitReason3 = 1
                                else
                                    numberValue15 += 1
                                    if data8.RETRY_MAX <= value25 then
                                        exitReason3 = 2
                                        break
                                    end
                                    if numberValue15 >= 2 then
                                        numberValue20 = data8.RATE_COOLDOWN + handler3()
                                    else
                                        retryBase = data8.RETRY_BASE
                                        numberValue20 = math.pow(retryBase, value25 + 1) + handler3()
                                    end
                                    text = string.format(
                                        "⏳ 429 RATE LIMITED — WAITING %.0fs THEN RETRYING (%d/%d)",
                                        numberValue20,
                                        value25 + 1,
                                        data8.RETRY_MAX
                                    )
                                    if value24 then
                                        handler15(text)
                                        Frame9.Visible = false
                                    else
                                        Frame9.Visible = true
                                        TextLabel6.Text = text
                                    end
                                    amber = data10.AMBER
                                    handler21("RATE LIMITED — WAITING " .. math.floor(numberValue20) .. "s", amber)
                                    amber2 = data10.AMBER
                                    handler20(string.format("⏳ 429 — RETRYING IN %.0fs", numberValue20), amber2)
                                    warn(string.format(
                                        "[ServerBrowser] 429 — waiting %.1fs (attempt %d/%d)",
                                        numberValue20,
                                        value25 + 1,
                                        data8.RETRY_MAX
                                    ))
                                    numberValue21 = math.floor(numberValue20)
                                    task.spawn(function()
                                        while numberValue21 > 0 do
                                            task.wait(1)
                                            numberValue21 -= 1
                                            local text2 = string.format(
                                                "⏳ 429 RATE LIMITED — %.0fs REMAINING (%d/%d)",
                                                numberValue21,
                                                value25 + 1,
                                                data8.RETRY_MAX
                                            )
                                            if value24 then
                                                if Frame8.Visible then
                                                    TextLabel3.Text = (string.format(
                                                        "⏳ 429 RATE LIMITED — %.0fs REMAINING (%d/%d)",
                                                        numberValue21,
                                                        value25 + 1,
                                                        data8.RETRY_MAX
                                                    ))
                                                end
                                            elseif Frame9.Visible then
                                                TextLabel6.Text = (string.format(
                                                    "⏳ 429 RATE LIMITED — %.0fs REMAINING (%d/%d)",
                                                    numberValue21,
                                                    value25 + 1,
                                                    data8.RETRY_MAX
                                                ))
                                            end
                                        end
                                    end)
                                    task.wait(numberValue20)
                                    if value24 then
                                        handler16()
                                    end
                                    numberValue18 += numberValue16
                                    if numberValue16 <= 0 then
                                        if numberValue18 >= numberValue17 then
                                            value25 = numberValue18
                                            exitReason2 = nil
                                            while true do
                                                numberValue19 = 368987844

                                                function value26()
                                                    return request2({
                                                        Url = value23,
                                                        Method = "GET",
                                                        Headers = {
                                                            ["User-Agent"] = "Mozilla/5.0",
                                                            Accept = "application/json",
                                                        },
                                                    })
                                                end

                                                numberValue19 = 461999587
                                                ok, result3 = pcall(value26)
                                                if not ok then
                                                    break
                                                end
                                                if not result3 then
                                                    exitReason2 = 1
                                                    break
                                                end
                                                statusCode = result3.StatusCode
                                                if not result3.StatusCode then
                                                    exitReason2 = 2
                                                    break
                                                end
                                                if result3.StatusCode ~= 429 then
                                                    exitReason2 = 3
                                                    break
                                                end
                                                numberValue15 += 1
                                                if data8.RETRY_MAX <= value25 then
                                                    exitReason2 = 4
                                                    break
                                                end
                                                if numberValue15 >= 2 then
                                                    numberValue20 = data8.RATE_COOLDOWN + handler3()
                                                else
                                                    retryBase = data8.RETRY_BASE
                                                    numberValue20 = math.pow(retryBase, value25 + 1) + handler3()
                                                end
                                                text = string.format(
                                                    "⏳ 429 RATE LIMITED — WAITING %.0fs THEN RETRYING (%d/%d)",
                                                    numberValue20,
                                                    value25 + 1,
                                                    data8.RETRY_MAX
                                                )
                                                if value24 then
                                                    handler15(text)
                                                    Frame9.Visible = false
                                                else
                                                    Frame9.Visible = true
                                                    TextLabel6.Text = text
                                                end
                                                amber = data10.AMBER
                                                handler21(
                                                    "RATE LIMITED — WAITING " .. math.floor(numberValue20) .. "s",
                                                    amber
                                                )
                                                amber2 = data10.AMBER
                                                handler20(
                                                    string.format("⏳ 429 — RETRYING IN %.0fs", numberValue20),
                                                    amber2
                                                )
                                                warn(string.format(
                                                    "[ServerBrowser] 429 — waiting %.1fs (attempt %d/%d)",
                                                    numberValue20,
                                                    value25 + 1,
                                                    data8.RETRY_MAX
                                                ))
                                                numberValue21 = math.floor(numberValue20)
                                                task.spawn(function()
                                                    while numberValue21 > 0 do
                                                        task.wait(1)
                                                        numberValue21 -= 1
                                                        local text2 = string.format(
                                                            "⏳ 429 RATE LIMITED — %.0fs REMAINING (%d/%d)",
                                                            numberValue21,
                                                            value25 + 1,
                                                            data8.RETRY_MAX
                                                        )
                                                        if value24 then
                                                            if Frame8.Visible then
                                                                TextLabel3.Text = (string.format(
                                                                    "⏳ 429 RATE LIMITED — %.0fs REMAINING (%d/%d)",
                                                                    numberValue21,
                                                                    value25 + 1,
                                                                    data8.RETRY_MAX
                                                                ))
                                                            end
                                                        elseif Frame9.Visible then
                                                            TextLabel6.Text = (string.format(
                                                                "⏳ 429 RATE LIMITED — %.0fs REMAINING (%d/%d)",
                                                                numberValue21,
                                                                value25 + 1,
                                                                data8.RETRY_MAX
                                                            ))
                                                        end
                                                    end
                                                end)
                                                task.wait(numberValue20)
                                                if value24 then
                                                    handler16()
                                                end
                                                numberValue18 += numberValue16
                                                if numberValue16 <= 0 then
                                                    if not (numberValue18 >= numberValue17) then
                                                        exitReason2 = 5
                                                        break
                                                    end
                                                else
                                                    if not (numberValue18 <= numberValue17) then
                                                        exitReason2 = 5
                                                        break
                                                    end
                                                end
                                                value25 = numberValue18
                                            end
                                            if exitReason2 == 1 then
                                                exitReason3 = 6
                                                break
                                            elseif exitReason2 == 2 then
                                                statusCode = result3.Status
                                                if result3.Status then
                                                    continue
                                                else
                                                    exitReason3 = 8
                                                    break
                                                end
                                            else
                                                exitReason3 = 7
                                                break
                                            end
                                        else
                                            exitReason3 = 3
                                            break
                                        end
                                    end
                                    if not (numberValue18 <= numberValue17) then
                                        exitReason3 = 3
                                        break
                                    end
                                    value25 = numberValue18
                                    exitReason2 = nil
                                    while true do
                                        numberValue19 = 368987844

                                        function value26()
                                            return request2({
                                                Url = value23,
                                                Method = "GET",
                                                Headers = {
                                                    ["User-Agent"] = "Mozilla/5.0",
                                                    Accept = "application/json",
                                                },
                                            })
                                        end

                                        numberValue19 = 461999587
                                        ok, result3 = pcall(value26)
                                        if not ok then
                                            break
                                        end
                                        if not result3 then
                                            exitReason2 = 1
                                            break
                                        end
                                        statusCode = result3.StatusCode
                                        if not result3.StatusCode then
                                            exitReason2 = 2
                                            break
                                        end
                                        if result3.StatusCode ~= 429 then
                                            exitReason2 = 3
                                            break
                                        end
                                        numberValue15 += 1
                                        if data8.RETRY_MAX <= value25 then
                                            exitReason2 = 4
                                            break
                                        end
                                        if numberValue15 >= 2 then
                                            numberValue20 = data8.RATE_COOLDOWN + handler3()
                                        else
                                            retryBase = data8.RETRY_BASE
                                            numberValue20 = math.pow(retryBase, value25 + 1) + handler3()
                                        end
                                        text = string.format(
                                            "⏳ 429 RATE LIMITED — WAITING %.0fs THEN RETRYING (%d/%d)",
                                            numberValue20,
                                            value25 + 1,
                                            data8.RETRY_MAX
                                        )
                                        if value24 then
                                            handler15(text)
                                            Frame9.Visible = false
                                        else
                                            Frame9.Visible = true
                                            TextLabel6.Text = text
                                        end
                                        amber = data10.AMBER
                                        handler21(
                                            "RATE LIMITED — WAITING " .. math.floor(numberValue20) .. "s",
                                            amber
                                        )
                                        amber2 = data10.AMBER
                                        handler20(string.format("⏳ 429 — RETRYING IN %.0fs", numberValue20), amber2)
                                        warn(string.format(
                                            "[ServerBrowser] 429 — waiting %.1fs (attempt %d/%d)",
                                            numberValue20,
                                            value25 + 1,
                                            data8.RETRY_MAX
                                        ))
                                        numberValue21 = math.floor(numberValue20)
                                        task.spawn(function()
                                            while numberValue21 > 0 do
                                                task.wait(1)
                                                numberValue21 -= 1
                                                local text2 = string.format(
                                                    "⏳ 429 RATE LIMITED — %.0fs REMAINING (%d/%d)",
                                                    numberValue21,
                                                    value25 + 1,
                                                    data8.RETRY_MAX
                                                )
                                                if value24 then
                                                    if Frame8.Visible then
                                                        TextLabel3.Text = (string.format(
                                                            "⏳ 429 RATE LIMITED — %.0fs REMAINING (%d/%d)",
                                                            numberValue21,
                                                            value25 + 1,
                                                            data8.RETRY_MAX
                                                        ))
                                                    end
                                                elseif Frame9.Visible then
                                                    TextLabel6.Text = (string.format(
                                                        "⏳ 429 RATE LIMITED — %.0fs REMAINING (%d/%d)",
                                                        numberValue21,
                                                        value25 + 1,
                                                        data8.RETRY_MAX
                                                    ))
                                                end
                                            end
                                        end)
                                        task.wait(numberValue20)
                                        if value24 then
                                            handler16()
                                        end
                                        numberValue18 += numberValue16
                                        if numberValue16 <= 0 then
                                            if not (numberValue18 >= numberValue17) then
                                                exitReason2 = 5
                                                break
                                            end
                                        else
                                            if not (numberValue18 <= numberValue17) then
                                                exitReason2 = 5
                                                break
                                            end
                                        end
                                        value25 = numberValue18
                                    end
                                    if exitReason2 == 1 then
                                        exitReason3 = 4
                                        break
                                    elseif exitReason2 == 2 then
                                        statusCode = result3.Status
                                        if result3.Status then
                                            continue
                                        else
                                            exitReason3 = 5
                                            break
                                        end
                                    end
                                end
                                break
                            end
                            if exitReason3 == 1 then
                                exitReason = 3
                                if exitReason == 2 then
                                    if result3.Body then
                                        if result3.Body ~= "" then
                                            ok2, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                            if ok2 then
                                                if result4 then
                                                    return result4, nil
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "INVALID_JSON"
                                        end
                                        return nil, "EMPTY_BODY"
                                    end
                                else
                                    if exitReason ~= 3 then
                                        if exitReason == 4 then
                                            return nil, "RATE_LIMIT"
                                        end
                                        if exitReason == 5 then
                                            return nil, "RATE_LIMIT"
                                        end
                                        return nil, "NETWORK_ERROR"
                                    end
                                    if statusCode == 403 then
                                        return nil, "FORBIDDEN"
                                    end
                                    if statusCode == 401 then
                                        return nil, "UNAUTHORIZED"
                                    end
                                    if statusCode >= 500 then
                                        return nil, "SERVER_ERROR"
                                    end
                                    if statusCode ~= 200 and statusCode ~= 0 then
                                        return nil, "HTTP_" .. tostring(statusCode)
                                    end
                                    if result3.Body then
                                        if result3.Body ~= "" then
                                            ok3, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                            if ok3 then
                                                if result4 then
                                                    return result4, nil
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "INVALID_JSON"
                                        end
                                        return nil, "EMPTY_BODY"
                                    end
                                end
                                return nil, "EMPTY_BODY"
                            end
                            if exitReason3 == 2 then
                                exitReason = 4
                                if exitReason == 2 then
                                    if result3.Body then
                                        if result3.Body ~= "" then
                                            ok2, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                            if ok2 then
                                                if result4 then
                                                    return result4, nil
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "INVALID_JSON"
                                        end
                                        return nil, "EMPTY_BODY"
                                    end
                                else
                                    if exitReason ~= 3 then
                                        if exitReason == 4 then
                                            return nil, "RATE_LIMIT"
                                        end
                                        if exitReason == 5 then
                                            return nil, "RATE_LIMIT"
                                        end
                                        return nil, "NETWORK_ERROR"
                                    end
                                    if statusCode == 403 then
                                        return nil, "FORBIDDEN"
                                    end
                                    if statusCode == 401 then
                                        return nil, "UNAUTHORIZED"
                                    end
                                    if statusCode >= 500 then
                                        return nil, "SERVER_ERROR"
                                    end
                                    if statusCode ~= 200 and statusCode ~= 0 then
                                        return nil, "HTTP_" .. tostring(statusCode)
                                    end
                                    if result3.Body then
                                        if result3.Body ~= "" then
                                            ok3, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                            if ok3 then
                                                if result4 then
                                                    return result4, nil
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "INVALID_JSON"
                                        end
                                        return nil, "EMPTY_BODY"
                                    end
                                end
                                return nil, "EMPTY_BODY"
                            end
                            if exitReason3 == 3 then
                                exitReason = 5
                                if exitReason == 2 then
                                    if result3.Body then
                                        if result3.Body ~= "" then
                                            ok2, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                            if ok2 then
                                                if result4 then
                                                    return result4, nil
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "INVALID_JSON"
                                        end
                                        return nil, "EMPTY_BODY"
                                    end
                                else
                                    if exitReason ~= 3 then
                                        if exitReason == 4 then
                                            return nil, "RATE_LIMIT"
                                        end
                                        if exitReason == 5 then
                                            return nil, "RATE_LIMIT"
                                        end
                                        return nil, "NETWORK_ERROR"
                                    end
                                    if statusCode == 403 then
                                        return nil, "FORBIDDEN"
                                    end
                                    if statusCode == 401 then
                                        return nil, "UNAUTHORIZED"
                                    end
                                    if statusCode >= 500 then
                                        return nil, "SERVER_ERROR"
                                    end
                                    if statusCode ~= 200 and statusCode ~= 0 then
                                        return nil, "HTTP_" .. tostring(statusCode)
                                    end
                                    if result3.Body then
                                        if result3.Body ~= "" then
                                            ok3, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                            if ok3 then
                                                if result4 then
                                                    return result4, nil
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "INVALID_JSON"
                                        end
                                        return nil, "EMPTY_BODY"
                                    end
                                end
                                return nil, "EMPTY_BODY"
                            end
                            if exitReason3 == 4 then
                                exitReason = 1
                                do
                                    return nil, "NETWORK_ERROR"
                                end
                            end
                            if exitReason3 == 5 then
                                exitReason = 2
                                if exitReason == 2 then
                                    if result3.Body then
                                        if result3.Body ~= "" then
                                            ok2, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                            if ok2 then
                                                if result4 then
                                                    return result4, nil
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "INVALID_JSON"
                                        end
                                        return nil, "EMPTY_BODY"
                                    end
                                else
                                    if exitReason ~= 3 then
                                        if exitReason == 4 then
                                            return nil, "RATE_LIMIT"
                                        end
                                        if exitReason == 5 then
                                            return nil, "RATE_LIMIT"
                                        end
                                        return nil, "NETWORK_ERROR"
                                    end
                                    if statusCode == 403 then
                                        return nil, "FORBIDDEN"
                                    end
                                    if statusCode == 401 then
                                        return nil, "UNAUTHORIZED"
                                    end
                                    if statusCode >= 500 then
                                        return nil, "SERVER_ERROR"
                                    end
                                    if statusCode ~= 200 and statusCode ~= 0 then
                                        return nil, "HTTP_" .. tostring(statusCode)
                                    end
                                    if result3.Body then
                                        if result3.Body ~= "" then
                                            ok3, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                            if ok3 then
                                                if result4 then
                                                    return result4, nil
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "INVALID_JSON"
                                        end
                                        return nil, "EMPTY_BODY"
                                    end
                                end
                                return nil, "EMPTY_BODY"
                            end
                            if exitReason3 == 6 then
                                exitReason = 1
                                do
                                    return nil, "NETWORK_ERROR"
                                end
                            end
                            if exitReason3 == 7 then
                                if exitReason2 == 3 then
                                    exitReason = 3
                                    if exitReason == 2 then
                                        if result3.Body then
                                            if result3.Body ~= "" then
                                                ok2, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                                if ok2 then
                                                    if result4 then
                                                        return result4, nil
                                                    end
                                                    return nil, "INVALID_JSON"
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "EMPTY_BODY"
                                        end
                                    else
                                        if exitReason ~= 3 then
                                            if exitReason == 4 then
                                                return nil, "RATE_LIMIT"
                                            end
                                            if exitReason == 5 then
                                                return nil, "RATE_LIMIT"
                                            end
                                            return nil, "NETWORK_ERROR"
                                        end
                                        if statusCode == 403 then
                                            return nil, "FORBIDDEN"
                                        end
                                        if statusCode == 401 then
                                            return nil, "UNAUTHORIZED"
                                        end
                                        if statusCode >= 500 then
                                            return nil, "SERVER_ERROR"
                                        end
                                        if statusCode ~= 200 and statusCode ~= 0 then
                                            return nil, "HTTP_" .. tostring(statusCode)
                                        end
                                        if result3.Body then
                                            if result3.Body ~= "" then
                                                ok3, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                                if ok3 then
                                                    if result4 then
                                                        return result4, nil
                                                    end
                                                    return nil, "INVALID_JSON"
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "EMPTY_BODY"
                                        end
                                    end
                                    return nil, "EMPTY_BODY"
                                end
                                if exitReason2 == 4 then
                                    exitReason = 4
                                    if exitReason == 2 then
                                        if result3.Body then
                                            if result3.Body ~= "" then
                                                ok2, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                                if ok2 then
                                                    if result4 then
                                                        return result4, nil
                                                    end
                                                    return nil, "INVALID_JSON"
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "EMPTY_BODY"
                                        end
                                    else
                                        if exitReason ~= 3 then
                                            if exitReason == 4 then
                                                return nil, "RATE_LIMIT"
                                            end
                                            if exitReason == 5 then
                                                return nil, "RATE_LIMIT"
                                            end
                                            return nil, "NETWORK_ERROR"
                                        end
                                        if statusCode == 403 then
                                            return nil, "FORBIDDEN"
                                        end
                                        if statusCode == 401 then
                                            return nil, "UNAUTHORIZED"
                                        end
                                        if statusCode >= 500 then
                                            return nil, "SERVER_ERROR"
                                        end
                                        if statusCode ~= 200 and statusCode ~= 0 then
                                            return nil, "HTTP_" .. tostring(statusCode)
                                        end
                                        if result3.Body then
                                            if result3.Body ~= "" then
                                                ok3, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                                if ok3 then
                                                    if result4 then
                                                        return result4, nil
                                                    end
                                                    return nil, "INVALID_JSON"
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "EMPTY_BODY"
                                        end
                                    end
                                    return nil, "EMPTY_BODY"
                                end
                                if exitReason2 == 5 then
                                    exitReason = 5
                                    if exitReason == 2 then
                                        if result3.Body then
                                            if result3.Body ~= "" then
                                                ok2, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                                if ok2 then
                                                    if result4 then
                                                        return result4, nil
                                                    end
                                                    return nil, "INVALID_JSON"
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "EMPTY_BODY"
                                        end
                                    else
                                        if exitReason ~= 3 then
                                            if exitReason == 4 then
                                                return nil, "RATE_LIMIT"
                                            end
                                            if exitReason == 5 then
                                                return nil, "RATE_LIMIT"
                                            end
                                            return nil, "NETWORK_ERROR"
                                        end
                                        if statusCode == 403 then
                                            return nil, "FORBIDDEN"
                                        end
                                        if statusCode == 401 then
                                            return nil, "UNAUTHORIZED"
                                        end
                                        if statusCode >= 500 then
                                            return nil, "SERVER_ERROR"
                                        end
                                        if statusCode ~= 200 and statusCode ~= 0 then
                                            return nil, "HTTP_" .. tostring(statusCode)
                                        end
                                        if result3.Body then
                                            if result3.Body ~= "" then
                                                ok3, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                                if ok3 then
                                                    if result4 then
                                                        return result4, nil
                                                    end
                                                    return nil, "INVALID_JSON"
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "EMPTY_BODY"
                                        end
                                    end
                                    return nil, "EMPTY_BODY"
                                end
                                if exitReason == 1 then
                                    return nil, "NETWORK_ERROR"
                                end
                                if exitReason == 2 then
                                    if result3.Body then
                                        if result3.Body ~= "" then
                                            ok2, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                            if ok2 then
                                                if result4 then
                                                    return result4, nil
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "INVALID_JSON"
                                        end
                                        return nil, "EMPTY_BODY"
                                    end
                                else
                                    if exitReason ~= 3 then
                                        if exitReason == 4 then
                                            return nil, "RATE_LIMIT"
                                        end
                                        if exitReason == 5 then
                                            return nil, "RATE_LIMIT"
                                        end
                                        return nil, "NETWORK_ERROR"
                                    end
                                    if statusCode == 403 then
                                        return nil, "FORBIDDEN"
                                    end
                                    if statusCode == 401 then
                                        return nil, "UNAUTHORIZED"
                                    end
                                    if statusCode >= 500 then
                                        return nil, "SERVER_ERROR"
                                    end
                                    if statusCode ~= 200 and statusCode ~= 0 then
                                        return nil, "HTTP_" .. tostring(statusCode)
                                    end
                                    if result3.Body then
                                        if result3.Body ~= "" then
                                            ok3, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                            if ok3 then
                                                if result4 then
                                                    return result4, nil
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "INVALID_JSON"
                                        end
                                        return nil, "EMPTY_BODY"
                                    end
                                end
                                return nil, "EMPTY_BODY"
                            end
                            if exitReason3 == 8 then
                                exitReason = 2
                                if exitReason == 2 then
                                    if result3.Body then
                                        if result3.Body ~= "" then
                                            ok2, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                            if ok2 then
                                                if result4 then
                                                    return result4, nil
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "INVALID_JSON"
                                        end
                                        return nil, "EMPTY_BODY"
                                    end
                                else
                                    if exitReason ~= 3 then
                                        if exitReason == 4 then
                                            return nil, "RATE_LIMIT"
                                        end
                                        if exitReason == 5 then
                                            return nil, "RATE_LIMIT"
                                        end
                                        return nil, "NETWORK_ERROR"
                                    end
                                    if statusCode == 403 then
                                        return nil, "FORBIDDEN"
                                    end
                                    if statusCode == 401 then
                                        return nil, "UNAUTHORIZED"
                                    end
                                    if statusCode >= 500 then
                                        return nil, "SERVER_ERROR"
                                    end
                                    if statusCode ~= 200 and statusCode ~= 0 then
                                        return nil, "HTTP_" .. tostring(statusCode)
                                    end
                                    if result3.Body then
                                        if result3.Body ~= "" then
                                            ok3, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                            if ok3 then
                                                if result4 then
                                                    return result4, nil
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "INVALID_JSON"
                                        end
                                        return nil, "EMPTY_BODY"
                                    end
                                end
                                return nil, "EMPTY_BODY"
                            end
                            if exitReason2 == 3 then
                                exitReason = 3
                                if exitReason == 2 then
                                    if result3.Body then
                                        if result3.Body ~= "" then
                                            ok2, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                            if ok2 then
                                                if result4 then
                                                    return result4, nil
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "INVALID_JSON"
                                        end
                                        return nil, "EMPTY_BODY"
                                    end
                                else
                                    if exitReason ~= 3 then
                                        if exitReason == 4 then
                                            return nil, "RATE_LIMIT"
                                        end
                                        if exitReason == 5 then
                                            return nil, "RATE_LIMIT"
                                        end
                                        return nil, "NETWORK_ERROR"
                                    end
                                    if statusCode == 403 then
                                        return nil, "FORBIDDEN"
                                    end
                                    if statusCode == 401 then
                                        return nil, "UNAUTHORIZED"
                                    end
                                    if statusCode >= 500 then
                                        return nil, "SERVER_ERROR"
                                    end
                                    if statusCode ~= 200 and statusCode ~= 0 then
                                        return nil, "HTTP_" .. tostring(statusCode)
                                    end
                                    if result3.Body then
                                        if result3.Body ~= "" then
                                            ok3, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                            if ok3 then
                                                if result4 then
                                                    return result4, nil
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "INVALID_JSON"
                                        end
                                        return nil, "EMPTY_BODY"
                                    end
                                end
                                return nil, "EMPTY_BODY"
                            end
                            if exitReason2 == 4 then
                                exitReason = 4
                                if exitReason == 2 then
                                    if result3.Body then
                                        if result3.Body ~= "" then
                                            ok2, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                            if ok2 then
                                                if result4 then
                                                    return result4, nil
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "INVALID_JSON"
                                        end
                                        return nil, "EMPTY_BODY"
                                    end
                                else
                                    if exitReason ~= 3 then
                                        if exitReason == 4 then
                                            return nil, "RATE_LIMIT"
                                        end
                                        if exitReason == 5 then
                                            return nil, "RATE_LIMIT"
                                        end
                                        return nil, "NETWORK_ERROR"
                                    end
                                    if statusCode == 403 then
                                        return nil, "FORBIDDEN"
                                    end
                                    if statusCode == 401 then
                                        return nil, "UNAUTHORIZED"
                                    end
                                    if statusCode >= 500 then
                                        return nil, "SERVER_ERROR"
                                    end
                                    if statusCode ~= 200 and statusCode ~= 0 then
                                        return nil, "HTTP_" .. tostring(statusCode)
                                    end
                                    if result3.Body then
                                        if result3.Body ~= "" then
                                            ok3, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                            if ok3 then
                                                if result4 then
                                                    return result4, nil
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "INVALID_JSON"
                                        end
                                        return nil, "EMPTY_BODY"
                                    end
                                end
                                return nil, "EMPTY_BODY"
                            end
                            if exitReason2 == 5 then
                                exitReason = 5
                                if exitReason == 2 then
                                    if result3.Body then
                                        if result3.Body ~= "" then
                                            ok2, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                            if ok2 then
                                                if result4 then
                                                    return result4, nil
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "INVALID_JSON"
                                        end
                                        return nil, "EMPTY_BODY"
                                    end
                                else
                                    if exitReason ~= 3 then
                                        if exitReason == 4 then
                                            return nil, "RATE_LIMIT"
                                        end
                                        if exitReason == 5 then
                                            return nil, "RATE_LIMIT"
                                        end
                                        return nil, "NETWORK_ERROR"
                                    end
                                    if statusCode == 403 then
                                        return nil, "FORBIDDEN"
                                    end
                                    if statusCode == 401 then
                                        return nil, "UNAUTHORIZED"
                                    end
                                    if statusCode >= 500 then
                                        return nil, "SERVER_ERROR"
                                    end
                                    if statusCode ~= 200 and statusCode ~= 0 then
                                        return nil, "HTTP_" .. tostring(statusCode)
                                    end
                                    if result3.Body then
                                        if result3.Body ~= "" then
                                            ok3, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                            if ok3 then
                                                if result4 then
                                                    return result4, nil
                                                end
                                                return nil, "INVALID_JSON"
                                            end
                                            return nil, "INVALID_JSON"
                                        end
                                        return nil, "EMPTY_BODY"
                                    end
                                end
                                return nil, "EMPTY_BODY"
                            end
                            if exitReason == 1 then
                                return nil, "NETWORK_ERROR"
                            end
                            if exitReason == 2 then
                                if result3.Body then
                                    if result3.Body ~= "" then
                                        ok2, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                        if ok2 then
                                            if result4 then
                                                return result4, nil
                                            end
                                            return nil, "INVALID_JSON"
                                        end
                                        return nil, "INVALID_JSON"
                                    end
                                    return nil, "EMPTY_BODY"
                                end
                            else
                                if exitReason ~= 3 then
                                    if exitReason == 4 then
                                        return nil, "RATE_LIMIT"
                                    end
                                    if exitReason == 5 then
                                        return nil, "RATE_LIMIT"
                                    end
                                    return nil, "NETWORK_ERROR"
                                end
                                if statusCode == 403 then
                                    return nil, "FORBIDDEN"
                                end
                                if statusCode == 401 then
                                    return nil, "UNAUTHORIZED"
                                end
                                if statusCode >= 500 then
                                    return nil, "SERVER_ERROR"
                                end
                                if statusCode ~= 200 and statusCode ~= 0 then
                                    return nil, "HTTP_" .. tostring(statusCode)
                                end
                                if result3.Body then
                                    if result3.Body ~= "" then
                                        ok3, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                        if ok3 then
                                            if result4 then
                                                return result4, nil
                                            end
                                            return nil, "INVALID_JSON"
                                        end
                                        return nil, "INVALID_JSON"
                                    end
                                    return nil, "EMPTY_BODY"
                                end
                            end
                            return nil, "EMPTY_BODY"
                        end
                        exitReason = 2
                        if exitReason == 2 then
                            if result3.Body then
                                if result3.Body ~= "" then
                                    ok2, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                    if ok2 then
                                        if result4 then
                                            return result4, nil
                                        end
                                        return nil, "INVALID_JSON"
                                    end
                                    return nil, "INVALID_JSON"
                                end
                                return nil, "EMPTY_BODY"
                            end
                        else
                            if exitReason ~= 3 then
                                if exitReason == 4 then
                                    return nil, "RATE_LIMIT"
                                end
                                if exitReason == 5 then
                                    return nil, "RATE_LIMIT"
                                end
                                return nil, "NETWORK_ERROR"
                            end
                            if statusCode == 403 then
                                return nil, "FORBIDDEN"
                            end
                            if statusCode == 401 then
                                return nil, "UNAUTHORIZED"
                            end
                            if statusCode >= 500 then
                                return nil, "SERVER_ERROR"
                            end
                            if statusCode ~= 200 and statusCode ~= 0 then
                                return nil, "HTTP_" .. tostring(statusCode)
                            end
                            if result3.Body then
                                if result3.Body ~= "" then
                                    ok3, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                    if ok3 then
                                        if result4 then
                                            return result4, nil
                                        end
                                        return nil, "INVALID_JSON"
                                    end
                                    return nil, "INVALID_JSON"
                                end
                                return nil, "EMPTY_BODY"
                            end
                        end
                        return nil, "EMPTY_BODY"
                    end
                    if exitReason2 == 3 then
                        exitReason = 3
                        if exitReason == 2 then
                            if result3.Body then
                                if result3.Body ~= "" then
                                    ok2, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                    if ok2 then
                                        if result4 then
                                            return result4, nil
                                        end
                                        return nil, "INVALID_JSON"
                                    end
                                    return nil, "INVALID_JSON"
                                end
                                return nil, "EMPTY_BODY"
                            end
                        else
                            if exitReason ~= 3 then
                                if exitReason == 4 then
                                    return nil, "RATE_LIMIT"
                                end
                                if exitReason == 5 then
                                    return nil, "RATE_LIMIT"
                                end
                                return nil, "NETWORK_ERROR"
                            end
                            if statusCode == 403 then
                                return nil, "FORBIDDEN"
                            end
                            if statusCode == 401 then
                                return nil, "UNAUTHORIZED"
                            end
                            if statusCode >= 500 then
                                return nil, "SERVER_ERROR"
                            end
                            if statusCode ~= 200 and statusCode ~= 0 then
                                return nil, "HTTP_" .. tostring(statusCode)
                            end
                            if result3.Body then
                                if result3.Body ~= "" then
                                    ok3, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                    if ok3 then
                                        if result4 then
                                            return result4, nil
                                        end
                                        return nil, "INVALID_JSON"
                                    end
                                    return nil, "INVALID_JSON"
                                end
                                return nil, "EMPTY_BODY"
                            end
                        end
                        return nil, "EMPTY_BODY"
                    end
                    if exitReason2 == 4 then
                        exitReason = 4
                        if exitReason == 2 then
                            if result3.Body then
                                if result3.Body ~= "" then
                                    ok2, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                    if ok2 then
                                        if result4 then
                                            return result4, nil
                                        end
                                        return nil, "INVALID_JSON"
                                    end
                                    return nil, "INVALID_JSON"
                                end
                                return nil, "EMPTY_BODY"
                            end
                        else
                            if exitReason ~= 3 then
                                if exitReason == 4 then
                                    return nil, "RATE_LIMIT"
                                end
                                if exitReason == 5 then
                                    return nil, "RATE_LIMIT"
                                end
                                return nil, "NETWORK_ERROR"
                            end
                            if statusCode == 403 then
                                return nil, "FORBIDDEN"
                            end
                            if statusCode == 401 then
                                return nil, "UNAUTHORIZED"
                            end
                            if statusCode >= 500 then
                                return nil, "SERVER_ERROR"
                            end
                            if statusCode ~= 200 and statusCode ~= 0 then
                                return nil, "HTTP_" .. tostring(statusCode)
                            end
                            if result3.Body then
                                if result3.Body ~= "" then
                                    ok3, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                    if ok3 then
                                        if result4 then
                                            return result4, nil
                                        end
                                        return nil, "INVALID_JSON"
                                    end
                                    return nil, "INVALID_JSON"
                                end
                                return nil, "EMPTY_BODY"
                            end
                        end
                        return nil, "EMPTY_BODY"
                    end
                    if exitReason2 == 5 then
                        exitReason = 5
                        if exitReason == 2 then
                            if result3.Body then
                                if result3.Body ~= "" then
                                    ok2, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                    if ok2 then
                                        if result4 then
                                            return result4, nil
                                        end
                                        return nil, "INVALID_JSON"
                                    end
                                    return nil, "INVALID_JSON"
                                end
                                return nil, "EMPTY_BODY"
                            end
                        else
                            if exitReason ~= 3 then
                                if exitReason == 4 then
                                    return nil, "RATE_LIMIT"
                                end
                                if exitReason == 5 then
                                    return nil, "RATE_LIMIT"
                                end
                                return nil, "NETWORK_ERROR"
                            end
                            if statusCode == 403 then
                                return nil, "FORBIDDEN"
                            end
                            if statusCode == 401 then
                                return nil, "UNAUTHORIZED"
                            end
                            if statusCode >= 500 then
                                return nil, "SERVER_ERROR"
                            end
                            if statusCode ~= 200 and statusCode ~= 0 then
                                return nil, "HTTP_" .. tostring(statusCode)
                            end
                            if result3.Body then
                                if result3.Body ~= "" then
                                    ok3, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                    if ok3 then
                                        if result4 then
                                            return result4, nil
                                        end
                                        return nil, "INVALID_JSON"
                                    end
                                    return nil, "INVALID_JSON"
                                end
                                return nil, "EMPTY_BODY"
                            end
                        end
                        return nil, "EMPTY_BODY"
                    end
                    if exitReason == 1 then
                        return nil, "NETWORK_ERROR"
                    end
                    if exitReason == 2 then
                        if result3.Body then
                            if result3.Body ~= "" then
                                ok2, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                if ok2 then
                                    if result4 then
                                        return result4, nil
                                    end
                                    return nil, "INVALID_JSON"
                                end
                                return nil, "INVALID_JSON"
                            end
                            return nil, "EMPTY_BODY"
                        end
                    else
                        if exitReason ~= 3 then
                            if exitReason == 4 then
                                return nil, "RATE_LIMIT"
                            end
                            if exitReason == 5 then
                                return nil, "RATE_LIMIT"
                            end
                            return nil, "NETWORK_ERROR"
                        end
                        if statusCode == 403 then
                            return nil, "FORBIDDEN"
                        end
                        if statusCode == 401 then
                            return nil, "UNAUTHORIZED"
                        end
                        if statusCode >= 500 then
                            return nil, "SERVER_ERROR"
                        end
                        if statusCode ~= 200 and statusCode ~= 0 then
                            return nil, "HTTP_" .. tostring(statusCode)
                        end
                        if result3.Body then
                            if result3.Body ~= "" then
                                ok3, result4 = pcall(value20.JSONDecode, value20, result3.Body)
                                if ok3 then
                                    if result4 then
                                        return result4, nil
                                    end
                                    return nil, "INVALID_JSON"
                                end
                                return nil, "INVALID_JSON"
                            end
                            return nil, "EMPTY_BODY"
                        end
                    end
                    return nil, "EMPTY_BODY"
                end
                return nil, "RATE_LIMIT"
            end

            function handler13()
                local value23, value24, value25 = ipairs(ScrollingFrame:GetChildren())
                local b_1 = 2
                local nextEntry4 = createIterator(value23, value24, value25)
                while true do
                    local hasEntry16, entryKey16, entryValue12 = nextEntry4()
                    if not hasEntry16 then
                        break
                    end
                    do
                        local value26 = entryValue12
                        while value26:IsA("Frame") do
                            value26:Destroy()
                            local hasEntry17, entryKey17, entryValue13 = nextEntry4()
                            if hasEntry17 then
                                value26 = entryValue13
                                continue
                            end
                            return
                        end
                    end
                end
            end

            function handler11()
                table.sort(data9.servers, function(inputValue, inputValue2)
                    local playing = inputValue.playing or 999
                    local playing2 = inputValue2.playing
                    if inputValue2.playing then
                        if (inputValue.playing or 999) ~= inputValue2.playing then
                            return (inputValue.playing or 999) < inputValue2.playing
                        end
                    else
                        playing2 = 999
                        if (inputValue.playing or 999) ~= 999 then
                            return (inputValue.playing or 999) < 999
                        end
                    end
                    return (inputValue.ping or 999) < (inputValue2.ping or 999)
                end)
            end

            function handler7(inputValue)
                if inputValue < 100 then
                    return data10.GREEN_GLOW
                end
                if inputValue < 200 then
                    return data10.AMBER
                end
                return data10.RED
            end

            function handler6(inputValue)
                if inputValue > 0.8 then
                    return data10.RED
                end
                if inputValue > 0.5 then
                    return data10.AMBER
                end
                return data10.CYAN
            end

            function handler12(inputValue, inputValue2)
                local numberValue14 = 3871084147
                local value23 = inputValue
                local value24 = inputValue2
                local condition2 = inputValue2 == 1
                local rowTop
                if inputValue2 == 1 then
                    rowTop = data10.ROW_TOP or data10.ROW
                else
                    rowTop = data10.ROW
                end
                local numberValue15 = 277563926 + numberValue14
                local Frame10 = handler8("Frame", {
                    Size = UDim2.new(1, 0, 0, 48),
                    BackgroundColor3 = rowTop,
                    BorderSizePixel = 0,
                    LayoutOrder = value24,
                }, ScrollingFrame)
                handler9(3, Frame10)
                local cyanDim
                if condition2 then
                    cyanDim = data10.CYAN_DIM
                    numberValue14 = 3871084147
                    cyanDim = data10.CYAN_DIM or data10.BORDER
                else
                    cyanDim = data10.BORDER
                end
                local value25 = handler4(1, cyanDim, 0, Frame10)
                Frame10.MouseEnter:Connect(function()
                    handler5(Frame10, {BackgroundColor3 = data10.ROW_HOVER})
                    handler5(value25, {Color = data10.BORDER_HOV})
                end)
                Frame10.MouseLeave:Connect(function()
                    handler5(Frame10, {BackgroundColor3 = rowTop})
                    local data15 = {}
                    local border
                    if not condition2 then
                        border = data10.BORDER
                        data15.Color = data10.BORDER
                        handler5(value25, data15)
                        return
                    end
                    border = data10.CYAN_DIM or data10.BORDER
                    data15.Color = border
                    handler5(value25, data15)
                end)
                local data15 = {
                    Size = UDim2.new(0, 28, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    BackgroundTransparency = 1,
                    Text = string.format("%02d", value24),
                }
                local cyan
                if condition2 then
                    cyan = data10.CYAN
                    numberValue14 = 3871084147
                    cyan = data10.CYAN or data10.TEXT_DIM
                else
                    cyan = data10.TEXT_DIM
                end
                data15.TextColor3 = cyan
                data15.Font = Enum.Font.GothamBold
                data15.TextSize = 11
                data15.TextXAlignment = Enum.TextXAlignment.Left
                handler8("TextLabel", data15, Frame10)
                local numberValue16 = numberValue15 + numberValue14
                handler8("TextLabel", {
                    Size = UDim2.new(0, 160, 0, 14),
                    Position = UDim2.new(0, 44, 0, 8),
                    BackgroundTransparency = 1,
                    Text = tostring(value23.id):sub(1, 18) .. "...",
                    TextColor3 = Color3.new(0.23529411852359772, 0.29411765933036804, 0.43137255311012268),
                    Font = Enum.Font.Code,
                    TextSize = 10,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, Frame10)
                local playing = value23.playing or 0
                local maxPlayers = value23.maxPlayers or 20
                local numberValue17 = (value23.playing or 0) / math.max(value23.maxPlayers or 20, 1)
                local numberValue18 = numberValue16 + 3984071910
                handler8("TextLabel", {
                    Size = UDim2.new(0, 80, 0, 14),
                    Position = UDim2.new(0, 44, 0, 26),
                    BackgroundTransparency = 1,
                    Text = playing .. "/" .. maxPlayers .. " players",
                    TextColor3 = data10.TEXT_DIM,
                    Font = Enum.Font.Gotham,
                    TextSize = 9,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, Frame10)
                handler8("TextLabel", {
                    Size = UDim2.new(0, 50, 0, 20),
                    Position = UDim2.new(0, 210, 0, 4),
                    BackgroundTransparency = 1,
                    Text = tostring(playing),
                    TextColor3 = data10.TEXT_PRI,
                    Font = Enum.Font.GothamBold,
                    TextSize = 15,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, Frame10)
                local Frame11 = handler8("Frame", {
                    Size = UDim2.new(0, 50, 0, 2),
                    Position = UDim2.new(0, 210, 0, 28),
                    BackgroundColor3 = Color3.new(0.086274512112140656, 0.094117648899555206, 0.14117647707462311),
                    BorderSizePixel = 0,
                }, Frame10)
                handler9(1, Frame11)
                local numberValue19 = numberValue18 + 4237242810 + 3902458385
                local numberValue20 = 4283096011
                handler9(1, handler8("Frame", {
                    Size = UDim2.new(math.clamp(numberValue17, 0, 1), 0, 1, 0),
                    BackgroundColor3 = handler6(numberValue17),
                    BorderSizePixel = 0,
                }, Frame11))
                local ping = value23.ping or 999
                handler8("TextLabel", {
                    Size = UDim2.new(0, 55, 1, 0),
                    Position = UDim2.new(0, 278, 0, 0),
                    BackgroundTransparency = 1,
                    Text = ping .. "ms",
                    TextColor3 = handler7(ping),
                    Font = Enum.Font.GothamBold,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, Frame10)
                local TextButton3 = handler8("TextButton", {
                    Size = UDim2.new(0, 72, 0, 28),
                    Position = UDim2.new(1, -82, 0.5, -14),
                    BackgroundColor3 = Color3.new(0.039215687662363052, 0.11764705926179886, 0.070588238537311554),
                    BorderSizePixel = 0,
                    Text = "JOIN",
                    TextColor3 = data10.GREEN,
                    Font = Enum.Font.GothamBold,
                    TextSize = 10,
                }, Frame10)
                handler9(3, TextButton3)
                handler10(
                    TextButton3,
                    Color3.new(0.039215687662363052, 0.11764705926179886, 0.070588238537311554),
                    Color3.new(0.031372550874948502, 0.17254902422428131, 0.094117648899555206)
                )
                TextButton3.MouseButton1Click:Connect(function()
                    local cyan2 = data10.CYAN
                    handler20("TELEPORTING TO " .. tostring(value23.id):sub(1, 16) .. "...", cyan2)
                    local ok, result3 = pcall(function()
                        game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", value23.id)
                    end)
                    if ok then
                        return
                    end
                    handler20("TELEPORT FAILED: " .. tostring(result3), data10.RED)
                    handler21("TELEPORT FAILED", data10.RED)
                end)
            end

            function handler18()
                local numberValue14 = 3470468658
                local numberValue15 = 1725057105
                handler13()
                handler11()
                local numberValue16 = #data9.servers
                local numberValue17 = math.min(#data9.servers, data8.MAX_SHOW)
                local numberValue18 = 1
                local numberValue19 = (math.min(#data9.servers, data8.MAX_SHOW)) + 0
                local numberValue20 = 0
                numberValue20 += 1
                local value23
                if numberValue20 <= (math.min(#data9.servers, data8.MAX_SHOW)) + 0 then
                    value23 = numberValue20
                    while true do
                        handler12(data9.servers[value23], value23)
                        numberValue20 += numberValue18
                        if numberValue18 <= 0 then
                            if numberValue20 >= numberValue19 then
                                value23 = numberValue20
                                continue
                            end
                        else
                            if numberValue20 <= numberValue19 then
                                value23 = numberValue20
                                continue
                            end
                        end
                        break
                    end
                end
                local value24
                numberValue20 = value24
                local value25
                numberValue19 = value25
                local value26
                numberValue18 = value26
                local b_0
                local b_1 = b_0
                ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 16)
                TextLabel4.Text = "SHOWING " .. numberValue17 .. " / " .. numberValue16
                TextLabel5.Text = "PLACE · " .. tostring(placeId) .. "  ·  PAGE " .. tostring(data9.pages)
                if data9.finished then
                    handler21("CACHE DONE — " .. numberValue16 .. " SERVERS", data10.GREEN_GLOW)
                    return
                end
                handler21("CACHE SAVED — " .. numberValue16 .. " SERVERS — PAGE " .. data9.pages, data10.CYAN)
            end

            function handler22()
                data9.servers = {}
                data9.cursor = nil
                data9.finished = false
                data9.lastUpdate = 0
                data9.pages = 0
                local value23 = handler16
                handler16()
                handler13()
                TextLabel4.Text = "SHOWING 0 / 0"
                TextLabel5.Text = "PLACE · " .. tostring(placeId)
                handler21("CACHE RESET", data10.RED)
                handler20("CACHE RESET", data10.RED)
            end

            local condition = false

            function handler24(inputValue, inputValue2)
                local numberValue14 = 3520927507
                local numberValue15 = 2609268571
                local value23 = inputValue
                local numberValue16 = 383868137
                if condition then
                    return
                end
                condition = true
                if inputValue2 then
                    handler22()
                end
                refreshLabel.Active = false
                waitLabel.Active = false
                TextButton2.Active = false
                local numberValue17 = bit32.bor(numberValue14, numberValue15)
                refreshLabel.Text = "LOADING"
                waitLabel.Text = "WAIT"
                local numberValue18 = 0
                local exitReason = nil
                local value24, condition2, value25, value26, value27, b_0
                while true do
                    value24 = nil
                    if data9.finished then
                        exitReason = 1
                    else
                        numberValue18 += 1
                        data9.pages = data9.pages + 1
                        condition2 = #data9.servers > 0
                        if #data9.servers > 0 then
                            Frame9.Visible = false
                        else
                            Frame9.Visible = true
                            TextLabel6.Text = "SCANNING PAGE " .. data9.pages .. "…"
                        end
                        handler21("PAGE " .. data9.pages .. " — " .. #data9.servers .. " FOUND", data10.AMBER)
                        local text = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"):format(placeId)
                        if data9.cursor then
                            text ..= "&cursor=" .. value20:UrlEncode(data9.cursor)
                        end
                        local value28, value29 = handler14(text, condition2)
                        value24 = value29
                        if value28 then
                            local data15 = value28.data
                            local value30, value31, value32 = ipairs(data15 or ({}))
                            local b_1 = 2
                            local nextEntry4 = createIterator(value30, value31, value32)
                            while true do
                                local hasEntry16, entryKey16, entryValue12 = nextEntry4()
                                if not hasEntry16 then
                                    break
                                end
                                do
                                    local value33 = entryValue12
                                    local exitReason2 = nil
                                    while value33.id do
                                        if not (value33.id ~= game.JobId) then
                                            local hasEntry17, entryKey17, entryValue13 = nextEntry4()
                                            if hasEntry17 then
                                                value33 = entryValue13
                                                continue
                                            else
                                                exitReason2 = 1
                                                break
                                            end
                                        end
                                        do
                                            local playing = value33.playing
                                            playing = value33.playing or 0
                                            local maxPlayers = value33.maxPlayers or 0
                                            if (value33.maxPlayers or 0) == 0 then
                                                table.insert(data9.servers, value33)
                                                local hasEntry17, entryKey17, entryValue13 = nextEntry4()
                                                if hasEntry17 then
                                                    value33 = entryValue13
                                                    continue
                                                else
                                                    exitReason2 = 2
                                                    break
                                                end
                                            elseif playing < (value33.maxPlayers or 0) then
                                                table.insert(data9.servers, value33)
                                                local hasEntry17, entryKey17, entryValue13 = nextEntry4()
                                                if hasEntry17 then
                                                    value33 = entryValue13
                                                    continue
                                                else
                                                    exitReason2 = 2
                                                    break
                                                end
                                            end
                                        end
                                        break
                                    end
                                    if exitReason2 == 1 then
                                        break
                                    end
                                    if exitReason2 == 2 then
                                        break
                                    end
                                end
                            end
                            nextEntry4 = value25
                            local value33 = value26
                            local value34 = value27
                            b_1 = b_0
                            data9.cursor = value28.nextPageCursor
                            data9.lastUpdate = tick()
                            if data9.cursor then
                                if data9.cursor == "" then
                                    data9.finished = true
                                    data9.cursor = nil
                                end
                            else
                                data9.finished = true
                                data9.cursor = nil
                            end
                            if not data9.finished and numberValue18 < value23 then
                                local text2 = string.format("PAGE %d DONE — WAITING %.1fs…", data9.pages, data8.PAGE_DELAY)
                                if #data9.servers > 0 then
                                    handler18()
                                    handler15(text2)
                                else
                                    TextLabel6.Text = (string.format("PAGE %d DONE — WAITING %.1fs…", data9.pages, data8.PAGE_DELAY))
                                end
                                handler21(text2, data10.CYAN)
                                task.wait(data8.PAGE_DELAY)
                                handler16()
                            end
                            numberValue16 = 383868137
                            value24 = nil
                            if value23 <= numberValue18 then
                                exitReason = 2
                                break
                            else
                                continue
                            end
                        end
                    end
                    break
                end
                if exitReason ~= 1 and exitReason ~= 2 then
                    local value28 = handler17(value24)
                    if not condition2 then
                        TextLabel6.Text = value28
                    end
                    handler21(value28, data10.RED)
                    handler20(value28, data10.RED)
                    warn("[ServerBrowser] " .. value28 .. " | Page: " .. data9.pages)
                    numberValue16 = 383868137
                end
                Frame9.Visible = false
                handler16()
                handler18()
                if value24 then
                    local numberValue19 = 2372344754
                    if #data9.servers > 0 then
                        local text = " — SHOWING " .. #data9.servers .. " CACHED"
                        handler20(handler17(value24) .. text, data10.AMBER)
                        numberValue15 = bit32.bor(numberValue15, 2609268571)
                        local text2 = " | PARTIAL " .. #data9.servers
                        handler21(handler17(value24) .. text2, data10.AMBER)
                    else
                        local value28 = bit32.band(numberValue15, 4294967295)
                        local value29 = bit32.band((bit32.band(numberValue15, 4294967295)), 65535)
                        local value30 = bit32.band((bit32.band((bit32.band(numberValue15, 4294967295)), 65535)) * 11530 + bit32.lshift(bit32.band(
                            (bit32.band((bit32.band(numberValue15, 4294967295)), 65535)) * 0 + bit32.rshift((bit32.band(numberValue15, 4294967295)), 16) * 11530,
                            65535
                        ), 16), 4294967295)
                        local red = data10.RED
                        handler21(handler17(value24), red)
                        numberValue15 = value30 - 306413875
                    end
                elseif data9.finished then
                    handler21("FULL SCAN DONE — " .. #data9.servers .. " SERVERS", data10.GREEN_GLOW)
                    handler20("SCAN COMPLETE — " .. #data9.servers .. " SERVERS", data10.GREEN_GLOW)
                else
                    handler21("PAGE SAVED — CLICK LOAD MORE TO CONTINUE", data10.CYAN)
                    numberValue17 = numberValue17 - numberValue16 + 383868137
                end
                refreshLabel.Active = true
                waitLabel.Active = true
                TextButton2.Active = true
                refreshLabel.Text = "REFRESH"
                waitLabel.Text = "LOAD MORE"
                condition = false
            end

            local mouseButton1Click = refreshLabel.MouseButton1Click
            local numberValue12 = 534418164

            function handler19()
                local handler33 = function()
                    local lastUpdate = data9.lastUpdate
                    local numberValue14 = tick() - lastUpdate
                    if #data9.servers > 0 and numberValue14 <= data8.CACHE_TIME then
                        handler18()
                        local cyan = data10.CYAN
                        handler20(
                            "CACHE STILL FRESH (" .. math.floor(data8.CACHE_TIME - numberValue14) .. "s) — RESET TO RELOAD",
                            cyan
                        )
                        return
                    end
                    handler24(2, true)
                end

                task.spawn(handler33)
            end

            numberValue12 = 210951956
            refreshLabel.MouseButton1Click.Connect(mouseButton1Click, handler19)
            waitLabel.MouseButton1Click:Connect(function()
                task.spawn(function()
                    if data9.finished then
                        handler20("ALL PAGES LOADED — NO MORE SERVERS", data10.AMBER)
                        handler21("NO MORE PAGES", data10.AMBER)
                        return
                    end
                    handler24(2, false)
                end)
            end)
            local mouseButton1Click2 = TextButton2.MouseButton1Click
            local numberValue13 = 395406426

            function handler23()
                if condition then
                    return
                end
                handler22()
            end

            numberValue13 = 523225066
            TextButton2.MouseButton1Click.Connect(mouseButton1Click2, handler23)
            task.spawn(function()
                handler24(2, true)
            end)
        end)
        StatusPlaceId = SectionServer.CreateLabel({Title = "PlaceId: " .. game.PlaceId})
        Runtime.value = ""
        Runtime.guardKey3 = 3187605294

        local handler = function(value2)
            Runtime.value = value2
        end

        SectionServer.CreateBox({
            Title = "Input JobId Normal And JobId BananaCat",
            Placeholder = "Type here",
            Number = false,
            Default = nil,
        }, handler)
        createToggle = SectionServer.CreateToggle
        Runtime.numberValue2 = 402979187
        Runtime.data2 = {Title = "Spam Join", Desc = nil}
        Runtime.spamJoin = Settings["Spam Join"]
        return sharedState, sharedState2, sharedState3, sharedState4, sharedState5, sharedState6, handler25, createToggle3, data11, handler26, createToggle4, data12, handler27, value, handler28, sharedState7, handler29, handler30, handler31, handler32, sharedState8, createLabel, data13, createLabel2, data14, value21, handler, Settings["Spam Join"]
    end

    -- Initialize server travel
    function Features.initializeServerTravel()
        Runtime.data2.Default = Runtime.spamJoin
        createToggle(Runtime.data2, function(inputValue)
            SaveSettings("Spam Join", inputValue)
        end)
        Runtime.guardState25 = bit32.band(Runtime.guardState3, Runtime.numberValue2)
        Runtime.chunk = loadstring([[local function EQ(a, r)
    local b, c = nil, nil
    local success = pcall(function()
        b, c = a, r
    end)

    if not success or b == nil or c == nil then
        return false
    end

    if type(b) ~= type(c) then
        return false
    end

    local d = { c, b, c, b }
    if d[1] ~= d[1] then
        return false
    end
    if d[1] ~= d[2] then
        return false
    end
    if d[2] ~= d[1] then
        return false
    end

    local e, f, g = 1 and 2, 2 and nil, true == not not true

    if type(b) == "number" and type(c) == "number" then
        if e and g and not f then
            return b == c
        end
    elseif type(b) == "string" and type(c) == "string" then
        if e and g then
            return b == c
        end
    else
        return b == c
    end

    return false
end

local function _vrf()
    local x = os.time and os.time() or 12345
    if tostring(print):find("function") == nil then
        while true do
        end
    end
    if tostring(type):find("function") == nil then
        while true do
        end
    end
    if (x * x + x) % 2 ~= 0 then
        while true do
        end
    end
    if not EQ(x, x) then
        while true do
        end
    end
end

local function _gct()
    _vrf()
    local s, p1, p2, p3 = 17, {}, {}, {}
    local _m = { [17] = 23, [23] = 41, [41] = 999 }

    while true do
        if s == 17 then
            for i = 0, 255 do
                local c = ("%c"):format(i)
                p1[i] = c
                p2[c] = i
            end
            s = _m[17]
        elseif s == 23 then
            for i = 0, 255 do
                p3[i] = p1[i]
            end
            s = _m[23]
        elseif s == 41 then
            if EQ(s, 41) then
                return p3, p2
            else
                while true do
                end
            end
        else
            while true do
            end
        end
    end
end

local _CT, _BT = _gct()

local _sp = (function()
    local _xk = { 0x61, 0x9A, 0x43, 0xF1, 0x27, 0xBC, 0x58, 0x0D, 0xE7, 0x33 }

    local _enc = {
        { 0x9A, 0x71, 0x24, 0xEF, 0x38, 0x4C },
        { 0x7D, 0xA1, 0x55, 0x92, 0xB7, 0x44, 0x18 },
        { 0x2F, 0xC3, 0x89, 0x11, 0xD4, 0x67 },
        { 0xA8, 0x3E, 0xD1, 0x5B },
        { 0x44, 0xE2, 0x71, 0x9C, 0x0A, 0xD8, 0x61, 0xF4 },
        { 0x1E, 0x7B, 0xC0, 0x35, 0x92, 0xAF, 0x4D, 0x28 },
        { 0xF3, 0x60, 0x1A, 0x87, 0xCE, 0x39, 0x54 },
        { 0x88, 0x2D, 0xB6, 0x41, 0xFA, 0x73, 0x19, 0xCC, 0x05 },
    }

    local function _dec(data, seed)
        local result = ""
        local state = seed or 0x53

        for i = 1, #data do
            local byte = data[i]
            local keyIdx = ((i - 1) % #_xk) + 1
            local key = _xk[keyIdx]

            byte = bit32.bxor(byte, key)
            byte = (byte - state + 256) % 256
            byte = bit32.bxor(byte, (i * 23) % 256)
            state = (state + i + key + 17) % 256

            result = result .. _CT[byte]
        end

        return result
    end

    local _d = {}
    for i = 1, #_enc do
        _d[i] = _dec(_enc[i], (i * 0x29) % 256)
    end

    return _d
end)()

local function _gb(str, pos)
    _vrf()
    local c, s = 0, 5
    local _states = { [5] = 7, [7] = 11, [11] = 999 }

    while true do
        if s == 5 then
            for ch in str:gmatch(".") do
                c = c + 1
                if c == pos then
                    s = _states[5]
                    break
                end
            end
            if s ~= 7 then
                s = _states[11]
            end
        elseif s == 7 then
            local ch = ""
            local cnt = 0
            for c2 in str:gmatch(".") do
                cnt = cnt + 1
                if cnt == pos then
                    ch = c2
                    break
                end
            end
            if EQ(_BT[ch] or 0, _BT[ch] or 0) then
                return _BT[ch] or 0
            end
        elseif s == 11 then
            return 0
        end
    end
end

local function _tc(num)
    if EQ(num, num) then
        return _CT[num % 256]
    end
    while true do
    end
end

local function _js(tbl)
    local r, s = "", 3
    local _sm = { [3] = 8, [8] = 999 }

    while true do
        if s == 3 then
            for i = 1, #tbl do
                r = r .. tbl[i]
            end
            s = _sm[3]
        elseif s == 8 then
            if EQ(r, r) then
                return r
            end
        end
    end
end

local function _gl(str)
    _vrf()
    local c = 0
    for _ in str:gmatch(".") do
        c = c + 1
    end
    if EQ(c, c) then
        return c
    end
    return 0
end

local function _rp(str, pat, rep)
    _vrf()
    local r, pl, m = "", _gl(pat), true

    for i = 1, pl do
        if _gb(str, i) ~= _gb(pat, i) then
            m = false
            break
        end
    end

    if m and EQ(m, true) then
        r = rep
        for i = pl + 1, _gl(str) do
            local ch = ""
            local cnt = 0
            for c in str:gmatch(".") do
                cnt = cnt + 1
                if cnt == i then
                    ch = c
                    break
                end
            end
            r = r .. ch
        end
        return r
    end

    return str
end

local function _cs(...)
    local args, r = { ... }, ""
    for i = 1, #args do
        r = r .. args[i]
    end
    if EQ(r, r) then
        return r
    end
    return ""
end

local function _gks(key, len)
    _vrf()
    local ks, kl, st = {}, _gl(key), 0

    for i = 1, len do
        local kp = ((i - 1) % kl) + 1
        local kb = _gb(key, kp)
        st = (st + kb + i + ((i * 11) % 256)) % 256
        ks[i] = (kb + st + (i * 17) + ((kb * 3) % 256)) % 256
    end

    if EQ(#ks, len) then
        return ks
    end
    return {}
end

local function _mix_key_material(key, salt)
    _vrf()
    local rev = key:reverse()
    local out = {}
    local src = _cs(key, salt, rev, _tc(_gl(key) % 256), _tc(_gl(salt) % 256))

    for i = 1, _gl(src) do
        local b = _gb(src, i)
        b = bit32.bxor(b, (i * 29) % 256)
        b = (b + ((i * 7) % 256)) % 256
        out[i] = _tc(b)
    end

    return _js(out)
end

local function _derive_stream(key, salt, len)
    _vrf()
    local km = _mix_key_material(key, salt)
    return _gks(km, len)
end

local function _randb()
    return math.random(0, 255)
end

local function _gensalt128()
    _vrf()
    local t = {}
    for i = 1, 16 do
        t[i] = _tc(_randb())
    end
    return _js(t)
end

local function _secure_round_enc(key, data, salt, round_idx)
    _vrf()
    local dl = _gl(data)
    local ks = _derive_stream(_cs(key, _tc(48 + round_idx)), salt, dl)
    local r = {}
    local st = (_gl(key) + _gl(salt) + round_idx * 37 + 91) % 256

    for i = 1, dl do
        local db = _gb(data, i)
        local sb = _gb(salt, ((i + round_idx - 2) % 16) + 1)
        local kk = ks[i]

        st = (st + kk + sb + i + round_idx) % 256

        local enc = db
        enc = bit32.bxor(enc, kk)
        enc = (enc + st + sb) % 256
        enc = bit32.bxor(enc, ((i * 31) + sb + round_idx * 9) % 256)
        enc = (enc + ((kk * 5) % 256)) % 256

        r[i] = _tc(enc)
    end

    return _js(r)
end

local function _secure_round_dec(key, data, salt, round_idx)
    _vrf()
    local dl = _gl(data)
    local ks = _derive_stream(_cs(key, _tc(48 + round_idx)), salt, dl)
    local r = {}
    local st = (_gl(key) + _gl(salt) + round_idx * 37 + 91) % 256

    for i = 1, dl do
        local sb = _gb(salt, ((i + round_idx - 2) % 16) + 1)
        local kk = ks[i]

        st = (st + kk + sb + i + round_idx) % 256

        local eb = _gb(data, i)

        local db = eb
        db = (db - ((kk * 5) % 256) + 256) % 256
        db = bit32.bxor(db, ((i * 31) + sb + round_idx * 9) % 256)
        db = (db - st - sb + 512) % 256
        db = bit32.bxor(db, kk)

        r[i] = _tc(db)
    end

    return _js(r)
end

local function _ae(key, data, salt, rnd)
    _vrf()
    rnd = rnd or 3
    local r = data

    for rd = 1, rnd do
        r = _secure_round_enc(key, r, salt, rd)
        if not EQ(r, r) then
            while true do
            end
        end
    end

    return r
end

local function _ad(key, data, salt, rnd)
    _vrf()
    rnd = rnd or 3
    local r = data

    for rd = rnd, 1, -1 do
        r = _secure_round_dec(key, r, salt, rd)
        if not EQ(r, r) then
            while true do
            end
        end
    end

    return r
end

local _b64 = (function()
    local chs = string.char(
        65,
        66,
        67,
        68,
        69,
        70,
        71,
        72,
        73,
        74,
        75,
        76,
        77,
        78,
        79,
        80,
        81,
        82,
        83,
        84,
        85,
        86,
        87,
        88,
        89,
        90,
        97,
        98,
        99,
        100,
        101,
        102,
        103,
        104,
        105,
        106,
        107,
        108,
        109,
        110,
        111,
        112,
        113,
        114,
        115,
        116,
        117,
        118,
        119,
        120,
        121,
        122,
        48,
        49,
        50,
        51,
        52,
        53,
        54,
        55,
        56,
        57,
        43,
        47
    )

    local function enc(data)
        _vrf()
        local r, dl = {}, _gl(data)
        local i = 1

        while i <= dl do
            local b1 = _gb(data, i)
            local b2 = i + 1 <= dl and _gb(data, i + 1) or 0
            local b3 = i + 2 <= dl and _gb(data, i + 2) or 0

            local n = b1 * 65536 + b2 * 256 + b3

            local c1 = (n // 262144) % 64 + 1
            local c2 = (n // 4096) % 64 + 1
            local c3 = (n // 64) % 64 + 1
            local c4 = n % 64 + 1

            r[#r + 1] = _gb(chs, c1)
            r[#r + 1] = _gb(chs, c2)
            r[#r + 1] = i + 1 <= dl and _gb(chs, c3) or 61
            r[#r + 1] = i + 2 <= dl and _gb(chs, c4) or 61

            i = i + 3
        end

        local out = {}
        for idx = 1, #r do
            out[idx] = _tc(r[idx])
        end

        if EQ(_js(out), _js(out)) then
            return _js(out)
        end
        return ""
    end

    local function dec(data)
        _vrf()
        local r, dl = {}, _gl(data)
        local i = 1

        while i <= dl do
            local c1 = _gb(data, i)
            local c2 = _gb(data, i + 1)
            local c3 = _gb(data, i + 2)
            local c4 = _gb(data, i + 3)

            local function fp(byte)
                if byte == 61 then
                    return 0
                end
                for p = 1, 64 do
                    if _gb(chs, p) == byte then
                        return p - 1
                    end
                end
                return 0
            end

            local n1, n2, n3, n4 = fp(c1), fp(c2), fp(c3), fp(c4)
            local n = n1 * 262144 + n2 * 4096 + n3 * 64 + n4

            r[#r + 1] = _tc((n // 65536) % 256)
            if c3 ~= 61 then
                r[#r + 1] = _tc((n // 256) % 256)
            end
            if c4 ~= 61 then
                r[#r + 1] = _tc(n % 256)
            end

            i = i + 4
        end

        if EQ(_js(r), _js(r)) then
            return _js(r)
        end
        return ""
    end

    return { encode = enc, decode = dec }
end)()

local function _seed_rng()
    local seed = (os.time and os.time() or 12345)
        + math.floor((os.clock and os.clock() or 0) * 100000)
        + math.random(1, 999999)

    math.randomseed(seed)
    math.random()
    math.random()
    math.random()
end

_seed_rng()

local function ebgzqifrwa(plaintext)
    _vrf()
    local k = _cs(_sp[5], _sp[6], _sp[7], _sp[8])
    if not EQ(k, k) then
        while true do
        end
    end

    local salt = _gensalt128()
    local enc = _ae(k, plaintext, salt, 3)
    local payload = _cs(salt, enc)
    local b64 = _b64.encode(payload)

    if EQ(b64, b64) then
        return _cs("BananaCat-", b64)
    end
    return ""
end

local function lebidlyjyf(encrypted)
    _vrf()
    local k = _cs(_sp[5], _sp[6], _sp[7], _sp[8])
    if not EQ(k, k) then
        while true do
        end
    end

    local ed = _rp(encrypted, "BananaCat-", "")
    local dc = _b64.decode(ed)

    if _gl(dc) < 16 then
        return ""
    end

    local salt_tbl = {}
    local data_tbl = {}

    for i = 1, 16 do
        salt_tbl[#salt_tbl + 1] = _tc(_gb(dc, i))
    end

    for i = 17, _gl(dc) do
        data_tbl[#data_tbl + 1] = _tc(_gb(dc, i))
    end

    local salt = _js(salt_tbl)
    local data = _js(data_tbl)

    if EQ(data, data) then
        return _ad(k, data, salt, 3)
    end
    return ""
end
return ebgzqifrwa, lebidlyjyf
]])
        local value = game
        local getService = game.GetService
        blackScreen2 = "ReplicatedStorage"
        Realm = require(getService(value, blackScreen2).Util.Realm)

        function tryTeleport(inputValue, inputValue2, inputValue3)
            local ok, result3 = pcall(function()
                game:GetService("TeleportService"):TeleportToPlaceInstance(
                    inputValue,
                    inputValue2,
                    Runtime.localPlayer2
                )
            end)
            if ok then
                inputValue3.done = true
                return
            end
            warn("Teleport thất bại:", inputValue, result3)
        end

        function teleportSmart(y)
            local value2 = Realm.safeGetCurrentSeaAsync()
            local value3, data = if value2 == "Sea1" then {2753915549, 85211729168715} else if value2 == "Sea2" then {4442272183, 79091703265657} else if value2 == "Sea3" then {7449423635, 100117331123089} else {}, {done = false}
            for i, value4 in ipairs(value3) do
                task.spawn(function()
                    if not not data.done then
                        return
                    end
                    tryTeleport(value4, y, data)
                end)
            end
        end

        local handler = function()
            if Settings["Spam Join"] then
                while task.wait() do
                    local value2 = Runtime.value
                    local value3, value4 = Runtime.chunk()
                    if string.find(Runtime.value, "BananaCat-") then
                        value2 = value4(Runtime.value)
                    end
                    game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", value2)
                end
                return
            end
            local value2, value3 = Runtime.chunk()
            string.find(Runtime.value, "BananaCat-")
            return nil
        end

        SectionServer.CreateButton({Title = "Join JobId"}, handler)
        SectionServer.CreateButton({Title = "Copy JobId"}, function()
            setclipboard(tostring(game.JobId))
        end)
        Runtime.data12 = {}
        local ok = pcall(function()
            readfile("Banana Cat Hub/Jobid.json")
        end)
        return value, getService, handler, ok
    end

    -- Initialize server hopping
    function Features.initializeServerHopping()
        local sharedState = {}

        function GetServerList()
            local bfServerList = getgenv().__BF_ServerList
            if bfServerList then
                local at = bfServerList.At
                if os.clock() - at < 30 then
                    return bfServerList.List
                end
            end
            local serverBrowser = game:GetService("ReplicatedStorage").__ServerBrowser
            local data = {}
            local numberValue = 0
            local numberValue2 = 1
            local numberValue3 = 100
            local numberValue4 = 0
            numberValue4 += 1
            local value
            if numberValue4 <= 100 then
                value = numberValue4
                while true do
                    task.delay(value / 50, function()
                        local ok, result3 = pcall(serverBrowser.InvokeServer, serverBrowser, value)
                        if ok then
                            if type(result3) ~= "table" then
                                result3 = {}
                            else
                                result3 = result3 or ({})
                            end
                        else
                            result3 = {}
                        end
                        local value2, value3, value4 = pairs(result3)
                        local b_1 = 2
                        local nextEntry4 = createIterator(value2, value3, value4)
                        local hasEntry16, entryKey16, entryValue12 = nextEntry4()
                        if hasEntry16 then
                            local value5 = entryKey16
                            local value6 = entryValue12
                            while true do
                                data[value5] = value6
                                local hasEntry17, entryKey17, entryValue13 = nextEntry4()
                                if not hasEntry17 then
                                    break
                                end
                                value5 = entryKey17
                                value6 = entryValue13
                            end
                        end
                        numberValue += 1
                    end)
                    numberValue4 += numberValue2
                    if numberValue2 <= 0 then
                        if numberValue4 >= numberValue3 then
                            value = numberValue4
                            continue
                        end
                    else
                        if numberValue4 <= numberValue3 then
                            value = numberValue4
                            continue
                        end
                    end
                    break
                end
            end
            local value2
            numberValue4 = value2
            local value3
            numberValue3 = value3
            local value4
            numberValue2 = value4
            local b_0
            local b_1 = b_0
            local now = os.clock()
            while true do
                task.wait()
                if numberValue >= 100 then
                    break
                elseif os.clock() - now > 10 then
                    break
                end
            end
            getgenv().__BF_ServerList = {At = os.clock(), List = data}
            return data
        end

        function HopToRandomServer(inputValue)
            local numberValue = 3905861059
            local numberValue2 = inputValue or game.Players.MaxPlayers - 2
            local bfHopTried = getgenv().__BF_HopTried or ({})
            local data = {}
            local hopServerRegion = Settings["Hop Server Region"]
            getgenv().__BF_HopTried = bfHopTried
            local value, value2, value3 = pairs(GetServerList())
            local b_1 = 2
            local nextEntry4 = createIterator(value, value2, value3)
            while true do
                local hasEntry16, entryKey16, entryValue12 = nextEntry4()
                if not hasEntry16 then
                    break
                end
                do
                    local value4 = entryKey16
                    local value5 = entryValue12
                    local exitReason = nil
                    while true do
                        if value4 ~= game.JobId then
                            if not bfHopTried[value4] and (type(value5) == "table" and (type(value5.Count) == "number" and value5.Count <= numberValue2)) then
                                if not hopServerRegion then
                                    data[#data + 1] = value4
                                    local hasEntry17, entryKey17, entryValue13 = nextEntry4()
                                    if hasEntry17 then
                                        value4 = entryKey17
                                        value5 = entryValue13
                                        continue
                                    else
                                        exitReason = 2
                                        break
                                    end
                                end
                                if not (hopServerRegion ~= "Any") then
                                    data[#data + 1] = value4
                                    local hasEntry17, entryKey17, entryValue13 = nextEntry4()
                                    if hasEntry17 then
                                        value4 = entryKey17
                                        value5 = entryValue13
                                        continue
                                    else
                                        exitReason = 3
                                        break
                                    end
                                end
                                if string.find(tostring(value5.Region), hopServerRegion, 1, true) == 1 then
                                    data[#data + 1] = value4
                                    local hasEntry17, entryKey17, entryValue13 = nextEntry4()
                                    if hasEntry17 then
                                        value4 = entryKey17
                                        value5 = entryValue13
                                        continue
                                    else
                                        exitReason = 4
                                        break
                                    end
                                end
                            end
                            break
                        end
                        do
                            local hasEntry17, entryKey17, entryValue13 = nextEntry4()
                            if not hasEntry17 then
                                exitReason = 1
                                break
                            end
                            value4 = entryKey17
                            value5 = entryValue13
                        end
                    end
                    if exitReason == 1 then
                        break
                    end
                    if exitReason == 2 then
                        break
                    end
                    if exitReason == 3 then
                        break
                    end
                    if exitReason == 4 then
                        break
                    end
                end
            end
            local value4
            nextEntry4 = value4
            local value5
            local value6 = value5
            local value7
            local value8 = value7
            local b_0
            b_1 = b_0
            local serverBrowser = game:GetService("ReplicatedStorage").__ServerBrowser
            while #data > 0 do
                local value9 = table.remove(data, math.random(#data))
                bfHopTried[value9] = true
                if pcall(serverBrowser.InvokeServer, serverBrowser, "teleport", value9) then
                    if getgenv().limit_type then
                        getgenv().limit_type("clearAll")
                        return true
                    end
                    return true
                end
            end
            return false
        end

        function HopServer(y)
            local function handler()
                HopToRandomServer()
            end

            local timeHopServer = y or (Settings["Time Hop Server"] or 5)
            require(game:GetService("ReplicatedStorage").Notification).new("<Color=Red>Banana Cat Hub : Wait " .. timeHopServer .. "s [Hop Server]<Color=/>"):Display()
            while wait(timeHopServer) do
                require(game:GetService("ReplicatedStorage").Notification).new("<Color=Red>Banana Cat Hub : Hop Server<Color=/>"):Display()
                handler()
            end
        end

        local createButton = SectionServer.CreateButton
        local data = {}
        sharedState.value = bit32.band(Runtime.guardKey3, 3904279808)
        data.Title = "Hop Server"
        createButton(data, function()
            HopServer()
        end)

        function HopLessAll()
            require(game:GetService("ReplicatedStorage").Notification).new("<Color=Red>Banana Hub : Hop Server<Color=/>"):Display()
            local y, data2, text = game.PlaceId, {}, ""
            local hour = os.date("!*t").hour
            local ok = pcall(function()
                data2 = game:GetService("HttpService"):JSONDecode(readfile("Banana Cat Hub/NotSameServers.json"))
            end)
            if not ok then
                table.insert(data2, hour)
                writefile("Banana Cat Hub/NotSameServers.json", game:GetService("HttpService"):JSONEncode(data2))
            end

            function HopServerLess()
                local value, x = if text == "" then game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. y .. "/servers/Public?sortOrder=Asc&limit=100")) else game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. y .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. text)), ""
                if value.nextPageCursor and (value.nextPageCursor ~= "null" and value.nextPageCursor ~= nil) then
                    text = value.nextPageCursor
                end
                local y, data3 = pairs, value.data
                local numberValue = 0
                for k, value2 in y(data3) do
                    k = true
                    x = tostring(value2.id)
                    if tonumber(value2.maxPlayers) > tonumber(value2.playing) and tonumber(value2.playing) <= 3 then
                        local y, numberValue2, value3 = data2, numberValue, k
                        for k2, value4 in pairs(y) do
                            if numberValue2 ~= 0 then
                                value3 = if x == tostring(value4) then false else value3
                            else
                                if tonumber(hour) ~= tonumber(value4) then
                                    pcall(function()
                                        delfile("Banana Cat Hub/NotSameServers.json")
                                        data2 = {}
                                        table.insert(data2, hour)
                                    end)
                                end
                            end
                            numberValue2 = numberValue2 + 1
                        end
                        if value3 == true then
                            table.insert(data2, x)
                            wait()
                            pcall(function()
                                writefile(
                                    "Banana Cat Hub/NotSameServers.json",
                                    game:GetService("HttpService"):JSONEncode(data2)
                                )
                                wait()
                                game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", x)
                                getgenv().limit_type("clearAll")
                            end)
                            wait(4)
         