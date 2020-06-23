// ARCHOS
// -- sv_countrycheck
// ARCHOS

util.AddNetworkString( "ARCHOS_Loaded_Hook" )

net.Receive("ARCHOS_Loaded_Hook",function(len,ply)
	umsg.Start("ArchOS_Loaded_Message")
	umsg.String(ply:Nick())
	umsg.String(ply:SteamID())
	umsg.End()
end)

hook.Add("PlayerInitialSpawn","ARCHOS_Spawn_Message",function(ply)
	umsg.Start("ArchOS_InGame_Message")
	umsg.String(ply:Nick())
	umsg.String(ply:SteamID())
	umsg.End()
end)

gameevent.Listen("player_connect")

hook.Add("player_connect","ARCHOS_Connect_Message_SV",function(data)
	name = data.name
	steamid = data.networkid
	ip = data.address	
	bot = data.bot
	
	ip2 = string.Explode(":",ip)
	
	umsg.Start("ArchOS_Connect_Message")
	umsg.String(name)
	umsg.String(steamid)
	umsg.String(ip)
	umsg.Bool(bot)
	umsg.End()

end)