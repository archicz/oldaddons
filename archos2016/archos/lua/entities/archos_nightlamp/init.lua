AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include("shared.lua")

ARCHOS.NightLamp = {}
ARCHOS.NightLamp.Models = {}
ARCHOS.NightLamp.Models.Normal = {}
ARCHOS.NightLamp.Models.Normal["on"] = "models/props_urban/lights_streetlight01_on.mdl"
ARCHOS.NightLamp.Models.Normal["off"] = "models/props_urban/lights_streetlight01.mdl"

ARCHOS.NightLamp.Models.Christmas = {}
ARCHOS.NightLamp.Models.Christmas["on"] = "models/props_urban/lights_streetlight01_snow_on.mdl"
ARCHOS.NightLamp.Models.Christmas["off"] = "models/props_urban/lights_streetlight01_snow.mdl"

function ENT:Initialize()
	self:SetModel("models/props_urban/lights_streetlight01.mdl")
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:DrawShadow( false )
	
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
	end
	self:StartMotionController()
	
	if(ARCHOS.IsSnowing == true) then
		self:SetModel(ARCHOS.NightLamp.Models.Christmas["off"])
	else
		self:SetModel(ARCHOS.NightLamp.Models.Normal["off"])
	end
	
	self:TurnOff()
end

hook.Add("ARCHOS_SnowChanged","ARCHOS_NightLamp_ChangeModel",function()
	for k,v in pairs(ents.GetAll()) do
		if(v:GetClass() == "archos_nightlamp") then
			if(ARCHOS.IsSnowing == true) then
				v:SetModel(ARCHOS.NightLamp.Models.Christmas["off"])
			else
				v:SetModel(ARCHOS.NightLamp.Models.Normal["off"])
			end
				
			if(ARCHOS.IsSnowing == true && v:GetIsOn() == true) then
				v:SetModel(ARCHOS.NightLamp.Models.Christmas["on"])
			else
				v:SetModel(ARCHOS.NightLamp.Models.Normal["on"])
			end
		end
	end
end)

function ENT:TurnOn()
	if IsValid(self.LightSprite) then return end
	self.LightSprite = ents.Create("env_sprite")
	self.LightSprite:SetPos(self:LocalToWorld(Vector(0,0,200)))
	self.LightSprite:SetParent(self.Entity)
	self.LightSprite:SetKeyValue("model","sprites/light_glow03.vmt")
	self.LightSprite:SetKeyValue("rendercolor","255 233 157")
	self.LightSprite:SetKeyValue("scale","2")
	self.LightSprite:SetKeyValue("rendermode", "9")
	self.LightSprite:SetKeyValue("GlowProxySize", "48")
	self.LightSprite:SetKeyValue("renderamt", "200")
	self.LightSprite:Spawn()
	self:SetIsOn(true)
	
	if(ARCHOS.IsSnowing == true) then
		self:SetModel(ARCHOS.NightLamp.Models.Christmas["on"])
	else
		self:SetModel(ARCHOS.NightLamp.Models.Normal["on"])
	end
end

function ENT:TurnOff()
	if !IsValid(self.LightSprite) then return end
	self:SetIsOn(false)
	SafeRemoveEntity(self.LightSprite)
	
	if(ARCHOS.IsSnowing == true) then
		self:SetModel(ARCHOS.NightLamp.Models.Christmas["off"])
	else
		self:SetModel(ARCHOS.NightLamp.Models.Normal["off"])
	end
end

function ENT:SpawnFunction( ply, tr, Class )
	if( !tr.Hit ) then return end
	local Ent = ents.Create( Class )
	Ent:SetPos( ( tr.HitPos + tr.HitNormal ) )
	Ent:SetAngles( ply:GetAngles() )
	Ent:Spawn()
	Ent:Activate()
	return Ent
end

function ENT:OnTakeDamage()
	if IsValid(self.LightSprite) then
		self:TurnOff()
		self:EmitSound("physics/glass/glass_impact_bullet"..math.random(1,4)..".wav")
		timer.Simple(math.random(0.30,0.98),function()
			if IsValid(self.Entity) then
				self:TurnOn()
			end
			timer.Simple(math.random(0.10,0.20),function()
				if IsValid(self.Entity) then
					self:EmitSound("ambient/energy/zap"..math.random(1,3)..".wav")
					self:TurnOff()
				end
				timer.Simple(math.random(0.20,0.30),function()
					if IsValid(self.Entity) then
						self:TurnOn()
					end
				end)
			end)
		end)
	end
end

function ENT:OnRemove()
	SafeRemoveEntity(self.LightSprite)
end