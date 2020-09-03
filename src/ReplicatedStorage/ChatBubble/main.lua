local ReplicatedStorage = game:GetService("ReplicatedStorage")
local chatEvents = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
local messageEvent = chatEvents:WaitForChild("OnNewMessage")

local Players = game:GetService("Players")
local player = Players.LocalPlayer

function typewrite(instance, text, delay)
    for i = 1, #text do
        instance.Text = text:sub(1, i)
        wait(delay)
    end
end

function run()
    local Bubbles = Instance.new("Folder")
    Bubbles.Name = "ChatBubbles"
    Bubbles.Parent = player.PlayerGui

    messageEvent.OnClientEvent:Connect(function(message)
        local player = Players:FindFirstChild(message.FromSpeaker)
        if player then
            local character = player.Character
            if character then
                local head = character:FindFirstChild("Head")
                if head then
                    local Bubble = Instance.new("BillboardGui")
                    Bubble.Name = "Bubble"
                    Bubble.Adornee = head
                    Bubble.StudsOffset = Vector3.new(0, 2, 0)
                    Bubble.Size = UDim2.new(10, 0, 1.5, 0)
                    Bubble.Parent = Bubbles

                    local Text = Instance.new("TextLabel")
                    Text.Text = ""
                    Text.Size = UDim2.new(1, 0, 1, 0)
                    Text.BackgroundTransparency = 1
                    Text.TextScaled = true
                    Text.Font = Enum.Font.Arcade
                    Text.Parent = Bubble

                    typewrite(Text, message.Message)

                    wait(5)

                    Bubble:Destroy()
                end
            end
        end
    end)
end

return run