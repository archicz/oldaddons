if( SERVER ) then

	local SV_WORKSHOP = {
		"206869955", -- gm_carcon_ws
		"1182610124", -- ArchOS Content
		"882310019", -- Atlaschat Content
		"882463775", -- Outfitter: Multiplayer player models
		"104691717", -- PAC3
		"686701650", -- Propeller SVN
		"605223544", -- NM Prop pack
		"160250458", -- Wiremod
		"799449579", -- Wiremod Extras
		"173482196", -- SProps Workshop Edition
		"246756300", -- 3D Stream Radio
		"185609021", -- Atmos - Day / Night and Weather Modification
		"117142677", -- Fireworks
		"546392647", -- Media Player
		"922947756", -- Playable Synthesizer
		"154492380", -- TARDIS
		"771487490", -- [simfphys] LUA Vehicles - Base
		"581160151", -- [V92 SimfPhys] PAYDAY 2
		"1175886758", -- Simfphys K29 Truck
		"165559580",  -- Anti-Noclip Field
		"413924233", -- LW Wheels
		"266579667", -- LW Shared Textures
		"356521204", -- ACF Unofficial Extras
		"256056339", -- White Texture Pack [dev halted]
		"323792126", -- Expression Advanced 2
		"108024198", -- Food and Household items
		"471435979", -- Race Seat
		"1296095852",-- TZAR VODKA
		"210294043" -- Chujovinka
	}
	
	for k,v in pairs(SV_WORKSHOP) do
		resource.AddWorkshop(v)
	end
end

if( CLIENT ) then

end