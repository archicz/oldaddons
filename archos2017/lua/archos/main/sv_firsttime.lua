// ARCHOS
// -- sv_firsttime
// ARCHOS

util.AddNetworkString("ARCHOS_Language_Joined")
util.AddNetworkString("ARCHOS_Language_OpenMenu")
util.AddNetworkString("ARCHOS_Language_Load")

net.Receive("ARCHOS_Language_Joined",function(len,ply)
	if(ply:GetPData("archos_firsttime",false) == false) then
		net.Start( "ARCHOS_Language_OpenMenu" )
		net.Send(ply)
		ply:SetPData("archos_firsttime",true)
	else
		net.Start( "ARCHOS_Language_Load" )
		net.Send(ply)
	end
end)