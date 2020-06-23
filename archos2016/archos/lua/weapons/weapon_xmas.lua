SWEP.PrintName			= "Xmax Lights Gun"			
SWEP.Author				= "Feihc (Fix by ArchiCZ)"
SWEP.Category			= "ArchOS [Fun]"
SWEP.Instructions   	= "Left click to shoot a light"

SWEP.Contact        	= ""
SWEP.Purpose        	= ""
SWEP.Spawnable      	= true
SWEP.AdminSpawnable 	= true

SWEP.Slot				= 5
SWEP.SlotPos			= 7
SWEP.ViewModelFOV		= 70

SWEP.ViewModel     	 = "models/weapons/v_grenade.mdl"
SWEP.WorldModel  	 = "models/weapons/w_grenade.mdl"

SWEP.Primary.Delay				= -1	
SWEP.Primary.ClipSize			= -1	
SWEP.Primary.DefaultClip		= -1
SWEP.Primary.Automatic   		= false
SWEP.Primary.Ammo         		= "none"

SWEP.Secondary.Delay			= -1
SWEP.Secondary.ClipSize			= -1
SWEP.Secondary.DefaultClip		= -1
SWEP.Secondary.Automatic   		= true
SWEP.Secondary.Ammo         	= "none"

if not SERVER then return end

function SWEP:Reload()
	for _, brek in pairs(self.lights) do
		if brek:IsValid() then
			brek:Remove()
			self.lights = {}
		end
	end
end
 
function SWEP:Think()
for _, brek in pairs(self.lights) do
	if brek:IsValid() then
		local trace = {}
		trace.start = brek:GetPos()
		trace.endpos = brek:GetPos() + (brek:GetForward() * 15)
		trace.filter = brek
		tr = util.TraceLine( trace )
		
		if tr.HitWorld then
			local phys = brek:GetPhysicsObject()
			phys:EnableMotion(false)
		end
	end
end

end

function MakeSprite( entity )
	entity.Sprite = ents.Create("env_sprite")
	entity.Sprite:SetPos( entity:GetPos() )
	entity.Sprite:SetKeyValue( "renderfx", "4" )
	entity.Sprite:SetKeyValue( "model", "sprites/glow1.vmt")
	entity.Sprite:SetKeyValue( "scale", "1.0")
	entity.Sprite:SetKeyValue( "spawnflags", "1")
	entity.Sprite:SetKeyValue( "angles", "0 0 0")
	entity.Sprite:SetKeyValue( "rendermode", "9")
	entity.Sprite:SetKeyValue( "renderamt", "255")
	local ran = math.random( 0, 255 ) .. " " .. math.random( 0, 255 ) .. " " .. math.random( 0, 255 )
	entity.Sprite:SetKeyValue( "rendercolor", ran )

	entity.Sprite:Spawn()
	entity.Sprite:Activate()
	entity.Sprite:SetParent( entity )
end 

function SWEP:Initialize()
	self.lights = {}
end

function SWEP:PrimaryAttack()
    light = ents.Create( "prop_physics" )
    light:SetPos( self.Owner:GetEyeTrace().HitPos )
    light:SetModel("models/Items/grenadeAmmo.mdl")
    light:Spawn()
    light:Activate()
	if(self.Owner:GetEyeTrace().Entity:CPPIGetOwner() == self.Owner) then
		light:SetParent(self.Owner:GetEyeTrace().Entity)
	end
	
	local delay = .25
	self.Weapon:SetNextPrimaryFire(CurTime() + delay)
    local phys = light:GetPhysicsObject()
	phys:EnableDrag(true)
	phys:EnableMotion(false)
	
	table.insert(self.lights, light)
	MakeSprite(light)
	
	self.Owner:EmitSound("AI_BaseNPC.SwishSound", 1, 1)
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	
	local width =  2
	local addedlength = 999
	local material = "models/rendertarget"

	local i = table.getn(self.lights)
	if i >= 2 then
		local other = i - 1
		local length = (math.abs((self.lights[other]:GetPos() - light:GetPos()):Length()))
		local constraint = constraint.Rope( self.lights[other], light, 0, 0, Vector(0,0,0), Vector(0,0,0), 100, addedlength, 0, width, material, false )
	end
end

function SWEP:SecondaryAttack()
	local delay = .25
	self.Weapon:SetNextSecondaryFire(CurTime() + delay)
	
	local i = table.getn(self.lights)
	
	if i > 0 then
		SafeRemoveEntity(table.GetLastValue(self.lights))
		table.remove(self.lights,table.GetLastKey(self.lights))
	end
end