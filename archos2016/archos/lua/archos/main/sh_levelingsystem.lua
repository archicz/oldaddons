// ARCHOS
// -- sh_levelingsystem
// ARCHOS

ARCHOS.LevelingSystem = {}
ARCHOS.LevelingSystem.Levels = {}
ARCHOS.LevelingSystem.Levels[1] = 1000
ARCHOS.LevelingSystem.Levels[2] = 2500
ARCHOS.LevelingSystem.Levels[3] = 3000
ARCHOS.LevelingSystem.Levels[4] = 4500
ARCHOS.LevelingSystem.Levels[5] = 5000
ARCHOS.LevelingSystem.Levels[6] = 6500
ARCHOS.LevelingSystem.Levels[7] = 7000
ARCHOS.LevelingSystem.Levels[8] = 8500
ARCHOS.LevelingSystem.Levels[9] = 10000

if SERVER then
	util.AddNetworkString("ARCHOS_LevelingSystem_Chat_AddXP")
	util.AddNetworkString("ARCHOS_LevelingSystem_Chat_TakeXP")
	util.AddNetworkString("ARCHOS_LevelingSystem_Chat_FirstTime")
	util.AddNetworkString("ARCHOS_LevelingSystem_Chat_LevelUp")
	util.AddNetworkString("ARCHOS_LevelingSystem_Chat_PayDay")
	util.AddNetworkString("ARCHOS_LevelingSystem_Chat_CantAfford")

	function ARCHOS.LevelingSystem.CreateTable()
		local query = ARCHOS.db:query("CREATE TABLE levelingsystem (steamid varchar(255),xps int,level int);")
		
		function query:onSuccess(data)
			MsgC(Color(0, 255, 0), "[Leveling System] Tabulka uspesne vytvorena.\n")
		end

		function query:onError(err)
			MsgC(Color(255, 0, 0), "[Leveling System] Tabulka neuspesne vytvorena.\n")
		end

		query:start()
	end
	
	function ARCHOS.LevelingSystem.CheckForTable()
		local query = ARCHOS.db:query("SELECT * FROM levelingsystem;")
		
		function query:onSuccess(data)
			MsgC(Color(0, 255, 0), "[Leveling System] Tabulka existuje.\n")
		end

		function query:onError(err)
			MsgC(Color(255, 255, 0), "[Leveling System] Tabulka neexistuje, vytvarim tabulku...\n")
			ARCHOS.LevelingSystem.CreateTable()
		end

		query:start()
	end
	
	function ARCHOS.LevelingSystem.AddUser(ply)
		MsgC(Color(255, 255, 0), "[Leveling System] Vytvarim databazi hracovi "..ply:Nick().."...\n")
		local query = ARCHOS.db:prepare("INSERT INTO levelingsystem (`steamid`, `xps`, `level`) VALUES(?, ?, ?)")
		function query:onSuccess(data)
			MsgC(Color(0, 255, 0), "[Leveling System] Databaze hrace "..ply:Nick().." byla uspesne vytvorena.\n")
		end
		
		function query:onError(err)
			MsgC(Color(255, 0, 0), "[Leveling System] Databaze hrace "..ply:Nick().." byla neuspesne vytvorena.\n")
		end
		
		query:setString(1, ply:SteamID64())
		query:setNumber(2, 500)
		query:setNumber(3, 1)
		query:start()
		
		ARCHOS.LevelingSystem.LoadNW(ply)
		ARCHOS.LevelingSystem.CheckForLevel(ply)
	end
	
	function ARCHOS.LevelingSystem.Set(ply,xps,level)
		local query = ARCHOS.db:query("UPDATE levelingsystem SET xps = "..xps.." WHERE steamid = '"..ply:SteamID64().."'")
		
		function query:onSuccess(data)
			MsgC(Color(0, 255, 0), "[Leveling System] Hrac "..ply:Nick().." nastavuje "..xps.."XP.".."\n")
		end

		function query:onError(err)
			MsgC(Color(255, 0, 0), "[Leveling System] Chyba na strane databaze.\n")
			MsgC(Color(255, 0, 0), "[Leveling System] "..err.."\n")
		end

		query:start()
		
		local query2 = ARCHOS.db:query("UPDATE levelingsystem SET level = "..level.." WHERE steamid = '"..ply:SteamID64().."'")
		
		function query2:onSuccess(data)
			MsgC(Color(0, 255, 0), "[Leveling System] Hrac "..ply:Nick().." nastavuje "..level.." Level.".."\n")
		end

		function query2:onError(err)
			MsgC(Color(255, 0, 0), "[Leveling System] Chyba na strane databaze.\n")
			MsgC(Color(255, 0, 0), "[Leveling System] "..err.."\n")
		end

		query2:start()
		ARCHOS.LevelingSystem.LoadNW(ply)
		ARCHOS.LevelingSystem.CheckForLevel(ply)
	end

	function ARCHOS.LevelingSystem.SetLevel(ply,level)
		local query = ARCHOS.db:query("UPDATE levelingsystem SET level = "..level.." WHERE steamid = '"..ply:SteamID64().."'")
		
		function query:onSuccess(data)
			MsgC(Color(0, 255, 0), "[Leveling System] Hrac "..ply:Nick().." nastavuje "..level.." Level.".."\n")
		end

		function query:onError(err)
			MsgC(Color(255, 0, 0), "[Leveling System] Chyba na strane databaze.\n")
			MsgC(Color(255, 0, 0), "[Leveling System] "..err.."\n")
		end

		query:start()
		ARCHOS.LevelingSystem.LoadNW(ply)
		
		net.Start("ARCHOS_LevelingSystem_Chat_LevelUp")
		net.WriteFloat(level)
		net.Send(ply)
	end
	
	function ARCHOS.LevelingSystem.SetXps(ply,xp)
		local query = ARCHOS.db:query("UPDATE levelingsystem SET xps = "..xps.." WHERE steamid = '"..ply:SteamID64().."'")
		
		function query:onSuccess(data)
			MsgC(Color(0, 255, 0), "[Leveling System] Hrac "..ply:Nick().." nastavuje "..xps.."XP.".."\n")
		end

		function query:onError(err)
			MsgC(Color(255, 0, 0), "[Leveling System] Chyba na strane databaze.\n")
			MsgC(Color(255, 0, 0), "[Leveling System] "..err.."\n")
		end

		query:start()
		ARCHOS.LevelingSystem.LoadNW(ply)
		ARCHOS.LevelingSystem.CheckForLevel(ply)
	end
	
	function ARCHOS.LevelingSystem.AddXps(ply,xps)
		local query = ARCHOS.db:query("UPDATE levelingsystem SET xps = xps + "..xps.." WHERE steamid = '"..ply:SteamID64().."'")
		
		function query:onSuccess(data)
			MsgC(Color(0, 255, 0), "[Leveling System] Hracovi "..ply:Nick().." pridavam "..xps.."XP.".."\n")
		end

		function query:onError(err)
			MsgC(Color(255, 0, 0), "[Leveling System] Chyba na strane databaze.\n")
			MsgC(Color(255, 0, 0), "[Leveling System] "..err.."\n")
		end

		query:start()
		ARCHOS.LevelingSystem.LoadNW(ply)
		ARCHOS.LevelingSystem.CheckForLevel(ply)
		
		net.Start("ARCHOS_LevelingSystem_Chat_AddXP")
		net.WriteFloat(xps)
		net.Send(ply)
	end
	
	function ARCHOS.LevelingSystem.Payday(ply)
		local payday = math.random(1,500)
	
		local query = ARCHOS.db:query("UPDATE levelingsystem SET xps = xps + "..payday.." WHERE steamid = '"..ply:SteamID64().."'")
		
		function query:onSuccess(data)
			MsgC(Color(0, 255, 0), "[Leveling System] Hrac "..ply:Nick().." dostal payday "..payday.."XP.".."\n")
		end

		function query:onError(err)
			MsgC(Color(255, 0, 0), "[Leveling System] Chyba na strane databaze.\n")
			MsgC(Color(255, 0, 0), "[Leveling System] "..err.."\n")
		end

		query:start()
		ARCHOS.LevelingSystem.LoadNW(ply)
		ARCHOS.LevelingSystem.CheckForLevel(ply)
		
		net.Start("ARCHOS_LevelingSystem_Chat_PayDay")
		net.WriteFloat(payday)
		net.Send(ply)
	end
	
	function ARCHOS.LevelingSystem.TakeXps(ply,xps)
	
		local query = ARCHOS.db:query("SELECT * FROM levelingsystem WHERE steamid='"..ply:SteamID64().."';")
		
		function query:onSuccess(data)
			local xp = data[1]["xps"]
		
			if tonumber(xps) > tonumber(xp) then
				net.Start("ARCHOS_LevelingSystem_Chat_CantAfford")
				net.Send(ply)
			else
				local query2 = ARCHOS.db:query("UPDATE levelingsystem SET xps = xps - "..xps.." WHERE steamid = '"..ply:SteamID64().."'")
					
				function query2:onSuccess(data)
					MsgC(Color(0, 255, 0), "[Leveling System] Hracovi "..ply:Nick().." odebiram "..xps.."XP.".."\n")
				end

				function query2:onError(err)
					MsgC(Color(255, 0, 0), "[Leveling System] Chyba na strane databaze.\n")
					MsgC(Color(255, 0, 0), "[Leveling System] "..err.."\n")
				end

				query2:start()
				ARCHOS.LevelingSystem.LoadNW(ply)
				ARCHOS.LevelingSystem.CheckForLevel(ply)
					
				net.Start("ARCHOS_LevelingSystem_Chat_TakeXP")
				net.WriteFloat(xps)
				net.Send(ply)
			end
		end

		function query:onError(err)
			MsgC(Color(255, 0, 0), "[Leveling System] Chyba na strane databaze.\n")
			MsgC(Color(255, 0, 0), "[Leveling System] "..err.."\n")
		end

		query:start()
	end
	
	function ARCHOS.LevelingSystem.LoadNW(ply)
		local query = ARCHOS.db:query("SELECT * FROM levelingsystem WHERE steamid='"..ply:SteamID64().."';")
		
		function query:onSuccess(data)
			MsgC(Color(255, 255, 0), "[Leveling System] Aktualizuji networking u hrace "..ply:Nick()..".\n")
			ply:SetNWInt("xps",data[1]["xps"])
			ply:SetNWInt("level",data[1]["level"])
		end

		function query:onError(err)
			MsgC(Color(255, 0, 0), "[Leveling System] Chyba na strane databaze.\n")
			MsgC(Color(255, 0, 0), "[Leveling System] "..err.."\n")
		end

		query:start()
	end
	
	function ARCHOS.LevelingSystem.CheckForLevel(ply)
	
		if ply:IsBot() then return end
		local query = ARCHOS.db:query("SELECT * FROM levelingsystem WHERE steamid='"..ply:SteamID64().."';")
		
		function query:onSuccess(data)
			if data[1] == nil then return end
			local xps = data[1]["xps"]
			local level = data[1]["level"]
			
			if(xps >= ARCHOS.LevelingSystem.Levels[1] && level == 1) then
				ARCHOS.LevelingSystem.SetLevel(ply,2)
			elseif(xps >= ARCHOS.LevelingSystem.Levels[2] && level == 2) then
				ARCHOS.LevelingSystem.SetLevel(ply,3)
			elseif(xps >= ARCHOS.LevelingSystem.Levels[3] && level == 3) then
				ARCHOS.LevelingSystem.SetLevel(ply,4)
			elseif(xps >= ARCHOS.LevelingSystem.Levels[4] && level == 4) then
				ARCHOS.LevelingSystem.SetLevel(ply,5)
			elseif(xps >= ARCHOS.LevelingSystem.Levels[5] && level == 5) then
				ARCHOS.LevelingSystem.SetLevel(ply,6)
			elseif(xps >= ARCHOS.LevelingSystem.Levels[6] && level == 6) then
				ARCHOS.LevelingSystem.SetLevel(ply,7)
			elseif(xps >= ARCHOS.LevelingSystem.Levels[7] && level == 7) then
				ARCHOS.LevelingSystem.SetLevel(ply,8)
			elseif(xps >= ARCHOS.LevelingSystem.Levels[8] && level == 8) then
				ARCHOS.LevelingSystem.SetLevel(ply,9)
			elseif(xps >= ARCHOS.LevelingSystem.Levels[9] && level == 9) then
				ARCHOS.LevelingSystem.SetLevel(ply,10)
			end
		end

		function query:onError(err)
			MsgC(Color(255, 0, 0), "[Leveling System] Chyba na strane databaze.\n")
			MsgC(Color(255, 0, 0), "[Leveling System] "..err.."\n")
		end
		
		query:start()
	end
	
	timer.Create("ARCHOS_LevelingSystem_CheckLevel",4,0,function()
		for k,v in pairs(player.GetAll()) do
			ARCHOS.LevelingSystem.CheckForLevel(v)
		end
	end)
	
	timer.Create("ARCHOS_LevelingSystem_PaydayGiver",3600,0,function()
		for k,v in pairs(player.GetAll()) do
			ARCHOS.LevelingSystem.Payday(v)
		end
	end)
	
	hook.Add("PlayerInitialSpawn","ARCHOS_LevelingSystem_Spawn",function(ply)
		if(ply:GetPData("archos_newbie",false) == false && !ply:IsBot()) then
			ARCHOS.LevelingSystem.AddUser(ply)
			ply:SetPData("archos_newbie",true)
		else
			ARCHOS.LevelingSystem.LoadNW(ply)
		end
	end)
	
	hook.Add("Initialize","ARCHOS_LevelingSystem_CheckForTable",function()
		ARCHOS.LevelingSystem.CheckForTable()
	end)
end

if CLIENT then
	net.Receive("ARCHOS_LevelingSystem_Chat_AddXP",function()
		local xp = net.ReadFloat()
		chat.AddText(Color(0,255,255),"[ArchOS] ",Color(255,255,255),ARCHOS.CurrentLanguage["lvs_yougot"].." "..xp.."XP.")
	end)
	
	net.Receive("ARCHOS_LevelingSystem_Chat_TakeXP",function()
		local xp = net.ReadFloat()
		chat.AddText(Color(0,255,255),"[ArchOS] ",Color(255,255,255),ARCHOS.CurrentLanguage["lvs_hasbeentaken"].." "..xp.."XP.")
	end)
	
	net.Receive("ARCHOS_LevelingSystem_Chat_LevelUp",function()
		local level = net.ReadFloat()
		chat.AddText(Color(0,255,255),"[ArchOS] ",Color(255,255,255),ARCHOS.CurrentLanguage["lvs_youarelevel"]..level..".")
	end)
	
	net.Receive("ARCHOS_LevelingSystem_Chat_FirstTime",function()
		chat.AddText(Color(0,255,255),"[ArchOS] ",Color(255,255,255),ARCHOS.CurrentLanguage["lvs_firsttime"])
	end)
	
	net.Receive("ARCHOS_LevelingSystem_Chat_PayDay",function()
		local xp = net.ReadFloat()
		chat.AddText(Color(0,255,255),"[ArchOS] ",Color(255,255,255),ARCHOS.CurrentLanguage["lvs_payday"].." "..xp.."XP "..ARCHOS.CurrentLanguage["lvs_for1hplaytime"])
	end)

	net.Receive("ARCHOS_LevelingSystem_Chat_CantAfford",function()
		chat.AddText(Color(0,255,255),"[ArchOS] ",Color(255,255,255),ARCHOS.CurrentLanguage["lvs_cantafford"])
	end)
end