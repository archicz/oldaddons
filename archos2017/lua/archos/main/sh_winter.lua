// ARCHOS
// -- sh_winter
// ARCHOS

ARCHOS.IsWinter = false -- Přepíná sníh

if not ARCHOS.IsWinter then return end

ARCHOS.SnowTextures = {}
ARCHOS.SnowTextures = {
"nature/snowfloor001a",
"nature/snowfloor002a",
"nature/snowfloor003a"
}

ARCHOS.GrassTextures = {}
ARCHOS.GrassTextures = {
"gm_construct/grass_13",
"gm_construct/grass",
"building_template/roof_template001a",
"maps/gm_construct_flatgrass_v6-2/gm_construct/grass_13_wvt_patch",
"carconstruct/grass/grass01"
}

ARCHOS.BlendGrassTextures = {}
ARCHOS.BlendGrassTextures = {
"gm_construct/grass-sand_13",
"carconstruct/grass/grass-sand_blend01",
"carconstruct/grass/grass01",
"nature/blendsandsand008b"
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
			Material(v):SetUndefined( "$surfaceprop" )
			Material(v):SetString( "$surfaceprop", "snow" )
			Material(v):Recompute()
		end
	end
	
	ARCHOS.StartSnowing()
end

if CLIENT then

	net.Receive("ARCHOS_Winter_Textures",function()
		ARCHOS.ChangeGrassToSnow()
	end)

	ARCHOS.Hook.Add("InitPostEntity","Winter_Grass2Snow",function()
		net.Start( "ARCHOS_Winter_Textures_Joined" )
		net.SendToServer()
	end)
	
	function ARCHOS.ChangeGrassToSnow()
		render.RedownloadAllLightmaps(false)
		
		ARCHOS.Hook.Add("PlayerFootstep","Winter_Footsteps",function(ply,pos,foot,sound,volume)
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
			Material(v):Recompute()
		end
	end
end