// ARCHOS
// -- sh_winter
// ARCHOS

ARCHOS.SnowTextures = {}
ARCHOS.SnowTextures = {
"nature/snowfloor001a",
"nature/snowfloor002a",
"nature/snowfloor003a"
}

ARCHOS.GrassTextures = {}
ARCHOS.GrassTextures = {
"maps/gm_genesis_b35/h38org/grass_13_genesis_wvt_patch",
"building_template/roof_template001a",
"gm_construct/flatgrass_2",
"gm_construct/flatgrass",
}

ARCHOS.BlendGrassTextures = {}
ARCHOS.BlendGrassTextures = {
"h38org/grass-sand_13_genesis"
}

ARCHOS.BlendSnowToGrassTextures = {}
ARCHOS.BlendSnowToGrassTextures = {
"h38org/grass-sand_13_genesis"
}

if SERVER then

	util.AddNetworkString("ARCHOS_Winter_Textures")
	util.AddNetworkString("ARCHOS_Winter_Textures_Joined")
	ARCHOS.IsSnowing = false
	
	net.Receive("ARCHOS_Winter_Textures_Joined",function(len,ply)
		if ARCHOS.IsSnowing then
			net.Start("ARCHOS_Winter_Textures")
			net.Send(ply)
		end
	end)

	function ARCHOS.StartSnowing()
		ARCHOS.IsSnowing = true
		hook.Call("ARCHOS_SnowChanged")
		
		net.Start("ARCHOS_Winter_Textures")
			net.WriteBool(true)
		net.Broadcast()
		ARCHOS.ChangeGrassToSnow()
		game.ConsoleCommand( "atmos_startsnow\n" )
	end

	concommand.Add("archos_enablesnow",function(ply,cmd,args)
		if ply:IsAdmin() or ply:IsSuperAdmin() then
			ARCHOS.StartSnowing()
		end
	end)
	
	function ARCHOS.ChangeGrassToSnow()
		ARCHOS.FogEntity = ents.Create("edit_fog")
		ARCHOS.FogEntity:SetPos(Vector(0,0,0))
		ARCHOS.FogEntity:SetNoDraw(true)
		ARCHOS.FogEntity:Spawn()
		
	
		for k,v in pairs(ARCHOS.GrassTextures) do
			Material(v):SetTexture( "$basetexture", ARCHOS.SnowTextures[2] )
			Material(v):SetUndefined( "$surfaceprop" )
			Material(v):SetString( "$surfaceprop", "snow" )
			Material(v):Recompute()
		end
			
		for k,v in pairs(ARCHOS.BlendGrassTextures) do
			Material(v):SetTexture( "$basetexture", ARCHOS.SnowTextures[2] )
			Material(v):SetTexture( "$basetexture2", ARCHOS.SnowTextures[3] )
			Material(v):SetUndefined( "$surfaceprop" )
			Material(v):SetString( "$surfaceprop", "snow" )
			Material(v):Recompute()
		end
	end
end

if CLIENT then

	net.Receive("ARCHOS_Winter_Textures",function()
		ARCHOS.ChangeGrassToSnow()
	end)

	hook.Add("InitPostEntity","ARCHOS_Winter_Grass2Snow",function()
		net.Start( "ARCHOS_Winter_Textures_Joined" )
		net.SendToServer()
	end)
	
	function ARCHOS.ChangeGrassToSnow()
		render.RedownloadAllLightmaps(false)
		
		hook.Add("PlayerFootstep","ARCHOS_Winter_Footsteps",function(ply,pos,foot,sound,volume)
			local tr = util.TraceLine( {
				start = LocalPlayer():GetPos(),
				endpos = LocalPlayer():GetPos()+Vector(0,0,-20),
			} )
			
			if(table.HasValue(ARCHOS.GrassTextures,tr.HitTexture)) then
				ply:EmitSound( "player/footsteps/snow"..math.random(1,6)..".wav" )
				return true
				
			elseif(tr.HitTexture == "**displacement**") then
				ply:EmitSound( "player/footsteps/snow"..math.random(1,6)..".wav" )
				return true
			end
		end)
	
		for k,v in pairs(ARCHOS.GrassTextures) do
			Material(v):SetTexture( "$basetexture", ARCHOS.SnowTextures[2] )
			Material(v):Recompute()
		end
			
		for k,v in pairs(ARCHOS.BlendGrassTextures) do
			Material(v):SetTexture( "$basetexture", ARCHOS.SnowTextures[2] )
			Material(v):SetTexture( "$basetexture2", ARCHOS.SnowTextures[3] )
			Material(v):Recompute()
		end
	end
end