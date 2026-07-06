local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer

local function ShowDeclaration()
    if Lighting:FindFirstChild("DeclarationBlur") then
        Lighting.DeclarationBlur:Destroy()
    end

    local blur = Instance.new("BlurEffect")
    blur.Name = "DeclarationBlur"
    blur.Size = 0
    blur.Parent = Lighting

    TweenService:Create(blur, TweenInfo.new(0.5), {Size = 16}):Play()

    local screenGui = Instance.new("ScreenGui")
    screenGui.IgnoreGuiInset = true
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1,0,1,0)
    bg.BackgroundColor3 = Color3.fromRGB(10,12,25)
    bg.BackgroundTransparency = 0.25
    bg.Parent = screenGui

    local layer = Instance.new("Frame")
    layer.Size = UDim2.new(1,0,1,0)
    layer.BackgroundTransparency = 1
    layer.Parent = bg

    local particles = {}

    for i = 1, 35 do
        local p = Instance.new("Frame")
        p.Size = UDim2.new(0, math.random(2,4), 0, math.random(2,4))
        p.Position = UDim2.new(math.random(),0,math.random(),0)
        p.BackgroundColor3 = Color3.fromRGB(120,180,255)
        p.BackgroundTransparency = math.random(40,80)/100
        p.BorderSizePixel = 0
        p.Parent = layer

        Instance.new("UICorner", p).CornerRadius = UDim.new(1,0)

        table.insert(particles, {
            obj = p,
            vx = (math.random()-0.5)*0.12,
            vy = (math.random()-0.5)*0.12,
            baseT = p.BackgroundTransparency
        })
    end

    RunService.RenderStepped:Connect(function()
        for _,p in ipairs(particles) do
            local pos = p.obj.Position
            local x = pos.X.Scale + p.vx * 0.002
            local y = pos.Y.Scale + p.vy * 0.002

            if x < 0 or x > 1 then p.vx = -p.vx end
            if y < 0 or y > 1 then p.vy = -p.vy end

            p.obj.Position = UDim2.new(math.clamp(x,0,1),0,math.clamp(y,0,1),0)

            local breathe = math.sin(os.clock()*1.2 + x*10)*0.3 + 0.7
            p.obj.BackgroundTransparency = p.baseT * breathe
        end
    end)

    local dialog = Instance.new("Frame")
    dialog.Size = UDim2.new(0, 420, 0, 320)
    dialog.Position = UDim2.new(0.5,0,0.5,0)
    dialog.AnchorPoint = Vector2.new(0.5,0.5)
    dialog.BackgroundColor3 = Color3.fromRGB(25,28,45)
    dialog.BorderSizePixel = 0
    dialog.Parent = bg

    Instance.new("UICorner", dialog).CornerRadius = UDim.new(0,16)

    TweenService:Create(dialog, TweenInfo.new(0.5, Enum.EasingStyle.Elastic), {
        Size = UDim2.new(0, 420, 0, 320)
    }):Play()

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,0,0,50)
    title.BackgroundTransparency = 1
    title.Text = "VOTR HUB"
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.Parent = dialog

    local content = Instance.new("TextLabel")
    content.Size = UDim2.new(1,-30,0,150)
    content.Position = UDim2.new(0,15,0,55)
    content.BackgroundTransparency = 1
    content.TextWrapped = true
    content.TextYAlignment = Enum.TextYAlignment.Top
    content.Font = Enum.Font.Gotham
    content.TextSize = 13
    content.TextColor3 = Color3.fromRGB(210,220,255)
    content.Text = "禁止在VOTR HUB群聊内询问更新日志\n禁止在VOTR HUB群聊内询问支持哪些服务器\n如果有想玩的服务器脚本,找棍木群主\n\n\n如果在群内被禁言，那就是你违反了规则\n最终解释权归NiL Team所有"
    content.Parent = dialog

    local function makeBtn(text, color, x)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0,170,0,40)
        b.Position = UDim2.new(x,0,0.82,0)
        b.BackgroundColor3 = color
        b.Text = text
        b.TextColor3 = Color3.new(1,1,1)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 15
        b.Parent = dialog

        Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
        return b
    end

    local agree = makeBtn("同意", Color3.fromRGB(40,180,80), 0.07)
    local reject = makeBtn("拒绝", Color3.fromRGB(200,60,60), 0.55)

    agree.Active = false
    reject.Active = false

    local cd = 3
    task.spawn(function()
        while cd > 0 do
            title.Text = "VOTR HUB ("..cd..")"
            cd -= 1
            task.wait(1)
        end

        title.Text = "VOTR HUB"
        agree.Active = true
        reject.Active = true
    end)

    agree.MouseButton1Click:Connect(function()
        if not agree.Active then return end

        blur:Destroy()
        screenGui:Destroy()

if not VOTR or VOTR ~= "887502203" then 
game.Players.LocalPlayer:Kick("进群获取卡密\n群号887502203\n已经自动复制")
setclipboard("887502203")
    return
end

local safeLoad = function(url, name)
    task.spawn(function()
        local ok, err = pcall(function()
            loadstring(game:HttpGet(url, true))()
        end)
        if not ok then
            warn("[VOTR]", name, "加载失败:", err)
        end
    end)
end

local exec = "未知执行器"
pcall(function() exec = identifyexecutor() end)

local function Q(R, S, T, U)
    S = S or 2
    T = T or 0
    U = U or {}
    local V = string.rep(" ", T * S)
    local W = string.rep(" ", (T + 1) * S)

    if R == nil then return "null" end

    local X = type(R)
    if X == "table" then
        if U[R] then return "\"[Circular Reference]\"" end
        U[R] = true

        local isArray, maxIdx, count = true, 0, 0
        for k, _ in pairs(R) do
            if type(k) == "number" and k > maxIdx then maxIdx = k end
            if type(k) ~= "number" or k <= 0 or math.floor(k) ~= k then
                isArray = false
                break
            end
        end
        for _ in pairs(R) do count = count + 1 end
        if count ~= maxIdx then isArray = false end
        if count == 0 then return "{}" end

        if isArray then
            local out = "[\n"
            for i = 1, maxIdx do
                out = out .. W .. Q(R[i], S, T + 1, U)
                if i < maxIdx then out = out .. "," end
                out = out .. "\n"
            end
            return out .. V .. "]"
        else
            local out = "{\n"
            local keys = {}
            for k in pairs(R) do table.insert(keys, k) end
            table.sort(keys, function(a, b)
                if type(a) == type(b) then return tostring(a) < tostring(b) end
                return type(a) < type(b)
            end)
            local first = true
            for _, k in ipairs(keys) do
                if not first then out = out .. ",\n" else first = false end
                out = out .. W .. "\"" .. tostring(k) .. "\": " .. Q(R[k], S, T + 1, U)
            end
            return out .. "\n" .. V .. "}"
        end

    elseif X == "string" then
        local s = R:gsub("\\", "\\\\")
                  :gsub("\"", "\\\"")
                  :gsub("\n", "\\n")
                  :gsub("\r", "\\r")
                  :gsub("\t", "\\t")
        return "\"" .. s .. "\""

    elseif X == "number" or X == "boolean" then
        return tostring(R)

    elseif X == "function" then
        return "\"function\""

    else
        return "\"" .. X .. "\""
    end
end

local function copyJson(tbl, indent)
    indent = indent or 4
    local result = Q(tbl, indent)
    pcall(function() setclipboard(result) end)
    return result
end

local zt = "<font color='#4169E1'>VOTR</font> Hub"

local WindUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/dist/main.lua"
))()

local Window = WindUI:CreateWindow({
    Title = zt,
    IconThemed = true,
    Author = "By/NIL Team",
    Folder = "store",
    Size = UDim2.fromOffset(500, 420),
    Background = "https://raw.githubusercontent.com/VOTR-HUB/MAIN/refs/heads/main/Image_1782863973467_970.jpg",
    BackgroundImageTransparency = 0.38,
    Transparent = false,
    Theme = "Dark",
    User = {
        Enabled = true,
        Callback = function() end,
        Anonymous = false,
    },
    SideBarWidth = 170,
    HideSearchBar = false,
    OpenButton = {
        Title = "<font color='#4169E1'>VOTR</font> Hub",
        Icon = "https://raw.githubusercontent.com/VOTR-SCRIPT/VOTR-TP/refs/heads/main/image_download_1779772664165.jpg",
        CornerRadius = UDim.new(0.4, 0),
        StrokeThickness = 2,
        Enabled = true,
        Draggable = true,
        OnlyMobile = true,
        Scale = 1,
        Color = ColorSequence.new(
            Color3.fromHex("#4169E1"),
            Color3.fromHex("#FFFFFF")
        ),
    },
})

local Tabs = {
    intro = Window:Tab({ Title = "简介", Icon = "info" }),
    func  = Window:Tab({ Title = "功能", Icon = "settings" }),
    MeiH = Window:Tab({ Title = "美化", Icon = "home" }),
    sbcnm = Window:Tab({ Title = "服务器", Icon = "https://raw.githubusercontent.com/VOTR-SCRIPT/VOTR-TP/refs/heads/main/image_download_1779772664165.jpg" }),
}

do
    local RS = game:GetService("RunService")
    local UIS = game:GetService("UserInputService")
    local LS = game:GetService("Lighting")

    task.spawn(function()
        task.wait(1)
        local mainContainer = Window.UIElements and Window.UIElements.Main
                          or Window:FindFirstChild("Main")
        if not mainContainer then return end

        local stroke = Instance.new("UIStroke")
        stroke.Name = "RainbowStroke"
        stroke.Thickness = 2
        stroke.Color = Color3.new(1, 1, 1)
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        local gradient = Instance.new("UIGradient")
        gradient.Name = "RainbowGradient"
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,   Color3.fromRGB(0, 50, 255)),
            ColorSequenceKeypoint.new(0.2, Color3.fromRGB(0, 150, 255)),
            ColorSequenceKeypoint.new(0.4, Color3.fromRGB(100, 200, 255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 220, 255)),
            ColorSequenceKeypoint.new(0.6, Color3.fromRGB(100, 200, 255)),
            ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 150, 255)),
            ColorSequenceKeypoint.new(1,   Color3.fromRGB(0, 50, 255)),
        })
        gradient.Enabled = true
        gradient.Parent = stroke
        stroke.Parent = mainContainer

        task.spawn(function()
            while stroke and stroke.Parent do
                task.wait(0.01)
                gradient.Rotation = (gradient.Rotation + 4) % 360
            end
        end)
    end)


    task.spawn(function()
        task.wait(1)

        local blurEffect = Instance.new("BlurEffect")
        blurEffect.Size = 0
        blurEffect.Name = "VOTRBlur"

        local dof = Instance.new("DepthOfFieldEffect")
        dof.FarIntensity = 0
        dof.InFocusRadius = 0.1
        dof.NearIntensity = 1
        dof.Name = "VOTRDof"

        local originalEffects = {}

        local function enableBlur()
            for _, e in pairs(LS:GetChildren()) do
                if e:IsA("BlurEffect") or e:IsA("DepthOfFieldEffect") then
                    originalEffects[e] = { Enabled = e.Enabled, Parent = e.Parent }
                    e.Enabled = false
                end
            end

            local cam = workspace.CurrentCamera
            if cam then
                for _, e in pairs(cam:GetChildren()) do
                    if e:IsA("BlurEffect") or e:IsA("DepthOfFieldEffect") then
                        originalEffects[e] = { Enabled = e.Enabled, Parent = e.Parent }
                        e.Enabled = false
                    end
                end
            end

            dof.Parent = LS
            blurEffect.Parent = LS

            game:GetService("TweenService"):Create(
                blurEffect,
                TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                { Size = 10 }
            ):Play()
        end

        local function disableBlur()
            for effect, data in pairs(originalEffects) do
                if effect and effect.Parent then
                    effect.Enabled = data.Enabled
                end
            end

            local tween = game:GetService("TweenService"):Create(
                blurEffect,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                { Size = 0 }
            )
            tween:Play()
            tween.Completed:Connect(function()
                blurEffect.Parent = nil
                dof.Parent = nil
            end)
        end

        if Window.UIElements and Window.UIElements.Main then
            Window.UIElements.Main:GetPropertyChangedSignal("Visible"):Connect(function()
                if Window.UIElements.Main.Visible then
                    enableBlur()
                else
                    disableBlur()
                end
            end)
        end

        if Window.UIElements
           and Window.UIElements.Main
           and Window.UIElements.Main.Visible then
            enableBlur()
        end
    end)

    local isUIVisible = true
    UIS.InputBegan:Connect(function(input, gp)
        if not gp and input.KeyCode == Enum.KeyCode.Semicolon then
            isUIVisible = not isUIVisible
            if Window.UIElements and Window.UIElements.Main then
                Window.UIElements.Main.Visible = isUIVisible
                pcall(function() Window:Toggle() end)
            elseif Window:FindFirstChild("Main") then
                Window.Main.Visible = isUIVisible
            end
        end
    end)
end

local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "VOTR Hub", Text = "反挂机已开启", Duration = 5
})
task.wait(1)
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "VOTR Hub", Text = "脚本加载完成", Duration = 5
})
task.wait(1)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Ghost = {
    ["透视颜色"] = Color3.fromRGB(255, 255, 255),
    ["透视名字"] = false,
    ["透视血量"] = false,
    ["透视开关"] = false,
    ["圆圈颜色"] = Color3.fromRGB(255, 255, 255),
    ["自瞄距离"] = 200,
    ["自瞄开关"] = false,
}

local Colors = {
    ["红"]   = Color3.fromRGB(255, 0, 0),
    ["橙"]   = Color3.fromRGB(255, 150, 0),
    ["黄"]   = Color3.fromRGB(255, 255, 15),
    ["绿"]   = Color3.fromRGB(0, 255, 0),
    ["青"]   = Color3.fromRGB(0, 255, 219),
    ["蓝"]   = Color3.fromRGB(0, 0, 255),
    ["紫"]   = Color3.fromRGB(183, 0, 255),
    ["彩色"] = nil,
}

local Circle = Drawing.new("Circle")
Circle.Filled = false
Circle.Position = Camera.ViewportSize / 2
Circle.Radius = 100
Circle.Thickness = 1
Circle.Visible = false

local espCache = {}

local function AddESP(char, color, text, enabled)
    if not char or not char.Parent then return end

    local hl = char:FindFirstChild("VOTR_Highlight")
    if not hl then
        hl = Instance.new("Highlight")
        hl.Name = "VOTR_Highlight"
        hl.FillTransparency = 0.5
        hl.OutlineTransparency = 0
        hl.Parent = char
        espCache[char] = hl
    end
    hl.FillColor = color or Color3.new(1, 1, 1)
    hl.Enabled = enabled

    local bg = char:FindFirstChild("VOTR_ESP")
    if not bg then
        bg = Instance.new("BillboardGui")
        bg.Name = "VOTR_ESP"
        bg.Size = UDim2.new(0, 100, 0, 50)
        bg.StudsOffset = Vector3.new(0, 3, 0)
        bg.AlwaysOnTop = true
        bg.Parent = char

        local tl = Instance.new("TextLabel")
        tl.Name = "Text"
        tl.BackgroundTransparency = 1
        tl.Size = UDim2.new(1, 0, 1, 0)
        tl.TextColor3 = color or Color3.new(1, 1, 1)
        tl.TextSize = 11
        tl.Font = Enum.Font.Gotham
        tl.Parent = bg
    end

    bg.Enabled = enabled
    bg.Text.Text = text or ""
end

local function lookAt(from, to)
    if not from or not to then return end
    Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, to)
end

local function getClosestPlayerToCursor(targetPart)
    local nearest = nil
    local mousePos = Vector2.new(
        Camera.ViewportSize.x / 2,
        Camera.ViewportSize.y / 2
    )

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer
           and v.Character
           and v.Character:FindFirstChild(targetPart)
           and LocalPlayer.Character
           and LocalPlayer.Character:FindFirstChild(targetPart) then

            local worldPos, onScreen = Camera:WorldToViewportPoint(
                v.Character[targetPart].Position
            )
            local screenPos = Vector2.new(worldPos.x, worldPos.y)
            local distance = (screenPos - mousePos).Magnitude

            if onScreen and distance < Circle.Radius then
                nearest = v
            end
        end
    end

    return nearest
end

game:GetService("RunService").Heartbeat:Connect(function()
    if not LocalPlayer.Character then return end

    local hue = (tick() % 5) / 5

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer
           and player.Character
           and player.Character:FindFirstChild("Humanoid")
           and player.Character:FindFirstChild("HumanoidRootPart") then

            local char = player.Character
            local nameText = Ghost["透视名字"] and player.Name or ""
            local hpText = Ghost["透视血量"]
                and ("\nHP:" .. math.floor(char.Humanoid.Health))
                or ""
            local espColor = Ghost["透视颜色"]
            if espColor == nil then
                espColor = Color3.fromHSV(hue, 1, 1)
            end

            AddESP(char, espColor, nameText .. hpText, Ghost["透视开关"])
        end
    end

    -- 圆圈颜色
    if Ghost["圆圈颜色"] ~= nil then
        Circle.Color = Ghost["圆圈颜色"]
    else
        Circle.Color = Color3.fromHSV(hue, 1, 1)
    end

    -- 自瞄
    local closest = getClosestPlayerToCursor("Head")
    if Ghost["自瞄开关"]
       and closest
       and closest.Character
       and closest.Character:FindFirstChild("Head")
       and LocalPlayer.Character
       and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then

        local hrp = LocalPlayer.Character.HumanoidRootPart
        if (hrp.Position - closest.Character.HumanoidRootPart.Position).Magnitude
           <= Ghost["自瞄距离"] then
            lookAt(Camera.CFrame.Position, closest.Character.Head.Position)
        end
    end
end)

-- ============================================================
-- ======================  简 介 Tab  =======================
-- ============================================================
do
    local tab = Tabs.intro

    local sec = tab:Section({
        Title = "VOTR Hub 简介",
        Box = true, BoxBorder = true, Opened = true,
    })
    sec:Paragraph({
        Title = "VOTR Hub",
        Desc = "欢迎使用 VOTR Hub\n持续更新\n作者：Nil团队",
        Thumbnail = "https://raw.githubusercontent.com/VOTR-SCRIPT/VOTR-TP/refs/heads/main/image_download_1780058124054.jpg",
    })

    local info = tab:Section({
        Title = "信息", Box = true, BoxBorder = true
    })
    info:Section({ Title = "脚本名称：VOTR Hub" })
    info:Section({ Title = "作者：Nil团队" })
    info:Section({ Title = "用户名：" .. LocalPlayer.Name })
    info:Section({ Title = "注入器：" .. exec })
    info:Section({ Title = "QQ群：887502203" })

    local about = tab:Section({
        Title = "关于", Box = true, BoxBorder = true
    })
    about:Section({ Title = "VOTR Hub " })
    about:Section({ Title = "作者：Nil" })
    about:Section({ Title = "用户名：" .. LocalPlayer.Name })
    about:Section({ Title = "注入器：" .. exec })
end

-- ============================================================
-- ======================  功 能 Tab  =======================
-- ============================================================
do
    local tab = Tabs.func
    local cBlue  = Color3.fromHex("#4169E1")
    local cRed   = Color3.fromHex("#ff4830")
    local cGold  = Color3.fromHex("#ECA201")
    local cPurple = Color3.fromHex("#7775F2")

    -- ==================== 子Tab：玩家 ====================
    local subPlayer = tab:Section({
        Title = "玩家", Box = true, BoxBorder = true, Opened = true
    })

    subPlayer:Slider({
        Title = "修改FPS", Step = 1,
        Value = { Min = 30, Max = 300, Default = 60 },
        Callback = function(v)
            if setfpscap then
                pcall(setfpscap, v)
            else
                warn("当前执行器不支持 setfpscap")
            end
        end
    })

    subPlayer:Slider({
        Title = "速度", Step = 1,
        Value = { Min = 16, Max = 500, Default = 16 },
        Callback = function(v)
            pcall(function()
                LocalPlayer.Character.Humanoid.WalkSpeed = v
            end)
        end
    })

    subPlayer:Slider({
        Title = "跳跃", Step = 1,
        Value = { Min = 50, Max = 500, Default = 50 },
        Callback = function(v)
            pcall(function()
                LocalPlayer.Character.Humanoid.JumpPower = v
            end)
        end
    })

    subPlayer:Slider({
        Title = "重力", Step = 1,
        Value = { Min = 0, Max = 1000, Default = 198 },
        Callback = function(v)
            workspace.Gravity = v
        end
    })

    subPlayer:Slider({
        Title = "高度", Step = 0.1,
        Value = { Min = 0.5, Max = 10, Default = 2 },
        Callback = function(v)
            pcall(function()
                LocalPlayer.Character.Humanoid.HipHeight = v
            end)
        end
    })

    subPlayer:Slider({
        Title = "相机焦距上限", Step = 1,
        Value = { Min = 128, Max = 10000, Default = 128 },
        Callback = function(v)
            LocalPlayer.CameraMaxZoomDistance = v
        end
    })

    subPlayer:Slider({
        Title = "相机焦距", Step = 1,
        Value = { Min = 30, Max = 120, Default = 70 },
        Callback = function(v)
            workspace.CurrentCamera.FieldOfView = v
        end
    })

    subPlayer:Slider({
        Title = "健康值上限", Step = 1,
        Value = { Min = 100, Max = 10000, Default = 100 },
        Callback = function(v)
            pcall(function()
                LocalPlayer.Character.Humanoid.MaxHealth = v
            end)
        end
    })

    subPlayer:Slider({
        Title = "玩家健康值", Step = 1,
        Value = { Min = 100, Max = 10000, Default = 100 },
        Callback = function(v)
            pcall(function()
                LocalPlayer.Character.Humanoid.Health = v
            end)
        end
    })

    -- 旋转功能
    subPlayer:Input({
        Title = "旋转速度",
        Desc = "输入旋转速度值",
        Placeholder = "输入速度...",
        Callback = function(value)
            local speed = tonumber(value)
            if not speed then return end

            local plr = LocalPlayer
            repeat task.wait() until plr.Character

            local humRoot = plr.Character:WaitForChild("HumanoidRootPart")
            local humanoid = plr.Character:WaitForChild("Humanoid")
            humanoid.AutoRotate = false

            local spinVelocity = humRoot:FindFirstChild("Spinbot")
            if not spinVelocity then
                spinVelocity = Instance.new("AngularVelocity")
                spinVelocity.Attachment0 = humRoot:WaitForChild("RootAttachment")
                spinVelocity.MaxTorque = math.huge
                spinVelocity.AngularVelocity = Vector3.new(0, speed, 0)
                spinVelocity.Parent = humRoot
                spinVelocity.Name = "Spinbot"
            else
                spinVelocity.AngularVelocity = Vector3.new(0, speed, 0)
            end
        end
    })

    subPlayer:Button({
        Title = "停止旋转",
        Color = cRed,
        Callback = function()
            local plr = LocalPlayer
            repeat task.wait() until plr.Character

            local humRoot = plr.Character:WaitForChild("HumanoidRootPart")
            local humanoid = plr.Character:WaitForChild("Humanoid")
            local spinbot = humRoot:FindFirstChild("Spinbot")

            if spinbot then spinbot:Destroy() end
            humanoid.AutoRotate = true
        end
    })

    -- ==================== 子Tab：战斗 ====================
    local subViol = tab:Section({
        Title = "战斗", Box = true, BoxBorder = true, Opened = true
    })

    -- 飞行
    subViol:Button({
        Title = "飞行", Color = cRed,
        Callback = function()
            local main = Instance.new("ScreenGui")
            main.Name = "VOTR"
            main.Parent = LocalPlayer:WaitForChild("PlayerGui")
            main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            main.ResetOnSpawn = false

            local Frame = Instance.new("Frame")
            Frame.Parent = main
            Frame.BackgroundColor3 = cBlue
            Frame.BorderSizePixel = 0
            Frame.Position = UDim2.new(0.1, 0, 0.38, 0)
            Frame.Size = UDim2.new(0, 190, 0, 57)
            Frame.Active = true
            Frame.Draggable = true

            local up = Instance.new("TextButton")
            up.Name = "up"
            up.Parent = Frame
            up.BackgroundColor3 = Color3.fromRGB(79, 255, 152)
            up.Size = UDim2.new(0, 44, 0, 28)
            up.Font = Enum.Font.SourceSans
            up.Text = "上"
            up.TextColor3 = Color3.fromRGB(0, 0, 0)
            up.TextSize = 25

            local down = Instance.new("TextButton")
            down.Name = "down"
            down.Parent = Frame
            down.BackgroundColor3 = Color3.fromRGB(215, 255, 121)
            down.Position = UDim2.new(0, 0, 0.49, 0)
            down.Size = UDim2.new(0, 44, 0, 28)
            down.Font = Enum.Font.SourceSans
            down.Text = "下"
            down.TextColor3 = Color3.fromRGB(0, 0, 0)
            down.TextSize = 25

            local onof = Instance.new("TextButton")
            onof.Name = "onof"
            onof.Parent = Frame
            onof.BackgroundColor3 = Color3.fromRGB(255, 249, 74)
            onof.Position = UDim2.new(0.70, 0, 0.49, 0)
            onof.Size = UDim2.new(0, 56, 0, 28)
            onof.Font = Enum.Font.SourceSans
            onof.Text = "飞行"
            onof.TextColor3 = Color3.fromRGB(0, 0, 0)
            onof.TextSize = 25

            local TextLabel = Instance.new("TextLabel")
            TextLabel.Parent = Frame
            TextLabel.BackgroundColor3 = cBlue
            TextLabel.Position = UDim2.new(0.47, 0, 0, 0)
            TextLabel.Size = UDim2.new(0, 100, 0, 28)
            TextLabel.Font = Enum.Font.SourceSans
            TextLabel.Text = "VOTR飞行"
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.TextScaled = true
            TextLabel.TextSize = 10
            TextLabel.TextWrapped = true

            local plus = Instance.new("TextButton")
            plus.Name = "plus"
            plus.Parent = Frame
            plus.BackgroundColor3 = Color3.fromRGB(133, 145, 255)
            plus.Position = UDim2.new(0.23, 0, 0, 0)
            plus.Size = UDim2.new(0, 45, 0, 28)
            plus.Font = Enum.Font.SourceSans
            plus.Text = "加速"
            plus.TextColor3 = Color3.fromRGB(0, 0, 0)
            plus.TextScaled = true
            plus.TextSize = 9
            plus.TextWrapped = true

            local speedLabel = Instance.new("TextLabel")
            speedLabel.Name = "speed"
            speedLabel.Parent = Frame
            speedLabel.BackgroundColor3 = cBlue
            speedLabel.Position = UDim2.new(0.47, 0, 0.49, 0)
            speedLabel.Size = UDim2.new(0, 44, 0, 28)
            speedLabel.Font = Enum.Font.SourceSans
            speedLabel.Text = "1"
            speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            speedLabel.TextScaled = true
            speedLabel.TextSize = 15
            speedLabel.TextWrapped = true

            local mine = Instance.new("TextButton")
            mine.Name = "mine"
            mine.Parent = Frame
            mine.BackgroundColor3 = Color3.fromRGB(123, 200, 255)
            mine.Position = UDim2.new(0.23, 0, 0.49, 0)
            mine.Size = UDim2.new(0, 45, 0, 29)
            mine.Font = Enum.Font.SourceSans
            mine.Text = "减速"
            mine.TextColor3 = Color3.fromRGB(0, 0, 0)
            mine.TextScaled = true
            mine.TextSize = 9
            mine.TextWrapped = true

            local closebutton = Instance.new("TextButton")
            closebutton.Name = "Close"
            closebutton.Parent = Frame
            closebutton.BackgroundColor3 = Color3.fromRGB(225, 25, 0)
            closebutton.Font = "SourceSans"
            closebutton.Size = UDim2.new(0, 45, 0, 28)
            closebutton.Text = "关闭"
            closebutton.TextSize = 25
            closebutton.Position = UDim2.new(0, 0, -1, 27)

            local mini = Instance.new("TextButton")
            mini.Name = "minimize"
            mini.Parent = Frame
            mini.BackgroundColor3 = cBlue
            mini.Font = "SourceSans"
            mini.Size = UDim2.new(0, 45, 0, 28)
            mini.Text = "隐藏"
            mini.TextSize = 25
            mini.Position = UDim2.new(0, 44, -1, 27)

            local mini2 = Instance.new("TextButton")
            mini2.Name = "minimize2"
            mini2.Parent = Frame
            mini2.BackgroundColor3 = cBlue
            mini2.Font = "SourceSans"
            mini2.Size = UDim2.new(0, 45, 0, 28)
            mini2.Text = "展开"
            mini2.TextSize = 25
            mini2.Position = UDim2.new(0, 44, -1, 57)
            mini2.Visible = false

            local speeds = 1
            local nowe = false

            onof.MouseButton1Down:Connect(function()
                if nowe then
                    -- 关闭飞行
                    nowe = false
                    local hum = LocalPlayer.Character.Humanoid
                    hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
                    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
                    hum:SetStateEnabled(Enum.HumanoidStateType.Flying, true)
                    hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
                    hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
                    hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
                    hum:SetStateEnabled(Enum.HumanoidStateType.Landed, true)
                    hum:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
                    hum:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, true)
                    hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
                    hum:SetStateEnabled(Enum.HumanoidStateType.Running, true)
                    hum:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true)
                    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                    hum:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
                    hum:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
                else
                    -- 开启飞行
                    nowe = true

                    for i = 1, speeds do
                        spawn(function()
                            local hb = game:GetService("RunService").Heartbeat
                            local tpwalking = true
                            local ch = LocalPlayer.Character
                            local hu = ch and ch:FindFirstChildWhichIsA("Humanoid")
                            while tpwalking and hb:Wait() and ch and hu and hu.Parent do
                                if hu.MoveDirection.Magnitude > 0 then
                                    ch:TranslateBy(hu.MoveDirection)
                                end
                            end
                        end)
                    end

                    LocalPlayer.Character.Animate.Disabled = true
                    local Hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                             or LocalPlayer.Character:FindFirstChildOfClass("AnimationController")
                    for _, v in next, Hum:GetPlayingAnimationTracks() do
                        v:AdjustSpeed(0)
                    end

                    for _, state in ipairs({
                        "Climbing", "FallingDown", "Flying", "Freefall",
                        "GettingUp", "Jumping", "Landed", "Physics",
                        "PlatformStanding", "Ragdoll", "Running",
                        "RunningNoPhysics", "Seated", "StrafingNoPhysics", "Swimming"
                    }) do
                        pcall(function()
                            LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType[state], false)
                        end)
                    end

                    LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)

                    local rigType = LocalPlayer.Character.Humanoid.RigType
                    local torso = (rigType == Enum.HumanoidRigType.R6)
                        and LocalPlayer.Character.Torso
                        or LocalPlayer.Character.UpperTorso

                    local ctrl = { f = 0, b = 0, l = 0, r = 0 }
                    local lastctrl = { f = 0, b = 0, l = 0, r = 0 }
                    local maxspeed = 50
                    local speed = 0

                    local bg = Instance.new("BodyGyro", torso)
                    bg.P = 9e4
                    bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                    bg.cframe = torso.CFrame

                    local bv = Instance.new("BodyVelocity", torso)
                    bv.velocity = Vector3.new(0, 0.1, 0)
                    bv.maxForce = Vector3.new(9e9, 9e9, 9e9)

                    LocalPlayer.Character.Humanoid.PlatformStand = true

                    task.spawn(function()
                        while nowe do
                            task.wait()
                            if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                                speed = math.min(speed + 0.5 + speed / maxspeed, maxspeed)
                            elseif speed ~= 0 then
                                speed = math.max(speed - 1, 0)
                            end

                            if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                                bv.velocity = (
                                    (Camera.CoordinateFrame.lookVector * (ctrl.f + ctrl.b))
                                  + ((Camera.CoordinateFrame * CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * 0.2, 0).p)
                                   - Camera.CoordinateFrame.p)
                                ) * speed
                                lastctrl = { f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r }
                            elseif speed ~= 0 then
                                bv.velocity = (
                                    (Camera.CoordinateFrame.lookVector * (lastctrl.f + lastctrl.b))
                                  + ((Camera.CoordinateFrame * CFrame.new(lastctrl.l + lastctrl.r, (lastctrl.f + lastctrl.b) * 0.2, 0).p)
                                   - Camera.CoordinateFrame.p)
                                ) * speed
                            else
                                bv.velocity = Vector3.new(0, 0, 0)
                            end

                            bg.cframe = Camera.CoordinateFrame
                                * CFrame.Angles(-math.rad((ctrl.f + ctrl.b) * 50 * speed / maxspeed), 0, 0)
                        end

                        ctrl = { f = 0, b = 0, l = 0, r = 0 }
                        lastctrl = { f = 0, b = 0, l = 0, r = 0 }
                        speed = 0
                        bg:Destroy()
                        bv:Destroy()
                        LocalPlayer.Character.Humanoid.PlatformStand = false
                        LocalPlayer.Character.Animate.Disabled = false
                    end)

                    local UIS2 = game:GetService("UserInputService")
                    local conn1 = UIS2.InputBegan:Connect(function(i)
                        if i.KeyCode == Enum.KeyCode.W then ctrl.f = 1 end
                        if i.KeyCode == Enum.KeyCode.S then ctrl.b = -1 end
                        if i.KeyCode == Enum.KeyCode.A then ctrl.l = -1 end
                        if i.KeyCode == Enum.KeyCode.D then ctrl.r = 1 end
                    end)
                    local conn2 = UIS2.InputEnded:Connect(function(i)
                        if i.KeyCode == Enum.KeyCode.W then ctrl.f = 0 end
                        if i.KeyCode == Enum.KeyCode.S then ctrl.b = 0 end
                        if i.KeyCode == Enum.KeyCode.A then ctrl.l = 0 end
                        if i.KeyCode == Enum.KeyCode.D then ctrl.r = 0 end
                    end)

                    LocalPlayer.CharacterAdded:Connect(function()
                        pcall(function()
                            conn1:Disconnect()
                            conn2:Disconnect()
                        end)
                    end)
                end
            end)

            local function makeHold(btn, dir)
                local conn
                btn.MouseButton1Down:Connect(function()
                    conn = btn.MouseEnter:Connect(function()
                        while conn do
                            task.wait()
                            pcall(function()
                                LocalPlayer.Character.HumanoidRootPart.CFrame =
                                    LocalPlayer.Character.HumanoidRootPart.CFrame
                                  * CFrame.new(dir.x, dir.y, dir.z)
                            end)
                        end
                    end)
                end)
                btn.MouseLeave:Connect(function()
                    if conn then
                        conn:Disconnect()
                        conn = nil
                    end
                end)
            end

            makeHold(up, Vector3.new(0, 1, 0))
            makeHold(down, Vector3.new(0, -1, 0))

            LocalPlayer.CharacterAdded:Connect(function(char)
                task.wait(0.7)
                pcall(function()
                    LocalPlayer.Character.Humanoid.PlatformStand = false
                    LocalPlayer.Character.Animate.Disabled = false
                end)
            end)

            plus.MouseButton1Down:Connect(function()
                speeds = speeds + 1
                speedLabel.Text = speeds
            end)

            mine.MouseButton1Down:Connect(function()
                if speeds > 1 then
                    speeds = speeds - 1
                    speedLabel.Text = speeds
                else
                    speedLabel.Text = "min=1"
                    task.wait(1)
                    speedLabel.Text = speeds
                end
            end)

            closebutton.MouseButton1Click:Connect(function()
                main:Destroy()
            end)

            mini.MouseButton1Click:Connect(function()
                up.Visible = false
                down.Visible = false
                onof.Visible = false
                plus.Visible = false
                speedLabel.Visible = false
                mine.Visible = false
                mini.Visible = false
                mini2.Visible = true
                Frame.BackgroundTransparency = 1
                closebutton.Position = UDim2.new(0, 0, -1, 57)
            end)

            mini2.MouseButton1Click:Connect(function()
                up.Visible = true
                down.Visible = true
                onof.Visible = true
                plus.Visible = true
                speedLabel.Visible = true
                mine.Visible = true
                mini.Visible = true
                mini2.Visible = false
                Frame.BackgroundTransparency = 0
                closebutton.Position = UDim2.new(0, 0, -1, 27)
            end)
        end
    })

    -- 飞车
    subViol:Button({
        Title = "飞车", Color = cRed,
        Callback = function()
            local Flymguiv2 = Instance.new("ScreenGui")
            Flymguiv2.Name = "Flymguiv2"
            Flymguiv2.Parent = game.CoreGui
            Flymguiv2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

            local Drag = Instance.new("Frame")
            Drag.Name = "Drag"
            Drag.Parent = Flymguiv2
            Drag.Active = true
            Drag.BackgroundColor3 = cBlue
            Drag.BorderSizePixel = 0
            Drag.Draggable = true
            Drag.Position = UDim2.new(0.48, 0, 0.45, 0)
            Drag.Size = UDim2.new(0, 237, 0, 27)

            local FlyFrame = Instance.new("Frame")
            FlyFrame.Name = "FlyFrame"
            FlyFrame.Parent = Drag
            FlyFrame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            FlyFrame.BorderSizePixel = 0
            FlyFrame.Position = UDim2.new(-0.002, 0, 0.989, 0)
            FlyFrame.Size = UDim2.new(0, 237, 0, 139)

            local Speed = Instance.new("TextBox")
            Speed.Name = "速度"
            Speed.Parent = FlyFrame
            Speed.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
            Speed.BorderSizePixel = 0
            Speed.Position = UDim2.new(0.445, 0, 0.403, 0)
            Speed.Size = UDim2.new(0, 111, 0, 33)
            Speed.Font = Enum.Font.SourceSans
            Speed.Text = "50"
            Speed.TextColor3 = Color3.fromRGB(255, 255, 255)
            Speed.TextScaled = true
            Speed.TextSize = 14

            local Fly = Instance.new("TextButton")
            Fly.Name = "Fly"
            Fly.Parent = FlyFrame
            Fly.BackgroundColor3 = cBlue
            Fly.BorderSizePixel = 0
            Fly.Position = UDim2.new(0.076, 0, 0.706, 0)
            Fly.Size = UDim2.new(0, 199, 0, 32)
            Fly.Font = Enum.Font.SourceSans
            Fly.Text = "开飞"
            Fly.TextColor3 = Color3.fromRGB(255, 255, 255)
            Fly.TextScaled = true
            Fly.TextSize = 14

            local Speeed = Instance.new("TextLabel")
            Speeed.Name = "Speeed"
            Speeed.Parent = FlyFrame
            Speeed.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            Speeed.BorderSizePixel = 0
            Speeed.Position = UDim2.new(0.076, 0, 0.403, 0)
            Speeed.Size = UDim2.new(0, 87, 0, 32)
            Speeed.Font = Enum.Font.SourceSans
            Speeed.Text = "速度:"
            Speeed.TextColor3 = Color3.fromRGB(255, 255, 255)
            Speeed.TextScaled = true
            Speeed.TextSize = 14

            local Stat = Instance.new("TextLabel")
            Stat.Name = "Stat"
            Stat.Parent = FlyFrame
            Stat.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            Stat.BorderSizePixel = 0
            Stat.Position = UDim2.new(0.3, 0, 0.24, 0)
            Stat.Size = UDim2.new(0, 85, 0, 15)
            Stat.Font = Enum.Font.SourceSans
            Stat.Text = "状态:"
            Stat.TextColor3 = Color3.fromRGB(255, 255, 255)
            Stat.TextScaled = true
            Stat.TextSize = 14

            local Stat2 = Instance.new("TextLabel")
            Stat2.Name = "Stat2"
            Stat2.Parent = FlyFrame
            Stat2.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            Stat2.BorderSizePixel = 0
            Stat2.Position = UDim2.new(0.547, 0, 0.24, 0)
            Stat2.Size = UDim2.new(0, 27, 0, 15)
            Stat2.Font = Enum.Font.SourceSans
            Stat2.Text = "关闭"
            Stat2.TextColor3 = Color3.fromRGB(255, 0, 0)
            Stat2.TextScaled = true
            Stat2.TextSize = 14

            local Unfly = Instance.new("TextButton")
            Unfly.Name = "Unfly"
            Unfly.Parent = FlyFrame
            Unfly.BackgroundColor3 = cBlue
            Unfly.BorderSizePixel = 0
            Unfly.Position = UDim2.new(0.076, 0, 0.706, 0)
            Unfly.Size = UDim2.new(0, 199, 0, 32)
            Unfly.Visible = false
            Unfly.Font = Enum.Font.SourceSans
            Unfly.Text = "降落"
            Unfly.TextColor3 = Color3.fromRGB(255, 255, 255)
            Unfly.TextScaled = true
            Unfly.TextSize = 14

            local Close = Instance.new("TextButton")
            Close.Name = "Close"
            Close.Parent = Drag
            Close.BackgroundColor3 = Color3.fromHex("#ff4830")
            Close.BorderSizePixel = 0
            Close.Position = UDim2.new(0.875, 0, 0, 0)
            Close.Size = UDim2.new(0, 27, 0, 27)
            Close.Font = Enum.Font.SourceSans
            Close.Text = "X"
            Close.TextColor3 = Color3.fromRGB(255, 255, 255)
            Close.TextScaled = true
            Close.TextSize = 14

            local Minimize = Instance.new("TextButton")
            Minimize.Name = "Minimize"
            Minimize.Parent = Drag
            Minimize.BackgroundColor3 = cBlue
            Minimize.BorderSizePixel = 0
            Minimize.Position = UDim2.new(0.75, 0, 0, 0)
            Minimize.Size = UDim2.new(0, 27, 0, 27)
            Minimize.Font = Enum.Font.SourceSans
            Minimize.Text = "-"
            Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
            Minimize.TextScaled = true
            Minimize.TextSize = 14

            Fly.MouseButton1Click:Connect(function()
                local HRP = LocalPlayer.Character.HumanoidRootPart
                Fly.Visible = false
                Stat2.Text = "开启"
                Stat2.TextColor3 = Color3.fromRGB(0, 255, 0)
                Unfly.Visible = true

                local BV = Instance.new("BodyVelocity", HRP)
                local BG = Instance.new("BodyGyro", HRP)
                BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

                game:GetService("RunService").RenderStepped:Connect(function()
                    pcall(function()
                        BG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                        BG.D = 5000
                        BG.P = 100000
                        BG.CFrame = Camera.CFrame
                        BV.Velocity = Camera.CFrame.LookVector * tonumber(Speed.Text or 50)
                    end)
                end)
            end)

            Unfly.MouseButton1Click:Connect(function()
                Fly.Visible = true
                Stat2.Text = "关闭"
                Stat2.TextColor3 = Color3.fromRGB(255, 0, 0)
                Unfly.Visible = false
                task.wait()
                pcall(function()
                    LocalPlayer.Character.HumanoidRootPart:FindFirstChildOfClass("BodyVelocity"):Destroy()
                    LocalPlayer.Character.HumanoidRootPart:FindFirstChildOfClass("BodyGyro"):Destroy()
                end)
            end)

            Close.MouseButton1Click:Connect(function()
                Flymguiv2:Destroy()
            end)

            Minimize.MouseButton1Click:Connect(function()
                if Minimize.Text == "-" then
                    Minimize.Text = "+"
                    FlyFrame.Visible = false
                else
                    Minimize.Text = "-"
                    FlyFrame.Visible = true
                end
            end)
        end
    })

    subViol:Toggle({
        Title = "夜视",
        Callback = function(v)
            game.Lighting.Ambient = v and Color3.new(1, 1, 1) or Color3.new(0, 0, 0)
        end
    })

    subViol:Toggle({
        Title = "无限跳",
        Callback = function(v)
            if v then
                game:GetService("UserInputService").JumpRequest:Connect(function()
                    pcall(function()
                        LocalPlayer.Character.Humanoid:ChangeState("Jumping")
                    end)
                end)
            end
        end
    })

    subViol:Button({ Title = "爬墙", Callback = function()
        safeLoad("https://pastebin.com/raw/zXk4Rq2r", "爬墙")
    end })

    subViol:Button({ Title = "铁拳", Callback = function()
        safeLoad("https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt", "铁拳")
    end })

    subViol:Button({ Title = "电脑键盘", Callback = function()
        safeLoad("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", "键盘")
    end })

    -- 范围自瞄
    subViol:Section({ Title = "---- 范围自瞄/子追 ----" })

    local aimbotList = {
        { "普通范围",       "https://pastebin.com/raw/jiNwDbCN" },
        { "全图范围",       "https://pastebin.com/raw/KKY9EpZU" },
        { "终极范围",       "https://pastebin.com/raw/CAQ9x4A7" },
        { "阿尔宙斯自瞄",   "https://raw.githubusercontent.com/AZYsGithub/chillz-workshop/main/Arceus%20Aimbot.lua" },
        { "自瞄50",         "https://pastefy.app/b3uXjRF6/raw" },
        { "自瞄100",        "https://pastefy.app/tQrd2r0L/raw" },
        { "自瞄150",        "https://pastefy.app/UOQWFvGp/raw" },
        { "自瞄200",        "https://pastefy.app/b5CuDuer/raw" },
        { "自瞄250",        "https://pastefy.app/nIyVhrvV/raw" },
        { "自瞄300",        "https://pastefy.app/LQuP7sjj/raw" },
        { "自瞄400",        "https://pastefy.app/WmcEe2HB/raw" },
        { "自瞄600",        "https://pastefy.app/n5LhGGgf/raw" },
        { "自瞄全屏",       "https://pastefy.app/n5LhGGgf/raw" },
    }

    for _, info in ipairs(aimbotList) do
        subViol:Button({
            Title = info[1],
            Callback = function()
                safeLoad(info[2], info[1])
            end
        })
    end

    subViol:Button({
        Title = "超级强大自瞄",
        Callback = function()
            local RunService = game:GetService("RunService")
            RunService.Heartbeat:Connect(function()
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                local nearest, minDist = nil, 1500
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer
                       and plr.Character
                       and plr.Character:FindFirstChild("Head")
                       and plr.Character:FindFirstChild("Humanoid")
                       and plr.Character.Humanoid.Health > 0 then

                        local dist = (plr.Character.Head.Position - hrp.Position).Magnitude
                        if dist < minDist then
                            minDist = dist
                            nearest = plr.Character.Head
                        end
                    end
                end
            end)
        end
    })
    
    subViol:Toggle({
    Title = "子弹追逐",
    Callback = function(enabled)
      local camera = nil
      local Players = nil
      local localPlayer = nil
      local originalNamecall = nil
      local originalIndex = nil
  
      if enabled then
        camera = workspace.CurrentCamera
        Players = game.Players
        localPlayer = Players.LocalPlayer
        local mouse = localPlayer:GetMouse()
    
        function ClosestPlayer()
          local closestDistance = math.huge
          local closestPlayer = nil
          
          for _, player in pairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Team ~= localPlayer.Team and player.Character then
              local head = player.Character:FindFirstChild("Head")
              if head then
                local screenPoint, isVisible = camera:WorldToScreenPoint(head.Position)
                if isVisible then
                  local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - 
                               Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, 
                                              workspace.CurrentCamera.ViewportSize.Y / 2)).Magnitude
                  if distance < closestDistance then
                    closestDistance = distance
                    closestPlayer = player
                  end
                end
              end
            end
          end
          return closestPlayer
        end
    
        local metatable = getrawmetatable(game)
        originalNamecall = metatable.__namecall
        originalIndex = metatable.__index
        setreadonly(metatable, false)
        
        metatable.__namecall = newcclosure(function(self, ...)
          local args = {...}
          
          if getnamecallmethod() == "FindPartOnRayWithIgnoreList" and not checkcaller() then
            local targetPlayer = ClosestPlayer()
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
          args[1] = Ray.new(camera.CFrame.Position, 
                           ((targetPlayer.Character.Head.Position - camera.CFrame.Position)).Unit * 1000)
          return originalNamecall(self, unpack(args))
        end
      end
      return originalNamecall(self, ...)
    end)
    
    metatable.__index = newcclosure(function(self, key)
      if key == "Clips" then
        return workspace.Map
      end
      return originalIndex(self, key)
    end)
    
    setreadonly(metatable, true)
    
  else
    local metatable = getrawmetatable(game)
    setreadonly(metatable, false)
    metatable.__namecall = originalNamecall
    metatable.__index = originalIndex
    setreadonly(metatable, true)
  end
end
})

    -- ==================== 子Tab：脚本 ====================
    local subFarm = tab:Section({
        Title = "脚本", Box = true, BoxBorder = true, Opened = true
    })

    subFarm:Section({ Title = "---- 热门脚本 ----" })

    subFarm:Button({ Title = "神秘黑客脚本 v6", Callback = function()
        safeLoad("https://raw.githubusercontent.com/iK4oS/backdoor.exe/v6x/source.lua", "神秘黑客v6")
    end })

    subFarm:Button({ Title = "冷脚本", Callback = function()
        getgenv().Leng = "冷脚本QQ群815883059"
        safeLoad("https://raw.githubusercontent.com/odhdshhe/lenglenglenglenglenglenglenglenglengleng-cold-script-LBT-H/refs/heads/main/-cold-script-LBT-H.txt", "冷脚本")
    end })

    subFarm:Button({ Title = "星河脚本", Callback = function()
        safeLoad("https://raw.githubusercontent.com/AWDX-DYVB/test/main/%E6%B2%B3%E6%B5%81%E6%97%A0%E5%AF%86%E9%92%A5.lua", "星河")
    end })

    subFarm:Button({ Title = "XA HUB", Callback = function()
        safeLoad("https://pastebin.com/raw/h8nC0fLb", "XA HUB")
    end })

    subFarm:Button({ Title = "落叶中星", Callback = function()
        getgenv().LS = "落叶中心.Cocoe"
        safeLoad("https://raw.githubusercontent.com/krlpl/Deciduous-center-LS/main/%E8%90%BD%E5%8F%B6%E4%B8%AD%E5%BF%83%E6%B7%B7%E6%B7%86.txt", "落叶中星")
    end })

    subFarm:Button({ Title = "小灵脚本", Callback = function()
        pcall(function()
            loadstring(game:HttpGet(
                "https://raw.githubusercontent.com/flyspeed7/Xiao-Ling-NEO.UI/main/%E2%82%AA%E5%B0%8F%E5%87%8C%E4%B8%AD%E5%BF%83(%E6%96%B0%E7%89%88ui).txt"
            ))("小凌中心")("作者QQ:1211373508")
        end)
    end })

    subFarm:Section({ Title = "---- 游戏工具 ----" })

    subFarm:Button({ Title = "神秘穿墙", Callback = function()
        pcall(function()
            for _, v in pairs(LocalPlayer.Character:GetChildren()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end)
    end })

    subFarm:Button({ Title = "点击传送工具", Callback = function()
        local mouse = LocalPlayer:GetMouse()
        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "Click TP"
        tool.Activated:Connect(function()
            local pos = mouse.Hit.p + Vector3.new(0, 2.5, 0)
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
        end)
        tool.Parent = LocalPlayer.Backpack
    end })

    subFarm:Button({ Title = "位置坐标", Callback = function()
        if LocalPlayer.Character then
            local pos = LocalPlayer.Character.HumanoidRootPart.Position
            setclipboard(string.format(
                "X: %.2f, Y: %.2f, Z: %.2f", pos.X, pos.Y, pos.Z
            ))
        end
    end })

    subFarm:Section({ Title = "---- 更多脚本 ----" })

    subFarm:Button({ Title = "绕过管理员检测", Callback = function()
        safeLoad("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua", "绕过管理")
    end })

    subFarm:Button({ Title = "防止甩飞", Callback = function()
        safeLoad("https://raw.githubusercontent.com/protezzx/Player-joined-left/refs/heads/main/Antifling%20script", "防甩飞")
    end })

    subFarm:Button({ Title = "回溯脚本", Callback = function()
        safeLoad("https://raw.githubusercontent.com/MSTTOPPER/Scripts/refs/heads/main/FlashBack", "回溯")
    end })

    subFarm:Button({ Title = "无头加断腿", Callback = function()
        safeLoad("https://rawscripts.net/raw/Universal-Script-Permanent-Headless-And-korblox-Script-4140", "无头断腿")
    end })

    subFarm:Button({ Title = "增加FPS", Callback = function()
        safeLoad("https://raw.githubusercontent.com/smalldesikon/hun/ee906e570c0f5b22e580a20decaba23757533569/fps", "增加FPS")
    end })

    subFarm:Button({ Title = "透视NPC", Callback = function()
        local RunService = game:GetService("RunService")
        local NPCESPTable = {}

        local function IsNPC(model)
            if not model:IsA("Model") then return false end
            local hum = model:FindFirstChildOfClass("Humanoid")
            if not hum then return false end
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character == model then return false end
            end
            return hum.Health > 0
        end

        local function CreateNPCESP(npc)
            if NPCESPTable[npc] then return end
            local hl = Instance.new("Highlight")
            hl.Name = "NPCESP_Highlight"
            hl.FillColor = Color3.new(0.5, 0, 0.5)
            hl.FillTransparency = 0.7
            hl.OutlineColor = Color3.new(1, 1, 1)
            hl.OutlineTransparency = 0
            hl.Adornee = npc
            hl.Parent = npc
            NPCESPTable[npc] = hl
        end

        for _, d in pairs(workspace:GetDescendants()) do
            if IsNPC(d) then CreateNPCESP(d) end
        end

        RunService.Heartbeat:Connect(function()
            for _, d in pairs(workspace:GetDescendants()) do
                if IsNPC(d) and not NPCESPTable[d] then
                    CreateNPCESP(d)
                end
            end
        end)
    end })

    subFarm:Button({ Title = "西格玛Spy", Callback = function()
        safeLoad("https://raw.githubusercontent.com/depthso/Sigma-Spy/refs/heads/main/Main.lua", "SigmaSpy")
    end })

    subFarm:Button({ Title = "双环黑洞", Callback = function()
        safeLoad("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E5%8F%8C%E7%8E%AF%E6%8E%A7%E5%88%B6%E9%BB%91%E6%B4%9E.txt", "双环黑洞")
    end })

    subFarm:Button({ Title = "哥特风黑洞", Callback = function()
        safeLoad("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E5%93%A5%E7%89%B9%E9%A3%8E%E9%BB%91%E6%B4%9E.txt", "哥特风黑洞")
    end })

    subFarm:Button({ Title = "旋转脚本", Callback = function()
        safeLoad("https://pastebin.com/raw/r97d7dS0", "旋转")
    end })

    -- ==================== 子Tab：传送 ====================
    local subTrans = tab:Section({
        Title = "传送", Box = true, BoxBorder = true, Opened = true
    })

    subTrans:Section({ Title = "---- 加入其他游戏 ----" })

    local games = {
        { "极速传奇",     3101667897 },
        { "鲨口生求2",   8908228901 },
        { "监狱人生",     155615604 },
        { "忍者传奇",     3956818381 },
        { "Break in",     1318971886 },
        { "自然灾害生存", 189707 },
        { "力量传奇",     3623096087 },
        { "餐厅大亨2",   3398014311 },
    }

    for _, g in ipairs(games) do
        subTrans:Button({
            Title = "加入 " .. g[1],
            Callback = function()
                pcall(function()
                    game:GetService("TeleportService"):Teleport(g[2], LocalPlayer)
                end)
            end
        })
    end

    subTrans:Section({ Title = "---- 位置传送 ----" })

    subTrans:Button({
        Title = "传送到出生点",
        Callback = function()
            pcall(function()
                if LocalPlayer.Character then
                    local spawn = workspace:FindFirstChild("SpawnLocation")
                                or LocalPlayer.Character.HumanoidRootPart
                    if spawn then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = spawn.CFrame
                    end
                end
            end)
        end
    })

    -- ==================== 子Tab：透视 ====================
    local subEsp = tab:Section({
        Title = "透视", Box = true, BoxBorder = true, Opened = true
    })

    subEsp:Section({ Title = "可能有bug，请理解" })

    subEsp:Toggle({
        Title = "开启透视",
        Callback = function(v) Ghost["透视开关"] = v end
    })

    subEsp:Dropdown({
        Title = "透视颜色",
        Values = { "红", "橙", "黄", "绿", "青", "蓝", "紫", "彩色" },
        Callback = function(v) Ghost["透视颜色"] = Colors[v] end
    })

    subEsp:Toggle({
        Title = "透视名字",
        Callback = function(v) Ghost["透视名字"] = v end
    })

    subEsp:Toggle({
        Title = "透视血量",
        Callback = function(v) Ghost["透视血量"] = v end
    })

    subEsp:Section({ Title = "---- 自瞄设置 ----" })

    subEsp:Toggle({
        Title = "自瞄开关",
        Callback = function(v) Ghost["自瞄开关"] = v end
    })

    subEsp:Toggle({
        Title = "圆圈开关",
        Callback = function(v) Circle.Visible = v end
    })

    subEsp:Dropdown({
        Title = "圆圈颜色",
        Values = { "红", "橙", "黄", "绿", "青", "蓝", "紫", "彩色" },
        Callback = function(v) Ghost["圆圈颜色"] = Colors[v] end
    })

    subEsp:Slider({
        Title = "圆圈大小", Step = 1,
        Value = { Min = 0, Max = 150, Default = 100 },
        Callback = function(v) Circle.Radius = v end
    })

    subEsp:Slider({
        Title = "圆圈厚度", Step = 1,
        Value = { Min = 0, Max = 15, Default = 1 },
        Callback = function(v) Circle.Thickness = v end
    })

    subEsp:Slider({
        Title = "自瞄距离", Step = 1,
        Value = { Min = 0, Max = 800, Default = 200 },
        Callback = function(v) Ghost["自瞄距离"] = v end
    })

    -- ==================== 子Tab：光影 ====================
    local subGfx = tab:Section({
        Title = "光影", Box = true, BoxBorder = true, Opened = true
    })

    local gUrl = "https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"

    subGfx:Button({ Title = "光影",       Color = cGold, Callback = function() safeLoad(gUrl, "光影") end })
    subGfx:Button({ Title = "光影滤镜",   Color = cGold, Callback = function() safeLoad(gUrl, "光影滤镜") end })
    subGfx:Button({ Title = "光影V4",     Color = cGold, Callback = function() safeLoad(gUrl, "光影V4") end })
    subGfx:Button({ Title = "RTX高仿",    Color = cGold, Callback = function() safeLoad("https://pastebin.com/raw/Bkf0BJb3", "RTX") end })
    subGfx:Button({ Title = "光影深",     Color = cGold, Callback = function() safeLoad(gUrl, "光影深") end })
    subGfx:Button({ Title = "光影浅",     Color = cGold, Callback = function() safeLoad("https://pastebin.com/raw/jHBfJYmS", "光影浅") end })

    -- ==================== 子Tab：工具 ====================
    local subTool = tab:Section({
        Title = "工具", Box = true, BoxBorder = true, Opened = true
    })

    subTool:Button({ Title = "lY指令", Callback = function()
        safeLoad("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", "lY指令")
    end })

    subTool:Button({ Title = "Dex抓包工具", Callback = function()
        safeLoad("https://raw.githubusercontent.com/XiaoFenHG/Dex-Explorer/refs/heads/main/Dex-Explorer.lua", "Dex")
    end })

    subTool:Button({ Title = "Spy调试工具", Callback = function()
        getgenv().Spy = "汉化Spy"
        safeLoad("https://raw.githubusercontent.com/xiaopi77/xiaopi77/refs/heads/main/spy%E6%B1%89%E5%8C%96%20(1).txt", "Spy")
    end })

    subTool:Button({ Title = "位置仪", Callback = function()
        local SG = Instance.new("ScreenGui")
        SG.Parent = game.CoreGui
        SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        local F = Instance.new("Frame")
        F.Parent = SG
        F.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
        F.BorderSizePixel = 0
        F.Position = UDim2.new(0.64, 0, 0.4, 0)
        F.Size = UDim2.new(0, 387, 0, 206)
        F.Active = true

        local title = Instance.new("TextLabel")
        title.Parent = F
        title.BackgroundColor3 = cBlue
        title.BorderSizePixel = 0
        title.Size = UDim2.new(0, 387, 0, 50)
        title.Font = Enum.Font.GothamBold
        title.Text = "位置仪"
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextSize = 30

        local copy = Instance.new("TextButton")
        copy.Parent = F
        copy.BackgroundColor3 = cBlue
        copy.BorderSizePixel = 0
        copy.Position = UDim2.new(0.527, 0, 0.636, 0)
        copy.Size = UDim2.new(0, 148, 0, 50)
        copy.Font = Enum.Font.GothamSemibold
        copy.Text = "复制"
        copy.TextColor3 = Color3.fromRGB(255, 255, 255)
        copy.TextSize = 20

        local pos = Instance.new("TextBox")
        pos.Parent = F
        pos.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        pos.BorderSizePixel = 0
        pos.Position = UDim2.new(0.09, 0, 0.306, 0)
        pos.Size = UDim2.new(0, 317, 0, 50)
        pos.Font = Enum.Font.GothamSemibold
        pos.Text = ""
        pos.TextColor3 = Color3.fromRGB(255, 255, 255)
        pos.TextSize = 14

        local find = Instance.new("TextButton")
        find.Parent = F
        find.BackgroundColor3 = cBlue
        find.BorderSizePixel = 0
        find.Position = UDim2.new(0.09, 0, 0.636, 0)
        find.Size = UDim2.new(0, 148, 0, 50)
        find.Font = Enum.Font.GothamSemibold
        find.Text = "查找当前位置"
        find.TextColor3 = Color3.fromRGB(255, 255, 255)
        find.TextSize = 20

        copy.MouseButton1Click:Connect(function()
            setclipboard(pos.Text)
        end)

        find.MouseButton1Down:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart then
                pos.Text = tostring(LocalPlayer.Character.HumanoidRootPart.Position)
            end
        end)
    end })
end

do
    local tab = Tabs.MeiH
    
    local particle_auras = {
        ["天使"] = "rbxassetid://97658130917593",
        ["星光"] = "rbxassetid://134645216613107",
        ["天堂"] = "rbxassetid://139300897520961",
        ["丝带"] = "rbxassetid://132069507632161",
        ["樱花"] = "rbxassetid://81755778619404",
        ["风"] = "rbxassetid://80694081850877",
        ["流"] = "rbxassetid://119913533725648",
        ["星"] = "rbxassetid://73754563740680",
    }
    
    local currentParticleStyle = "天使"
    local particles = {}
    local particleEnabled = false
    local particleAuraInstance = nil
    
    local function loadParticleModel(styleName)
        local id = particle_auras[styleName]
        if not id then return nil end
        local success, model = pcall(function()
            return game:GetObjects(id)[1]
        end)
        return success and model or nil
    end
    
    local function clearParticles()
        for i = 1, #particles do
            pcall(function() particles[i]:Destroy() end)
            particles[i] = nil
        end
        particles = {}
        if particleAuraInstance then
            pcall(function() particleAuraInstance:Destroy() end)
            particleAuraInstance = nil
        end
    end
    
    local function applyParticleAura()
        clearParticles()
        if not particleEnabled then return end
        
        local char = player.Character
        if not char then return end
        
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        local model = loadParticleModel(currentParticleStyle)
        if not model then return end
        
        particleAuraInstance = model
        local children = model:GetChildren()
        
        for i = 1, #children do
            local part = children[i]
            local local_part = char:FindFirstChild(part.Name)
            
            if local_part then
                local partChildren = part:GetChildren()
                for j = 1, #partChildren do
                    local child = partChildren[j]
                    child.Name = "\0\0"
                    child.Parent = local_part
                    particles[#particles + 1] = child
                end
            else
                part:Destroy()
            end
        end
        
        model:Destroy()
    end
    
    local function onCharacterAdded(newChar)
        character = newChar
        task.wait(0.5)
        if particleEnabled then
            applyParticleAura()
        end
    end
    
    player.CharacterAdded:Connect(onCharacterAdded)
    
    local particleSection = tab:Section({
        Title = "粒子特效",
        Box = true,
        BoxBorder = true,
        Opened = true,
    })
    
    particleSection:Toggle({
        Title = "启用粒子特效",
        Default = false,
        Callback = function(state)
            particleEnabled = state
            if state then
                applyParticleAura()
            else
                clearParticles()
            end
        end
    })
    
    particleSection:Dropdown({
        Title = "粒子样式",
        Values = {"天使", "星光", "天堂", "丝带", "樱花", "风", "流", "星"},
        Default = "天使",
        Callback = function(value)
            currentParticleStyle = value
            if particleEnabled then
                applyParticleAura()
            end
        end
    })
    
    particleSection:Button({
        Title = "刷新粒子",
        Callback = function()
            if particleEnabled then
                applyParticleAura()
            end
        end
    })
    
    particleSection:Button({
        Title = "清除粒子",
        Callback = function()
            clearParticles()
            particleEnabled = false
        end
    })
    
    local otherSection = tab:Section({
        Title = "其他美化等待更新",
        Box = true,
        BoxBorder = true,
        Opened = true,
    })
end

Tabs.sbcnm:Section({
    Title = "Ohio", 
    TextXAlignment = "Left", 
    TextSize = 17
})

local ohioLoaded = false

local allowedServerIds = {
    "7239319209",
}

local function GetCurrentServerId()
    local success, id = pcall(function()
        return tostring(game.PlaceId)
    end)
    if success and id then
        return id
    end
    return nil
end

local function CheckServerId()
    local currentId = GetCurrentServerId()
    if not currentId then
        if WindUI and WindUI.Notify then
            WindUI:Notify({
                Title = "加载失败", 
                Content = "无法获取ID", 
                Duration = 3
            })
        end
        return false
    end
    
    for _, allowedId in ipairs(allowedServerIds) do
        if currentId == allowedId then
            return true
        end
    end
    
    if WindUI and WindUI.Notify then
        WindUI:Notify({
            Title = "服务器不符", 
            Content = "当前ID: " .. currentId, 
            Duration = 3
        })
    end
    return false
end

Tabs.sbcnm:Button({
    Title = "Ohio",
    Callback = function()
        if ohioLoaded then
            if WindUI and WindUI.Notify then
                WindUI:Notify({
                    Title = "重复点击！", 
                    Content = "", 
                    Duration = 3
                })
            end
            return
        end
        
        if not CheckServerId() then
            return
        end
        
        ohioLoaded = true

        local Players = game:GetService("Players")
        local UserInputService = game:GetService("UserInputService")
        local RunService = game:GetService("RunService")
        local Lighting = game:GetService("Lighting")
        local Workspace = game:GetService("Workspace")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local TeleportService = game:GetService("TeleportService")
        local HttpService = game:GetService("HttpService")
        local VirtualUser = game:GetService("VirtualUser")
        local TextChatService = game:GetService("TextChatService")
        local StarterGui = game:GetService("StarterGui")
        local TweenService = game:GetService("TweenService")
        local GuiService = game:GetService("GuiService")
        
        local LocalPlayer = Players.LocalPlayer
        local Camera = workspace.CurrentCamera

        local OhioTabs = {
            h = Window:Tab({ Title = "主页", Icon = "house" }),
            p = Window:Tab({ Title = "玩家", Icon = "user" }),
            v = Window:Tab({ Title = "战斗", Icon = "swords" }),
            f = Window:Tab({ Title = "刷钱", Icon = "dollar-sign" }),
            t = Window:Tab({ Title = "传送", Icon = "map" }),
            e = Window:Tab({ Title = "透视", Icon = "eye" }),
            k = Window:Tab({ Title = "杀戮", Icon = "crown" }),
            pr = Window:Tab({ Title = "隐私", Icon = "shield" }),
            pro = Window:Tab({ Title = "防护", Icon = "shield-check" }),
            by = Window:Tab({ Title = "绕过", Icon = "unlock" }),
            main = Window:Tab({ Title = "主要", Icon = "star" }),
            remote = Window:Tab({ Title = "远程", Icon = "shopping-cart" }),
            instant = Window:Tab({ Title = "互动", Icon = "bolt" }),
            lock = Window:Tab({ Title = "锁定", Icon = "lock" }),
            auto = Window:Tab({ Title = "自动", Icon = "play" }),
            mm = Window:Tab({ Title = "美化", Icon = "paintbrush" }),
            farm = Window:Tab({ Title = "农场", Icon = "tree" }),
            ui = Window:Tab({ Title = "UI设置", Icon = "settings" }),
        }

        OhioTabs.h:Paragraph({
            Title = "VOTR Hub",
            Desc = "欢迎使用 VOTR Hub\n祝你游戏愉快\n有bug请见谅，透视用不了请移步通用功能使用",
            Thumbnail = "https://raw.githubusercontent.com/tzxnb666/tzxnb666/refs/heads/main/Screenshot_20260228_213152_com_ss_android_ugc_aweme_DetailActivity.jpg",
            ThumbnailSize = 160
        })

        -- ========================================
        -- 玩家 Tab
        -- ========================================

        local SpeedMin = 16
        local SpeedMax = 500
        local SpeedCurrent = 16
        local function applySpeed(character)
            local hum = character:WaitForChild("Humanoid")
            local hrp = character:WaitForChild("HumanoidRootPart")
            local lastPos = hrp.Position
            RunService.Heartbeat:Connect(function()
                if SpeedCurrent > 16 then
                    local moveDir = hum.MoveDirection
                    if moveDir.Magnitude > 0 then
                        local newPos = hrp.Position + moveDir * (SpeedCurrent - 16) / 10 * 0.2
                        if not Workspace:FindPartOnRay(Ray.new(hrp.Position, (newPos - hrp.Position)), character) then
                            hrp.CFrame = CFrame.new(newPos, newPos + moveDir)
                            lastPos = newPos
                        end
                    end
                end
            end)
        end
        LocalPlayer.CharacterAdded:Connect(applySpeed)
        if LocalPlayer.Character then applySpeed(LocalPlayer.Character) end
        
        OhioTabs.p:Slider({
            Title = "设置速度",
            Value = { Min = SpeedMin, Max = SpeedMax, Default = SpeedCurrent },
            Callback = function(val) SpeedCurrent = val end
        })

        local infiniteJump = false
        local jumpConnection = nil
        local function onJumpRequest()
            if infiniteJump and LocalPlayer.Character then
                local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
                if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end
        local function setupJump()
            if jumpConnection then jumpConnection:Disconnect() end
            jumpConnection = UserInputService.JumpRequest:Connect(onJumpRequest)
        end
        setupJump()
        LocalPlayer.CharacterAdded:Connect(setupJump)
        OhioTabs.p:Toggle({
            Title = "无限跳",
            Value = false,
            Callback = function(state) infiniteJump = state end
        })

        local noclipConnection = nil
        OhioTabs.p:Toggle({
            Title = "穿墙",
            Value = false,
            Callback = function(state)
                if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
                if state then
                    noclipConnection = RunService.Stepped:Connect(function()
                        if LocalPlayer.Character then
                            for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                                if part:IsA("BasePart") then
                                    part.CanCollide = false
                                end
                            end
                        end
                    end)
                end
            end
        })

        local FBEX = false
        local FBE = false
        local NormalLighting = {}
        local function setupHighlight()
            if FBEX then return end
            FBEX = true
            NormalLighting = {
                Brightness = Lighting.Brightness,
                ClockTime = Lighting.ClockTime,
                FogEnd = Lighting.FogEnd,
                GlobalShadows = Lighting.GlobalShadows,
                Ambient = Lighting.Ambient
            }
            local function setProp(prop, val)
                Lighting[prop] = val
                NormalLighting[prop] = val
            end
            local function watchProp(prop, target)
                Lighting:GetPropertyChangedSignal(prop):Connect(function()
                    if Lighting[prop] ~= target and Lighting[prop] ~= NormalLighting[prop] then
                        setProp(prop, target)
                    end
                end)
            end
            watchProp("Brightness", 1)
            watchProp("ClockTime", 12)
            watchProp("FogEnd", 786543)
            watchProp("GlobalShadows", false)
            watchProp("Ambient", Color3.fromRGB(178,178,178))
            for k, v in pairs({Brightness=1, ClockTime=12, FogEnd=786543, GlobalShadows=false, Ambient=Color3.fromRGB(178,178,178)}) do
                Lighting[k] = v
            end
            local lastFBE = false
            spawn(function()
                while true do
                    task.wait()
                    if FBE ~= lastFBE then
                        lastFBE = FBE
                        if FBE then
                            for k, v in pairs({Brightness=1, ClockTime=12, FogEnd=786543, GlobalShadows=false, Ambient=Color3.fromRGB(178,178,178)}) do
                                Lighting[k] = v
                            end
                        else
                            for k, v in pairs(NormalLighting) do
                                Lighting[k] = v
                            end
                        end
                    end
                end
            end)
        end
        OhioTabs.p:Toggle({
            Title = "夜视",
            Value = false,
            Callback = function(state)
                if not FBEX then setupHighlight() end
                FBE = state
            end
        })

        local respawnToggle = false
        local respawnConn = nil
        local deathPos = nil
        local function onDied(character)
            if not respawnToggle then return end
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if hrp then deathPos = hrp.Position end
        end
        local function onRespawn(character)
            if not respawnToggle then return end
            local hrp = character:WaitForChild("HumanoidRootPart", 10)
            if hrp and deathPos then
                hrp.CFrame = CFrame.new(deathPos)
                wait(1)
                if (hrp.Position - deathPos).Magnitude > 1 then
                    hrp.CFrame = CFrame.new(deathPos)
                end
            end
            local hum = character:FindFirstChildOfClass("Humanoid")
            if hum then hum.Died:Connect(function() onDied(character) end) end
        end
        OhioTabs.p:Toggle({
            Title = "原地复活",
            Value = false,
            Callback = function(state)
                respawnToggle = state
                if state then
                    respawnConn = LocalPlayer.CharacterAdded:Connect(onRespawn)
                    if LocalPlayer.Character then onRespawn(LocalPlayer.Character) end
                    spawn(function()
                        while respawnToggle do
                            wait(1)
                            local char = LocalPlayer.Character
                            local hum = char and char:FindFirstChildOfClass("Humanoid")
                            if hum and hum.Health == 0 then onDied(char) end
                        end
                    end)
                else
                    if respawnConn then respawnConn:Disconnect() respawnConn = nil end
                    deathPos = nil
                end
            end
        })

        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
        local chatConfig = TextChatService:FindFirstChild("ChatWindowConfiguration")
        if chatConfig then chatConfig.Enabled = false end
        OhioTabs.p:Toggle({
            Title = "显示聊天",
            Value = false,
            Callback = function(state)
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, state)
                if chatConfig then chatConfig.Enabled = state end
            end
        })

        local flyEnabled = false
        local flyParts = {}
        local terrain = Workspace:FindFirstChildOfClass("Terrain")
        local waterSettings = {
            WaterTransparency = 0.7,
            WaterReflectance = 0.2,
            WaterWaveSize = 0.5,
            WaterWaveSpeed = 0.5,
            WaterColor = Color3.fromRGB(0, 100, 200)
        }
        local airSettings = {
            WaterTransparency = 1,
            WaterReflectance = 0,
            WaterWaveSize = 0,
            WaterWaveSpeed = 0,
            WaterColor = Color3.fromRGB(255,255,255)
        }
        local decayTime = 0.8
        RunService.RenderStepped:Connect(function()
            if flyEnabled and LocalPlayer.Character and terrain then
                local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                local head = LocalPlayer.Character:FindFirstChild("Head")
                if hrp and head then
                    local headCF = head.CFrame
                    local hrpCF = hrp.CFrame
                    local size = hrp.Size + Vector3.new(0,0.1,0)
                    terrain.WaterTransparency = airSettings.WaterTransparency
                    terrain.WaterReflectance = airSettings.WaterReflectance
                    terrain.WaterWaveSize = airSettings.WaterWaveSize
                    terrain.WaterWaveSpeed = airSettings.WaterWaveSpeed
                    terrain.WaterColor = airSettings.WaterColor
                    terrain:FillBlock(headCF, size, Enum.Material.Water)
                    terrain:FillBlock(hrpCF, size, Enum.Material.Water)
                    table.insert(flyParts, {time=tick(), cf=headCF, size=size})
                    table.insert(flyParts, {time=tick(), cf=hrpCF, size=size})
                end
            end
        end)
        spawn(function()
            while true do
                local now = tick()
                for i = #flyParts, 1, -1 do
                    local p = flyParts[i]
                    if now - p.time >= decayTime then
                        terrain:FillBlock(p.cf, p.size, Enum.Material.Air)
                        table.remove(flyParts, i)
                    end
                end
                terrain.WaterTransparency = waterSettings.WaterTransparency
                terrain.WaterReflectance = waterSettings.WaterReflectance
                terrain.WaterWaveSize = waterSettings.WaterWaveSize
                terrain.WaterWaveSpeed = waterSettings.WaterWaveSpeed
                terrain.WaterColor = waterSettings.WaterColor
                task.wait(0.05)
            end
        end)
        OhioTabs.p:Toggle({
            Title = "飞行(anti ban)",
            Value = false,
            Callback = function(state)
                flyEnabled = state
                if not state and LocalPlayer.Character then
                    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then hrp.Velocity = Vector3.new(0,0,0) end
                end
            end
        })

        OhioTabs.p:Toggle({
            Title = "远程储物柜（打开背包即可）",
            Value = false,
            Callback = function(state)
                local locker = LocalPlayer.PlayerGui:FindFirstChild("Backpack") and LocalPlayer.PlayerGui.Backpack:FindFirstChild("Holder") and LocalPlayer.PlayerGui.Backpack.Holder:FindFirstChild("Locker")
                if locker then locker.Visible = state end
            end
        })

        OhioTabs.p:Toggle({
            Title = "远程黑市",
            Value = false,
            Callback = function(state)
                local dealer = Workspace:FindFirstChild("BlackMarket") and Workspace.BlackMarket:FindFirstChild("Dealer") and Workspace.BlackMarket.Dealer:FindFirstChild("Dealer")
                local prompt = dealer and dealer:FindFirstChild("ProximityPrompt")
                if prompt then
                    prompt.MaxActivationDistance = state and 100000 or 16
                end
            end
        })

        local animationPacks = {
            ["吸血鬼"] = {idle1="1083445855",idle2="1083450166",walk="1083473930",run="1083462077",jump="1083455352",climb="1083439238",fall="1083443587"},
            ["英雄"] = {idle1="616111295",idle2="616113536",walk="616122287",run="616117076",jump="616115533",climb="616104706",fall="616108001"},
            ["经典僵尸"] = {idle1="616158929",idle2="616160636",walk="616168032",run="616163682",jump="616161997",climb="616156119",fall="616157476"},
            ["法师"] = {idle1="707742142",idle2="707855907",walk="707897309",run="707861613",jump="707853694",climb="707826056",fall="707829716"},
            ["幽灵"] = {idle1="616006778",idle2="616008087",walk="616010382",run="616013216",jump="616008936",climb="616003713",fall="616005863"},
            ["长者"] = {idle1="845397899",idle2="845400520",walk="845403856",run="845386501",jump="845398858",climb="845392038",fall="845396048"},
            ["漂浮"] = {idle1="616006778",idle2="616008087",walk="616013216",run="616010382",jump="616008936",climb="616003713",fall="616005863"},
            ["宇航员"] = {idle1="891621366",idle2="891633237",walk="891667138",run="891636393",jump="891627522",climb="891609353",fall="891617961"},
            ["忍者"] = {idle1="656117400",idle2="656118341",walk="656121766",run="656118852",jump="656117878",climb="656114359",fall="656115606"},
            ["狼人"] = {idle1="1083195517",idle2="1083214717",walk="1083178339",run="1083216690",jump="1083218792",climb="1083182000",fall="1083189019"},
            ["卡通"] = {idle1="742637544",idle2="742638445",walk="742640026",run="742638842",jump="742637942",climb="742636889",fall="742637151"},
            ["海盗"] = {idle1="750781874",idle2="750782770",walk="750785693",run="750783738",jump="750782230",climb="750779899",fall="750780242"},
            ["潜行"] = {idle1="1132473842",idle2="1132477671",walk="1132510133",run="1132494274",jump="1132489853",climb="1132461372",fall="1132469004"},
            ["玩具"] = {idle1="782841498",idle2="782845736",walk="782843345",run="782842708",jump="782847020",climb="782843869",fall="782846423"},
            ["骑士"] = {idle1="657595757",idle2="657568135",walk="657552124",run="657564596",jump="658409194",climb="658360781",fall="657600338"},
            ["自信"] = {idle1="1069977950",idle2="1069987858",walk="1070017263",run="1070001516",jump="1069984524",climb="1069946257",fall="1069973677"},
            ["流行明星"] = {idle1="1212900985",idle2="1212900985",walk="1212980338",run="1212980348",jump="1212954642",climb="1213044953",fall="1212900995"},
            ["公主"] = {idle1="941003647",idle2="941013098",walk="941028902",run="941015281",jump="941008832",climb="940996062",fall="941000007"},
            ["牛仔"] = {idle1="1014390418",idle2="1014398616",walk="1014421541",run="1014401683",jump="1014394726",climb="1014380606",fall="1014384571"},
            ["巡逻"] = {idle1="1149612882",idle2="1150842221",walk="1151231493",run="1150967949",jump="1150944216",climb="1148811837",fall="1148863382"},
            ["僵尸FE"] = {idle1="3489171152",idle2="3489171152",walk="3489174223",run="3489173414",jump="616161997",climb="616156119",fall="616157476"}
        }

        local plr = LocalPlayer
        local autoApplyConnection = nil

        local function applyAnimationPack(packName)
            if not plr.Character or not plr.Character:FindFirstChild("Animate") then
                return
            end
            local Animate = plr.Character.Animate
            Animate.Disabled = true
            local a = animationPacks[packName]
            if a then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=" .. a.idle1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=" .. a.idle2
                Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=" .. a.walk
                Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=" .. a.run
                Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=" .. a.jump
                Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=" .. a.climb
                Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=" .. a.fall
            end
            Animate.Disabled = false
            if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end

        local DEFAULT_PACK = "海盗"

        OhioTabs.main:Toggle({
            Title = "启动动画包(先打开)",
            Default = false,
            Callback = function(state)
                if state then
                    applyAnimationPack(DEFAULT_PACK)
                    autoApplyConnection = plr.CharacterAdded:Connect(function(char)
                        char:WaitForChild("Animate")
                        applyAnimationPack(DEFAULT_PACK)
                    end)
                else
                    if autoApplyConnection then
                        autoApplyConnection:Disconnect()
                        autoApplyConnection = nil
                    end
                end
            end
        })

        OhioTabs.main:Dropdown({
            Title = "选择一个r15动画包",
            Values = { 
                "吸血鬼", "英雄", "经典僵尸", "法师", "幽灵", 
                "长者", "漂浮", "宇航员", "忍者", "狼人", 
                "卡通", "海盗", "潜行", "玩具", "骑士", 
                "自信", "流行明星", "公主", "牛仔", "巡逻", 
                "僵尸FE"
            },
            Callback = function(Value)
                applyAnimationPack(Value)
            end
        })

        OhioTabs.main:Button({
            Title = "全枪无限子弹",
            Callback = function()
                local function setInfiniteAmmo()
                    local itemSystem = require(ReplicatedStorage.devv).load("v3item")
                    local inventory = itemSystem.inventory
                    for _, item in pairs(inventory.items) do
                        if item and item.ammoManager then
                            item.ammoManager:setAmmo(9999)
                            item.ammoManager:setAmmoOut(9999)
                        end
                    end
                end
                setInfiniteAmmo()
                task.spawn(function()
                    while true do
                        pcall(setInfiniteAmmo)
                        task.wait(25)
                    end
                end)
            end
        })

        OhioTabs.main:Button({
            Title = "全枪射速提升",
            Callback = function()
                local function increaseFireRate()
                    local itemSystem = require(ReplicatedStorage.devv).load("v3item")
                    local inventory = itemSystem.inventory
                    for _, item in pairs(inventory.items) do
                        if item then
                            item.fireDebounce = 0.01
                            item.reloadTime = 0.1
                            if item.ammoManager then
                                item.ammoManager.ammo = 9999
                            end
                        end
                    end
                end
                increaseFireRate()
                task.spawn(function()
                    while true do
                        pcall(increaseFireRate)
                        task.wait(30)
                    end
                end)
            end
        })

        OhioTabs.main:Button({
            Title = "全枪无后坐力",
            Callback = function()
                local function removeRecoil()
                    local itemSystem = require(ReplicatedStorage.devv).load("v3item")
                    local inventory = itemSystem.inventory
                    for _, item in pairs(inventory.items) do
                        if item then
                            item.recoilAdd = 0
                            item.maxRecoil = 0
                            item.recoilDiminishFactor = 0
                            item.recoilFastDiminishFactor = 0
                            item.baseSpread = 0
                            item.baseAimSpread = 0
                            item.spread = 0
                            item.aimSpread = 0
                        end
                    end
                end
                removeRecoil()
                task.spawn(function()
                    while true do
                        pcall(removeRecoil)
                        task.wait(30)
                    end
                end)
            end
        })

        -- ========================================
        -- 战斗 Tab
        -- ========================================

        local dvv = require(ReplicatedStorage.devv)
        local sig = dvv.load("Signal")
        local guid = dvv.load("GUID")
        local inv = dvv.load("v3item").inventory

        local dartOn = false
        local dartTeleportTargets = false
        local dartCachedHitId = nil
        local dartCurrentTarget = nil
        local dartHeartConnections = {}
        local dartNinjaStarBuyThread = nil
        local dartTeleportConn = nil
        local dartTeleportCheckConn = nil

        getgenv().TrailColors = {
            StartColor = Color3.fromRGB(200, 180, 255),
            EndColor = Color3.fromRGB(140, 100, 220),
            MiddleColor1 = Color3.fromRGB(180, 150, 240),
            MiddleColor2 = Color3.fromRGB(160, 130, 230)
        }

        local function createBeautifulTrail(origin, targetPos)
            local trailContainer = Instance.new("Folder")
            trailContainer.Name = "MagicTrail"
            trailContainer.Parent = Workspace
            local midPoint = (origin + targetPos) / 2
            local direction = (targetPos - origin).Unit
            local perpendicular = Vector3.new(-direction.Z, direction.Y, direction.X) * 3
            local controlPoint = midPoint + perpendicular + Vector3.new(0, math.random(-3, 3), 0)
            local function createBezierCurve(p0, p1, p2, t)
                return (1 - t)^2 * p0 + 2 * (1 - t) * t * p1 + t^2 * p2
            end
            local curvePoints = {}
            local numSegments = 20
            for i = 0, numSegments do
                local t = i / numSegments
                local point = createBezierCurve(origin, controlPoint, targetPos, t)
                table.insert(curvePoints, point)
            end
            for i = 1, #curvePoints - 1 do
                local startPoint = curvePoints[i]
                local endPoint = curvePoints[i + 1]
                local distance = (endPoint - startPoint).Magnitude
                local beamPart = Instance.new("Part")
                beamPart.Size = Vector3.new(0.15, 0.15, distance)
                beamPart.Anchored = true
                beamPart.CanCollide = false
                beamPart.Material = Enum.Material.Neon
                beamPart.Transparency = 0.3
                beamPart.CFrame = CFrame.new(startPoint, endPoint) * CFrame.new(0, 0, -distance / 2)
                beamPart.Parent = trailContainer
                local t = i / (#curvePoints - 1)
                local color
                if t < 0.3 then
                    color = getgenv().TrailColors.StartColor or Color3.fromRGB(200, 180, 255)
                elseif t < 0.6 then
                    color = getgenv().TrailColors.MiddleColor1 or Color3.fromRGB(180, 150, 240)
                elseif t < 0.9 then
                    color = getgenv().TrailColors.MiddleColor2 or Color3.fromRGB(160, 130, 230)
                else
                    color = getgenv().TrailColors.EndColor or Color3.fromRGB(140, 100, 220)
                end
                beamPart.Color = color
                local pointLight = Instance.new("PointLight")
                pointLight.Brightness = 5
                pointLight.Range = 3
                pointLight.Color = color
                pointLight.Parent = beamPart
                local particles = Instance.new("ParticleEmitter")
                particles.Size = NumberSequence.new(0.1, 0.3)
                particles.Transparency = NumberSequence.new(0.3, 0.8)
                particles.Lifetime = NumberRange.new(0.5, 1)
                particles.Rate = 50
                particles.Speed = NumberRange.new(1, 2)
                particles.VelocitySpread = 180
                particles.Color = ColorSequence.new(color)
                particles.Parent = beamPart
            end
            task.delay(1.5, function()
                if trailContainer and trailContainer.Parent then
                    trailContainer:Destroy()
                end
            end)
            return trailContainer
        end

        local function dartCleanupConnections()
            for _, conn in ipairs(dartHeartConnections) do
                if conn then conn:Disconnect() end
            end
            dartHeartConnections = {}
        end

        local function dartEquipNinjaStar()
            local itm = inv.getItems and inv.getItems() or inv.items or {}
            for _, v in next, itm do
                if v.name == "Ninja Star" then
                    sig.FireServer("equip", v.guid)
                    return v.guid
                end
            end
            return nil
        end

        local function dartInitThrow()
            local sg = dartEquipNinjaStar()
            if not sg then return end
            local c = LocalPlayer.Character
            if not c then return end
            local rh = c:FindFirstChild("RightHand")
            local hrp = c:FindFirstChild("HumanoidRootPart")
            if not rh or not hrp then return end
            local mp = rh.Position + Vector3.new(0, 0.5, 0)
            local tp = mp + Vector3.new(50, 0, 0)
            local vel = (tp - mp).Unit * 150
            createBeautifulTrail(mp, tp)
            local ok, r1, hid = pcall(function()
                return sig.InvokeServer("throwSticky", guid(), "Ninja Star", sg, vel, tp)
            end)
            if ok and r1 and hid then
                dartCachedHitId = hid
            end
        end

        local function dartHasShield(targetPlayer)
            if not targetPlayer or not targetPlayer.Character then return false end
            local char = targetPlayer.Character
            local humanoid = char:FindFirstChild("Humanoid")
            if not humanoid then return false end
            for _, desc in pairs(char:GetDescendants()) do
                if desc:IsA("ForceField") then
                    return true
                end
            end
            return false
        end

        local function dartFindValidTarget()
            local closest = nil
            local minDist = math.huge
            local myPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position
            if not myPos then return nil end
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local char = player.Character
                    local humanoid = char:FindFirstChild("Humanoid")
                    local head = char:FindFirstChild("Head")
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if humanoid and head and hrp and humanoid.Health > 0 and not dartHasShield(player) then
                        local dist = (hrp.Position - myPos).Magnitude
                        if dist < minDist and dist <= 50 then
                            minDist = dist
                            closest = {player = player, head = head}
                        end
                    end
                end
            end
            return closest
        end

        local function dartRapidThrowAttack()
            if not dartOn or not dartCachedHitId then return end
            local targetData = dartFindValidTarget()
            if not targetData then return end
            local head = targetData.head 
            local tp = head.Position
            local wcf = CFrame.new(tp, tp + Vector3.new(0, 1, 0))
            local rcf = CFrame.new(0, 0, 0)
            local c = LocalPlayer.Character
            if c and c:FindFirstChild("RightHand") then
                local rh = c:FindFirstChild("RightHand")
                createBeautifulTrail(rh.Position, tp)
            end
            for i = 1, 15 do 
                sig.InvokeServer("hitSticky", dartCachedHitId, head, rcf, wcf)
            end
        end

        local function dartFindNextTeleportTarget()
            local players = Players:GetPlayers()
            for _, player in ipairs(players) do
                if player ~= LocalPlayer and player.Character then
                    local humanoid = player.Character:FindFirstChild("Humanoid")
                    if humanoid and humanoid.Health > 0 and not dartHasShield(player) then
                        return player
                    end
                end
            end
            return nil
        end

        local function dartFastTeleport()
            if not dartTeleportTargets or not dartOn then return end
            if not dartCurrentTarget then
                dartCurrentTarget = dartFindNextTeleportTarget()
                if not dartCurrentTarget then return end
            end
            if not dartCurrentTarget.Character then
                dartCurrentTarget = dartFindNextTeleportTarget()
                if not dartCurrentTarget then return end
            end
            local humanoid = dartCurrentTarget.Character:FindFirstChild("Humanoid")
            if not humanoid or humanoid.Health <= 0 or dartHasShield(dartCurrentTarget) then
                dartCurrentTarget = dartFindNextTeleportTarget()
                if not dartCurrentTarget then return end
            end
            local char = LocalPlayer.Character
            if not char or not char.PrimaryPart then return end
            local targetChar = dartCurrentTarget.Character
            local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
            if not targetHRP then return end
            char.PrimaryPart.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 1.5)
        end

        OhioTabs.k:Toggle({
            Title = "忍者飞镖光环",
            Default = false,
            Callback = function(state)
                dartOn = state
                dartCleanupConnections()
                if state then
                    dartEquipNinjaStar()
                    task.wait(0.1)
                    dartInitThrow()
                    local fastAttackConn = RunService.RenderStepped:Connect(function()
                        if not dartOn then return end
                        dartRapidThrowAttack()
                    end)
                    table.insert(dartHeartConnections, fastAttackConn)
                end
            end
        })

        OhioTabs.k:Toggle({
            Title = "传送攻击(需开启忍者飞镖光环)",
            Default = false,
            Callback = function(state)
                dartTeleportTargets = state
                if dartTeleportConn then
                    dartTeleportConn:Disconnect()
                    dartTeleportConn = nil
                end
                if dartTeleportCheckConn then
                    dartTeleportCheckConn:Disconnect()
                    dartTeleportCheckConn = nil
                end
                if state then
                    if dartOn then
                        dartTeleportConn = RunService.RenderStepped:Connect(function()
                            dartFastTeleport()
                        end)
                        table.insert(dartHeartConnections, dartTeleportConn)
                        WindUI:Notify({
                            Title = "TPattack",
                            Content = "开启",
                            Duration = 2,
                            Icon = "zap"
                        })
                    else
                        dartTeleportCheckConn = RunService.Heartbeat:Connect(function()
                            if dartOn then
                                dartTeleportCheckConn:Disconnect()
                                dartTeleportCheckConn = nil
                                dartTeleportConn = RunService.RenderStepped:Connect(function()
                                    dartFastTeleport()
                                end)
                                table.insert(dartHeartConnections, dartTeleportConn)
                            end
                        end)
                    end
                end
            end
        })

        OhioTabs.k:Toggle({
            Title = "自动购买忍者飞镖",
            Default = false,
            Callback = function(state)
                if dartNinjaStarBuyThread then
                    dartNinjaStarBuyThread:Disconnect()
                    dartNinjaStarBuyThread = nil
                end
                if state then
                    local heartbeat = RunService.Heartbeat
                    dartNinjaStarBuyThread = heartbeat:Connect(function()
                        sig.InvokeServer("attemptPurchase", "Ninja Star")
                        for _, v in next, inv.items do
                            if v.name == "Ninja Star" then
                                break
                            end
                        end
                    end)
                end
            end
        })

        OhioTabs.k:Toggle({
            Title = "香蕉光环",
            Default = false,
            Callback = function(state)
                _G.AuraEnabled = state
                if not state then _G.TargetId = nil end
            end
        })

        OhioTabs.k:Toggle({
            Title = "斧头光环",
            Default = false,
            Callback = function(state)
                _G.BladeAuraEnabled = state
            end
        })

        OhioTabs.k:Slider({
            Title = "不攻击生命值",
            Value = {
                Min = 0,
                Max = 25,
                Default = 0,
            },
            Callback = function(value)
                _G.HealthThreshold = value
            end
        })

        -- ========================================
        -- 隐私 Tab
        -- ========================================

        local maskOptions = {"Surgeon Mask", "Hockey Mask", "Blue Bandana", "Black Bandana", "Red Bandana"}
        local selectedMask = "Surgeon Mask"
        local autoMaskEnabled2 = false

        OhioTabs.pr:Dropdown({
            Title = "选择口罩类型",
            Values = {"口罩", "小丑面具", "蓝色头巾", "黑色头巾", "红色头巾"},
            Value = "口罩",
            Callback = function(option)
                if option == "口罩" then
                    selectedMask = "Surgeon Mask"
                elseif option == "小丑面具" then
                    selectedMask = "Hockey Mask"
                elseif option == "蓝色头巾" then
                    selectedMask = "Blue Bandana"
                elseif option == "黑色头巾" then
                    selectedMask = "Black Bandana"
                elseif option == "红色头巾" then
                    selectedMask = "Red Bandana"
                end
            end
        })

        OhioTabs.pr:Toggle({
            Title = "自动口罩",
            Default = false,
            Callback = function(Value)
                autoMaskEnabled2 = Value
                if not Value then return end
                task.spawn(function()
                    local Signal = require(ReplicatedStorage.devv).load("Signal")
                    local item = require(ReplicatedStorage.devv).load("v3item")
                    local function purchaseAndEquipMask()
                        if not autoMaskEnabled2 then return end
                        local hasMask = false
                        for _, v in pairs(item.inventory.items) do
                            if v.name == selectedMask then
                                hasMask = true
                                break
                            end
                        end
                        if not hasMask then
                            Signal.InvokeServer("attemptPurchase", selectedMask)
                            task.wait()
                        end
                        for _, v in pairs(item.inventory.items) do
                            if v.name == selectedMask then
                                Signal.FireServer("equip", v.guid)
                                Signal.FireServer("wearMask", v.guid)
                                break
                            end
                        end
                    end
                    purchaseAndEquipMask()
                    local conn
                    conn = LocalPlayer.CharacterAdded:Connect(function(char)
                        char:WaitForChild("HumanoidRootPart")
                        task.wait()
                        purchaseAndEquipMask()
                    end)
                    while autoMaskEnabled2 do
                        task.wait()
                    end
                    if conn then conn:Disconnect() end
                end)
            end
        })

        OhioTabs.pr:Button({
            Title = "变身警察",
            Callback = function()
                local function fastInteractProximityPrompt(proximityPrompt)
                    if not proximityPrompt or not proximityPrompt:IsA("ProximityPrompt") then
                        return false
                    end
                    local originalRequiresLineOfSight = proximityPrompt.RequiresLineOfSight
                    local originalHoldDuration = proximityPrompt.HoldDuration
                    proximityPrompt.RequiresLineOfSight = false
                    proximityPrompt.HoldDuration = 0
                    for i = 1, 5 do
                        fireproximityprompt(proximityPrompt)
                        task.wait(0.01)
                    end
                    proximityPrompt.RequiresLineOfSight = originalRequiresLineOfSight
                    proximityPrompt.HoldDuration = originalHoldDuration
                    return true
                end
                local function interactAtPosition(position)
                    local character = LocalPlayer.Character
                    if not character then return false end
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if not rootPart then return false end
                    local originalPosition = rootPart.CFrame
                    rootPart.CFrame = CFrame.new(position)
                    task.wait(0.2)
                    local closestPrompt = nil
                    local closestDistance = math.huge
                    for _, prompt in pairs(Workspace:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") then
                            local promptParent = prompt.Parent
                            if promptParent and (promptParent:IsA("MeshPart") or promptParent:IsA("Part")) then
                                local distance = (rootPart.Position - promptParent.Position).Magnitude
                                if distance < closestDistance then
                                    closestDistance = distance
                                    closestPrompt = prompt
                                end
                            end
                        end
                    end
                    local interacted = false
                    if closestPrompt then
                        interacted = fastInteractProximityPrompt(closestPrompt)
                    end
                    rootPart.CFrame = originalPosition
                    return interacted
                end
                interactAtPosition(Vector3.new(580.19, 26.67, -873.15))
                interactAtPosition(Vector3.new(587.30, 26.66, -871.14))
            end
        })

        OhioTabs.pr:Button({
            Title = "小丑头套",
            Callback = function()
                local function fastInteractProximityPrompt(proximityPrompt)
                    if not proximityPrompt or not proximityPrompt:IsA("ProximityPrompt") then
                        return false
                    end
                    local originalRequiresLineOfSight = proximityPrompt.RequiresLineOfSight
                    local originalHoldDuration = proximityPrompt.HoldDuration
                    proximityPrompt.RequiresLineOfSight = false
                    proximityPrompt.HoldDuration = 0
                    for i = 1, 5 do
                        fireproximityprompt(proximityPrompt)
                        task.wait(0.01)
                    end
                    proximityPrompt.RequiresLineOfSight = originalRequiresLineOfSight
                    proximityPrompt.HoldDuration = originalHoldDuration
                    return true
                end
                local function interactAtPosition(position)
                    local character = LocalPlayer.Character
                    if not character then return false end
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if not rootPart then return false end
                    local originalPosition = rootPart.CFrame
                    rootPart.CFrame = CFrame.new(position)
                    task.wait(0.2)
                    local closestPrompt = nil
                    local closestDistance = math.huge
                    for _, prompt in pairs(Workspace:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") then
                            local promptParent = prompt.Parent
                            if promptParent and (promptParent:IsA("MeshPart") or promptParent:IsA("Part")) then
                                local distance = (rootPart.Position - promptParent.Position).Magnitude
                                if distance < closestDistance then
                                    closestDistance = distance
                                    closestPrompt = prompt
                                end
                            end
                        end
                    end
                    local interacted = false
                    if closestPrompt then
                        interacted = fastInteractProximityPrompt(closestPrompt)
                    end
                    rootPart.CFrame = originalPosition
                    return interacted
                end
                interactAtPosition(Vector3.new(1124.44, 16.84, 113.32))
            end
        })

        -- ========================================
        -- 防护 Tab
        -- ========================================

        local AutoArmor = false
        OhioTabs.pro:Toggle({
            Title = "自动买护甲",
            Default = false,
            Callback = function(Value)
                AutoArmor = Value
                if Value then
                    local heartbeat = RunService.Heartbeat
                    local connection
                    connection = heartbeat:Connect(function()
                        if not AutoArmor then
                            connection:Disconnect()
                            return
                        end
                        pcall(function()
                            local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                            if humanoid and humanoid.Health > 35 then
                                local b1 = require(ReplicatedStorage.devv).load('v3item').inventory.items
                                local hasLightVest = false
                                for i, v in next, b1 do
                                    if v.name == "Light Vest" then
                                        hasLightVest = true
                                        local light = v.guid
                                        local armor = LocalPlayer:GetAttribute('armor')
                                        if armor == nil or armor <= 0 then
                                            require(ReplicatedStorage.devv).load("Signal").FireServer("equip", light)
                                            require(ReplicatedStorage.devv).load("Signal").FireServer("useConsumable", light)
                                            require(ReplicatedStorage.devv).load("Signal").FireServer("removeItem", light)
                                        end
                                        break
                                    end
                                end
                                if not hasLightVest then
                                    require(ReplicatedStorage.devv).load("Signal").InvokeServer("attemptPurchase", "Light Vest")
                                end
                            end
                        end)
                    end)
                end
            end
        })

        local healThread = nil
        OhioTabs.pro:Toggle({
            Title = "自动恢复健康值(回血)",
            Default = false,
            Callback = function(Value)
                if healThread then
                    healThread:Disconnect()
                    healThread = nil
                end
                if Value then
                    local heartbeat = RunService.Heartbeat
                    healThread = heartbeat:Connect(function()
                        sig.InvokeServer("attemptPurchase", 'Bandage')
                        local inv2 = require(ReplicatedStorage.devv).load('v3item').inventory
                        for _, v in next, inv2.items do
                            if v.name == 'Bandage' then
                                local bande = v.guid
                                local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                                local Humanoid = Character:WaitForChild('Humanoid')
                                if Humanoid.Health >= 5 and Humanoid.Health < Humanoid.MaxHealth then
                                    sig.FireServer("equip", bande)
                                    sig.FireServer("useConsumable", bande)
                                    sig.FireServer("removeItem", bande)
                                end
                                break
                            end
                        end
                    end)
                end
            end
        })

        local melee = require(ReplicatedStorage.devv).load("ClientReplicator")
        local AutoKnockReset = false
        OhioTabs.pro:Toggle({
            Title = "反立",
            Default = false,
            Callback = function(Value)
                AutoKnockReset = Value
                if Value then
                    task.spawn(function()
                        while AutoKnockReset do
                            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                                melee.Set(LocalPlayer, "knocked", false)
                                melee.Replicate("knocked")
                            end
                            task.wait()
                        end
                    end)
                end
            end
        })

        local antiKBEnabled = false
        OhioTabs.pro:Toggle({
            Title = "反击退",
            Default = false,
            Callback = function(Value)
                antiKBEnabled = Value
                task.spawn(function()
                    while antiKBEnabled and task.wait(0.1) do
                        local character = LocalPlayer.Character
                        if character then
                            for _, part in ipairs(character:GetDescendants()) do
                                if part:IsA("BasePart") then
                                    part.CanCollide = false
                                end
                            end
                        end
                    end
                end)
            end
        })

        local autostomp = false
        local grabplay = false

        local function stompAura()
            local character = LocalPlayer.Character
            if not character then return end
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if not rootPart then return end
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local targetChar = player.Character
                    local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
                    local targetHumanoid = targetChar:FindFirstChild("Humanoid")
                    if targetHRP and targetHumanoid and targetHumanoid.Health < 20 then
                        local distance = (rootPart.Position - targetHRP.Position).Magnitude
                        if distance <= 40 then
                            sig.FireServer("finish", player)
                        end
                    end
                end
            end
        end

        local function grabAura()
            local character = LocalPlayer.Character
            if not character then return end
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if not rootPart then return end
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local targetChar = player.Character
                    local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
                    local targetHumanoid = targetChar:FindFirstChild("Humanoid")
                    if targetHRP and targetHumanoid and targetHumanoid.Health < 20 then
                        local distance = (rootPart.Position - targetHRP.Position).Magnitude
                        if distance <= 40 then
                            sig.FireServer("grabPlayer", player)
                        end
                    end
                end
            end
        end

        RunService.Heartbeat:Connect(function()
            if autostomp then stompAura() end
            if grabplay then grabAura() end
        end)

        OhioTabs.v:Toggle({
            Title = "踩踏光环",
            Value = false,
            Callback = function(state)
                autostomp = state
            end
        })

        OhioTabs.v:Toggle({
            Title = "抓取光环",
            Value = false,
            Callback = function(state)
                grabplay = state
            end
        })

        local onePunchEnabled = false
        local onePunchThread = nil

        OhioTabs.v:Toggle({
            Title = "一拳",
            Default = false,
            Callback = function(state)
                onePunchEnabled = state
                if state then
                    onePunchThread = task.spawn(function()
                        local L = LocalPlayer
                        local S = require(ReplicatedStorage.devv).load("Signal")
                        while onePunchEnabled do
                            if L.Character and L.Character:FindFirstChild("HumanoidRootPart") then
                                local r = L.Character.HumanoidRootPart
                                local t, d = nil, 28
                                for _, p in ipairs(Players:GetPlayers()) do
                                    if p ~= L then
                                        local c = p.Character
                                        local h = c and c:FindFirstChild("HumanoidRootPart")
                                        if h and c:FindFirstChild("Humanoid") and c.Humanoid.Health > 5 then
                                            local m = (r.Position - h.Position).Magnitude
                                            if m < d then
                                                t, d = p, m
                                            end
                                        end
                                    end
                                end
                                if t then
                                    S.FireServer("equip", "Fists")
                                    S.FireServer("attackOfMeleeSwing", "meleemegapunch")
                                    S.FireServer("attackMeleeHit", "player", {hitPlayerId = t.UserId, meleeType = "meleemegapunch"})
                                end
                            end
                            task.wait(0.00001)
                        end
                    end)
                else
                    if onePunchThread then
                        task.cancel(onePunchThread)
                        onePunchThread = nil
                    end
                end
            end
        })

        if not connections then connections = {} end

        OhioTabs.v:Toggle({
            Title = "防击倒",
            Default = false,
            Callback = function(Value)
                if connections.antiKnockConnection then
                    connections.antiKnockConnection:Disconnect()
                    connections.antiKnockConnection = nil
                end
                if Value then
                    connections.antiKnockConnection = RunService.Heartbeat:Connect(function()
                        pcall(function()
                            local lp2 = LocalPlayer
                            if not lp2 or not lp2.Character then return end
                            local humanoid = lp2.Character:FindFirstChild("Humanoid")
                            if not humanoid then return end
                            local isKnocked = lp2:GetAttribute("knocked") or false
                            if isKnocked then
                                local melee2 = require(ReplicatedStorage.devv).load("ClientReplicator")
                                melee2.Set(lp2, "knocked", false)
                                melee2.Replicate("knocked")
                            end
                        end)
                    end)
                end
            end
        })

        OhioTabs.v:Toggle({
            Title = "防摔飞",
            Default = false,
            Callback = function(Value)
                if connections.antiThrowConnection then
                    connections.antiThrowConnection:Disconnect()
                    connections.antiThrowConnection = nil
                end
                if Value then
                    connections.antiThrowConnection = RunService.Heartbeat:Connect(function()
                        pcall(function()
                            local character = LocalPlayer.Character
                            if not character then return end
                            local rootPart = character:FindFirstChild("HumanoidRootPart")
                            if rootPart then rootPart.CanCollide = false end
                            local parts = {"Head", "Torso", "UpperTorso", "LowerTorso"}
                            for _, partName in ipairs(parts) do
                                local part = character:FindFirstChild(partName)
                                if part and part:IsA("BasePart") then
                                    part.CanCollide = false
                                end
                            end
                        end)
                    end)
                else
                    pcall(function()
                        local character = LocalPlayer.Character
                        if character then
                            for _, part in ipairs(character:GetDescendants()) do
                                if part:IsA("BasePart") then
                                    part.CanCollide = true
                                end
                            end
                        end
                    end)
                end
            end
        })

        OhioTabs.v:Toggle({
            Title = "防布娃娃",
            Default = false,
            Callback = function(Value)
                if connections.antiRagdollConnection then
                    connections.antiRagdollConnection:Disconnect()
                    connections.antiRagdollConnection = nil
                end
                if Value then
                    connections.antiRagdollConnection = RunService.Heartbeat:Connect(function()
                        pcall(function()
                            local character = LocalPlayer.Character
                            if not character then return end
                            local humanoid = character:FindFirstChild("Humanoid")
                            if not humanoid then return end
                            if humanoid:GetState() == Enum.HumanoidStateType.Frozen then
                                humanoid:ChangeState(Enum.HumanoidStateType.Running)
                                for _, joint in ipairs(character:GetDescendants()) do
                                    if joint:IsA("JointInstance") then
                                        joint.Enabled = true
                                    end
                                end
                            end
                        end)
                    end)
                end
            end
        })

        OhioTabs.v:Toggle({
            Title = "防坐下",
            Default = false,
            Callback = function(Value)
                if connections.antiSitConnection then
                    connections.antiSitConnection:Disconnect()
                    connections.antiSitConnection = nil
                end
                if Value then
                    connections.antiSitConnection = RunService.Heartbeat:Connect(function()
                        pcall(function()
                            local character = LocalPlayer.Character
                            if not character then return end
                            local humanoid = character:FindFirstChild("Humanoid")
                            if not humanoid then return end
                            if humanoid.Sit or humanoid:GetState() == Enum.HumanoidStateType.Seated then
                                humanoid.Sit = false
                                humanoid:ChangeState(Enum.HumanoidStateType.Running)
                                local seat = character:FindFirstChildWhichIsA("Seat")
                                if seat then seat:Destroy() end
                            end
                        end)
                    end)
                end
            end
        })

        OhioTabs.v:Toggle({
            Title = "自动治疗",
            Default = false,
            Callback = function(Value)
                if connections.healThread then
                    connections.healThread:Disconnect()
                    connections.healThread = nil
                end
                if Value then
                    connections.healThread = RunService.Heartbeat:Connect(function()
                        pcall(function()
                            local LocalPlayer2 = LocalPlayer
                            if not LocalPlayer2 then return end
                            local Character = LocalPlayer2.Character
                            if not Character then return end
                            local Humanoid = Character:FindFirstChild('Humanoid')
                            if not Humanoid then return end
                            local healthPercent = Humanoid.Health / Humanoid.MaxHealth
                            if Humanoid.Health >= 5 and Humanoid.Health < Humanoid.MaxHealth and healthPercent < 1 then
                                local Signal = require(ReplicatedStorage.devv).load("Signal")
                                local item = require(ReplicatedStorage.devv).load("v3item")
                                Signal.InvokeServer("attemptPurchase", 'Bandage')
                                for _, v in next, item.inventory.items do
                                    if v.name == 'Bandage' then
                                        local bande = v.guid
                                        Signal.FireServer("equip", bande)
                                        task.wait(0.1)
                                        Signal.FireServer("useConsumable", bande)
                                        task.wait(0.1)
                                        Signal.FireServer("removeItem", bande)
                                        break
                                    end
                                end
                            end
                        end)
                    end)
                end
            end
        })

        local armorOptions = {"轻甲", "重甲", "军用防弹衣", "EOD防弹衣"}
        local selectedArmor = "轻甲"
        local AutoArmor2 = false

        OhioTabs.v:Dropdown({
            Title = "选择防弹衣",
            Values = {"轻甲", "重甲", "军用防弹衣", "EOD防弹衣"},
            Default = "轻甲",
            Callback = function(option)
                if option == "轻甲" then selectedArmor = "轻甲"
                elseif option == "重甲" then selectedArmor = "重甲"
                elseif option == "军用防弹衣" then selectedArmor = "军用防弹衣"
                elseif option == "EOD防弹衣" then selectedArmor = "EOD防弹衣" end
            end
        })

        OhioTabs.v:Toggle({
            Title = "自动装备防弹衣",
            Default = false,
            Callback = function(Value)
                AutoArmor2 = Value
                if Value then
                    task.spawn(function()
                        while AutoArmor2 do
                            pcall(function()
                                local player = LocalPlayer
                                local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                                if humanoid and humanoid.Health > 35 then
                                    local inventory = require(ReplicatedStorage.devv).load('v3item').inventory.items
                                    local hasArmor = false
                                    for i, v in pairs(inventory) do
                                        if v.name == selectedArmor then
                                            hasArmor = true
                                            local armorGuid = v.guid
                                            local armor = player:GetAttribute('armor')
                                            if armor == nil or armor <= 0 then
                                                require(ReplicatedStorage.devv).load("Signal").FireServer("equip", armorGuid)
                                                require(ReplicatedStorage.devv).load("Signal").FireServer("useConsumable", armorGuid)
                                                require(ReplicatedStorage.devv).load("Signal").FireServer("removeItem", armorGuid)
                                            end
                                            break
                                        end
                                    end
                                    if not hasArmor then
                                        require(ReplicatedStorage.devv).load("Signal").InvokeServer("attemptPurchase", selectedArmor)
                                    end
                                end
                            end)
                            wait(0.01)
                        end
                    end)
                end
            end
        })

        -- ========================================
        -- 绕过 Tab
        -- ========================================

        OhioTabs.by:Button({
            Title = "绕过移动经销商",
            Callback = function()
                local pjyd = hookmetamethod(game,"__namecall",function(self,...)local args={...}local method=getnamecallmethod()if method=="InvokeServer" and args[2]==true then args[2]=false return pjyd(self,unpack(args))end return pjyd(self,...)end)
                LocalPlayer:SetAttribute("mobileDealer",true)
                local mobileDealer=require(ReplicatedStorage.devv.shared.Indicies.mobileDealer)
                for category,items in pairs(mobileDealer)do 
                    for _,item in ipairs(items)do 
                        item.stock=999999 
                    end 
                end
                table.insert(mobileDealer.Gun,{itemName="Acid Gun",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="Candy Bucket",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="Golden Rose",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="Black Rose",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="Dollar Balloon",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="Bat Balloon",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="Bunny Balloon",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="Clover Balloon",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="Ghost Balloon",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="Gold Clover Balloon",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="Heart Balloon",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="Skull Balloon",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="Snowflake Balloon",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="Admin AK-47",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="Admin Nuke Launcher",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="Admin RPG",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="Void Gem",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="Pulse Rifle",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="Unusual Money Printer",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="Money Printer",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="Trident",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="NextBot Grenade",stock=9999})
                table.insert(mobileDealer.Gun,{itemName="El Fuego",stock=9999})
            end
        })

        OhioTabs.by:Button({
            Title = "绕过高级动作",
            Callback = function()
                local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
                if playerGui then
                    local emotes = playerGui:FindFirstChild("Emotes")
                    if emotes then
                        local frame = emotes:FindFirstChild("Frame")
                        if frame then
                            local scrollingFrame = frame:FindFirstChild("ScrollingFrame")
                            if scrollingFrame then
                                for _, v in pairs(scrollingFrame:GetDescendants()) do
                                    if v.Name == "Locked" then
                                        v.Visible = false
                                    end
                                end
                            end
                        end
                    end
                end
            end
        })

        OhioTabs.by:Button({
            Title = "绕过飞行封禁",
            Callback = function()
                local devv = ReplicatedStorage:FindFirstChild("devv")
                if devv then
                    local remoteStorage = devv:FindFirstChild("remoteStorage")
                    if remoteStorage then
                        local makeExplosion = remoteStorage:FindFirstChild("makeExplosion")
                        if makeExplosion then makeExplosion:Destroy() end
                    end
                end
            end
        })

        OhioTabs.by:Button({
            Title = "绕过物品栏封禁",
            Callback = function()
                local devv = ReplicatedStorage:FindFirstChild("devv")
                if devv then
                    local remoteStorage = devv:FindFirstChild("remoteStorage")
                    if remoteStorage then
                        local makeExplosion = remoteStorage:FindFirstChild("makeExplosion")
                        if makeExplosion then makeExplosion:Destroy() end
                    end
                end
            end
        })

        OhioTabs.by:Button({
            Title = "绕过战斗状态",
            Callback = function()
                for _, func in pairs(getgc(true)) do
                    if type(func) == "function" then
                        local info = debug.getinfo(func)
                        if info.name == "isInCombat" or (info.source and info.source:find("combatIndicator")) then
                            hookfunction(func, function() return false end)
                        end
                    end
                end
            end
        })

        -- ========================================
        -- 远程购买 Tab
        -- ========================================

        local buying = false
        local buyConn = nil
        local function hideModel(model, timeout)
            local start = os.clock()
            while os.clock() - start < timeout do
                local allHidden = true
                for _, desc in ipairs(model:GetDescendants()) do
                    local ok = pcall(function()
                        if desc:IsA("BasePart") then
                            desc.Transparency = 1
                            desc.CanCollide = false
                            return desc.Transparency == 1
                        elseif desc:IsA("Decal") or desc:IsA("Texture") then
                            desc.Transparency = 1
                            return desc.Transparency == 1
                        elseif desc:IsA("ParticleEmitter") or desc:IsA("Beam") or desc:IsA("Trail") or desc:IsA("Light") then
                            desc.Enabled = false
                            return not desc.Enabled
                        elseif desc:IsA("BillboardGui") or desc:IsA("SurfaceGui") then
                            desc.Enabled = false
                            return not desc.Enabled
                        elseif desc:IsA("GuiObject") then
                            desc.Visible = false
                            return not desc.Visible
                        elseif desc:IsA("Sound") then
                            desc.Playing = false
                            return not desc.Playing
                        end
                        return true
                    end)
                    if not ok then allHidden = false end
                end
                if allHidden then return true end
                task.wait(0.05)
            end
            return false
        end
        local function stopBuy()
            if buyConn then buyConn:Disconnect() buyConn = nil end
            buying = false
        end
        local function buyItem(itemName, offset, guiName)
            if buying then return end
            buying = true
            local itemsOnSale = Workspace:FindFirstChild("ItemsOnSale")
            if not itemsOnSale then return end
            local itemFolder = itemsOnSale:FindFirstChild(itemName)
            if not itemFolder then return end
            local itemModel = itemFolder:FindFirstChild(itemName)
            if not itemModel then return end
            spawn(function()
                for _ = 1, 100 do
                    local clientModel = itemModel:FindFirstChild("ClientRenderModel")
                    if clientModel then clientModel:Destroy() break end
                    task.wait(0.1)
                end
            end)
            if not itemModel.PrimaryPart then
                local base = itemModel:FindFirstChildWhichIsA("BasePart")
                if base then itemModel.PrimaryPart = base end
            end
            local clickDetector = itemModel:FindFirstChildOfClass("ClickDetector")
            local char = LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not clickDetector or not hrp then return end
            task.wait(0.5)
            hideModel(itemModel, 1)
            itemModel:SetPrimaryPartCFrame(hrp.CFrame * offset)
            pcall(function() fireclickdetector(clickDetector) end)
            buyConn = RunService.Heartbeat:Connect(function()
                if not buying then return end
                char = LocalPlayer.Character
                if not char then return end
                hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
                if playerGui and not playerGui:FindFirstChild(guiName) then
                    stopBuy()
                    return
                end
                if itemModel and itemModel.PrimaryPart and hrp then
                    itemModel:SetPrimaryPartCFrame(hrp.CFrame * offset)
                end
            end)
        end

        OhioTabs.remote:Button({ Title = "Uzi", Callback = function() buyItem("Uzi", CFrame.new(2,-0.5,2), "PurchaseGUI") end })
        OhioTabs.remote:Button({ Title = "Barrett M107", Callback = function() buyItem("Barrett M107", CFrame.new(2,-0.5,2), "PurchaseGUI") end })
        OhioTabs.remote:Button({ Title = "Sawn Off", Callback = function() buyItem("Sawn Off", CFrame.new(2,-0.5,2), "PurchaseGUI") end })
        OhioTabs.remote:Button({ Title = "Lockpick", Callback = function() buyItem("Lockpick", CFrame.new(2,-0.5,2), "PurchaseDialog") end })
        OhioTabs.remote:Button({ Title = "Mossberg", Callback = function() buyItem("Mossberg", CFrame.new(2,-0.5,2), "PurchaseGUI") end })
        OhioTabs.remote:Button({ Title = "Skateboard", Callback = function() buyItem("Skateboard", CFrame.new(2,-0.5,2), "PurchaseGUI") end })
        OhioTabs.remote:Button({ Title = "Scar L", Callback = function() buyItem("Scar L", CFrame.new(2,-0.5,2), "PurchaseGUI") end })
        OhioTabs.remote:Button({ Title = "Double Barrel", Callback = function() buyItem("Double Barrel", CFrame.new(2,-0.5,2), "PurchaseGUI") end })
        OhioTabs.remote:Button({ Title = "Hoverboard", Callback = function() buyItem("Hoverboard", CFrame.new(2,-0.5,2), "PurchaseGUI") end })
        OhioTabs.remote:Button({ Title = "Medium Vest", Callback = function() buyItem("Medium Vest", CFrame.new(2,-0.5,2), "PurchaseGUI") end })

        -- ========================================
        -- 互动 Tab
        -- ========================================

        OhioTabs.instant:Button({
            Title = "银行",
            Callback = function()
                local vaultDoor = Workspace:FindFirstChild("BankRobbery") and Workspace.BankRobbery:FindFirstChild("VaultDoor")
                if vaultDoor then
                    local door = vaultDoor:FindFirstChild("Door")
                    if door then
                        local attachment = door:FindFirstChild("Attachment")
                        if attachment then
                            local prompt = attachment:FindFirstChild("ProximityPrompt")
                            if prompt then
                                prompt.HoldDuration = 0
                                prompt.MaxActivationDistance = 16
                            end
                        end
                    end
                end
                local bankCash = Workspace:FindFirstChild("BankRobbery") and Workspace.BankRobbery:FindFirstChild("BankCash")
                if bankCash then
                    local main = bankCash:FindFirstChild("Main")
                    if main then
                        local attachment = main:FindFirstChild("Attachment")
                        if attachment then
                            local prompt = attachment:FindFirstChild("ProximityPrompt")
                            if prompt then prompt.MaxActivationDistance = 16 end
                        end
                    end
                end
            end
        })

        OhioTabs.instant:Button({
            Title = "金保险",
            Callback = function()
                spawn(function()
                    while true do
                        wait(1)
                        local goldSafe = Workspace:FindFirstChild("Game") and Workspace.Game:FindFirstChild("Entities") and Workspace.Game.Entities:FindFirstChild("GoldJewelSafe")
                        if goldSafe then
                            local safe = goldSafe:FindFirstChild("GoldJewelSafe")
                            if safe then
                                local door = safe:FindFirstChild("Door")
                                if door then
                                    local mesh = door:FindFirstChild("Meshes/LargeSafe_Cube.002_Cube.003_None (1)")
                                    if mesh then
                                        local attachment = mesh:FindFirstChild("Attachment")
                                        if attachment then
                                            local prompt = attachment:FindFirstChild("ProximityPrompt")
                                            if prompt then prompt.HoldDuration = 0 end
                                        end
                                    end
                                end
                                safe.Name = "safeopen"
                            end
                        end
                    end
                end)
            end
        })

        OhioTabs.instant:Button({
            Title = "黑保险",
            Callback = function()
                spawn(function()
                    while true do
                        wait(1)
                        local jewelSafe = Workspace:FindFirstChild("Game") and Workspace.Game:FindFirstChild("Entities") and Workspace.Game.Entities:FindFirstChild("JewelSafe")
                        if jewelSafe then
                            local safe = jewelSafe:FindFirstChild("JewelSafe")
                            if safe then
                                local door = safe:FindFirstChild("Door")
                                if door then
                                    local mesh = door:FindFirstChild("Meshes/LargeSafe_Cube.002_Cube.003_None (1)")
                                    if mesh then
                                        local attachment = mesh:FindFirstChild("Attachment")
                                        if attachment then
                                            local prompt = attachment:FindFirstChild("ProximityPrompt")
                                            if prompt then prompt.HoldDuration = 0 end
                                        end
                                    end
                                end
                                safe.Name = "safeopen"
                            end
                        end
                    end
                end)
            end
        })

        OhioTabs.instant:Button({
            Title = "秒填弹药箱",
            Callback = function()
                local droppables = Workspace:FindFirstChild("Game") and Workspace.Game:FindFirstChild("Local") and Workspace.Game.Local:FindFirstChild("droppables")
                if droppables then
                    for _, obj in ipairs(droppables:GetChildren()) do
                        if obj.Name == "Ammo Box" then
                            local handle = obj:FindFirstChild("Handle")
                            if handle then
                                local prompt = handle:FindFirstChild("ProximityPrompt")
                                if prompt then prompt.HoldDuration = 0 end
                            end
                            obj.Name = "ammoopen"
                        end
                    end
                end
            end
        })

        local holdConn = nil
        OhioTabs.instant:Toggle({
            Title = "全图秒互动",
            Value = false,
            Callback = function(state)
                for _, desc in ipairs(Workspace:GetDescendants()) do
                    if desc:IsA("ProximityPrompt") then
                        desc.HoldDuration = state and 0 or 1
                    end
                end
                if holdConn then holdConn:Disconnect() holdConn = nil end
                if state then
                    holdConn = Workspace.DescendantAdded:Connect(function(desc)
                        if desc:IsA("ProximityPrompt") then desc.HoldDuration = 0 end
                    end)
                end
            end
        })

        local autoGrab = false
        OhioTabs.instant:Toggle({
            Title = "自动互动",
            Value = false,
            Callback = function(state)
                autoGrab = state
                if state then
                    spawn(function()
                        while autoGrab do
                            for _, desc in ipairs(Workspace:GetDescendants()) do
                                if desc:IsA("ProximityPrompt") and desc.Enabled then
                                    local parent = desc.Parent
                                    if parent and parent:IsA("Model") then
                                        local part = parent.PrimaryPart or parent:FindFirstChildWhichIsA("BasePart")
                                        if part and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                            local dist = (part.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                                            if dist <= math.min(desc.MaxActivationDistance, 10) then
                                                pcall(function() fireproximityprompt(desc, true) end)
                                            end
                                        end
                                    end
                                end
                            end
                            task.wait(1)
                        end
                    end)
                end
            end
        })

        -- ========================================
        -- 锁定 Tab
        -- ========================================

        local targetPlayerName = nil
        local targetDropdown = nil
        local function getPlayerNames()
            local names = {}
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer then table.insert(names, plr.Name) end
            end
            table.sort(names)
            return names
        end
        local function refreshPlayerDropdown()
            local names = getPlayerNames()
            if targetDropdown then
                targetDropdown:Refresh(names)
                if targetPlayerName and table.find(names, targetPlayerName) then
                    targetDropdown:SetValue(targetPlayerName)
                else
                    targetDropdown:SetValue("请选择")
                    targetPlayerName = nil
                end
            else
                targetDropdown = OhioTabs.lock:Dropdown({
                    Title = "选择玩家",
                    Values = names,
                    Value = "请选择",
                    Callback = function(val)
                        targetPlayerName = val
                    end
                })
            end
        end
        Players.PlayerAdded:Connect(refreshPlayerDropdown)
        Players.PlayerRemoving:Connect(refreshPlayerDropdown)
        refreshPlayerDropdown()

        OhioTabs.lock:Button({
            Title = "传送到玩家",
            Callback = function()
                if targetPlayerName then
                    local target = Players:FindFirstChild(targetPlayerName)
                    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
                    end
                end
            end
        })

        local attract = false
        local function attractLoop()
            while attract do
                task.wait()
                if targetPlayerName then
                    local target = Players:FindFirstChild(targetPlayerName)
                    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        target.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                    end
                else break end
            end
        end
        OhioTabs.lock:Toggle({
            Title = "吸人",
            Value = false,
            Callback = function(state)
                attract = state
                if state then spawn(attractLoop) end
            end
        })

        local spin = false
        local function spinLoop()
            while spin do
                task.wait(0.1)
                if targetPlayerName then
                    local target = Players:FindFirstChild(targetPlayerName)
                    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = target.Character.HumanoidRootPart
                        hrp.Velocity = Vector3.new(math.random(-100,100), math.random(50,150), math.random(-100,100))
                        hrp.RotVelocity = Vector3.new(math.random(-20,20), math.random(-20,20), math.random(-20,20))
                    end
                else break end
            end
        end
        OhioTabs.lock:Toggle({
            Title = "操逼",
            Value = false,
            Callback = function(state)
                spin = state
                if state then spawn(spinLoop) end
            end
        })

        local lockFollow = false
        local function followLoop()
            while lockFollow do
                task.wait()
                if targetPlayerName then
                    local target = Players:FindFirstChild(targetPlayerName)
                    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character:MoveTo(target.Character.HumanoidRootPart.Position + Vector3.new(0,3,0))
                    end
                else break end
            end
        end
        OhioTabs.lock:Toggle({
            Title = "锁人传送",
            Value = false,
            Callback = function(state)
                lockFollow = state
                if state then spawn(followLoop) end
            end
        })

        OhioTabs.lock:Toggle({
            Title = "持续传送",
            Value = false,
            Callback = function(state)
                if state then
                    spawn(function()
                        while state do
                            if targetPlayerName then
                                local target = Players:FindFirstChild(targetPlayerName)
                                if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                    LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
                                end
                            end
                            task.wait(0.5)
                        end
                    end)
                end
            end
        })

        -- ========================================
        -- 自动 Tab
        -- ========================================

        OhioTabs.auto:Toggle({
            Title = "防挂机",
            Value = false,
            Callback = function(state)
                if state then
                    LocalPlayer.Idled:Connect(function()
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton2(Vector2.new())
                    end)
                end
            end
        })

        local autoPrinter = false
        local function printerLoop()
            while autoPrinter do
                wait(0.1)
                local itemPickup = Workspace:FindFirstChild("Game") and Workspace.Game:FindFirstChild("Entities") and Workspace.Game.Entities:FindFirstChild("ItemPickup")
                if itemPickup then
                    for _, group in ipairs(itemPickup:GetChildren()) do
                        for _, obj in ipairs(group:GetChildren()) do
                            if obj:IsA("MeshPart") or obj:IsA("Part") then
                                for _, prompt in ipairs(obj:GetChildren()) do
                                    if prompt:IsA("ProximityPrompt") and prompt.ObjectText == "Money Printer" then
                                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                            LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                                        end
                                    end
                                end
                            end
                        end
                    end
                    for _, group in ipairs(itemPickup:GetChildren()) do
                        for _, obj in ipairs(group:GetChildren()) do
                            for _, bill in ipairs(obj:GetChildren()) do
                                if bill:IsA("BillboardGui") then bill:Destroy() end
                            end
                        end
                    end
                end
            end
        end
        OhioTabs.auto:Toggle({
            Title = "自动捡印钞机",
            Value = false,
            Callback = function(state)
                autoPrinter = state
                if state then spawn(printerLoop) end
            end
        })

        local autoAirdrop = false
        local airdropConn = nil
        OhioTabs.auto:Toggle({
            Title = "自动捡空投",
            Value = false,
            Callback = function(state)
                if state then
                    airdropConn = RunService.Heartbeat:Connect(function()
                        for _, desc in ipairs(Workspace:GetDescendants()) do
                            if desc:IsA("ProximityPrompt") and desc.ObjectText then
                                local text = desc.ObjectText:lower()
                                if text:match("airdrop") or text:match("airstrike") then
                                    local parent = desc.Parent
                                    if parent and parent:IsA("BasePart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                        LocalPlayer.Character.HumanoidRootPart.CFrame = parent.CFrame * CFrame.new(0,2,0)
                                        desc:InputHoldBegin()
                                        wait(0.1)
                                    end
                                end
                            end
                        end
                    end)
                elseif airdropConn then
                    airdropConn:Disconnect()
                    airdropConn = nil
                end
            end
        })

        local autoNuke = false
        local nukeConn = nil
        OhioTabs.auto:Toggle({
            Title = "自动捡核弹",
            Value = false,
            Callback = function(state)
                if state then
                    nukeConn = RunService.Heartbeat:Connect(function()
                        for _, desc in ipairs(Workspace:GetDescendants()) do
                            if desc:IsA("ProximityPrompt") and desc.ObjectText == "Nuke Launcher" then
                                local parent = desc.Parent
                                if parent and parent:IsA("BasePart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                    LocalPlayer.Character.HumanoidRootPart.CFrame = parent.CFrame * CFrame.new(0,2,0)
                                    desc:InputHoldBegin()
                                    wait(0.1)
                                end
                            end
                        end
                    end)
                elseif nukeConn then
                    nukeConn:Disconnect()
                    nukeConn = nil
                end
            end
        })

        OhioTabs.auto:Button({
            Title = "手动寻打印机",
            Callback = function()
                local itemPickup = Workspace:FindFirstChild("Game") and Workspace.Game:FindFirstChild("Entities") and Workspace.Game.Entities:FindFirstChild("ItemPickup")
                if itemPickup then
                    for _, group in ipairs(itemPickup:GetChildren()) do
                        for _, obj in ipairs(group:GetChildren()) do
                            if obj:IsA("MeshPart") or obj:IsA("Part") then
                                for _, prompt in ipairs(obj:GetChildren()) do
                                    if prompt:IsA("ProximityPrompt") and prompt.ObjectText == "Money Printer" then
                                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                            LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                                            RunService.Heartbeat:Wait()
                                            prompt:InputHoldBegin()
                                            RunService.Heartbeat:Wait(0.1)
                                            prompt:InputHoldEnd()
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        })

        OhioTabs.auto:Button({
            Title = "手动找印钞机(换服务器)",
            Callback = function()
                local function switchServer()
                    local placeId = game.PlaceId
                    local currentJob = game.JobId
                    local cursor = ""
                    while true do
                        local resp = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. cursor))
                        if resp and resp.data then
                            for _, server in ipairs(resp.data) do
                                if server.id ~= currentJob and server.playing < server.maxPlayers then
                                    TeleportService:TeleportToPlaceInstance(placeId, server.id, LocalPlayer)
                                    return
                                end
                            end
                        end
                        cursor = resp.nextPageCursor
                        if not cursor then break end
                    end
                end
                local start = tick()
                while true do
                    wait(0.1)
                    local itemPickup = Workspace:FindFirstChild("Game") and Workspace.Game:FindFirstChild("Entities") and Workspace.Game.Entities:FindFirstChild("ItemPickup")
                    if itemPickup then
                        for _, group in ipairs(itemPickup:GetChildren()) do
                            for _, obj in ipairs(group:GetChildren()) do
                                if obj:IsA("MeshPart") or obj:IsA("Part") then
                                    for _, prompt in ipairs(obj:GetChildren()) do
                                        if prompt:IsA("ProximityPrompt") and prompt.ObjectText == "Money Printer" then
                                            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                                LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        for _, group in ipairs(itemPickup:GetChildren()) do
                            for _, obj in ipairs(group:GetChildren()) do
                                for _, bill in ipairs(obj:GetChildren()) do
                                    if bill:IsA("BillboardGui") then bill:Destroy() end
                                end
                            end
                        end
                    end
                    if tick() - start >= 5 then
                        switchServer()
                        break
                    end
                end
            end
        })

        -- ========================================
        -- 农场 Tab
        -- =======================================

        OhioTabs.farm:Toggle({
            Title = "反挂机(必开)",
            Value = false,
            Callback = function(state)
                if state then
                    loadstring(game:HttpGet("https://pastebin.com/raw/9fFu43FF"))()
                end
            end
        })

        -- ========================================
        -- 刷钱 Tab
        -- ========================================

        local Farming = false
        local FarmConnection = nil

        OhioTabs.f:Toggle({
            Title = "自动刷钱",
            Default = false,
            Callback = function(state)
                Farming = state
                if state then
                    FarmConnection = RunService.Heartbeat:Connect(function()
                        pcall(function()
                            if not LocalPlayer or not LocalPlayer.Character then return end
                            for _, v in ipairs(Workspace:GetDescendants()) do
                                if v:IsA("TouchTransmitter") or (v:IsA("BasePart") and (v.Name:lower():find("collect") or v.Name:lower():find("coin") or v.Name:lower():find("money") or v.Name:lower():find("cash"))) then
                                    pcall(function()
                                        firetouchinterest(v, LocalPlayer.Character.HumanoidRootPart, 0)
                                        firetouchinterest(v, LocalPlayer.Character.HumanoidRootPart, 1)
                                    end)
                                end
                            end
                        end)
                    end)
                else
                    if FarmConnection then
                        FarmConnection:Disconnect()
                        FarmConnection = nil
                    end
                end
            end
        })

        OhioTabs.f:Toggle({
            Title = "自动出售",
            Default = false,
            Callback = function(state)
                if state then
                    task.spawn(function()
                        while state do
                            pcall(function()
                                local Signal = require(ReplicatedStorage.devv).load("Signal")
                                Signal.FireServer("sellAll")
                            end)
                            task.wait(5)
                        end
                    end)
                end
            end
        })

        -- ========================================
        -- 传送 Tab
        -- ========================================

        OhioTabs.t:Toggle({
            Title = "空降",
            Desc = "打开地图 点哪传哪",
            Value = false,
            Callback = function(Value)
                if Value then
                    local MapTiles = ReplicatedStorage:FindFirstChild("Shared") and ReplicatedStorage.Shared:FindFirstChild("MapTiles") or ReplicatedStorage
                    local tiles = {}
                    local tileOrder = {3, 1, 4, 2}
                    local function initTiles()
                        for i = 1, 4 do
                            local tileName = "tile" .. i
                            local tileFolder = MapTiles:FindFirstChild(tileName) or ReplicatedStorage:FindFirstChild(tileName)
                            if tileFolder then
                                local center = tileFolder:FindFirstChild("center")
                                if center then
                                    local mesh = center:FindFirstChild("mesh")
                                    if mesh then
                                        local worldSizeX = mesh.Scale.X
                                        local worldSizeZ = mesh.Scale.Z
                                        tiles[i] = {
                                            index = i,
                                            center = center.CFrame,
                                            invCenter = center.CFrame:Inverse(),
                                            worldSize = Vector3.new(worldSizeX, 0, worldSizeZ),
                                            worldHalfSize = Vector3.new(worldSizeX / 2, 0, worldSizeZ / 2)
                                        }
                                    end
                                end
                            end
                        end
                    end
                    local function isPointInMapFrame(mapFrame, position)
                        local absPos = mapFrame.AbsolutePosition
                        local absSize = mapFrame.AbsoluteSize
                        local guiInset = GuiService:GetGuiInset()
                        local adjusted = position - guiInset
                        return adjusted.X >= absPos.X and adjusted.X <= absPos.X + absSize.X and adjusted.Y >= absPos.Y and adjusted.Y <= absPos.Y + absSize.Y
                    end
                    local function getTile(percentX, percentY)
                        local vx = math.floor(percentX * 2)
                        local vy = math.floor(percentY * 2)
                        local clampedX = math.clamp(vx, 0, 1)
                        local clampedY = math.clamp(vy, 0, 1)
                        return tileOrder[clampedY * 2 + clampedX + 1], clampedX, clampedY
                    end
                    local function getWorldPositionFromPercent(percentX, percentY)
                        local tileIndex, tileX, tileY = getTile(percentX, percentY)
                        local tile = tiles[tileIndex]
                        if tile then
                            local localX = ((percentX - tileX * 0.5) / 0.5 - 0.5) * tile.worldSize.X
                            local localZ = ((percentY - tileY * 0.5) / 0.5 - 0.5) * tile.worldSize.Z
                            return tile.center.Position + tile.center:VectorToWorldSpace(Vector3.new(localX, 0, localZ))
                        end
                        return nil
                    end
                    local function teleportTo(position)
                        local character = LocalPlayer.Character
                        if character then
                            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                            if humanoidRootPart then
                                humanoidRootPart.CFrame = CFrame.new(position.X, position.Y + 50, position.Z)
                            end
                        end
                    end
                    local function findMapHolder()
                        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
                        for _, screenGui in pairs(PlayerGui:GetChildren()) do
                            if screenGui:IsA("ScreenGui") and screenGui.Enabled then
                                local mapFrame = screenGui:FindFirstChild("MapFrame", true)
                                if mapFrame then
                                    local mapHolder = mapFrame:FindFirstChild("MapHolder")
                                    if mapHolder then
                                        local contextFrame = screenGui:FindFirstChild("ContextFrame", true)
                                        if contextFrame and contextFrame.Visible then
                                            return mapHolder, mapFrame
                                        end
                                        if screenGui.Name == "FullMapScreen" then
                                            return mapHolder, mapFrame
                                        end
                                    end
                                end
                            end
                        end
                        return nil, nil
                    end
                    local function getPercentFromClick(mapHolder, mousePosition)
                        local holderSize = Vector2.new(mapHolder.Size.X.Offset, mapHolder.Size.Y.Offset)
                        local uiScale = mapHolder:FindFirstChild("UIScale")
                        local zoom = uiScale and uiScale.Scale or 1
                        local scaledSize = holderSize * zoom
                        local holderPosition = mapHolder.Position
                        local mapOffsetX = holderPosition.X.Offset
                        local mapOffsetY = holderPosition.Y.Offset
                        local mapFrame = mapHolder.Parent
                        local frameAbsPos = mapFrame.AbsolutePosition
                        local frameAbsSize = mapFrame.AbsoluteSize
                        local frameCenter = frameAbsPos + frameAbsSize / 2
                        local adjustedMouse = mousePosition - guiInset
                        local mouseRelativeToCenter = adjustedMouse - frameCenter
                        local clickOffsetX = mouseRelativeToCenter.X - mapOffsetX
                        local clickOffsetY = mouseRelativeToCenter.Y - mapOffsetY
                        local percentX = 0.5 + clickOffsetX / scaledSize.X
                        local percentY = 0.5 + clickOffsetY / scaledSize.Y
                        percentX = math.clamp(percentX, 0, 1)
                        percentY = math.clamp(percentY, 0, 1)
                        return percentX, percentY
                    end
                    local function setupMapClick()
                        local touchState = {
                            active = false,
                            input = nil,
                            pos = nil,
                            percentX = nil,
                            percentY = nil,
                            token = 0
                        }
                        UserInputService.InputBegan:Connect(function(input, gameProcessed)
                            if input.UserInputType == Enum.UserInputType.MouseButton2 then
                                local mapHolder, mapFrame = findMapHolder()
                                if not mapHolder or not mapFrame then return end
                                local mousePos = UserInputService:GetMouseLocation()
                                if not isPointInMapFrame(mapFrame, mousePos) then return end
                                local percentX, percentY = getPercentFromClick(mapHolder, mousePos)
                                local worldPos = getWorldPositionFromPercent(percentX, percentY)
                                if worldPos then
                                    teleportTo(worldPos)
                                end
                            elseif input.UserInputType == Enum.UserInputType.Touch then
                                local mapHolder, mapFrame = findMapHolder()
                                if not mapHolder or not mapFrame then return end
                                local touchPos = Vector2.new(input.Position.X, input.Position.Y) + guiInset
                                if not isPointInMapFrame(mapFrame, touchPos) then return end
                                touchState.active = true
                                touchState.input = input
                                touchState.pos = touchPos
                                local percentX, percentY = getPercentFromClick(mapHolder, touchPos)
                                touchState.percentX = percentX
                                touchState.percentY = percentY
                                touchState.token = touchState.token + 1
                                local currentToken = touchState.token
                                local capturedInput = input
                                task.delay(1.5, function()
                                    if not touchState.active or touchState.input ~= capturedInput or touchState.token ~= currentToken then return end
                                    local holder, frame = findMapHolder()
                                    if not holder or not frame then return end
                                    if not isPointInMapFrame(frame, touchState.pos) then return end
                                    local worldPos = getWorldPositionFromPercent(touchState.percentX, touchState.percentY)
                                    if worldPos then
                                        teleportTo(worldPos)
                                    end
                                end)
                            end
                        end)
                        UserInputService.InputEnded:Connect(function(input, gameProcessed)
                            if input.UserInputType == Enum.UserInputType.Touch and input == touchState.input then
                                touchState.active = false
                                touchState.input = nil
                                touchState.percentX = nil
                                touchState.percentY = nil
                            end
                        end)
                    end
                    initTiles()
                    setupMapClick()
                    WindUI:Notify({
                        Title = "空降",
                        Content = "开启\n移动端请长按进行传送",
                        Icon = "map-pin",
                        Duration = 3
                    })
                else
                    if _G.MapAirDropConnection then
                        _G.MapAirDropConnection:Disconnect()
                        _G.MapAirDropConnection = nil
                    end
                    WindUI:Notify({
                        Title = "空降",
                        Content = "关闭",
                        Icon = "map-pin",
                        Duration = 2
                    })
                end
            end
        })

        OhioTabs.t:Section({ Title = "世界传送", Icon = "map-pin" })

        local teleportLocations = {
            {"银行金库", CFrame.new(-388.7, 617.2, -1153)},
            {"典当行", CFrame.new(-2878, 36.7, 1633)},
            {"军事基地", CFrame.new(-1371.06, 178.68, 3236.76)},
            {"警察局外部", CFrame.new(1579.12, 119.39, -715.22)},
            {"警察局", CFrame.new(1637.2, 123.6, -586.2)},
            {"湾景武器店", CFrame.new(-3277, 39.70, 1849)},
            {"湾景车店", CFrame.new(-3036, 36.91, 1285)},
            {"帮派别墅外武器店", CFrame.new(-7264, 43.50, 1383)},
            {"帮派别墅内艾瑞克", CFrame.new(-7867, 21.39, 1187)},
            {"帮派别墅内b爵士", CFrame.new(-7895, 21.37, 1182)},
            {"帮派别墅内隐秘", CFrame.new(-7837, 21.36, 1050)},
            {"黑帮基地", CFrame.new(-7931, 21.5, 1061.3)},
            {"黑市", CFrame.new(-2910.8, 37.1, 1651.62)},
            {"二倍售卖", CFrame.new(-7892.93, 21.37, 1181.68)},
            {"银行", CFrame.new(-386.96, 620.81, -1195.01)},
            {"警局武器店", CFrame.new(1643, 144.49, -598)},
            {"轮盘", CFrame.new(-1233, 50.39, -2843)},
            {"C4炸弹", CFrame.new(328, 551.59, -1204)},
            {"烈焰要塞空投点", CFrame.new(-1742, 204.01, 3159)}
        }

        for _, loc in ipairs(teleportLocations) do
            OhioTabs.t:Button({
                Title = loc[1],
                Callback = function()
                    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                    HumanoidRootPart.CFrame = loc[2]
                end
            })
        end

        OhioTabs.t:Section({ Title = "武器传送", Icon = "target" })

        local weaponLocations = {
            {"UZI", CFrame.new(-1351.5, 40.2, 2036.68)},
            {"RPG", CFrame.new(-1392.26, 271.9, 3203.12)},
            {"AK-47", CFrame.new(-7838.77, 21.37, 1194.19)},
            {"M4A1", CFrame.new(-6343.96, 134.38, -4329.21)},
            {"贝内利M1014", CFrame.new(1348.13, 141.04, -4808.4)},
            {"UMP45", CFrame.new(1665.2, 143.37, -644.01)},
            {"自动瞄准器", CFrame.new(-822.79, 325.62, -505.92)},
            {"AUG", CFrame.new(-1268.50, 152.62, -2832.19)},
            {"武器店", CFrame.new(-193, 42.9, -2812.6)},
            {"枪店", CFrame.new(-3277.16, 39.7, 1849.02)}
        }

        for _, loc in ipairs(weaponLocations) do
            OhioTabs.t:Button({
                Title = loc[1],
                Callback = function()
                    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                    HumanoidRootPart.CFrame = loc[2]
                end
            })
        end

        OhioTabs.t:Section({ Title = "玩家传送", Icon = "users" })
        local teleportPlayers = {}
        local teleportEnabled = false
        local teleportLoop = nil
        local teleportTarget2 = nil

        local function updateTeleportPlayerList()
            teleportPlayers = {}
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    table.insert(teleportPlayers, player.Name)
                end
            end
        end
        updateTeleportPlayerList()

        local selectedTeleportPlayer = ""

        OhioTabs.t:Dropdown({
            Title = "选择传送玩家",
            Values = teleportPlayers,
            Value = "",
            Callback = function(Value)
                selectedTeleportPlayer = Value
                if Value ~= "" then
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player.Name == Value then
                            teleportTarget2 = player
                            break
                        end
                    end
                else
                    teleportTarget2 = nil
                end
            end
        })

        OhioTabs.t:Button({
            Title = "刷新玩家列表",
            Callback = function()
                updateTeleportPlayerList()
            end
        })

        OhioTabs.t:Button({
            Title = "传送至玩家",
            Callback = function()
                if teleportTarget2 and teleportTarget2.Character then
                    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                    local targetRoot = teleportTarget2.Character:FindFirstChild("HumanoidRootPart")
                    if targetRoot then
                        HumanoidRootPart.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 3)
                        WindUI:Notify({
                            Title = "传送成功",
                            Content = "已传送到 " .. teleportTarget2.Name .. " 附近",
                            Icon = "map-pin",
                            Duration = 3
                        })
                    else
                        WindUI:Notify({
                            Title = "传送失败",
                            Content = "无法找到有效的传送目标位置",
                            Icon = "x",
                            Duration = 3
                        })
                    end
                end
            end
        })

        OhioTabs.t:Toggle({
            Title = "持续传送",
            Value = false,
            Callback = function(Value)
                teleportEnabled = Value
                if Value then
                    if teleportLoop then teleportLoop:Disconnect() end
                    teleportLoop = RunService.Heartbeat:Connect(function()
                        if teleportEnabled and teleportTarget2 and teleportTarget2.Character then
                            local Character = LocalPlayer.Character
                            if Character then
                                local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                                local targetRoot = teleportTarget2.Character:FindFirstChild("HumanoidRootPart")
                                if HumanoidRootPart and targetRoot then
                                    HumanoidRootPart.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 3)
                                end
                            end
                        end
                    end)
                else
                    if teleportLoop then
                        teleportLoop:Disconnect()
                        teleportLoop = nil
                    end
                end
            end
        })

        -- ========================================
        -- 透视 Tab
        -- ========================================

        local espSettings = {
            Enabled = false,
            ShowBox = true,
            BoxType = "2D",
            ShowSkeletons = false,
            ShowHealth = false,
            ShowDistance = false,
            ShowName = false,
            ShowTeam = false,
            TeamCheck = false,
            WallCheck = false,
            ShowTracer = false,
            TracerPosition = "Bottom",
            TracerColor = Color3.new(1, 1, 1),
            SkeletonsColor = Color3.new(1, 1, 1)
        }

        local ESP = (function()
            local a = Players
            local b = RunService
            local c = LocalPlayer
            local d = Camera
            local e = {}
            local TeamColors = {
                ["none"] = Color3.new(1, 1, 1),
                ["syndicate"] = Color3.fromRGB(128, 0, 128),
                ["police"] = Color3.fromRGB(0, 100, 255)
            }
            
            local function getPlayerTeam(player)
                local success, teamName = pcall(function()
                    return player:GetAttribute("currentTeam") or player.currentTeam
                end)
                if success and teamName then
                    return string.lower(tostring(teamName))
                end
                return "none"
            end
            
            local function getTeamColor(player)
                local teamName = getPlayerTeam(player)
                return TeamColors[teamName] or Color3.new(1, 1, 1)
            end
            
            local function isSameTeam(player1, player2)
                local team1 = getPlayerTeam(player1)
                local team2 = getPlayerTeam(player2)
                return team1 == team2
            end
            
            local f = {
                {"Head", "UpperTorso"},
                {"UpperTorso", "RightUpperArm"},
                {"RightUpperArm", "RightLowerArm"},
                {"RightLowerArm", "RightHand"},
                {"UpperTorso", "LeftUpperArm"},
                {"LeftUpperArm", "LeftLowerArm"},
                {"LeftLowerArm", "LeftHand"},
                {"UpperTorso", "LowerTorso"},
                {"LowerTorso", "LeftUpperLeg"},
                {"LeftUpperLeg", "LeftLowerLeg"},
                {"LeftLowerLeg", "LeftFoot"},
                {"LowerTorso", "RightUpperLeg"},
                {"RightUpperLeg", "RightLowerLeg"},
                {"RightLowerLeg", "RightFoot"}
            }
            
            local g = {
                BoxOutlineColor = Color3.new(0, 0, 0),
                BoxColor = Color3.new(1, 1, 1),
                NameColor = Color3.new(1, 1, 1),
                HealthOutlineColor = Color3.new(0, 0, 0),
                HealthHighColor = Color3.new(0, 1, 0),
                HealthLowColor = Color3.new(1, 0, 0),
                CharSize = Vector2.new(4, 6),
                Teamcheck = true,
                WallCheck = false,
                Enabled = true,
                ShowBox = true,
                BoxType = "2D",
                ShowName = false,
                ShowTeam = true,
                ShowHealth = false,
                ShowDistance = false,
                ShowSkeletons = true,
                ShowTracer = false,
                TracerColor = Color3.new(1, 1, 1),
                TracerThickness = 2,
                SkeletonsColor = Color3.new(1, 1, 1),
                TracerPosition = "Bottom"
            }
            
            local function h(i, j)
                local k = Drawing.new(i)
                for l, m in pairs(j) do
                    k[l] = m
                end
                return k
            end
            
            local function n(o)
                local p = {
                    tracer = h("Line", {Thickness = g.TracerThickness, Color = g.TracerColor, Transparency = 0.5}),
                    boxOutline = h("Square", {Color = g.BoxOutlineColor, Thickness = 3, Filled = false}),
                    box = h("Square", {Color = g.BoxColor, Thickness = 1, Filled = false}),
                    name = h("Text", {Color = g.NameColor, Outline = true, Center = true, Size = 13}),
                    healthOutline = h("Line", {Thickness = 3, Color = g.HealthOutlineColor}),
                    health = h("Line", {Thickness = 1}),
                    distance = h("Text", {Color = Color3.new(1, 1, 1), Size = 12, Outline = true, Center = true}),
                    team = h("Text", {Color = Color3.new(1, 1, 1), Size = 11, Outline = true, Center = true}),
                    boxLines = {}
                }
                e[o] = p
                e[o]["skeletonlines"] = {}
            end
            
            local function q(o)
                local r = o.Character
                if not r then return false end
                local s = r:FindFirstChild("HumanoidRootPart")
                if not s then return false end
                local t = Ray.new(d.CFrame.Position, (s.Position - d.CFrame.Position).Unit * (s.Position - d.CFrame.Position).Magnitude)
                local u, v = workspace:FindPartOnRayWithIgnoreList(t, {c.Character, r})
                return u and u:IsA("Part")
            end
            
            local function w(o)
                local p = e[o]
                if not p then return end
                for x, k in pairs(p) do
                    if type(k) == "table" then
                        for _, item in pairs(k) do
                            pcall(function()
                                if item and item.Destroy then
                                    item:Destroy()
                                elseif item and item.Remove then
                                    item:Remove()
                                end
                            end)
                        end
                    else
                        pcall(function()
                            if k and k.Destroy then
                                k:Destroy()
                            elseif k and k.Remove then
                                k:Remove()
                            end
                        end)
                    end
                end
                e[o] = nil
            end
            
            local function y()
                pcall(function()
                    for o, p in pairs(e) do
                        local r = o.Character
                        local sameTeam = g.Teamcheck and isSameTeam(o, c)
                        if r and (not g.Teamcheck or not sameTeam) then
                            local s = r:FindFirstChild("HumanoidRootPart")
                            local A = r:FindFirstChild("Head")
                            local B = r:FindFirstChild("Humanoid")
                            local C = g.WallCheck and q(o)
                            local D = not C and g.Enabled
                            if s and A and B and D then
                                local v, E = d:WorldToViewportPoint(s.Position)
                                if E then
                                    local F = d:WorldToViewportPoint(s.Position)
                                    local G = (d:WorldToViewportPoint(s.Position - Vector3.new(0, 3, 0)).Y - d:WorldToViewportPoint(s.Position + Vector3.new(0, 2.6, 0)).Y) / 2
                                    local H = Vector2.new(math.floor(G * 1.8), math.floor(G * 1.9))
                                    local I = Vector2.new(math.floor(F.X - G * 1.8 / 2), math.floor(F.Y - G * 1.6 / 2))
                                    local teamColor = getTeamColor(o)
                                    
                                    if g.ShowName and g.Enabled then
                                        p.name.Visible = true
                                        p.name.Text = string.lower(o.Name)
                                        p.name.Position = Vector2.new(H.X / 2 + I.X, I.Y - 16)
                                        p.name.Color = teamColor
                                    else
                                        p.name.Visible = false
                                    end
                                    
                                    if g.ShowTeam and g.Enabled then
                                        local teamName = getPlayerTeam(o)
                                        p.team.Visible = true
                                        p.team.Text = "[" .. teamName .. "]"
                                        p.team.Position = Vector2.new(H.X / 2 + I.X, I.Y - (g.ShowName and 28 or 16))
                                        p.team.Color = teamColor
                                    else
                                        p.team.Visible = false
                                    end
                                    
                                    if g.ShowBox and g.Enabled then
                                        local boxSize = Vector2.new(math.floor(G * 1.8), math.floor(G * 1.9))
                                        local boxPos = Vector2.new(math.floor(F.X - G * 1.8 / 2), math.floor(F.Y - G * 1.6 / 2))
                                        p.boxOutline.Visible = true
                                        p.boxOutline.Size = boxSize
                                        p.boxOutline.Position = boxPos
                                        p.box.Visible = true
                                        p.box.Size = boxSize
                                        p.box.Position = boxPos
                                        p.box.Color = teamColor
                                    else
                                        p.boxOutline.Visible = false
                                        p.box.Visible = false
                                    end
                                    
                                    if g.ShowHealth and g.Enabled and B then
                                        local healthPercent = B.Health / B.MaxHealth
                                        local barHeight = math.floor(G * 1.9)
                                        local barX = math.floor(F.X - G * 1.8 / 2) - 6
                                        local barY = math.floor(F.Y - G * 1.6 / 2)
                                        p.healthOutline.Visible = true
                                        p.healthOutline.From = Vector2.new(barX, barY)
                                        p.healthOutline.To = Vector2.new(barX, barY + barHeight)
                                        p.healthOutline.Color = Color3.new(0, 0, 0)
                                        p.health.Visible = true
                                        p.health.From = Vector2.new(barX + 1, barY + barHeight * (1 - healthPercent))
                                        p.health.To = Vector2.new(barX + 1, barY + barHeight)
                                        p.health.Color = healthPercent > 0.5 and g.HealthHighColor or g.HealthLowColor
                                    else
                                        p.healthOutline.Visible = false
                                        p.health.Visible = false
                                    end
                                    
                                    if g.ShowDistance and g.Enabled then
                                        p.distance.Visible = true
                                        local hrp = r:FindFirstChild("HumanoidRootPart")
                                        local dist = hrp and math.floor((hrp.Position - d.CFrame.Position).Magnitude) or 0
                                        p.distance.Text = dist .. " 距离"
                                        p.distance.Position = Vector2.new(H.X / 2 + I.X, I.Y + 14)
                                    else
                                        p.distance.Visible = false
                                    end
                                    
                                    if g.ShowSkeletons and g.Enabled then
                                        for _, pair in ipairs(f) do
                                            local part1 = r:FindFirstChild(pair[1])
                                            local part2 = r:FindFirstChild(pair[2])
                                            if part1 and part2 then
                                                local _, onScreen1 = d:WorldToViewportPoint(part1.Position)
                                                local _, onScreen2 = d:WorldToViewportPoint(part2.Position)
                                                if onScreen1 and onScreen2 then
                                                    local lineIdx = _ - 1
                                                    if not p.skeletonlines[lineIdx] then
                                                        p.skeletonlines[lineIdx] = h("Line", {Thickness = 1, Color = g.SkeletonsColor, Transparency = 0.7})
                                                    end
                                                    local line = p.skeletonlines[lineIdx]
                                                    line.Visible = true
                                                    line.From = Vector2.new(d:WorldToViewportPoint(part1.Position).X, d:WorldToViewportPoint(part1.Position).Y)
                                                    line.To = Vector2.new(d:WorldToViewportPoint(part2.Position).X, d:WorldToViewportPoint(part2.Position).Y)
                                                    line.Color = teamColor
                                                end
                                            end
                                        end
                                    else
                                        for _, line in pairs(p.skeletonlines) do
                                            line.Visible = false
                                        end
                                    end
                                    
                                    if g.ShowTracer and g.Enabled then
                                        p.tracer.Visible = true
                                        local tracerY = g.TracerPosition == "Bottom" and d.ViewportSize.Y or 0
                                        p.tracer.From = Vector2.new(d.ViewportSize.X / 2, tracerY)
                                        p.tracer.To = Vector2.new(F.X, F.Y)
                                        p.tracer.Color = g.TracerColor
                                    else
                                        p.tracer.Visible = false
                                    end
                                else
                                    p.boxOutline.Visible = false
                                    p.box.Visible = false
                                    p.name.Visible = false
                                    p.team.Visible = false
                                    p.healthOutline.Visible = false
                                    p.health.Visible = false
                                    p.distance.Visible = false
                                    p.tracer.Visible = false
                                    for _, line in pairs(p.skeletonlines) do
                                        line.Visible = false
                                    end
                                end
                            end
                        end
                    end
                end)
            end

            Players.PlayerAdded:Connect(function(o)
                n(o)
            end)

            Players.PlayerRemoving:Connect(function(o)
                w(o)
            end)

            for _, o in ipairs(Players:GetPlayers()) do
                if o ~= c then
                    n(o)
                end
            end
            RunService.RenderStepped:Connect(function()
                y()
            end)
                
            OhioTabs.e:Toggle({Title = "启用透视", Default = false, Callback = function(state) espSettings.Enabled = state; g.Enabled = state end})
            OhioTabs.e:Toggle({Title = "显示方框", Default = true, Callback = function(state) espSettings.ShowBox = state; g.ShowBox = state end})
            OhioTabs.e:Toggle({Title = "显示骨骼", Default = false, Callback = function(state) espSettings.ShowSkeletons = state; g.ShowSkeletons = state end})
            OhioTabs.e:Toggle({Title = "显示血量", Default = false, Callback = function(state) espSettings.ShowHealth = state; g.ShowHealth = state end})
            OhioTabs.e:Toggle({Title = "显示距离", Default = false, Callback = function(state) espSettings.ShowDistance = state; g.ShowDistance = state end})
            OhioTabs.e:Toggle({Title = "显示名字", Default = false, Callback = function(state) espSettings.ShowName = state; g.ShowName = state end})
            OhioTabs.e:Toggle({Title = "显示队伍", Default = false, Callback = function(state) espSettings.ShowTeam = state; g.ShowTeam = state end})
            OhioTabs.e:Toggle({Title = "队伍检测", Default = false, Callback = function(state) espSettings.TeamCheck = state; g.Teamcheck = state end})
            OhioTabs.e:Toggle({Title = "穿墙检测", Default = false, Callback = function(state) espSettings.WallCheck = state; g.WallCheck = state end})
            OhioTabs.e:Toggle({Title = "显示追踪线", Default = false, Callback = function(state) espSettings.ShowTracer = state; g.ShowTracer = state end})
        end)()

        -- ========================================
        -- 美化 Tab
        -- ========================================

        local skinsec = "Void"
        local autoskin = false

        OhioTabs.mm:Dropdown({
            Title = "选择美化皮肤",
            Values = { 
                "烟火", "虚空", "纯金", "暗物质", "反物质", "神秘", "虚空神秘", "战术", "纯金战术", 
                "白未来", "黑未来", "圣诞未来", "礼物包装", "猩红", "收割者", "虚空收割者", "圣诞玩具",
                "荒地", "隐形", "像素", "钻石像素", "黄金零下", "绿水晶", "生物", "樱花", "精英", 
                "黑樱花", "彩虹激光", "蓝水晶", "紫水晶", "红水晶", "零下", "虚空射线", "冰冻钻石",
                "虚空梦魇", "金雪", "爱国者", "MM2", "声望", "酷化", "蒸汽", "海盗", "玫瑰", "黑玫瑰",
                "激光", "烟花", "诅咒背瓜", "大炮", "财富", "黄金大炮", "四叶草", "自由", "黑曜石", "赛博朋克"
            },
            Callback = function(Value) 
                local skinMap = {
                    ["烟火"]="Sparkler",["虚空"]="Void",["纯金"]="Solid Gold",["暗物质"]="Dark Matter",
                    ["反物质"]="Anti Matter",["神秘"]="Hystic",["虚空神秘"]="Void Mystic",["战术"]="Tactical",
                    ["纯金战术"]="Solid Gold Tactical",["白未来"]="Future White",["黑未来"]="Future Black",
                    ["圣诞未来"]="Christmas Future",["礼物包装"]="Gift Wrapped",["猩红"]="Crimson Blood",
                    ["收割者"]="Reaper",["虚空收割者"]="Void Reaper",["圣诞玩具"]="Christmas Toy",
                    ["荒地"]="Wasteland",["隐形"]="Invisible",["像素"]="Pixel",["钻石像素"]="Diamond Pixel",
                    ["黄金零下"]="Frozen-Gold",["绿水晶"]="Atomic Nature",["生物"]="Biohazard",["樱花"]="Sakura",
                    ["精英"]="Elite",["黑樱花"]="Death Blossom-Gold",["彩虹激光"]="Rainbowlaser",
                    ["蓝水晶"]="Atomic Water",["紫水晶"]="Atomic Amethyst",["红水晶"]="Atomic Flame",
                    ["零下"]="Sub-Zero",["虚空射线"]="Void-Ray",["冰冻钻石"]="Frozen Diamond",
                    ["虚空梦魇"]="Void Nightmare",["金雪"]="Golden Snow",["爱国者"]="Patriot",
                    ["MM2"]="MM2 Barrett",["声望"]="Prestige Barnett",["酷化"]="Skin Walter",
                    ["蒸汽"]="Steampunk",["海盗"]="Pirate",["玫瑰"]="Rose",["黑玫瑰"]="Black Rose",
                    ["激光"]="Hyperlaser",["烟花"]="Firework",["诅咒背瓜"]="Cursed Pumpkin",
                    ["大炮"]="Cannon",["财富"]="Firework",["黄金大炮"]="Gold Cannon",
                    ["四叶草"]="Lucky Clover",["自由"]="Freedom",["黑曜石"]="Obsidian",["赛博朋克"]="Cyberpunk"
                }
                skinsec = skinMap[Value] or "Void"
            end
        })

        OhioTabs.mm:Toggle({
            Title = "全部枪械美化",
            Value = false,
            Callback = function(start) 
                autoskin = start
                if autoskin then
                    local it = require(ReplicatedStorage.devv).load("v3item").inventory
                    local b1 = require(ReplicatedStorage.devv).load('v3item').inventory.items
                    for i, item in next, b1 do 
                        if item.type == "Gun" then
                            it.skinUpdate(item.name, skinsec)
                        end
                    end
                end
            end
        })
        
        -- ========================================
-- 美化 Tab (追加气球和苦无)
-- ========================================

local items = {
    "Golden Rose", "Black Rose", "Dollar Balloon", "Bat Balloon", "Bunny Balloon", "Clover Balloon",
    "Ghost Balloon", "Gold Clover Balloon", "Heart Balloon", "Skull Balloon", "Snowflake Balloon",
    "Admin AK-47", "Admin Nuke Launcher", "Admin RPG", "Void Gem", "Pulse Rifle", "Unusual Money Printer",
    "Money Printer", "Trident", "NextBot Grenade", "El Fuego", "Kunai", "Spirit Kunai"
}
local itemDisplayNames = {
    ["Golden Rose"] = "金玫瑰", ["Black Rose"] = "黑玫瑰", ["Dollar Balloon"] = "美元气球",
    ["Bat Balloon"] = "蝙蝠气球", ["Bunny Balloon"] = "兔子气球", ["Clover Balloon"] = "三叶草气球",
    ["Ghost Balloon"] = "幽灵气球", ["Gold Clover Balloon"] = "金三叶草气球", ["Heart Balloon"] = "爱心气球",
    ["Skull Balloon"] = "骷髅气球", ["Snowflake Balloon"] = "雪花气球", ["Admin AK-47"] = "管理员黄金AK-47",
    ["Admin Nuke Launcher"] = "管理员核弹发射器", ["Admin RPG"] = "管理员RPG", ["Void Gem"] = "虚空宝石",
    ["Pulse Rifle"] = "脉冲步枪", ["Unusual Money Printer"] = "异常印钞机", ["Money Printer"] = "印钞机",
    ["Trident"] = "三叉戟", ["NextBot Grenade"] = "NextBot手榴弹", ["El Fuego"] = "烈焰喷射器",
    ["Kunai"] = "苦无", ["Spirit Kunai"] = "灵魂苦无"
}
local itemData = {}

itemData["Bat Balloon"] = {name = "Bat Balloon", cost = 0, unpurchasable = true, multiplier = 0.625, holdableType = "Balloon", canDrop = true, dropCooldown = 120, permanent = true, TPSOffsets = {hold = CFrame.new(0, 0, 0)}, viewportOffsets = {hotbar = {dist = 5.5, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, math.pi, 0)}, ammoHUD = {dist = 5, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 0, 0)}}}
itemData["Bunny Balloon"] = {name = "Bunny Balloon", cost = 0, unpurchasable = true, multiplier = 0.61, holdableType = "Balloon", canDrop = true, dropCooldown = 120, permanent = true, TPSOffsets = {hold = CFrame.new(0, 0, 0)}, viewportOffsets = {hotbar = {dist = 4.75, offset = CFrame.new(0, -0.25, 0), rotoffset = CFrame.Angles(0, 4.71238898038469, 0)}, ammoHUD = {dist = 5, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 0, 0)}}}
itemData["Clover Balloon"] = {name = "Clover Balloon", cost = 200, unpurchasable = true, multiplier = 0.625, holdableType = "Balloon", canDrop = true, dropCooldown = 120, permanent = true, TPSOffsets = {hold = CFrame.new(0, 0, 0)}, viewportOffsets = {hotbar = {dist = 5, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 0, 0)}, ammoHUD = {dist = 5, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 0, 0)}}}
itemData["Ghost Balloon"] = {name = "Ghost Balloon", cost = 0, unpurchasable = true, multiplier = 0.625, holdableType = "Balloon", canDrop = true, dropCooldown = 120, permanent = true, TPSOffsets = {hold = CFrame.new(0, 0, 0)}, viewportOffsets = {hotbar = {dist = 3.5, offset = CFrame.new(0, 0.5, 0), rotoffset = CFrame.Angles(0, math.pi, 0)}, ammoHUD = {dist = 5, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 0, 0)}}}
itemData["Gold Clover Balloon"] = {name = "Gold Clover Balloon", cost = 250000, unpurchasable = true, multiplier = 0.6, holdableType = "Balloon", canDrop = true, dropCooldown = 120, permanent = true, TPSOffsets = {hold = CFrame.new(0, 0, 0)}, viewportOffsets = {hotbar = {dist = 5, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 0, 0)}, ammoHUD = {dist = 5, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 0, 0)}}}
itemData["Heart Balloon"] = {name = "Heart Balloon", cost = 200, multiplier = 0.6, holdableType = "Balloon", unpurchasable = true, canDrop = true, dropCooldown = 120, permanent = true, TPSOffsets = {hold = CFrame.new(0, 0, 0)}, viewportOffsets = {hotbar = {dist = 5, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 0, 0)}, ammoHUD = {dist = 5, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 0, 0)}}}
itemData["Skull Balloon"] = {name = "Skull Balloon", cost = 0, unpurchasable = true, multiplier = 0.625, holdableType = "Balloon", canDrop = true, dropCooldown = 120, permanent = true, TPSOffsets = {hold = CFrame.new(0, 0, 0)}, viewportOffsets = {hotbar = {dist = 5.5, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, -270, 0)}, ammoHUD = {dist = 5, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 0, 0)}}}
itemData["Snowflake Balloon"] = {name = "Snowflake Balloon", cost = 0, unpurchasable = true, multiplier = 0.625, holdableType = "Balloon", canDrop = true, dropCooldown = 120, permanent = true, TPSOffsets = {hold = CFrame.new(0, 0, 0)}, viewportOffsets = {hotbar = {dist = 5, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, (math.pi/2), 0)}, ammoHUD = {dist = 5, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 0, 0)}}}
itemData["Golden Rose"] = {name = "Golden Rose", guid = "golden_rose_"..tostring(tick()), permanent = true, canDrop = true, dropCooldown = 120, multiplier = 0.625, holdableType = "Balloon", movespeedAdd = 5, TPSOffsets = {hold = CFrame.new(0, 0.5, 0)}, viewportOffsets = {hotbar = {dist = 3, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, (math.pi/2), 0)}, ammoHUD = {dist = 2, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, -1.3744467859455345, 0)}, slotButton = {dist = 1, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, (-math.pi/2), 0)}}}
itemData["Black Rose"] = {name = "Black Rose", guid = "black_rose_"..tostring(tick()), permanent = true, canDrop = true, dropCooldown = 120, multiplier = 0.75, holdableType = "Balloon", movespeedAdd = 12, TPSOffsets = {hold = CFrame.new(0, 0.5, 0)}, viewportOffsets = {hotbar = {dist = 3, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, (math.pi/2), 0)}, ammoHUD = {dist = 2, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, -1.3744467859455345, 0)}, slotButton = {dist = 1, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, (-math.pi/2), 0)}}}
itemData["Dollar Balloon"] = {name = "Dollar Balloon", cost = 100000000000, unpurchasable = true, multiplier = 0.8, holdableType = "Balloon", movespeedAdd = 8, cannotDiscard = true, TPSOffsets = {hold = CFrame.new(0, 0, 0) * CFrame.Angles(0, math.pi, 0)}, viewportOffsets = {hotbar = {dist = 4, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 0, 0)}, ammoHUD = {dist = 5, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 0, 0)}}}
itemData["Admin AK-47"] = {name = "Admin AK-47", modelName = "Gold AK-47", subtype = "AK-47", adminOnly = true, canDrop = false, unpurchasable = true, damage = 10, ammo = 999999999, startAmmo = -1, maxAmmo = -1, firemode = "auto", numProjectiles = 8, fireDebounce = 0.01}
itemData["Admin Nuke Launcher"] = {name = "Admin Nuke Launcher", modelName = "Nuke Launcher", subtype = "Nuke Launcher", adminOnly = true, canDrop = false, unpurchasable = true, ammo = 99999999, startAmmo = -1, maxAmmo = -1, overrideProjectileProperties = {disableNukeFlash = true}, reloadTime = 0, reloadType = "mag", firemode = "auto", numProjectiles = 1, fireDebounce = 0.2}
itemData["Admin RPG"] = {canDrop = false, unpurchasable = true, name = "Admin RPG", modelName = "RPG", subtype = "RPG", adminOnly = true, ammo = 99999999, startAmmo = -1, maxAmmo = -1, reloadTime = 0, reloadType = "mag", firemode = "auto", numProjectiles = 1, fireDebounce = 0.02, recoilAdd = 0, maxRecoil = 0, recoilDiminishFactor = 0, recoilFastDiminishFactor = 0}
itemData["Void Gem"] = {name = "Void Gem", subtype = "gem", maxAmmo = 3, adminLimit = 1, sellPrice = 25000, canDrop = true, dropCooldown = 300}
itemData["Pulse Rifle"] = {name = "Pulse Rifle", subtype = "Raygun", unpurchasable = true, damage = 22, headshotMultiplier = 1.5, ammo = 50, startAmmo = -1, maxAmmo = -1, reloadTime = 3.5, reloadType = "mag", firemode = "auto", numProjectiles = 1, fireDebounce = 0.04, projectileLength = 20, projectileLifetime = 200, speedDropoff = 0.04, speedMax = 5, baseSpread = 3, baseAimSpread = 0.8, spread = 11, aimSpread = 2.4, recoilAdd = 0.05, maxRecoil = 0.4, recoilDiminishFactor = 0.95, recoilFastDiminishFactor = 0.85}
itemData["Unusual Money Printer"] = {name = "Unusual Money Printer", cost = 500, ammo = 1, startAmmo = -1, maxAmmo = 1, hint = {computer = "Click to Place", console = "Click to Place"}, canDrop = true, dropCooldown = 600, isConsumable = true, TPSOffsets = {hold = CFrame.new(-0.1, 0, -0.75) * CFrame.Angles(0, 0, 0)}, viewportOffsets = {hotbar = {dist = 5, offset = CFrame.new(0, 0.15, 0), rotoffset = CFrame.Angles(0, (-math.pi/2), 0)}, ammoHUD = {dist = 3.25, offset = CFrame.new(0, 1, 0), rotoffset = CFrame.Angles(0, (math.pi/2), 0)}}}
itemData["Money Printer"] = {name = "Money Printer", ammo = 1, startAmmo = -1, maxAmmo = 1, adminLimit = 10, hint = {computer = "Click to Place", console = "Click to Place"}, canDrop = true, dropCooldown = 600, isConsumable = true, permanent = true, TPSOffsets = {hold = CFrame.new(-0.1, 0, -0.75) * CFrame.Angles(0, 0, 0)}, viewportOffsets = {hotbar = {dist = 5, offset = CFrame.new(0, 0.15, 0), rotoffset = CFrame.Angles(0, (-math.pi/2), 0)}, ammoHUD = {dist = 3.25, offset = CFrame.new(0, 1, 0), rotoffset = CFrame.Angles(0, (-math.pi/2), 0)}}}
itemData["Trident"] = {name = "Trident", subtype = "RPG", unpurchasable = true, ammo = 1, startAmmo = 12, maxAmmo = 12, firemode = "semi", numProjectiles = 3, fireDebounce = 0.5, projectileLength = 4, projectileLifetime = 1000, speedDropoff = 0.04, speedMax = 5, baseSpread = 5, baseAimSpread = 1, spread = 10, aimSpread = 6, recoilAdd = 1, maxRecoil = 1.25, recoilDiminishFactor = 0.9, recoilFastDiminishFactor = 0.66}
itemData["NextBot Grenade"] = {name = "NextBot Grenade", isNade = true, bounceSFX = "nadeBounce", canDrop = true, dropCooldown = 600, thrownOffset = CFrame.Angles(0, (math.pi/2), 0), ammo = 1, startAmmo = -1, maxAmmo = 1, permanent = true, throwDist = 50, TPSOffsets = {hold = CFrame.new(-0.1, 0.25, -0.125)}, viewportOffsets = {hotbar = {dist = 2.75, offset = CFrame.new(0, -0.125, 0), rotoffset = CFrame.Angles(0, 1.8849555921538759, 0)}, ammoHUD = {dist = 2, offset = CFrame.new(0, 0.1, 0), rotoffset = CFrame.Angles(0, (math.pi/2), 0)}}}
itemData["El Fuego"] = {name = "El Fuego", modelName = "El Fuego", subtype = "Flamethrower", unpurchasable = true, ammo = 600, startAmmo = 0, maxAmmo = 600, reloadTime = 6, reloadType = "mag", firemode = "auto", damage = 6, numProjectiles = 3, fireDebounce = 0.05, projectileLength = 4, projectileLifetime = 60, speedDropoff = 0.04, speedMax = 5, baseSpread = 4, baseAimSpread = 2, spread = 12, aimSpread = 6, recoilAdd = 0.1, maxRecoil = 1, recoilDiminishFactor = 0.95, recoilFastDiminishFactor = 0.8}
itemData["Kunai"] = {name = "Kunai", permanent = true, canDrop = true, dropCooldown = 120, holdableType = "Kunai", movespeedAdd = 12, TPSOffsets = {hold = CFrame.new(0, -0.3, 0)}, viewportOffsets = {hotbar = {dist = 3, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 1.5707963, 0)}, ammoHUD = {dist = 2, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, -1.3744468, 0)}, slotButton = {dist = 1, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, -1.5707963, 0)}}}
itemData["Spirit Kunai"] = {name = "Spirit Kunai", permanent = true, canDrop = true, dropCooldown = 120, holdableType = "Kunai", movespeedAdd = 12, TPSOffsets = {hold = CFrame.new(0, -0.3, 0)}, viewportOffsets = {hotbar = {dist = 3, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 1.5707963, 0)}, ammoHUD = {dist = 2, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, -1.3744468, 0)}, slotButton = {dist = 1, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, -1.5707963, 0)}}}

local function getItemList()
    local itemList = {}
    for _, itemName in ipairs(items) do
        local displayName = itemDisplayNames[itemName] or itemName
        table.insert(itemList, displayName)
    end
    return itemList
end

local selectedItem = ""
OhioTabs.mm:Dropdown({
    Title = "选择物品",
    Desc = "从列表中选择要获得的物品",
    Values = getItemList(),
    Value = "",
    Callback = function(value)
        if value and value ~= "" then
            selectedItem = value
        else
            selectedItem = ""
        end
    end
})

local function getItemNameByDisplayName(displayName)
    for itemName, dispName in pairs(itemDisplayNames) do
        if dispName == displayName then return itemName end
    end
    return displayName
end

local function addItem(itemName)
    pcall(function()
        local itemSystem = require(ReplicatedStorage.devv).load("v3item")
        local inventory = itemSystem.inventory
        if not itemData[itemName] then return end
        local itemConfig = itemData[itemName]
        local itemToAdd = {
            name = itemConfig.name,
            guid = itemName:lower():gsub(" ", "_").."_"..tostring(tick()),
            permanent = itemConfig.permanent or true,
            canDrop = itemConfig.canDrop or true,
            dropCooldown = itemConfig.dropCooldown or 120,
            multiplier = itemConfig.multiplier or 0.625,
            holdableType = itemConfig.holdableType or "Balloon",
            movespeedAdd = itemConfig.movespeedAdd or 0,
            cannotDiscard = itemConfig.cannotDiscard or false,
            TPSOffsets = itemConfig.TPSOffsets or {hold = CFrame.new(0, 0.5, 0)},
            viewportOffsets = itemConfig.viewportOffsets or {
                hotbar = {dist = 3, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, (math.pi/2), 0)},
                ammoHUD = {dist = 2, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, -1.3744467859455345, 0)},
                slotButton = {dist = 1, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, (-math.pi/2), 0)}
            }
        }
        if itemConfig.subtype then itemToAdd.subtype = itemConfig.subtype end
        if itemConfig.modelName then itemToAdd.modelName = itemConfig.modelName end
        if itemConfig.adminOnly then itemToAdd.adminOnly = itemConfig.adminOnly end
        if itemConfig.damage then itemToAdd.damage = itemConfig.damage end
        if itemConfig.ammo then itemToAdd.ammo = itemConfig.ammo end
        if itemConfig.startAmmo then itemToAdd.startAmmo = itemConfig.startAmmo end
        if itemConfig.maxAmmo then itemToAdd.maxAmmo = itemConfig.maxAmmo end
        if itemConfig.reloadTime then itemToAdd.reloadTime = itemConfig.reloadTime end
        if itemConfig.reloadType then itemToAdd.reloadType = itemConfig.reloadType end
        if itemConfig.firemode then itemToAdd.firemode = itemConfig.firemode end
        if itemConfig.numProjectiles then itemToAdd.numProjectiles = itemConfig.numProjectiles end
        if itemConfig.fireDebounce then itemToAdd.fireDebounce = itemConfig.fireDebounce end
        if itemConfig.projectileLength then itemToAdd.projectileLength = itemConfig.projectileLength end
        if itemConfig.projectileLifetime then itemToAdd.projectileLifetime = itemConfig.projectileLifetime end
        if itemConfig.headshotMultiplier then itemToAdd.headshotMultiplier = itemConfig.headshotMultiplier end
        if itemConfig.hint then itemToAdd.hint = itemConfig.hint end
        if itemConfig.isConsumable then itemToAdd.isConsumable = itemConfig.isConsumable end
        if itemConfig.isNade then itemToAdd.isNade = itemConfig.isNade end
        if itemConfig.throwDist then itemToAdd.throwDist = itemConfig.throwDist end
        if itemConfig.sellPrice then itemToAdd.sellPrice = itemConfig.sellPrice end
        if itemConfig.adminLimit then itemToAdd.adminLimit = itemConfig.adminLimit end
        if itemConfig.overrideProjectileProperties then itemToAdd.overrideProjectileProperties = itemConfig.overrideProjectileProperties end
        if itemConfig.recoilAdd then itemToAdd.recoilAdd = itemConfig.recoilAdd end
        if itemConfig.maxRecoil then itemToAdd.maxRecoil = itemConfig.maxRecoil end
        if itemConfig.recoilDiminishFactor then itemToAdd.recoilDiminishFactor = itemConfig.recoilDiminishFactor end
        if itemConfig.recoilFastDiminishFactor then itemToAdd.recoilFastDiminishFactor = itemConfig.recoilFastDiminishFactor end
        if inventory.add then
            inventory.add(itemToAdd, false)
            if inventory.currentItemsData then
                table.insert(inventory.currentItemsData, itemToAdd)
            end
        end
        if inventory.rerender then
            inventory:rerender()
        end
    end)
end

OhioTabs.mm:Button({
    Title = "免费获得选择的物品",
    Callback = function()
        if selectedItem and selectedItem ~= "" then
            local itemName = getItemNameByDisplayName(selectedItem)
            if itemName then
                addItem(itemName)
                WindUI:Notify({
                    Title = "物品已添加",
                    Content = selectedItem,
                    Duration = 2
                })
            end
        end
    end
})

OhioTabs.mm:Button({
    Title = "美化美元(需普通气球)",
    Callback = function()
        for _, v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v, "name") == "Balloon" and rawget(v, "holdableType") == "Balloon" then
                v.name, v.cost, v.unpurchasable, v.multiplier, v.movespeedAdd, v.cannotDiscard = "Dollar Balloon", 200, true, 0.8, 8, true
                if v.TPSOffsets then v.TPSOffsets.hold = CFrame.new(0, 0, 0) * CFrame.Angles(0, math.pi, 0) end
                if v.viewportOffsets and v.viewportOffsets.hotbar then v.viewportOffsets.hotbar.dist = 4 end
                v.canDrop, v.dropCooldown, v.craft = nil
                break
            end
        end
        for _, item in pairs(require(ReplicatedStorage.devv.client.Objects.v3item.modules.inventory).items) do
            if item.name == "Dollar Balloon" then
                for _, btn in pairs({item.button, item.backpackButton}) do
                    if btn and btn.resetModelSkin then btn:resetModelSkin() end
                end
            end
        end
        WindUI:Notify({Title = "美化成功", Content = "气球已变为美元气球", Duration = 2})
    end
})

OhioTabs.mm:Button({
    Title = "美化黑玫瑰(需普通气球)",
    Callback = function()
        for _, v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v, "name") == "Balloon" and rawget(v, "holdableType") == "Balloon" then
                v.name, v.cost, v.unpurchasable, v.multiplier, v.movespeedAdd, v.cannotDiscard = "Black Rose", 200, true, 0.75, 12, true
                if v.TPSOffsets then v.TPSOffsets.hold = CFrame.new(0, 0.5, 0) end
                if v.viewportOffsets and v.viewportOffsets.hotbar then v.viewportOffsets.hotbar.dist = 3 end
                v.canDrop, v.dropCooldown, v.craft = nil
                break
            end
        end
        for _, item in pairs(require(ReplicatedStorage.devv.client.Objects.v3item.modules.inventory).items) do
            if item.name == "Black Rose" then
                for _, btn in pairs({item.button, item.backpackButton}) do
                    if btn and btn.resetModelSkin then btn:resetModelSkin() end
                end
            end
        end
        WindUI:Notify({Title = "美化成功", Content = "气球已变为黑玫瑰", Duration = 2})
    end
})

OhioTabs.mm:Button({
    Title = "美化Kunai(需普通气球)",
    Callback = function()
        for _, v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v, "name") == "Balloon" and rawget(v, "holdableType") == "Balloon" then
                v.name = "Kunai"
                v.permanent = true
                v.canDrop = true
                v.dropCooldown = 120
                v.holdableType = "Balloon"
                v.movespeedAdd = 12
                if v.TPSOffsets then v.TPSOffsets.hold = CFrame.new(0, -0.3, 0)
                else v.TPSOffsets = {hold = CFrame.new(0, -0.3, 0)} end
                if v.viewportOffsets then
                    if v.viewportOffsets.hotbar then
                        v.viewportOffsets.hotbar.dist = 3
                        v.viewportOffsets.hotbar.offset = CFrame.new(0, 0, 0)
                        v.viewportOffsets.hotbar.rotoffset = CFrame.Angles(0, 1.5707963, 0)
                    else
                        v.viewportOffsets.hotbar = {dist = 3, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 1.5707963, 0)}
                    end
                    if v.viewportOffsets.ammoHUD then
                        v.viewportOffsets.ammoHUD.dist = 2
                        v.viewportOffsets.ammoHUD.offset = CFrame.new(-0.1, -0.2, 0)
                        v.viewportOffsets.ammoHUD.rotoffset = CFrame.Angles(0, -1.3744468, 0)
                    else
                        v.viewportOffsets.ammoHUD = {dist = 2, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, -1.3744468, 0)}
                    end
                    if v.viewportOffsets.slotButton then
                        v.viewportOffsets.slotButton.dist = 1
                        v.viewportOffsets.slotButton.offset = CFrame.new(-0.1, -0.2, 0)
                        v.viewportOffsets.slotButton.rotoffset = CFrame.Angles(0, -1.5707963, 0)
                    else
                        v.viewportOffsets.slotButton = {dist = 1, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, -1.5707963, 0)}
                    end
                else
                    v.viewportOffsets = {
                        hotbar = {dist = 3, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 1.5707963, 0)},
                        ammoHUD = {dist = 2, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, -1.3744468, 0)},
                        slotButton = {dist = 1, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, -1.5707963, 0)}
                    }
                end
                break
            end
        end
        for _, item in pairs(require(ReplicatedStorage.devv.client.Objects.v3item.modules.inventory).items) do
            if item.name == "Kunai" then
                for _, btn in pairs({item.button, item.backpackButton}) do
                    if btn and btn.resetModelSkin then btn:resetModelSkin() end
                end
            end
        end
        WindUI:Notify({Title = "美化成功", Content = "气球已变为Kunai", Duration = 2})
    end
})

OhioTabs.mm:Button({
    Title = "美化Spirit Kunai(需普通Kunai)",
    Callback = function()
        for _, v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v, "name") == "Kunai" and rawget(v, "holdableType") == "Kunai" then
                v.name = "Spirit Kunai"
                v.permanent = true
                v.canDrop = true
                v.dropCooldown = 120
                v.holdableType = "Kunai"
                v.movespeedAdd = 12
                if v.TPSOffsets then v.TPSOffsets.hold = CFrame.new(0, -0.3, 0)
                else v.TPSOffsets = {hold = CFrame.new(0, -0.3, 0)} end
                if v.viewportOffsets then
                    if v.viewportOffsets.hotbar then
                        v.viewportOffsets.hotbar.dist = 3
                        v.viewportOffsets.hotbar.offset = CFrame.new(0, 0, 0)
                        v.viewportOffsets.hotbar.rotoffset = CFrame.Angles(0, 1.5707963, 0)
                    else
                        v.viewportOffsets.hotbar = {dist = 3, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 1.5707963, 0)}
                    end
                    if v.viewportOffsets.ammoHUD then
                        v.viewportOffsets.ammoHUD.dist = 2
                        v.viewportOffsets.ammoHUD.offset = CFrame.new(-0.1, -0.2, 0)
                        v.viewportOffsets.ammoHUD.rotoffset = CFrame.Angles(0, -1.3744468, 0)
                    else
                        v.viewportOffsets.ammoHUD = {dist = 2, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, -1.3744468, 0)}
                    end
                    if v.viewportOffsets.slotButton then
                        v.viewportOffsets.slotButton.dist = 1
                        v.viewportOffsets.slotButton.offset = CFrame.new(-0.1, -0.2, 0)
                        v.viewportOffsets.slotButton.rotoffset = CFrame.Angles(0, -1.5707963, 0)
                    else
                        v.viewportOffsets.slotButton = {dist = 1, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, -1.5707963, 0)}
                    end
                else
                    v.viewportOffsets = {
                        hotbar = {dist = 3, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 1.5707963, 0)},
                        ammoHUD = {dist = 2, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, -1.3744468, 0)},
                        slotButton = {dist = 1, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, -1.5707963, 0)}
                    }
                end
                break
            end
        end
        for _, item in pairs(require(ReplicatedStorage.devv.client.Objects.v3item.modules.inventory).items) do
            if item.name == "Spirit Kunai" then
                for _, btn in pairs({item.button, item.backpackButton}) do
                    if btn and btn.resetModelSkin then btn:resetModelSkin() end
                end
            end
        end
        WindUI:Notify({Title = "美化成功", Content = "Kunai已变为Spirit Kunai", Duration = 2})
    end
})

        -- ========================================
        -- UI设置 Tab
        -- ========================================

        OhioTabs.ui:Toggle({
            Title = "自定义光标",
            Value = false,
            Callback = function(Value)
                Window:ToggleCustomCursor(Value)
            end
        })

        OhioTabs.ui:Dropdown({
            Title = "通知位置",
            Values = { "左", "右" },
            Value = "右",
            Callback = function(Value)
                WindUI:SetNotifySide(Value == "左" and "Left" or "Right")
            end
        })

        OhioTabs.ui:Dropdown({
            Title = "DPI缩放",
            Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
            Value = "100%",
            Callback = function(Value)
                local dpiValue = tonumber(Value:gsub("%%", ""))
                if not dpiValue then return end
                Window:SetDPIScale(dpiValue / 100)
            end
        })

        OhioTabs.ui:Keybind({
            Title = "菜单按键",
            Value = "RightShift",
            Callback = function(v)
                Window:SetToggleKey(Enum.KeyCode[v])
            end
        })

        local originalOnDestroy2 = Window.OnDestroy or function() end
        Window.OnDestroy = function(...)
            originalOnDestroy2(...)
            dartCleanupConnections()
            if dartNinjaStarBuyThread then
                dartNinjaStarBuyThread:Disconnect()
                dartNinjaStarBuyThread = nil
            end
            if dartTeleportConn then
                dartTeleportConn:Disconnect()
                dartTeleportConn = nil
            end
            if dartTeleportCheckConn then
                dartTeleportCheckConn:Disconnect()
                dartTeleportCheckConn = nil
            end
        end

        if WindUI and WindUI.Notify then
            WindUI:Notify({
                Title = "Ohio已加载", 
                Content = "", 
                Duration = 3
            })
        end
    end
})

Tabs.sbcnm:Section({
    Title = "通缉", 
    TextXAlignment = "Left", 
    TextSize = 17
})

local allowedServerIds = {
    "14438406081",
}

local function GetCurrentServerId()
    local success, id = pcall(function()
        return tostring(game.PlaceId)
    end)
    if success and id then
        return id
    end
    return nil
end

local function CheckServerId()
    local currentId = GetCurrentServerId()
    if not currentId then
        if WindUI and WindUI.Notify then
            WindUI:Notify({
                Title = "加载失败", 
                Content = "无法获取ID", 
                Duration = 3
            })
        end
        return false
    end
    
    for _, allowedId in ipairs(allowedServerIds) do
        if currentId == allowedId then
            return true
        end
    end
    
    if WindUI and WindUI.Notify then
        WindUI:Notify({
            Title = "服务器不符", 
            Content = "当前ID: " .. currentId, 
            Duration = 3
        })
    end
    return false
end

local isLoaded = false

Tabs.sbcnm:Button({
    Title = "通缉",
    Callback = function()
        if isLoaded then
            if WindUI and WindUI.Notify then
                WindUI:Notify({
                    Title = "重复点击！", 
                    Content = "", 
                    Duration = 3
                })
            end
            return
        end
        
        if not CheckServerId() then
            return
        end
        
        isLoaded = true
        
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local RunService = game:GetService("RunService")
        local TweenService = game:GetService("TweenService")
        
        local F = WindUI
        local J = Window
        
        local oldRequire = require
        getgenv().require = function(module)
            if typeof(module) == "Instance" and module.Name == "ClientValidate" then
                return {
                    _realStep = function() end,
                    _cheatStep = function() end,
                    Initialize = function() end
                }
            end
            return oldRequire(module)
        end

        local _seFuncCache = setmetatable({}, { __mode = "k" })
        local _seTableCache = setmetatable({}, { __mode = "k" })
        local _seNoop = function() end
        local _seReplacementValidator = {
            _realStep = _seNoop,
            _cheatStep = _seNoop,
            Initialize = _seNoop,
        }

        local function patchGC()
            local count = 0
            for _, v in ipairs(getgc()) do
                count += 1
                if count % 500 == 0 then
                    task.wait()
                end
                local t = type(v)
                if t == "table" then
                    if not _seTableCache[v] then
                        if rawget(v, "_realStep") and rawget(v, "Initialize") then
                            v._realStep = _seNoop
                            v._cheatStep = _seNoop
                            v.Initialize = _seNoop
                            _seTableCache[v] = true
                        else
                            _seTableCache[v] = false
                        end
                    end
                elseif t == "function" then
                    local cached = _seFuncCache[v]
                    if cached == nil then
                        local ok, info = pcall(debug.getinfo, v)
                        if ok and info and info.source and info.source:find("ClientValidate") and (info.name == "_realStep" or info.name == "Initialize") then
                            _seFuncCache[v] = true
                        else
                            _seFuncCache[v] = false
                        end
                        cached = _seFuncCache[v]
                    end
                    if cached then
                        local ok, ups = pcall(debug.getupvalues, v)
                        if ok and ups then
                            for i, up in ipairs(ups) do
                                local upt = type(up)
                                if upt == "boolean" and up == true then
                                    pcall(debug.setupvalue, v, i, false)
                                elseif upt == "table" and up._realStep and up._realStep ~= _seNoop then
                                    pcall(debug.setupvalue, v, i, _seReplacementValidator)
                                end
                            end
                        end
                    end
                end
            end
        end

        local function hookNetwork()
            local devv = ReplicatedStorage:FindFirstChild("Devv")
            if not devv then return end
            local success, result = pcall(function() return require(devv) end)
            if not success or not result then return end
            local blocked = {
                exploitDetected = true,
                reportPlayer = true,
            }
            local function wrapFire(originalFn, mod)
                if not originalFn or rawget(mod, "_seFireWrapped") then return originalFn end
                rawset(mod, "_seFireWrapped", true)
                return function(a, b, ...)
                    if a == mod then
                        if blocked[b] then return end
                        return originalFn(b, ...)
                    end
                    if blocked[a] then return end
                    return originalFn(a, b, ...)
                end
            end
            local function patchModule(mod)
                if type(mod) ~= "table" then return end
                if mod.FireServer and not rawget(mod, "_seFireWrapped") then
                    local oldFire = mod.FireServer
                    mod.FireServer = wrapFire(oldFire, mod)
                end
            end
            if type(result) == "table" then
                local already
                pcall(function() already = result.load and result.load("Network") end)
                if already then patchModule(already) end
            end
            if result.load and not rawget(result, "_seLoadWrapped") then
                rawset(result, "_seLoadWrapped", true)
                local oldLoad = result.load
                result.load = function(name)
                    local mod = oldLoad(name)
                    if name == "Network" then patchModule(mod) end
                    return mod
                end
            end
        end

        local _seConnFuncCache = setmetatable({}, { __mode = "k" })
        local _seDisabledConns = setmetatable({}, { __mode = "k" })

        local function killHeartbeat()
            for _, conn in ipairs(getconnections(RunService.Heartbeat)) do
                if not _seDisabledConns[conn] then
                    local func = conn.Function
                    if func then
                        local cached = _seConnFuncCache[func]
                        if cached == nil then
                            local ok, info = pcall(debug.getinfo, func)
                            if ok and info then
                                local hit = false
                                if info.source and (info.source:find("ClientValidate") or info.source:find("Wanted")) then
                                    hit = true
                                elseif info.name and (info.name == "_realStep" or info.name == "v_u_1._realStep") then
                                    hit = true
                                end
                                _seConnFuncCache[func] = hit
                                cached = hit
                            else
                                _seConnFuncCache[func] = false
                                cached = false
                            end
                        end
                        if cached then
                            pcall(function() conn:Disable() end)
                            _seDisabledConns[conn] = true
                        end
                    end
                end
            end
        end

        local function protectInstances()
            local illegal = { "BodyVelocity", "BodyForce", "BodyPosition", "VectorForce", "AlignPosition" }
            local function protect(char)
                if not char then return end
                for _, inst in ipairs(char:GetDescendants()) do
                    if table.find(illegal, inst.ClassName) then
                        pcall(function() inst:SetAttribute("protected", true) end)
                    end
                end
                char.DescendantAdded:Connect(function(inst)
                    if table.find(illegal, inst.ClassName) then
                        pcall(function() inst:SetAttribute("protected", true) end)
                    end
                end)
            end
            if LocalPlayer.Character then
                protect(LocalPlayer.Character)
            end
            LocalPlayer.CharacterAdded:Connect(protect)
        end

        pcall(patchGC)
        pcall(hookNetwork)
        pcall(killHeartbeat)
        pcall(protectInstances)

        task.spawn(function()
            task.wait(0.5)
            pcall(patchGC)
            pcall(killHeartbeat)
            pcall(hookNetwork)
            while true do
                task.wait(5)
                pcall(patchGC)
                pcall(killHeartbeat)
                pcall(hookNetwork)
            end
        end)

        if not getgenv()._seNamecallHooked then
            getgenv()._seNamecallHooked = true
            local oldNamecall
            oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local method = getnamecallmethod()
                if (method == "FireServer" or method == "InvokeServer")
                    and typeof(self) == "Instance"
                    and (self:IsA("RemoteEvent") or self:IsA("RemoteFunction") or self:IsA("UnreliableRemoteEvent")) then
                    local info = debug.getinfo(2)
                    if info and info.source and (info.source:find("ClientValidate") or info.source:find("ReportDialog")) then
                        return nil
                    end
                end
                return oldNamecall(self, ...)
            end)
        end

        local Tabs = {}
        do
            Tabs.Main = Window:Tab({ Title = "主要功能", Icon = "solar:hamburger-menu-bold", IconShape = "Square"})
            Tabs.Teleport = Window:Tab({ Title = "传送", Icon = "solar:password-minimalistic-input-bold", IconShape = "Square"})
            Tabs.Visual = Window:Tab({ Title = "视觉功能", Icon = "solar:check-square-bold", IconShape = "Square", IconColor = Color3.fromHex("#ECA201") })
            Tabs.Weather = Window:Tab({ Title = "天气控制", Icon = "solar:file-text-bold", IconShape = "Square"})
            Tabs.PlayerInfo = Window:Tab({ Title = "玩家信息", Icon = "users", IconShape = "Square", IconColor = Color3.fromHex("#FF6B6B")})
            Tabs.UISettings = Window:Tab({ Title = "UI设置", Icon = "solar:info-square-bold", IconShape = "Square"})
        end

        local adminDetectInitialized = false
        local AdminDetected = {}
        local isAlertActive = false
        local alertToken = 0
        local soundEndedConn = nil

        local function G()
            if _G.D then return end
            _G.D = true
            local H = Instance.new("Sound")
            H.SoundId = "rbxassetid://90157211359035"
            H.Looped = true
            H.Volume = 0.5
            H.Parent = game:GetService("SoundService")
            H:Play()
            _G.E = H
            if soundEndedConn then
                soundEndedConn:Disconnect()
            end
            soundEndedConn = H.Ended:Connect(function()
                if not isAlertActive then
                    I()
                end
            end)
        end

        local function I()
            if soundEndedConn then
                soundEndedConn:Disconnect()
                soundEndedConn = nil
            end
            if _G.E then
                pcall(function()
                    _G.E.Looped = false
                    _G.E:Stop()
                    _G.E:Destroy()
                end)
                _G.E = nil
            end
            _G.D = false
        end

        local function sendAdminAlert(K)
            if isAlertActive then return end
            isAlertActive = true
            alertToken += 1
            local currentToken = alertToken
            I()
            G()
            local success, err = pcall(function()
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "特殊人员️",
                    Text = "特殊人员: HXMyyds541" .. K,
                    Duration = 15,
                    Button1 = "退出",
                    Button2 = "留下",
                    Callback = function(M)
                        if M == 1 then
                            LocalPlayer:Kick("已检测到管理员 " .. K .. "，选择退出服务器")
                        end
                        I()
                        isAlertActive = false
                        alertToken += 1
                    end,
                    Icon = ""
                })
            end)
            if not success then
                isAlertActive = false
                return
            end
            task.delay(15, function()
                if currentToken ~= alertToken then return end
                if isAlertActive then
                    I()
                    isAlertActive = false
                    alertToken += 1
                end
            end)
        end

        local function N(O)
            if O == LocalPlayer then return end
            if AdminDetected[O.UserId] then return end
            local P, Q = pcall(function()
                return O:GetRankInGroup(4856485)
            end)
            if P and Q and Q > 0 then
                AdminDetected[O.UserId] = true
                sendAdminAlert(O.Name)
            end
        end

        for _, O in pairs(Players:GetPlayers()) do
            if O ~= LocalPlayer then
                N(O)
            end
        end

        Players.PlayerAdded:Connect(function(O)
            wait(1)
            N(O)
        end)

        Players.PlayerRemoving:Connect(function(O)
            if AdminDetected[O.UserId] then
                AdminDetected[O.UserId] = nil
            end
        end)

        Tabs.Main:Section({ Title = "主要功能", Icon = "move" })
        local flyEnabled = false
        local nowe = false
        local tpwalking = false
        local flyspeed = 50
        local SpinningEnabled = false
        local SpinSpeed = 5
        local CurrentAO, CurrentMoverAttachment

        local function setupBodyMovers(character)
            local hrp = character:WaitForChild("HumanoidRootPart")
            local moverParent = workspace:FindFirstChildOfClass("Terrain") or workspace
            local moverAttachment = Instance.new("Attachment", hrp)
            moverAttachment.Name = "FlightAttachment"
            local alignOrientation = Instance.new('AlignOrientation')
            alignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
            alignOrientation.RigidityEnabled = true
            alignOrientation.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            alignOrientation.CFrame = hrp.CFrame
            alignOrientation.Attachment0 = moverAttachment
            alignOrientation.Parent = moverParent
            return alignOrientation, moverAttachment
        end

        local function startSpinning()
            if SpinningEnabled then return end
            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            if not character then return end
            SpinningEnabled = true
            if CurrentAO then CurrentAO:Destroy() end
            if CurrentMoverAttachment then CurrentMoverAttachment:Destroy() end
            CurrentAO, CurrentMoverAttachment = setupBodyMovers(character)
            local spinConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if not SpinningEnabled or not CurrentAO then
                    if spinConnection then
                        spinConnection:Disconnect()
                        spinConnection = nil
                    end
                    return
                end
                local targetPart = character.Humanoid.SeatPart or character.HumanoidRootPart
                local spinCFrame = targetPart.CFrame * CFrame.Angles(0, math.rad(SpinSpeed), 0)
                CurrentAO.CFrame = spinCFrame
                if character.HumanoidRootPart then
                    character.Humanoid.PlatformStand = true
                end
            end)
            character.AncestryChanged:Connect(function(_, parent)
                if not parent and SpinningEnabled then
                    stopSpinning()
                end
            end)
        end

        local function stopSpinning()
            if not SpinningEnabled then return end
            SpinningEnabled = false
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                character.Humanoid.PlatformStand = false
            end
            if CurrentAO then
                CurrentAO:Destroy()
                CurrentAO = nil
            end
            if CurrentMoverAttachment then
                CurrentMoverAttachment:Destroy()
                CurrentMoverAttachment = nil
            end
        end

        Tabs.Main:Toggle({
            Title = "旋转(躲头部自瞄)",
            Value = false,
            Callback = function(v)
                if v then
                    SpinningEnabled = true
                    startSpinning()
                else
                    SpinningEnabled = false
                    stopSpinning()
                end
            end
        })

        Tabs.Main:Slider({
            Title = "旋转速度",
            Value = {
                Min = 1,
                Max = 50,
                Default = 5
            },
            Callback = function(value)
                SpinSpeed = value
            end
        })

        Tabs.Main:Toggle({
            Title = "飞行",
            Value = false,
            Callback = function(isEnabled)
                local speeds = 1
                flyEnabled = isEnabled
                if isEnabled then
                    local speaker = Players.LocalPlayer
                    local chr = speaker.Character
                    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                    nowe = true
                    for i = 1, speeds do
                        task.spawn(function()
                            local hb = game:GetService("RunService").Heartbeat
                            tpwalking = true
                            local chr = speaker.Character
                            local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                            while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                                if hum.MoveDirection.Magnitude > 0 then
                                    chr:TranslateBy(hum.MoveDirection)
                                end
                            end
                        end)
                    end
                    speaker.Character.Animate.Disabled = true
                    local Char = speaker.Character
                    local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")
                    for i,v in next, Hum:GetPlayingAnimationTracks() do
                        v:AdjustSpeed(0)
                    end
                    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
                    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
                    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
                    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
                    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
                    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
                    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
                    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
                    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
                    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
                    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
                    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
                    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
                    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
                    speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
                    speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
                    if speaker.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
                        local plr = speaker
                        local torso = plr.Character.Torso
                        local flying = true
                        local deb = true
                        local ctrl = {f = 0, b = 0, l = 0, r = 0}
                        local lastctrl = {f = 0, b = 0, l = 0, r = 0}
                        local speed = 0
                        local bg = Instance.new("BodyGyro", torso)
                        bg.P = 9e4
                        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                        bg.cframe = torso.CFrame
                        local bv = Instance.new("BodyVelocity", torso)
                        bv.velocity = Vector3.new(0, 0.1, 0)
                        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
                        plr.Character.Humanoid.PlatformStand = true
                        task.spawn(function()
                            local input = game:GetService("UserInputService")
                            local camera = workspace.CurrentCamera
                            while nowe and speaker.Character.Humanoid.Health > 0 do
                                game:GetService("RunService").RenderStepped:Wait()
                                local forward = 0
                                local backward = 0
                                local left = 0
                                local right = 0
                                local up = 0
                                local down = 0
                                if input:IsKeyDown(Enum.KeyCode.W) then forward = 1 end
                                if input:IsKeyDown(Enum.KeyCode.S) then backward = 1 end
                                if input:IsKeyDown(Enum.KeyCode.A) then left = 1 end
                                if input:IsKeyDown(Enum.KeyCode.D) then right = 1 end
                                if input:IsKeyDown(Enum.KeyCode.Space) then up = 1 end
                                if input:IsKeyDown(Enum.KeyCode.LeftShift) then down = 1 end
                                ctrl = {f = forward, b = backward, l = left, r = right}
                                if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 or up ~= 0 or down ~= 0 then
                                    speed = speed + 0.5 + (speed / flyspeed)
                                    if speed > flyspeed then
                                        speed = flyspeed
                                    end
                                elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 or up ~= 0 or down ~= 0) and speed ~= 0 then
                                    speed = speed - 1
                                    if speed < 0 then
                                        speed = 0
                                    end
                                end
                                local camCF = camera.CFrame
                                local moveVector = Vector3.new(0, 0, 0)
                                if ctrl.f + ctrl.b ~= 0 or ctrl.l + ctrl.r ~= 0 then
                                    moveVector = moveVector + (camCF.LookVector * (ctrl.f - ctrl.b))
                                    moveVector = moveVector + (camCF.RightVector * (ctrl.r - ctrl.l))
                                    moveVector = moveVector * speed
                                end
                                if up ~= 0 then
                                    moveVector = moveVector + Vector3.new(0, speed, 0)
                                end
                                if down ~= 0 then
                                    moveVector = moveVector + Vector3.new(0, -speed, 0)
                                end
                                if moveVector.Magnitude > 0 then
                                    bv.Velocity = moveVector
                                    lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
                                elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and up == 0 and down == 0 and speed ~= 0 then
                                    bv.Velocity = Vector3.new(0, 0, 0)
                                end
                                bg.CFrame = camera.CFrame
                            end
                            ctrl = {f = 0, b = 0, l = 0, r = 0}
                            lastctrl = {f = 0, b = 0, l = 0, r = 0}
                            speed = 0
                            if bg then bg:Destroy() end
                            if bv then bv:Destroy() end
                            if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                                plr.Character.Humanoid.PlatformStand = false
                            end
                        end)
                    end
                    if speaker.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R15 then
                        local plr = speaker
                        local root = plr.Character:FindFirstChild("HumanoidRootPart")
                        local flying = true
                        local ctrl = {f = 0, b = 0, l = 0, r = 0, u = 0, d = 0}
                        local lastctrl = {f = 0, b = 0, l = 0, r = 0, u = 0, d = 0}
                        local speed = 0
                        local bg = Instance.new("BodyGyro", root)
                        bg.P = 9e4
                        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                        bg.cframe = root.CFrame
                        local bv = Instance.new("BodyVelocity", root)
                        bv.Velocity = Vector3.new(0, 0.1, 0)
                        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                        plr.Character.Humanoid.PlatformStand = true
                        task.spawn(function()
                            local input = game:GetService("UserInputService")
                            local camera = workspace.CurrentCamera
                            while nowe and speaker.Character.Humanoid.Health > 0 do
                                game:GetService("RunService").RenderStepped:Wait()
                                local forward = 0
                                local backward = 0
                                local left = 0
                                local right = 0
                                local up = 0
                                local down = 0
                                if input:IsKeyDown(Enum.KeyCode.W) then forward = 1 end
                                if input:IsKeyDown(Enum.KeyCode.S) then backward = 1 end
                                if input:IsKeyDown(Enum.KeyCode.A) then left = 1 end
                                if input:IsKeyDown(Enum.KeyCode.D) then right = 1 end
                                if input:IsKeyDown(Enum.KeyCode.Space) then up = 1 end
                                if input:IsKeyDown(Enum.KeyCode.LeftShift) then down = 1 end
                                ctrl = {f = forward, b = backward, l = left, r = right, u = up, d = down}
                                if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 or ctrl.u ~= 0 or ctrl.d ~= 0 then
                                    speed = speed + 0.5 + (speed / flyspeed)
                                    if speed > flyspeed then
                                        speed = flyspeed
                                    end
                                elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 or ctrl.u ~= 0 or ctrl.d ~= 0) and speed ~= 0 then
                                    speed = speed - 1
                                    if speed < 0 then
                                        speed = 0
                                    end
                                end
                                local camCF = camera.CFrame
                                local moveVector = Vector3.new(0, 0, 0)
                                if ctrl.f + ctrl.b ~= 0 or ctrl.l + ctrl.r ~= 0 then
                                    moveVector = moveVector + (camCF.LookVector * (ctrl.f - ctrl.b))
                                    moveVector = moveVector + (camCF.RightVector * (ctrl.r - ctrl.l))
                                    moveVector = moveVector * speed
                                end
                                if ctrl.u ~= 0 then
                                    moveVector = moveVector + Vector3.new(0, speed, 0)
                                end
                                if ctrl.d ~= 0 then
                                    moveVector = moveVector + Vector3.new(0, -speed, 0)
                                end
                                if moveVector.Magnitude > 0 then
                                    bv.Velocity = moveVector
                                    lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r, u = ctrl.u, d = ctrl.d}
                                elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and ctrl.u == 0 and ctrl.d == 0 and speed ~= 0 then
                                    bv.Velocity = Vector3.new(0, 0, 0)
                                end
                                bg.CFrame = camera.CFrame
                            end
                            ctrl = {f = 0, b = 0, l = 0, r = 0, u = 0, d = 0}
                            lastctrl = {f = 0, b = 0, l = 0, r = 0, u = 0, d = 0}
                            speed = 0
                            if bg then bg:Destroy() end
                            if bv then bv:Destroy() end
                            if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                                plr.Character.Humanoid.PlatformStand = false
                            end
                        end)
                    end
                else
                    nowe = false
                    tpwalking = false
                    local speaker = Players.LocalPlayer
                    if speaker.Character and speaker.Character:FindFirstChild("Humanoid") then
                        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
                        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
                        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, true)
                        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
                        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
                        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
                        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, true)
                        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
                        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, true)
                        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
                        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
                        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true)
                        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, true)
                        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
                        speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
                        speaker.Character.Animate.Disabled = false
                    end
                end
                speaker.CharacterAdded:Connect(function(char)
                    task.wait(0.7)
                    if speaker.Character and speaker.Character:FindFirstChild("Humanoid") then
                        speaker.Character.Humanoid.PlatformStand = false
                        speaker.Character.Animate.Disabled = false
                    end
                end)
            end
        })

        Tabs.Main:Slider({
            Title = "飞行速度",
            Value = {
                Min = 1,
                Max = 200,
                Default = 50,
            },
            Callback = function(Value)
                flyspeed = Value
            end
        })

        local TeleportWalkEnabled = false
        local TeleportWalkConnection = nil
        local TeleportWalkSpeed = 30

        Tabs.Main:Toggle({
            Title = "加速",
            Value = false,
            Callback = function(Value)
                TeleportWalkEnabled = Value
                if Value then
                    TeleportWalkConnection = game:GetService("RunService").Heartbeat:Connect(function()
                        if TeleportWalkEnabled then
                            local Character = LocalPlayer.Character
                            if Character then
                                local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
                                local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                                if Humanoid and HumanoidRootPart and Humanoid.MoveDirection.Magnitude > 0 then
                                    local MoveDirection = Humanoid.MoveDirection
                                    HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + MoveDirection * TeleportWalkSpeed
                                end
                            end
                        end
                    end)
                else
                    if TeleportWalkConnection then
                        TeleportWalkConnection:Disconnect()
                        TeleportWalkConnection = nil
                    end
                end
            end
        })

        Tabs.Main:Slider({
            Title = "速度",
            Value = {
                Min = 5,
                Max = 100,
                Default = 30,
            },
            Callback = function(Value)
                TeleportWalkSpeed = Value
            end
        })

        local JumpConnection
        Tabs.Main:Toggle({
            Title = "无限跳",
            Value = false,
            Callback = function(Value)
                if Value then
                    local UserInputService = game:GetService("UserInputService")
                    JumpConnection = UserInputService.JumpRequest:Connect(function()
                        local Character = LocalPlayer.Character
                        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                        if Humanoid then
                            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        end
                    end)
                else
                    if JumpConnection then
                        JumpConnection:Disconnect()
                        JumpConnection = nil
                    end
                end
            end
        })

        local ForceLoadAll = false
        Tabs.Main:Toggle({
            Title = "强制加载所有数据",
            Default = ForceLoadAll,
            Callback = function(v)
                ForceLoadAll = v
                if v then
                    task.spawn(function()
                        local ReplicatedStorage = game:GetService("ReplicatedStorage")
                        local DevvModule = ReplicatedStorage:FindFirstChild("Devv")
                        if not DevvModule then return end
                        local devv = require(DevvModule)
                        local Network = devv.load("Network")
                        if not Network then return end
                        local RunService = game:GetService("RunService")
                        local function loadArea(position, radius)
                            if RunService:IsClient() then
                                pcall(function()
                                    LocalPlayer:RequestStreamAroundAsync(position, 1)
                                end)
                            end
                        end
                        local function loadAllGizmos()
                            local White = workspace:FindFirstChild("Local") and workspace.Local:FindFirstChild("Gizmos")
                            if White then
                                for _,gizmo in ipairs(White:GetChildren()) do
                                    if gizmo:IsA("Model") and gizmo.PrimaryPart then
                                        loadArea(gizmo.PrimaryPart.Position, 50)
                                        task.wait(0.1)
                                    end
                                end
                            end
                        end
                        local function loadAllPlayers()
                            for _,player in ipairs(Players:GetPlayers()) do
                                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                    loadArea(player.Character.HumanoidRootPart.Position, 50)
                                    task.wait(0.1)
                                end
                            end
                        end
                        while ForceLoadAll do
                            loadAllGizmos()
                            loadAllPlayers()
                            loadArea(Vector3.new(0,0,0), 1000)
                            loadArea(Vector3.new(1000,0,1000), 1000)
                            loadArea(Vector3.new(-1000,0,-1000), 1000)
                            loadArea(Vector3.new(1000,0,-1000), 1000)
                            loadArea(Vector3.new(-1000,0,1000), 1000)
                            task.wait(5)
                        end
                    end)
                end
            end
        })

        local AutoBankCash = false

        Tabs.Main:Toggle({
            Title = "自动抢银行",
            Default = AutoBankCash,
            Callback = function(v)
                AutoBankCash = v
                if v then
                    task.spawn(function()
                        local function GetRootPart()
                            local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                            return Character:WaitForChild("HumanoidRootPart", 5)
                        end
                        while AutoBankCash do
                            local RootPart = GetRootPart()
                            local White = workspace:FindFirstChild("Local") and workspace.Local:FindFirstChild("Gizmos")
                            if White and RootPart and White:FindFirstChild("MainBankCash") and AutoBankCash then
                                local Item = White.MainBankCash
                                local Target = Item.PrimaryPart or Item:FindFirstChildWhichIsA("BasePart", true)
                                if Target then
                                    RootPart.CFrame = Target.CFrame * CFrame.new(0, 0, -2.5)
                                    task.wait(0.2)
                                    while AutoBankCash and White:FindFirstChild("MainBankCash") do
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)
                                        task.wait(0.05)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game)
                                        task.wait(0.5)
                                    end
                                end
                            end
                            task.wait(0.5)
                        end
                    end)
                end
            end
        })

        Tabs.Main:Section({ Title = "光环", Icon = "circle" })

        local ATMHaloFlag = false
        local ATMHaloConnection = nil

        Tabs.Main:Toggle({
            Title = "ATM光环",
            Value = false,
            Callback = function(Value)
                if Value then
                    ATMHaloFlag = true
                    local rep = game:GetService("ReplicatedStorage")
                    local plr = game:GetService("Players").LocalPlayer
                    local Network = require(rep.Shared.Core.Network)
                    local function getAllATMs()
                        local atms = {}
                        local gizmoFolder = workspace.Local.Gizmos
                        if not gizmoFolder then return atms end
                        for _, obj in ipairs(gizmoFolder:GetChildren()) do
                            if obj.Name == "ATM" and obj:GetAttribute("gizmoType") == "ATM" then
                                local metalPart = obj:FindFirstChild("Metal")
                                local hitPart = metalPart or obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                                if hitPart then
                                    table.insert(atms, {
                                        Instance = obj,
                                        Part = hitPart,
                                        Position = hitPart.Position,
                                        Id = obj:GetAttribute("objectId")
                                    })
                                end
                            end
                        end
                        return atms
                    end
                    ATMHaloConnection = task.spawn(function()
                        while ATMHaloFlag do
                            local atms = getAllATMs()
                            for _, atm in ipairs(atms) do
                                if not ATMHaloFlag then break end
                                if atm.Id and atm.Part then
                                    local hitPart = atm.Part
                                    local hitPos = hitPart.Position
                                    Network.FireServer(
                                        "registerMeleeHits",
                                        {{
                                            normal = Vector3.new(0, 0, 0),
                                            direction = Vector3.new(0, 0, 0),
                                            source = {
                                                sourceType = "Melee"
                                            },
                                            id = atm.Id,
                                            material = Enum.Material.Metal,
                                            position = hitPos,
                                            gizmoType = "ATM",
                                            processedPlayerId = plr.UserId,
                                            hit = hitPart,
                                            speed = 0,
                                            collisionPoint = hitPos,
                                            hitName = hitPart.Name,
                                            hitType = "gizmo"
                                        }}
                                    )
                                end
                            end
                            task.wait(0.05)
                        end
                    end)
                else
                    ATMHaloFlag = false
                    if ATMHaloConnection then
                        task.cancel(ATMHaloConnection)
                        ATMHaloConnection = nil
                    end
                end
            end
        })

        local AutoGift = false
        local AutoGiftConnection = nil

        Tabs.Main:Toggle({
            Title = "礼盒光环",
            Value = false,
            Callback = function(Value)
                if Value then
                    AutoGift = true
                    local ReplicatedStorage = game:GetService("ReplicatedStorage")
                    local RunService = game:GetService("RunService")
                    local Devv = nil
                    local NetworkModule = nil
                    pcall(function()
                        Devv = require(ReplicatedStorage:WaitForChild("Devv", 5))
                        if Devv then
                            NetworkModule = Devv.load("Network")
                        end
                    end)
                    local Config = {
                        Enabled = true,
                        Range = 29,
                        Interval = 0.2,
                    }
                    local GiftMeshIds = {
                        "rbxassetid://113102284301343",
                        "rbxassetid://103625160606249",
                        "rbxassetid://119188107372240",
                    }
                    local function GetLootItems()
                        local items = {}
                        local gizmosFolder = workspace:FindFirstChild("Local")
                        if gizmosFolder then
                            gizmosFolder = gizmosFolder:FindFirstChild("Gizmos")
                        end
                        if not gizmosFolder then return items end
                        for _, folder in pairs(gizmosFolder:GetChildren()) do
                            for _, model in pairs(folder:GetChildren()) do
                                if model:IsA("Model") and model.PrimaryPart then
                                    local objectId = model:GetAttribute("objectId")
                                    local gizmoType = model:GetAttribute("gizmoType")
                                    if objectId then
                                        table.insert(items, {
                                            model = model,
                                            objectId = objectId,
                                            gizmoType = gizmoType,
                                            name = model.Name,
                                            position = model.PrimaryPart.Position
                                        })
                                    end
                                end
                            end
                        end
                        return items
                    end
                    local function GetCharacterPosition()
                        local char = LocalPlayer.Character
                        if char and char.PrimaryPart then
                            return char.PrimaryPart.Position
                        end
                        return nil
                    end
                    local function IsGift(model)
                        if not model then return false end
                        for _, part in pairs(model:GetDescendants()) do
                            if part:IsA("MeshPart") then
                                for _, meshId in pairs(GiftMeshIds) do
                                    if part.MeshId == meshId then return true end
                                end
                            end
                            if part:IsA("SpecialMesh") then
                                for _, meshId in pairs(GiftMeshIds) do
                                    if part.MeshId == meshId then return true end
                                end
                            end
                        end
                        return false
                    end
                    local function ShouldPickup(item)
                        return IsGift(item.model)
                    end
                    local function GetDistance(item)
                        local charPos = GetCharacterPosition()
                        if not charPos then return math.huge end
                        if item.position then
                            return (charPos - item.position).Magnitude
                        end
                        return math.huge
                    end
                    local function TryPickup(item)
                        if not item or not item.objectId then return false end
                        if NetworkModule then
                            pcall(function()
                                local gizmoType = item.gizmoType
                                if gizmoType == "WorldItem" or gizmoType == "Loot" then
                                    NetworkModule.InvokeServer("collectLoot", item.objectId)
                                else
                                    NetworkModule.FireServer("gizmoInteraction", item.objectId, "GetTool")
                                end
                            end)
                        else
                            local char = LocalPlayer.Character
                            if char and char.PrimaryPart then
                                local root = char.PrimaryPart
                                root.CFrame = CFrame.new(item.position) * CFrame.new(0, 0, -2.5)
                                task.wait(0.1)
                                local vim = game:GetService("VirtualInputManager")
                                vim:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                                task.wait(0.05)
                                vim:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                            end
                        end
                        return true
                    end
                    local LastPickupTime = 0
                    local function AutoPickupLoop()
                        if not AutoGift then return end
                        local now = tick()
                        if now - LastPickupTime < Config.Interval then return end
                        local charPos = GetCharacterPosition()
                        if not charPos then return end
                        local items = GetLootItems()
                        for _, item in pairs(items) do
                            if not AutoGift then break end
                            local distance = GetDistance(item)
                            if distance <= Config.Range and ShouldPickup(item) then
                                LastPickupTime = now
                                local success = TryPickup(item)
                                if success then
                                    task.wait(0.1)
                                end
                                break
                            end
                        end
                    end
                    AutoGiftConnection = RunService.Heartbeat:Connect(AutoPickupLoop)
                else
                    AutoGift = false
                    if AutoGiftConnection then
                        AutoGiftConnection:Disconnect()
                        AutoGiftConnection = nil
                    end
                end
            end
        })

        local UniversalHaloFlag = false
        local UniversalHaloConnection = nil

        Tabs.Main:Toggle({
            Title = "通用拾取光环（独家)",
            Desc = "开启后就不要单独开启某光环",
            Value = false,
            Callback = function(Value)
                if Value then
                    UniversalHaloFlag = true
                    UniversalHaloConnection = game:GetService("RunService").Heartbeat:Connect(function()
                        if not UniversalHaloFlag then
                            if UniversalHaloConnection then
                                UniversalHaloConnection:Disconnect()
                                UniversalHaloConnection = nil
                            end
                            return
                        end
                        for _, v in pairs(workspace.Local.Gizmos:GetDescendants()) do
                            local objId = v:GetAttribute("objectId")
                            if objId and v:GetAttribute("gizmoType") then
                                require(game:GetService("ReplicatedStorage").Devv).load("Network").InvokeServer("collectLoot", objId)
                            end
                        end
                    end)
                else
                    UniversalHaloFlag = false
                    if UniversalHaloConnection then
                        UniversalHaloConnection:Disconnect()
                        UniversalHaloConnection = nil
                    end
                end
            end
        })

        local GoldSilverHalo = false
        local GoldSilverConnection = nil

        Tabs.Main:Toggle({
            Title = "黄金/白银光环",
            Value = false,
            Callback = function(Value)
                if Value then
                    GoldSilverHalo = true
                    local ReplicatedStorage = game:GetService("ReplicatedStorage")
                    local RunService = game:GetService("RunService")
                    local Devv = require(ReplicatedStorage:WaitForChild("Devv", 5))
                    local NetworkModule = Devv.load("Network")
                    local Config = {
                        Enabled = true,
                        Range = 29,
                        Interval = 0.2,
                    }
                    local GiftMeshIds = {
                        "rbxassetid://14365333965",
                    }
                    local function MatchesGiftMeshId(meshId)
                        if not meshId then return false end
                        for _, targetId in ipairs(GiftMeshIds) do
                            if meshId == targetId then return true end
                        end
                        return false
                    end
                    local function HasGiftMesh(instance)
                        if not instance then return false end
                        if instance:IsA("MeshPart") and MatchesGiftMeshId(instance.MeshId) then
                            return true
                        end
                        for _, descendant in ipairs(instance:GetDescendants()) do
                            if descendant:IsA("MeshPart") and MatchesGiftMeshId(descendant.MeshId) then
                                return true
                            end
                            if descendant:IsA("SpecialMesh") and MatchesGiftMeshId(descendant.MeshId) then
                                return true
                            end
                        end
                        return false
                    end
                    local function GetLootItems()
                        local items = {}
                        local gizmosFolder = workspace:FindFirstChild("Local")
                        if gizmosFolder then
                            gizmosFolder = gizmosFolder:FindFirstChild("Gizmos")
                        end
                        if not gizmosFolder then return items end
                        for _, v in pairs(gizmosFolder:GetDescendants()) do
                            if v:IsA("Model") and v.PrimaryPart then
                                local objectId = v:GetAttribute("objectId")
                                if objectId then
                                    table.insert(items, {
                                        model = v,
                                        objectId = objectId,
                                        name = v.Name,
                                        position = v.PrimaryPart.Position
                                    })
                                end
                            end
                        end
                        return items
                    end
                    local function GetCharacterPosition()
                        local char = LocalPlayer.Character
                        if char and char.PrimaryPart then
                            return char.PrimaryPart.Position
                        end
                        return nil
                    end
                    local function ShouldPickup(item)
                        return HasGiftMesh(item.model)
                    end
                    local function GetDistance(item)
                        local charPos = GetCharacterPosition()
                        if not charPos then return math.huge end
                        if item.position then
                            return (charPos - item.position).Magnitude
                        end
                        return math.huge
                    end
                    local function TryPickup(item)
                        if not item or not item.objectId then return false end
                        pcall(function()
                            NetworkModule.InvokeServer("collectLoot", item.objectId)
                        end)
                    end
                    local LastPickupTime = 0
                    local function AutoPickupLoop()
                        if not GoldSilverHalo then return end
                        local now = tick()
                        if now - LastPickupTime < Config.Interval then return end
                        local charPos = GetCharacterPosition()
                        if not charPos then return end
                        local items = GetLootItems()
                        for _, item in pairs(items) do
                            local distance = GetDistance(item)
                            if distance <= Config.Range and ShouldPickup(item) then
                                LastPickupTime = now
                                TryPickup(item)
                                return
                            end
                        end
                    end
                    GoldSilverConnection = RunService.Heartbeat:Connect(function()
                        if GoldSilverHalo then
                            AutoPickupLoop()
                        else
                            if GoldSilverConnection then
                                GoldSilverConnection:Disconnect()
                                GoldSilverConnection = nil
                            end
                        end
                    end)
                else
                    GoldSilverHalo = false
                    if GoldSilverConnection then
                        GoldSilverConnection:Disconnect()
                        GoldSilverConnection = nil
                    end
                end
            end
        })

        local SapphireHalo = false
        local SapphireConnection = nil

        Tabs.Main:Toggle({
            Title = "蓝宝石光环",
            Value = false,
            Callback = function(Value)
                if Value then
                    SapphireHalo = true
                    local ReplicatedStorage = game:GetService("ReplicatedStorage")
                    local RunService = game:GetService("RunService")
                    local Devv = require(ReplicatedStorage:WaitForChild("Devv", 5))
                    local NetworkModule = Devv.load("Network")
                    local Config = {
                        Enabled = true,
                        Range = 29,
                        Interval = 0.2,
                    }
                    local function IsShappsire(model)
                        if not model then return false end
                        if model.Name == "Sapphire" then return true end
                        for _, part in pairs(model:GetDescendants()) do
                            if part.Name == "Sapphire" then return true end
                        end
                        return false
                    end
                    local function GetLootItems()
                        local items = {}
                        local gizmosFolder = workspace:FindFirstChild("Local")
                        if gizmosFolder then
                            gizmosFolder = gizmosFolder:FindFirstChild("Gizmos")
                        end
                        if not gizmosFolder then return items end
                        for _, v in pairs(gizmosFolder:GetDescendants()) do
                            if v:IsA("Model") and v.PrimaryPart then
                                local objectId = v:GetAttribute("objectId")
                                if objectId then
                                    table.insert(items, {
                                        model = v,
                                        objectId = objectId,
                                        name = v.Name,
                                        position = v.PrimaryPart.Position
                                    })
                                end
                            end
                        end
                        return items
                    end
                    local function GetCharacterPosition()
                        local char = LocalPlayer.Character
                        if char and char.PrimaryPart then
                            return char.PrimaryPart.Position
                        end
                        return nil
                    end
                    local function GetDistance(item)
                        local charPos = GetCharacterPosition()
                        if not charPos then return math.huge end
                        if item.position then
                            return (charPos - item.position).Magnitude
                        end
                        return math.huge
                    end
                    local function TryPickup(item)
                        if not item or not item.objectId then return false end
                        pcall(function()
                            NetworkModule.InvokeServer("collectLoot", item.objectId)
                        end)
                    end
                    local LastPickupTime = 0
                    local function AutoPickupLoop()
                        if not SapphireHalo then return end
                        local now = tick()
                        if now - LastPickupTime < Config.Interval then return end
                        local charPos = GetCharacterPosition()
                        if not charPos then return end
                        local items = GetLootItems()
                        for _, item in pairs(items) do
                            local distance = GetDistance(item)
                            if distance <= Config.Range and IsShappsire(item.model) then
                                LastPickupTime = now
                                TryPickup(item)
                                return
                            end
                        end
                    end
                    SapphireConnection = RunService.Heartbeat:Connect(function()
                        if SapphireHalo then
                            AutoPickupLoop()
                        else
                            if SapphireConnection then
                                SapphireConnection:Disconnect()
                                SapphireConnection = nil
                            end
                        end
                    end)
                else
                    SapphireHalo = false
                    if SapphireConnection then
                        SapphireConnection:Disconnect()
                        SapphireConnection = nil
                    end
                end
            end
        })

        Tabs.Main:Section({ Title = "传送", Icon = "move-vertical" })

        local AutoGoldBar = false
        local AutoGoldConnection = nil

        Tabs.Main:Toggle({
            Title = "金条",
            Value = false,
            Callback = function(Value)
                if Value then
                    AutoGoldBar = true
                    local function GetRootPart()
                        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                        return Character:WaitForChild("HumanoidRootPart", 5)
                    end
                    AutoGoldConnection = game:GetService("RunService").Heartbeat:Connect(function()
                        if not AutoGoldBar then
                            if AutoGoldConnection then
                                AutoGoldConnection:Disconnect()
                                AutoGoldConnection = nil
                            end
                            return
                        end
                        local RootPart = GetRootPart()
                        local White = workspace:FindFirstChild("Local") and workspace.Local:FindFirstChild("Gizmos")
                        if White and RootPart then
                            for _, Item in ipairs(White:GetChildren()) do
                                if Item.Name == "Gold Bar" and AutoGoldBar then
                                    local Target = Item.PrimaryPart or Item:FindFirstChildWhichIsA("BasePart", true)
                                    if Target then
                                        RootPart.CFrame = Target.CFrame * CFrame.new(0, 0, -2.5)
                                        task.wait(0.2)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)
                                        task.wait(0.05)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game)
                                        repeat
                                            task.wait(0.1)
                                        until not Item.Parent or not AutoGoldBar
                                    end
                                end
                            end
                        end
                    end)
                else
                    AutoGoldBar = false
                    if AutoGoldConnection then
                        AutoGoldConnection:Disconnect()
                        AutoGoldConnection = nil
                    end
                end
            end
        })

        local AutoSilverBar = false
        local AutoSilverConnection = nil

        Tabs.Main:Toggle({
            Title = "银条",
            Value = false,
            Callback = function(Value)
                if Value then
                    AutoSilverBar = true
                    local function GetRootPart()
                        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                        return Character:WaitForChild("HumanoidRootPart", 5)
                    end
                    AutoSilverConnection = game:GetService("RunService").Heartbeat:Connect(function()
                        if not AutoSilverBar then
                            if AutoSilverConnection then
                                AutoSilverConnection:Disconnect()
                                AutoSilverConnection = nil
                            end
                            return
                        end
                        local RootPart = GetRootPart()
                        local White = workspace:FindFirstChild("Local") and workspace.Local:FindFirstChild("Gizmos")
                        if White and RootPart then
                            for _, Item in ipairs(White:GetChildren()) do
                                if Item.Name == "Silver Bar" and AutoSilverBar then
                                    local Target = Item.PrimaryPart or Item:FindFirstChildWhichIsA("BasePart", true)
                                    if Target then
                                        RootPart.CFrame = Target.CFrame * CFrame.new(0, 0, -2.5)
                                        task.wait(0.2)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)
                                        task.wait(0.05)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game)
                                        repeat
                                            task.wait(0.1)
                                        until not Item.Parent or not AutoSilverBar
                                    end
                                end
                            end
                        end
                    end)
                else
                    AutoSilverBar = false
                    if AutoSilverConnection then
                        AutoSilverConnection:Disconnect()
                        AutoSilverConnection = nil
                    end
                end
            end
        })

        local AutoSapphire = false

        Tabs.Main:Toggle({
            Title = "蓝宝石",
            Value = false,
            Callback = function(v)
                AutoSapphire = v
                if v then
                    task.spawn(function()
                        local function GetRootPart()
                            local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                            return Character:WaitForChild("HumanoidRootPart", 5)
                        end
                        while AutoSapphire do
                            local RootPart = GetRootPart()
                            local White = workspace:FindFirstChild("Local") and workspace.Local:FindFirstChild("Gizmos")
                            if White and RootPart and White:FindFirstChild("Sapphire") and AutoSapphire then
                                local Item = White.Sapphire
                                local Target = Item.PrimaryPart or Item:FindFirstChildWhichIsA("BasePart", true)
                                if Target then
                                    RootPart.CFrame = Target.CFrame * CFrame.new(0, 0, -2.5)
                                    task.wait(0.2)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)
                                    task.wait(0.05)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game)
                                    repeat
                                        task.wait(0.1)
                                    until not White:FindFirstChild("Sapphire") or not AutoSapphire
                                end
                            end
                            task.wait(0.5)
                        end
                    end)
                end
            end
        })

        Tabs.Main:Toggle({
            Title = "自动刷钱",
            Desc = "自动刷ATM 收银机",
            Value = false,
            Callback = function(Value)
                if not _G.AutoFarmData then
                    _G.AutoFarmData = {
                        Running = false,
                        Connection = nil,
                        Thread = nil
                    }
                end
                local data = _G.AutoFarmData
                if data.Connection then
                    data.Connection:Disconnect()
                    data.Connection = nil
                end
                if data.Thread then
                    coroutine.close(data.Thread)
                    data.Thread = nil
                end
                data.Running = false
                if Value then
                    data.Running = true
                    local VirtualInputManager = game:GetService("VirtualInputManager")
                    local HumanoidRootPart = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
                    local WhiteZoneGizmos = workspace.Local.Gizmos
                    local function FindBasePart(model)
                        if model:IsA("BasePart") then
                            return model
                        end
                        for _, child in ipairs(model:GetDescendants()) do
                            if child:IsA("BasePart") then
                                return child
                            end
                        end
                    end
                    local function IsATMOrRegister(gizmo)
                        local gizmoType = gizmo:GetAttribute("gizmoType")
                        return gizmoType == "ATM" or gizmoType == "Register"
                    end
                    local function FindNearestATM()
                        local shortestDistance = math.huge
                        local nearestATM = nil
                        for _, gizmo in ipairs(WhiteZoneGizmos:GetChildren()) do
                            if IsATMOrRegister(gizmo) then
                                local basePart = FindBasePart(gizmo)
                                if basePart then
                                    local distance = (HumanoidRootPart.Position - basePart.Position).Magnitude
                                    if distance < shortestDistance then
                                        nearestATM = basePart
                                        shortestDistance = distance
                                    end
                                end
                            end
                        end
                        return nearestATM
                    end
                    local function TeleportToTarget(target)
                        if typeof(target) ~= "Instance" then
                            if typeof(target) == "Vector3" then
                                HumanoidRootPart.CFrame = CFrame.new(target)
                            end
                        else
                            HumanoidRootPart.CFrame = target.CFrame * CFrame.new(0, 5, 0)
                        end
                    end
                    local function PressEKey(duration)
                        local startTime = tick()
                        while tick() - startTime < duration and data.Running do
                            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                            task.wait(0.05)
                        end
                    end
                    local function CollectMoney(atmPart)
                        local startTime = tick()
                        local timeout = 3
                        while tick() - startTime < timeout and (atmPart.Parent and not atmPart:GetAttribute("Collected")) and data.Running do
                            task.wait(0.1)
                        end
                        if data.Running then
                            PressEKey(1.5)
                        end
                    end
                    data.Connection = game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
                        if not data.Running then
                            data.Connection:Disconnect()
                            return
                        end
                        if not data.LastCheck then
                            data.LastCheck = tick()
                        end
                        if tick() - data.LastCheck > 1 then
                            data.LastCheck = tick()
                            local nearestATM = FindNearestATM()
                            if nearestATM then
                                TeleportToTarget(nearestATM)
                                task.wait(0.3)
                                if not data.Running then return end
                                PressEKey(1.5)
                                if not data.Running then return end
                                CollectMoney(nearestATM)
                            end
                        end
                    end)
                else
                    if data.Connection then
                        pcall(function() data.Connection:Disconnect() end)
                        data.Connection = nil
                    end
                    if data.Thread then
                        pcall(function() coroutine.close(data.Thread) end)
                        data.Thread = nil
                    end
                    data.Running = false
                    _G.AutoFarmData = nil
                end
            end
        })

        Tabs.Main:Section({ Title = "子弹追踪", Icon = "crosshair" })
        local Camera = workspace.CurrentCamera
        local UserInputService = game:GetService("UserInputService")
        local old
        local cachedTarget = nil
        local lastUpdate = 0
        local updateDelay = 0.1
        local BulletTrackingEnabled = false
        local updateConnection = nil
        local isFirstPerson = false

        local function checkFirstPerson()
            local Character = LocalPlayer.Character
            if not Character then return false end
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            if not Humanoid then return false end
            if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
                return true
            end
            local head = Character:FindFirstChild("Head")
            if head then
                local distance = (Camera.CFrame.Position - head.Position).Magnitude
                return distance < 2
            end
            return false
        end

        local function getRayOrigin()
            local Character = LocalPlayer.Character
            if not Character then return Camera.CFrame.Position end
            if isFirstPerson then
                return Camera.CFrame.Position
            end
            local head = Character:FindFirstChild("Head")
            if head then
                for _, tool in ipairs(Character:GetChildren()) do
                    if tool:IsA("Tool") then
                        local muzzle = tool:FindFirstChild("Muzzle") or tool:FindFirstChild("muzzle")
                        if muzzle and muzzle:IsA("BasePart") then
                            return muzzle.Position
                        elseif muzzle and muzzle:IsA("Attachment") then
                            return muzzle.WorldPosition
                        end
                    end
                end
                return head.Position + head.CFrame.LookVector * 1.5
            end
            return Camera.CFrame.Position
        end

        local function updateTarget()
            if not BulletTrackingEnabled then return end
            isFirstPerson = checkFirstPerson()
            local closest, dist = nil, math.huge
            local rayOrigin = getRayOrigin()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    local c = p.Character
                    if c then
                        local head = c:FindFirstChild("Head")
                        local hum = c:FindFirstChildOfClass("Humanoid")
                        if head and hum and hum.Health > 0 and not c:FindFirstChild("ForceField") then
                            local dir = (head.Position - rayOrigin)
                            local mag = dir.Magnitude
                            local cameraLook = Camera.CFrame.LookVector
                            local angle = math.deg(math.acos(cameraLook:Dot(dir.Unit)))
                            local maxAngle = isFirstPerson and 15 or 30
                            if angle <= maxAngle and mag < dist and mag < 500 then
                                dist = mag
                                closest = head
                            end
                        end
                    end
                end
            end
            cachedTarget = closest
        end

        local function hookRaycast()
            local previousNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local method = getnamecallmethod()
                if not checkcaller() and self == workspace and (method == "Raycast" or method == "FindPartOnRay") then
                    if cachedTarget and BulletTrackingEnabled then
                        local args = {...}
                        local origin, direction
                        if method == "Raycast" then
                            origin, direction = args[1], args[2]
                        else
                            local ray = args[1]
                            if typeof(ray) == "Ray" then
                                origin, direction = ray.Origin, ray.Direction
                            end
                        end
                        if origin and direction then
                            return {
                                Instance = cachedTarget,
                                Position = cachedTarget.Position,
                                Normal = (cachedTarget.Position - origin).Unit,
                                Material = Enum.Material.Plastic
                            }
                        end
                    end
                end
                return previousNamecall(self, ...)
            end)
            old = previousNamecall
        end

        Tabs.Main:Toggle({
            Title = "子弹追踪",
            Value = false,
            Callback = function(Value)
                BulletTrackingEnabled = Value
                if Value then
                    if updateConnection then
                        updateConnection:Disconnect()
                    end
                    updateConnection = RunService.RenderStepped:Connect(function()
                        if tick() - lastUpdate > updateDelay then
                            lastUpdate = tick()
                            updateTarget()
                        end
                    end)
                    if not old then
                        hookRaycast()
                    end
                else
                    if updateConnection then
                        updateConnection:Disconnect()
                        updateConnection = nil
                    end
                    if old then
                        hookmetamethod(game, "__namecall", old)
                        old = nil
                    end
                    cachedTarget = nil
                end
            end
        })

        Tabs.Main:Section({ Title = "暴力模式", Icon = "zap" })
        local RagebotEnabled = false
        local AttackTeam = "全部"

        local function getPlayerTeam(player)
            local success, teamName = pcall(function()
                return player:GetAttribute("currentTeam") or player.currentTeam
            end)
            if success and teamName then
                return string.lower(tostring(teamName))
            end
            return "none"
        end

        local Devv = require(ReplicatedStorage:WaitForChild("Devv"))
        local Network = Devv.load("Network")
        local MathUtil = Devv.load("MathUtil")
        local NUID = Devv.load("NUID")
        local ClientGuns = Devv.load("ClientGuns")
        local ClientTools = Devv.load("ClientTools")
        local ClientPlayers = Devv.load("ClientPlayers")
        local ClientProjectiles = Devv.load("ClientProjectiles")
        local Debris = game:GetService("Debris")
        local CollectionService = game:GetService("CollectionService")

        local Config = {
            FireInterval = 0.02,
            MaxRange = 600,
            Enabled = false,
            WallbangEnabled = false,
            WallbangThickness = 1.5,
            ReloadCooldown = 2.5,
            ScanEnabled = true,
            OriginScanRadius = 5,
            TargetScanOffset = 3,
            ShootPrecision = 20,
            TargetPrecision = 20
        }

        local LastFireTime = 0
        local LastReloadTime = 0
        local CycleActive = false

        local ScanPositionsVectors = {
            Vector3.new(1, 0, 0), Vector3.new(0, 0, 1), Vector3.new(0, 1, 0),
            -Vector3.new(1, 0, 0), -Vector3.new(0, 0, 1), -Vector3.new(0, 1, 0),
            Vector3.new(1, 1, 0)/math.sqrt(2), Vector3.new(1, 0, 1)/math.sqrt(2), Vector3.new(0, 1, 1)/math.sqrt(2),
            Vector3.new(-1, 1, 0)/math.sqrt(2), Vector3.new(-1, 0, 1)/math.sqrt(2),
            -Vector3.new(1, 0, 1)/math.sqrt(2), -Vector3.new(-1, 0, 1)/math.sqrt(2), -Vector3.new(0, -1, 1)/math.sqrt(2),
            Vector3.new(1, 1, 1)/math.sqrt(3), Vector3.new(-1, 1, 1)/math.sqrt(3), Vector3.new(1, 1, -1)/math.sqrt(3),
            -Vector3.new(1, 1, 1)/math.sqrt(3), -Vector3.new(1, -1, 1)/math.sqrt(3)
        }

        local function GetEquippedTool()
            if ClientTools and ClientTools.GetLocalEquippedTool then
                local ok, tool = pcall(function()
                    return ClientTools.GetLocalEquippedTool()
                end)
                if ok and tool then
                    return tool
                end
            end
            return nil
        end

        local function GetToolId()
            if ClientPlayers and ClientPlayers.Get then
                local ok, playerObj = pcall(function()
                    return ClientPlayers.Get()
                end)
                if ok and playerObj and playerObj.GetEquippedReplica then
                    local ok2, replica = pcall(function()
                        return playerObj:GetEquippedReplica()
                    end)
                    if ok2 and replica and replica.toolId then
                        return replica.toolId
                    end
                end
            end
            local tool = GetEquippedTool()
            if tool and tool.toolId then
                return tool.toolId
            end
            if tool and tool.GetId then
                local ok, id = pcall(function()
                    return tool:GetId()
                end)
                if ok and id then
                    return id
                end
            end
            return nil
        end

        local function GetShooter()
            local tool = GetEquippedTool()
            if tool and tool.GetComponent then
                local ok, shooter = pcall(function()
                    return tool:GetComponent("Shooter")
                end)
                if ok and shooter then
                    return shooter
                end
            end
            return nil
        end

        local function GetAmmo()
            local shooter = GetShooter()
            if shooter then
                return shooter.ammo or 0, shooter.totalAmmo or 0
            end
            local tool = GetEquippedTool()
            if tool and tool.toolState then
                return tool.toolState.ammo or 0, tool.toolState.totalAmmo or 0
            end
            return 0, 0
        end

        local function DoReload()
            local tool = GetEquippedTool()
            if tool and tool.Reload then
                pcall(function()
                    tool:Reload()
                end)
                return true
            end
            local toolId = GetToolId()
            if toolId and Network and Network.FireServer then
                pcall(function()
                    Network.FireServer("reload", toolId)
                end)
                return true
            end
            return false
        end

        local function GetTargetHitbox(character)
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") and CollectionService:HasTag(part, "rootHitbox") then
                    return part
                end
            end
            return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head")
        end

        local function GetClosestEnemy()
            local closest, minDist, closestPlayer = nil, math.huge, nil
            local camPos = Camera.CFrame.Position
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local hitbox = GetTargetHitbox(p.Character)
                    local humanoid = p.Character:FindFirstChildOfClass("Humanoid")
                    if hitbox and humanoid and humanoid.Health > 0 then
                        local dist = (hitbox.Position - camPos).Magnitude
                        if dist < minDist and dist < Config.MaxRange then
                            closest, minDist, closestPlayer = hitbox, dist, p
                        end
                    end
                end
            end
            return closest, closestPlayer
        end

        local function CanShootFromPosition(shootPos, targetPos, targetCharacter, allowWallbang)
            local direction = (targetPos - shootPos).Unit
            local distance = (targetPos - shootPos).Magnitude
            if distance < 0.1 then return false end
            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, targetCharacter}
            raycastParams.FilterType = Enum.RaycastFilterType.Exclude
            raycastParams.IgnoreWater = true
            local result = Workspace:Raycast(shootPos, direction * distance, raycastParams)
            if not result then
                return true
            end
            if not allowWallbang then
                return false
            end
            local entryPoint = result.Position
            local exitResult = Workspace:Raycast(targetPos, -direction * distance, raycastParams)
            if not exitResult then
                return false
            end
            local exitPoint = exitResult.Position
            local thickness = (entryPoint - exitPoint).Magnitude
            return thickness <= Config.WallbangThickness
        end

        local function GetOffsets(pos, targetPos, offset)
            if not offset or offset == 0 then return {pos} end
            local offsets = {pos}
            local cf = CFrame.new(pos, targetPos) * CFrame.Angles(0, 0, math.rad(math.random(1, 90)))
            for _, v in ipairs(ScanPositionsVectors) do
                table.insert(offsets, cf:PointToWorldSpace(v * offset))
            end
            return offsets
        end

        local function CreateShotRay(origin, targetPos)
            local part = Instance.new("Part")
            part.Size = Vector3.new(0.2, 0.2, 0.2)
            part.Anchored = true
            part.CanCollide = false
            part.CanQuery = false
            part.CanTouch = false
            part.Transparency = 1
            part.CFrame = CFrame.new(origin)
            part.Parent = Workspace
            local att0 = Instance.new("Attachment")
            att0.Parent = part
            local att1 = Instance.new("Attachment")
            att1.Parent = Workspace.Terrain
            att1.WorldPosition = targetPos
            local beam = Instance.new("Beam")
            beam.Attachment0 = att0
            beam.Attachment1 = att1
            beam.Color = ColorSequence.new(Color3.fromRGB(255, 80, 80))
            beam.Width0 = 0.2
            beam.Width1 = 0.2
            beam.FaceCamera = true
            beam.LightEmission = 1
            beam.Parent = part
            Debris:AddItem(part, 0.2)
        end

        local lastShootOrigin = nil
        local lastShootHitPos = nil
        local lastShootPosUpdate = 0

        local function FindBestShootSolution(basePos, targetPos, targetCharacter)
            if CanShootFromPosition(basePos, targetPos, targetCharacter, false) then
                return basePos, targetPos
            end
            local currentTime = tick()
            if lastShootOrigin and lastShootHitPos and (currentTime - lastShootPosUpdate) < 0.1 then
                if CanShootFromPosition(lastShootOrigin, lastShootHitPos, targetCharacter, false) then
                    return lastShootOrigin, lastShootHitPos
                end
            end
            if Config.ScanEnabled then
                local originOffsets = GetOffsets(basePos, targetPos, Config.OriginScanRadius)
                local targetOffsets = GetOffsets(targetPos, basePos, Config.TargetScanOffset)
                for _, originPos in ipairs(originOffsets) do
                    if CanShootFromPosition(originPos, targetPos, targetCharacter, false) then
                        lastShootOrigin = originPos
                        lastShootHitPos = targetPos
                        lastShootPosUpdate = currentTime
                        return originPos, targetPos
                    end
                end
                for _, originPos in ipairs(originOffsets) do
                    for _, hitPos in ipairs(targetOffsets) do
                        if CanShootFromPosition(originPos, hitPos, targetCharacter, false) then
                            lastShootOrigin = originPos
                            lastShootHitPos = hitPos
                            lastShootPosUpdate = currentTime
                            return originPos, hitPos
                        end
                    end
                end
            end
            for _ = 1, Config.ShootPrecision do
                local originAngle = Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit
                local testOrigin = basePos + originAngle * math.random() * Config.OriginScanRadius
                for _ = 1, Config.TargetPrecision do
                    local targetAngle = Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit
                    local testTarget = targetPos + targetAngle * math.random() * Config.TargetScanOffset
                    if CanShootFromPosition(testOrigin, testTarget, targetCharacter, false) then
                        lastShootOrigin = testOrigin
                        lastShootHitPos = testTarget
                        lastShootPosUpdate = currentTime
                        return testOrigin, testTarget
                    end
                end
            end
            return nil, nil
        end

        local function DoAttack(targetPart, targetPlayer)
            local now = tick()
            if now - LastFireTime < Config.FireInterval then return end
            if not LocalPlayer.Character then return end
            local toolId = GetToolId()
            if not toolId then return end
            local ammo = GetAmmo()
            if ammo <= 0 then
                if now - LastReloadTime > Config.ReloadCooldown then
                    LastReloadTime = now
                    DoReload()
                end
                return
            end
            local camPos = Camera.CFrame.Position
            local targetPos = targetPart.Position
            local targetCharacter = targetPlayer.Character
            local shootPos, hitPos = FindBestShootSolution(camPos, targetPos, targetCharacter)
            if not shootPos or not hitPos then
                return
            end
            LastFireTime = now
            CreateShotRay(shootPos, hitPos)
            local muzzleCFrame = CFrame.new(shootPos, hitPos)
            local projectileId = NUID()
            local projectileCFrame = CFrame.new(shootPos, hitPos)
            local compressedMuzzle = MathUtil.CompressCFrame(muzzleCFrame)
            local compressedProjectile = MathUtil.CompressCFrame(projectileCFrame)
            local projectileEntry = {{projectileId, compressedProjectile}}
            local uncompressedEntry = {{projectileId, projectileCFrame}}
            if ClientGuns and ClientGuns.MakeGunProjectiles then
                pcall(function()
                    ClientGuns.MakeGunProjectiles(LocalPlayer.UserId, toolId, muzzleCFrame, uncompressedEntry)
                end)
            end
            local direction = (hitPos - shootPos).Unit
            local speed = 1200
            local targetHead = targetCharacter:FindFirstChild("Head")
            local hitInstance = targetHead or targetPart
            task.spawn(function()
                local result = nil
                if Network and Network.InvokeServer then
                    local ok, res = pcall(function()
                        return Network.InvokeServer("shoot", toolId, compressedMuzzle, projectileEntry)
                    end)
                    if ok then
                        result = res
                    end
                end
                if ClientProjectiles and ClientProjectiles.SetProjectileValid then
                    pcall(function()
                        ClientProjectiles.SetProjectileValid(projectileId, result)
                    end)
                end
                task.wait(0.02)
                local hitInfo = {
                    {
                        normal = -direction,
                        direction = direction,
                        source = {
                            sourceType = "Bullet",
                            sourceId = projectileId,
                            sourceToolId = toolId,
                            sourcePlayerId = LocalPlayer.UserId,
                        },
                        massLimit = 5,
                        position = shootPos,
                        hitPlayers = {},
                        ownerId = LocalPlayer.UserId,
                        material = Enum.Material.SmoothPlastic,
                        processedPlayerId = LocalPlayer.UserId,
                        hit = hitInstance,
                        speed = speed,
                        collisionPoint = hitPos,
                        hitName = hitInstance.Name,
                        hitType = "player",
                        distance = (hitPos - shootPos).Magnitude,
                    }
                }
                if Network and Network.FireServer then
                    pcall(function()
                        Network.FireServer("registerProjectileHits", projectileId, toolId, hitInfo)
                    end)
                end
            end)
            local shooter = GetShooter()
            if shooter and shooter.UpdateAmmo then
                pcall(function()
                    shooter:UpdateAmmo(math.max(0, (shooter.ammo or 1) - 1), shooter.totalAmmo)
                end)
            end
        end

        local function StartCycle()
            if CycleActive then return end
            CycleActive = true
            task.spawn(function()
                local accumulator = 0
                while Config.Enabled do
                    local dt = RunService.Heartbeat:Wait()
                    accumulator = accumulator + dt
                    if accumulator >= Config.FireInterval then
                        local target, player = GetClosestEnemy()
                        if target and player then
                            while accumulator >= Config.FireInterval and Config.Enabled do
                                accumulator = accumulator - Config.FireInterval
                                DoAttack(target, player)
                                target, player = GetClosestEnemy()
                                if not target then
                                    accumulator = 0
                                    break
                                end
                            end
                        else
                            accumulator = 0
                        end
                    end
                end
                CycleActive = false
            end)
        end

        local function StopCycle()
            CycleActive = false
            Config.Enabled = false
        end

        Tabs.Main:Toggle({
            Title = "Ragebot",
            Value = false,
            Callback = function(Value)
                if Value then
                    Config.Enabled = true
                    StartCycle()
                else
                    StopCycle()
                end
            end
        })

        local AutoShoot = false
        local ShooterModule = nil
        local OriginalShoot = nil
        local Ragebot2Installed = false

        Tabs.Main:Toggle({
            Title = "Ragebot(2)",
            Value = false,
            Callback = function(Value)
                AutoShoot = Value
                if Value then
                    if Ragebot2Installed then return end
                    Ragebot2Installed = true
                    task.spawn(function()
                        ShooterModule = require(game:GetService("ReplicatedStorage").Client.Wanted.Objects.ClientTool.Components.Tools.Guns.Shooter)
                        local previousShoot = ShooterModule._shoot
                        OriginalShoot = previousShoot
                        local trailColors = {
                            primary = ColorSequence.new{
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 170, 255)),
                                ColorSequenceKeypoint.new(0.3, Color3.fromRGB(255, 0, 255)),
                                ColorSequenceKeypoint.new(0.6, Color3.fromRGB(255, 255, 0)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                            }
                        }
                        local function createBezierCurve(p0, p1, p2, t)
                            return (1-t)^2 * p0 + 2*(1-t)*t * p1 + t^2 * p2
                        end
                        local function createBeautifulTrail(origin, targetPos)
                            local trailContainer = Instance.new("Folder")
                            trailContainer.Name = "MagicTrail"
                            trailContainer.Parent = workspace
                            local midPoint = (origin + targetPos) / 2
                            local direction = (targetPos - origin).Unit
                            local perpendicular = Vector3.new(-direction.Z, direction.Y, direction.X) * 3
                            local controlPoint = midPoint + perpendicular + Vector3.new(0, math.random(-3, 3), 0)
                            local curvePoints = {}
                            local numSegments = 20
                            for i = 0, numSegments do
                                local t = i / numSegments
                                local point = createBezierCurve(origin, controlPoint, targetPos, t)
                                table.insert(curvePoints, point)
                            end
                            for i = 1, #curvePoints - 1 do
                                local startPoint = curvePoints[i]
                                local endPoint = curvePoints[i + 1]
                                local distance = (endPoint - startPoint).Magnitude
                                local beamPart = Instance.new("Part")
                                beamPart.Size = Vector3.new(0.15, 0.15, distance)
                                beamPart.Anchored = true
                                beamPart.CanCollide = false
                                beamPart.Material = Enum.Material.Neon
                                beamPart.Transparency = 0.3
                                beamPart.CFrame = CFrame.new(startPoint, endPoint) * CFrame.new(0, 0, -distance/2)
                                beamPart.Parent = trailContainer
                                local pointLight = Instance.new("PointLight")
                                pointLight.Brightness = 5
                                pointLight.Range = 3
                                pointLight.Color = Color3.fromRGB(0, 170, 255)
                                pointLight.Parent = beamPart
                                local particles = Instance.new("ParticleEmitter")
                                particles.Size = NumberSequence.new(0.1, 0.3)
                                particles.Transparency = NumberSequence.new(0.3, 0.8)
                                particles.Lifetime = NumberRange.new(0.5, 1)
                                particles.Rate = 50
                                particles.Speed = NumberRange.new(1, 2)
                                particles.VelocitySpread = 180
                                particles.Parent = beamPart
                            end
                            task.spawn(function()
                                task.wait(1.5)
                                if trailContainer and trailContainer.Parent then
                                    trailContainer:Destroy()
                                end
                            end)
                            return trailContainer
                        end
                        local function hasLineOfSight(shooterPos, targetPos)
                            local raycastParams = RaycastParams.new()
                            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                            raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
                            raycastParams.IgnoreWater = true
                            local direction = (targetPos - shooterPos).Unit
                            local distance = (targetPos - shooterPos).Magnitude
                            local raycastResult = workspace:Raycast(shooterPos, direction * distance, raycastParams)
                            if raycastResult then
                                local hitPart = raycastResult.Instance
                                if hitPart then
                                    local hitCharacter = hitPart:FindFirstAncestorOfClass("Model")
                                    if hitCharacter and hitCharacter:FindFirstChild("Humanoid") then
                                        return true
                                    else
                                        return false
                                    end
                                end
                            end
                            return true
                        end
                        ShooterModule._shoot = function(self)
                            if not self or not self.tool then
                                return previousShoot(self)
                            end
                            local Character = LocalPlayer.Character
                            if not Character then
                                return previousShoot(self)
                            end
                            local shooterPos = Character.HumanoidRootPart and Character.HumanoidRootPart.Position or Character.PrimaryPart.Position
                            local nearestPlayer = nil
                            local nearestDistance = math.huge
                            for _, player in ipairs(Players:GetPlayers()) do
                                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                    local playerTeam = getPlayerTeam(player)
                                    if AttackTeam ~= "全部" and playerTeam ~= AttackTeam then
                                    end
                                    local targetPos = player.Character.HumanoidRootPart.Position
                                    local distance = (shooterPos - targetPos).Magnitude
                                    if hasLineOfSight(shooterPos, targetPos) and distance < nearestDistance then
                                        nearestDistance = distance
                                        nearestPlayer = player
                                    end
                                end
                            end
                            if nearestPlayer and nearestPlayer.Character and nearestPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                local targetPos = nearestPlayer.Character.HumanoidRootPart.Position
                                self.aimpoint = targetPos
                                self.aimpoint2 = targetPos
                                if self.tool.model and self.tool.model.PrimaryPart then
                                    local muzzlePos = self.tool.model.PrimaryPart.Position
                                    createBeautifulTrail(muzzlePos, targetPos)
                                else
                                    createBeautifulTrail(shooterPos, targetPos)
                                end
                                if self.tool then
                                    self.tool.shooting = true
                                    self.tool.fireDebounce = 0
                                    self.tool.fireMode = "auto"
                                end
                            else
                                if self.tool then
                                    self.tool.shooting = false
                                end
                            end
                            return previousShoot(self)
                        end
                        while AutoShoot do
                            if ShooterModule and ShooterModule._shoot then
                                local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
                                if tool then
                                    local shooter = {tool = tool}
                                    pcall(function()
                                        ShooterModule._shoot(shooter)
                                    end)
                                end
                            end
                            task.wait(0.2)
                        end
                        if OriginalShoot then
                            ShooterModule._shoot = OriginalShoot
                        end
                        Ragebot2Installed = false
                    end)
                else
                    if ShooterModule and OriginalShoot then
                        ShooterModule._shoot = OriginalShoot
                        Ragebot2Installed = false
                    end
                end
            end
        })

        local teamList = {"全部", "police", "syndicate", "wanted", "none"}
        Tabs.Main:Dropdown({
            Title = "攻击队伍",
            Values = teamList,
            Value = "全部",
            Callback = function(Value)
                AttackTeam = Value
            end
        })

        Tabs.Main:Section({ Title = "静默自瞄", Icon = "crosshair" })

        local AimLockSystem = {}
        AimLockSystem.Config = {
            enabled = false,
            smoothAim = false,
            aimType = "最近玩家",
            aimPart = "头部",
            fovEnabled = false,
            showFov = false,
            fovSize = 100,
            fovColor = Color3.fromRGB(255, 255, 255),
            fovLockDistance = 1000,
            nearestPlayerDistance = 1000,
            nearestMouseDistance = 500,
            wallCheckEnabled = true,
            lerpAlpha = 0.4,
            aimlockOffsetX = 0,
            aimlockOffsetY = 0,
            ignoredPlayers = {},
            prioritizedPlayers = {},
            aimlockCertainPlayer = false,
            selectedPlayer = nil,
            rainbowFov = false,
            fovStrokeThickness = 2,
            fovGui = nil,
            fovFrame = nil,
            fovStroke = nil
        }
        AimLockSystem.State = {
            isAimingLocked = false,
            aimlockConnection = nil
        }

        function AimLockSystem.GetLocalHRP()
            if not LocalPlayer.Character then return nil end
            return LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        end

        function AimLockSystem.IsPlayerIgnored(player)
            return AimLockSystem.Config.ignoredPlayers[player.Name] == true
        end

        function AimLockSystem.GetAimPartPosition(targetPlayer)
            if not targetPlayer or not targetPlayer.Character then return nil end
            local part = nil
            if AimLockSystem.Config.aimPart == "头部" then
                part = targetPlayer.Character:FindFirstChild("Head")
            elseif AimLockSystem.Config.aimPart == "躯干" then
                part = targetPlayer.Character:FindFirstChild("UpperTorso") or targetPlayer.Character:FindFirstChild("Torso")
            elseif AimLockSystem.Config.aimPart == "脚部" then
                local hrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    return hrp.Position + Vector3.new(0, -3, 0)
                end
            end
            return part and part.Position or nil
        end

        function AimLockSystem.GetPriorityScore(player)
            if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
                return math.huge
            end
            local localHRP = AimLockSystem.GetLocalHRP()
            if not localHRP then return math.huge end
            if player == LocalPlayer then return math.huge end
            if AimLockSystem.IsPlayerIgnored(player) then return math.huge end
            local hrp = player.Character.HumanoidRootPart
            if AimLockSystem.Config.fovEnabled then
                local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                if not onScreen then return math.huge end
                local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
                local distFromCenter = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                if distFromCenter > AimLockSystem.Config.fovSize/2 then return math.huge end
                if (localHRP.Position - hrp.Position).Magnitude > AimLockSystem.Config.fovLockDistance then
                    return math.huge
                end
            end
            if AimLockSystem.Config.wallCheckEnabled then
                local head = player.Character:FindFirstChild("Head")
                if head then
                    local origin = localHRP.Parent:FindFirstChild("Head") and localHRP.Parent.Head.Position or localHRP.Position
                    local direction = head.Position - origin
                    local rayParams = RaycastParams.new()
                    rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
                    rayParams.FilterType = Enum.RaycastFilterType.Exclude
                    local result = workspace:Raycast(origin, direction, rayParams)
                    if result and not result.Instance:IsDescendantOf(player.Character) then
                        return math.huge
                    end
                end
            end
            if AimLockSystem.Config.aimType == "最近玩家" then
                return (localHRP.Position - hrp.Position).Magnitude
            else
                local mousePos = UserInputService:GetMouseLocation()
                local screenPos = Camera:WorldToViewportPoint(hrp.Position)
                return (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
            end
        end

        function AimLockSystem.GetClosestPlayer()
            local localHRP = AimLockSystem.GetLocalHRP()
            if not localHRP then return nil end
            local bestPlayer, bestScore = nil, math.huge
            for _, player in ipairs(AimLockSystem.Config.prioritizedPlayers) do
                local score = AimLockSystem.GetPriorityScore(player)
                if score < bestScore then
                    bestScore = score
                    bestPlayer = player
                end
            end
            if bestPlayer then return bestPlayer end
            for _, player in ipairs(Players:GetPlayers()) do
                if table.find(AimLockSystem.Config.prioritizedPlayers, player) then
                   
                end
                local score = AimLockSystem.GetPriorityScore(player)
                if score < bestScore then
                    bestScore = score
                    bestPlayer = player
                end
            end
            return bestPlayer
        end

        function AimLockSystem.UpdateAimlock()
            local localHRP = AimLockSystem.GetLocalHRP()
            if not localHRP then
                AimLockSystem.State.isAimingLocked = false
                return
            end
            local targetPlayer = nil
            if AimLockSystem.Config.aimlockCertainPlayer then
                targetPlayer = AimLockSystem.Config.selectedPlayer
            else
                targetPlayer = AimLockSystem.GetClosestPlayer()
            end
            if targetPlayer then
                AimLockSystem.State.isAimingLocked = true
                local targetPosition = AimLockSystem.GetAimPartPosition(targetPlayer)
                if targetPosition then
                    targetPosition = targetPosition + Vector3.new(
                        AimLockSystem.Config.aimlockOffsetX,
                        AimLockSystem.Config.aimlockOffsetY,
                        0
                    )
                    local lookDirection = (targetPosition - Camera.CFrame.Position).Unit
                    if AimLockSystem.Config.smoothAim then
                        local targetCFrame = CFrame.lookAt(
                            Camera.CFrame.Position,
                            Camera.CFrame.Position + lookDirection
                        )
                        Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, AimLockSystem.Config.lerpAlpha)
                    else
                        Camera.CFrame = CFrame.lookAt(
                            Camera.CFrame.Position,
                            Camera.CFrame.Position + lookDirection
                        )
                    end
                end
            else
                AimLockSystem.State.isAimingLocked = false
            end
        end

        function AimLockSystem.UpdateFOVCircle()
            if not AimLockSystem.Config.showFov then
                if AimLockSystem.Config.fovFrame then
                    AimLockSystem.Config.fovFrame.Visible = false
                end
                return
            end
            if not AimLockSystem.Config.fovGui then
                AimLockSystem.Config.fovGui = Instance.new("ScreenGui")
                AimLockSystem.Config.fovGui.Name = "FOVCircle"
                AimLockSystem.Config.fovGui.IgnoreGuiInset = true
                AimLockSystem.Config.fovGui.Parent = game:GetService("CoreGui")
                AimLockSystem.Config.fovFrame = Instance.new("Frame")
                AimLockSystem.Config.fovFrame.Name = "Circle"
                AimLockSystem.Config.fovFrame.AnchorPoint = Vector2.new(0.5, 0.5)
                AimLockSystem.Config.fovFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
                AimLockSystem.Config.fovFrame.BackgroundTransparency = 1
                AimLockSystem.Config.fovFrame.BorderSizePixel = 0
                AimLockSystem.Config.fovFrame.Parent = AimLockSystem.Config.fovGui
                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(1, 0)
                corner.Parent = AimLockSystem.Config.fovFrame
                AimLockSystem.Config.fovStroke = Instance.new("UIStroke")
                AimLockSystem.Config.fovStroke.Thickness = AimLockSystem.Config.fovStrokeThickness
                AimLockSystem.Config.fovStroke.Parent = AimLockSystem.Config.fovFrame
            end
            local color = AimLockSystem.Config.fovColor
            if AimLockSystem.State.isAimingLocked then
                color = Color3.fromRGB(0, 255, 0)
            elseif AimLockSystem.Config.rainbowFov then
                color = Color3.fromHSV(tick() % 1, 1, 1)
            end
            AimLockSystem.Config.fovStroke.Color = color
            AimLockSystem.Config.fovFrame.Size = UDim2.new(0, AimLockSystem.Config.fovSize, 0, AimLockSystem.Config.fovSize)
            AimLockSystem.Config.fovFrame.Visible = true
        end

        function AimLockSystem.ToggleAimlock(enabled)
            AimLockSystem.Config.enabled = enabled
            if enabled then
                if not AimLockSystem.State.aimlockConnection then
                    AimLockSystem.State.aimlockConnection = RunService.RenderStepped:Connect(function()
                        AimLockSystem.UpdateAimlock()
                        AimLockSystem.UpdateFOVCircle()
                    end)
                end
            else
                if AimLockSystem.State.aimlockConnection then
                    AimLockSystem.State.aimlockConnection:Disconnect()
                    AimLockSystem.State.aimlockConnection = nil
                end
                AimLockSystem.State.isAimingLocked = false
                if AimLockSystem.Config.fovFrame then
                    AimLockSystem.Config.fovFrame.Visible = false
                end
            end
        end

        Tabs.Main:Toggle({
            Title = "启用自瞄",
            Value = false,
            Callback = function(Value)
                AimLockSystem.ToggleAimlock(Value)
            end
        })

        Tabs.Main:Toggle({
            Title = "平滑瞄准",
            Value = false,
            Callback = function(Value)
                AimLockSystem.Config.smoothAim = Value
            end
        })

        Tabs.Main:Toggle({
            Title = "启用FOV检测",
            Value = false,
            Callback = function(Value)
                AimLockSystem.Config.fovEnabled = Value
            end
        })

        Tabs.Main:Toggle({
            Title = "显示FOV圆圈",
            Value = false,
            Callback = function(Value)
                AimLockSystem.Config.showFov = Value
            end
        })

        Tabs.Main:Slider({
            Title = "FOV大小",
            Value = { Min = 50, Max = 500, Default = 100 },
            Callback = function(Value)
                AimLockSystem.Config.fovSize = Value
            end
        })

        Tabs.Main:Slider({
            Title = "平滑度",
            Value = { Min = 0.1, Max = 1, Default = 0.4 },
            Callback = function(Value)
                AimLockSystem.Config.lerpAlpha = Value
            end
        })

        Tabs.Main:Slider({
            Title = "最大距离",
            Value = { Min = 100, Max = 5000, Default = 1000 },
            Callback = function(Value)
                AimLockSystem.Config.fovLockDistance = Value
            end
        })

        Tabs.Main:Dropdown({
            Title = "瞄准类型",
            Values = { "最近玩家", "鼠标最近" },
            Value = "最近玩家",
            Callback = function(Value)
                AimLockSystem.Config.aimType = Value
            end
        })

        Tabs.Main:Dropdown({
            Title = "瞄准部位",
            Values = { "头部", "躯干", "脚部" },
            Value = "头部",
            Callback = function(Value)
                AimLockSystem.Config.aimPart = Value
            end
        })

        Tabs.Main:Toggle({
            Title = "掩体检测",
            Value = false,
            Callback = function(Value)
                AimLockSystem.Config.wallCheckEnabled = Value
            end
        })

        local playerList = {}
        local function updatePlayerList()
            playerList = {"全部"}
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    table.insert(playerList, player.Name)
                end
            end
        end
        updatePlayerList()
        local selectedTarget = "全部"

        Tabs.Main:Dropdown({
            Title = "锁定指定玩家",
            Values = playerList,
            Value = "全部",
            Callback = function(Value)
                selectedTarget = Value
                if Value == "全部" then
                    AimLockSystem.Config.aimlockCertainPlayer = false
                    AimLockSystem.Config.selectedPlayer = nil
                else
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player.Name == Value then
                            AimLockSystem.Config.aimlockCertainPlayer = true
                            AimLockSystem.Config.selectedPlayer = player
                            break
                        end
                    end
                end
            end
        })

        Tabs.Main:Button({
            Title = "刷新玩家列表",
            Callback = function()
                updatePlayerList()
            end
        })

        Tabs.Main:Colorpicker({
            Title = "FOV颜色",
            Default = Color3.fromRGB(255, 255, 255),
            Callback = function(Value)
                AimLockSystem.Config.fovColor = Value
            end
        })

        Tabs.Main:Toggle({
            Title = "彩虹FOV",
            Value = false,
            Callback = function(Value)
                AimLockSystem.Config.rainbowFov = Value
            end
        })

        Tabs.Main:Slider({
            Title = "水平偏移",
            Value = { Min = -50, Max = 50, Default = 0 },
            Callback = function(Value)
                AimLockSystem.Config.aimlockOffsetX = Value
            end
        })

        Tabs.Main:Slider({
            Title = "垂直偏移",
            Value = { Min = -50, Max = 50, Default = 0 },
            Callback = function(Value)
                AimLockSystem.Config.aimlockOffsetY = Value
            end
        })

        Tabs.Main:Section({ Title = "战斗功能", Icon = "target" })
        local DetectedPlayers = {}
        local AdminCheckEnabled = true

        local function notify(player, role)
            F:Notify({
                Title = "管理员",
                Content = "玩家: " .. player.DisplayName .. "\n身份: " .. role,
                Icon = "shield",
                Duration = 10
            })
        end

        local function check(player)
            if not AdminCheckEnabled then return end
            if player == LocalPlayer then return end
            if DetectedPlayers[player.UserId] then return end
            task.spawn(function()
                local success, rank = pcall(function()
                    return player:GetRankInGroup(4856485)
                end)
                if success then
                    if rank > 1 then
                        local role = player:GetRoleInGroup(4856485)
                        DetectedPlayers[player.UserId] = true
                        notify(player, role)
                    end
                end
            end)
        end

        local AdminCheckConnectionAdded = nil
        local AdminCheckConnectionRemoving = nil

        local function toggleAdminCheck(enable)
            AdminCheckEnabled = enable
            if enable then
                if not AdminCheckConnectionAdded then
                    AdminCheckConnectionAdded = Players.PlayerAdded:Connect(check)
                end
                if not AdminCheckConnectionRemoving then
                    AdminCheckConnectionRemoving = Players.PlayerRemoving:Connect(function(player)
                        DetectedPlayers[player.UserId] = nil
                    end)
                end
                for _, p in ipairs(Players:GetPlayers()) do
                    check(p)
                end
            else
                if AdminCheckConnectionAdded then
                    AdminCheckConnectionAdded:Disconnect()
                    AdminCheckConnectionAdded = nil
                end
                if AdminCheckConnectionRemoving then
                    AdminCheckConnectionRemoving:Disconnect()
                    AdminCheckConnectionRemoving = nil
                end
                DetectedPlayers = {}
            end
        end
        toggleAdminCheck(true)

        Tabs.Main:Toggle({
            Title = "管理员检测",
            Value = true,
            Callback = function(Value)
                toggleAdminCheck(Value)
            end
        })

        Tabs.Main:Divider()

        Tabs.Main:Button({
            Title = "无限子弹(本地)",
            Desc = "娱乐功能，无伤害",
            Callback = function()
                if getgenv()._seInfiniteAmmoInstalled then return end
                getgenv()._seInfiniteAmmoInstalled = true
                local Shooter = require(game:GetService("ReplicatedStorage").Client.Wanted.Objects.ClientTool.Components.Tools.Guns.Shooter)
                local originalShoot = Shooter._shoot
                Shooter._shoot = function(self)
                    self.ammo = 9999
                    self.totalAmmo = 9999
                    return originalShoot(self)
                end
            end
        })

        Tabs.Main:Button({
            Title = "无后坐力",
            Callback = function()
                if getgenv()._seNoRecoilInstalled then return end
                getgenv()._seNoRecoilInstalled = true
                local Shooter = require(game:GetService("ReplicatedStorage").Client.Wanted.Objects.ClientTool.Components.Tools.Guns.Shooter)
                local originalShoot = Shooter._shoot
                Shooter._shoot = function(self)
                    self.recoil = {firstShotKick = 0, climb = 0, spread = 0}
                    return originalShoot(self)
                end
            end
        })

        Tabs.Main:Button({
            Title = "无散布",
            Callback = function()
                if getgenv()._seNoSpreadInstalled then return end
                getgenv()._seNoSpreadInstalled = true
                local Shooter = require(game:GetService("ReplicatedStorage").Client.Wanted.Objects.ClientTool.Components.Tools.Guns.Shooter)
                local originalShoot = Shooter._shoot
                Shooter._shoot = function(self)
                    self.aim = {spreadAngle = 0, zeroing = 1000}
                    return originalShoot(self)
                end
            end
        })

        Tabs.Main:Button({
            Title = "快射",
            Callback = function()
                if getgenv()._seFastFireInstalled then return end
                getgenv()._seFastFireInstalled = true
                local Shooter = require(game:GetService("ReplicatedStorage").Client.Wanted.Objects.ClientTool.Components.Tools.Guns.Shooter)
                local originalShoot = Shooter._shoot
                Shooter._shoot = function(self)
                    self.tool.fireDebounce = 0
                    self.tool.fireMode = "auto"
                    return originalShoot(self)
                end
            end
        })

        Tabs.Main:Button({
            Title = "无装弹",
            Callback = function()
                if getgenv()._seNoReloadInstalled then return end
                getgenv()._seNoReloadInstalled = true
                local Shooter = require(game:GetService("ReplicatedStorage").Client.Wanted.Objects.ClientTool.Components.Tools.Guns.Shooter)
                local originalShoot = Shooter._shoot
                Shooter._shoot = function(self)
                    self.ammoData = {reloadTime = 0, magSize = 9999}
                    return originalShoot(self)
                end
            end
        })

        local ImmuneTurret = false
        local originalFireServer = nil
        local TurretBypassInstalled = false

        Tabs.Main:Toggle({
            Title = "绕过炮塔伤害",
            Default = ImmuneTurret,
            Callback = function(v)
                ImmuneTurret = v
                if v then
                    if TurretBypassInstalled then return end
                    TurretBypassInstalled = true
                    local ReplicatedStorage = game:GetService("ReplicatedStorage")
                    local Network = require(ReplicatedStorage.Shared.Core.Network)
                    local previousFireServer = Network.FireServer
                    originalFireServer = previousFireServer
                    Network.FireServer = function(event, ...)
                        if event == "registerLocalHit" then
                            local args = {...}
                            if #args >= 1 then
                                local attacker = args[1]
                                if attacker == "Turret" or (type(attacker) == "table" and attacker.Type == "Turret") then
                                    return nil
                                end
                            end
                        end
                        return previousFireServer(event, ...)
                    end
                else
                    if originalFireServer then
                        local ReplicatedStorage = game:GetService("ReplicatedStorage")
                        local Network = require(ReplicatedStorage.Shared.Core.Network)
                        Network.FireServer = originalFireServer
                        originalFireServer = nil
                        TurretBypassInstalled = false
                    end
                end
            end
        })

        local AntiGas = {
            Start = function() end,
            Stop = function() end,
            IsActive = function() return false end,
            DisableGasPumps = function() return 0 end,
            ForceBlockGasDamage = function() end
        }

        local Devv, NetworkModule
        do
            local devvInstance = ReplicatedStorage:FindFirstChild("Devv") or ReplicatedStorage:WaitForChild("Devv", 5)
            if devvInstance then
                local ok, devvResult = pcall(require, devvInstance)
                if ok and devvResult then
                    Devv = devvResult
                    local okNet, netResult = pcall(function()
                        return Devv.load("Network")
                    end)
                    if okNet and netResult then
                        NetworkModule = netResult
                    end
                end
            end
        end

        if Devv and NetworkModule then
            local originalFunctions = {}
            local hookedRemotes = {}
            local AntiGasDamage = false

            local function IsGasDamageEvent(remoteName, ...)
                if not remoteName then return false end
                if remoteName == "gassed" then
                    return true
                end
                local args = {...}
                for _, arg in ipairs(args) do
                    if type(arg) == "string" then
                        local lowerArg = arg:lower()
                        if lowerArg:find("gas") or lowerArg:find("gassed") or lowerArg:find("poison") or lowerArg:find("toxic") then
                            return true
                        end
                    end
                end
                return false
            end

            local function HookFireServer()
                if not originalFunctions.FireServer then
                    originalFunctions.FireServer = NetworkModule.FireServer
                    NetworkModule.FireServer = function(remoteName, ...)
                        if AntiGasDamage and IsGasDamageEvent(remoteName, ...) then
                            hookedRemotes[remoteName] = true
                            if remoteName == "gassed" then
                                hookedRemotes.LastBlocked = os.time()
                            end
                            return nil
                        end
                        return originalFunctions.FireServer(remoteName, ...)
                    end
                end
            end

            local function HookBindEvent()
                if not originalFunctions.BindEvent then
                    originalFunctions.BindEvent = NetworkModule.BindEvent
                    NetworkModule.BindEvent = function(remoteName, callback)
                        local wrappedCallback = function(...)
                            if AntiGasDamage and IsGasDamageEvent(remoteName, ...) then
                                hookedRemotes[remoteName] = true
                                return
                            end
                            return callback(...)
                        end
                        return originalFunctions.BindEvent(remoteName, wrappedCallback)
                    end
                end
            end

            local function HookGasZoneDetection()
                local gasZoneModule
                pcall(function()
                    gasZoneModule = require(ReplicatedStorage.Client.Wanted.Objects.ClientProp.Props.GasZone)
                end)
                if not gasZoneModule then return end
                if not originalFunctions._updateGas then
                    originalFunctions._updateGas = gasZoneModule._updateGas
                    gasZoneModule._updateGas = function(self)
                        if AntiGasDamage then
                            local model = self.model
                            if model and model:GetAttribute("isOn") then
                                for _, v in model:GetChildren() do
                                    if v.Name == "GasZone" then
                                        v.Gas.Enabled = true
                                    end
                                end
                            end
                            return
                        end
                        return originalFunctions._updateGas(self)
                    end
                end
            end

            local function HookGasPumpDamage()
                local function ProcessGasPumps()
                    if not AntiGasDamage then return end
                    for _, workspaceFolder in ipairs(workspace:GetChildren()) do
                        if workspaceFolder.Name == "Local" then
                            local objectsFolder = workspaceFolder:FindFirstChild("Objects")
                            if objectsFolder then
                                for _, obj in ipairs(objectsFolder:GetChildren()) do
                                    if obj.Name == "GasPump" then
                                        obj:SetAttribute("isOn", false)
                                        for _, child in ipairs(obj:GetChildren()) do
                                            if child.Name == "GasZone" then
                                                if child:FindFirstChild("Gas") then
                                                    child.Gas.Enabled = false
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                local processConnection
                processConnection = RunService.Heartbeat:Connect(function()
                    if AntiGasDamage then
                        pcall(ProcessGasPumps)
                    else
                        if processConnection then
                            processConnection:Disconnect()
                        end
                    end
                end)
                return processConnection
            end

            local function PreventGasZoneIntersection()
                local mathUtilModule
                pcall(function()
                    mathUtilModule = Devv.load("MathUtil")
                end)
                if not mathUtilModule then return end
                if not originalFunctions.PointIntersectsPart then
                    originalFunctions.PointIntersectsPart = mathUtilModule.PointIntersectsPart
                    mathUtilModule.PointIntersectsPart = function(point, part)
                        if AntiGasDamage then
                            if part and part.Parent and part.Parent.Name == "GasZone" then
                                return false
                            end
                        end
                        return originalFunctions.PointIntersectsPart(point, part)
                    end
                end
            end

            local function StartAntiGasDamage()
                if AntiGasDamage then return end
                AntiGasDamage = true
                hookedRemotes = {}
                HookFireServer()
                HookBindEvent()
                HookGasZoneDetection()
                HookGasPumpDamage()
                PreventGasZoneIntersection()
            end

            local function StopAntiGasDamage()
                if not AntiGasDamage then return end
                AntiGasDamage = false
                for name, originalFunc in pairs(originalFunctions) do
                    if name == "_updateGas" then
                        local gasZoneModule = require(ReplicatedStorage.Client.Wanted.Objects.ClientProp.Props.GasZone)
                        gasZoneModule._updateGas = originalFunc
                    elseif name == "PointIntersectsPart" then
                        local mathUtilModule = Devv.load("MathUtil")
                        if mathUtilModule then
                            mathUtilModule.PointIntersectsPart = originalFunc
                        end
                    else
                        NetworkModule[name] = originalFunc
                    end
                end
                originalFunctions = {}
            end

            local function DisableAllGasPumps()
                local disabledCount = 0
                for _, workspaceFolder in ipairs(workspace:GetChildren()) do
                    if workspaceFolder.Name == "Local" then
                        local objectsFolder = workspaceFolder:FindFirstChild("Objects")
                        if objectsFolder then
                            for _, obj in ipairs(objectsFolder:GetChildren()) do
                                if obj.Name == "GasPump" then
                                    obj:SetAttribute("isOn", false)
                                    for _, child in ipairs(obj:GetChildren()) do
                                        if child.Name == "GasZone" and child:FindFirstChild("Gas") then
                                            child.Gas.Enabled = false
                                        end
                                    end
                                    disabledCount = disabledCount + 1
                                end
                            end
                        end
                    end
                end
                return disabledCount
            end

            AntiGas = {
                Start = StartAntiGasDamage,
                Stop = StopAntiGasDamage,
                IsActive = function() return AntiGasDamage end,
                DisableGasPumps = DisableAllGasPumps,
                ForceBlockGasDamage = function()
                    local originalFireServer = NetworkModule.FireServer
                    NetworkModule.FireServer = function(remoteName, ...)
                        if remoteName == "gassed" then
                            return nil
                        end
                        return originalFireServer(remoteName, ...)
                    end
                    task.delay(5, function()
                        NetworkModule.FireServer = originalFireServer
                    end)
                end
            }
        end

        Tabs.Main:Toggle({
            Title = "绕过毒气伤害",
            Value = false,
            Callback = function(Value)
                if Value then
                    AntiGas.Start()
                    AntiGas.DisableGasPumps()
                else
                    AntiGas.Stop()
                end
            end
        })

        local CarSpeedSystem = {
            ActiveVehicles = {},
            Connections = {},
            OriginalValues = {},
            CurrentMultiplier = 1,
            VehicleCache = {}
        }

        function CarSpeedSystem:GetCurrentVehicle()
            local character = LocalPlayer.Character
            if not character then return nil end
            local humanoid = character:FindFirstChild("Humanoid")
            if not humanoid then return nil end
            local seat = humanoid.SeatPart
            if not seat then return nil end
            return seat:FindFirstAncestorWhichIsA("Model")
        end

        function CarSpeedSystem:GetVehicleRoot(vehicle)
            if not vehicle then return nil end
            return vehicle:FindFirstChild("Chassis") or vehicle.PrimaryPart
        end

        function CarSpeedSystem:GetVehicleData(vehicle)
            if not vehicle then return nil end
            for _, desc in pairs(vehicle:GetDescendants()) do
                if desc:IsA("VehicleSeat") then
                    return desc
                end
            end
            return nil
        end

        function CarSpeedSystem:ApplySpeedBoost(vehicle, multiplier)
            if not vehicle then return end
            self.CurrentMultiplier = multiplier
            if self.Connections[vehicle] then
                self.Connections[vehicle]:Disconnect()
                self.Connections[vehicle] = nil
            end
            if multiplier == 1 then
                if self.OriginalValues[vehicle] then
                    local orig = self.OriginalValues[vehicle]
                    local seat = self:GetVehicleData(vehicle)
                    if seat and seat:IsA("VehicleSeat") then
                        seat.MaxSpeed = orig.maxSpeed or seat.MaxSpeed
                        seat.Torque = orig.torque or seat.Torque
                    end
                    self.OriginalValues[vehicle] = nil
                end
                self.ActiveVehicles[vehicle] = nil
                return
            end
            local root = self:GetVehicleRoot(vehicle)
            if not root then return end
            local seat = self:GetVehicleData(vehicle)
            if seat and seat:IsA("VehicleSeat") then
                if not self.OriginalValues[vehicle] then
                    self.OriginalValues[vehicle] = {
                        maxSpeed = seat.MaxSpeed,
                        torque = seat.Torque
                    }
                end
                seat.MaxSpeed = (self.OriginalValues[vehicle].maxSpeed or 50) * multiplier
                seat.Torque = (self.OriginalValues[vehicle].torque or 10) * multiplier
            end
            self.ActiveVehicles[vehicle] = true
            local connection = RunService.Heartbeat:Connect(function(dt)
                if not vehicle or not vehicle.Parent or not root or not root.Parent then
                    if self.Connections[vehicle] then
                        self.Connections[vehicle]:Disconnect()
                        self.Connections[vehicle] = nil
                    end
                    self.ActiveVehicles[vehicle] = nil
                    return
                end
                local seatNow = self:GetVehicleData(vehicle)
                local throttle = 0
                if seatNow then
                    throttle = seatNow.ThrottleFloat or seatNow.Throttle or 0
                end
                if math.abs(throttle) < 0.05 then
                    return
                end
                local currentVelocity = root.AssemblyLinearVelocity
                local speed = currentVelocity.Magnitude
                if speed > 1 then
                    local boostFactor = (multiplier - 1) * 0.15
                    local forward = root.CFrame.LookVector
                    local throttleDir = throttle > 0 and 1 or -1
                    local signedSpeed = forward:Dot(currentVelocity)
                    if signedSpeed * throttleDir <= 0 then
                        return
                    end
                    local horizontalDir = Vector3.new(forward.X, 0, forward.Z)
                    if horizontalDir.Magnitude > 0.1 then
                        horizontalDir = horizontalDir.Unit * throttleDir
                        local boostForce = horizontalDir * speed * boostFactor * 60
                        local maxBoost = 200 * multiplier
                        if boostForce.Magnitude > maxBoost then
                            boostForce = boostForce.Unit * maxBoost
                        end
                        root.AssemblyLinearVelocity = currentVelocity + boostForce * dt
                    end
                end
            end)
            self.Connections[vehicle] = connection
        end

        function CarSpeedSystem:ResetAll()
            for vehicle, conn in pairs(self.Connections) do
                if conn then conn:Disconnect() end
                if self.OriginalValues[vehicle] then
                    local orig = self.OriginalValues[vehicle]
                    local seat = self:GetVehicleData(vehicle)
                    if seat and seat:IsA("VehicleSeat") then
                        seat.MaxSpeed = orig.maxSpeed or seat.MaxSpeed
                        seat.Torque = orig.torque or seat.Torque
                    end
                end
            end
            self.Connections = {}
            self.ActiveVehicles = {}
            self.OriginalValues = {}
            self.CurrentMultiplier = 1
            self.VehicleCache = {}
        end

        local lastVehicleCheck = 0
        local vehicleCheckConnection = RunService.Heartbeat:Connect(function()
            local now = tick()
            if now - lastVehicleCheck > 0.5 then
                lastVehicleCheck = now
                CarSpeedSystem:UpdateAllVehicles()
            end
            local currentVehicle = CarSpeedSystem:GetCurrentVehicle()
            local cachedVehicle = CarSpeedSystem.VehicleCache["current"]
            if currentVehicle ~= cachedVehicle then
                if cachedVehicle and CarSpeedSystem.ActiveVehicles[cachedVehicle] then
                    CarSpeedSystem:ApplySpeedBoost(cachedVehicle, 1)
                end
                CarSpeedSystem.VehicleCache["current"] = currentVehicle
                if currentVehicle and CarSpeedSystem.CurrentMultiplier ~= 1 then
                    CarSpeedSystem:ApplySpeedBoost(currentVehicle, CarSpeedSystem.CurrentMultiplier)
                end
            end
        end)

        Tabs.Main:Section({ Title = "汽车", Icon = "car" })

        Tabs.Main:Slider({
            Title = "速度倍数",
            Value = { Min = 1, Max = 5, Default = 1 },
            Callback = function(Value)
                CarSpeedSystem.CurrentMultiplier = Value
                local vehicle = CarSpeedSystem:GetCurrentVehicle()
                if vehicle then
                    CarSpeedSystem:ApplySpeedBoost(vehicle, Value)
                    F:Notify({
                        Title = "汽车控制",
                        Content = string.format("速度倍数: %.1fx", Value),
                        Icon = "zap",
                        Duration = 2
                    })
                else
                    F:Notify({
                        Title = "汽车控制",
                        Content = "未检测到车辆",
                        Icon = "x",
                        Duration = 2
                    })
                end
            end
        })

        Tabs.Main:Button({
            Title = "恢复正常速度",
            Callback = function()
                CarSpeedSystem.CurrentMultiplier = 1
                local vehicle = CarSpeedSystem:GetCurrentVehicle()
                if vehicle then
                    CarSpeedSystem:ApplySpeedBoost(vehicle, 1)
                end
                F:Notify({
                    Title = "汽车控制",
                    Content = "已恢复正常速度",
                    Icon = "check-circle",
                    Duration = 2
                })
            end
        })

        Tabs.Main:Button({
            Title = "重置所有车辆",
            Callback = function()
                CarSpeedSystem:ResetAll()
                F:Notify({
                    Title = "汽车控制",
                    Content = "已重置所有车辆设置",
                    Icon = "refresh-cw",
                    Duration = 2
                })
            end
        })

        local speedDisplay = Tabs.Main:Paragraph({
            Title = "车辆状态",
            Desc = "速度: 0 studs/s\n倍数: 1.0x\n状态: 未驾驶"
        })

        local speedUpdateConnection = RunService.Heartbeat:Connect(function()
            local vehicle = CarSpeedSystem:GetCurrentVehicle()
            local multiplier = CarSpeedSystem.CurrentMultiplier
            if vehicle then
                local root = CarSpeedSystem:GetVehicleRoot(vehicle)
                local speed = root and math.floor(root.AssemblyLinearVelocity.Magnitude) or 0
                local kmh = math.floor(speed * 0.0682 * 3.6)
                speedDisplay:SetDesc(string.format("速度: %d studs/s (%d km/h)\n倍数: %.1fx\n状态: 驾驶中", speed, kmh, multiplier))
            else
                speedDisplay:SetDesc(string.format("速度: 0 studs/s\n倍数: %.1fx\n状态: 未驾驶", multiplier))
            end
        end)

        _G.CarSpeedSystem = CarSpeedSystem

        Players.PlayerRemoving:Connect(function(player)
            if player == LocalPlayer then
                if vehicleCheckConnection then vehicleCheckConnection:Disconnect() end
                if speedUpdateConnection then speedUpdateConnection:Disconnect() end
                CarSpeedSystem:ResetAll()
            end
        end)

        Tabs.Visual:Section({ Title = "ESP设置", Icon = "eye" })
        local LinNiESP = {
            a = Players,
            b = RunService,
            c = nil,
            d = workspace.CurrentCamera,
            e = {},
            TeamColors = {
                ["none"] = Color3.new(1, 1, 1),
                ["syndicate"] = Color3.fromRGB(128, 0, 128),
                ["police"] = Color3.fromRGB(0, 100, 255),
                ["wanted"] = Color3.fromRGB(255, 165, 0),
                ["admin"] = Color3.fromRGB(255, 0, 0)
            },
            f = {
                {"Head", "UpperTorso"},
                {"UpperTorso", "RightUpperArm"},
                {"RightUpperArm", "RightLowerArm"},
                {"RightLowerArm", "RightHand"},
                {"UpperTorso", "LeftUpperArm"},
                {"LeftUpperArm", "LeftLowerArm"},
                {"LeftLowerArm", "LeftHand"},
                {"UpperTorso", "LowerTorso"},
                {"LowerTorso", "LeftUpperLeg"},
                {"LeftUpperLeg", "LeftLowerLeg"},
                {"LeftLowerLeg", "LeftFoot"},
                {"LowerTorso", "RightUpperLeg"},
                {"RightUpperLeg", "RightLowerLeg"},
                {"RightLowerLeg", "RightFoot"}
            },
            g = {
                BoxOutlineColor = Color3.new(0, 0, 0),
                BoxColor = Color3.new(1, 1, 1),
                NameColor = Color3.new(1, 1, 1),
                HealthOutlineColor = Color3.new(0, 0, 0),
                HealthHighColor = Color3.new(0, 1, 0),
                HealthLowColor = Color3.new(1, 0, 0),
                TeamOutlineColor = Color3.new(0, 0, 0),
                TeamColor = Color3.new(1, 1, 1),
                CharSize = Vector2.new(4, 6),
                Teamcheck = false,
                ShowTeam = true,
                WallCheck = false,
                Enabled = false,
                ShowBox = false,
                BoxType = "2D",
                ShowName = false,
                ShowHealth = false,
                ShowDistance = false,
                ShowSkeletons = false,
                ShowTracer = false,
                TracerColor = Color3.new(1, 1, 1),
                TracerThickness = 2,
                SkeletonsColor = Color3.new(1, 1, 1),
                TracerPosition = "Bottom"
            },
            playerConnections = {}
        }

        local function getPlayerStars(player)
            local starsValue = player:GetAttribute("stars") or player:GetAttribute("Stars")
            if not starsValue then
                local childStars = player:FindFirstChild("stars") or player:FindFirstChild("Stars")
                if childStars and childStars:IsA("ValueBase") then
                    starsValue = childStars.Value
                end
            end
            return tonumber(starsValue) or 0
        end

        function LinNiESP:getPlayerTeam(player)
            local success, teamName = pcall(function()
                if player.UserId and F[player.UserId] then
                    return "admin"
                end
                local successRank, rank = pcall(function()
                    return player:GetRankInGroup(4856485)
                end)
                if successRank and rank and rank > 1 then
                    return "admin"
                end
                local stars = getPlayerStars(player)
                if stars >= 1 then
                    return "wanted"
                end
                local team = player:GetAttribute("currentTeam") or player.currentTeam
                if team then
                    return string.lower(tostring(team))
                end
                return "none"
            end)
            if success and teamName then
                return teamName
            end
            return "none"
        end

        function LinNiESP:getTeamColor(player)
            local teamName = self:getPlayerTeam(player)
            return self.TeamColors[teamName] or Color3.new(1, 1, 1)
        end

        function LinNiESP:isSameTeam(player1, player2)
            local team1 = self:getPlayerTeam(player1)
            local team2 = self:getPlayerTeam(player2)
            return team1 == team2
        end

        function LinNiESP:Init()
            self.c = self.a.LocalPlayer
        end

        function LinNiESP:h(i, j)
            local k = Drawing.new(i)
            for l, m in pairs(j) do
                k[l] = m
            end
            return k
        end

        function LinNiESP:n(o)
            local p = {
                tracer = self:h("Line", {Thickness = self.g.TracerThickness, Color = self.g.TracerColor, Transparency = 0.5}),
                boxOutline = self:h("Square", {Color = self.g.BoxOutlineColor, Thickness = 3, Filled = false}),
                box = self:h("Square", {Color = self.g.BoxColor, Thickness = 1, Filled = false}),
                name = self:h("Text", {Color = self.g.NameColor, Outline = true, Center = true, Size = 13}),
                healthOutline = self:h("Line", {Thickness = 3, Color = self.g.HealthOutlineColor}),
                health = self:h("Line", {Thickness = 1}),
                distance = self:h("Text", {Color = Color3.new(1, 1, 1), Size = 12, Outline = true, Center = true}),
                team = self:h("Text", {Color = self.g.TeamColor, Size = 12, Outline = true, Center = true, OutlineColor = self.g.TeamOutlineColor}),
                boxLines = {}
            }
            self.e[o] = p
            self.e[o]["skeletonlines"] = {}
        end

        function LinNiESP:q(o)
            local r = o.Character
            if not r then return false end
            local s = r:FindFirstChild("HumanoidRootPart")
            if not s then return false end
            local t = Ray.new(self.d.CFrame.Position, (s.Position - self.d.CFrame.Position).Unit * (s.Position - self.d.CFrame.Position).Magnitude)
            local u, v = workspace:FindPartOnRayWithIgnoreList(t, {self.c.Character, r})
            return u and u:IsA("Part")
        end

        function LinNiESP:w(o)
            local p = self.e[o]
            if not p then return end
            for x, k in pairs(p) do
                if type(k) == "table" then
                    for _, item in pairs(k) do
                        pcall(function()
                            if item and item.Destroy then
                                item:Destroy()
                            elseif item and item.Remove then
                                item:Remove()
                            end
                        end)
                    end
                else
                    pcall(function()
                        if k and k.Destroy then
                            k:Destroy()
                        elseif k and k.Remove then
                            k:Remove()
                        end
                    end)
                end
            end
            self.e[o] = nil
            if self.playerConnections[o] then
                for _, conn in pairs(self.playerConnections[o]) do
                    pcall(function() conn:Disconnect() end)
                end
                self.playerConnections[o] = nil
            end
        end

        function LinNiESP:y()
            pcall(function()
                for o, p in pairs(self.e) do
                    if not o or not o.Parent then
                        self:w(o)
                       
                    end
                    local r = o.Character
                    local sameTeam = self.g.Teamcheck and self:isSameTeam(o, self.c)
                    if r and (not self.g.Teamcheck or not sameTeam) then
                        local s = r:FindFirstChild("HumanoidRootPart")
                        local A = r:FindFirstChild("Head")
                        local B = r:FindFirstChild("Humanoid")
                        local C = self.g.WallCheck and self:q(o)
                        local D = not C and self.g.Enabled
                        if s and A and B and D then
                            local v, E = self.d:WorldToViewportPoint(s.Position)
                            if E then
                                local F = self.d:WorldToViewportPoint(s.Position)
                                local G = (self.d:WorldToViewportPoint(s.Position - Vector3.new(0, 3, 0)).Y - self.d:WorldToViewportPoint(s.Position + Vector3.new(0, 2.6, 0)).Y) / 2
                                local H = Vector2.new(math.floor(G * 1.8), math.floor(G * 1.9))
                                local I = Vector2.new(math.floor(F.X - G * 1.8 / 2), math.floor(F.Y - G * 1.6 / 2))
                                local teamColor = self:getTeamColor(o)
                                local teamName = self:getPlayerTeam(o)
                                if teamName == "admin" then
                                    teamName = "[管理员]"
                                elseif teamName == "wanted" then
                                    teamName = "[Wanted]"
                                else
                                    teamName = "[" .. teamName .. "]"
                                end
                                if self.g.ShowName and self.g.Enabled then
                                    pcall(function()
                                        p.name.Visible = true
                                        p.name.Text = string.lower(o.Name)
                                        p.name.Position = Vector2.new(H.X / 2 + I.X, I.Y - 16)
                                        p.name.Color = teamColor
                                    end)
                                else
                                    pcall(function()
                                        p.name.Visible = false
                                    end)
                                end
                                if self.g.ShowTeam and self.g.Enabled then
                                    pcall(function()
                                        p.team.Visible = true
                                        p.team.Text = teamName
                                        p.team.Position = Vector2.new(H.X / 2 + I.X, I.Y - (self.g.ShowName and 28 or 16))
                                        p.team.Color = teamColor
                                    end)
                                else
                                    pcall(function()
                                        p.team.Visible = false
                                    end)
                                end
                                if self.g.ShowBox and self.g.Enabled then
                                    if self.g.BoxType == "2D" then
                                        pcall(function()
                                            p.boxOutline.Size = H
                                            p.boxOutline.Position = I
                                            p.box.Size = H
                                            p.box.Position = I
                                            p.box.Color = teamColor
                                            p.box.Visible = true
                                            p.boxOutline.Visible = true
                                            for x, J in ipairs(p.boxLines) do
                                                pcall(function()
                                                    if J and J.Destroy then
                                                        Window:Destroy()
                                                    elseif J and J.Remove then
                                                        Window:Remove()
                                                    end
                                                end)
                                            end
                                            p.boxLines = {}
                                        end)
                                    elseif self.g.BoxType == "Corner Box Esp" then
                                        pcall(function()
                                            local K = H.X / 5
                                            local L = H.Y / 6
                                            local M = 1
                                            if #p.boxLines == 0 then
                                                for N = 1, 16 do
                                                    local O = self:h("Line", {Thickness = 1, Color = teamColor, Transparency = 1})
                                                    p.boxLines[#p.boxLines + 1] = O
                                                end
                                            end
                                            local P = p.boxLines
                                            if #P >= 16 then
                                                P[1].From = Vector2.new(I.X - M, I.Y - M)
                                                P[1].To = Vector2.new(I.X + K, I.Y - M)
                                                P[2].From = Vector2.new(I.X - M, I.Y - M)
                                                P[2].To = Vector2.new(I.X - M, I.Y + L)
                                                P[3].From = Vector2.new(I.X + H.X - K, I.Y - M)
                                                P[3].To = Vector2.new(I.X + H.X + M, I.Y - M)
                                                P[4].From = Vector2.new(I.X + H.X + M, I.Y - M)
                                                P[4].To = Vector2.new(I.X + H.X + M, I.Y + L)
                                                P[5].From = Vector2.new(I.X - M, I.Y + H.Y - L)
                                                P[5].To = Vector2.new(I.X - M, I.Y + H.Y + M)
                                                P[6].From = Vector2.new(I.X - M, I.Y + H.Y + M)
                                                P[6].To = Vector2.new(I.X + K, I.Y + H.Y + M)
                                                P[7].From = Vector2.new(I.X + H.X - K, I.Y + H.Y + M)
                                                P[7].To = Vector2.new(I.X + H.X + M, I.Y + H.Y + M)
                                                P[8].From = Vector2.new(I.X + H.X + M, I.Y + H.Y - L)
                                                P[8].To = Vector2.new(I.X + H.X + M, I.Y + H.Y + M)
                                                for N = 9, 16 do
                                                    if P[N] then
                                                        P[N].Thickness = 2
                                                        P[N].Color = self.g.BoxOutlineColor
                                                        P[N].Transparency = 1
                                                    end
                                                end
                                                if P[9] then P[9].From = Vector2.new(I.X, I.Y) end
                                                if P[9] then P[9].To = Vector2.new(I.X, I.Y + L) end
                                                if P[10] then P[10].From = Vector2.new(I.X, I.Y) end
                                                if P[10] then P[10].To = Vector2.new(I.X + K, I.Y) end
                                                if P[11] then P[11].From = Vector2.new(I.X + H.X - K, I.Y) end
                                                if P[11] then P[11].To = Vector2.new(I.X + H.X, I.Y) end
                                                if P[12] then P[12].From = Vector2.new(I.X + H.X, I.Y) end
                                                if P[12] then P[12].To = Vector2.new(I.X + H.X, I.Y + L) end
                                                if P[13] then P[13].From = Vector2.new(I.X, I.Y + H.Y - L) end
                                                if P[13] then P[13].To = Vector2.new(I.X, I.Y + H.Y) end
                                                if P[14] then P[14].From = Vector2.new(I.X, I.Y + H.Y) end
                                                if P[14] then P[14].To = Vector2.new(I.X + K, I.Y + H.Y) end
                                                if P[15] then P[15].From = Vector2.new(I.X + H.X - K, I.Y + H.Y) end
                                                if P[15] then P[15].To = Vector2.new(I.X + H.X, I.Y + H.Y) end
                                                if P[16] then P[16].From = Vector2.new(I.X + H.X, I.Y + H.Y - L) end
                                                if P[16] then P[16].To = Vector2.new(I.X + H.X, I.Y + H.Y) end
                                                for x, J in ipairs(P) do
                                                    if J then J.Visible = true end
                                                end
                                                p.box.Visible = false
                                                p.boxOutline.Visible = false
                                            end
                                        end)
                                    end
                                else
                                    pcall(function()
                                        p.box.Visible = false
                                        p.boxOutline.Visible = false
                                        for x, J in ipairs(p.boxLines) do
                                            pcall(function()
                                                if J and J.Destroy then
                                                    Window:Destroy()
                                                elseif J and J.Remove then
                                                    Window:Remove()
                                                end
                                            end)
                                        end
                                        p.boxLines = {}
                                    end)
                                end
                                if self.g.ShowHealth and self.g.Enabled then
                                    pcall(function()
                                        p.healthOutline.Visible = true
                                        p.health.Visible = true
                                        local Q = B.Health / B.MaxHealth
                                        p.healthOutline.From = Vector2.new(I.X - 6, I.Y + H.Y)
                                        p.healthOutline.To = Vector2.new(p.healthOutline.From.X, p.healthOutline.From.Y - H.Y)
                                        p.health.From = Vector2.new(I.X - 5, I.Y + H.Y)
                                        p.health.To = Vector2.new(p.health.From.X, p.health.From.Y - Q * H.Y)
                                        p.health.Color = self.g.HealthLowColor:Lerp(self.g.HealthHighColor, Q)
                                    end)
                                else
                                    pcall(function()
                                        p.healthOutline.Visible = false
                                        p.health.Visible = false
                                    end)
                                end
                                if self.g.ShowDistance and self.g.Enabled then
                                    pcall(function()
                                        local R = (self.d.CFrame.Position - s.Position).Magnitude
                                        p.distance.Text = string.format("%.1f studs", R)
                                        p.distance.Position = Vector2.new(I.X + H.X / 2, I.Y + H.Y + 5)
                                        p.distance.Visible = true
                                    end)
                                else
                                    pcall(function()
                                        p.distance.Visible = false
                                    end)
                                end
                                if self.g.ShowSkeletons and self.g.Enabled then
                                    pcall(function()
                                        if #p["skeletonlines"] == 0 then
                                            for x, S in ipairs(self.f) do
                                                local T, U = S[1], S[2]
                                                if r:FindFirstChild(T) and r:FindFirstChild(U) then
                                                    local V = self:h("Line", {Thickness = 1, Color = self.g.SkeletonsColor, Transparency = 1})
                                                    p["skeletonlines"][#p["skeletonlines"] + 1] = {V, T, U}
                                                end
                                            end
                                        end
                                        for x, W in ipairs(p["skeletonlines"]) do
                                            local V = W[1]
                                            local T, U = W[2], W[3]
                                            if r:FindFirstChild(T) and r:FindFirstChild(U) then
                                                local headPos = r:FindFirstChild("Head")
                                                if headPos then
                                                    local headScreenPos = self.d:WorldToViewportPoint(headPos.Position)
                                                    local partScreenPos = self.d:WorldToViewportPoint(r[T].Position)
                                                    local targetScreenPos = self.d:WorldToViewportPoint(r[U].Position)
                                                    V.From = Vector2.new(partScreenPos.X, partScreenPos.Y)
                                                    V.To = Vector2.new(targetScreenPos.X, targetScreenPos.Y)
                                                    V.Color = teamColor
                                                    V.Visible = true
                                                end
                                            else
                                                pcall(function()
                                                    if V and V.Destroy then
                                                        V:Destroy()
                                                    elseif V and V.Remove then
                                                        V:Remove()
                                                    end
                                                end)
                                            end
                                        end
                                    end)
                                else
                                    pcall(function()
                                        for x, W in ipairs(p["skeletonlines"]) do
                                            local V = W[1]
                                            pcall(function()
                                                if V and V.Destroy then
                                                    V:Destroy()
                                                elseif V and V.Remove then
                                                    V:Remove()
                                                end
                                            end)
                                        end
                                        p["skeletonlines"] = {}
                                    end)
                                end
                                if self.g.ShowTracer and self.g.Enabled then
                                    pcall(function()
                                        local Z
                                        if self.g.TracerPosition == "Top" then
                                            Z = 0
                                        elseif self.g.TracerPosition == "Middle" then
                                            Z = self.d.ViewportSize.Y / 2
                                        else
                                            Z = self.d.ViewportSize.Y
                                        end
                                        if self.g.Teamcheck and self:isSameTeam(o, self.c) then
                                            p.tracer.Visible = false
                                        else
                                            p.tracer.Visible = true
                                            local headScreenPos = self.d:WorldToViewportPoint(A.Position)
                                            p.tracer.From = Vector2.new(self.d.ViewportSize.X / 2, Z)
                                            p.tracer.To = Vector2.new(headScreenPos.X, headScreenPos.Y)
                                            p.tracer.Color = teamColor
                                        end
                                    end)
                                else
                                    pcall(function()
                                        p.tracer.Visible = false
                                    end)
                                end
                            else
                                pcall(function()
                                    for x, k in pairs(p) do
                                        if type(k) ~= "table" and k then
                                            k.Visible = false
                                        end
                                    end
                                    for x, W in ipairs(p["skeletonlines"]) do
                                        local V = W[1]
                                        pcall(function()
                                            if V and V.Destroy then
                                                V:Destroy()
                                            end
                                        end)
                                    end
                                    p["skeletonlines"] = {}
                                    for x, J in ipairs(p.boxLines) do
                                        pcall(function()
                                            if J and J.Destroy then
                                                Window:Destroy()
                                            elseif J and J.Remove then
                                                Window:Remove()
                                            end
                                        end)
                                    end
                                    p.boxLines = {}
                                end)
                            end
                        else
                            pcall(function()
                                for x, k in pairs(p) do
                                    if type(k) ~= "table" and k then
                                        k.Visible = false
                                    end
                                end
                                for x, W in ipairs(p["skeletonlines"]) do
                                    local V = W[1]
                                    pcall(function()
                                        if V and V.Destroy then
                                            V:Destroy()
                                        end
                                    end)
                                end
                                p["skeletonlines"] = {}
                                for x, J in ipairs(p.boxLines) do
                                    pcall(function()
                                        if J then
                                            Window:Destroy()
                                        elseif J and J.Remove then
                                            Window:Remove()
                                        end
                                    end)
                                end
                                p.boxLines = {}
                            end)
                        end
                    else
                        pcall(function()
                            for x, k in pairs(p) do
                                if type(k) ~= "table" and k then
                                    k.Visible = false
                                end
                            end
                            for x, W in ipairs(p["skeletonlines"]) do
                                local V = W[1]
                                pcall(function()
                                    if V and V.Destroy then
                                        V:Destroy()
                                    elseif V and V.Remove then
                                        V:Remove()
                                    end
                                end)
                            end
                            p["skeletonlines"] = {}
                            for x, J in ipairs(p.boxLines) do
                                pcall(function()
                                    if J and J.Destroy then
                                        Window:Destroy()
                                    elseif J and J.Remove then
                                        Window:Remove()
                                    end
                                end)
                            end
                            p.boxLines = {}
                        end)
                    end
                end
            end)
        end

        function LinNiESP:Enable()
            if self.g.Enabled then return end
            self.g.Enabled = true
            self:Init()
            for x, o in ipairs(self.a:GetPlayers()) do
                if o ~= self.c then
                    pcall(function()
                        self:n(o)
                        self.playerConnections[o] = {}
                        table.insert(self.playerConnections[o], o.CharacterAdded:Connect(function()
                            task.wait(0.5)
                            if self.e[o] then
                                self:w(o)
                                self:n(o)
                            end
                        end))
                        table.insert(self.playerConnections[o], o.CharacterRemoving:Connect(function()
                            if self.e[o] then
                                local p = self.e[o]
                                for x, k in pairs(p) do
                                    if type(k) ~= "table" and k then
                                        k.Visible = false
                                    end
                                end
                            end
                        end))
                    end)
                end
            end
            self.a.PlayerAdded:Connect(function(o)
                if o ~= self.c then
                    pcall(function()
                        self:n(o)
                        self.playerConnections[o] = {}
                        table.insert(self.playerConnections[o], o.CharacterAdded:Connect(function()
                            task.wait(0.5)
                            if self.e[o] then
                                self:w(o)
                                self:n(o)
                            end
                        end))
                    end)
                end
            end)
            self.a.PlayerRemoving:Connect(function(o)
                pcall(function()
                    self:w(o)
                end)
            end)
            local espConnection = self.b.RenderStepped:Connect(function()
                self:y()
            end)
            table.insert(self.playerConnections, espConnection)
        end

        function LinNiESP:Disable()
            if not self.g.Enabled then return end
            self.g.Enabled = false
            local playersToClean = {}
            for o, _ in pairs(self.e) do
                table.insert(playersToClean, o)
            end
            for _, o in ipairs(playersToClean) do
                self:w(o)
            end
            for _, conn in pairs(self.playerConnections) do
                if type(conn) == "table" then
                    for _, c in pairs(conn) do
                        pcall(function() c:Disconnect() end)
                    end
                else
                    pcall(function() conn:Disconnect() end)
                end
            end
            self.e = {}
            self.playerConnections = {}
        end

        Tabs.Visual:Toggle({
            Title = "启用ESP",
            Value = false,
            Callback = function(Value)
                if Value then
                    LinNiESP:Enable()
                else
                    LinNiESP:Disable()
                end
            end
        })

        Tabs.Visual:Toggle({
            Title = "显示队伍",
            Value = false,
            Callback = function(Value)
                LinNiESP.g.ShowTeam = Value
            end
        })

        Tabs.Visual:Toggle({
            Title = "过滤队友",
            Value = false,
            Callback = function(Value)
                LinNiESP.g.Teamcheck = Value
            end
        })

        Tabs.Visual:Toggle({
            Title = "显示方框",
            Value = false,
            Callback = function(Value)
                LinNiESP.g.ShowBox = Value
            end
        })

        Tabs.Visual:Dropdown({
            Title = "方框类型",
            Values = {"2D", "Corner Box Esp"},
            Value = "2D",
            Callback = function(Value)
                LinNiESP.g.BoxType = Value
            end
        })

        Tabs.Visual:Toggle({
            Title = "显示名字",
            Value = false,
            Callback = function(Value)
                LinNiESP.g.ShowName = Value
            end
        })

        Tabs.Visual:Toggle({
            Title = "显示血量",
            Value = false,
            Callback = function(Value)
                LinNiESP.g.ShowHealth = Value
            end
        })

        Tabs.Visual:Toggle({
            Title = "显示距离",
            Value = false,
            Callback = function(Value)
                LinNiESP.g.ShowDistance = Value
            end
        })

        Tabs.Visual:Toggle({
            Title = "显示骨骼",
            Value = false,
            Callback = function(Value)
                LinNiESP.g.ShowSkeletons = Value
            end
        })

        Tabs.Visual:Toggle({
            Title = "显示追踪线",
            Value = false,
            Callback = function(Value)
                LinNiESP.g.ShowTracer = Value
            end
        })

        Tabs.Visual:Dropdown({
            Title = "追踪线位置",
            Values = {"Top", "Middle", "Bottom"},
            Value = "Bottom",
            Callback = function(Value)
                LinNiESP.g.TracerPosition = Value
            end
        })

        Tabs.Visual:Toggle({
            Title = "穿墙检测",
            Value = false,
            Callback = function(Value)
                LinNiESP.g.WallCheck = Value
            end
        })

        Tabs.Visual:Colorpicker({
            Title = "方框颜色",
            Default = Color3.fromRGB(255, 255, 255),
            Callback = function(Value)
                LinNiESP.g.BoxColor = Value
            end
        })

        Tabs.Visual:Colorpicker({
            Title = "名字颜色",
            Default = Color3.fromRGB(255, 255, 255),
            Callback = function(Value)
                LinNiESP.g.NameColor = Value
            end
        })

        Tabs.Visual:Colorpicker({
            Title = "队伍颜色",
            Default = Color3.fromRGB(255, 255, 255),
            Callback = function(Value)
                LinNiESP.g.TeamColor = Value
            end
        })

        Tabs.Teleport:Toggle({
            Title = "空降",
            Desc = "打开地图 点哪传哪",
            Value = false,
            Callback = function(Value)
                if Value then
                    local MapTiles = ReplicatedStorage:FindFirstChild("Shared") and ReplicatedStorage.Shared:FindFirstChild("MapTiles") or ReplicatedStorage
                    local tiles = {}
                    local tileOrder = {3, 1, 4, 2}
                    local function initTiles()
                        for i = 1, 4 do
                            local tileName = "tile" .. i
                            local tileFolder = MapTiles:FindFirstChild(tileName) or ReplicatedStorage:FindFirstChild(tileName)
                            if tileFolder then
                                local center = tileFolder:FindFirstChild("center")
                                if center then
                                    local mesh = center:FindFirstChild("mesh")
                                    if mesh then
                                        local worldSizeX = mesh.Scale.X
                                        local worldSizeZ = mesh.Scale.Z
                                        tiles[i] = {
                                            index = i,
                                            center = center.CFrame,
                                            invCenter = center.CFrame:Inverse(),
                                            worldSize = Vector3.new(worldSizeX, 0, worldSizeZ),
                                            worldHalfSize = Vector3.new(worldSizeX / 2, 0, worldSizeZ / 2)
                                        }
                                    end
                                end
                            end
                        end
                    end
                    local function isPointInMapFrame(mapFrame, position)
                        local absPos = mapFrame.AbsolutePosition
                        local absSize = mapFrame.AbsoluteSize
                        local guiInset = GuiService:GetGuiInset()
                        local adjusted = position - guiInset
                        return adjusted.X >= absPos.X and adjusted.X <= absPos.X + absSize.X and adjusted.Y >= absPos.Y and adjusted.Y <= absPos.Y + absSize.Y
                    end
                    local function getTile(percentX, percentY)
                        local vx = math.floor(percentX * 2)
                        local vy = math.floor(percentY * 2)
                        local clampedX = math.clamp(vx, 0, 1)
                        local clampedY = math.clamp(vy, 0, 1)
                        return tileOrder[clampedY * 2 + clampedX + 1], clampedX, clampedY
                    end
                    local function getWorldPositionFromPercent(percentX, percentY)
                        local tileIndex, tileX, tileY = getTile(percentX, percentY)
                        local tile = tiles[tileIndex]
                        if tile then
                            local localX = ((percentX - tileX * 0.5) / 0.5 - 0.5) * tile.worldSize.X
                            local localZ = ((percentY - tileY * 0.5) / 0.5 - 0.5) * tile.worldSize.Z
                            return tile.center.Position + tile.center:VectorToWorldSpace(Vector3.new(localX, 0, localZ))
                        end
                        return nil
                    end
                    local function teleportTo(position)
                        local character = LocalPlayer.Character
                        if character then
                            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                            if humanoidRootPart then
                                humanoidRootPart.CFrame = CFrame.new(position.X, position.Y + 50, position.Z)
                            end
                        end
                    end
                    local function findMapHolder()
                        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
                        for _, screenGui in pairs(PlayerGui:GetChildren()) do
                            if screenGui:IsA("ScreenGui") and screenGui.Enabled then
                                local mapFrame = screenGui:FindFirstChild("MapFrame", true)
                                if mapFrame then
                                    local mapHolder = mapFrame:FindFirstChild("MapHolder")
                                    if mapHolder then
                                        local contextFrame = screenGui:FindFirstChild("ContextFrame", true)
                                        if contextFrame and contextFrame.Visible then
                                            return mapHolder, mapFrame
                                        end
                                        if screenGui.Name == "FullMapScreen" then
                                            return mapHolder, mapFrame
                                        end
                                    end
                                end
                            end
                        end
                        return nil, nil
                    end
                    local GuiService = game:GetService("GuiService")
                    local function getPercentFromClick(mapHolder, mousePosition)
                        local holderSize = Vector2.new(mapHolder.Size.X.Offset, mapHolder.Size.Y.Offset)
                        local uiScale = mapHolder:FindFirstChild("UIScale")
                        local zoom = uiScale and uiScale.Scale or 1
                        local scaledSize = holderSize * zoom
                        local holderPosition = mapHolder.Position
                        local mapOffsetX = holderPosition.X.Offset
                        local mapOffsetY = holderPosition.Y.Offset
                        local mapFrame = mapHolder.Parent
                        local frameAbsPos = mapFrame.AbsolutePosition
                        local frameAbsSize = mapFrame.AbsoluteSize
                        local frameCenter = frameAbsPos + frameAbsSize / 2
                        local guiInset = GuiService:GetGuiInset()
                        local adjustedMouse = mousePosition - guiInset
                        local mouseRelativeToCenter = adjustedMouse - frameCenter
                        local clickOffsetX = mouseRelativeToCenter.X - mapOffsetX
                        local clickOffsetY = mouseRelativeToCenter.Y - mapOffsetY
                        local percentX = 0.5 + clickOffsetX / scaledSize.X
                        local percentY = 0.5 + clickOffsetY / scaledSize.Y
                        percentX = math.clamp(percentX, 0, 1)
                        percentY = math.clamp(percentY, 0, 1)
                        return percentX, percentY
                    end
                    local function setupMapClick()
                        local touchState = {
                            active = false,
                            input = nil,
                            pos = nil,
                            percentX = nil,
                            percentY = nil,
                            token = 0
                        }
                        UserInputService.InputBegan:Connect(function(input, gameProcessed)
                            if input.UserInputType == Enum.UserInputType.MouseButton2 then
                                local mapHolder, mapFrame = findMapHolder()
                                if not mapHolder or not mapFrame then return end
                                local mousePos = UserInputService:GetMouseLocation()
                                if not isPointInMapFrame(mapFrame, mousePos) then return end
                                local percentX, percentY = getPercentFromClick(mapHolder, mousePos)
                                local worldPos = getWorldPositionFromPercent(percentX, percentY)
                                if worldPos then
                                    teleportTo(worldPos)
                                end
                            elseif input.UserInputType == Enum.UserInputType.Touch then
                                local mapHolder, mapFrame = findMapHolder()
                                if not mapHolder or not mapFrame then return end
                                local guiInset = GuiService:GetGuiInset()
                                local touchPos = Vector2.new(input.Position.X, input.Position.Y) + guiInset
                                if not isPointInMapFrame(mapFrame, touchPos) then return end
                                touchState.active = true
                                touchState.input = input
                                touchState.pos = touchPos
                                local percentX, percentY = getPercentFromClick(mapHolder, touchPos)
                                touchState.percentX = percentX
                                touchState.percentY = percentY
                                touchState.token = touchState.token + 1
                                local currentToken = touchState.token
                                local capturedInput = input
                                task.delay(1.5, function()
                                    if not touchState.active or touchState.input ~= capturedInput or touchState.token ~= currentToken then return end
                                    local holder, frame = findMapHolder()
                                    if not holder or not frame then return end
                                    if not isPointInMapFrame(frame, touchState.pos) then return end
                                    local worldPos = getWorldPositionFromPercent(touchState.percentX, touchState.percentY)
                                    if worldPos then
                                        teleportTo(worldPos)
                                    end
                                end)
                            end
                        end)
                        UserInputService.InputEnded:Connect(function(input, gameProcessed)
                            if input.UserInputType == Enum.UserInputType.Touch and input == touchState.input then
                                touchState.active = false
                                touchState.input = nil
                                touchState.percentX = nil
                                touchState.percentY = nil
                            end
                        end)
                    end
                    initTiles()
                    setupMapClick()
                    F:Notify({
                        Title = "空降",
                        Content = "开启\n移动端请长按进行传送",
                        Icon = "map-pin",
                        Duration = 3
                    })
                else
                    if _G.MapAirDropConnection then
                        _G.MapAirDropConnection:Disconnect()
                        _G.MapAirDropConnection = nil
                    end
                    F:Notify({
                        Title = "空降",
                        Content = "关闭",
                        Icon = "map-pin",
                        Duration = 2
                    })
                end
            end
        })

        Tabs.Teleport:Section({ Title = "世界传送", Icon = "map-pin" })

        local teleportLocations = {
            {"银行金库", CFrame.new(-388.7, 617.2, -1153)},
            {"典当行", CFrame.new(-2878, 36.7, 1633)},
            {"军事基地", CFrame.new(-1371.06, 178.68, 3236.76)},
            {"警察局外部", CFrame.new(1579.12, 119.39, -715.22)},
            {"警察局", CFrame.new(1637.2, 123.6, -586.2)},
            {"湾景武器店", CFrame.new(-3277, 39.70, 1849)},
            {"湾景车店", CFrame.new(-3036, 36.91, 1285)},
            {"帮派别墅外武器店", CFrame.new(-7264, 43.50, 1383)},
            {"帮派别墅内艾瑞克", CFrame.new(-7867, 21.39, 1187)},
            {"帮派别墅内b爵士", CFrame.new(-7895, 21.37, 1182)},
            {"帮派别墅内隐秘", CFrame.new(-7837, 21.36, 1050)},
            {"黑帮基地", CFrame.new(-7931, 21.5, 1061.3)},
            {"黑市", CFrame.new(-2910.8, 37.1, 1651.62)},
            {"二倍售卖", CFrame.new(-7892.93, 21.37, 1181.68)},
            {"银行", CFrame.new(-386.96, 620.81, -1195.01)},
            {"警局武器店", CFrame.new(1643, 144.49, -598)},
            {"轮盘", CFrame.new(-1233, 50.39, -2843)},
            {"C4炸弹", CFrame.new(328, 551.59, -1204)},
            {"烈焰要塞空投点", CFrame.new(-1742, 204.01, 3159)}
        }

        for _, loc in ipairs(teleportLocations) do
            Tabs.Teleport:Button({
                Title = loc[1],
                Callback = function()
                    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                    HumanoidRootPart.CFrame = loc[2]
                end
            })
        end

        Tabs.Teleport:Section({ Title = "武器传送", Icon = "target" })

        local weaponLocations = {
            {"UZI", CFrame.new(-1351.5, 40.2, 2036.68)},
            {"RPG", CFrame.new(-1392.26, 271.9, 3203.12)},
            {"AK-47", CFrame.new(-7838.77, 21.37, 1194.19)},
            {"M4A1", CFrame.new(-6343.96, 134.38, -4329.21)},
            {"贝内利M1014", CFrame.new(1348.13, 141.04, -4808.4)},
            {"UMP45", CFrame.new(1665.2, 143.37, -644.01)},
            {"自动瞄准器", CFrame.new(-822.79, 325.62, -505.92)},
            {"AUG", CFrame.new(-1268.50, 152.62, -2832.19)},
            {"武器店", CFrame.new(-193, 42.9, -2812.6)},
            {"枪店", CFrame.new(-3277.16, 39.7, 1849.02)}
        }

        for _, loc in ipairs(weaponLocations) do
            Tabs.Teleport:Button({
                Title = loc[1],
                Callback = function()
                    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                    HumanoidRootPart.CFrame = loc[2]
                end
            })
        end

        Tabs.Teleport:Section({ Title = "玩家传送", Icon = "users" })
        local teleportPlayers = {}
        local teleportEnabled = false
        local teleportLoop = nil
        local teleportTarget = nil

        local function updateTeleportPlayerList()
            teleportPlayers = {}
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    table.insert(teleportPlayers, player.Name)
                end
            end
        end
        updateTeleportPlayerList()

        local selectedTeleportPlayer = ""

        Tabs.Teleport:Dropdown({
            Title = "选择玩家",
            Values = teleportPlayers,
            Value = "",
            Callback = function(Value)
                selectedTeleportPlayer = Value
                if Value ~= "" then
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player.Name == Value then
                            teleportTarget = player
                            break
                        end
                    end
                else
                    teleportTarget = nil
                end
            end
        })

        Tabs.Teleport:Button({
            Title = "刷新玩家列表",
            Callback = function()
                updateTeleportPlayerList()
            end
        })

        Tabs.Teleport:Button({
            Title = "传送至玩家",
            Callback = function()
                if teleportTarget and teleportTarget.Character then
                    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                    local targetRoot = teleportTarget.Character:FindFirstChild("HumanoidRootPart")
                    if targetRoot then
                        HumanoidRootPart.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 3)
                        F:Notify({
                            Title = "传送成功",
                            Content = "已传送到 " .. teleportTarget.Name .. " 附近",
                            Icon = "map-pin",
                            Duration = 3
                        })
                    else
                        F:Notify({
                            Title = "传送失败",
                            Content = "无法找到有效的传送目标位置",
                            Icon = "x",
                            Duration = 3
                        })
                    end
                end
            end
        })

        Tabs.Teleport:Toggle({
            Title = "持续传送",
            Value = false,
            Callback = function(Value)
                teleportEnabled = Value
                if Value then
                    if teleportLoop then
                        teleportLoop:Disconnect()
                    end
                    teleportLoop = game:GetService("RunService").Heartbeat:Connect(function()
                        if teleportEnabled and teleportTarget and teleportTarget.Character then
                            local Character = LocalPlayer.Character
                            if Character then
                                local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                                local targetRoot = teleportTarget.Character:FindFirstChild("HumanoidRootPart")
                                if HumanoidRootPart and targetRoot then
                                    HumanoidRootPart.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 3)
                                end
                            end
                        end
                    end)
                else
                    if teleportLoop then
                        teleportLoop:Disconnect()
                        teleportLoop = nil
                    end
                end
            end
        })

        Tabs.Weather:Section({ Title = "天气控制", Icon = "cloud" })
        local WeatherSystem = {
            CustomWeatherData = {
                Cloud = 0.3,
                Rain = 0,
                Snow = 0,
                Thunder = 0,
                AvgWindSpeed = 5
            },
            RainParts = {},
            SnowParts = {},
            Connections = {}
        }

        function WeatherSystem:GetCurrentWeather()
            return self.CustomWeatherData
        end

        function WeatherSystem:SetCurrentWeather(weatherData)
            for k, v in pairs(weatherData) do
                self.CustomWeatherData[k] = v
            end
            self:ApplyVisualEffects()
            return true
        end

        function WeatherSystem:ApplyVisualEffects()
            local Lighting = game:GetService("Lighting")
            local data = self.CustomWeatherData
            local atmo = Lighting:FindFirstChildOfClass("Atmosphere")
            if atmo then
                atmo.Density = 0.3 + data.Cloud * 0.4
                atmo.Haze = data.Cloud * 8
            end
            local clouds = Lighting:FindFirstChildOfClass("Clouds")
            if clouds then
                clouds.Cover = data.Cloud
                clouds.Density = 0.5 + data.Cloud * 0.3
            end
            local sky = Lighting:FindFirstChildOfClass("Sky")
            if sky then
                if data.Cloud > 0.7 or data.Rain > 0.5 then
                    sky.SunAngularSize = 5
                else
                    sky.SunAngularSize = 21
                end
            end
            if data.Rain > 0 or data.Thunder > 0 then
                Lighting.Brightness = math.max(0.5, 2 - data.Rain * 1.5)
                Lighting.Ambient = Color3.fromRGB(80, 80, 90)
            elseif data.Snow > 0 then
                Lighting.Brightness = 2.5
                Lighting.Ambient = Color3.fromRGB(200, 200, 220)
            else
                Lighting.Brightness = 2
                Lighting.Ambient = Color3.fromRGB(150, 150, 150)
            end
            self:DoRainEffect(data.Rain)
            self:DoSnowEffect(data.Snow)
            self:DoThunderEffect(data.Thunder)
        end

        function WeatherSystem:DoRainEffect(intensity)
            for _, p in pairs(self.RainParts) do
                if p and p.Parent then p:Destroy() end
            end
            self.RainParts = {}
            if intensity <= 0 then return end
            local char = LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local rainPart = Instance.new("Part")
            rainPart.Name = "RainEmitter"
            rainPart.Anchored = true
            rainPart.CanCollide = false
            rainPart.Transparency = 1
            rainPart.Size = Vector3.new(50, 1, 50)
            rainPart.CFrame = hrp.CFrame + Vector3.new(0, 30, 0)
            rainPart.Parent = workspace
            local emitter = Instance.new("ParticleEmitter")
            emitter.Texture = "rbxassetid://241876428"
            emitter.Rate = math.floor(intensity * 500)
            emitter.Lifetime = NumberRange.new(0.8, 1.2)
            emitter.Speed = NumberRange.new(80, 100)
            emitter.SpreadAngle = Vector2.new(5, 5)
            emitter.Rotation = NumberRange.new(0, 0)
            emitter.RotSpeed = NumberRange.new(0, 0)
            emitter.Size = NumberSequence.new(0.1)
            emitter.Transparency = NumberSequence.new(0.3)
            emitter.Color = ColorSequence.new(Color3.fromRGB(180, 200, 255))
            emitter.EmissionDirection = Enum.NormalId.Bottom
            emitter.Parent = rainPart
            table.insert(self.RainParts, rainPart)
            local conn = game:GetService("RunService").Heartbeat:Connect(function()
                if hrp and hrp.Parent then
                    rainPart.CFrame = hrp.CFrame + Vector3.new(0, 30, 0)
                end
            end)
            table.insert(self.Connections, conn)
        end

        function WeatherSystem:DoSnowEffect(intensity)
            for _, p in pairs(self.SnowParts) do
                if p and p.Parent then p:Destroy() end
            end
            self.SnowParts = {}
            if intensity <= 0 then return end
            local char = LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local snowPart = Instance.new("Part")
            snowPart.Name = "SnowEmitter"
            snowPart.Anchored = true
            snowPart.CanCollide = false
            snowPart.Transparency = 1
            snowPart.Size = Vector3.new(60, 1, 60)
            snowPart.CFrame = hrp.CFrame + Vector3.new(0, 35, 0)
            snowPart.Parent = workspace
            local emitter = Instance.new("ParticleEmitter")
            emitter.Texture = "rbxassetid://243660364"
            emitter.Rate = math.floor(intensity * 200)
            emitter.Lifetime = NumberRange.new(3, 5)
            emitter.Speed = NumberRange.new(5, 15)
            emitter.SpreadAngle = Vector2.new(30, 30)
            emitter.Rotation = NumberRange.new(0, 360)
            emitter.RotSpeed = NumberRange.new(-50, 50)
            emitter.Size = NumberSequence.new(0.3, 0.5)
            emitter.Transparency = NumberSequence.new(0)
            emitter.Color = ColorSequence.new(Color3.new(1, 1, 1))
            emitter.EmissionDirection = Enum.NormalId.Bottom
            emitter.Parent = snowPart
            table.insert(self.SnowParts, snowPart)
            local conn = game:GetService("RunService").Heartbeat:Connect(function()
                if hrp and hrp.Parent then
                    snowPart.CFrame = hrp.CFrame + Vector3.new(0, 35, 0)
                end
            end)
            table.insert(self.Connections, conn)
        end

        function WeatherSystem:DoThunderEffect(intensity)
            if intensity <= 0 then return end
            task.spawn(function()
                while self.CustomWeatherData.Thunder > 0 do
                    task.wait(math.random(3, 8) / intensity)
                    if self.CustomWeatherData.Thunder <= 0 then break end
                    local Lighting = game:GetService("Lighting")
                    local origBrightness = Lighting.Brightness
                    Lighting.Brightness = 5
                    task.wait(0.1)
                    Lighting.Brightness = origBrightness
                end
            end)
        end

        function WeatherSystem:ForceUpdateWeather()
            self:ApplyVisualEffects()
            return true
        end

        function WeatherSystem:SetSunny()
            return self:SetCurrentWeather({
                Cloud = 0,
                Rain = 0,
                Snow = 0,
                Thunder = 0,
                TempLow = 65,
                TempHigh = 85,
                AvgWindSpeed = 3,
                WindTurbulence = 0.5
            })
        end

        function WeatherSystem:SetRainy()
            return self:SetCurrentWeather({
                Cloud = 0.9,
                Rain = 0.8,
                Snow = 0,
                Thunder = 0.4,
                TempLow = 60,
                TempHigh = 70,
                AvgWindSpeed = 12,
                WindTurbulence = 1.5
            })
        end

        function WeatherSystem:SetSnowy()
            return self:SetCurrentWeather({
                Cloud = 0.8,
                Rain = 0,
                Snow = 0.9,
                Thunder = 0,
                TempLow = 25,
                TempHigh = 32,
                AvgWindSpeed = 8,
                WindTurbulence = 1.2
            })
        end

        function WeatherSystem:SetStormy()
            return self:SetCurrentWeather({
                Cloud = 1,
                Rain = 1,
                Snow = 0,
                Thunder = 0.9,
                TempLow = 55,
                TempHigh = 65,
                AvgWindSpeed = 20,
                WindTurbulence = 2
            })
        end

        local currentWeatherText = Tabs.Weather:Paragraph({
            Title = "当前天气",
            Desc = "正在加载天气数据...",
            Image = "cloud"
        })

        local function updateWeatherDisplay()
            local currentWeather = WeatherSystem:GetCurrentWeather()
            if currentWeather then
                currentWeatherText:SetDesc(
                    "云量: " .. math.floor((currentWeather.Cloud or 0) * 100) .. "%\n" ..
                    "降雨: " .. math.floor((currentWeather.Rain or 0) * 100) .. "%\n" ..
                    "降雪: " .. math.floor((currentWeather.Snow or 0) * 100) .. "%\n" ..
                    "雷暴: " .. math.floor((currentWeather.Thunder or 0) * 100) .. "%\n" ..
                    "风速: " .. (currentWeather.AvgWindSpeed or 5) .. " mph"
                )
            else
                currentWeatherText:SetDesc("无法获取天气数据")
            end
        end

        Tabs.Weather:Divider()

        Tabs.Weather:Section({ Title = "立即修改天气", Icon = "zap" })

        Tabs.Weather:Button({
            Title = "晴天",
            Callback = function()
                if WeatherSystem:SetSunny() then
                    updateWeatherDisplay()
                    WeatherSystem:ForceUpdateWeather()
                end
            end
        })

        Tabs.Weather:Button({
            Title = "雨天",
            Callback = function()
                if WeatherSystem:SetRainy() then
                    updateWeatherDisplay()
                    WeatherSystem:ForceUpdateWeather()
                end
            end
        })

        Tabs.Weather:Button({
            Title = "雪天",
            Callback = function()
                if WeatherSystem:SetSnowy() then
                    updateWeatherDisplay()
                    WeatherSystem:ForceUpdateWeather()
                end
            end
        })

        Tabs.Weather:Button({
            Title = "雷暴",
            Callback = function()
                if WeatherSystem:SetStormy() then
                    updateWeatherDisplay()
                    WeatherSystem:ForceUpdateWeather()
                end
            end
        })

        Tabs.Weather:Divider()

        Tabs.Weather:Section({ Title = "精细调整", Icon = "sliders" })

        Tabs.Weather:Slider({
            Title = "云量 %",
            Value = { Min = 0, Max = 100, Default = 30 },
            Callback = function(Value)
                local currentWeather = WeatherSystem:GetCurrentWeather()
                if currentWeather then
                    currentWeather.Cloud = Value / 100
                    WeatherSystem:SetCurrentWeather(currentWeather)
                    updateWeatherDisplay()
                end
            end
        })

        Tabs.Weather:Slider({
            Title = "降雨 %",
            Value = { Min = 0, Max = 100, Default = 0 },
            Callback = function(Value)
                local currentWeather = WeatherSystem:GetCurrentWeather()
                if currentWeather then
                    currentWeather.Rain = Value / 100
                    WeatherSystem:SetCurrentWeather(currentWeather)
                    updateWeatherDisplay()
                end
            end
        })

        Tabs.Weather:Slider({
            Title = "降雪 %",
            Value = { Min = 0, Max = 100, Default = 0 },
            Callback = function(Value)
                local currentWeather = WeatherSystem:GetCurrentWeather()
                if currentWeather then
                    currentWeather.Snow = Value / 100
                    WeatherSystem:SetCurrentWeather(currentWeather)
                    updateWeatherDisplay()
                end
            end
        })

        Tabs.Weather:Slider({
            Title = "雷暴 %",
            Value = { Min = 0, Max = 100, Default = 0 },
            Callback = function(Value)
                local currentWeather = WeatherSystem:GetCurrentWeather()
                if currentWeather then
                    currentWeather.Thunder = Value / 100
                    WeatherSystem:SetCurrentWeather(currentWeather)
                    updateWeatherDisplay()
                end
            end
        })

        Tabs.Weather:Slider({
            Title = "风速 (mph)",
            Value = { Min = 0, Max = 30, Default = 5 },
            Callback = function(Value)
                local currentWeather = WeatherSystem:GetCurrentWeather()
                if currentWeather then
                    currentWeather.AvgWindSpeed = Value
                    currentWeather.TopWindSpeed = Value * 1.5
                    WeatherSystem:SetCurrentWeather(currentWeather)
                    updateWeatherDisplay()
                end
            end
        })

        Tabs.Weather:Section({ Title = "高级设置", Icon = "settings" })

        Tabs.Weather:Toggle({
            Title = "强制天气更新",
            Value = false,
            Callback = function(Value)
                if Value then
                    WeatherSystem:ForceUpdateWeather()
                end
            end
        })

        Tabs.Weather:Toggle({
            Title = "禁用天气效果",
            Value = false,
            Callback = function(Value)
                if Value then
                    WeatherSystem:SetCurrentWeather({
                        Cloud = 0,
                        Rain = 0,
                        Snow = 0,
                        Thunder = 0,
                        AvgWindSpeed = 0,
                        WindTurbulence = 0
                    })
                    updateWeatherDisplay()
                end
            end
        })

        Tabs.Weather:Button({
            Title = "重置天气",
            Callback = function()
                local currentWeather = WeatherSystem:GetCurrentWeather()
                if currentWeather then
                    currentWeather.Cloud = 0.3
                    currentWeather.Rain = 0.1
                    currentWeather.Snow = 0
                    currentWeather.Thunder = 0.05
                    currentWeather.AvgWindSpeed = 5
                    currentWeather.WindTurbulence = 1
                    WeatherSystem:SetCurrentWeather(currentWeather)
                    updateWeatherDisplay()
                end
            end
        })

        Tabs.Weather:Button({
            Title = "刷新天气显示",
            Callback = function()
                updateWeatherDisplay()
            end
        })

        Tabs.PlayerInfo:Section({ Title = "玩家信息", Icon = "users" })

        local selectedPlayer = nil
        local playerInfoDisplay = nil
        local playerDropdown = nil
        local lastHealthCache = {}
        local healthUpdateInterval = 1
        local lastHealthUpdate = 0

        local function getCharacterHealth(character)
            if not character then return nil end
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                return humanoid.Health, humanoid.MaxHealth
            end
            return nil
        end

        local function getPlayerInfoText(player)
            if not player then return "请选择一个玩家" end
            local function safeGetAttribute(attrName)
                local success, value = pcall(function()
                    return player:GetAttribute(attrName)
                end)
                return success and value or "未知"
            end
            local info = {
                "=== 玩家 ===",
                "玩家名: " .. player.Name,
                "显示名: " .. player.DisplayName,
                "用户ID: " .. player.UserId,
                "账户年龄: " .. player.AccountAge .. " 天",
                "",
                "=== 游戏 ===",
                "队伍: " .. tostring(safeGetAttribute("currentTeam")),
                "警衔: " .. tostring(safeGetAttribute("policeRank")),
                "星星: " .. tostring(safeGetAttribute("stars")),
                "悬赏金额: $" .. tostring(safeGetAttribute("bounty")),
                "现金: $" .. tostring(safeGetAttribute("cash")),
                "银行周期: " .. tostring(safeGetAttribute("bankPeriod")),
                ""
            }
            if player.Character then
                local health, maxHealth = getCharacterHealth(player.Character)
                if health and maxHealth then
                    table.insert(info, "生命值: " .. math.floor(health) .. "/" .. math.floor(maxHealth))
                else
                    table.insert(info, "生命值: 无法获取")
                end
            else
                table.insert(info, "未知")
            end
            return table.concat(info, "\n")
        end

        local function updatePlayerList()
            local playerNames = {}
            for _, player in ipairs(Players:GetPlayers()) do
                table.insert(playerNames, player.Name)
            end
            table.sort(playerNames, function(a, b)
                return a:lower() < b:lower()
            end)
            return playerNames
        end

        local function forceHealthUpdate()
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        lastHealthCache[player.UserId] = {
                            health = humanoid.Health,
                            maxHealth = humanoid.MaxHealth,
                            timestamp = tick()
                        }
                    end
                end
            end
        end

        playerDropdown = Tabs.PlayerInfo:Dropdown({
            Title = "选择玩家",
            Values = updatePlayerList(),
            Value = nil,
            Callback = function(value)
                if value then
                    selectedPlayer = Players:FindFirstChild(value)
                    if selectedPlayer then
                        if playerInfoDisplay then
                            forceHealthUpdate()
                            playerInfoDisplay:SetDesc(getPlayerInfoText(selectedPlayer))
                        end
                        F:Notify({
                            Title = "玩家已选择",
                            Content = "已选择玩家: " .. selectedPlayer.Name,
                            Icon = "user",
                            Duration = 2
                        })
                    end
                else
                    selectedPlayer = nil
                    if playerInfoDisplay then
                        playerInfoDisplay:SetDesc("请从上方下拉框中选择一个玩家")
                    end
                end
            end
        })

        playerInfoDisplay = Tabs.PlayerInfo:Paragraph({
            Title = "玩家信息",
            Desc = "请从上方下拉框中选择一个玩家以查看其详细信息",
            Image = "user",
            ImageSize = 32,
            Thumbnail = nil,
            ThumbnailSize = 120
        })

        Tabs.PlayerInfo:Section({ Title = "操作功能", Icon = "settings" })

        Tabs.PlayerInfo:Button({
            Title = "传送到玩家",
            Desc = "传送到选定玩家的位置",
            Callback = function()
                if selectedPlayer and selectedPlayer.Character then
                    local targetRoot = selectedPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local localChar = LocalPlayer.Character
                    if targetRoot and localChar and localChar:FindFirstChild("HumanoidRootPart") then
                        localChar.HumanoidRootPart.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 5)
                        F:Notify({
                            Title = "传送成功",
                            Content = "已传送到 " .. selectedPlayer.Name .. " 附近",
                            Icon = "map-pin",
                            Duration = 3
                        })
                    else
                        F:Notify({
                            Title = "传送失败",
                            Content = "无法传送到该玩家",
                            Icon = "x",
                            Duration = 3
                        })
                    end
                else
                    F:Notify({
                        Title = "未选择玩家",
                        Content = "请先选择一个玩家",
                        Icon = "alert-circle",
                        Duration = 3
                    })
                end
            end
        })

        Tabs.PlayerInfo:Button({
            Title = "复制玩家信息",
            Desc = "将玩家信息复制到剪贴板",
            Callback = function()
                if selectedPlayer then
                    local infoText = getPlayerInfoText(selectedPlayer)
                    if setclipboard then
                        setclipboard(infoText)
                        F:Notify({
                            Title = "复制成功",
                            Content = "玩家信息已复制到剪贴板",
                            Icon = "check",
                            Duration = 3
                        })
                    else
                        F:Notify({
                            Title = "复制失败",
                            Content = "剪贴板功能不可用",
                            Icon = "x",
                            Duration = 3
                        })
                    end
                else
                    F:Notify({
                        Title = "未选择玩家",
                        Content = "请先选择一个玩家",
                        Icon = "alert-circle",
                        Duration = 3
                    })
                end
            end
        })

        Tabs.PlayerInfo:Button({
            Title = "刷新玩家列表",
            Desc = "更新服务器中的玩家列表",
            Callback = function()
                local success = pcall(function()
                    if playerDropdown and playerDropdown.SetValues then
                        local newPlayerList = updatePlayerList()
                        playerDropdown:SetValues(newPlayerList)
                        F:Notify({
                            Title = "刷新成功",
                            Content = "已刷新玩家列表 (" .. #newPlayerList .. " 个玩家)",
                            Icon = "refresh-cw",
                            Duration = 3
                        })
                    end
                end)
                if not success then
                    F:Notify({
                        Title = "刷新失败",
                        Content = "更新玩家列表时出错",
                        Icon = "x",
                        Duration = 3
                    })
                end
            end
        })

        Tabs.PlayerInfo:Section({ Title = "刷新", Icon = "eye" })

        local autoRefreshEnabled = false
        local autoRefreshConnection = nil

        Tabs.PlayerInfo:Toggle({
            Title = "强制刷新生命值",
            Desc = "实时强制更新玩家生命值",
            Value = false,
            Callback = function(Value)
                autoRefreshEnabled = Value
                if Value then
                    if autoRefreshConnection then
                        autoRefreshConnection:Disconnect()
                    end
                    autoRefreshConnection = game:GetService("RunService").Heartbeat:Connect(function()
                        local now = tick()
                        if now - lastHealthUpdate >= healthUpdateInterval then
                            lastHealthUpdate = now
                            forceHealthUpdate()
                            if selectedPlayer and playerInfoDisplay then
                                local success = pcall(function()
                                    playerInfoDisplay:SetDesc(getPlayerInfoText(selectedPlayer))
                                end)
                                if not success and playerInfoDisplay then
                                    playerInfoDisplay:SetDesc("获取玩家信息时出错")
                                end
                            end
                        end
                    end)
                    F:Notify({
                        Title = "开启",
                        Content = "已开启强制生命值刷新",
                        Icon = "check",
                        Duration = 3
                    })
                else
                    if autoRefreshConnection then
                        autoRefreshConnection:Disconnect()
                        autoRefreshConnection = nil
                    end
                    F:Notify({
                        Title = "关闭",
                        Content = "已停止强制生命值刷新",
                        Icon = "x",
                        Duration = 3
                    })
                end
            end
        })

        local function setupPlayerMonitoring()
            Players.PlayerAdded:Connect(function(player)
                task.wait(1)
                if playerDropdown and playerDropdown.SetValues then
                    pcall(function()
                        playerDropdown:SetValues(updatePlayerList())
                    end)
                end
            end)
            Players.PlayerRemoving:Connect(function(player)
                if selectedPlayer == player then
                    selectedPlayer = nil
                    if playerInfoDisplay then
                        playerInfoDisplay:SetDesc("该玩家已离开服务器，请重新选择")
                    end
                end
                if playerDropdown and playerDropdown.SetValues then
                    pcall(function()
                        task.wait(0.5)
                        playerDropdown:SetValues(updatePlayerList())
                    end)
                end
                lastHealthCache[player.UserId] = nil
            end)
        end

        forceHealthUpdate()
        task.spawn(setupPlayerMonitoring)

        Tabs.PlayerInfo:Paragraph({
            Title = "使用说明",
            Desc = "1. 从下拉框选择要查看的玩家\n2. 玩家信息将自动显示在下方\n3. 可以使用右侧按钮进行操作\n4. 开启强制刷新可实时监控生命值",
            Image = "info",
            ImageSize = 24
        })

        Tabs.UISettings:Section({ Title = "菜单设置", Icon = "wrench" })

        Tabs.UISettings:Toggle({
            Title = "自定义光标",
            Value = false,
            Callback = function(Value)
                Window:ToggleCustomCursor(Value)
            end
        })

        Tabs.UISettings:Dropdown({
            Title = "通知位置",
            Values = { "左", "右" },
            Value = "右",
            Callback = function(Value)
                F:SetNotifySide(Value == "左" and "Left" or "Right")
            end
        })

        Tabs.UISettings:Dropdown({
            Title = "DPI缩放",
            Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
            Value = "100%",
            Callback = function(Value)
                local dpiValue = tonumber(Value:gsub("%%", ""))
                if not dpiValue then return end
                Window:SetDPIScale(dpiValue / 100)
            end
        })

        Tabs.UISettings:Divider()

        Tabs.UISettings:Keybind({
            Title = "菜单按键",
            Value = "RightShift",
            Callback = function(v)
                Window:SetToggleKey(Enum.KeyCode[v])
            end
        })

        if WindUI and WindUI.Notify then
            WindUI:Notify({
                Title = "已加载", 
                Content = "", 
                Duration = 3
            })
        end
    end
})

Tabs.sbcnm:Section({
    Title = "8球池", 
    TextXAlignment = "Left", 
    TextSize = 17
})

local poolLoaded = false

local allowedServerIds = {
    "5523851880",
}

local function GetCurrentServerId()
    local success, id = pcall(function()
        return tostring(game.PlaceId)
    end)
    if success and id then
        return id
    end
    return nil
end

local function CheckServerId()
    local currentId = GetCurrentServerId()
    if not currentId then
        if WindUI and WindUI.Notify then
            WindUI:Notify({
                Title = "加载失败", 
                Content = "无法获取ID", 
                Duration = 3
            })
        end
        return false
    end
    
    for _, allowedId in ipairs(allowedServerIds) do
        if currentId == allowedId then
            return true
        end
    end
    
    if WindUI and WindUI.Notify then
        WindUI:Notify({
            Title = "服务器不符", 
            Content = "当前ID: " .. currentId, 
            Duration = 3
        })
    end
    return false
end

Tabs.sbcnm:Button({
    Title = "8球池",
    Callback = function()
        if poolLoaded then
            if WindUI and WindUI.Notify then
                WindUI:Notify({
                    Title = "重复点击！", 
                    Content = "", 
                    Duration = 3
                })
            end
            return
        end
        
        if not CheckServerId() then
            return
        end

        poolLoaded = true

        local TabPool = Window:Tab({
            Title = "8球池",
            Icon = "circle",
            Locked = false,
        })

        TabPool:Section({ Title = "---- 恶搞功能 ----" })

        TabPool:Toggle({
            Title = "让对手看不见球",
            Default = false,
            Callback = function(state)
                getgenv().HI = state

                local ev
                for _, v in pairs(getnilinstances()) do
                    if v.Name == "EventHandlerClient" then
                        ev = v
                        break
                    end
                end

                if getgenv().HI and ev then
                    getgenv()._InvisibleBallsConn = coroutine.create(function()
                        while getgenv().HI do
                            wait(0.2)
                            for i = 1, 15 do
                                pcall(function()
                                    require(ev):FireRemoteEvent("UpdateBalls", { [i.. "Ball"] = CFrame.new(1, 1, 1) })
                                end)
                            end
                        end
                    end)
                    coroutine.resume(getgenv()._InvisibleBallsConn)
                elseif state and not ev then
                    WindUI:Notify({Title = "错误", Content = "无法找到 EventHandlerClient，可能执行器不支持或游戏已更新", Duration = 3})
                end
            end
        })

        local extendedLineConn
        local trajectoryParts = {}

        TabPool:Toggle({
            Title = "延长线",
            Default = false,
            Callback = function(state)
                local activeTable = workspace:FindFirstChild("Tables") and (workspace.Tables:FindFirstChild("Table1") or workspace.Tables:FindFirstChild("Table2") or workspace.Tables:FindFirstChild("Table3"))
                
                if not activeTable then
                    WindUI:Notify({Title = "错误", Content = "未找到球桌 (Table)，请进入对局后再试", Duration = 3})
                    return
                end
                local Guides = activeTable:FindFirstChild("Guides")
                local HitTrajectory = Guides and Guides:FindFirstChild("HitTrajectory")
                
                if not HitTrajectory then
                    WindUI:Notify({Title = "错误", Content = "未找到预测线 (HitTrajectory)", Duration = 3})
                    return
                end

                local maxSegments = 5
                local segmentLength = 10

                local function clearTrajectory()
                    for _, part in pairs(trajectoryParts) do
                        if part and part.Parent then
                            part:Destroy()
                        end
                    end
                    trajectoryParts = {}
                end

                if extendedLineConn then
                    extendedLineConn:Disconnect()
                    extendedLineConn = nil
                end

                clearTrajectory()

                if state then
                    local function updateTrajectory()
                        clearTrajectory()
                        local startPos = HitTrajectory.Position
                        local direction = HitTrajectory.CFrame.LookVector.Unit
                        local currentPos = startPos

                        for i = 1, maxSegments do
                            local nextPos = currentPos + direction * segmentLength

                            local line = Instance.new("Part")
                            line.Size = Vector3.new(0.2, 0.2, segmentLength)
                            line.CFrame = CFrame.lookAt(currentPos, nextPos) * CFrame.new(0, 0, -segmentLength / 2)
                            line.BrickColor = BrickColor.Green()
                            line.Anchored = true
                            line.CanCollide = false
                            line.Material = Enum.Material.Neon
                            line.Parent = workspace

                            table.insert(trajectoryParts, line)
                            currentPos = nextPos
                        end
                    end

                    extendedLineConn = HitTrajectory:GetPropertyChangedSignal("CFrame"):Connect(updateTrajectory)
                    updateTrajectory()
                    
                    if not getgenv()._ExtendedLines then getgenv()._ExtendedLines = {} end
                    getgenv()._ExtendedLines.Clear = clearTrajectory
                else
                    if getgenv()._ExtendedLines and getgenv()._ExtendedLines.Clear then
                        getgenv()._ExtendedLines.Clear()
                    end
                end
            end
        })

        if WindUI and WindUI.Notify then
            WindUI:Notify({
                Title = "8球池已加载", 
                Content = "", 
                Duration = 3
            })
        end
    end
})

Tabs.sbcnm:Section({
    Title = "Chain", 
    TextXAlignment = "Left", 
    TextSize = 17
})

local chainLoaded = false

local allowedServerIds = {
    "13977939077",
}

local function GetCurrentServerId()
    local success, id = pcall(function()
        return tostring(game.PlaceId)
    end)
    if success and id then
        return id
    end
    return nil
end

local function CheckServerId()
    local currentId = GetCurrentServerId()
    if not currentId then
        if WindUI and WindUI.Notify then
            WindUI:Notify({
                Title = "加载失败", 
                Content = "无法获取ID", 
                Duration = 3
            })
        end
        return false
    end
    
    for _, allowedId in ipairs(allowedServerIds) do
        if currentId == allowedId then
            return true
        end
    end
    
    if WindUI and WindUI.Notify then
        WindUI:Notify({
            Title = "服务器不符", 
            Content = "当前ID: " .. currentId, 
            Duration = 3
        })
    end
    return false
end

Tabs.sbcnm:Button({
    Title = "Chain",
    Callback = function()
        if chainLoaded then
            if WindUI and WindUI.Notify then
                WindUI:Notify({
                    Title = "重复点击！", 
                    Content = "", 
                    Duration = 3
                })
            end
            return
        end
        
        if not CheckServerId() then
            return
        end

        chainLoaded = true

        local TabChain = Window:Tab({
            Title = "Chain",
            Icon = "hand",
            Locked = false,
        })

        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local RunService = game:GetService("RunService")
        local Lighting = game:GetService("Lighting")

        local combatStaminaEnabled = false
        local staminaEnabled = false
        local combatLoop = nil
        local staminaLoop = nil

        local function setCombatStamina(value)
            local char = workspace:FindFirstChild(LocalPlayer.Name)
            if char and char:FindFirstChild("Stats") then
                local stat = char.Stats:FindFirstChild("CombatStamina")
                if stat then stat.Value = value end
            end
        end

        local function setStamina(value)
            local char = workspace:FindFirstChild(LocalPlayer.Name)
            if char and char:FindFirstChild("Stats") then
                local stat = char.Stats:FindFirstChild("Stamina")
                if stat then stat.Value = value end
            end
        end

        local function startCombatLoop()
            if combatLoop then return end
            combatLoop = RunService.Heartbeat:Connect(function()
                if combatStaminaEnabled then setCombatStamina(100) end
            end)
        end

        local function startStaminaLoop()
            if staminaLoop then return end
            staminaLoop = RunService.Heartbeat:Connect(function()
                if staminaEnabled then setStamina(100) end
            end)
        end

        local function stopCombatLoop()
            if combatLoop then combatLoop:Disconnect() combatLoop = nil end
        end

        local function stopStaminaLoop()
            if staminaLoop then staminaLoop:Disconnect() staminaLoop = nil end
        end

        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(1)
            if combatStaminaEnabled then setCombatStamina(100) end
            if staminaEnabled then setStamina(100) end
        end)

        TabChain:Section({ Title = "---- 体力 ----" })

        TabChain:Toggle({
            Title = "无限战斗体力",
            Value = false,
            Callback = function(state)
                combatStaminaEnabled = state
                if state then startCombatLoop() else stopCombatLoop() end
            end
        })

        TabChain:Toggle({
            Title = "无限体力",
            Value = false,
            Callback = function(state)
                staminaEnabled = state
                if state then startStaminaLoop() else stopStaminaLoop() end
            end
        })

        TabChain:Section({ Title = "---- 透视 ----" })

        local chainESPEnabled = false
        local chainESPConnection = nil
        local currentChain = nil

        local function createChainESP(chain)
            if not chain:FindFirstChild("Highlight") then
                local h = Instance.new("Highlight")
                h.Name = "Highlight"
                h.Adornee = chain
                h.FillColor = Color3.fromRGB(255, 0, 0)
                h.FillTransparency = 0.8
                h.OutlineColor = Color3.fromRGB(255, 60, 60)
                h.OutlineTransparency = 0
                h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                h.Parent = chain
            end
            if not chain:FindFirstChild("NameGui") then
                local gui = Instance.new("BillboardGui")
                gui.Name = "NameGui"
                gui.Size = UDim2.new(0, 150, 0, 30)
                gui.StudsOffset = Vector3.new(0, 5, 0)
                gui.Adornee = chain
                gui.AlwaysOnTop = true
                gui.LightInfluence = 0
                gui.Parent = chain
                local titleLabel = Instance.new("TextLabel")
                titleLabel.Name = "TitleLabel"
                titleLabel.Size = UDim2.new(1, 0, 0.5, 0)
                titleLabel.Text = "CHAIN"
                titleLabel.TextColor3 = Color3.new(1, 0, 0)
                titleLabel.TextScaled = true
                titleLabel.Font = Enum.Font.GothamBold
                titleLabel.BackgroundTransparency = 1
                titleLabel.Parent = gui
                local attrLabel = Instance.new("TextLabel")
                attrLabel.Name = "AttrLabel"
                attrLabel.Size = UDim2.new(1, 0, 0.5, 0)
                attrLabel.Position = UDim2.new(0, 0, 0.5, 0)
                attrLabel.RichText = true
                attrLabel.Text = ""
                attrLabel.TextColor3 = Color3.new(1, 1, 1)
                attrLabel.TextScaled = true
                attrLabel.Font = Enum.Font.Gotham
                attrLabel.BackgroundTransparency = 1
                attrLabel.Parent = gui
            end
        end

        local function updateChainAttributes(chain)
            local gui = chain:FindFirstChild("NameGui")
            if gui then
                local attrLabel = gui:FindFirstChild("AttrLabel")
                if attrLabel then
                    local anger = chain:GetAttribute("Anger") or 0
                    local burst = chain:GetAttribute("Burst") or 0
                    local choke = chain:GetAttribute("ChokeMeter") or 0
                    attrLabel.Text = string.format('[血月度: <font color="rgb(255,255,255)">%.0f%%</font>] [捶地: <font color="rgb(255,255,255)">%.0f%%</font>] [掐脖: <font color="rgb(255,255,255)">%.0f%%</font>]', anger, burst, choke)
                end
            end
        end

        local function refreshChainESP()
            local chain = workspace:FindFirstChild("Misc") and workspace.Misc:FindFirstChild("AI") and workspace.Misc.AI:FindFirstChild("CHAIN")
            if chain then
                if currentChain ~= chain then
                    if currentChain then
                        local h = currentChain:FindFirstChild("Highlight")
                        if h then h:Destroy() end
                    end
                    currentChain = chain
                    createChainESP(chain)
                end
                updateChainAttributes(chain)
            end
        end

        TabChain:Toggle({
            Title = "透视chain",
            Value = false,
            Callback = function(state)
                if state then
                    chainESPEnabled = true
                    chainESPConnection = RunService.Heartbeat:Connect(refreshChainESP)
                else
                    chainESPEnabled = false
                    if chainESPConnection then
                        chainESPConnection:Disconnect()
                        chainESPConnection = nil
                    end
                end
            end
        })

        local playerESPEnabled = false
        local playerESPConnections = {}
        local trackedCharacters = {}

        local function addESP(character, player)
            if not character:FindFirstChild("Highlight") then
                local h = Instance.new("Highlight")
                h.Name = "Highlight"
                h.Parent = character
                h.FillColor = Color3.fromRGB(0, 255, 0)
                h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            end
            if not character:FindFirstChild("NameGui") then
                local gui = Instance.new("BillboardGui")
                gui.Name = "NameGui"
                gui.Parent = character
                gui.Size = UDim2.new(0, 50, 0, 10)
                gui.AlwaysOnTop = true
                local label = Instance.new("TextLabel")
                label.Parent = gui
                label.Size = UDim2.new(1, 0, 1, 0)
                label.Text = player.Name
                label.TextColor3 = Color3.new(0, 1, 0)
                label.BackgroundTransparency = 1
                label.TextScaled = true
            end
        end

        TabChain:Toggle({
            Title = "透视玩家",
            Default = false,
            Callback = function(state)
                playerESPEnabled = state
                if state then
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character then
                            addESP(player.Character, player)
                        end
                    end
                end
            end
        })

        local highlightLoop

        TabChain:Toggle({
            Title = "高亮",
            Default = false,
            Callback = function(state)
                if state then
                    highlightLoop = task.spawn(function()
                        while task.wait(0.5) do
                            Lighting.Brightness = 2
                            Lighting.ClockTime = 13.5
                            Lighting.GlobalShadows = false
                        end
                    end)
                else
                    if highlightLoop then
                        task.cancel(highlightLoop)
                        highlightLoop = nil
                    end
                end
            end
        })

        TabChain:Section({ Title = "---- 传送捡物 ----" })

        local targetPositions = {
            Vector3.new(-26.879, -107.017, -204.777),
            Vector3.new(-110.858, -86.338, 211.858),
            Vector3.new(43.304, -97.968, 349.153),
            Vector3.new(164.498, -103.651, -35.760),
            Vector3.new(308.971, -113.493, -250.460),
            Vector3.new(-203.818, -110.890, -108.904),
            Vector3.new(-381.873, -115.021, 42.071),
        }

        TabChain:Toggle({
            Title = "传送捡废铁",
            Value = false,
            Callback = function(state)
                _G.ScrapRunning = state
                if state then
                    task.spawn(function()
                        while _G.ScrapRunning do
                            for _, pos in ipairs(targetPositions) do
                                if not _G.ScrapRunning then break end
                                pcall(function()
                                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
                                end)
                                task.wait(3)
                            end
                        end
                    end)
                end
            end
        })

        TabChain:Toggle({
            Title = "传送捡魔法书碎片",
            Value = false,
            Callback = function(state)
                _G.ArtRunning = state
                if state then
                    task.spawn(function()
                        while _G.ArtRunning do
                            pcall(function()
                                local arts = workspace.Misc.Zones.LootingItems.Artifacts:GetChildren()
                                for _, m in pairs(arts) do
                                    for _, p in pairs(m:GetChildren()) do
                                        if p:IsA("MeshPart") and p.Transparency == 0 then
                                            LocalPlayer.Character.HumanoidRootPart.CFrame = p.CFrame
                                            task.wait(0.3)
                                            fireproximityprompt(p:FindFirstChildOfClass("ProximityPrompt"))
                                            task.wait(0.5)
                                        end
                                    end
                                end
                            end)
                            task.wait(1)
                        end
                    end)
                end
            end
        })

        TabChain:Section({ Title = "---- 其他 ----" })

        TabChain:Toggle({
            Title = "显示聊天框",
            Callback = function(state)
                pcall(function()
                    game:GetService("TextChatService").ChatWindowConfiguration.Enabled = state
                end)
            end
        })

        TabChain:Toggle({
            Title = "强制第三人称",
            Callback = function(state)
                pcall(function()
                    LocalPlayer.CameraMaxZoomDistance = state and 99999 or 16
                    LocalPlayer.CameraMode = state and Enum.CameraMode.Classic or Enum.CameraMode.LockFirstPerson
                end)
            end
        })

        TabChain:Button({
            Title = "删除雾",
            Callback = function()
                if Lighting:FindFirstChild("Rainy") then
                    Lighting.Rainy:Destroy()
                end
            end
        })

        TabChain:Section({ Title = "---- 暴力功能 ----" })

        TabChain:Paragraph({
            Title = "注意事项",
            Desc = "要先点反作弊，然后开启无限闪避之后再点一下闪避键",
            Color = "Red"
        })

        TabChain:Button({
            Title = "绕过反作弊",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua", true))()
            end
        })

        local function smoothLookAt(currentCFrame, targetPos, speed)
            local direction = (targetPos - currentCFrame.Position).Unit
            local lerpedLook = currentCFrame.LookVector:Lerp(direction, speed)
            return CFrame.new(currentCFrame.Position, currentCFrame.Position + lerpedLook)
        end

        TabChain:Toggle({
            Title = "自瞄chain",
            Callback = function(state)
                if state then
                    _G.AimLoop = RunService.RenderStepped:Connect(function()
                        local chain = workspace:FindFirstChild("Misc") and workspace.Misc.AI:FindFirstChild("CHAIN")
                        if chain and chain:FindFirstChild("HumanoidRootPart") then
                            workspace.CurrentCamera.CFrame = smoothLookAt(
                                workspace.CurrentCamera.CFrame,
                                chain.HumanoidRootPart.Position,
                                0.3
                            )
                        end
                    end)
                else
                    if _G.AimLoop then
                        _G.AimLoop:Disconnect()
                        _G.AimLoop = nil
                    end
                end
            end
        })

        TabChain:Toggle({
            Title = "chain爆炸自动躲v1",
            Callback = function(state)
                _G.DodgeV1 = state
            end
        })

        TabChain:Toggle({
            Title = "chain爆炸自动躲v2",
            Callback = function(state)
                _G.DodgeV2 = state
            end
        })

        local mt = getrawmetatable(game)
        local old = mt.__namecall
        setreadonly(mt, false)
        local lastCTS, lastInteract

        mt.__namecall = function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            if method == "FireServer" then
                if self.Name == "CTS" then
                    lastCTS = args
                end
                if self.Name == "Interact" then
                    lastInteract = args
                end
            end
            return old(self, ...)
        end
        setreadonly(mt, true)

        TabChain:Toggle({
            Title = "自动无限闪避",
            Callback = function(state)
                _G.InfDodge = state
                if state then
                    task.spawn(function()
                        while _G.InfDodge do
                            pcall(function()
                                local remote = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("CharacterMobility") and LocalPlayer.Character.CharacterMobility:FindFirstChild("CTS")
                                if remote and lastCTS then
                                    remote:FireServer(unpack(lastCTS))
                                end
                            end)
                            task.wait(0.3)
                        end
                    end)
                end
            end
        })

        TabChain:Toggle({
            Title = "无敌",
            Callback = function(state)
                _G.GodMode = state
                if state then
                    task.spawn(function()
                        while _G.GodMode do
                            pcall(function()
                                local remote = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("CharacterHandler") and LocalPlayer.Character.CharacterHandler.Contents.Remotes:FindFirstChild("Interact")
                                if remote and lastInteract then
                                    remote:FireServer(unpack(lastInteract))
                                end
                            end)
                            task.wait(1)
                        end
                    end)
                end
            end
        })

        TabChain:Toggle({
            Title = "自动拼刀",
            Callback = function(state)
                if state then
                    _G.ClashLoop = RunService.Heartbeat:Connect(function()
                        pcall(function()
                            LocalPlayer.Character.Stats.ClashStrength.Value = 100
                        end)
                    end)
                else
                    if _G.ClashLoop then
                        _G.ClashLoop:Disconnect()
                        _G.ClashLoop = nil
                    end
                end
            end
        })

        TabChain:Section({ Title = "---- 蓝图解锁 ----" })

        local function UnlockAttr(attr)
            pcall(function()
                LocalPlayer:WaitForChild("PlayerStats"):WaitForChild("Blueprints"):SetAttribute(attr, true)
            end)
        end

        TabChain:Button({
            Title = "解锁小刀",
            Callback = function()
                UnlockAttr("CombatKnife")
            end
        })

        TabChain:Button({
            Title = "解锁喷子",
            Callback = function()
                UnlockAttr("DoubleBarrel")
            end
        })

        TabChain:Button({
            Title = "解锁m1911",
            Callback = function()
                UnlockAttr("M1911")
            end
        })

        TabChain:Button({
            Title = "解锁马切特",
            Callback = function()
                UnlockAttr("Machete")
            end
        })

        TabChain:Button({
            Title = "解锁魔法书",
            Callback = function()
                UnlockAttr("SpellBook")
            end
        })

        TabChain:Button({
            Title = "解锁神器任务",
            Callback = function()
                pcall(function()
                    LocalPlayer.PlayerStats.Quests:SetAttribute("ArtifactQuest", true)
                end)
            end
        })

        TabChain:Section({ Title = "---- 传送位置 ----" })

        local function Teleport(pos)
            pcall(function()
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
            end)
        end

        TabChain:Button({
            Title = "chain出生地",
            Callback = function()
                Teleport(Vector3.new(-26.879, -107.017, -204.777))
            end
        })

        TabChain:Button({
            Title = "商店",
            Callback = function()
                Teleport(Vector3.new(-110.858, -86.338, 211.858))
            end
        })

        TabChain:Button({
            Title = "排行榜",
            Callback = function()
                Teleport(Vector3.new(43.304, -97.968, 349.153))
            end
        })

        TabChain:Button({
            Title = "工作间",
            Callback = function()
                Teleport(Vector3.new(164.498, -103.651, -35.760))
            end
        })

        TabChain:Button({
            Title = "仓库",
            Callback = function()
                Teleport(Vector3.new(308.971, -113.493, -250.460))
            end
        })

        TabChain:Button({
            Title = "发电站",
            Callback = function()
                Teleport(Vector3.new(-203.818, -110.890, -108.904))
            end
        })

        TabChain:Button({
            Title = "收音机站",
            Callback = function()
                Teleport(Vector3.new(-381.873, -115.021, 42.071))
            end
        })

        TabChain:Button({
            Title = "打开商店界面",
            Callback = function()
                pcall(function()
                    LocalPlayer.PlayerGui.Ingame.Shop.Visible = true
                end)
            end
        })

        if WindUI and WindUI.Notify then
            WindUI:Notify({
                Title = "Chain已加载", 
                Content = "", 
                Duration = 3
            })
        end
    end
})

Tabs.sbcnm:Section({
    Title = "最强战场", 
    TextXAlignment = "Left", 
    TextSize = 17
})

local battlefieldLoaded = false

local allowedServerIds = {
    "10449761463",
}

local function GetCurrentServerId()
    local success, id = pcall(function()
        return tostring(game.PlaceId)
    end)
    if success and id then
        return id
    end
    return nil
end

local function CheckServerId()
    local currentId = GetCurrentServerId()
    if not currentId then
        if WindUI and WindUI.Notify then
            WindUI:Notify({
                Title = "加载失败", 
                Content = "无法获取ID", 
                Duration = 3
            })
        end
        return false
    end
    
    for _, allowedId in ipairs(allowedServerIds) do
        if currentId == allowedId then
            return true
        end
    end
    
    if WindUI and WindUI.Notify then
        WindUI:Notify({
            Title = "服务器不符", 
            Content = "当前ID: " .. currentId, 
            Duration = 3
        })
    end
    return false
end

Tabs.sbcnm:Button({
    Title = "最强战场",
    Callback = function()
        if battlefieldLoaded then
            if WindUI and WindUI.Notify then
                WindUI:Notify({
                    Title = "重复点击！", 
                    Content = "", 
                    Duration = 3
                })
            end
            return
        end
        
        if not CheckServerId() then
            return
        end

        battlefieldLoaded = true

        local TabBattle = Window:Tab({
            Title = "最强战场",
            Icon = "swords",
            Locked = false,
        })

        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local RunService = game:GetService("RunService")

        local animationIDs = {
            ["rbxassetid://10468665991"] = true,
            ["rbxassetid://10466974800"] = true,
            ["rbxassetid://10471336737"] = true,
            ["rbxassetid://12510170988"] = true,
            ["rbxassetid://12272894215"] = true,
            ["rbxassetid://12296882427"] = true,
            ["rbxassetid://12307656616"] = true,
            ["rbxassetid://12351854556"] = true,
            ["rbxassetid://12534735382"] = true,
            ["rbxassetid://12502664044"] = true,
            ["rbxassetid://12509505723"] = true,
            ["rbxassetid://12618292188"] = true,
            ["rbxassetid://12684185971"] = true,
            ["rbxassetid://13376869471"] = true,
            ["rbxassetid://13294790250"] = true,
            ["rbxassetid://13376962659"] = true,
            ["rbxassetid://13501296372"] = true,
            ["rbxassetid://14004235777"] = true,
            ["rbxassetid://14003607057"] = true,
            ["rbxassetid://14046756619"] = true,
            ["rbxassetid://14048349132"] = true,
            ["rbxassetid://14299135500"] = true,
            ["rbxassetid://14967219354"] = true,
            ["rbxassetid://14357997687"] = true,
            ["rbxassetid://14357943487"] = true,
            ["rbxassetid://15290930205"] = true,
            ["rbxassetid://15145462680"] = true,
            ["rbxassetid://15295895753"] = true,
            ["rbxassetid://15311685628"] = true,
            ["rbxassetid://16139108718"] = true,
            ["rbxassetid://16139402582"] = true,
            ["rbxassetid://16515850153"] = true,
            ["rbxassetid://16431491215"] = true,
            ["rbxassetid://16597322398"] = true,
            ["rbxassetid://10469493270"] = true,
            ["rbxassetid://10469630950"] = true,
            ["rbxassetid://10469639222"] = true,
            ["rbxassetid://10469643643"] = true,
            ["rbxassetid://13532562418"] = true,
            ["rbxassetid://13491635433"] = true,
            ["rbxassetid://13296577783"] = true,
            ["rbxassetid://13295919399"] = true,
            ["rbxassetid://13370310513"] = true,
            ["rbxassetid://13390230973"] = true,
            ["rbxassetid://13378751717"] = true,
            ["rbxassetid://13378708199"] = true,
            ["rbxassetid://14004222985"] = true,
            ["rbxassetid://13997092940"] = true,
            ["rbxassetid://14001963401"] = true,
            ["rbxassetid://14136436157"] = true,
            ["rbxassetid://15259161390"] = true,
            ["rbxassetid://15240216931"] = true,
            ["rbxassetid://15240176873"] = true,
            ["rbxassetid://15162694192"] = true,
            ["rbxassetid://16515503507"] = true,
            ["rbxassetid://16515520431"] = true,
            ["rbxassetid://16515448089"] = true,
            ["rbxassetid://16552234590"] = true,
            ["rbxassetid://17889458563"] = true,
            ["rbxassetid://17889461810"] = true,
            ["rbxassetid://17889471098"] = true,
            ["rbxassetid://17889290569"] = true,
            ["rbxassetid://10479335397"] = true,
            ["rbxassetid://13380255751"] = true,
            ["rbxassetid://13362587853"] = true,
            ["rbxassetid://11365563255"] = {range = 175, behind = 17},
            ["rbxassetid://12983333733"] = {range = 200, behind = 16},
            ["rbxassetid://13927612951"] = {range = 100, behind = 16},
            ["rbxassetid://13146710762"] = {range = 200, behind = 24},
            ["rbxassetid://15520132233"] = {range = 100, behind = 75},
            ["rbxassetid://16082123712"] = {range = 40, behind = 20}
        }

        local detectionRange = 15
        local detectionMode = "360"
        local lastTeleportTime = 0

        local function getNearbyPlayers(radius)
            local players = {}
            for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                if otherPlayer ~= player then
                    local otherCharacter = otherPlayer.Character
                    if otherCharacter then
                        local otherHumanoidRootPart = otherCharacter:FindFirstChild("HumanoidRootPart")
                        if otherHumanoidRootPart and (otherHumanoidRootPart.Position - humanoidRootPart.Position).Magnitude <= radius then
                            table.insert(players, otherPlayer)
                        end
                    end
                end
            end
            return players
        end

        local function isInFront(character, target)
            local lookVector = character.CFrame.lookVector
            local directionToTarget = (target.Position - character.Position).unit
            return lookVector:Dot(directionToTarget) > 0.5
        end

        local function checkAnimations()
            local currentTime = tick()
            if currentTime - lastTeleportTime < 0.1 then
                return
            end
            
            local nearbyPlayers = getNearbyPlayers(detectionRange)
            for _, otherPlayer in pairs(nearbyPlayers) do
                local otherCharacter = otherPlayer.Character
                if otherCharacter then
                    local otherHumanoidRootPart = otherCharacter:FindFirstChild("HumanoidRootPart")
                    if otherHumanoidRootPart then
                        if (detectionMode == "360" or isInFront(humanoidRootPart, otherHumanoidRootPart)) then
                            for _, animTrack in pairs(otherCharacter:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()) do
                                local animId = animTrack.Animation.AnimationId
                                local data = animationIDs[animId]
                                if data then
                                    local teleportDistance = (type(data) == "table" and data.behind) or 18
                                    local newPosition = otherHumanoidRootPart.Position - otherHumanoidRootPart.CFrame.lookVector * teleportDistance + Vector3.new(math.random(-1, 1), 0, math.random(-1, 1))
                                    humanoidRootPart.CFrame = CFrame.new(newPosition)
                                    lastTeleportTime = currentTime
                                    return
                                end
                            end
                        end
                    end
                end
            end
        end

        local ultraInstinctActive = false

        local function ultraInstinctLoop()
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if ultraInstinctActive then
                    checkAnimations()
                else
                    connection:Disconnect()
                end
            end)
        end

        local function onCharacterAdded(newCharacter)
            character = newCharacter
            humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            if ultraInstinctActive then
                ultraInstinctLoop()
            end
        end

        player.CharacterAdded:Connect(onCharacterAdded)

        local animationsToAvoid = {
            ["rbxassetid://10468665991"] = true,
            ["rbxassetid://10466974800"] = true,
            ["rbxassetid://10471336737"] = true,
            ["rbxassetid://12510170988"] = true,
            ["rbxassetid://12272894215"] = true,
            ["rbxassetid://12296882427"] = true,
            ["rbxassetid://12307656616"] = true,
            ["rbxassetid://12351854556"] = true,
            ["rbxassetid://12534735382"] = true,
            ["rbxassetid://12502664044"] = true,
            ["rbxassetid://12509505723"] = true,
            ["rbxassetid://12618292188"] = true,
            ["rbxassetid://12684185971"] = true,
            ["rbxassetid://13376869471"] = true,
            ["rbxassetid://13294790250"] = true,
            ["rbxassetid://13376962659"] = true,
            ["rbxassetid://13501296372"] = true,
            ["rbxassetid://14004235777"] = true,
            ["rbxassetid://14003607057"] = true,
            ["rbxassetid://14046756619"] = true,
            ["rbxassetid://14048349132"] = true,
            ["rbxassetid://14299135500"] = true,
            ["rbxassetid://14967219354"] = true,
            ["rbxassetid://14357997687"] = true,
            ["rbxassetid://14357943487"] = true,
            ["rbxassetid://15290930205"] = true,
            ["rbxassetid://15145462680"] = true,
            ["rbxassetid://15295895753"] = true,
            ["rbxassetid://15311685628"] = true,
            ["rbxassetid://16139108718"] = true,
            ["rbxassetid://16139402582"] = true,
            ["rbxassetid://16515850153"] = true,
            ["rbxassetid://16431491215"] = true,
            ["rbxassetid://16597322398"] = true,
            ["rbxassetid://10469493270"] = "special"
        }

        local skills = {
            firstskill = {"Normal Punch", "Flowing Water", "Machine Gun Blows", "Flash Strike", "Homerun", "Quick Slice", "Bullet Barrage", "Crushing Pull"},
            secondskill = {"Atmos Cleave", "Windstorm Fury", "Ignition Burst", "Whirlwind Kick", "Beatdown", "Consecutive Punches", "Lethal Whirlwind Stream", "Vanishing Kick"},
            thirdskill = {"Shove", "Hunter's Grasp", "Blitz Shot", "Scatter", "Grand Slam", "Pinpoint Cut", "Stone Coffin", "Whirlwind Drop"},
            fourthskill = {"Split Second Counter", "Expulsive Push", "Jet Dive", "Explosive Shuriken", "Foul Ball", "Uppercut", "Head First", "Prey's Peril"}
        }

        local skillCooldowns = {
            ["Normal Punch"] = 21,
            ["Flowing Water"] = 19,
            ["Machine Gun Blows"] = 17,
            ["Flash Strike"] = 18.5,
            ["Homerun"] = 18.6,
            ["Quick Slice"] = 21.5,
            ["Bullet Barrage"] = 22,
            ["Crushing Pull"] = 23,
            ["Consecutive Punches"] = 19,
            ["Lethal Whirlwind Stream"] = 22,
            ["Ignition Burst"] = 18.3,
            ["Whirlwind Kick"] = 21.5,
            ["Beatdown"] = 24.3,
            ["Atmos Cleave"] = 23.2,
            ["Windstorm Fury"] = 21,
            ["Vanishing Kick"] = 21,
            ["Shove"] = 11,
            ["Hunter's Grasp"] = 17.8,
            ["Blitz Shot"] = 26,
            ["Scatter"] = 22.3,
            ["Grand Slam"] = 21.7,
            ["Pinpoint Cut"] = 18,
            ["Stone Coffin"] = 25.7,
            ["Whirlwind Drop"] = 15.7,
            ["Jet Dive"] = 19.5,
            ["Explosive Shuriken"] = 18.5,
            ["Foul Ball"] = 24.8,
            ["Split Second Counter"] = 18.7,
            ["Expulsive Push"] = 20.7,
            ["Prey's Peril"] = 18.5,
            ["Head First"] = 22,
            ["Uppercut"] = 21
        }

        local skillUsage = {
            firstskill = 0,
            secondskill = 0,
            thirdskill = 0,
            fourthskill = 0
        }

        local function isAnimationPlaying(character)
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                    if animationsToAvoid[track.Animation.AnimationId] then
                        return animationsToAvoid[track.Animation.AnimationId]
                    end
                end
            end
            return false
        end

        local function teleportBehindTarget(player, targetPlayer, distance)
            local targetCharacter = targetPlayer.Character
            if targetCharacter then
                local targetHRP = targetCharacter:FindFirstChild("HumanoidRootPart")
                local playerHRP = player.Character:FindFirstChild("HumanoidRootPart")
                if targetHRP and playerHRP then
                    local backOffset = targetHRP.CFrame.lookVector * -distance
                    playerHRP.CFrame = CFrame.new(targetHRP.Position + backOffset, targetHRP.Position)
                end
            end
        end

        local function equipAndUseSkill(player, skillType)
            local character = player.Character
            if character then
                local backpack = player.Backpack
                local liveFolder = workspace:FindFirstChild("Live")
                if backpack and liveFolder then
                    for _, skill in pairs(skills[skillType]) do
                        local tool = backpack:FindFirstChild(skill) or character:FindFirstChild(skill)
                        if tool then
                            pcall(function()
                                character.Humanoid:EquipTool(tool)
                                
                                local args = {
                                    [1] = {
                                        ["Mobile"] = true,
                                        ["Goal"] = "LeftClick"
                                    }
                                }
                                game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(args))

                                wait(0.02)

                                local argsRelease = {
                                    [1] = {
                                        ["Goal"] = "LeftClickRelease",
                                        ["Mobile"] = true
                                    }
                                }
                                game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(argsRelease))

                                character.Humanoid:UnequipTools()

                                if skillCooldowns[skill] then
                                    skillUsage[skillType] = tick()
                                    wait(skillCooldowns[skill])
                                end
                            end)
                        end
                    end
                end
            end
        end

        local autoFarmThread
        local useFirstSkill = false
        local useSecondSkill = false
        local useThirdSkill = false
        local useFourthSkill = false
        local ignoreFriends = false
        local specificPlayerUsername = ""
        local specificPlayerTarget = nil

        local function findClosestMatchingPlayer(inputName)
            local players = game:GetService("Players"):GetPlayers()
            local closestPlayer = nil
            local closestDistance = math.huge

            for _, player in pairs(players) do
                local distance = string.len(player.Name) + string.len(inputName) - 2 * string.len(player.Name:sub(1, string.len(inputName)))
                if distance < closestDistance then
                    closestDistance = distance
                    closestPlayer = player
                end
            end

            return closestPlayer
        end

        local function autoFarm()
            local player = game:GetService("Players").LocalPlayer
            local targetPlayer

            while true do
                wait(0.02)

                if specificPlayerTarget then
                    targetPlayer = specificPlayerTarget
                else
                    if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") or targetPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then
                        local players = game:GetService("Players"):GetPlayers()
                        repeat
                            targetPlayer = players[math.random(1, #players)]
                        until targetPlayer ~= player and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and (not ignoreFriends or not player:IsFriendsWith(targetPlayer.UserId))
                    end
                end

                if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
                    repeat wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                end

                local function handleAvoidAnimation()
                    local endTime = tick() + 1
                    while tick() < endTime do
                        teleportBehindTarget(player, targetPlayer, 13)
                        wait(0.02)
                    end
                end

                if isAnimationPlaying(targetPlayer.Character) then
                    handleAvoidAnimation()
                else
                    teleportBehindTarget(player, targetPlayer, 3)

                    local args = {
                        [1] = {
                            ["Goal"] = "LeftClick",
                            ["Mobile"] = true
                        }
                    }
                    pcall(function()
                        game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(args))
                    end)

                    local argsRelease = {
                        [1] = {
                            ["Goal"] = "LeftClickRelease",
                            ["Mobile"] = true
                        }
                    }
                    pcall(function()
                        game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(argsRelease))
                    end)

                    local currentTime = tick()

                    if useFirstSkill and (currentTime - skillUsage["firstskill"] >= skillCooldowns[skills.firstskill[1]]) then
                        coroutine.wrap(equipAndUseSkill)(player, "firstskill")
                        skillUsage["firstskill"] = currentTime
                    end
                    if useSecondSkill and (currentTime - skillUsage["secondskill"] >= skillCooldowns[skills.secondskill[1]]) then
                        coroutine.wrap(equipAndUseSkill)(player, "secondskill")
                        skillUsage["secondskill"] = currentTime
                    end
                    if useThirdSkill and (currentTime - skillUsage["thirdskill"] >= skillCooldowns[skills.thirdskill[1]]) then
                        coroutine.wrap(equipAndUseSkill)(player, "thirdskill")
                        skillUsage["thirdskill"] = currentTime
                    end
                    if useFourthSkill and (currentTime - skillUsage["fourthskill"] >= skillCooldowns[skills.fourthskill[1]]) then
                        coroutine.wrap(equipAndUseSkill)(player, "fourthskill")
                        skillUsage["fourthskill"] = currentTime
                    end
                end
            end
        end

        local punchAnimations = {
            ["10469493270"] = true,
            ["10469630950"] = true,
            ["10469639222"] = true,
            ["10469643643"] = true,
            ["13532562418"] = true,
            ["13491635433"] = true,
            ["13296577783"] = true,
            ["13295919399"] = true,
            ["13370310513"] = true,
            ["13390230973"] = true,
            ["13378751717"] = true,
            ["13378708199"] = true,
            ["14004222985"] = true,
            ["13997092940"] = true,
            ["14001963401"] = true,
            ["14136436157"] = true,
            ["15259161390"] = true,
            ["15240216931"] = true,
            ["15240176873"] = true,
            ["15162694192"] = true,
            ["16515503507"] = true,
            ["16515520431"] = true,
            ["16515448089"] = true,
            ["16552234590"] = true,
            ["17889458563"] = true,
            ["17889461810"] = true,
            ["17889471098"] = true,
            ["17889290569"] = true
        }

        local dashAnimations = {
            ["10479335397"] = true,
            ["13380255751"] = true
        }

        local skillAnimations = {
            ["10466974800"] = 1.8,
            ["12534735382"] = 1.9,
            ["14046756619"] = 0.5,
            ["13376962659"] = 1.0,
            ["12296882427"] = 0.4,
            ["12618292188"] = 0.6,
            ["12618271998"] = 0.6,
            ["13376869471"] = 0.5,
            ["17799224866"] = 0.9,
            ["18179181663"] = 0.6,
            ["16515850153"] = 0.8,
            ["16431491215"] = 0.7
        }

        local blockAnimations = {
            ["BlockingAnimationId"] = true
        }

        local function isPlayerInRange(player, range)
            local localPlayer = game:GetService("Players").LocalPlayer
            local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
            local rootPart = character:WaitForChild("HumanoidRootPart")

            local targetCharacter = player.Character
            if targetCharacter then
                local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
                if targetRootPart then
                    local distance = (rootPart.Position - targetRootPart.Position).Magnitude
                    return distance <= range
                end
            end
            return false
        end

        local function isLocalPlayerPlayingAnimation()
            local localPlayer = game:GetService("Players").LocalPlayer
            local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
            for _, animTrack in pairs(character.Humanoid:GetPlayingAnimationTracks()) do
                local animId = animTrack.Animation.AnimationId:match("%d+$")
                if punchAnimations[animId] or dashAnimations[animId] or skillAnimations[animId] then
                    return true
                end
            end
            return false
        end

        local function isLocalPlayerBlocking()
            local localPlayer = game:GetService("Players").LocalPlayer
            local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
            for _, animTrack in pairs(character.Humanoid:GetPlayingAnimationTracks()) do
                local animId = animTrack.Animation.AnimationId:match("%d+$")
                if blockAnimations[animId] then
                    return true
                end
            end
            return false
        end

        local function detectAnimations()
            local players = game:GetService("Players")

            for _, player in pairs(players:GetPlayers()) do
                if player ~= players.LocalPlayer then
                    local inRange = false
                    if detectionMode == "360" then
                        inRange = isPlayerInRange(player, 50)
                    end

                    if inRange then
                        local character = player.Character
                        if character then
                            for _, animTrack in pairs(character.Humanoid:GetPlayingAnimationTracks()) do
                                local animId = animTrack.Animation.AnimationId:match("%d+$")
                                if not isLocalPlayerPlayingAnimation() then
                                    if punchAnimations[animId] then
                                        local args = {
                                            [1] = {
                                                ["Goal"] = "KeyPress",
                                                ["Key"] = Enum.KeyCode.F
                                            }
                                        }
                                        pcall(function()
                                            game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(args))
                                        end)
                                        wait(0.45)
                                        local argsRelease = {
                                            [1] = {
                                                ["Goal"] = "KeyRelease",
                                                ["Key"] = Enum.KeyCode.F
                                            }
                                        }
                                        pcall(function()
                                            game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(argsRelease))
                                        end)
                                    elseif dashAnimations[animId] then
                                        local args = {
                                            [1] = {
                                                ["Goal"] = "KeyPress",
                                                ["Key"] = Enum.KeyCode.F
                                            }
                                        }
                                        pcall(function()
                                            game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(args))
                                        end)
                                        wait(0.90)
                                        local argsRelease = {
                                            [1] = {
                                                ["Goal"] = "KeyRelease",
                                                ["Key"] = Enum.KeyCode.F
                                            }
                                        }
                                        pcall(function()
                                            game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(argsRelease))
                                        end)
                                    elseif skillAnimations[animId] then
                                        local args = {
                                            [1] = {
                                                ["Goal"] = "KeyPress",
                                                ["Key"] = Enum.KeyCode.F
                                            }
                                        }
                                        pcall(function()
                                            game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(args))
                                        end)
                                        wait(skillAnimations[animId])
                                        local argsRelease = {
                                            [1] = {
                                                ["Goal"] = "KeyRelease",
                                                ["Key"] = Enum.KeyCode.F
                                            }
                                        }
                                        pcall(function()
                                            game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(argsRelease))
                                        end)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        local function autoPunch()
            local players = game:GetService("Players")

            for _, player in pairs(players:GetPlayers()) do
                if player ~= players.LocalPlayer then
                    local inRange = false
                    if detectionMode == "360" then
                        inRange = isPlayerInRange(player, 7)
                    end

                    if inRange and not isLocalPlayerBlocking() then
                        local args = {
                            [1] = {
                                ["Goal"] = "LeftClick",
                                ["Mobile"] = true
                            }
                        }
                        pcall(function()
                            game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(args))
                        end)

                        local argsRelease = {
                            [1] = {
                                ["Goal"] = "LeftClickRelease",
                                ["Mobile"] = true
                            }
                        }
                        pcall(function()
                            game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(argsRelease))
                        end)
                    end
                end
            end
        end

        local autoBlockEnabled = false
        local autoPunchEnabled = false

        RunService.Heartbeat:Connect(function()
            if autoBlockEnabled then
                detectAnimations()
            end
            if autoPunchEnabled then
                autoPunch()
            end
        end)

        TabBattle:Section({ Title = "---- 战斗功能 ----" })

        TabBattle:Toggle({
            Title = "防击打",
            Value = false,
            Callback = function(Value)
                ultraInstinctActive = Value
                if ultraInstinctActive then
                    ultraInstinctLoop()
                end
            end
        })

        TabBattle:Toggle({
            Title = "自动打人",
            Value = false,
            Callback = function(Value)
                if Value then
                    autoFarmThread = coroutine.create(autoFarm)
                    coroutine.resume(autoFarmThread)
                else
                    if autoFarmThread then
                        coroutine.close(autoFarmThread)
                        autoFarmThread = nil
                    end
                end
            end
        })

        TabBattle:Input({
            Title = "输入玩家用户名",
            Placeholder = "输入玩家用户名",
            Callback = function(Value)
                specificPlayerUsername = Value
                specificPlayerTarget = findClosestMatchingPlayer(specificPlayerUsername)
            end
        })

        TabBattle:Button({
            Title = "关闭自动打人",
            Callback = function()
                specificPlayerTarget = nil
            end
        })

        TabBattle:Toggle({
            Title = "自动格挡",
            Value = false,
            Callback = function(Value)
                autoBlockEnabled = Value
            end
        })

        TabBattle:Toggle({
            Title = "自动挥拳",
            Value = false,
            Callback = function(Value)
                autoPunchEnabled = Value
            end
        })

        TabBattle:Toggle({
            Title = "自瞄玩家",
            Value = false,
            Callback = function(Value)
                getgenv().AutoAimlocking = Value
                RunService.RenderStepped:Connect(function() 
                    if not getgenv().AutoAimlocking == true then 
                        return 
                    end 
                    local x,b 
                    for _,v in ipairs(game:GetService("Players"):GetPlayers()) do 
                        if v.Character and v ~= game:GetService("Players").LocalPlayer then 
                            if not x or (v.Character.Head.Position - game:GetService("Players").LocalPlayer.Character.Head.Position).Magnitude < b then 
                                x = v 
                                b = (v.Character.Head.Position - game:GetService("Players").LocalPlayer.Character.Head.Position).Magnitude 
                            end 
                        end 
                    end 
                    if x and b <= 15 then 
                        game:GetService("Workspace").CurrentCamera.CFrame = CFrame.new(game:GetService("Workspace").CurrentCamera.CFrame.p, x.Character.HumanoidRootPart.Position) 
                    end 
                end)
            end
        })

        TabBattle:Toggle({
            Title = "自动躲技能",
            Value = false,
            Callback = function(Value)
                getgenv().AutoDodging = Value

                local DashAnims = {NormalDash = {10479335397},WeaponDash = {13380255751}}
                local SaitamaAnims = {NormalPunch = {10468665991}}
                local GarouAnims = {FlowingWater = {12272894215}}
                local GenosAnims = {MachineGunBlows = {12534735382}}
                local SonicAnims = {FlashStrike = {13376869471}}
                local MetalBatAnims = {Homerun = {14004235777,14003607057}}
                local SamuraiAnims = {QuickSlice = {15290930205}}
                local EsperAnims = {CrushingPull = {16139108718,16139402582}}

                local Animations = {}
                for _,x in pairs({DashAnims,SaitamaAnims,GarouAnims,GenosAnims,SonicAnims,MetalBatAnims,SamuraiAnims,EsperAnims}) do
                    for _,k in pairs(x) do
                        for _,v in pairs(k) do
                            table.insert(Animations,v)
                        end
                    end
                end

                task.spawn(function()
                    local connection
                    connection = RunService.RenderStepped:Connect(function()
                        if getgenv().AutoDodging == true then
                            pcall(function()
                                for _,k in ipairs(workspace.Live:GetChildren()) do
                                    if k:IsA("Model") and k:FindFirstChild("Head") and k.Head:IsA("Part") and k.Head.Name == "Head" and k.Head ~= game.Players.LocalPlayer.Character.Head then
                                        if (k.Head.Position - game.Players.LocalPlayer.Character.Head.Position).magnitude <= 25 then
                                            if k:FindFirstChildOfClass("Humanoid") and k:FindFirstChildOfClass("Humanoid").Health > 0 then 
                                                local IsUsingAttacks = false
                                                for _,x in pairs(k:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()) do
                                                    local animId = x.Animation.AnimationId:match("%d+")
                                                    if animId and table.find(Animations, tonumber(animId)) then
                                                        IsUsingAttacks = true
                                                        break
                                                    end
                                                end

                                                if k:FindFirstChild("M1ing") or IsUsingAttacks then    
                                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(k.Head.Position + k.Head.CFrame.lookVector * -20 + Vector3.new(0,35,0),k.Head.Position)
                                                end
                                            end
                                        end
                                    end
                                end
                            end)
                        else
                            if connection then
                                connection:Disconnect()
                            end
                        end
                    end)
                end)
            end
        })

        TabBattle:Section({ Title = "---- 自动功能 ----" })

        TabBattle:Toggle({
            Title = "自动放技能1",
            Value = false,
            Callback = function(Value)
                useFirstSkill = Value
            end
        })

        TabBattle:Toggle({
            Title = "自动放技能2",
            Value = false,
            Callback = function(Value)
                useSecondSkill = Value
            end
        })

        TabBattle:Toggle({
            Title = "自动放技能3",
            Value = false,
            Callback = function(Value)
                useThirdSkill = Value
            end
        })

        TabBattle:Toggle({
            Title = "自动放技能4",
            Value = false,
            Callback = function(Value)
                useFourthSkill = Value
            end
        })

        if WindUI and WindUI.Notify then
            WindUI:Notify({
                Title = "最强战场已加载", 
                Content = "", 
                Duration = 3
            })
        end
    end
})

Tabs.sbcnm:Section({
    Title = "启示录", 
    TextXAlignment = "Left", 
    TextSize = 17
})

local apocalypseLoaded = false

local allowedServerIds = {
    "122160128185618",
}

local function GetCurrentServerId()
    local success, id = pcall(function()
        return tostring(game.PlaceId)
    end)
    if success and id then
        return id
    end
    return nil
end

local function CheckServerId()
    local currentId = GetCurrentServerId()
    if not currentId then
        if WindUI and WindUI.Notify then
            WindUI:Notify({
                Title = "加载失败", 
                Content = "无法获取ID", 
                Duration = 3
            })
        end
        return false
    end
    
    for _, allowedId in ipairs(allowedServerIds) do
        if currentId == allowedId then
            return true
        end
    end
    
    if WindUI and WindUI.Notify then
        WindUI:Notify({
            Title = "服务器不符", 
            Content = "当前ID: " .. currentId, 
            Duration = 3
        })
    end
    return false
end

Tabs.sbcnm:Button({
    Title = "启示录",
    Callback = function()
        if apocalypseLoaded then
            if WindUI and WindUI.Notify then
                WindUI:Notify({
                    Title = "重复点击！", 
                    Content = "", 
                    Duration = 3
                })
            end
            return
        end
        
        if not CheckServerId() then
            return
        end

        apocalypseLoaded = true

        local TabPerspective = Window:Tab({
            Title = "透视",
            Icon = "eye",
            Locked = false,
        })

        local TabMain = Window:Tab({
            Title = "主要",
            Icon = "swords",
            Locked = false,
        })

        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local RunService = game:GetService("RunService")
        local Workspace = game:GetService("Workspace")
        local Camera = Workspace.CurrentCamera

        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local Humanoid = Character:WaitForChild("Humanoid")

        local Data = {
            TreeCuttingDistance = 50,
            MiningDistance = 50,
            KillAuraDistance = 50,
            AutoTreeCutting = false,
            AutoMining = false,
            KillAura = false,
            InfiniteStamina = false,
        }

        local activeHighlights = {}
        local heartbeatConnection = nil
        local sd = nil
        local speed = 1

        TabPerspective:Toggle({
            Title = "透视宝箱",
            Default = false,
            Callback = function(state)
                local TARGET_NAME = "CommonLoot"

                if state then
                    local function UpdateHighlights()
                        for _, highlight in pairs(activeHighlights) do
                            highlight:Destroy()
                        end
                        activeHighlights = {}

                        local spawnedFolder = Workspace:FindFirstChild("Spawned")
                        if spawnedFolder then
                            for _, child in ipairs(spawnedFolder:GetChildren()) do
                                if child.Name == TARGET_NAME then
                                    if child:IsA("Model") or child:IsA("BasePart") then
                                        local newHighlight = Instance.new("Highlight")
                                        newHighlight.FillColor = Color3.fromRGB(255, 255, 0)
                                        newHighlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                                        newHighlight.Adornee = child
                                        newHighlight.Parent = Camera
                                        table.insert(activeHighlights, newHighlight)
                                    end
                                end
                            end
                        end
                    end

                    heartbeatConnection = RunService.Heartbeat:Connect(UpdateHighlights)
                else
                    if heartbeatConnection then
                        heartbeatConnection:Disconnect()
                        heartbeatConnection = nil
                    end
                    for _, highlight in pairs(activeHighlights) do
                        highlight:Destroy()
                    end
                    activeHighlights = {}
                end
            end
        })

        TabPerspective:Toggle({
            Title = "透视蓝莓灌木",
            Default = false,
            Callback = function(state)
                local TARGET_NAME = "BlueberryBush"

                if state then
                    local function UpdateHighlights()
                        for _, highlight in pairs(activeHighlights) do
                            highlight:Destroy()
                        end
                        activeHighlights = {}

                        local spawnedFolder = Workspace:FindFirstChild("Spawned")
                        if spawnedFolder then
                            for _, child in ipairs(spawnedFolder:GetChildren()) do
                                if child.Name == TARGET_NAME then
                                    if child:IsA("Model") or child:IsA("BasePart") then
                                        local newHighlight = Instance.new("Highlight")
                                        newHighlight.FillColor = Color3.fromRGB(174, 55, 204)
                                        newHighlight.OutlineColor = Color3.fromRGB(174, 55, 204)
                                        newHighlight.Adornee = child
                                        newHighlight.Parent = Camera
                                        table.insert(activeHighlights, newHighlight)
                                    end
                                end
                            end
                        end
                    end

                    heartbeatConnection = RunService.Heartbeat:Connect(UpdateHighlights)
                else
                    if heartbeatConnection then
                        heartbeatConnection:Disconnect()
                        heartbeatConnection = nil
                    end
                    for _, highlight in pairs(activeHighlights) do
                        highlight:Destroy()
                    end
                    activeHighlights = {}
                end
            end
        })

        TabPerspective:Toggle({
            Title = "透视石头",
            Default = false,
            Callback = function(state)
                local TARGET_NAME = "Stone"

                if state then
                    local function UpdateHighlights()
                        for _, highlight in pairs(activeHighlights) do
                            highlight:Destroy()
                        end
                        activeHighlights = {}

                        local spawnedFolder = Workspace:FindFirstChild("Spawned")
                        if spawnedFolder then
                            for _, child in ipairs(spawnedFolder:GetChildren()) do
                                if child.Name == TARGET_NAME then
                                    if child:IsA("Model") or child:IsA("BasePart") then
                                        local newHighlight = Instance.new("Highlight")
                                        newHighlight.FillColor = Color3.fromRGB(12, 98, 209)
                                        newHighlight.OutlineColor = Color3.fromRGB(12, 98, 209)
                                        newHighlight.Adornee = child
                                        newHighlight.Parent = Camera
                                        table.insert(activeHighlights, newHighlight)
                                    end
                                end
                            end
                        end
                    end

                    heartbeatConnection = RunService.Heartbeat:Connect(UpdateHighlights)
                else
                    if heartbeatConnection then
                        heartbeatConnection:Disconnect()
                        heartbeatConnection = nil
                    end
                    for _, highlight in pairs(activeHighlights) do
                        highlight:Destroy()
                    end
                    activeHighlights = {}
                end
            end
        })

        TabPerspective:Toggle({
            Title = "透视铜矿石",
            Default = false,
            Callback = function(state)
                local TARGET_NAME = "CopperOre"

                if state then
                    local function UpdateHighlights()
                        for _, highlight in pairs(activeHighlights) do
                            highlight:Destroy()
                        end
                        activeHighlights = {}

                        local spawnedFolder = Workspace:FindFirstChild("Spawned")
                        if spawnedFolder then
                            for _, child in ipairs(spawnedFolder:GetChildren()) do
                                if child.Name == TARGET_NAME then
                                    if child:IsA("Model") or child:IsA("BasePart") then
                                        local newHighlight = Instance.new("Highlight")
                                        newHighlight.FillColor = Color3.fromRGB(224, 24, 24)
                                        newHighlight.OutlineColor = Color3.fromRGB(224, 24, 24)
                                        newHighlight.Adornee = child
                                        newHighlight.Parent = Camera
                                        table.insert(activeHighlights, newHighlight)
                                    end
                                end
                            end
                        end
                    end

                    heartbeatConnection = RunService.Heartbeat:Connect(UpdateHighlights)
                else
                    if heartbeatConnection then
                        heartbeatConnection:Disconnect()
                        heartbeatConnection = nil
                    end
                    for _, highlight in pairs(activeHighlights) do
                        highlight:Destroy()
                    end
                    activeHighlights = {}
                end
            end
        })

        TabPerspective:Toggle({
            Title = "透视铁矿石",
            Default = false,
            Callback = function(state)
                local TARGET_NAME = "IronOre"

                if state then
                    local function UpdateHighlights()
                        for _, highlight in pairs(activeHighlights) do
                            highlight:Destroy()
                        end
                        activeHighlights = {}

                        local spawnedFolder = Workspace:FindFirstChild("Spawned")
                        if spawnedFolder then
                            for _, child in ipairs(spawnedFolder:GetChildren()) do
                                if child.Name == TARGET_NAME then
                                    if child:IsA("Model") or child:IsA("BasePart") then
                                        local newHighlight = Instance.new("Highlight")
                                        newHighlight.FillColor = Color3.fromRGB(0, 255, 136)
                                        newHighlight.OutlineColor = Color3.fromRGB(0, 255, 136)
                                        newHighlight.Adornee = child
                                        newHighlight.Parent = Camera
                                        table.insert(activeHighlights, newHighlight)
                                    end
                                end
                            end
                        end
                    end

                    heartbeatConnection = RunService.Heartbeat:Connect(UpdateHighlights)
                else
                    if heartbeatConnection then
                        heartbeatConnection:Disconnect()
                        heartbeatConnection = nil
                    end
                    for _, highlight in pairs(activeHighlights) do
                        highlight:Destroy()
                    end
                    activeHighlights = {}
                end
            end
        })

        TabPerspective:Toggle({
            Title = "透视马铃薯植物",
            Default = false,
            Callback = function(state)
                local TARGET_NAME = "PotatoPlant"

                if state then
                    local function UpdateHighlights()
                        for _, highlight in pairs(activeHighlights) do
                            highlight:Destroy()
                        end
                        activeHighlights = {}

                        local spawnedFolder = Workspace:FindFirstChild("Spawned")
                        if spawnedFolder then
                            for _, child in ipairs(spawnedFolder:GetChildren()) do
                                if child.Name == TARGET_NAME then
                                    if child:IsA("Model") or child:IsA("BasePart") then
                                        local newHighlight = Instance.new("Highlight")
                                        newHighlight.FillColor = Color3.fromRGB(98, 0, 255)
                                        newHighlight.OutlineColor = Color3.fromRGB(98, 0, 255)
                                        newHighlight.Adornee = child
                                        newHighlight.Parent = Camera
                                        table.insert(activeHighlights, newHighlight)
                                    end
                                end
                            end
                        end
                    end

                    heartbeatConnection = RunService.Heartbeat:Connect(UpdateHighlights)
                else
                    if heartbeatConnection then
                        heartbeatConnection:Disconnect()
                        heartbeatConnection = nil
                    end
                    for _, highlight in pairs(activeHighlights) do
                        highlight:Destroy()
                    end
                    activeHighlights = {}
                end
            end
        })

        TabPerspective:Toggle({
            Title = "透视稀有战利品",
            Default = false,
            Callback = function(state)
                local TARGET_NAME = "RareLoot"

                if state then
                    local function UpdateHighlights()
                        for _, highlight in pairs(activeHighlights) do
                            highlight:Destroy()
                        end
                        activeHighlights = {}

                        local spawnedFolder = Workspace:FindFirstChild("Spawned")
                        if spawnedFolder then
                            for _, child in ipairs(spawnedFolder:GetChildren()) do
                                if child.Name == TARGET_NAME then
                                    if child:IsA("Model") or child:IsA("BasePart") then
                                        local newHighlight = Instance.new("Highlight")
                                        newHighlight.FillColor = Color3.fromRGB(0, 183, 255)
                                        newHighlight.OutlineColor = Color3.fromRGB(0, 183, 255)
                                        newHighlight.Adornee = child
                                        newHighlight.Parent = Camera
                                        table.insert(activeHighlights, newHighlight)
                                    end
                                end
                            end
                        end
                    end

                    heartbeatConnection = RunService.Heartbeat:Connect(UpdateHighlights)
                else
                    if heartbeatConnection then
                        heartbeatConnection:Disconnect()
                        heartbeatConnection = nil
                    end
                    for _, highlight in pairs(activeHighlights) do
                        highlight:Destroy()
                    end
                    activeHighlights = {}
                end
            end
        })

        TabPerspective:Toggle({
            Title = "透视砂岩",
            Default = false,
            Callback = function(state)
                local TARGET_NAME = "Sandstone"

                if state then
                    local function UpdateHighlights()
                        for _, highlight in pairs(activeHighlights) do
                            highlight:Destroy()
                        end
                        activeHighlights = {}

                        local spawnedFolder = Workspace:FindFirstChild("Spawned")
                        if spawnedFolder then
                            for _, child in ipairs(spawnedFolder:GetChildren()) do
                                if child.Name == TARGET_NAME then
                                    if child:IsA("Model") or child:IsA("BasePart") then
                                        local newHighlight = Instance.new("Highlight")
                                        newHighlight.FillColor = Color3.fromRGB(38, 0, 255)
                                        newHighlight.OutlineColor = Color3.fromRGB(38, 0, 255)
                                        newHighlight.Adornee = child
                                        newHighlight.Parent = Camera
                                        table.insert(activeHighlights, newHighlight)
                                    end
                                end
                            end
                        end
                    end

                    heartbeatConnection = RunService.Heartbeat:Connect(UpdateHighlights)
                else
                    if heartbeatConnection then
                        heartbeatConnection:Disconnect()
                        heartbeatConnection = nil
                    end
                    for _, highlight in pairs(activeHighlights) do
                        highlight:Destroy()
                    end
                    activeHighlights = {}
                end
            end
        })

        TabPerspective:Toggle({
            Title = "透视煤",
            Default = false,
            Callback = function(state)
                local TARGET_NAME = "Coal"

                if state then
                    local function UpdateHighlights()
                        for _, highlight in pairs(activeHighlights) do
                            highlight:Destroy()
                        end
                        activeHighlights = {}

                        local spawnedFolder = Workspace:FindFirstChild("Spawned")
                        if spawnedFolder then
                            for _, child in ipairs(spawnedFolder:GetChildren()) do
                                if child.Name == TARGET_NAME then
                                    if child:IsA("Model") or child:IsA("BasePart") then
                                        local newHighlight = Instance.new("Highlight")
                                        newHighlight.FillColor = Color3.fromRGB(0, 204, 255)
                                        newHighlight.OutlineColor = Color3.fromRGB(0, 204, 255)
                                        newHighlight.Adornee = child
                                        newHighlight.Parent = Camera
                                        table.insert(activeHighlights, newHighlight)
                                    end
                                end
                            end
                        end
                    end

                    heartbeatConnection = RunService.Heartbeat:Connect(UpdateHighlights)
                else
                    if heartbeatConnection then
                        heartbeatConnection:Disconnect()
                        heartbeatConnection = nil
                    end
                    for _, highlight in pairs(activeHighlights) do
                        highlight:Destroy()
                    end
                    activeHighlights = {}
                end
            end
        })

        TabPerspective:Toggle({
            Title = "透视草莓丛",
            Default = false,
            Callback = function(state)
                local TARGET_NAME = "StrawberryBush"

                if state then
                    local function UpdateHighlights()
                        for _, highlight in pairs(activeHighlights) do
                            highlight:Destroy()
                        end
                        activeHighlights = {}

                        local spawnedFolder = Workspace:FindFirstChild("Spawned")
                        if spawnedFolder then
                            for _, child in ipairs(spawnedFolder:GetChildren()) do
                                if child.Name == TARGET_NAME then
                                    if child:IsA("Model") or child:IsA("BasePart") then
                                        local newHighlight = Instance.new("Highlight")
                                        newHighlight.FillColor = Color3.fromRGB(0, 205, 255)
                                        newHighlight.OutlineColor = Color3.fromRGB(0, 205, 255)
                                        newHighlight.Adornee = child
                                        newHighlight.Parent = Camera
                                        table.insert(activeHighlights, newHighlight)
                                    end
                                end
                            end
                        end
                    end

                    heartbeatConnection = RunService.Heartbeat:Connect(UpdateHighlights)
                else
                    if heartbeatConnection then
                        heartbeatConnection:Disconnect()
                        heartbeatConnection = nil
                    end
                    for _, highlight in pairs(activeHighlights) do
                        highlight:Destroy()
                    end
                    activeHighlights = {}
                end
            end
        })

        TabMain:Slider({
            Title = "杀戮光环范围",
            Value = {Min = 16, Max = 200, Default = 50},
            Callback = function(Value)
                Data.KillAuraDistance = Value
            end
        })

        TabMain:Toggle({
            Title = "杀戮光环",
            Value = false,
            Callback = function(state)
                Data.KillAura = state
                spawn(function()
                    while Data.KillAura and task.wait() do
                        pcall(function()
                            local closestEnemy, minDistance = nil, math.huge
                            local currentDistance = Data.KillAuraDistance or 50
                            local enemies = Workspace:FindFirstChild("Enemies")
                            if enemies then
                                for _,v in next,enemies:GetChildren() do
                                    if v then
                                        local distance = (LocalPlayer.Character.HumanoidRootPart.Position - v:GetPivot().Position).Magnitude
                                        if distance <= currentDistance and distance < minDistance then
                                            closestEnemy = v
                                            minDistance = distance
                                        end
                                    end
                                end
                            end
                            
                            if closestEnemy then
                                game:GetService("ReplicatedStorage").Network.Items.ToolAction:FireServer("click", closestEnemy)
                            end
                        end)
                    end
                end)
            end
        })

        TabMain:Slider({
            Title = "速度调整",
            Value = {Min = 1, Max = 500, Default = 16},
            Callback = function(value)
                speed = value
            end
        })

        TabMain:Toggle({
            Title = "开启速度",
            Value = false,
            Callback = function(v)
                if v then
                    sd = RunService.Heartbeat:Connect(function()
                        if Character and Humanoid then
                            if Humanoid.MoveDirection.Magnitude > 0 then
                                Character:TranslateBy(Humanoid.MoveDirection * speed / 20)
                            end
                        end
                    end)
                elseif sd then
                    sd:Disconnect()
                    sd = nil
                end
            end
        })

        TabMain:Slider({
            Title = "砍树范围",
            Value = {Min = 16, Max = 200, Default = 50},
            Callback = function(Value)
                Data.TreeCuttingDistance = Value
            end
        })

        TabMain:Toggle({
            Title = "自动砍树",
            Value = false,
            Callback = function(state)
                Data.AutoTreeCutting = state
                spawn(function()
                    while Data.AutoTreeCutting and task.wait() do
                        pcall(function()
                            local closestTree, minDistance = nil, math.huge
                            local currentDistance = Data.TreeCuttingDistance or 50
                            local spawned = Workspace:FindFirstChild("Spawned")
                            if spawned then
                                for _,v in next,spawned:GetChildren() do
                                    if v and v.Name:find("Tree") then
                                        local distance = (LocalPlayer.Character.HumanoidRootPart.Position - v:GetPivot().Position).Magnitude
                                        if distance <= currentDistance and distance < minDistance then
                                            closestTree = v
                                            minDistance = distance
                                        end
                                    end
                                end
                            end
                            
                            if closestTree then
                                game:GetService("ReplicatedStorage").Network.Items.ToolAction:FireServer("click", closestTree, false)
                            end
                        end)
                    end
                end)
            end
        })

        TabMain:Slider({
            Title = "挖矿距离",
            Value = {Min = 16, Max = 200, Default = 50},
            Callback = function(Value)
                Data.MiningDistance = Value
            end
        })

        TabMain:Toggle({
            Title = "自动挖矿",
            Value = false,
            Callback = function(state)
                Data.AutoMining = state
                spawn(function()
                    while Data.AutoMining and task.wait() do
                        pcall(function()
                            local closestOre, minDistance = nil, math.huge
                            local currentDistance = Data.MiningDistance or 50
                            local spawned = Workspace:FindFirstChild("Spawned")
                            if spawned then
                                for _,v in next,spawned:GetChildren() do
                                    if v and v:FindFirstChild("Config") then
                                        local success, config = pcall(function()
                                            return require(v.Config)
                                        end)
                                        if success and config and config.handlerModule == "Ore" then
                                            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - v:GetPivot().Position).Magnitude
                                            if distance <= currentDistance and distance < minDistance then
                                                closestOre = v
                                                minDistance = distance
                                            end
                                        end
                                    end
                                end
                            end
                            
                            if closestOre then
                                game:GetService("ReplicatedStorage").Network.Items.ToolAction:FireServer("click", closestOre, false)
                            end
                        end)
                    end
                end)
            end
        })

        local sbxp = false
        TabMain:Toggle({
            Title = "无限体力",
            Default = false,
            Callback = function(state)
                sbxp = state
                while sbxp and task.wait() do
                    pcall(function()
                        game:GetService("ReplicatedStorage").Network.Character.TakeStamina:FireServer(-math.huge)
                    end)
                end
            end
        })

        if WindUI and WindUI.Notify then
            WindUI:Notify({
                Title = "启示录已加载", 
                Content = "", 
                Duration = 3
            })
        end
    end
})

Tabs.sbcnm:Section({
    Title = "自然灾害", 
    TextXAlignment = "Left", 
    TextSize = 17
})

local naturalLoaded = false

local allowedServerIds = {
    "189707",
}

local function GetCurrentServerId()
    local success, id = pcall(function()
        return tostring(game.PlaceId)
    end)
    if success and id then
        return id
    end
    return nil
end

local function CheckServerId()
    local currentId = GetCurrentServerId()
    if not currentId then
        if WindUI and WindUI.Notify then
            WindUI:Notify({Title = "加载失败", Content = "无法获取ID", Duration = 3})
        end
        return false
    end
    
    for _, allowedId in ipairs(allowedServerIds) do
        if currentId == allowedId then
            return true
        end
    end
    
    if WindUI and WindUI.Notify then
        WindUI:Notify({Title = "服务器不符", Content = "当前ID: " .. currentId, Duration = 3})
    end
    return false
end

Tabs.sbcnm:Button({
    Title = "自然灾害",
    Callback = function()
        if naturalLoaded then
            if WindUI and WindUI.Notify then
                WindUI:Notify({Title = "重复点击！", Content = "", Duration = 3})
            end
            return
        end
        
        if not CheckServerId() then
            return
        end

        naturalLoaded = true

        local TabNatural = Window:Tab({
            Title = "自然灾害",
            Icon = "cloud",
            Locked = false,
        })

        TabNatural:Button({
            Title = "磁吸黑洞",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/finendss/FIN-function/refs/heads/main/Magnetic-black-hole"))()
            end
        })

        TabNatural:Button({
            Title = "黑洞v1",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/finendss/FIN-function/refs/heads/main/Black-hole-v1"))()
            end
        })

        TabNatural:Button({
            Title = "黑洞v2",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/finendss/FIN-function/refs/heads/main/Black-hole-v2"))()
            end
        })

        local partDestroyerEnabled = false
        local partDestroyerConnection
        local heartBeatConnection

        TabNatural:Toggle({
            Title = "崩飞零件",
            Callback = function(state)
                partDestroyerEnabled = state
                
                if partDestroyerEnabled then
                    WindUI:Notify({Title = "已开启零件崩飞", Content = "", Duration = 3})
                    
                    local function ForcePart(v)
                        if v:IsA("Part") and not v.Anchored and not v.Parent:FindFirstChild("Humanoid") and not v.Parent:FindFirstChild("Head") and v.Name ~= "Handle" then
                            for _, x in next, v:GetChildren() do
                                if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
                                    pcall(function() x:Destroy() end)
                                end
                            end
                            if v:FindFirstChild("Attachment") then
                                pcall(function() v:FindFirstChild("Attachment"):Destroy() end)
                            end
                            if v:FindFirstChild("AlignPosition") then
                                pcall(function() v:FindFirstChild("AlignPosition"):Destroy() end)
                            end
                            if v:FindFirstChild("Torque") then
                                pcall(function() v:FindFirstChild("Torque"):Destroy() end)
                            end
                            
                            pcall(function()
                                v.CanCollide = false
                                local randomForce = Instance.new("BodyVelocity", v)
                                randomForce.Velocity = Vector3.new(math.random(-100, 100), math.random(50, 100), math.random(-100, 100))
                                randomForce.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                                local randomTorque = Instance.new("BodyAngularVelocity", v)
                                randomTorque.AngularVelocity = Vector3.new(math.random(-20, 20), math.random(-20, 20), math.random(-20, 20))
                                randomTorque.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                                delay(5, function()
                                    if randomForce and randomForce.Parent then pcall(function() randomForce:Destroy() end) end
                                    if randomTorque and randomTorque.Parent then pcall(function() randomTorque:Destroy() end) end
                                end)
                            end)
                        end
                    end

                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("Part") and not obj.Anchored and not obj.Parent:FindFirstChild("Humanoid") and not obj.Parent:FindFirstChild("Head") and obj.Name ~= "Handle" then
                            ForcePart(obj)
                        end
                    end

                    partDestroyerConnection = workspace.DescendantAdded:Connect(function(descendant)
                        if partDestroyerEnabled and descendant:IsA("Part") and not descendant.Anchored and not descendant.Parent:FindFirstChild("Humanoid") and not descendant.Parent:FindFirstChild("Head") and descendant.Name ~= "Handle" then
                            wait(0.1)
                            ForcePart(descendant)
                        end
                    end)

                    heartBeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
                        if not partDestroyerEnabled then return end
                        if tick() % 0.5 < 0.05 then
                            for _, obj in pairs(workspace:GetDescendants()) do
                                if obj:IsA("Part") and not obj.Anchored and not obj.Parent:FindFirstChild("Humanoid") and not obj.Parent:FindFirstChild("Head") and obj.Name ~= "Handle" then
                                    local hasForce = false
                                    for _, child in pairs(obj:GetChildren()) do
                                        if child:IsA("BodyVelocity") or child:IsA("BodyAngularVelocity") then
                                            hasForce = true
                                            break
                                        end
                                    end
                                    if not hasForce then
                                        ForcePart(obj)
                                    end
                                end
                            end
                        end
                    end)
                else
                    WindUI:Notify({Title = "已关闭零件崩飞", Content = "", Duration = 3})
                    if partDestroyerConnection then partDestroyerConnection:Disconnect() end
                    if heartBeatConnection then heartBeatConnection:Disconnect() end
                end
            end
        })

        TabNatural:Toggle({
            Title = "自动胜出",
            Default = true,
            Callback = function(bool)
                _G.autowinfarm = bool
                while _G.autowinfarm do
                    wait(.1)
                    if _G.autowinfarm then
                        local char = game.Players.LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = CFrame.new(-236, 180, 360)
                        end
                    end
                end  
            end
        })

        local plr = game.Players.LocalPlayer
        local Message = Instance.new("ScreenGui")
        Message.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        local TextLabel = Instance.new("TextLabel", Message)
        TextLabel.Size = UDim2.new(0, 300, 0, 50)
        TextLabel.Position = UDim2.new(0.5, -150, 0, 10)
        TextLabel.BackgroundTransparency = 1
        TextLabel.TextColor3 = Color3.new(1, 1, 1)
        TextLabel.TextScaled = true
        TextLabel.Visible = false
        TextLabel.Text = ""

        TabNatural:Toggle({
            Title = "预测灾难",
            Default = true,
            Callback = function(val)
                _G.nextdis = val
                while wait(1) and _G.nextdis do
                    if plr and plr.Character then
                        local SurvivalTag = plr.Character:FindFirstChild("SurvivalTag")
                        if SurvivalTag then
                            local disasterName = SurvivalTag.Value
                            local text = ""
                            if disasterName == "Blizzard" then text = "暴风雪"
                            elseif disasterName == "Sandstorm" then text = "沙尘暴"
                            elseif disasterName == "Tornado" then text = "龙卷风"
                            elseif disasterName == "Volcanic Eruption" then text = "火山"
                            elseif disasterName == "Flash Flood" then text = "洪水"
                            elseif disasterName == "Deadly Virus" then text = "病毒"
                            elseif disasterName == "Tsunami" then text = "海啸"
                            elseif disasterName == "Acid Rain" then text = "酸雨"
                            elseif disasterName == "Fire" then text = "火焰"
                            elseif disasterName == "Meteor Shower" then text = "流星雨"
                            elseif disasterName == "Earthquake" then text = "地震"
                            elseif disasterName == "Thunder Storm" then text = "暴风雨"
                            end
                            if text ~= "" then
                                TextLabel.Visible = true
                                TextLabel.Text = "下一个灾难是：" .. text
                            else
                                TextLabel.Visible = false
                            end
                        else
                            TextLabel.Visible = false
                        end
                    end
                end
            end
        })

        TabNatural:Toggle({
            Title = "地图玩家投票界面",
            Default = true,
            Callback = function(bool)
                local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("MainGui")
                if gui then
                    local page = gui:FindFirstChild("MapVotePage")
                    if page then
                        page.Visible = bool
                    end
                end
            end
        })

        TabNatural:Toggle({
            Title = "水上行走",
            Default = true,
            Callback = function(bool)
                local water = game.Workspace:FindFirstChild("WaterLevel")
                if water then
                    if bool then
                        water.CanCollide = true
                        water.Size = Vector3.new(5000, 1, 5000)
                    else
                        water.CanCollide = false
                        water.Size = Vector3.new(10, 1, 10)
                    end
                end
            end
        })

        TabNatural:Toggle({
            Title = "游戏岛悬崖碰撞",
            Default = true,
            Callback = function(bool)
                for _, v in pairs(game.workspace:GetDescendants()) do
                    if v.Name == 'LowerRocks' then
                        v.CanCollide = bool
                    end
                end
            end
        })

        local antiFallDamageEnabled = false
        local antiFallThread = nil

        TabNatural:Toggle({
            Title = "禁用跌落伤害",
            Default = false,
            Callback = function(state)
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local RunService = game:GetService("RunService")
                local Players = game:GetService("Players")
                
                if state then
                    if not ReplicatedStorage:FindFirstChild("juisdfj0i32i0eidsuf0iok") then
                        local detection = Instance.new("Decal")
                        detection.Name = "juisdfj0i32i0eidsuf0iok"
                        detection.Parent = ReplicatedStorage
                    end
                    
                    antiFallDamageEnabled = true
                    
                    local function antiFallLoop()
                        local lp = Players.LocalPlayer
                        local c, hrp, vel, movel = nil, nil, nil, 0.1
                        while antiFallDamageEnabled do
                            RunService.Heartbeat:Wait()
                            c = lp.Character
                            hrp = c and c:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                vel = hrp.Velocity
                                hrp.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
                                RunService.RenderStepped:Wait()
                                hrp.Velocity = vel
                                RunService.Stepped:Wait()
                                hrp.Velocity = vel + Vector3.new(0, movel, 0)
                                movel = -movel
                            end
                        end
                    end
                    
                    antiFallThread = coroutine.create(antiFallLoop)
                    coroutine.resume(antiFallThread)
                    WindUI:Notify({Title = "已开启防坠落伤害", Content = "", Duration = 3})
                else
                    antiFallDamageEnabled = false
                    antiFallThread = nil
                    WindUI:Notify({Title = "已关闭防坠落伤害", Content = "", Duration = 3})
                end
            end
        })

        local TabNaturalTP = Window:Tab({
            Title = "传送",
            Icon = "navigation",
            Locked = false,
        })

        TabNaturalTP:Button({
            Title = "传送到地图",
            Callback = function()
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = CFrame.new(-115.828506, 65.4863434, 18.8461514)
                end
            end
        })

        TabNaturalTP:Button({
            Title = "传送到游戏岛",
            Callback = function()
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = CFrame.new(-83.5, 38.5, -27.5)
                end
            end
        })

        TabNaturalTP:Button({
            Title = "传送到产卵塔",
            Callback = function()
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = CFrame.new(-280, 170, 341)
                end
            end
        })

        if WindUI and WindUI.Notify then
            WindUI:Notify({Title = "自然灾害已加载", Content = "", Duration = 3})
        end
    end
})

Tabs.sbcnm:Section({
    Title = "DOORS", 
    TextXAlignment = "Left", 
    TextSize = 17
})

local doorsLoaded = false

local allowedServerIds = {
    "6839171747",
}

local function GetCurrentServerId()
    local success, id = pcall(function()
        return tostring(game.PlaceId)
    end)
    if success and id then
        return id
    end
    return nil
end

local function CheckServerId()
    local currentId = GetCurrentServerId()
    if not currentId then
        if WindUI and WindUI.Notify then
            WindUI:Notify({Title = "加载失败", Content = "无法获取ID", Duration = 3})
        end
        return false
    end
    
    for _, allowedId in ipairs(allowedServerIds) do
        if currentId == allowedId then
            return true
        end
    end
    
    if WindUI and WindUI.Notify then
        WindUI:Notify({Title = "服务器不符", Content = "当前ID: " .. currentId, Duration = 3})
    end
    return false
end

Tabs.sbcnm:Button({
    Title = "DOORS",
    Callback = function()
        if doorsLoaded then
            if WindUI and WindUI.Notify then
                WindUI:Notify({Title = "重复点击！", Content = "", Duration = 3})
            end
            return
        end
        
        if not CheckServerId() then
            return
        end

        doorsLoaded = true

        local LocalPlayer = game:GetService("Players").LocalPlayer
        
        if not LocalPlayer.Character then
            LocalPlayer.CharacterAdded:Wait()
        end
        task.wait(0.5)
        
        local success, err = pcall(function()
            local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/finendss/VowLibrary/refs/heads/main/Esp.lua"))()
            
            if not ESPLibrary then
                if WindUI and WindUI.Notify then
                    WindUI:Notify({Title = "ESP加载失败", Content = "请检查网络", Duration = 3})
                end
                return
            end
            
            ESPLibrary:SetRenderingSpeed(60)
            ESPLibrary:SetShowDistance(false)
            ESPLibrary:SetTracers(false)
            ESPLibrary:SetRainbow(false)
            ESPLibrary:SetESPMode("Highlight/Text")
            ESPLibrary:SetFont(Enum.Font.SourceSansBold)
            
            local PlayerFuncs = loadstring(game:HttpGet("https://raw.githubusercontent.com/finendss/VowLibrary/refs/heads/main/DOORSPlayFuncs.lua"))()
            
            if not PlayerFuncs then
                if WindUI and WindUI.Notify then
                    WindUI:Notify({Title = "加载失败", Content = "模块加载失败", Duration = 3})
                end
                return
            end
            
            if type(PlayerFuncs) == "function" then
                PlayerFuncs = PlayerFuncs()
            end
            
            DoorsPlayerFuncs = PlayerFuncs
            DoorsModuleLoaded = true
            
            local doorsTab = Window:Tab({Title = "DOORS玩家", Icon = "door"})
            
            doorsTab:Slider({
                Title = "移速",
                Value = {Min = 10, Max = 100, Default = 16},
                Increment = 1,
                Callback = function(v) 
                    pcall(function() 
                        if DoorsPlayerFuncs and DoorsPlayerFuncs.SetMovementSpeed then
                            DoorsPlayerFuncs.SetMovementSpeed(v)
                        end
                    end) 
                end
            })
            
            doorsTab:Slider({
                Title = "攀爬速度",
                Value = {Min = 10, Max = 100, Default = 16},
                Increment = 1,
                Callback = function(v) 
                    pcall(function() 
                        if DoorsPlayerFuncs and DoorsPlayerFuncs.SetClimbingSpeed then
                            DoorsPlayerFuncs.SetClimbingSpeed(v)
                        end
                    end) 
                end
            })
            
            doorsTab:Toggle({
                Title = "飞行",
                Default = false,
                Callback = function(v) 
                    pcall(function() 
                        if DoorsPlayerFuncs and DoorsPlayerFuncs.ToggleFlight then
                            DoorsPlayerFuncs.ToggleFlight(v)
                        end
                    end) 
                end
            })
            
            doorsTab:Slider({
                Title = "飞行速度",
                Value = {Min = 5, Max = 100, Default = 15},
                Increment = 1,
                Callback = function(v) 
                    pcall(function() 
                        if DoorsPlayerFuncs and DoorsPlayerFuncs.SetFlightSpeed then
                            DoorsPlayerFuncs.SetFlightSpeed(v)
                        end
                    end) 
                end
            })
            
            doorsTab:Toggle({
                Title = "无敌",
                Default = false,
                Callback = function(v) 
                    pcall(function() 
                        if DoorsPlayerFuncs and DoorsPlayerFuncs.ToggleGodmode then
                            DoorsPlayerFuncs.ToggleGodmode(v)
                        end
                    end) 
                end
            })
            
            doorsTab:Toggle({
                Title = "防滑",
                Default = false,
                Callback = function(v) 
                    pcall(function() 
                        if DoorsPlayerFuncs and DoorsPlayerFuncs.ToggleNoAcc then
                            DoorsPlayerFuncs.ToggleNoAcc(v)
                        end
                    end) 
                end
            })
            
            doorsTab:Toggle({
                Title = "启用跳跃",
                Default = false,
                Callback = function(v) 
                    pcall(function() 
                        if DoorsPlayerFuncs and DoorsPlayerFuncs.ToggleEnableJump then
                            DoorsPlayerFuncs.ToggleEnableJump(v)
                        end
                    end) 
                end
            })
            
            doorsTab:Toggle({
                Title = "快速躲藏点",
                Default = false,
                Callback = function(v) 
                    pcall(function() 
                        if DoorsPlayerFuncs and DoorsPlayerFuncs.ToggleFastClosetExit then
                            DoorsPlayerFuncs.ToggleFastClosetExit(v)
                        end
                    end) 
                end
            })
            
            doorsTab:Toggle({
                Title = "假复活",
                Default = false,
                Callback = function(v) 
                    pcall(function() 
                        if DoorsPlayerFuncs and DoorsPlayerFuncs.ToggleFakeRevive then
                            DoorsPlayerFuncs.ToggleFakeRevive(v)
                        end
                    end) 
                end
            })
            
            doorsTab:Button({
                Title = "重置速度",
                Callback = function()
                    pcall(function()
                        if DoorsPlayerFuncs and DoorsPlayerFuncs.ResetMovementSpeed then
                            DoorsPlayerFuncs.ResetMovementSpeed()
                        end
                        if WindUI and WindUI.Notify then
                            WindUI:Notify({Title = "已重置", Content = "", Duration = 2})
                        end
                    end)
                end
            })
            
            local BypassTab = Window:Tab({
                Title = "DOORS绕过",
                Icon = "ban",
                Locked = false,
            })
            
            local SpeedBypassModule = {}
            local BypassEnabledDoors = false
            local BypassMethodDoors = 1
            local CollisionCloneDoors = nil
            local bypassThread = nil
            local RemotesFolderDoors = nil
            
            local function InitSpeedBypass()
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                RemotesFolderDoors = ReplicatedStorage:FindFirstChild("EntityInfo") or 
                                ReplicatedStorage:FindFirstChild("Bricks") or 
                                ReplicatedStorage:FindFirstChild("RemotesFolder")
                
                if not RemotesFolderDoors then
                    return false
                end
                
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("CollisionPart") then
                    if CollisionCloneDoors and CollisionCloneDoors.Parent then
                        CollisionCloneDoors:Destroy()
                    end
                    CollisionCloneDoors = LocalPlayer.Character.CollisionPart:Clone()
                    CollisionCloneDoors.Parent = LocalPlayer.Character
                    CollisionCloneDoors.Name = "CollisionClone"
                    CollisionCloneDoors.RootPriority = 127
                    CollisionCloneDoors.Anchored = false
                    CollisionCloneDoors.CanCollide = false
                    local c = CollisionCloneDoors:FindFirstChild("CollisionCrouch")
                    if c then c:Destroy() end
                end
                
                return true
            end
            
            local function StartBypassLoop()
                if bypassThread then
                    task.cancel(bypassThread)
                    bypassThread = nil
                end
                
                bypassThread = task.spawn(function()
                    local Params = RaycastParams.new()
                    Params.FilterType = Enum.RaycastFilterType.Exclude
                    local Direction = Vector3.new(0, -100, 0)
                    
                    while true do
                        task.wait(BypassMethodDoors == 1 and 0 or 0.209)
                        
                        if not BypassEnabledDoors then
                            if CollisionCloneDoors and CollisionCloneDoors.Parent then
                                CollisionCloneDoors.Massless = false
                            end
                        else
                            pcall(function()
                                if BypassMethodDoors == 1 then
                                    if CollisionCloneDoors and CollisionCloneDoors.Parent then
                                        CollisionCloneDoors.Massless = true
                                    end
                                    local crouch = RemotesFolderDoors and RemotesFolderDoors:FindFirstChild("Crouch")
                                    if crouch then
                                        crouch:FireServer(true, true)
                                    end
                                elseif BypassMethodDoors == 2 then
                                    local char = LocalPlayer.Character
                                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                                    if LocalPlayer:GetAttribute("Alive") and hrp and CollisionCloneDoors and CollisionCloneDoors.Parent then
                                        Params.FilterDescendantsInstances = {char, CollisionCloneDoors}
                                        if not workspace:Raycast(hrp.Position, Direction, Params) then
                                            CollisionCloneDoors.Massless = true
                                        else
                                            CollisionCloneDoors.Massless = false
                                            task.wait(0.209)
                                            if LocalPlayer:GetAttribute("Alive") and CollisionCloneDoors and CollisionCloneDoors.Parent then
                                                CollisionCloneDoors.Massless = false
                                            end
                                        end
                                    end
                                end
                            end)
                        end
                    end
                end)
            end
            
            SpeedBypassModule.Enable = function(method)
                if not RemotesFolderDoors then
                    if not InitSpeedBypass() then return false end
                end
                BypassEnabledDoors = true
                if method then BypassMethodDoors = method end
                StartBypassLoop()
                return true
            end
            
            SpeedBypassModule.Disable = function()
                BypassEnabledDoors = false
                if CollisionCloneDoors and CollisionCloneDoors.Parent then
                    CollisionCloneDoors.Massless = false
                end
                if bypassThread then
                    task.cancel(bypassThread)
                    bypassThread = nil
                end
            end
            
            SpeedBypassModule.SetMethod = function(method)
                BypassMethodDoors = method
                if BypassEnabledDoors then
                    StartBypassLoop()
                end
            end
            
            SpeedBypassModule.IsEnabled = function()
                return BypassEnabledDoors
            end
            
            getgenv().SpeedBypass = SpeedBypassModule
            
            local bypassDropdownCreated = false
            local bypassDropdownRef = nil
            
            BypassTab:Toggle({
                Title = "速度绕过",
                Default = false,
                Callback = function(v)
                    if v then
                        if getgenv().SpeedBypass then
                            getgenv().SpeedBypass.Enable(1)
                            if not bypassDropdownCreated then
                                bypassDropdownRef = BypassTab:Dropdown({
                                    Title = "绕过模式",
                                    Values = {"模式1", "模式2"},
                                    Default = 1,
                                    Callback = function(val)
                                        if getgenv().SpeedBypass then
                                            getgenv().SpeedBypass.SetMethod(val == "模式1" and 1 or 2)
                                        end
                                    end
                                })
                                bypassDropdownCreated = true
                            end
                            if WindUI and WindUI.Notify then
                                WindUI:Notify({Title = "速度绕过已开启", Content = "", Duration = 2})
                            end
                        else
                            if WindUI and WindUI.Notify then
                                WindUI:Notify({Title = "错误", Content = "绕过模块未加载", Duration = 3})
                            end
                        end
                    else
                        if getgenv().SpeedBypass then
                            getgenv().SpeedBypass.Disable()
                            if WindUI and WindUI.Notify then
                                WindUI:Notify({Title = "速度绕过已关闭", Content = "", Duration = 2})
                            end
                        end
                    end
                end
            })
            
            BypassTab:Toggle({
                Title = "梯子绕过",
                Default = false,
                Callback = function(v) 
                    pcall(function() 
                        if DoorsPlayerFuncs and DoorsPlayerFuncs.ToggleLadderBypass then
                            DoorsPlayerFuncs.ToggleLadderBypass(v)
                        end
                    end) 
                end
            })
            
            local ESPTab = Window:Tab({
                Title = "DOORS ESP",
                Icon = "eye",
                Locked = false,
            })
            
            local ESPColors = {
                Door = Color3.new(0, 1, 1),
                HidingPlace = Color3.new(0, 0.8, 0.2),
                Lever = Color3.new(1, 0.5, 0),
                Book = Color3.new(0.2, 0.2, 1),
                Breaker = Color3.new(0.5, 1, 0.5),
                Items = Color3.new(1, 0.2, 0.8),
                Gold = Color3.new(1, 1, 0),
                Entity = Color3.new(1, 0, 0),
                Player = Color3.new(0.2, 0.8, 1),
                Ladder = Color3.new(1, 0.6, 0.2),
                Fuse = Color3.new(0.8, 0.3, 0.8),
            }
            
            local HidingPlaces = {
                ["Wardrobe"] = "衣柜",
                ["Rooms_Locker"] = "储物柜",
                ["Rooms_Locker_Fridge"] = "冰箱",
                ["Locker_Large"] = "储物柜",
                ["Backdoor_Wardrobe"] = "衣柜",
                ["Bed"] = "床",
                ["Double_Bed"] = "双人床",
                ["Toolshed"] = "工具棚",
                ["RetroWardrobe"] = "衣柜",
                ["CircularVent"] = "通风口",
            }
            
            local Items = {
                ["Bandage"] = "绷带",
                ["Flashlight"] = "手电筒",
                ["Battery"] = "电池",
                ["BatteryPack"] = "电池包",
                ["SkeletonKey"] = "骷髅钥匙",
                ["Crucifix"] = "十字架",
                ["Straplight"] = "肩带灯",
                ["Lockpick"] = "开锁器",
                ["Bulklight"] = "大灯",
                ["Vitamins"] = "维生素",
                ["Shears"] = "剪刀",
                ["LaserPointer"] = "激光笔",
                ["Candle"] = "蜡烛",
                ["Smoothie"] = "冰沙",
                ["StarJug"] = "水瓶",
                ["StardustPickup"] = "星尘",
                ["ChestBoxLocked"] = "上锁宝箱",
                ["ChestBox"] = "宝箱",
                ["Chest_Vine"] = "藤蔓宝箱",
                ["Toolbox_Locked"] = "上锁工具箱",
                ["Toolshed_Small"] = "工具棚",
                ["TimerLever"] = "拉杆",
                ["HolyGrenade"] = "圣手榴弹",
                ["ShieldMini"] = "小型护盾",
                ["ShieldBig"] = "大型护盾",
                ["CrucifixWall"] = "十字架",
                ["Glowsticks"] = "荧光棒",
                ["BandagePack"] = "绷带包",
                ["AlarmClock"] = "闹钟",
                ["MinesGenerator"] = "发电机",
                ["MinesGateButton"] = "门按钮",
                ["MouseHole"] = "老鼠洞",
                ["StarVial"] = "星瓶",
                ["StarBottle"] = "星瓶",
                ["Compass"] = "指南针",
                ["KeyIron"] = "铁钥匙",
                ["GoldGun"] = "金枪",
                ["Candy"] = "糖果",
                ["WaterPump"] = "水泵",
                ["VineGuillotine"] = "藤蔓闸刀",
                ["Shakelight"] = "摇摇灯",
                ["LibraryHintPaper"] = "提示纸",
                ["LotusPetalPickup"] = "莲花瓣",
            }
            
            local roomEntities = {
                ["Snare"] = "Snare",
                ["FigureRig"] = "Figure",
                ["FigureRagdoll"] = "Figure",
                ["GrumbleRig"] = "Grumble",
                ["Groundskeeper"] = "Ground Keeper",
                ["MandrakeLive"] = "Man Drake",
                ["LiveEntityBramble"] = "Bramble"
            }
            
            local workspaceEntities = {
                ["RushMoving"] = "Rush",
                ["AmbushMoving"] = "Ambush",
                ["A60"] = "A-60",
                ["A120"] = "A-120",
                ["GlitchRush"] = "Glitch Rush",
                ["GlitchAmbush"] = "Glitch Ambush",
                ["Eyes"] = "Eyes",
                ["Lookman"] = "Eyes",
                ["BackdoorRush"] = "Blitz",
                ["BackdoorLookman"] = "Lookman",
                ["JeffTheKiller"] = "Jeff"
            }
            
            local ESPToggles = {
                Door = false,
                HidingPlace = false,
                GateLever = false,
                Books = false,
                Breakers = false,
                Objective = false,
                Gold = false,
                Entity = false,
                Player = false,
                Ladder = false,
                Fuse = false,
            }
            
            local Closets = {}
            
            local function AddESP(part, txt, color)
                if not part or not part.Parent then return end
                ESPLibrary:AddESP({
                    Object = part,
                    Text = txt or "",
                    Color = color or Color3.new(1, 1, 1)
                })
            end
            
            local function RemoveESP(object)
                ESPLibrary:RemoveESP(object)
            end
            
            local function AddEntityESP(part, txt, color)
                if not part or not part.Parent then return end
                
                if part:IsA("Model") then
                    while not part.PrimaryPart do
                        for _, v in pairs(part:GetChildren()) do
                            if v:IsA("BasePart") then
                                part.PrimaryPart = v
                                break
                            end
                        end
                        task.wait()
                    end
                    if part.PrimaryPart then
                        part.PrimaryPart.Transparency = 0.99
                    end
                    if not part:FindFirstChildOfClass("Humanoid") then
                        local hum = Instance.new("Humanoid", part)
                        hum.Health = 100
                        hum.MaxHealth = 100
                        hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                    end
                end
                
                if part.Name == "FigureRig" or part.Name == "FigureRagdoll" then
                    local root = part:FindFirstChild("Root")
                    if root then
                        root.Size = Vector3.new(0.001, 0.001, 0.001)
                    end
                end
                
                ESPLibrary:AddESP({
                    Object = part,
                    Text = txt or "",
                    Color = color or Color3.new(1, 1, 1)
                })
            end
            
            local function ClearESP()
                local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
                if currentRoom and workspace.CurrentRooms then
                    local room1 = workspace.CurrentRooms:FindFirstChild(tostring(currentRoom))
                    local room2 = workspace.CurrentRooms:FindFirstChild(tostring(currentRoom + 1))
                    if room1 then
                        for _, v in pairs(room1:GetDescendants()) do
                            RemoveESP(v)
                        end
                    end
                    if room2 then
                        for _, v in pairs(room2:GetDescendants()) do
                            RemoveESP(v)
                        end
                    end
                end
                for _, v in pairs(workspace:GetChildren()) do
                    if workspaceEntities[v.Name] then
                        RemoveESP(v)
                    end
                end
            end
            
            local function RefreshESP()
                local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
                if not currentRoom then return end
                if not workspace.CurrentRooms then return end
                local room = workspace.CurrentRooms:FindFirstChild(tostring(currentRoom))
                if not room then return end
                
                if ESPToggles.Door then
                    local nextRoom = currentRoom + 1
                    local nextRoomObj = workspace.CurrentRooms:FindFirstChild(tostring(nextRoom))
                    if nextRoomObj then
                        local door1 = room:FindFirstChild("Door")
                        if door1 then
                            local doorPart = door1:FindFirstChild("Door")
                            if doorPart then                                AddESP(doorPart, "门 " .. tostring(doorPart.Parent:GetAttribute("RoomID") or ""), ESPColors.Door)
                                local cross = doorPart:FindFirstChild("CrossBoards")
                                if cross then AddESP(cross, "", ESPColors.Door) end
                            end
                        end
                        local door2 = nextRoomObj:FindFirstChild("Door")
                        if door2 then
                            local doorPart = door2:FindFirstChild("Door")
                            if doorPart then
                                AddESP(doorPart, "门 " .. tostring(doorPart.Parent:GetAttribute("RoomID") or ""), ESPColors.Door)
                                local cross = doorPart:FindFirstChild("CrossBoards")
                                if cross then AddESP(cross, "", ESPColors.Door) end
                            end
                        end
                    end
                end
                
                if ESPToggles.HidingPlace then
                    for _, v in pairs(Closets) do
                        if v and v.Parent and v:IsDescendantOf(room) then
                            local name = HidingPlaces[v.Name]
                            if name then
                                AddESP(v, name, ESPColors.HidingPlace)
                            end
                        end
                    end
                end
                
                if ESPToggles.GateLever then
                    local lever = room:FindFirstChild("LeverForGate", true)
                    if lever then
                        AddESP(lever, "拉杆", ESPColors.Lever)
                    end
                end
                
                if ESPToggles.Books then
                    for _, v in pairs(room:GetDescendants()) do
                        if v.Name == "LiveHintBook" then
                            AddESP(v, "书", ESPColors.Book)
                        end
                    end
                end
                
                if ESPToggles.Breakers then
                    for _, v in pairs(room:GetDescendants()) do
                        if v.Name == "LiveBreakerPolePickup" then
                            AddESP(v, "电闸", ESPColors.Breaker)
                        end
                    end
                end
                
                if ESPToggles.Objective then
                    for _, v in pairs(room:GetDescendants()) do
                        local itemName = Items[v.Name]
                        if itemName then
                            AddESP(v, itemName, ESPColors.Items)
                        end
                        if v.Name == "MinesAnchor" then
                            local sign = v:FindFirstChild("Sign")
                            if sign then
                                local text = sign:FindFirstChild("TextLabel")
                                AddESP(v, "锚点 " .. (text and text.Text or ""), ESPColors.Items)
                            end
                        end
                        if v.Name == "KeyObtain" then
                            repeat task.wait() until v.PrimaryPart
                            AddESP(v, "钥匙", Color3.new(0, 1, 1))
                        end
                        if v.Name == "ElectrialKeyObtain" then
                            AddESP(v, "电气间钥匙", Color3.new(0, 1, 1))
                        end
                    end
                end
                
                if ESPToggles.Gold then
                    for _, v in pairs(room:GetDescendants()) do
                        if v.Name == "GoldPile" then
                            AddESP(v, "金币 " .. tostring(v:GetAttribute("GoldValue") or ""), ESPColors.Gold)
                        end
                    end
                end
                
                if ESPToggles.Entity then
                    for _, v in pairs(room:GetDescendants()) do
                        local entityName = roomEntities[v.Name]
                        if entityName then
                            if v.Name == "Snare" then
                                local hitbox = v:FindFirstChild("Hitbox")
                                if hitbox then AddEntityESP(v, entityName, ESPColors.Entity) end
                            else
                                AddEntityESP(v, entityName, ESPColors.Entity)
                            end
                        elseif v.Name == "DoorFake" and v.Parent and v.Parent.Name == "SideroomDupe" then
                            local door = v:FindFirstChild("Door")
                            if door then AddEntityESP(door, "假门", ESPColors.Entity) end
                        elseif v.Name == "GiggleCeiling" then
                            task.spawn(function()
                                local t = 0
                                repeat 
                                    task.wait(0.1) 
                                    t = t + 0.1 
                                until t > 2 or v:FindFirstChild("Hitbox")
                                if v:FindFirstChild("Hitbox") then 
                                    AddEntityESP(v, "Giggle", ESPColors.Entity) 
                                end
                            end)
                        end
                    end
                    for _, v in pairs(workspace:GetChildren()) do
                        local entityName = workspaceEntities[v.Name]
                        if entityName then
                            AddEntityESP(v, entityName, ESPColors.Entity)
                        end
                    end
                end
                
                if ESPToggles.Ladder then
                    for _, v in pairs(room:GetDescendants()) do
                        if v.Name == "Ladder" then
                            AddESP(v, "梯子", ESPColors.Ladder)
                        end
                    end
                end
                
                if ESPToggles.Fuse then
                    for _, v in pairs(room:GetDescendants()) do
                        if v.Name == "FuseObtain" then
                            AddESP(v, "保险丝", ESPColors.Fuse)
                        end
                    end
                end
            end
            
            ESPTab:Toggle({
                Title = "显示门",
                Default = false,
                Callback = function(state)
                    ESPToggles.Door = state
                    if state then RefreshESP() else ClearESP() end
                end
            })
            
            ESPTab:Toggle({
                Title = "显示躲藏点",
                Default = false,
                Callback = function(state)
                    ESPToggles.HidingPlace = state
                    if state then RefreshESP() else ClearESP() end
                end
            })
            
            ESPTab:Toggle({
                Title = "显示拉杆",
                Default = false,
                Callback = function(state)
                    ESPToggles.GateLever = state
                    if state then RefreshESP() else ClearESP() end
                end
            })
            
            ESPTab:Toggle({
                Title = "显示书籍",
                Default = false,
                Callback = function(state)
                    ESPToggles.Books = state
                    if state then RefreshESP() else ClearESP() end
                end
            })
            
            ESPTab:Toggle({
                Title = "显示电闸",
                Default = false,
                Callback = function(state)
                    ESPToggles.Breakers = state
                    if state then RefreshESP() else ClearESP() end
                end
            })
            
            ESPTab:Toggle({
                Title = "显示物品",
                Default = false,
                Callback = function(state)
                    ESPToggles.Objective = state
                    if state then RefreshESP() else ClearESP() end
                end
            })
            
            ESPTab:Toggle({
                Title = "显示金币",
                Default = false,
                Callback = function(state)
                    ESPToggles.Gold = state
                    if state then RefreshESP() else ClearESP() end
                end
            })
            
            ESPTab:Toggle({
                Title = "显示实体",
                Default = false,
                Callback = function(state)
                    ESPToggles.Entity = state
                    if state then RefreshESP() else ClearESP() end
                end
            })
            
            ESPTab:Toggle({
                Title = "显示玩家",
                Default = false,
                Callback = function(state)
                    ESPToggles.Player = state
                    if not state then
                        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                            if v ~= LocalPlayer then
                                RemoveESP(v.Character)
                            end
                        end
                    end
                end
            })
            
            ESPTab:Toggle({
                Title = "显示梯子",
                Default = false,
                Callback = function(state)
                    ESPToggles.Ladder = state
                    if state then RefreshESP() else ClearESP() end
                end
            })
            
            ESPTab:Toggle({
                Title = "显示保险丝",
                Default = false,
                Callback = function(state)
                    ESPToggles.Fuse = state
                    if state then RefreshESP() else ClearESP() end
                end
            })
            
            task.spawn(function()
                while true do
                    task.wait(0.5)
                    if ESPToggles.Player then
                        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                            if v ~= LocalPlayer and v.Character then
                                local hum = v.Character:FindFirstChildOfClass("Humanoid")
                                if hum and hum.Health > 0 then
                                    AddESP(v.Character, v.Name .. " [" .. math.floor((hum.Health / hum.MaxHealth) * 100) .. "%]", ESPColors.Player)
                                else
                                    RemoveESP(v.Character)
                                end
                            end
                        end
                    end
                end
            end)
            
            LocalPlayer:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
                ClearESP()
                RefreshESP()
            end)
            
            workspace.DescendantAdded:Connect(function(v)
                if not doorsLoaded then return end
                
                if HidingPlaces[v.Name] then
                    table.insert(Closets, v)
                    if ESPToggles.HidingPlace and LocalPlayer:GetAttribute("CurrentRoom") then
                        local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
                        if workspace.CurrentRooms and workspace.CurrentRooms:FindFirstChild(tostring(currentRoom)) then
                            if v:IsDescendantOf(workspace.CurrentRooms[tostring(currentRoom)]) then
                                AddESP(v, HidingPlaces[v.Name], ESPColors.HidingPlace)
                            end
                        end
                    end
                end
                
                if ESPToggles.Objective and LocalPlayer:GetAttribute("CurrentRoom") then
                    local itemName = Items[v.Name]
                    if itemName then
                        local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
                        if workspace.CurrentRooms and workspace.CurrentRooms:FindFirstChild(tostring(currentRoom)) then
                            if v:IsDescendantOf(workspace.CurrentRooms[tostring(currentRoom)]) then
                                AddESP(v, itemName, ESPColors.Items)
                            end
                        end
                    end
                end
                
                if ESPToggles.Books and v.Name == "LiveHintBook" then
                    local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
                    if currentRoom and workspace.CurrentRooms and workspace.CurrentRooms:FindFirstChild(tostring(currentRoom)) then
                        if v:IsDescendantOf(workspace.CurrentRooms[tostring(currentRoom)]) then
                            AddESP(v, "书", ESPColors.Book)
                        end
                    end
                end
                
                if ESPToggles.Breakers and v.Name == "LiveBreakerPolePickup" then
                    local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
                    if currentRoom and workspace.CurrentRooms and workspace.CurrentRooms:FindFirstChild(tostring(currentRoom)) then
                        if v:IsDescendantOf(workspace.CurrentRooms[tostring(currentRoom)]) then
                            AddESP(v, "电闸", ESPColors.Breaker)
                        end
                    end
                end
                
                if ESPToggles.Gold and v.Name == "GoldPile" then
                    local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
                    if currentRoom and workspace.CurrentRooms and workspace.CurrentRooms:FindFirstChild(tostring(currentRoom)) then
                        if v:IsDescendantOf(workspace.CurrentRooms[tostring(currentRoom)]) then
                            AddESP(v, "金币 " .. tostring(v:GetAttribute("GoldValue") or ""), ESPColors.Gold)
                        end
                    end
                end
                
                if ESPToggles.Ladder and v.Name == "Ladder" then
                    local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
                    if currentRoom and workspace.CurrentRooms and workspace.CurrentRooms:FindFirstChild(tostring(currentRoom)) then
                        if v:IsDescendantOf(workspace.CurrentRooms[tostring(currentRoom)]) then
                            AddESP(v, "梯子", ESPColors.Ladder)
                        end
                    end
                end
                
                if ESPToggles.Fuse and v.Name == "FuseObtain" then
                    local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
                    if currentRoom and workspace.CurrentRooms and workspace.CurrentRooms:FindFirstChild(tostring(currentRoom)) then
                        if v:IsDescendantOf(workspace.CurrentRooms[tostring(currentRoom)]) then
                            AddESP(v, "保险丝", ESPColors.Fuse)
                        end
                    end
                end
            end)
            
            local AutoTab = Window:Tab({
                Title = "DOORS自动",
                Icon = "wand",
                Locked = false,
            })
            
            local killEnabled = false
            local killConnection = nil
            
            AutoTab:Toggle({
                Title = "刷旋钮",
                Default = false,
                Callback = function(state)
                    killEnabled = state
                    
                    if killConnection then
                        killConnection:Disconnect()
                        killConnection = nil
                    end
                    
                    if state then
                        killConnection = game:GetService("RunService").Heartbeat:Connect(function()
                            if not killEnabled then
                                killConnection:Disconnect()
                                killConnection = nil
                                return
                            end
                            
                            pcall(function()
                                local player = game.Players.LocalPlayer
                                local character = player.Character
                                local humanoid = character and character:FindFirstChild("Humanoid")
                                
                                if humanoid then
                                    humanoid.Health = 0
                                    game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):WaitForChild("Statistics"):FireServer()
                                end
                            end)
                        end)
                        WindUI:Notify({Title = "已开启刷旋钮", Content = "", Duration = 2})
                    else
                        WindUI:Notify({Title = "已关闭刷旋钮", Content = "", Duration = 2})
                    end
                end
            })
            
            local AutoInteractEnabled = false
            local InstantInteractEnabled = false
            local autoInteractConnection = nil
            local instantInteractConnection = nil
            
            local HidingPlacesForAuto = {
                ["Wardrobe"] = true,
                ["Backdoor_Wardrobe"] = true,
                ["Bed"] = true,
                ["Double_Bed"] = true,
                ["Toolshed"] = true,
                ["RetroWardrobe"] = true,
                ["CircularVent"] = true,
            }
            
            local function IsExcluded(obj)
                if not obj then return false end
                if HidingPlacesForAuto[obj.Name] then return true end
                local parent = obj.Parent
                if parent and HidingPlacesForAuto[parent.Name] then return true end
                local name = obj.Name:lower()
                if name:find("picture") or name:find("painting") or name:find("art") or name:find("frame") or name:find("canvas") or name:find("portrait") then
                    return true
                end
                if parent then
                    local pname = parent.Name:lower()
                    if pname:find("picture") or pname:find("painting") or pname:find("art") or pname:find("frame") or pname:find("canvas") or pname:find("portrait") then
                        return true
                    end
                end
                return false
            end
            
            AutoTab:Toggle({
                Title = "自动交互",
                Default = false,
                Callback = function(state)
                    AutoInteractEnabled = state
                    if state then
                        if autoInteractConnection then autoInteractConnection:Disconnect() end
                        autoInteractConnection = game:GetService("RunService").RenderStepped:Connect(function()
                            if not AutoInteractEnabled then return end
                            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
                            local hrp = LocalPlayer.Character.HumanoidRootPart
                            for _, v in pairs(workspace:GetDescendants()) do
                                if v:IsA("ProximityPrompt") and v.Enabled then
                                    local target = v.Parent
                                    if IsExcluded(target) then continue end
                                    local pos = target:IsA("BasePart") and target.Position or (target:IsA("Model") and target.PrimaryPart and target.PrimaryPart.Position)
                                    if pos and (hrp.Position - pos).Magnitude < 10 then
                                        pcall(function()
                                            fireproximityprompt(v)
                                        end)
                                    end
                                end
                            end
                        end)
                    else
                        if autoInteractConnection then
                            autoInteractConnection:Disconnect()
                            autoInteractConnection = nil
                        end
                    end
                end
            })
            
            AutoTab:Toggle({
                Title = "瞬间交互",
                Default = false,
                Callback = function(state)
                    InstantInteractEnabled = state
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("ProximityPrompt") then
                            local target = v.Parent
                            if IsExcluded(target) then continue end
                            if state then
                                if not v:GetAttribute("OldDuration") then
                                    v:SetAttribute("OldDuration", v.HoldDuration)
                                end
                                v.HoldDuration = 0
                            else
                                local old = v:GetAttribute("OldDuration")
                                if old then
                                    v.HoldDuration = old
                                    v:SetAttribute("OldDuration", nil)
                                end
                            end
                        end
                    end
                    if state then
                        if instantInteractConnection then instantInteractConnection:Disconnect() end
                        instantInteractConnection = workspace.DescendantAdded:Connect(function(v)
                            if InstantInteractEnabled and v:IsA("ProximityPrompt") then
                                local target = v.Parent
                                if IsExcluded(target) then return end
                                if not v:GetAttribute("OldDuration") then
                                    v:SetAttribute("OldDuration", v.HoldDuration)
                                end
                                v.HoldDuration = 0
                            end
                        end)
                    else
                        if instantInteractConnection then
                            instantInteractConnection:Disconnect()
                            instantInteractConnection = nil
                        end
                    end
                end
            })
            
            game:GetService("RunService").RenderStepped:Connect(function()
                if DoorsPlayerFuncs then
                    pcall(function() 
                        if DoorsPlayerFuncs.Process then
                            DoorsPlayerFuncs.Process() 
                        end
                    end)
                end
            end)
            
            local UserInputService = game:GetService("UserInputService")
            if UserInputService.KeyboardEnabled then
                local jumpCooldown = false
                UserInputService.JumpRequest:Connect(function()
                    if DoorsPlayerFuncs then
                        pcall(function()
                            if DoorsPlayerFuncs._InfiniteJumpEnabled and not jumpCooldown and LocalPlayer.Character then
                                jumpCooldown = true
                                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                                if humanoid then
                                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping, true)
                                end
                                task.wait(0.1)
                                jumpCooldown = false
                            end
                        end)
                    end
                end)
            end
            
            LocalPlayer.CharacterAdded:Connect(function(char)
                task.wait(0.5)
                if getgenv().SpeedBypass and getgenv().SpeedBypass.IsEnabled() then
                    pcall(function()
                        if char:FindFirstChild("CollisionPart") then
                            if CollisionCloneDoors and CollisionCloneDoors.Parent then
                                CollisionCloneDoors:Destroy()
                            end
                            CollisionCloneDoors = char.CollisionPart:Clone()
                            CollisionCloneDoors.Parent = char
                            CollisionCloneDoors.Name = "CollisionClone"
                            CollisionCloneDoors.RootPriority = 127
                            CollisionCloneDoors.Anchored = false
                            CollisionCloneDoors.CanCollide = false
                            local c = CollisionCloneDoors:FindFirstChild("CollisionCrouch")
                            if c then c:Destroy() end
                        end
                    end)
                end
            end)
        end)
        
        if not success then
            if WindUI and WindUI.Notify then
                WindUI:Notify({Title = "加载失败", Content = tostring(err):sub(1, 50), Duration = 3})
            end
        end

        if WindUI and WindUI.Notify then
            WindUI:Notify({Title = "DOORS已加载", Content = "", Duration = 3})
        end
    end
})

Tabs.sbcnm:Section({
    Title = "踢一个幸运方块", 
    TextXAlignment = "Left", 
    TextSize = 17
})

local luckyLoaded = false

local allowedServerIds = {
    "89469502395769",
}

local function GetCurrentServerId()
    local success, id = pcall(function()
        return tostring(game.PlaceId)
    end)
    if success and id then
        return id
    end
    return nil
end

local function CheckServerId()
    local currentId = GetCurrentServerId()
    if not currentId then
        if WindUI and WindUI.Notify then
            WindUI:Notify({Title = "加载失败", Content = "无法获取ID", Duration = 3})
        end
        return false
    end
    
    for _, allowedId in ipairs(allowedServerIds) do
        if currentId == allowedId then
            return true
        end
    end
    
    if WindUI and WindUI.Notify then
        WindUI:Notify({Title = "服务器不符", Content = "当前ID: " .. currentId, Duration = 3})
    end
    return false
end

Tabs.sbcnm:Button({
    Title = "踢一个幸运方块",
    Callback = function()
        if luckyLoaded then
            if WindUI and WindUI.Notify then
                WindUI:Notify({Title = "重复点击！", Content = "", Duration = 3})
            end
            return
        end
        
        if not CheckServerId() then
            return
        end

        luckyLoaded = true

        local TabLucky = Window:Tab({
            Title = "幸运方块",
            Icon = "swords",
            Locked = false,
        })

        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local collectEvent = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network"):WaitForChild("rev_B_Collect")

        local autoCollectEnabled = false

        task.spawn(function()
            while true do
                if autoCollectEnabled then
                    for i = 1, 10 do
                        collectEvent:FireServer(unpack({i}))
                        task.wait(0.5)
                    end
                end
                task.wait(10)
            end
        end)

        TabLucky:Toggle({
            Title = "自动领取金钱",
            Default = false,
            Callback = function(state)
                autoCollectEnabled = state
            end
        })

        local speedEvent = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network"):WaitForChild("rev_SPEED_UPGRADE")

        TabLucky:Toggle({
            Title = "自动购买速度",
            Default = false,
            Callback = function(state)
                if state then
                    task.spawn(function()
                        while state do
                            for i = 1, 9 do
                                speedEvent:FireServer(unpack({i}))
                                task.wait(0.3)
                            end
                        end
                    end)
                end
            end
        })

        local buyEvent = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network"):WaitForChild("rev_Shop_Buy")

        local items = {
            "Bone Barbell",
            "Stone",
            "Copper Plate",
            "Iron Plate",
            "Ice Barbell",
            "Donut Barbell",
            "Heaven Plate",
            "Giant Gold Barbell",
            "Neon Barbell",
            "Giant Gold Star Barbell",
            "Jade Barbell",
            "Planet Barbell",
            "Giant Jupiter"
        }

        TabLucky:Toggle({
            Title = "自动购买杠铃",
            Default = false,
            Callback = function(state)
                if state then
                    task.spawn(function()
                        while state do
                            for _, item in ipairs(items) do
                                buyEvent:FireServer(unpack({"WeightShop", item}))
                                task.wait(0.5)
                            end
                        end
                    end)
                end
            end
        })

        local KickController = require(ReplicatedStorage.Modules.ControllerLoader.KickController)
        local kickEvent = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network"):WaitForChild("rev_KickEvent")
        local RunService = game:GetService("RunService")

        local connection = nil
        local lastKick = 0

        TabLucky:Toggle({
            Title = "自动Perfect踢球",
            Default = false,
            Callback = function(state)
                if state then
                    connection = RunService.PreRender:Connect(function()
                        if KickController.Scale >= 0.97 and KickController.InMinigame and os.clock() - lastKick > 0.5 then
                            lastKick = os.clock()
                            kickEvent:FireServer(1, 1)
                        end
                    end)
                else
                    if connection then
                        connection:Disconnect()
                        connection = nil
                    end
                end
            end
        })

        local player = game:GetService("Players").LocalPlayer
        local kickPos = Vector3.new(705.68, 3.11, 206.85)

        TabLucky:Button({
            Title = "传送到踢球位置",
            Callback = function()
                player.Character.HumanoidRootPart.CFrame = CFrame.new(kickPos)
            end
        })

        local Players = game:GetService("Players")
        local SoundService = game:GetService("SoundService")

        local player2 = Players.LocalPlayer
        local character = player2.Character or player2.CharacterAdded:Wait()

        local humanoid = character:WaitForChild("Humanoid", 5)
        local hrp = character:WaitForChild("HumanoidRootPart", 5)

        local tsunamiMusic = SoundService:WaitForChild("TsunamiMusic", 10)
        if not tsunamiMusic then return end

        local function getKickReady()
            local areas = workspace:FindFirstChild("Areas")
            if areas and areas:FindFirstChild("KickReady") then
                return areas.KickReady
            end
            return workspace:FindFirstChild("KickReady", true)
        end

        local connection2 = nil

        TabLucky:Toggle({
            Title = "自动躲避海啸",
            Default = false,
            Callback = function(state)
                if state then
                    connection2 = tsunamiMusic.Played:Connect(function()
                        if not hrp or not humanoid then return end

                        local kickReady = getKickReady()
                        if not kickReady then return end

                        hrp.CFrame += Vector3.new(0, 120, 0)
                        task.wait(0.3)

                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        hrp.Anchored = false

                        local startPos = hrp.Position
                        local goalPos = kickReady.Position + Vector3.new(0, 5, 0)

                        local direction = (Vector3.new(goalPos.X, startPos.Y, goalPos.Z) - startPos).Unit
                        local distance = (Vector3.new(goalPos.X, 0, goalPos.Z) - Vector3.new(startPos.X, 0, startPos.Z)).Magnitude

                        local speed = 60
                        local duration = distance / speed

                        local elapsed = 0
                        local conn3

                        conn3 = RunService.Heartbeat:Connect(function(dt)
                            if not hrp or not humanoid or humanoid.Health <= 0 then
                                conn3:Disconnect()
                                return
                            end

                            elapsed += dt
                            local alpha = math.clamp(elapsed / duration, 0, 1)

                            hrp.Velocity = direction * speed
                            humanoid.Jump = true

                            if alpha >= 1 then
                                conn3:Disconnect()
                                humanoid.Jump = false
                                hrp.Velocity = Vector3.new(0, -15, 0)

                                task.delay(0.5, function()
                                    if hrp and humanoid then
                                        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                                        hrp.Velocity = Vector3.zero
                                    end
                                end)
                            end
                        end)
                    end)
                else
                    if connection2 then
                        connection2:Disconnect()
                        connection2 = nil
                    end
                end
            end
        })

        if WindUI and WindUI.Notify then
            WindUI:Notify({Title = "幸运方块已加载", Content = "", Duration = 3})
        end
    end
})

Tabs.sbcnm:Section({
    Title = "行动一", 
    TextXAlignment = "Left", 
    TextSize = 17
})

local actionLoaded = false

local allowedServerIds = {
    "72920620366355",
}

local function GetCurrentServerId()
    local success, id = pcall(function()
        return tostring(game.PlaceId)
    end)
    if success and id then
        return id
    end
    return nil
end

local function CheckServerId()
    local currentId = GetCurrentServerId()
    if not currentId then
        if WindUI and WindUI.Notify then
            WindUI:Notify({Title = "加载失败", Content = "无法获取ID", Duration = 3})
        end
        return false
    end
    
    for _, allowedId in ipairs(allowedServerIds) do
        if currentId == allowedId then
            return true
        end
    end
    
    if WindUI and WindUI.Notify then
        WindUI:Notify({Title = "服务器不符", Content = "当前ID: " .. currentId, Duration = 3})
    end
    return false
end

Tabs.sbcnm:Button({
    Title = "行动一",
    Callback = function()
        if actionLoaded then
            if WindUI and WindUI.Notify then
                WindUI:Notify({Title = "重复点击！", Content = "", Duration = 3})
            end
            return
        end
        
        if not CheckServerId() then
            return
        end

        actionLoaded = true

        local actionOnePlayers = game:GetService("Players")
        local actionOneRunService = game:GetService("RunService")
        local actionOneWorkspace = game:GetService("Workspace")
        local actionOneLocalPlayer = actionOnePlayers.LocalPlayer

        local actionOneSettings = {
            ESPEnabled = false,
            TeamCheck = true,
            BoxESP = false,
            NameESP = false,
            HealthESP = false,
            DistanceESP = false,
            LineESP = false,
            RadarEnabled = false,
            RadarRadius = 150,
            AimAssistEnabled = false,
            AimFOV = 15,
            AimSmoothness = 7,
            AimTarget = "Head",
            FOVCircleEnabled = false,
        }

        local espContainer = nil
        local espObjects = {}
        local espConnections = {}

        local function getESPContainer()
            if not espContainer or not espContainer.Parent then
                espContainer = Instance.new("ScreenGui")
                espContainer.Name = "ESP_Container"
                espContainer.ResetOnSpawn = false
                espContainer.Parent = game:GetService("CoreGui")
            end
            return espContainer
        end

        local function removeESPObject(player)
            local obj = espObjects[player]
            if not obj then return end
            
            pcall(function()
                if obj.Box then
                    obj.Box.Adornee = nil
                    obj.Box.Visible = false
                    obj.Box:Destroy()
                end
            end)
            pcall(function()
                if obj.NameLabel then
                    obj.NameLabel.Adornee = nil
                    obj.NameLabel.Enabled = false
                    obj.NameLabel:Destroy()
                end
            end)
            pcall(function()
                if obj.HealthBg then
                    obj.HealthBg:Destroy()
                end
            end)
            pcall(function()
                if obj.HealthBar then
                    obj.HealthBar:Destroy()
                end
            end)
            pcall(function()
                if obj.DistLabel then
                    obj.DistLabel:Destroy()
                end
            end)
            pcall(function()
                if obj.Line then
                    obj.Line:Destroy()
                end
            end)
            
            espObjects[player] = nil
        end

        local function isValidTarget(player)
            if not player or not player.Parent then return false end
            if player == actionOneLocalPlayer then return false end
            
            local character = player.Character
            if not character then return false end
            
            local hrp = character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if not hrp or not humanoid or humanoid.Health <= 0 then return false end
            
            if actionOneSettings.TeamCheck and player.Team == actionOneLocalPlayer.Team then
                return false
            end
            
            return true
        end

        local function createESPObject(player)
            if espObjects[player] then
                removeESPObject(player)
            end
            
            if not isValidTarget(player) then return end
            
            local character = player.Character
            local hrp = character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            
            local container = getESPContainer()
            local object = {}
            object.Player = player
            
            object.Box = Instance.new("BoxHandleAdornment")
            object.Box.Name = "ESPBox_" .. player.UserId
            object.Box.AlwaysOnTop = true
            object.Box.Size = Vector3.new(4, 6, 1)
            object.Box.Transparency = 0.5
            object.Box.Color3 = Color3.fromRGB(255, 0, 0)
            object.Box.ZIndex = 0
            object.Box.Adornee = hrp
            object.Box.Visible = actionOneSettings.BoxESP
            object.Box.Parent = container
            
            object.NameLabel = Instance.new("BillboardGui")
            object.NameLabel.Name = "ESPName_" .. player.UserId
            object.NameLabel.AlwaysOnTop = true
            object.NameLabel.Size = UDim2.new(0, 200, 0, 50)
            object.NameLabel.StudsOffset = Vector3.new(0, 3, 0)
            object.NameLabel.Adornee = hrp
            object.NameLabel.Enabled = actionOneSettings.NameESP
            
            local nameFrame = Instance.new("Frame", object.NameLabel)
            nameFrame.BackgroundTransparency = 1
            nameFrame.Size = UDim2.new(1, 0, 1, 0)
            
            object.NameText = Instance.new("TextLabel", nameFrame)
            object.NameText.BackgroundTransparency = 1
            object.NameText.Size = UDim2.new(1, 0, 1, 0)
            object.NameText.Text = player.DisplayName or player.Name
            object.NameText.TextColor3 = Color3.fromRGB(255, 0, 0)
            object.NameText.TextSize = 14
            object.NameText.Font = Enum.Font.SourceSansBold
            object.NameLabel.Parent = container
            
            object.HealthBg = Instance.new("Frame")
            object.HealthBg.Name = "ESPHealthBg_" .. player.UserId
            object.HealthBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            object.HealthBg.BorderSizePixel = 0
            object.HealthBg.BackgroundTransparency = 0.5
            object.HealthBg.Size = UDim2.new(0, 3, 0, 40)
            object.HealthBg.Parent = container
            object.HealthBg.Visible = actionOneSettings.HealthESP
            
            object.HealthBar = Instance.new("Frame")
            object.HealthBar.Name = "ESPHealth_" .. player.UserId
            object.HealthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            object.HealthBar.BorderSizePixel = 0
            object.HealthBar.Size = UDim2.new(0, 3, 0, 40)
            object.HealthBar.Parent = container
            object.HealthBar.Visible = actionOneSettings.HealthESP
            
            object.DistLabel = Instance.new("TextLabel")
            object.DistLabel.Name = "ESPDist_" .. player.UserId
            object.DistLabel.BackgroundTransparency = 1
            object.DistLabel.Text = ""
            object.DistLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            object.DistLabel.TextSize = 12
            object.DistLabel.Font = Enum.Font.SourceSans
            object.DistLabel.Parent = container
            object.DistLabel.Visible = actionOneSettings.DistanceESP
            
            espObjects[player] = object
            return object
        end

        local function updateESPObject(object)
            if not object or not object.Player then return end
            local player = object.Player
            
            if not isValidTarget(player) then
                removeESPObject(player)
                return
            end
            
            local character = player.Character
            local hrp = character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            
            if object.Box.Adornee ~= hrp then
                object.Box.Adornee = hrp
                object.NameLabel.Adornee = hrp
            end
            
            local camera = actionOneWorkspace.CurrentCamera
            if not camera then return end
            
            local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position)
            local teamColor = Color3.fromRGB(255, 0, 0)
            
            object.Box.Visible = actionOneSettings.BoxESP
            object.Box.Color3 = teamColor
            
            object.NameLabel.Enabled = actionOneSettings.NameESP
            if actionOneSettings.NameESP then
                object.NameText.Text = player.DisplayName or player.Name
                object.NameText.TextColor3 = teamColor
            end
            
            local show2DElements = onScreen and actionOneSettings.ESPEnabled
            local healthPercent = humanoid.Health / humanoid.MaxHealth
            
            if actionOneSettings.HealthESP and show2DElements then
                local boxHeight = 40
                local barHeight = boxHeight * healthPercent
                
                object.HealthBg.Visible = true
                object.HealthBg.Size = UDim2.new(0, 3, 0, boxHeight)
                object.HealthBg.Position = UDim2.new(0, screenPos.X - 8, 0, screenPos.Y - boxHeight / 2)
                
                object.HealthBar.Visible = true
                object.HealthBar.Size = UDim2.new(0, 3, 0, barHeight)
                object.HealthBar.Position = UDim2.new(0, screenPos.X - 8, 0, screenPos.Y + boxHeight / 2 - barHeight)
                object.HealthBar.BackgroundColor3 = Color3.fromRGB(255 * (1 - healthPercent), 255 * healthPercent, 0)
            else
                object.HealthBg.Visible = false
                object.HealthBar.Visible = false
            end
            
            if actionOneSettings.DistanceESP and show2DElements then
                local localChar = actionOneLocalPlayer.Character
                if localChar then
                    local localHrp = localChar:FindFirstChild("HumanoidRootPart")
                    if localHrp then
                        local dist = (hrp.Position - localHrp.Position).Magnitude
                        object.DistLabel.Visible = true
                        object.DistLabel.Position = UDim2.new(0, screenPos.X - 100, 0, screenPos.Y + 25)
                        object.DistLabel.Size = UDim2.new(0, 200, 0, 20)
                        object.DistLabel.Text = string.format("%.0fm", dist)
                        object.DistLabel.TextColor3 = teamColor
                    else
                        object.DistLabel.Visible = false
                    end
                else
                    object.DistLabel.Visible = false
                end
            else
                object.DistLabel.Visible = false
            end
            
            if actionOneSettings.LineESP and onScreen then
                if not object.Line then
                    object.Line = Instance.new("Frame")
                    object.Line.Name = "ESPLine_" .. player.UserId
                    object.Line.BorderSizePixel = 0
                    object.Line.Parent = getESPContainer()
                end
                object.Line.Visible = true
                local viewportSize = camera.ViewportSize
                local centerX = viewportSize.X / 2
                local bottomY = viewportSize.Y
                local deltaX = screenPos.X - centerX
                local deltaY = bottomY - screenPos.Y
                local length = math.sqrt(deltaX * deltaX + deltaY * deltaY)
                local angle = math.atan2(deltaY, deltaX)
                object.Line.Position = UDim2.new(0, centerX, 0, bottomY)
                object.Line.Size = UDim2.new(0, length, 0, 1)
                object.Line.Rotation = math.deg(-angle)
                object.Line.BackgroundColor3 = teamColor
            else
                if object.Line then
                    object.Line.Visible = false
                end
            end
        end

        local function startESP()
            getESPContainer()
            
            for _, player in ipairs(actionOnePlayers:GetPlayers()) do
                if player ~= actionOneLocalPlayer then
                    createESPObject(player)
                end
            end
            
            local conn1 = actionOnePlayers.PlayerAdded:Connect(function(player)
                if player == actionOneLocalPlayer then return end
                task.wait(0.5)
                if actionOneSettings.ESPEnabled then
                    createESPObject(player)
                end
            end)
            table.insert(espConnections, conn1)
            
            local conn2 = actionOnePlayers.PlayerRemoving:Connect(function(player)
                removeESPObject(player)
            end)
            table.insert(espConnections, conn2)
            
            local conn3 = actionOneRunService.RenderStepped:Connect(function()
                if not actionOneSettings.ESPEnabled then return end
                
                for player, object in pairs(espObjects) do
                    if player and player.Parent then
                        updateESPObject(object)
                    else
                        removeESPObject(player)
                    end
                end
            end)
            table.insert(espConnections, conn3)
        end

        local function stopESP()
            for _, conn in ipairs(espConnections) do
                pcall(function() conn:Disconnect() end)
            end
            espConnections = {}
            
            for player, _ in pairs(espObjects) do
                removeESPObject(player)
            end
            espObjects = {}
            
            if espContainer then
                pcall(function() espContainer:Destroy() end)
                espContainer = nil
            end
        end

        local radarGui = nil
        local radarFrame = nil
        local radarObjects = {}
        local radarConnection = nil

        local function startRadar()
            if radarGui then return end
            
            radarGui = Instance.new("ScreenGui")
            radarGui.Name = "ActionOneRadar"
            radarGui.ResetOnSpawn = false
            radarGui.Parent = game:GetService("CoreGui")
            
            radarFrame = Instance.new("Frame", radarGui)
            radarFrame.Name = "RadarFrame"
            radarFrame.Size = UDim2.new(0, 200, 0, 200)
            radarFrame.Position = UDim2.new(0, 40, 0, 20)
            radarFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            radarFrame.BackgroundTransparency = 0.6
            radarFrame.BorderSizePixel = 1
            radarFrame.BorderColor3 = Color3.new(1, 1, 1)
            radarFrame.ClipsDescendants = true
            
            local corner = Instance.new("UICorner", radarFrame)
            corner.CornerRadius = UDim.new(1, 0)
            
            local centerDot = Instance.new("Frame", radarFrame)
            centerDot.Size = UDim2.new(0, 10, 0, 10)
            centerDot.Position = UDim2.new(0.5, -5, 0.5, -5)
            centerDot.BackgroundColor3 = Color3.new(0, 1, 0)
            centerDot.BorderSizePixel = 0
            centerDot.ZIndex = 2
            
            radarConnection = actionOneRunService.RenderStepped:Connect(function()
                if not actionOneSettings.RadarEnabled then return end
                
                local char = actionOneLocalPlayer.Character
                if not char then return end
                local rootPart = char:FindFirstChild("HumanoidRootPart")
                if not rootPart then return end
                
                local activePlayers = {}
                
                for _, player in ipairs(actionOnePlayers:GetPlayers()) do
                    if player ~= actionOneLocalPlayer then
                        activePlayers[player] = true
                        
                        local showOnRadar = true
                        if actionOneSettings.TeamCheck and player.Team == actionOneLocalPlayer.Team then
                            showOnRadar = false
                        end
                        
                        if not showOnRadar or not player.Character then
                            if radarObjects[player] then
                                radarObjects[player]:Destroy()
                                radarObjects[player] = nil
                            end
                            continue
                        end
                        
                        local targetChar = player.Character
                        local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
                        local humanoid = targetChar:FindFirstChildOfClass("Humanoid")
                        
                        if not targetRoot or not humanoid or humanoid.Health <= 0 then
                            if radarObjects[player] then
                                radarObjects[player]:Destroy()
                                radarObjects[player] = nil
                            end
                            continue
                        end
                        
                        local relativePos = targetRoot.Position - rootPart.Position
                        local distance = relativePos.Magnitude
                        
                        if distance <= actionOneSettings.RadarRadius then
                            local screenPos = Vector2.new(relativePos.X, relativePos.Z) * 100 / actionOneSettings.RadarRadius
                            if screenPos.Magnitude > 100 then
                                screenPos = screenPos.Unit * 100
                            end
                            
                            if not radarObjects[player] then
                                local dot = Instance.new("Frame", radarFrame)
                                dot.Name = "EnemyDot_" .. player.UserId
                                dot.Size = UDim2.new(0, 8, 0, 8)
                                dot.AnchorPoint = Vector2.new(0.5, 0.5)
                                dot.BorderSizePixel = 0
                                dot.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                                dot.ZIndex = 2
                                radarObjects[player] = dot
                            end
                            
                            radarObjects[player].Position = UDim2.new(0.5, screenPos.X, 0.5, screenPos.Y)
                        else
                            if radarObjects[player] then
                                radarObjects[player]:Destroy()
                                radarObjects[player] = nil
                            end
                        end
                    end
                end
                
                for player, dot in pairs(radarObjects) do
                    if not activePlayers[player] then
                        dot:Destroy()
                        radarObjects[player] = nil
                    end
                end
            end)
        end

        local function stopRadar()
            if radarConnection then
                pcall(function() radarConnection:Disconnect() end)
                radarConnection = nil
            end
            if radarGui then
                pcall(function() radarGui:Destroy() end)
                radarGui = nil
            end
            for _, dot in pairs(radarObjects) do
                pcall(function() dot:Destroy() end)
            end
            radarObjects = {}
        end

        local fovCircleGui = nil
        local fovCircle = nil
        local aimConnection = nil

        local function createFOVCircle()
            if fovCircleGui then return end
            
            fovCircleGui = Instance.new("ScreenGui")
            fovCircleGui.Name = "FOVCircle"
            fovCircleGui.ResetOnSpawn = false
            fovCircleGui.Parent = game:GetService("CoreGui")
            
            fovCircle = Instance.new("Frame", fovCircleGui)
            fovCircle.BackgroundTransparency = 1
            fovCircle.BorderSizePixel = 2
            fovCircle.BorderColor3 = Color3.fromRGB(255, 255, 255)
            fovCircle.AnchorPoint = Vector2.new(0.5, 0.5)
            fovCircle.Visible = false
            fovCircle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            
            local corner = Instance.new("UICorner", fovCircle)
            corner.CornerRadius = UDim.new(1, 0)
        end

        local function updateFOVCircle()
            if not fovCircle then return end
            
            if actionOneSettings.FOVCircleEnabled and actionOneSettings.AimAssistEnabled then
                local camera = actionOneWorkspace.CurrentCamera
                if not camera then return end
                
                local viewportSize = camera.ViewportSize
                local radius = actionOneSettings.AimFOV * 8
                
                fovCircle.Visible = true
                fovCircle.Size = UDim2.new(0, radius * 2, 0, radius * 2)
                fovCircle.Position = UDim2.new(0, viewportSize.X / 2, 0, viewportSize.Y / 2)
            else
                fovCircle.Visible = false
            end
        end

        local function getClosestPlayer()
            local char = actionOneLocalPlayer.Character
            if not char then return nil end
            local rootPart = char:FindFirstChild("HumanoidRootPart")
            if not rootPart then return nil end
            
            local camera = actionOneWorkspace.CurrentCamera
            if not camera then return nil end
            
            local viewportSize = camera.ViewportSize
            local screenCenter = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
            local fovRadius = actionOneSettings.AimFOV * 8
            
            local closestDist = math.huge
            local closestPlayer = nil
            
            for _, player in ipairs(actionOnePlayers:GetPlayers()) do
                if player ~= actionOneLocalPlayer then
                    if actionOneSettings.TeamCheck and player.Team == actionOneLocalPlayer.Team then
                        continue
                    end
                    
                    local character = player.Character
                    if not character then continue end
                    
                    local targetPart = character:FindFirstChild(actionOneSettings.AimTarget)
                    if not targetPart then
                        targetPart = character:FindFirstChild("Head")
                    end
                    if not targetPart then
                        targetPart = character:FindFirstChild("HumanoidRootPart")
                    end
                    if not targetPart then continue end
                    
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if not humanoid or humanoid.Health <= 0 then continue end
                    
                    local screenPos, onScreen = camera:WorldToViewportPoint(targetPart.Position)
                    if not onScreen then continue end
                    
                    local screenPoint = Vector2.new(screenPos.X, screenPos.Y)
                    local distToCenter = (screenPoint - screenCenter).Magnitude
                    
                    if distToCenter < fovRadius then
                        local dist = (rootPart.Position - targetPart.Position).Magnitude
                        if dist < closestDist then
                            closestDist = dist
                            closestPlayer = player
                        end
                    end
                end
            end
            
            return closestPlayer
        end

        local function startAim()
            if aimConnection then return end
            createFOVCircle()
            
            aimConnection = actionOneRunService.RenderStepped:Connect(function()
                if not actionOneSettings.AimAssistEnabled then
                    if fovCircle then fovCircle.Visible = false end
                    return
                end
                
                updateFOVCircle()
                
                local camera = actionOneWorkspace.CurrentCamera
                if not camera then return end
                
                local targetPlayer = getClosestPlayer()
                if not targetPlayer then return end
                
                local character = targetPlayer.Character
                if not character then return end
                
                local targetPart = character:FindFirstChild(actionOneSettings.AimTarget)
                if not targetPart then
                    targetPart = character:FindFirstChild("Head")
                end
                if not targetPart then
                    targetPart = character:FindFirstChild("HumanoidRootPart")
                end
                if not targetPart then return end
                
                local targetPos = targetPart.Position
                local direction = (targetPos - camera.CFrame.Position).Unit
                local targetCFrame = CFrame.lookAt(camera.CFrame.Position, camera.CFrame.Position + direction)
                
                local smoothness = math.clamp(actionOneSettings.AimSmoothness / 10, 0.1, 1)
                camera.CFrame = camera.CFrame:Lerp(targetCFrame, smoothness)
            end)
        end

        local function stopAim()
            if aimConnection then
                pcall(function() aimConnection:Disconnect() end)
                aimConnection = nil
            end
            if fovCircleGui then
                pcall(function() fovCircleGui:Destroy() end)
                fovCircleGui = nil
                fovCircle = nil
            end
        end

        local TabActionESP = Window:Tab({
            Title = "行动ESP",
            Icon = "target"
        })

        TabActionESP:Toggle({
            Title = "启用 ESP",
            Default = false,
            Callback = function(state)
                actionOneSettings.ESPEnabled = state
                if state then
                    startESP()
                else
                    stopESP()
                end
            end
        })

        TabActionESP:Toggle({
            Title = "队伍检查",
            Default = true,
            Callback = function(state)
                actionOneSettings.TeamCheck = state
            end
        })

        TabActionESP:Toggle({
            Title = "显示方框",
            Default = false,
            Callback = function(state)
                actionOneSettings.BoxESP = state
            end
        })

        TabActionESP:Toggle({
            Title = "显示名字",
            Default = false,
            Callback = function(state)
                actionOneSettings.NameESP = state
            end
        })

        TabActionESP:Toggle({
            Title = "显示血量",
            Default = false,
            Callback = function(state)
                actionOneSettings.HealthESP = state
            end
        })

        TabActionESP:Toggle({
            Title = "显示距离",
            Default = false,
            Callback = function(state)
                actionOneSettings.DistanceESP = state
            end
        })

        TabActionESP:Toggle({
            Title = "显示连线",
            Default = false,
            Callback = function(state)
                actionOneSettings.LineESP = state
            end
        })

        TabActionESP:Toggle({
            Title = "启用雷达",
            Default = false,
            Callback = function(state)
                actionOneSettings.RadarEnabled = state
                if state then
                    startRadar()
                else
                    stopRadar()
                end
            end
        })

        TabActionESP:Slider({
            Title = "雷达半径",
            Value = {
                Min = 50,
                Max = 500,
                Default = 150,
            },
            Increment = 10,
            Callback = function(value)
                actionOneSettings.RadarRadius = value
            end
        })

        TabActionESP:Button({
            Title = "清理所有 ESP",
            Callback = function()
                stopESP()
                stopRadar()
                if WindUI and WindUI.Notify then
                    WindUI:Notify({Title = "已清理", Content = "", Duration = 2})
                end
            end
        })

        local TabActionAim = Window:Tab({
            Title = "行动自瞄",
            Icon = "target"
        })

        TabActionAim:Toggle({
            Title = "启用自瞄",
            Default = false,
            Callback = function(state)
                actionOneSettings.AimAssistEnabled = state
                if state then
                    startAim()
                else
                    stopAim()
                end
            end
        })

        TabActionAim:Toggle({
            Title = "FOV圈",
            Default = false,
            Callback = function(state)
                actionOneSettings.FOVCircleEnabled = state
            end
        })

        TabActionAim:Slider({
            Title = "自瞄范围",
            Value = {
                Min = 5,
                Max = 50,
                Default = 15,
            },
            Increment = 1,
            Callback = function(value)
                actionOneSettings.AimFOV = value
            end
        })

        TabActionAim:Slider({
            Title = "平滑度",
            Value = {
                Min = 1,
                Max = 20,
                Default = 7,
            },
            Increment = 1,
            Callback = function(value)
                actionOneSettings.AimSmoothness = value
            end
        })

        TabActionAim:Dropdown({
            Title = "瞄准部位",
            Values = {"Head", "HumanoidRootPart", "UpperTorso"},
            Value = "Head",
            Callback = function(value)
                actionOneSettings.AimTarget = value
            end
        })

        if WindUI and WindUI.Notify then
            WindUI:Notify({Title = "行动一已加载", Content = "", Duration = 3})
        end
    end
})

Tabs.sbcnm:Section({
    Title = "狙击竞技场", 
    TextXAlignment = "Left", 
    TextSize = 17
})

local snipLoaded = false

local allowedServerIds = {
    "119259569670784",
    "119661268047775",
}

local function GetCurrentServerId()
    local success, id = pcall(function()
        return tostring(game.PlaceId)
    end)
    if success and id then
        return id
    end
    return nil
end

local function CheckServerId()
    local currentId = GetCurrentServerId()
    if not currentId then
        if WindUI and WindUI.Notify then
            WindUI:Notify({Title = "加载失败", Content = "无法获取ID", Duration = 3})
        end
        return false
    end
    
    for _, allowedId in ipairs(allowedServerIds) do
        if currentId == allowedId then
            return true
        end
    end
    
    if WindUI and WindUI.Notify then
        WindUI:Notify({Title = "服务器不符", Content = "当前ID: " .. currentId, Duration = 3})
    end
    return false
end

Tabs.sbcnm:Button({
    Title = "狙击竞技场",
    Callback = function()
        if snipLoaded then
            if WindUI and WindUI.Notify then
                WindUI:Notify({Title = "重复点击！", Content = "", Duration = 3})
            end
            return
        end
        
        if not CheckServerId() then
            return
        end

        snipLoaded = true

        local TabSnipESP = Window:Tab({
            Title = "狙击ESP",
            Icon = "eye",
            Locked = false,
        })

        local ESP = {
            Enabled = false,
            XRay = true,
            EnemyColor = Color3.fromRGB(255, 60, 60),
            FriendlyColor = Color3.fromRGB(60, 220, 100),
            FillTransparency = 0.6,
            OutlineTransparency = 0,
        }

        local ESPHighlights = {}
        local ESPConnections = {}
        local LocalPlayer = game.Players.LocalPlayer
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")

        local function IsTeammate(player)
            if not LocalPlayer.Team then return false end
            return player.Team == LocalPlayer.Team
        end

        local function AddESP(player)
            if player == LocalPlayer or ESPHighlights[player] then return end
            if not player.Character then return end

            local highlight = Instance.new("Highlight")
            highlight.Name = "ESP_" .. player.Name
            highlight.DepthMode = ESP.XRay and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded

            local friendly = IsTeammate(player)
            highlight.FillColor = friendly and ESP.FriendlyColor or ESP.EnemyColor
            highlight.OutlineColor = friendly and ESP.FriendlyColor or ESP.EnemyColor
            highlight.FillTransparency = ESP.FillTransparency
            highlight.OutlineTransparency = ESP.OutlineTransparency
            highlight.Adornee = player.Character
            highlight.Parent = player.Character
            ESPHighlights[player] = highlight
        end

        local function RemoveESP(player)
            local highlight = ESPHighlights[player]
            if highlight then
                pcall(function() highlight:Destroy() end)
                ESPHighlights[player] = nil
            end
        end

        local function RefreshESP()
            for player, highlight in pairs(ESPHighlights) do
                if highlight and highlight.Parent then
                    local friendly = IsTeammate(player)
                    highlight.FillColor = friendly and ESP.FriendlyColor or ESP.EnemyColor
                    highlight.OutlineColor = friendly and ESP.FriendlyColor or ESP.EnemyColor
                    highlight.DepthMode = ESP.XRay and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
                end
            end
        end

        local function SetupPlayer(player)
            local connections = {
                player.CharacterAdded:Connect(function()
                    task.wait(0.2)
                    if ESP.Enabled then AddESP(player) end
                end),
                player.CharacterRemoving:Connect(function()
                    RemoveESP(player)
                end)
            }
            ESPConnections[player] = connections
            if ESP.Enabled and player.Character then
                AddESP(player)
            end
        end

        local function CleanupPlayer(player)
            RemoveESP(player)
            local conns = ESPConnections[player]
            if conns then
                for _, conn in ipairs(conns) do
                    pcall(function() conn:Disconnect() end)
                end
                ESPConnections[player] = nil
            end
        end

        function ESP:Enable()
            self.Enabled = true
            for _, player in ipairs(Players:GetPlayers()) do
                SetupPlayer(player)
            end
            ESPConnections._a = Players.PlayerAdded:Connect(SetupPlayer)
            ESPConnections._r = Players.PlayerRemoving:Connect(CleanupPlayer)
            ESPConnections._heartbeat = RunService.Heartbeat:Connect(function()
                if not ESP.Enabled then return end
                for _, player in ipairs(Players:GetPlayers()) do
                    if player == LocalPlayer then continue end
                    local highlight = ESPHighlights[player]
                    if player.Character then
                        if not highlight or not highlight.Parent then
                            ESPHighlights[player] = nil
                            AddESP(player)
                        end
                    else
                        if highlight then
                            RemoveESP(player)
                        end
                    end
                end
            end)
        end

        function ESP:Disable()
            self.Enabled = false
            for player, _ in pairs(ESPHighlights) do
                RemoveESP(player)
            end
            if ESPConnections._heartbeat then
                ESPConnections._heartbeat:Disconnect()
            end
            for player, conns in pairs(ESPConnections) do
                if type(conns) == "table" then
                    for _, conn in ipairs(conns) do
                        pcall(function() conn:Disconnect() end)
                    end
                else
                    pcall(function() conns:Disconnect() end)
                end
                ESPConnections[player] = nil
            end
        end

        function ESP:Toggle(state)
            if state then self:Enable() else self:Disable() end
        end

        function ESP:SetXRay(enabled)
            self.XRay = enabled
            RefreshESP()
        end

        TabSnipESP:Toggle({
            Title = "启动ESP",
            Default = false,
            Callback = function(state) ESP:Toggle(state) end
        })

        TabSnipESP:Toggle({
            Title = "开启X光",
            Default = true,
            Callback = function(state) ESP:SetXRay(state) end
        })

        TabSnipESP:Slider({
            Title = "填充不透明度",
            Value = {
                Min = 0,
                Max = 100,
                Default = 40,
            },
            Increment = 1,
            Callback = function(value)
                ESP.FillTransparency = 1 - value / 100
                for _, highlight in pairs(ESPHighlights) do
                    if highlight then
                        highlight.FillTransparency = ESP.FillTransparency
                    end
                end
            end
        })

        TabSnipESP:Slider({
            Title = "边框不透明度",
            Value = {
                Min = 0,
                Max = 100,
                Default = 100,
            },
            Increment = 1,
            Callback = function(value)
                ESP.OutlineTransparency = 1 - value / 100
                for _, highlight in pairs(ESPHighlights) do
                    if highlight then
                        highlight.OutlineTransparency = ESP.OutlineTransparency
                    end
                end
            end
        })

        local TabSnipAim = Window:Tab({
            Title = "狙击自瞄",
            Icon = "crosshair",
            Locked = false,
        })

        local SilentAim = {
            Enabled = false,
            FOV = 120,
            TargetBone = "Head",
            VisCheck = true,
            DrawFOV = true,
            AimMode = "All",
            Smoothness = 0.08,
            SmoothAim = false,
            PredictionFactor = 12,
        }

        local FOVCircle = nil
        local SilentAimConnection = nil
        local Camera = workspace.CurrentCamera
        local currentTarget = nil

        local function CreateFOVCircle()
            if not Drawing then return end
            FOVCircle = Drawing.new("Circle")
            FOVCircle.Visible = false
            FOVCircle.Radius = SilentAim.FOV
            FOVCircle.Color = Color3.fromRGB(255, 255, 255)
            FOVCircle.Thickness = 1.5
            FOVCircle.Filled = false
            FOVCircle.NumSides = 64
        end

        local function UpdateFOVCircle()
            if not FOVCircle then return end
            local cam = workspace.CurrentCamera
            if not cam then return end
            FOVCircle.Position = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
            FOVCircle.Radius = SilentAim.FOV
            FOVCircle.Visible = SilentAim.Enabled and SilentAim.DrawFOV
        end

        local function IsVisible(position)
            if not SilentAim.VisCheck then return true end
            local cam = workspace.CurrentCamera
            if not cam then return true end
            local origin = cam.CFrame.Position
            local direction = position - origin
            local params = RaycastParams.new()
            params.FilterType = Enum.RaycastFilterType.Exclude
            local filterList = {}
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character then
                    table.insert(filterList, player.Character)
                end
            end
            params.FilterDescendantsInstances = filterList
            local result = workspace:Raycast(origin, direction.Unit * direction.Magnitude, params)
            return result == nil
        end

        local function IsTargetValid(player)
            if player == LocalPlayer then return false end
            if not player.Character then return false end
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if not humanoid or humanoid.Health <= 0 then return false end
            
            if SilentAim.AimMode == "Team" then
                if LocalPlayer.Team and player.Team and player.Team == LocalPlayer.Team then
                    return false
                end
                return true
            elseif SilentAim.AimMode == "Enemy" then
                if not LocalPlayer.Team or not player.Team then return true end
                return player.Team ~= LocalPlayer.Team
            else
                return true
            end
        end

        local function predictTargetPosition(player)
            if not player or not player.Character then return nil end

            local aimPart = player.Character:FindFirstChild(SilentAim.TargetBone)
            if not aimPart then return nil end

            local velocity = aimPart.Velocity
            local targetPos = aimPart.Position
            local horizontalSpeed = Vector3.new(velocity.X, 0, velocity.Z).Magnitude

            if horizontalSpeed > 20 then
                return targetPos + (velocity * SilentAim.PredictionFactor * 0.02)
            else
                return targetPos
            end
        end

        local function GetClosestTarget()
            local closestDist = math.huge
            local closestPlayer = nil
            local cam = workspace.CurrentCamera
            if not cam then return nil end
            local screenCenter = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
            local char = LocalPlayer.Character
            local rootPart = char and char:FindFirstChild("HumanoidRootPart")
            if not rootPart then return nil end

            for _, player in ipairs(Players:GetPlayers()) do
                if not IsTargetValid(player) then continue end
                if not player.Character then continue end

                local targetPart = player.Character:FindFirstChild(SilentAim.TargetBone)
                if not targetPart then continue end

                local screenPos, onScreen = cam:WorldToScreenPoint(targetPart.Position)
                if not onScreen then continue end

                if not IsVisible(targetPart.Position) then continue end

                local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                if screenDist > SilentAim.FOV then continue end

                local worldDist = (rootPart.Position - targetPart.Position).Magnitude
                
                if worldDist < closestDist then
                    closestDist = worldDist
                    closestPlayer = player
                end
            end

            return closestPlayer
        end

        function SilentAim:Enable()
            self.Enabled = true
            if not FOVCircle then CreateFOVCircle() end
            SilentAimConnection = RunService.RenderStepped:Connect(function()
                UpdateFOVCircle()
                
                local target = GetClosestTarget()
                currentTarget = target
                
                if target and target.Character then
                    local cam = workspace.CurrentCamera
                    if not cam then return end
                    
                    local targetPart = target.Character:FindFirstChild(SilentAim.TargetBone)
                    if not targetPart then return end
                    
                    local targetPos = predictTargetPosition(target) or targetPart.Position
                    
                    if SilentAim.SmoothAim then
                        local currentPos = cam.CFrame.Position
                        local lookAt = CFrame.lookAt(currentPos, targetPos)
                        local smoothness = math.clamp(SilentAim.Smoothness, 0.01, 1)
                        cam.CFrame = cam.CFrame:Lerp(lookAt, smoothness)
                    else
                        cam.CFrame = CFrame.lookAt(cam.CFrame.Position, targetPos)
                    end
                end
            end)
        end

        function SilentAim:Disable()
            self.Enabled = false
            if SilentAimConnection then
                SilentAimConnection:Disconnect()
                SilentAimConnection = nil
            end
            if FOVCircle then
                FOVCircle.Visible = false
            end
            currentTarget = nil
        end

        function SilentAim:Toggle(state)
            if state then self:Enable() else self:Disable() end
        end

        function SilentAim:SetFOV(radius)
            self.FOV = math.clamp(radius, 10, 500)
            UpdateFOVCircle()
        end

        function SilentAim:SetBone(bone)
            self.TargetBone = bone
        end

        function SilentAim:SetAimMode(mode)
            self.AimMode = mode
        end

        TabSnipAim:Toggle({
            Title = "开启自瞄",
            Default = false,
            Callback = function(state) SilentAim:Toggle(state) end
        })

        TabSnipAim:Slider({
            Title = "FOV 半径",
            Value = {
                Min = 20,
                Max = 350,
                Default = 120,
            },
            Increment = 1,
            Callback = function(value) SilentAim:SetFOV(value) end
        })

        TabSnipAim:Toggle({
            Title = "显示 FOV 圆圈",
            Default = true,
            Callback = function(state)
                SilentAim.DrawFOV = state
                if FOVCircle then
                    FOVCircle.Visible = SilentAim.Enabled and state
                end
            end
        })

        TabSnipAim:Dropdown({
            Title = "锁定部位",
            Values = { "Head", "HumanoidRootPart", "UpperTorso" },
            Default = "Head",
            Callback = function(value) SilentAim:SetBone(value) end
        })

        TabSnipAim:Dropdown({
            Title = "自瞄模式",
            Values = { "全部玩家", "队伍模式", "敌人模式" },
            Default = "全部玩家",
            Callback = function(value)
                if value == "全部玩家" then
                    SilentAim:SetAimMode("All")
                elseif value == "队伍模式" then
                    SilentAim:SetAimMode("Team")
                elseif value == "敌人模式" then
                    SilentAim:SetAimMode("Enemy")
                end
            end
        })

        TabSnipAim:Toggle({
            Title = "平滑瞄准",
            Default = false,
            Callback = function(state) 
                SilentAim.SmoothAim = state 
            end
        })

        TabSnipAim:Slider({
            Title = "平滑度",
            Value = {
                Min = 1,
                Max = 100,
                Default = 8,
            },
            Increment = 1,
            Callback = function(val) 
                SilentAim.Smoothness = val / 100
            end
        })

        TabSnipAim:Slider({
            Title = "瞄准预测",
            Value = {
                Min = 0,
                Max = 30,
                Default = 12,
            },
            Increment = 1,
            Callback = function(val) 
                SilentAim.PredictionFactor = val
            end
        })

        TabSnipAim:Toggle({
            Title = "可见性检测",
            Default = true,
            Callback = function(state) SilentAim.VisCheck = state end
        })

        if WindUI and WindUI.Notify then
            WindUI:Notify({Title = "狙击竞技场已加载", Content = "", Duration = 3})
        end
    end
})

Tabs.sbcnm:Section({
    Title = "po大po", 
    TextXAlignment = "Left", 
    TextSize = 17
})

local popoLoaded = false

local allowedServerIds = {
    "85050171250159",
}

local function GetCurrentServerId()
    local success, id = pcall(function()
        return tostring(game.PlaceId)
    end)
    if success and id then
        return id
    end
    return nil
end

local function CheckServerId()
    local currentId = GetCurrentServerId()
    if not currentId then
        if WindUI and WindUI.Notify then
            WindUI:Notify({
                Title = "加载失败", 
                Content = "无法获取ID", 
                Duration = 3
            })
        end
        return false
    end
    
    for _, allowedId in ipairs(allowedServerIds) do
        if currentId == allowedId then
            return true
        end
    end
    
    if WindUI and WindUI.Notify then
        WindUI:Notify({
            Title = "服务器不符", 
            Content = "当前ID: " .. currentId, 
            Duration = 3
        })
    end
    return false
end

Tabs.sbcnm:Button({
    Title = "po大po",
    Callback = function()
        if popoLoaded then
            if WindUI and WindUI.Notify then
                WindUI:Notify({
                    Title = "重复点击！", 
                    Content = "", 
                    Duration = 3
                })
            end
            return
        end
        
        if not CheckServerId() then
            return
        end

        popoLoaded = true

        local TabPopo = Window:Tab({
            Title = "po大po",
            Icon = "crown",
            Locked = false,
        })

        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local RemoteEvent = ReplicatedStorage.Packets.Packet.RemoteEvent

        local run1 = false
        TabPopo:Toggle({
            Title = "自动售卖",
            Desc = "自动卖臭臭",
            Default = false,
            Callback = function(state)
                run1 = state
                WindUI:Notify({
                    Title = "自动售卖",
                    Content = state and "已启用" or "已禁用",
                    Icon = state and "check" or "x",
                    Duration = 1
                })
                if state then
                    task.spawn(function()
                        while run1 do
                            RemoteEvent:FireServer(buffer.fromstring("\3\0"))
                            task.wait(0.0001)
                        end
                    end)
                end
            end
        })

        local run2 = false
        TabPopo:Toggle({
            Title = "卡服",
            Desc = "拉很多臭臭(会被踢,但很爽)",
            Default = false,
            Callback = function(state)
                run2 = state
                WindUI:Notify({
                    Title = "卡服",
                    Content = state and "已启用" or "已禁用",
                    Icon = state and "check" or "x",
                    Duration = 1
                })
                if state then
                    task.spawn(function()
                        while run2 do
                            RemoteEvent:FireServer(buffer.fromstring("\0\0\0\0"))
                            task.wait(0.000000000000001)
                        end
                    end)
                end
            end
        })

        local run3 = false
        TabPopo:Toggle({
            Title = "自动拉屎",
            Desc = "拉臭臭",
            Default = false,
            Callback = function(state)
                run3 = state
                WindUI:Notify({
                    Title = "自动拉屎",
                    Content = state and "已启用" or "已禁用",
                    Icon = state and "check" or "x",
                    Duration = 1
                })
                if state then
                    task.spawn(function()
                        while run3 do
                            RemoteEvent:FireServer(buffer.fromstring("\0\0\0\0"))
                            task.wait(0.5)
                        end
                    end)
                end
            end
        })

        if WindUI and WindUI.Notify then
            WindUI:Notify({
                Title = "po大po已加载", 
                Content = "", 
                Duration = 3
            })
        end
    end
})

Tabs.sbcnm:Section({
    Title = "动物医院", 
    TextXAlignment = "Left", 
    TextSize = 17
})

local hospitalLoaded = false

local allowedServerIds = {
    "104522435597696",
}

local function GetCurrentServerId()
    local success, id = pcall(function()
        return tostring(game.PlaceId)
    end)
    if success and id then
        return id
    end
    return nil
end

local function CheckServerId()
    local currentId = GetCurrentServerId()
    if not currentId then
        if WindUI and WindUI.Notify then
            WindUI:Notify({
                Title = "加载失败", 
                Content = "无法获取ID", 
                Duration = 3
            })
        end
        return false
    end
    
    for _, allowedId in ipairs(allowedServerIds) do
        if currentId == allowedId then
            return true
        end
    end
    
    if WindUI and WindUI.Notify then
        WindUI:Notify({
            Title = "服务器不符", 
            Content = "当前ID: " .. currentId, 
            Duration = 3
        })
    end
    return false
end

Tabs.sbcnm:Button({
    Title = "动物医院",
    Callback = function()
        if hospitalLoaded then
            if WindUI and WindUI.Notify then
                WindUI:Notify({
                    Title = "重复点击！", 
                    Content = "", 
                    Duration = 3
                })
            end
            return
        end
        
        if not CheckServerId() then
            return
        end

        hospitalLoaded = true

        local TabHospital1 = Window:Tab({
            Title = "控制",
            Icon = "settings",
            Locked = false,
        })

        local TabHospital2 = Window:Tab({
            Title = "玩家",
            Icon = "user",
            Locked = false,
        })

        local TabHospital3 = Window:Tab({
            Title = "关于",
            Icon = "info",
            Locked = false,
        })

        local Players = game:GetService("Players")
        local Workspace = game:GetService("Workspace")
        local TweenService = game:GetService("TweenService")
        local RunService = game:GetService("RunService")
        local Camera = workspace.CurrentCamera
        local LocalPlayer = Players.LocalPlayer

        if not _G.HospitalConfig then
            _G.HospitalConfig = {
                InstantAction = false,
                AutoProcess = false,
                AutoHeal = false,
                AutoRoom6 = false,
                AutoRoom7 = false,
                AutoRoom8 = false,
                NoClip = false,
                WalkSpeed = 16
            }
        end
        local Config = _G.HospitalConfig
        local PromptConnections = {}
        local OriginalCollisions = {}
        local ItemDebounce = {}
        local ITEM_PICKUP_COOLDOWN = 0.2
        local ItemPromptCache = {}
        local CacheRefreshTime = 0
        local CACHE_DURATION = 3

        local function RefreshItemCache()
            ItemPromptCache = {}
            CacheRefreshTime = os.clock()
            for _, desc in ipairs(Workspace:GetDescendants()) do
                if desc:IsA("ProximityPrompt") and desc.Enabled and desc.ActionText then
                    ItemPromptCache[string.lower(desc.ActionText)] = desc
                end
            end
        end

        local function GetCachedItemPrompt(itemName)
            if not itemName or itemName == "" then return nil end
            if os.clock() - CacheRefreshTime > CACHE_DURATION then RefreshItemCache() end
            local target = string.lower(itemName)
            for key, prompt in pairs(ItemPromptCache) do
                if string.find(key, target) or string.find(target, key) then return prompt end
            end
            return nil
        end

        local function GetCharacter()
            return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        end

        local function GetHumanoid()
            local char = GetCharacter()
            return char and char:FindFirstChildOfClass("Humanoid")
        end

        local function GetRootPart()
            local char = GetCharacter()
            return char and char:FindFirstChild("HumanoidRootPart")
        end

        local function FindBasePartInObject(obj)
            if not obj then return nil end
            if obj:IsA("BasePart") then return obj end
            for _, child in ipairs(obj:GetChildren()) do
                if child:IsA("BasePart") then return child end
                if child:IsA("Model") then
                    local part = FindBasePartInObject(child)
                    if part then return part end
                end
            end
            return nil
        end

        local function SafeTeleport(position)
            local root = GetRootPart()
            if not root then return end
            local newPos = position + Vector3.new(0, 2, 0)
            pcall(function()
                root.CFrame = CFrame.new(newPos)
                RunService.Heartbeat:Wait()
                root.Velocity = Vector3.new(0, 0, 0)
                local hum = GetHumanoid()
                if hum then hum:ChangeState(Enum.HumanoidStateType.Running) end
            end)
        end

        local function LookAtPosition(targetPosition)
            local root = GetRootPart()
            if root and targetPosition then
                pcall(function()
                    root.CFrame = CFrame.lookAt(root.Position, targetPosition)
                    local character = GetCharacter()
                    if character then
                        local head = character:FindFirstChild("Head")
                        if head then
                            local camPos = head.Position - (root.CFrame.LookVector * 4) + Vector3.new(0, 2, 0)
                            Camera.CFrame = CFrame.lookAt(camPos, targetPosition)
                        end
                    end
                end)
            end
        end

        local function FirePromptDirect(prompt)
            if not prompt or not prompt:IsA("ProximityPrompt") or not prompt.Enabled then return false end
            local targetPart = FindBasePartInObject(prompt.Parent)
            if targetPart then LookAtPosition(targetPart.Position) end
            if Config.InstantAction then prompt.HoldDuration = 0 end
            local success = false
            local s1, e1 = pcall(function() fireproximityprompt(prompt) end)
            if s1 then success = true end
            if not success then
                local s2, e2 = pcall(function()
                    prompt:InputHoldStart(LocalPlayer)
                    task.wait(0.05)
                    prompt:InputHoldEnd(LocalPlayer)
                end)
                if s2 then success = true end
            end
            if not success then
                local s3, e3 = pcall(function()
                    local mouse = LocalPlayer:GetMouse()
                    if mouse then
                        local part = FindBasePartInObject(prompt.Parent)
                        if part then
                            mouse.Target = part
                            mouse.TargetClick:Fire()
                        end
                    end
                end)
                if s3 then success = true end
            end
            return success
        end

        local function FirePromptWithCamera(prompt, targetPosition)
            if not prompt or not prompt:IsA("ProximityPrompt") then return false end
            if targetPosition then LookAtPosition(targetPosition) end
            return FirePromptDirect(prompt)
        end

        local function ClickButton(buttonPart)
            if not buttonPart then return false end
            local clickDetector = buttonPart:FindFirstChildOfClass("ClickDetector")
            if clickDetector then
                LookAtPosition(buttonPart.Position)
                local success, err = pcall(function() fireclickdetector(clickDetector) end)
                if success then return true end
            end
            return false
        end

        local function HasItem(itemName)
            if not itemName or itemName == "" then return false end
            local backpack = LocalPlayer:FindFirstChild("Backpack")
            if backpack then
                for _, tool in ipairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") and string.find(string.lower(tool.Name), string.lower(itemName)) then
                        return true
                    end
                end
            end
            local char = GetCharacter()
            if char then
                for _, tool in ipairs(char:GetChildren()) do
                    if tool:IsA("Tool") and string.find(string.lower(tool.Name), string.lower(itemName)) then
                        return true
                    end
                end
            end
            return false
        end

        local function EquipToolFast(itemName)
            local backpack = LocalPlayer:FindFirstChild("Backpack")
            local hum = GetHumanoid()
            if backpack and hum then
                for _, tool in ipairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") and string.find(string.lower(tool.Name), string.lower(itemName)) then
                        hum:EquipTool(tool)
                        task.wait(0.05)
                        return true
                    end
                end
            end
            return false
        end

        local function GetMedicalRooms()
            local rooms = Workspace:FindFirstChild("Rooms")
            if rooms then return rooms:FindFirstChild("Medical") end
            return Workspace:FindFirstChild("Medical")
        end

        local function GetEmergencyRooms()
            local rooms = Workspace:FindFirstChild("Rooms")
            if rooms then return rooms:FindFirstChild("Emergency") end
            return Workspace:FindFirstChild("Emergency")
        end

        local function FindInBedInRoom(room)
            if not room then return nil end
            local minigame = room:FindFirstChild("Minigame")
            if minigame then
                local bed = minigame:FindFirstChild("Bed")
                if bed then return bed:FindFirstChild("InBed") end
            end
            return room:FindFirstChild("InBed")
        end

        local function FindInvInRoom(room)
            if not room then return nil end
            local minigame = room:FindFirstChild("Minigame")
            if minigame then
                local tv = minigame:FindFirstChild("TV")
                if tv then
                    local screen = tv:FindFirstChild("Screen")
                    if screen then
                        local ui = screen:FindFirstChild("UI")
                        if ui then
                            local report = ui:FindFirstChild("Report")
                            if report then return report:FindFirstChild("inv") end
                        end
                    end
                end
            end
            return room:FindFirstChild("inv", true)
        end

        local function FindColorsInMinigame(room)
            if not room then return nil end
            local minigame = room:FindFirstChild("Minigame")
            if not minigame then return nil end
            for _, desc in ipairs(minigame:GetDescendants()) do
                if desc.Name == "Colors" and desc:IsA("Folder") then return desc end
            end
            return nil
        end

        local function FindXrayMonitorInMinigame(room)
            if not room then return nil end
            local minigame = room:FindFirstChild("Minigame")
            if not minigame then return nil end
            for _, desc in ipairs(minigame:GetDescendants()) do
                if desc.Name == "xrayMonitor" and desc:IsA("Model") then return desc end
            end
            return nil
        end

        local function HasCheck(item)
            if not item then return false end
            local check = item:FindFirstChild("check")
            if check and check:IsA("ImageLabel") then return check.Visible == true end
            return false
        end

        local function GetItemsFromInv(invFolder)
            local itemsNeeded = {}
            if not invFolder then return itemsNeeded end
            for _, child in ipairs(invFolder:GetChildren()) do
                if not child:IsA("UIGridLayout") and not child:IsA("UIListLayout") then
                    if child.Name and child.Name ~= "" and not HasCheck(child) then
                        table.insert(itemsNeeded, child.Name)
                    end
                end
            end
            return itemsNeeded
        end

        local function GetButtonModels(colorsFolder)
            if not colorsFolder then return {} end
            local buttons = {}
            for _, model in ipairs(colorsFolder:GetChildren()) do
                if model:IsA("Model") and model:FindFirstChild("Button") then
                    local btn = model:FindFirstChild("Button")
                    if btn and btn:IsA("BasePart") then
                        table.insert(buttons, btn)
                    end
                end
            end
            return buttons
        end

        local function GetButtonColors(colorsFolder)
            if not colorsFolder then return {} end
            local colors = {}
            for _, model in ipairs(colorsFolder:GetChildren()) do
                if model:IsA("Model") and model:FindFirstChild("Button") then
                    local btn = model:FindFirstChild("Button")
                    if btn and btn:IsA("BasePart") then
                        table.insert(colors, btn.Color)
                    end
                end
            end
            return colors
        end

        local function CountChangedButtons(colorsFolder, initialColors)
            if not colorsFolder or not initialColors then return 0 end
            local currentColors = GetButtonColors(colorsFolder)
            local changed = 0
            for i = 1, math.min(#initialColors, #currentColors) do
                if initialColors[i] ~= currentColors[i] then
                    changed = changed + 1
                end
            end
            return changed
        end

        local function GetPromptByActionText(actionText, searchRoot)
            if not actionText or actionText == "" then return nil end
            if not searchRoot then searchRoot = Workspace end
            local targetText = string.lower(actionText)
            for _, desc in ipairs(searchRoot:GetDescendants()) do
                if desc:IsA("ProximityPrompt") and desc.Enabled and desc.ActionText then
                    local lowerAction = string.lower(desc.ActionText)
                    if string.find(lowerAction, targetText) or string.find(targetText, lowerAction) then
                        return desc
                    end
                end
            end
            return nil
        end

        local function AutoRoom6Sequence()
            local emergency = GetEmergencyRooms()
            if not emergency then return end
            local room6 = emergency:FindFirstChild("Room6")
            if not room6 then return end
            local minigame = room6:FindFirstChild("Minigame")
            if not minigame then return end
            local xrayMonitor = FindXrayMonitorInMinigame(room6)
            if xrayMonitor then
                local xrayPrompt = xrayMonitor:FindFirstChild("PP")
                if xrayPrompt and xrayPrompt:IsA("ProximityPrompt") and xrayPrompt.Enabled then
                    local part = FindBasePartInObject(xrayMonitor)
                    if part then
                        SafeTeleport(part.Position)
                        FirePromptWithCamera(xrayPrompt, part.Position)
                        wait(0.5)
                    end
                end
            end
            local colorsFolder = FindColorsInMinigame(room6)
            if not colorsFolder then return end
            local initialColors = GetButtonColors(colorsFolder)
            local buttons = GetButtonModels(colorsFolder)
            if #buttons < 4 then return end
            local timeout = 0
            local changedCount = 0
            local maxWaitTime = 15
            while timeout < maxWaitTime and changedCount < 4 do
                wait(0.2)
                changedCount = CountChangedButtons(colorsFolder, initialColors)
                timeout = timeout + 0.2
            end
            wait(1.5)
            local clickedCount = 0
            for _, btn in ipairs(buttons) do
                if btn and btn:IsA("BasePart") then
                    SafeTeleport(btn.Position + Vector3.new(0, 1, 2))
                    LookAtPosition(btn.Position)
                    wait(0.2)
                    if ClickButton(btn) then
                        clickedCount = clickedCount + 1
                    end
                    wait(0.15)
                end
            end
            local processPrompt = nil
            local processTimeout = 0
            while processTimeout < 10 do
                processPrompt = GetPromptByActionText("process results", minigame)
                if processPrompt then break end
                wait(0.3)
                processTimeout = processTimeout + 0.3
            end
            if processPrompt then
                local part = FindBasePartInObject(processPrompt.Parent)
                if part then
                    SafeTeleport(part.Position)
                    FirePromptWithCamera(processPrompt, part.Position)
                    wait(0.5)
                end
            end
            local printBadgePrompt = nil
            local badgeTimeout = 0
            while badgeTimeout < 10 do
                printBadgePrompt = GetPromptByActionText("print badge", minigame)
                if printBadgePrompt then break end
                wait(0.3)
                badgeTimeout = badgeTimeout + 0.3
            end
            if printBadgePrompt then
                local part = FindBasePartInObject(printBadgePrompt.Parent)
                if part then
                    SafeTeleport(part.Position)
                    FirePromptWithCamera(printBadgePrompt, part.Position)
                    wait(0.5)
                end
            end
            local collectPrompt = nil
            local collectTimeout = 0
            while collectTimeout < 8 do
                collectPrompt = GetPromptByActionText("collect", Workspace)
                if collectPrompt then break end
                wait(0.3)
                collectTimeout = collectTimeout + 0.3
            end
            if collectPrompt then
                local part = FindBasePartInObject(collectPrompt.Parent)
                if part then
                    SafeTeleport(part.Position)
                    FirePromptWithCamera(collectPrompt, part.Position)
                    wait(0.3)
                end
            end
        end

        task.spawn(function()
            while true do
                RunService.Heartbeat:Wait()
                if Config.AutoRoom6 then
                    AutoRoom6Sequence()
                    wait(3)
                end
            end
        end)

        local function HealRoomFast(roomNum)
            local room = nil
            local itemsNeeded = {}
            local promptToDeliver = nil
            local deliverPosition = nil
            if roomNum <= 5 then
                local medical = GetMedicalRooms()
                if medical then room = medical:FindFirstChild("Room" .. roomNum) end
                if not room then return false end
                local invPath = FindInvInRoom(room)
                if not invPath then return false end
                itemsNeeded = GetItemsFromInv(invPath)
                local bedPath = FindInBedInRoom(room)
                if bedPath then
                    for _, desc in ipairs(bedPath:GetDescendants()) do
                        if desc:IsA("ProximityPrompt") and desc.Enabled then
                            promptToDeliver = desc
                            break
                        end
                    end
                    if not promptToDeliver then
                        for _, desc in ipairs(bedPath.Parent:GetDescendants()) do
                            if desc:IsA("ProximityPrompt") and desc.Enabled then
                                promptToDeliver = desc
                                break
                            end
                        end
                    end
                    deliverPosition = bedPath.Position
                end
            elseif roomNum == 6 then
                local emergency = GetEmergencyRooms()
                if emergency then room = emergency:FindFirstChild("Room6") end
                if not room then return false end
                local invPath = FindInvInRoom(room)
                if not invPath then return false end
                itemsNeeded = GetItemsFromInv(invPath)
                local npcsFolder = Workspace:FindFirstChild("NPCs")
                if npcsFolder then
                    for _, npc in ipairs(npcsFolder:GetChildren()) do
                        local pp = npc:FindFirstChild("PP")
                        if pp and pp:IsA("ProximityPrompt") and pp.Enabled and string.find(string.lower(pp.ActionText or ""), "treatment") then
                            promptToDeliver = pp
                            deliverPosition = FindBasePartInObject(npc) and FindBasePartInObject(npc).Position
                            break
                        end
                    end
                end
            end
            if #itemsNeeded == 0 or not promptToDeliver then return false end
            local holdingAllItems = true
            local maxRetries = 3
            for _, itemName in ipairs(itemsNeeded) do
                local retryCount = 0
                local collected = HasItem(itemName)
                while not collected and retryCount < maxRetries do
                    if HasItem(itemName) then
                        collected = true
                        break
                    end
                    local prompt = GetCachedItemPrompt(itemName)
                    if prompt and prompt.Enabled then
                        local lastPickup = ItemDebounce[prompt] or 0
                        if os.clock() - lastPickup >= ITEM_PICKUP_COOLDOWN then
                            local part = FindBasePartInObject(prompt.Parent)
                            if part then
                                ItemDebounce[prompt] = os.clock()
                                SafeTeleport(part.Position)
                                FirePromptDirect(prompt)
                                task.wait(0.2)
                                if HasItem(itemName) then
                                    collected = true
                                    break
                                end
                            end
                        end
                    end
                    retryCount = retryCount + 1
                    task.wait(0.1)
                end
                if not collected then
                    holdingAllItems = false
                end
            end
            if holdingAllItems and deliverPosition then
                SafeTeleport(deliverPosition + Vector3.new(0, 1, 0))
                for _, itemName in ipairs(itemsNeeded) do
                    if HasItem(itemName) then
                        EquipToolFast(itemName)
                        local deliverSuccess = false
                        for i = 1, 3 do
                            if FirePromptDirect(promptToDeliver) then
                                deliverSuccess = true
                                break
                            end
                            task.wait(0.1)
                        end
                        task.wait(0.1)
                    end
                end
            end
            return true
        end

        task.spawn(function()
            while true do
                RunService.Heartbeat:Wait()
                if Config.AutoHeal then
                    for roomNum = 1, 6 do 
                        if not Config.AutoHeal then break end
                        HealRoomFast(roomNum)
                        task.wait(0.1)
                    end
                end
            end
        end)

        local function ProcessGlobalRooms()
            for _, desc in ipairs(Workspace:GetDescendants()) do
                if not Config.AutoProcess then break end
                if desc:IsA("ProximityPrompt") and desc.Enabled and desc.ActionText then
                    local txt = string.lower(desc.ActionText)
                    if string.find(txt, "dna") or string.find(txt, "analyze") or string.find(txt, "process") then
                        local part = FindBasePartInObject(desc.Parent)
                        if part then
                            SafeTeleport(part.Position)
                            FirePromptDirect(desc)
                        end
                    end
                end
            end
        end

        task.spawn(function()
            while true do
                RunService.Heartbeat:Wait()
                if Config.AutoProcess then
                    ProcessGlobalRooms()
                end
            end
        end)

        local function AutoRoom7Loop()
            while true do
                RunService.Heartbeat:Wait()
                if Config.AutoRoom7 then
                    local emergency = GetEmergencyRooms()
                    local room7 = emergency and emergency:FindFirstChild("Room7")
                    if room7 then
                        local inBed = FindInBedInRoom(room7)
                        if inBed then
                            for _, prompt in ipairs(inBed:GetDescendants()) do
                                if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                                    local text = string.lower(prompt.ActionText or "")
                                    local targets = {"sleep", "prepare", "set up", "turn on", "begin", "collect"}
                                    for _, target in ipairs(targets) do
                                        if string.find(text, target) then
                                            local part = FindBasePartInObject(prompt.Parent)
                                            if part then
                                                SafeTeleport(part.Position)
                                                FirePromptDirect(prompt)
                                            end
                                            break
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        local function AutoRoom8Loop()
            while true do
                RunService.Heartbeat:Wait()
                if Config.AutoRoom8 then
                    local emergency = GetEmergencyRooms()
                    local room8 = emergency and emergency:FindFirstChild("Room8")
                    if room8 then
                        local inBed = FindInBedInRoom(room8)
                        if inBed then
                            for _, prompt in ipairs(inBed:GetDescendants()) do
                                if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                                    local text = string.lower(prompt.ActionText or "")
                                    if string.find(text, "sleep") or string.find(text, "patient") then
                                        local part = FindBasePartInObject(prompt.Parent)
                                        if part then
                                            SafeTeleport(part.Position)
                                            FirePromptDirect(prompt)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        local function HookPrompt(prompt)
            if not prompt:IsA("ProximityPrompt") then return end
            if Config.InstantAction then prompt.HoldDuration = 0 end
        end

        Workspace.DescendantAdded:Connect(HookPrompt)
        for _, p in ipairs(Workspace:GetDescendants()) do HookPrompt(p) end

        local function SaveOriginalCollisions()
            local char = GetCharacter()
            if not char or next(OriginalCollisions) ~= nil then return end
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then OriginalCollisions[part] = part.CanCollide end
            end
        end

        local function RestoreOriginalCollisions()
            local char = GetCharacter()
            if not char then return end
            for part, canCollide in pairs(OriginalCollisions) do
                if part and part.Parent then part.CanCollide = canCollide end
            end
            OriginalCollisions = {}
        end

        local function ApplyNoClip()
            local char = GetCharacter()
            if not char then return end
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = not Config.NoClip
                end
            end
        end

        RunService.Heartbeat:Connect(function()
            local hum = GetHumanoid()
            if hum then hum.WalkSpeed = Config.WalkSpeed end
            if Config.NoClip then
                SaveOriginalCollisions()
                ApplyNoClip()
            else
                RestoreOriginalCollisions()
            end
        end)

        task.spawn(AutoRoom7Loop)
        task.spawn(AutoRoom8Loop)

        TabHospital1:Toggle({
            Title = "快速交互",
            Default = false,
            Callback = function(state)
                Config.InstantAction = state
                if state then
                    for _, prompt in ipairs(Workspace:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") then prompt.HoldDuration = 0 end
                    end
                end
            end
        })

        TabHospital1:Toggle({
            Title = "自动收集",
            Default = false,
            Callback = function(state)
                Config.AutoProcess = state
            end
        })

        TabHospital1:Toggle({
            Title = "自动房间 6（X 光）",
            Default = false,
            Callback = function(state)
                Config.AutoRoom6 = state
            end
        })

        TabHospital1:Toggle({
            Title = "自动房间 7",
            Default = false,
            Callback = function(state)
                Config.AutoRoom7 = state
            end
        })

        TabHospital1:Toggle({
            Title = "自动房间 8",
            Default = false,
            Callback = function(state)
                Config.AutoRoom8 = state
            end
        })

        TabHospital1:Toggle({
            Title = "自动治疗",
            Default = false,
            Callback = function(state)
                Config.AutoHeal = state
                if state then RefreshItemCache() end
            end
        })

        TabHospital2:Slider({
            Title = "移动速度",
            Value = { Min = 1, Max = 200, Default = 16 },
            Callback = function(value)
                Config.WalkSpeed = value
                local hum = GetHumanoid()
                if hum then hum.WalkSpeed = value end
            end
        })

        TabHospital2:Toggle({
            Title = "穿墙模式",
            Default = false,
            Callback = function(state)
                Config.NoClip = state
                if not state then RestoreOriginalCollisions() end
            end
        })

        TabHospital2:Button({
            Title = "重置速度",
            Callback = function()
                Config.WalkSpeed = 16
                local hum = GetHumanoid()
                if hum then hum.WalkSpeed = 16 end
            end
        })

        TabHospital3:Button({
            Title = "全部关闭",
            Callback = function()
                Config.InstantAction = false
                Config.AutoProcess = false
                Config.AutoRoom6 = false
                Config.AutoRoom7 = false
                Config.AutoRoom8 = false
                Config.AutoHeal = false
                Config.NoClip = false
                RestoreOriginalCollisions()
                Config.WalkSpeed = 16
            end
        })

        if WindUI and WindUI.Notify then
            WindUI:Notify({
                Title = "动物医院已加载", 
                Content = "", 
                Duration = 3
            })
        end
    end
})

Tabs.sbcnm:Section({
    Title = "烧烤战斗", 
    TextXAlignment = "Left", 
    TextSize = 17
})

local otherLoaded = false

local allowedServerIds = {
    "101272402522756",
}

local function GetCurrentServerId()
    local success, id = pcall(function()
        return tostring(game.PlaceId)
    end)
    if success and id then
        return id
    end
    return nil
end

local function CheckServerId()
    local currentId = GetCurrentServerId()
    if not currentId then
        if WindUI and WindUI.Notify then
            WindUI:Notify({
                Title = "加载失败", 
                Content = "无法获取ID", 
                Duration = 3
            })
        end
        return false
    end
    
    for _, allowedId in ipairs(allowedServerIds) do
        if currentId == allowedId then
            return true
        end
    end
    
    if WindUI and WindUI.Notify then
        WindUI:Notify({
            Title = "服务器不符", 
            Content = "当前ID: " .. currentId, 
            Duration = 3
        })
    end
    return false
end

Tabs.sbcnm:Button({
    Title = "烧烤战斗",
    Callback = function()
        if otherLoaded then
            if WindUI and WindUI.Notify then
                WindUI:Notify({
                    Title = "重复点击！", 
                    Content = "", 
                    Duration = 3
                })
            end
            return
        end
        
        if not CheckServerId() then
            return
        end

        otherLoaded = true

        local TabOther = Window:Tab({
            Title = "主要",
            Icon = "swords",
            Locked = false,
        })

        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local LocalPlayer = Players.LocalPlayer
        local RunService = game:GetService("RunService")

        local killAuraEnabled = false
        local autoEatEnabled = false
        local killAuraConnection = nil

        local function getCharacter()
            return LocalPlayer.Character
        end

        local function getHumanoidRootPart(char)
            if not char then return nil end
            return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
        end

        local function getCameraDirection()
            local cam = workspace.CurrentCamera
            local hrp = getHumanoidRootPart(getCharacter())
            local lookVector = cam and cam.CFrame.LookVector or (hrp and hrp.CFrame.LookVector or Vector3.new(0, 0, -1))
            local flat = Vector3.new(lookVector.X, 0, lookVector.Z)
            return flat.Magnitude < 0.01 and Vector3.new(0, 0, -1) or flat.Unit
        end

        local function getEquippedTool()
            local char = getCharacter()
            if not char then return nil end
            for _, tool in ipairs(char:GetChildren()) do
                if tool:IsA("Tool") then return tool end
            end
            return nil
        end

        local function getEquipmentPart(char)
            if not char then return nil end
            for _, tool in ipairs(char:GetChildren()) do
                if tool:IsA("Tool") then
                    for _, desc in ipairs(tool:GetDescendants()) do
                        if desc:IsA("BasePart") then return desc end
                    end
                end
            end
            local hrp = getHumanoidRootPart(char)
            if hrp then return hrp end
            for _, desc in ipairs(char:GetDescendants()) do
                if desc:IsA("BasePart") then return desc end
            end
            return nil
        end

        local combo = 0
        local lastHitTime = 0
        local lastEatTime = 0

        local function startKillAura()
            if killAuraConnection then return end
            killAuraConnection = RunService.Heartbeat:Connect(function()
                if not killAuraEnabled then return end
                pcall(function()
                    local char = getCharacter()
                    if not char then return end
                    local myHrp = getHumanoidRootPart(char)
                    if not myHrp then return end
                    if char:GetAttribute("SafeZone") then return end

                    local now = os.clock()
                    if now - lastHitTime >= 0.5 then
                        local lookDir = getCameraDirection()
                        local stamp = os.clock()
                        combo = combo + 1
                        pcall(function()
                            ReplicatedStorage.Remotes.Hitreg.SwingInit:FireServer(combo, lookDir)
                        end)
                        for _, player in ipairs(Players:GetPlayers()) do
                            if player ~= LocalPlayer then
                                local enemyChar = player.Character
                                if enemyChar then
                                    local humanoid = enemyChar:FindFirstChildOfClass("Humanoid")
                                    if humanoid and humanoid.Health > 0 then
                                        local part = getEquipmentPart(enemyChar)
                                        if part then
                                            pcall(function()
                                                ReplicatedStorage.Remotes.Hitreg.RegisterHit:FireServer(
                                                    part, stamp, myHrp.CFrame, combo, lookDir
                                                )
                                            end)
                                        end
                                    end
                                end
                            end
                        end
                        lastHitTime = now
                    end

                    if now - lastEatTime >= 2 then
                        local tool = getEquippedTool()
                        if tool then
                            pcall(function()
                                ReplicatedStorage.Remotes.Eat:FireServer(tool)
                            end)
                        end
                        lastEatTime = now
                    end
                end)
            end)
        end

        local function stopKillAura()
            if killAuraConnection then
                killAuraConnection:Disconnect()
                killAuraConnection = nil
            end
        end

        TabOther:Toggle({
            Title = "杀戮光环",
            Desc = "必须拿武器",
            Default = false,
            Callback = function(state)
                killAuraEnabled = state
                if state then
                    startKillAura()
                else
                    stopKillAura()
                end
            end
        })

        TabOther:Toggle({
            Title = "自动吃",
            Desc = "记得拿起武器",
            Default = false,
            Callback = function(state)
                autoEatEnabled = state
                if state then
                    startKillAura()
                else
                    if not killAuraEnabled then
                        stopKillAura()
                    end
                end
            end
        })

        if WindUI and WindUI.Notify then
            WindUI:Notify({
                Title = "烧烤战斗已加载", 
                Content = "", 
                Duration = 3
            })
        end
    end
})

    end)

    reject.MouseButton1Click:Connect(function()
        if not reject.Active then return end
        player:Kick("你玩脚本 你不同意 你玩你妈呢")
    end)
end

ShowDeclaration()