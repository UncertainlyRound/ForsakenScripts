local oldassets = require(game.ReplicatedStorage.Assets.Skins.Killers.c00lkidd.MafiasoC00l.Config)
game.ReplicatedStorage.Assets.Skins.Killers.c00lkidd.MafiasoC00l.Config:Destroy() game.ReplicatedStorage.Assets.Skins.Killers.c00lkidd.MafiosoC00l.Config:Clone().Parent = game.ReplicatedStorage.Assets.Skins.Killers.c00lkidd.MafiasoC00l
game.ReplicatedStorage.Assets.Skins.Killers.c00lkidd.MafiasoC00l.Behavior:Destroy() game.ReplicatedStorage.Assets.Skins.Killers.c00lkidd.MafiosoC00l.Behavior:Clone().Parent = game.ReplicatedStorage.Assets.Skins.Killers.c00lkidd.MafiasoC00l
local rigsource = game:GetObjects("rbxassetid://114748682440378")[1]
rigsource.Parent = game.ReplicatedStorage
local emoteTrack
local emoteSound1
local emoteSound2
local emoting = false
local assets = require(game.ReplicatedStorage.Assets.Skins.Killers.c00lkidd.MafiosoC00l.Config)
local minions = assets.Mafiasos
local emoteButton

function GetDescendants(tbl)
    local currentTbl = {}
    for i, v in pairs(tbl) do
        if type(v) == "table" then
            for ind, val in pairs(GetDescendants(v)) do
                table.insert(currentTbl, val)
            end
        else
            table.insert(currentTbl, v)
        end
    end
    return currentTbl
end

game:GetService("UserInputService").InputBegan:Connect(function(input)
if input.KeyCode == Enum.KeyCode.G then
emoting = false
if emoteTrack then
	emoteTrack:Stop()
	emoteSound1:Stop()
	emoteSound2:Stop()
end
end
end)

function setup()
	rig = rigsource:Clone()
	rig.Parent = workspace
	parttable = {}
	for i, v in ipairs(rig:GetChildren()) do
		if v:IsA("BasePart") then
			if v.Name ~= "HumanoidRootPart" then
				table.insert(parttable, {["Original"] = game.Players.LocalPlayer.Character:FindFirstChild(v.Name), ["new"] = v})
			end
		end
	end
	game.Players.LocalPlayer.Character["Left Arm"].WalkieTalkie.Part0 = game.Players.LocalPlayer.Character["Right Arm"]
	for i, v in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
		if v:IsA("BasePart") then
			if v.Name ~= "firebrand" and v.Name ~= "WalkieTalkie" then
					v.Transparency = 1
					v.Changed:Connect(function(str)
						if str == "Transparency" then
							v.Transparency = 1
						end
					end)
				end
		end
	end
	for i, v in ipairs(parttable) do
		local weld = Instance.new("Weld")
		weld.Parent = v["new"]
		weld.Part0 = v["new"]
		weld.Part1 = v["Original"]
	end
	local connection = game.Players.LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(v)
		if active then
			if v:IsA("Sound") and table.find(GetDescendants(assets.Voicelines), v.SoundId)  then
				v:Destroy()
			end
		else
			connection:Disconnect()
		end
	end)
	game.Players.LocalPlayer.Character.Changed:Connect(function(str)
		if str == "Parent" then
			rig:Destroy()
		end
	end)
	game.Players.LocalPlayer.Character.Humanoid.AnimationPlayed:Connect(function(track)
		if track.Animation.AnimationId == "rbxassetid://80139543732416" then
				local anim = Instance.new("Animation") anim.AnimationId = "rbxassetid://117334224937914"
				local Track = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(anim)
				Track.Priority = Enum.AnimationPriority.Action4
				Track:Play()
				Track:AdjustSpeed(Track.Length/3.875)
		end
	end)
end

function playSound(SoundId, Volume, Parent, Loop)
local sound = Instance.new("Sound", Parent)
sound.SoundId = SoundId
sound.Volume = Volume
sound.Looped = Loop
sound:Play()
return sound
end

game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
	if char.Name == "c00lkidd" and game.Players.LocalPlayer.PlayerData.Equipped.Skins.c00lkidd.Value == "MafiasoC00l" then
		print("activated")
		active = true
		task.spawn(setup)
	else
		print("unactivated")
		active = false
	end
wait(0.1)
for i, v in ipairs(game.Players.LocalPlayer.PlayerGui.TopbarStandard.Holders.Left:GetChildren()) do
	if v.Name == "Widget" then
		if v.IconButton.Menu.IconSpot.Contents.IconLabelContainer.IconLabel.Text == "Emote" then
			emoteButton = v.IconButton.Menu.IconSpot.ClickRegion
			print(v.IconButton.Menu.IconSpot.Contents.IconLabelContainer.IconLabel.Text)
		else
			print(v.IconButton.Menu.IconSpot.Contents.IconLabelContainer.IconLabel.Text)
		end
	else
		print(v.Name)
	end
end

if emoteButton then
emoteButton.MouseButton1Down:Connect(function()
emoting = false
if emoteTrack then
	emoteTrack:Stop()
	emoteSound1:Stop()
	emoteSound2:Stop()
end
end)
end
end)

local hook;
hook = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
       local args = {...}
       if self == game.ReplicatedStorage.Modules.Network.RemoteEvent then
       	if not checkcaller() and getnamecallmethod() == "FireServer" or getnamecallmethod() == "InvokeServer"  then
            	if args[3] == "Snap" then
            		if args[1] == "PlayEmote" then
            			emoting = true
            			local anim = Instance.new("Animation") anim.AnimationId = assets.Emotes.Animations.Snap.AssetID
            			emoteTrack = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(anim)
            			emoteTrack.Looped = true
            			emoteTrack.Priority = Enum.AnimationPriority.Action4
            			emoteTrack:Play()
            			emoteSound1 = playSound(assets.Emotes.Animations.Snap.SFX[1], 0.5, game.Players.LocalPlayer.Character.PrimaryPart, true)
            			emoteSound2 = playSound(assets.Emotes.Animations.Snap.SFX[2], 0.5, game.Players.LocalPlayer.Character.PrimaryPart, true)
            			repeat
            				task.wait()
            				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 6
            			until emoting == false or game.Players.LocalPlayer.Character.Parent == nil
            			emoting = false
            		end
            	end
       	end
       end
       return hook(self, ...)
end))

game:GetService("UserInputService").InputBegan:Connect(function(input)
if input.KeyCode == Enum.KeyCode.G then
emoting = false
if emoteTrack then
	emoteTrack:Stop()
	emoteSound1:Stop()
	emoteSound2:Stop()
end
end
end)

workspace.Map.Ingame.ChildAdded:Connect(function(v)
	if active then
		if string.find(v.Name, "Mafiaso") then
			local died = false
			local minion = minions[math.random(1, 4)]
			minion = minion:Clone()
			minion.Parent = workspace
			for i, val in ipairs(v:GetDescendants()) do
				if val:IsA("BasePart") then
					val.Transparency = 1
					val.Changed:Connect(function(str)
						if str == "Transparency" then
							local trans = val.Transparency
							for index, value in ipairs(minion:GetDescendants()) do
								if value:IsA("BasePart") then
									if value.Transparency < 1 then
									value.Transparency = trans
									end
								end
							end
							val.Transparency = 1
						end
					end)
				elseif val:IsA("Decal") then
					val.Transparency = 1
				elseif val:IsA("SelectionBox") then
					if minion:FindFirstChild(val.Parent.Name) then
						val.Adornee = minion:FindFirstChild(val.Parent.Name)
					end
				end
			end
			v.DescendantAdded:Connect(function(val)
				if val:IsA("BasePart") then
					val.Transparency = 1
					val.Changed:Connect(function(str)
						if str == "Transparency" then
							local trans = val.Transparency
							for index, value in ipairs(minion:GetDescendants()) do
								if value:IsA("BasePart") then
								if value.Transparency < 1 then
									value.Transparency = trans
								end
								end
							end
							val.Transparency = 1
						end
					end)
				elseif val:IsA("Decal") then
					val.Transparency = 1
				elseif val:IsA("SelectionBox") then
					if minion:FindFirstChild(val.Parent.Name) then
						val.Adornee = minion:FindFirstChild(val.Parent.Name)
					end
				end
			end)
			task.spawn(function()
				repeat
					task.wait()
					if v.Parent ~= nil then
						minion.HumanoidRootPart.CFrame = v.PrimaryPart.CFrame
					end
				until v.Parent == nil
				minion:Destroy()
			end)
			v:WaitForChild("Humanoid")
			local idleanim = Instance.new("Animation")
			idleanim.AnimationId = assets.PizzaDeliveryAnimations.Idle
			idleanim = minion.Humanoid.Animator:LoadAnimation(idleanim)
			idleanim.Looped = true
			local runanim = Instance.new("Animation")
			runanim.AnimationId = assets.PizzaDeliveryAnimations.Walk
			runanim = minion.Humanoid.Animator:LoadAnimation(runanim)
			runanim.Looped = true
			v:FindFirstChildOfClass("Humanoid").AnimationPlayed:Connect(function(track)
				if track.Animation.AnimationId == oldassets.PizzaDeliveryAnimations.Hit then
					local anim = Instance.new("Animation")
					anim.AnimationId = assets.PizzaDeliveryAnimations.Hit
					anim = minion.Humanoid.Animator:LoadAnimation(anim)
					runanim:Stop()
					anim:Play()
				end
			end)
			local introanim = Instance.new("Animation")
			introanim.AnimationId = assets.PizzaDeliveryAnimations.Summoned
			introanim = minion.Humanoid.Animator:LoadAnimation(introanim)
			introanim:Play()
			introanim.Stopped:Wait()
			idleanim:Play()
			v:FindFirstChildOfClass("Humanoid").AnimationPlayed:Wait()
			idleanim:Stop()
			runanim:Play()			
		elseif v.Name == "Bunny" then
			v:WaitForChild("Head").Transparency = 1
			v.Head:WaitForChild("Classic Default Face").Transparency = 1
			v:WaitForChild("Torso").Transparency = 1
			v:WaitForChild("Wedge").Transparency =1
			local suitcase = game.ReplicatedStorage.Assets.Instances.SuitcaseBase:Clone()
			suitcase.Anchored = false
			suitcase.Massless = true
			suitcase.Parent = v
			local weld = Instance.new("Weld")
			weld.Parent = suitcase
			weld.Part0 = suitcase
			weld.Part1 = v.Torso
		end
	end
end)
