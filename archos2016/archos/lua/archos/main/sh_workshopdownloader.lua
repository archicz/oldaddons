if( SERVER ) then

	local SV_WORKSHOP = {
	"266666023",
	"173482196",
	"546392647",
	"160250458",
	"104691717",
	"799449579",
	"185609021",
	"771487490",
	"128093075",
	"128089118"
	}
	
	for k,v in pairs(SV_WORKSHOP) do
		resource.AddWorkshop(v)
	end
end

if( CLIENT ) then

	local CL_WORKSHOP = {
	"1136661986",
	"605223544",
	"356521204",
	"246756300",
	"831680603",
	"673698301",
	"104607228",
	"150455514",
	"111412589",
	"108024198",
	"117142677",
	"171935748",
	"242776816",
	"107590810",
	"581160151",
	"130227747"
	}
	
	hook.Add("InitPostEntity","ARCHOS_WorkshopDownloader_Download",function()
		for k,v in pairs(CL_WORKSHOP) do
			steamworks.FileInfo( v, function( result )
				steamworks.Download( result.fileid, true, function( name )
					game.MountGMA(name)
				end)
			end)
		end
	end)
	
	concommand.Add("archos_workshop_download",function(ply,cmd,args)
		for k,v in pairs(CL_WORKSHOP) do
			steamworks.FileInfo( v, function( result )
				steamworks.Download( result.fileid, true, function( name )
					game.MountGMA(name)
				end)
			end)
		end
	end)
end