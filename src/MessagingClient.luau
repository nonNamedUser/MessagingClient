export type MessagingClient={
	Publish: (self: MessagingClient, topic:string, message: any) -> (),
	Subscribe: (self: MessagingClient, topic:string, callback: (message: any) -> ()) -> ()
} 

--[[
--   _   _ ____    _    ____ _____ 
--  | | | / ___|  / \  / ___| ____|
--  | | | \___ \ / _ \| |  _|  _|  
--  | |_| |___) / ___ \ |_| | |___ 
--   \___/|____/_/   \_\____|_____|
--                                 

-------------------------------------------------------------

Publish:

local MessagingClient=require(path.MessagingClient)

local TOPIC="Example"

MessagingClient.Publish(TOPIC, "Example")

-------------------------------------------------------------

Subscribe:

local MessagingClient=require(path.MessagingClient)

local TOPIC="Example"

MessagingClient.Subscribe(TOPIC, function()
	
end)
]]

local MessagingService = game:GetService("MessagingService")

local MessagingClient = {}

function MessagingClient:Publish(topic, message)
	local success, err = pcall(function()
		MessagingService:PublishAsync(topic, message)
	end)

	if not success then
		warn("Failed to publish message to topic ["..topic.."]: "..err)
	end
end


function MessagingClient:Subscribe(topic, callback)
	local success, err = pcall(function()
		MessagingService:SubscribeAsync(topic, function(message)
			callback(message.Data)
		end)
	end)

	if not success then
		warn("Failed to subscribe to topic ["..topic .."]: "..err)
	end
end

return MessagingClient
