// ARCHOS
// -- sv_servermenu
// ARCHOS

util.AddNetworkString("ARCHOS_F2MENU")
util.AddNetworkString("ARCHOS_F2MENU_ServerInfo_Rcv")
util.AddNetworkString("ARCHOS_F2MENU_ServerInfo_Snd")

ARCHOS.Hook.Add("ShowTeam","SERVERMENU_Open",function(ply)
	net.Start("ARCHOS_F2MENU")
	net.Send(ply)
end)

net.Receive("ARCHOS_F2MENU_ServerInfo_Rcv",function(len,ply)
	net.Start("ARCHOS_F2MENU_ServerInfo_Snd")
	net.WriteFloat(SysTime())
	net.WriteFloat(#ents.GetAll())
	net.WriteFloat(#ents.FindByClass("prop_physics"))
	net.Send(ply)
end)