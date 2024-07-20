
function farmold(trying, important)
        api.humanoid():MoveTo(trying.Position)
    repeat task.wait() until (trying.Position - api.humanoidrootpart().Position).magnitude <= 4 or not IsToken(trying) or not temptable.running
end

function gettoken(v3, farmclosest)
    if not v3 then v3 = fieldposition end
    task.wait()
    if farmclosest then
        for i=0,10 do
            local closesttoken = {}
            for e, r in next, game.Workspace.Collectibles:GetChildren() do
                if r:FindFirstChild("farmed") then continue end
                itb = false
                if r:FindFirstChildOfClass("Decal") and bongkoc.toggles.enabletokenblacklisting then
                    if api.findvalue(bongkoc.bltokens, string.split(r:FindFirstChildOfClass("Decal").Texture, "rbxassetid://")[2]) then
                        itb = true
                    end
                end
                if not itb and findField(r.Position) == findField(api.humanoidrootpart().Position) then
                    if closesttoken.Distance then
                        if (r.Position - api.humanoidrootpart().Position).magnitude < closesttoken.Distance then
                            closesttoken = {Token = r, Distance = (r.Position - api.humanoidrootpart().Position).magnitude}
                        end
                    else
                        closesttoken = {Token = r, Distance = (r.Position - api.humanoidrootpart().Position).magnitude}
                    end
                end
            end
            if closesttoken.Token then
                farm(closesttoken.Token)
                local farmed = Instance.new("BoolValue", closesttoken.Token)
                farmed.Name = "farmed"
                task.spawn(function()
                    task.wait(0.95)
                    if closesttoken.Token and closesttoken.Token.Parent then
                        farmed.Parent = nil
                    end
                end)
            end
        end
    else
        for e, r in next, game.Workspace.Collectibles:GetChildren() do
            itb = false
            if r:FindFirstChildOfClass("Decal") and bongkoc.toggles.enabletokenblacklisting then
                if api.findvalue(bongkoc.bltokens, string.split(r:FindFirstChildOfClass("Decal").Texture, "rbxassetid://")[2]) then
                    itb = true
                end
            end
            if tonumber((r.Position - api.humanoidrootpart().Position).magnitude) <= temptable.magnitude / 1.4 and not itb and (v3 - r.Position).magnitude <= temptable.magnitude then
                farm(r)
            end
        end
    end
end

function converthoney()
    task.wait(0)
    if temptable.converting and not temptable.planting then
        if player.PlayerGui.ScreenGui.ActivateButton.TextBox.Text ~= "Stop Making Honey" and player.PlayerGui.ScreenGui.ActivateButton.BackgroundColor3 ~= Color3.new(201, 39, 28) or (player.SpawnPos.Value.Position - api.humanoidrootpart().Position).magnitude > 13 then
            api.tween(2, player.SpawnPos.Value * CFrame.fromEulerAnglesXYZ(0, 110, 0) + Vector3.new(0, 0, 3))
            task.wait(0.9)
            if player.PlayerGui.ScreenGui.ActivateButton.TextBox.Text ~= "Stop Making Honey" and player.PlayerGui.ScreenGui.ActivateButton.BackgroundColor3 ~= Color3.new(201, 39, 28) or (player.SpawnPos.Value.Position - api.humanoidrootpart().Position).magnitude > 13 then
                game:GetService("ReplicatedStorage").Events.PlayerHiveCommand:FireServer("ToggleHoneyMaking")
            end
            task.wait(0.1)
        end
    end
end
