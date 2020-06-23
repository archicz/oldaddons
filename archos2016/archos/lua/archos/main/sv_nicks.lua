// ARCHOS
// -- sv_nicks
// ARCHOS

ARCHOS.Title = {}

util.AddNetworkString("ARCHOS_Nicks_TitleSet")

function ARCHOS.Title.CreateTable()
	local query = ARCHOS.db:query("CREATE TABLE titles (steamid varchar(255),title varchar(255));")
		
	function query:onSuccess(data)
		MsgC(Color(0, 255, 0), "[ArchOS - Titles] Tabulka uspesne vytvorena.\n")
	end
	
	function query:onError(err)
		MsgC(Color(255, 0, 0), "[ArchOS - Titles] Tabulka neuspesne vytvorena.\n")
	end

	query:start()
end

function ARCHOS.Title.CheckForTable()
	local query = ARCHOS.db:query("SELECT * FROM titles;")
		
	function query:onSuccess(data)
		MsgC(Color(0, 255, 0), "[ArchOS - Titles] Tabulka existuje.\n")
	end

	function query:onError(err)
		MsgC(Color(255, 255, 0), "[ArchOS - Titles] Tabulka neexistuje, vytvarim tabulku...\n")
		ARCHOS.LevelingSystem.CreateTable()
	end

	query:start()
end

function ARCHOS.Title.AddUser(ply)
	MsgC(Color(255, 255, 0), "[ArchOS - Titles] Vytvarim databazi hracovi "..ply:Nick().."...\n")
	local query = ARCHOS.db:prepare("INSERT INTO titles (`steamid`, `title`) VALUES(?, ?)")
	function query:onSuccess(data)
		MsgC(Color(0, 255, 0), "[ArchOS - Titles] Databaze hrace "..ply:Nick().." byla uspesne vytvorena.\n")
	end
		
	function query:onError(err)
		MsgC(Color(255, 0, 0), "[ArchOS - Titles] Databaze hrace "..ply:Nick().." byla neuspesne vytvorena.\n")
	end
		
	query:setString(1, ply:SteamID64())
	query:setString(2, "")
	query:start()
end

function ARCHOS.Title.Load(ply)
	local query = ARCHOS.db:query("SELECT * FROM titles WHERE steamid='"..ply:SteamID64().."';")
		
	function query:onSuccess(data)
		MsgC(Color(255, 255, 0), "[ArchOS - Titles] Aktualizuji networking u hrace "..ply:Nick()..".\n")
		ply:SetNWString("archos_title",data[1]["title"])
	end

	function query:onError(err)
		MsgC(Color(255, 0, 0), "[ArchOS - Titles] Chyba na strane databaze.\n")
		MsgC(Color(255, 0, 0), "[ArchOS - Titles] "..err.."\n")
	end

	query:start()
end

function ARCHOS.Title.Save(ply,str)
	local query = ARCHOS.db:query("UPDATE titles SET title = '"..str.."' WHERE steamid = '"..ply:SteamID64().."'")
		
	function query:onSuccess(data)
		MsgC(Color(0, 255, 0), "[ArchOS - Titles] Hrac "..ply:Nick().." nastavuje titulek "..str.."\n")
	end

	function query:onError(err)
		MsgC(Color(255, 0, 0), "[ArchOS - Titles] Chyba na strane databaze.\n")
		MsgC(Color(255, 0, 0), "[ArchOS - Titles] "..err.."\n")
	end

	query:start()
	
	ARCHOS.Title.Load(ply)
	net.Start("ARCHOS_Nicks_TitleSet")
	net.Send(ply)
end

concommand.Add("archos_titles_check",function(ply,cmd,args)
	if ply:GetPData("archos_firsttaym",false) == false then
		ARCHOS.Title.AddUser(ply)
		ply:SetPData("archos_firsttaym",true)
	else
		ARCHOS.Title.Load(ply)
	end
end)

concommand.Add("archos_titles_rt",function(ply,cmd,args)
	ARCHOS.Title.AddUser(ply)
end)

hook.Add("PlayerInitialSpawn","ARCHOS_TITLE_SPAWN",function(ply)
	if ply:GetPData("archos_firsttaym",false) == false && !ply:IsBot() then
		ARCHOS.Title.AddUser(ply)
		ply:SetPData("archos_firsttaym",true)
	else
		ARCHOS.Title.Load(ply)
	end
end)

hook.Add("Initialize","ARCHOS_TITLE_Check",function()
	ARCHOS.Title.CheckForTable()
end)

hook.Add("PlayerSay","ARCHOS_TITLE_CHAT",function(ply,text,team)
	if(string.sub(text,1,6) == "!title") then
		ARCHOS.Title.Save(ply,string.sub(text,7))
		print(string.sub(text,7))
		return ""
	end
end)