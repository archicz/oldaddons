// ARCHOS
// -- sh_pvpscript
// ARCHOS

ARCHOS.PVP = {}

if SERVER then

util.AddNetworkString("ARCHOS_PVP_TurnOn")
util.AddNetworkString("ARCHOS_PVP_HasNotEnabled")
util.AddNetworkString("ARCHOS_PVP_On")
util.AddNetworkString("ARCHOS_PVP_Off")

concommand.Add("archos_pvp_on",function(ply,cmd,args)
	ARCHOS.PVP.On(ply)
end)
  
concommand.Add("archos_pvp_off",function(ply,cmd,args)
	ARCHOS.PVP.Off(ply)
end)

function ARCHOS.PVP.Off(ply)   
	net.Start("ARCHOS_PVP_Off")
	net.Send(ply)
	ply:GodEnable()  
	ply:StripWeapons()  
	ply:SetArmor(100)
	ply:SetHealth(100)
	ply:Give("weapon_crowbar")  
	ply:Give("weapon_physgun")  
	ply:Give("weapon_physcannon")  
	ply:Give("gmod_tool")  
	ply:Give("gmod_camera") 
	ply.pvp = false 
end  

function ARCHOS.PVP.On(ply)
	net.Start("ARCHOS_PVP_On")
	net.Send(ply)
	ply:GodDisable() 
	ply:SetArmor(100)
	ply:SetHealth(100)	
	ply:Give("weapon_357")     
	ply:Give("weapon_ar2")  
	ply:Give("weapon_crossbow")  
	ply:Give("weapon_crowbar")  
	ply:Give("weapon_frag")  
	ply:Give("weapon_physcannon")  
	ply:Give("weapon_pistol")  
	ply:Give("weapon_rpg")  
	ply:Give("weapon_shotgun")  
	ply:Give("weapon_smg1")  
	ply:Give("weapon_stunstick")  
	ply.pvp = true  
end  
  
hook.Add("PlayerLoadout","ARCHOS_PVP_Loadout",function(ply)  
	if ply.pvp then  
		ply:SetArmor(100)
		ply:SetHealth(100)	
		ply:Give("weapon_357")    
		ply:Give("weapon_ar2")    
		ply:Give("weapon_crossbow")  
		ply:Give("weapon_crowbar")  
		ply:Give("weapon_frag")  
		ply:Give("weapon_physcannon")  
		ply:Give("weapon_pistol")  
		ply:Give("weapon_rpg")  
		ply:Give("weapon_shotgun")  
		ply:Give("weapon_smg1")  
		ply:Give("weapon_stunstick")  
	else 
		ply:GodEnable()  
		ply:SetArmor(100)
		ply:SetHealth(100)	
		ply:Give("weapon_crowbar")  
		ply:Give("weapon_physgun")  
		ply:Give("weapon_physcannon")  
		ply:Give("gmod_tool")  
		ply:Give("gmod_camera") 
		return true  
	end  
end)

hook.Add("PlayerShouldTakeDamage","ARCHOS_PVP_Damage",function(victim,attacker)
	if victim.pvp == false then
		net.Start("ARCHOS_PVP_HasNotEnabled")
		net.WriteString(victim:Nick())
		net.Send(attacker)
		return false
	elseif attacker.pvp == false then
		net.Start("ARCHOS_PVP_TurnOn")
		net.Send(attacker)
		return false
	else
		return true
	end
end)


hook.Add("PlayerInitialSpawn","ARCHOS_PVP_Spawn",function(ply)
	ply.pvp = true
	ply:GodDisable() 
end)

end

if CLIENT then

	net.Receive("ARCHOS_PVP_TurnOn",function()
		chat.AddText(Color(0,255,255),"[ArchOS] ",Color(255,255,255),ARCHOS.CurrentLanguage["pvp_turnon"])
	end)
	
	net.Receive("ARCHOS_PVP_HasNotEnabled",function()
		local nick = net.ReadString()
		chat.AddText(Color(0,255,255),"[ArchOS] ",Color(255,255,255),nick..ARCHOS.CurrentLanguage["pvp_hasnotenabled"])
	end)
	
	net.Receive("ARCHOS_PVP_On",function()
		chat.AddText(Color(0,255,255),"[ArchOS] ",Color(255,255,255),ARCHOS.CurrentLanguage["pvp_pvpon"])
	end)
	
	net.Receive("ARCHOS_PVP_Off",function()
		chat.AddText(Color(0,255,255),"[ArchOS] ",Color(255,255,255),ARCHOS.CurrentLanguage["pvp_pvpoff"])
	end)

end