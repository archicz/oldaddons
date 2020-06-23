// ARCHOS
// -- sv_daynight
// ARCHOS

ARCHOS.IsNight = false

timer.Create("ARCHOS_TimeChecker",2,0,function()
	if !AtmosGlobal then return end
	if(AtmosGlobal:GetTime() > 19) then
		ARCHOS.IsNight = true
		for k,v in pairs(ents.GetAll()) do
			if(v:GetClass() == "archos_nightlamp") then
				v:TurnOn()
			end
		end
	elseif(AtmosGlobal:GetTime() < 19) then
		ARCHOS.IsNight = false
		for k,v in pairs(ents.GetAll()) do
			if(v:GetClass() == "archos_nightlamp") then
				v:TurnOff()
			end
		end
	end
end)

concommand.Add("archos_daynight_lamps_on",function(ply,cmd,args)
	if ply:IsAdmin() or ply:IsSuperAdmin() then
		for k,v in pairs(ents.GetAll()) do
			if(v:GetClass() == "archos_nightlamp") then
				v:TurnOn()
			end
		end
	end
end)

concommand.Add("archos_daynight_lamps_off",function(ply,cmd,args)
	if ply:IsAdmin() or ply:IsSuperAdmin() then
		for k,v in pairs(ents.GetAll()) do
			if(v:GetClass() == "archos_nightlamp") then
				v:TurnOff()
			end
		end
	end
end)