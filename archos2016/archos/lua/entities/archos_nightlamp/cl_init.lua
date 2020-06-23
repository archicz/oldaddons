include("shared.lua")

ENT.dlight = nil

function ENT:Draw()

	self:DrawModel()
	if(self:GetIsOn() == true && LocalPlayer():GetPos():Distance( self:GetPos() ) < 850) then
		self.dlight = DynamicLight(self:EntIndex())
		self.dlight.pos = self:LocalToWorld(Vector(0,0,200))
		self.dlight.r = 255
		self.dlight.g = 233
		self.dlight.b = 157
		self.dlight.brightness = 8
		self.dlight.Decay = 1
		self.dlight.Size = 777
		self.dlight.DieTime = CurTime() + 1
	end
end