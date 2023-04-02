function BypassAntiCheat()
	local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
	local functions = Network.Fire, Network.Invoke
	local old 
	old = hookfunction(getupvalue(functions, 1) , function(...) return true end)
	
	local Blunder = require(game:GetService("ReplicatedStorage"):FindFirstChild("BlunderList", true))
	local OldGet = Blunder.getAndClear

	setreadonly(Blunder, false)

	local function OutputData(Message)
		return Message
	end

	Blunder.getAndClear = function(...)
		local Packet = ...
		for i,v in next, Packet.list do
			if v.message ~= "PING" then
				OutputData(v.message)
				table.remove(Packet.list, i)
			end
		end
		return OldGet(Packet)
	end
	local Audio = require(game:GetService("ReplicatedStorage").Library.Audio)
	local old1 = hookfunction(Audio.Play, function(sound, ...)
		return {
			Play = function()
				print("Fake sound played")
			end,
			Stop = function()
				print("Fake sound stopped")
			end,
			IsPlaying = function()
				return false
			end
		}
	end)
	print("Hooked Functions")
end

BypassAntiCheat()
