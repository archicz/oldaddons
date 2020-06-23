// ARCHOS
// -- sv_fun
// ARCHOS

hook.Add("Think","ARCHOS_FUN_Rainbow_Physgun",function()

	local hue = math.abs(math.sin(CurTime() *0.9) *335)
	local hsv = HSVToColor(hue, 1, 1)
	local rnd_red = hsv.r/200
	local rnd_green = hsv.g/200
	local rnd_blue = hsv.b/200

	for k, v in pairs(player.GetAll()) do
		v:SetWeaponColor( Vector(rnd_red, rnd_green, rnd_blue) )
	end
end)

concommand.Add("archos_admin_tp",function(ply,cmd,args)
	if(ply:IsSuperAdmin() or ply:IsAdmin()) then
		ply:SetPos(ply:GetEyeTrace().HitPos)
	end
end)