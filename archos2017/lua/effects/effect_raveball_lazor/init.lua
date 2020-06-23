local beam_mat = Material("sprites/rollermine_shock")


local randomcolors = {
	{255,0,0},
	{0,255,0},
	{0,0,255},
	{255,255,0},
	{0,255,255},
	{255,0,255},
	
	n=6
}

function EFFECT:Init( data )

	self.Alpha = 1
	self.FadingIn = true
	self.Color = randomcolors[math.random(1,randomcolors.n)]
	
	self.Entity:SetRenderBounds( Vector()*-512, Vector()*512 )
	self.Angle = data:GetAngles()
	self.Position = data:GetStart()
	self.ParentEnt = data:GetEntity()
	
end


/*---------------------------------------------------------
   THINK
   Returning false makes the entity die
---------------------------------------------------------*/
function EFFECT:Think( )
	
	self.Angle = self.Angle + Angle(0,0.4,0)
	
	if self.FadingIn then
		self.Alpha = self.Alpha + 8
		if self.Alpha>=255 then
			self.Alpha=255
			self.FadingIn=false
		end
	else
		if self.ParentEnt and self.ParentEnt:IsValid() then
			self.Alpha = self.Alpha - 6
		else
			self.Alpha = self.Alpha - 32
		end
	end
	
	if self.Alpha<=0 then return false end
	return true
	
end


/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()
	
	local vStart = self.Position
	local vForward = self.Angle:Forward()
	local vEnd = vStart + (vForward * 400)

	local bbmin, bbmax = self.Entity:GetRenderBounds()
	local lspos = self.Entity:WorldToLocal(vStart)
	local lepos = self.Entity:WorldToLocal(vEnd)
	if (lspos.x < bbmin.x) then bbmin.x = lspos.x end
	if (lspos.y < bbmin.y) then bbmin.y = lspos.y end
	if (lspos.z < bbmin.z) then bbmin.z = lspos.z end
	if (lspos.x > bbmax.x) then bbmax.x = lspos.x end
	if (lspos.y > bbmax.y) then bbmax.y = lspos.y end
	if (lspos.z > bbmax.z) then bbmax.z = lspos.z end
	if (lepos.x < bbmin.x) then bbmin.x = lepos.x end
	if (lepos.y < bbmin.y) then bbmin.y = lepos.y end
	if (lepos.z < bbmin.z) then bbmin.z = lepos.z end
	if (lepos.x > bbmax.x) then bbmax.x = lepos.x end
	if (lepos.y > bbmax.y) then bbmax.y = lepos.y end
	if (lepos.z > bbmax.z) then bbmax.z = lepos.z end
	self.Entity:SetRenderBounds(bbmin, bbmax, Vector()*6)
	
	render.SetMaterial(beam_mat)
	render.DrawBeam(vStart, vEnd, 5, 0, 10, Color(self.Color[1],self.Color[2],self.Color[3],self.Alpha))

end



