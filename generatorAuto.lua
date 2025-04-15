for i, v in ipairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
  if v.Name == "Generator" then
    if v.Progress.Value ~= 4 then
      local left = true
      local right = true
      local center = true
      local available = 0
      for index, value in ipairs(game.Players:GetChildren()) do
          if value.Character.HumanoidRootPart.CFrame == v.Positions.Left.CFrame then
              available +=1
              left = false
          end
          if value.Character.HumanoidRootPart.CFrame == v.Positions.Right.CFrame then
              available +=1
              right = false
          end
          if value.Character.HumanoidRootPart.CFrame == v.Positions.Center.CFrame then
              available +=1
              center = false
          end
      end
      if available < 3 then
          local positiontoUse
          if left == true then
              positiontoUse = "Left"
          elseif right == true then
              positiontoUse = "Right"
          elseif center == true then
              positiontoUse = "Center"
          end
          if positiontoUse then
          game.Players.LocalPlayer.Character.PrimaryPart.CFrame = v.Positions[positiontoUse].CFrame
          wait(0.2)
          v.Remotes.RF:InvokeServer("enter")
          for i = 1, 4 do
               -- if v.Progress.Value < 4 then
                print(v.Progress.Value)
                wait(1.5)
                v.Remotes.RE:FireServer()
               -- end
          end
          wait(0.2)
                v.Remotes.RF:InvokeServer("leave")
        end
      end
    end
  end
end
