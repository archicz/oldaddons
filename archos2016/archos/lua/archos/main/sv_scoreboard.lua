// ARCHOS
// -- sv_scoreboard
// ARCHOS

util.AddNetworkString("ARCHOS_Scoreboard_AddXP")
util.AddNetworkString("ARCHOS_Scoreboard_TakeXP")
util.AddNetworkString("ARCHOS_Scoreboard_SetLevel")
util.AddNetworkString("ARCHOS_Scoreboard_SetXP")
util.AddNetworkString("ARCHOS_Scoreboard_FixDB")

net.Receive("ARCHOS_Scoreboard_AddXP",function(len,ply)
	local pl = net.ReadEntity()
	local xps = net.ReadFloat()
	
	if ply:IsAdmin() or ply:IsSuperAdmin() then
		if pl == ply then
			ARCHOS.LevelingSystem.AddXps(ply,xps)
		else
			ARCHOS.LevelingSystem.AddXps(pl,xps)
		end
	end
end)

net.Receive("ARCHOS_Scoreboard_TakeXP",function(len,ply)
	local pl = net.ReadEntity()
	local xps = net.ReadFloat()
	
	if ply:IsAdmin() or ply:IsSuperAdmin() then
		if pl == ply then
			ARCHOS.LevelingSystem.TakeXps(ply,xps)
		else
			ARCHOS.LevelingSystem.TakeXps(pl,xps)
		end
	end
end)

net.Receive("ARCHOS_Scoreboard_SetLevel",function(len,ply)
	local pl = net.ReadEntity()
	local level = net.ReadFloat()
	
	if ply:IsAdmin() or ply:IsSuperAdmin() then
		if pl == ply then
			ARCHOS.LevelingSystem.SetLevel(ply,level)
		else
			ARCHOS.LevelingSystem.SetLevel(pl,level)
		end
	end
end)

net.Receive("ARCHOS_Scoreboard_SetXP",function(len,ply)
	local pl = net.ReadEntity()
	local xps = net.ReadFloat()
	
	if ply:IsAdmin() or ply:IsSuperAdmin() then
		if pl == ply then
			ARCHOS.LevelingSystem.SetXps(ply,xps)
		else
			ARCHOS.LevelingSystem.SetXps(pl,xps)
		end
	end
end)

net.Receive("ARCHOS_Scoreboard_FixDB",function(len,ply)
	local pl = net.ReadEntity()
	
	if ply:IsAdmin() or ply:IsSuperAdmin() then
		if pl == ply then
			ARCHOS.LevelingSystem.AddUser(ply)
		else
			ARCHOS.LevelingSystem.AddUser(pl)
		end
	end
end)