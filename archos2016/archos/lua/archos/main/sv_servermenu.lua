// ARCHOS
// -- sh_servermenu
// ARCHOS
util.AddNetworkString("ARCHOS_F2MENU")

hook.Add("ShowTeam","ARCHOS_SERVERMENU",function(ply)
	net.Start( "ARCHOS_F2MENU" )
	net.Send(ply)
end)