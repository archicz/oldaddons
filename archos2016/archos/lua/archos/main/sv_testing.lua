// ARCHOS
// -- sv_testing
// ARCHOS

concommand.Add("archos_simfphystest",function(ply,cmd,args)
	local base_entity = "gmod_sent_vehicle_fphysics_base"
	if ply:InVehicle() then
		for k,v in pairs(ents.FindInSphere(ply:GetPos(),20)) do
			if v:GetClass() == base_entity then
				VehicleExists(v)
			end
		end
	end
end)

function VehicleExists(ent)
	local simfphyscar = ent
	simfphyscar:SetEfficiency(5)
end

function UpgradeMotor(ent)
	
end