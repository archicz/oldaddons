// ARCHOS
// -- cl_countrycheck
// ARCHOS
gameevent.Listen("player_disconnect")

ARCHOS.Hook.Add("player_disconnect", "Disconnect_Message", function(data)
	if not ARCHOS.CurrentLanguage then return end
	chat.AddText(Color(255,255,255), ARCHOS.CurrentLanguage["player"], Color(255,0,0), data.name, Color(128,128,128), " (" .. data.networkid	.. ") ", Color(255,255,255), " "..ARCHOS.CurrentLanguage["disconnected"].." ", Color(32,146,253),data.reason)
	surface.PlaySound( "npc/turret_floor/click1.wav" )
end)

ARCHOS.Hook.Add("InitPostEntity","Loaded_Hook",function()
	net.Start( "ARCHOS_Loaded_Hook" )
	net.SendToServer()
end)

usermessage.Hook("ArchOS_Connect_Message",function(data)
	if not ARCHOS.CurrentLanguage then return end
	name = data:ReadString()
	steamid = data:ReadString()
	ip = data:ReadString()
	bot = data:ReadBool()
	
	ip2 = string.Explode(":",ip)

	http.Fetch( "http://freegeoip.net/json/"..ip2[1],
		function( body, len, headers, code )
			json = util.JSONToTable( body )
			if ip == "none" then
				chat.AddText(Color(255,255,255), ARCHOS.CurrentLanguage["player"], Color(0,255,0), name, Color(128,128,128), " (" .. steamid	.. ") ", Color(255,255,255), " "..ARCHOS.CurrentLanguage["isconnecting"]..".")
			else
				chat.AddText(Color(255,255,255), ARCHOS.CurrentLanguage["player"], Color(0,255,0), name, Color(128,128,128), " (" .. steamid	.. ") ", Color(255,255,255), " "..ARCHOS.CurrentLanguage["isconnecting"].." ", Color(32,146,253),"( "..json["country_name"].." "..json["region_name"].." ).")
			end
		end
	)
	
	surface.PlaySound( "npc/turret_floor/ping.wav" )
end)

usermessage.Hook("ArchOS_NotEnoughHours",function(data)
	if not ARCHOS.CurrentLanguage then return end
	name = data:ReadString()
	steamid = data:ReadString()
	hrs = data:ReadFloat()

	chat.AddText(Color(255,255,255), ARCHOS.CurrentLanguage["player"], Color(0,255,0), name, Color(128,128,128), " (" .. steamid	.. ") ", Color(255,255,255), " "..ARCHOS.CurrentLanguage["notenoughhours"].."("..hrs.."/"..ARCHOS.PlayTime.Limit..").")

	surface.PlaySound( "npc/turret_floor/active.wav" )
end)

usermessage.Hook("ArchOS_InGame_Message",function(data)
	if not ARCHOS.CurrentLanguage then return end
	name = data:ReadString()
	steamid = data:ReadString()

	chat.AddText(Color(255,255,255), ARCHOS.CurrentLanguage["player"], Color(0,255,0), name, Color(128,128,128), " (" .. steamid	.. ") ", Color(255,255,255), " "..ARCHOS.CurrentLanguage["hasspawned"]..".")

	surface.PlaySound( "weapons/ar2/ar2_reload_rotate.wav" )
end)

usermessage.Hook("ArchOS_Loaded_Message",function(data)
	if not ARCHOS.CurrentLanguage then return end
	name = data:ReadString()
	steamid = data:ReadString()

	chat.AddText(Color(255,255,255), ARCHOS.CurrentLanguage["player"], Color(0,255,0), name, Color(128,128,128), " (" .. steamid	.. ") ", Color(255,255,255), " "..ARCHOS.CurrentLanguage["nasloaded"]..".")

	surface.PlaySound( "ambient/levels/canals/windchime2.wav" )
end)