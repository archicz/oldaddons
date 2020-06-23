if SERVER then
	util.AddNetworkString("ARCHOS_Announce")
	
	concommand.Add("archos_announce",function(ply,cmd,args)
		if !ply:IsSuperAdmin() then return end
		local voxline = table.concat(args, " ")
		net.Start( "ARCHOS_Announce" )
			net.WriteString(voxline)
		net.Broadcast()
	end)
end

if CLIENT then
	net.Receive("ARCHOS_Announce", function(length)
		local str = net.ReadString()
		
		local sl = string.lower
		local path = "vox/"
		local time = 0
		local emitEntity = LocalPlayer()
		local table = string.Explode( " ", str )
		for k, v in ipairs( table ) do
			v = sl(v)
			local sndDir = path .. v .. ".wav"
			if (string.Left( v, 1 ) == "!") then
				v = string.sub(v, 2)
				local command = string.Explode( "=", v )
				if commands[command[1]] then
					time = commands[command[1]](time, command[2], entity)
				end
			else
				if (k != 1) then
					time = time + SoundDuration(sndDir) + .1
				end
				timer.Simple( time, function()
					surface.PlaySound(sndDir)
				end)
			end
		end
	end)
end