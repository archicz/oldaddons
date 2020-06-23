// ARCHOS
// >>#-#-#- CORE -#-#-#<<
// ARCHOS

if not ARCHOS then
ARCHOS = {}
ARCHOS.Version = 15.0
ARCHOS.Codename = "Circl0r"
end

ARCHOS.Hook = {}
ARCHOS.Hook.List_SV = {}
ARCHOS.Hook.List_CL = {}

if SERVER then
	function ARCHOS.Hook.Add(eventname,name,func)
		table.insert(ARCHOS.Hook.List_SV,eventname.. " " .. name)
		MsgC(Color(255, 255, 0), "[ArchOS] Přidán hook " .. eventname .. " " .. name .. ".\n")
		hook.Add(eventname,"ARCHOS_"..name,func)
	end
end

if CLIENT then
	function ARCHOS.Hook.Add(eventname,name,func)
		table.insert(ARCHOS.Hook.List_CL,eventname.. " " .. name)
		MsgC(Color(255, 255, 0), "[ArchOS] Přidán hook " .. eventname .. " " .. name .. ".\n")
		hook.Add(eventname,"ARCHOS_"..name,func)
	end
end

if SERVER then

require( "mysqloo" )

--if file.Exists("archos_mysql.txt","DATA") then
	local mysql_credentials = util.JSONToTable(file.Read("archos_mysql.txt","DATA"))
	ARCHOS.db = mysqloo.connect( "localhost", "gmodserver", "krysy123", "gmodserver", 3306 )

	function ARCHOS.db:onConnected()
		MsgC(Color(0, 255, 0), "[ArchOS] Pripojeni k databazi uspesne.\n")
	end

	function ARCHOS.db:onConnectionFailed( err )
		MsgC(Color(255, 0, 0), "[ArchOS] Chyba pri pripojovani k databazi.\n")
		MsgC(Color(255, 0, 0), "[ArchOS] "..err.."\n")
	end

	ARCHOS.db:connect()
--else
	--MsgC(Color(255, 255, 0), "[ArchOS] Chybi prihlasovaci udaje pro databazi.\n")
--end

concommand.Add("archos_mysql_create",function(ply,cmd,args)
	local temptbl = {}
	temptbl["hostname"] = args[1]
	temptbl["username"] = args[2]
	temptbl["password"] = args[3]
	temptbl["dbname"] = args[4]
	local json = util.TableToJSON(temptbl)
	file.Write("archos_mysql.txt",json)
end)

end