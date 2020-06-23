luaroot = "archos"

concommand.Add("archos_reload",function(ply,cmd,args)

if SERVER then
	luaroot = "archos"
    local fol = luaroot .. "/"
    local files, folders = file.Find(fol .. "*", "LUA")

    for k, v in pairs(files) do
        include(fol .. v)
    end

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(fol .. folder .. "/sh_*.lua", "LUA"), true) do
            MsgC(Color(0, 255, 255), "[ArchOS] Modul : " .. File .. "\n")
            AddCSLuaFile(fol .. folder .. "/" .. File)
            include(fol .. folder .. "/" .. File)
        end
    end

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(fol .. folder .. "/sv_*.lua", "LUA"), true) do
            MsgC(Color(255, 0, 0), "[ArchOS] Modul : " .. File .. "\n")
            include(fol .. folder .. "/" .. File)
        end
    end

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(fol .. folder .. "/cl_*.lua", "LUA"), true) do
            MsgC(Color(255, 255, 0), "[ArchOS] Modul : " .. File .. "\n")
            AddCSLuaFile(fol .. folder .. "/" .. File)
        end
    end

    MsgC(Color(0, 255, 255), "\n[ArchOS] Moduly Načteny.\n\n")

end

if CLIENT then
	luaroot = "archos"

    local root = "archos" .. "/"
    local _, folders = file.Find(root .. "*", "LUA")

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(root .. folder .. "/sh_*.lua", "LUA"), true) do
            MsgC(Color(0, 255, 255), "[ArchOS] Modul : " .. File .. "\n")
            include(root .. folder .. "/" .. File)
        end
    end

    for _, folder in SortedPairs(folders, true) do
        for _, File in SortedPairs(file.Find(root .. folder .. "/cl_*.lua", "LUA"), true) do
            MsgC(Color(255, 255, 0), "[ArchOS] Modul : " .. File .. "\n")
            include(root .. folder .. "/" .. File)
        end
    end

    MsgC(Color( 0, 255, 0 ), "\n[ArchOS] Moduly Načteny.\n\n")

end

end)


if SERVER then
	luaroot = "archos"
    local fol = luaroot .. "/"
    local files, folders = file.Find(fol .. "*", "LUA")

    for k, v in pairs(files) do
        include(fol .. v)
    end

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(fol .. folder .. "/sh_*.lua", "LUA"), true) do
            MsgC(Color(0, 255, 255), "[ArchOS] Modul : " .. File .. "\n")
            AddCSLuaFile(fol .. folder .. "/" .. File)
            include(fol .. folder .. "/" .. File)
        end
    end

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(fol .. folder .. "/sv_*.lua", "LUA"), true) do
            MsgC(Color(255, 0, 0), "[ArchOS] Modul : " .. File .. "\n")
            include(fol .. folder .. "/" .. File)
        end
    end

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(fol .. folder .. "/cl_*.lua", "LUA"), true) do
            MsgC(Color(255, 255, 0), "[ArchOS] Modul : " .. File .. "\n")
            AddCSLuaFile(fol .. folder .. "/" .. File)
        end
    end

    MsgC(Color(0, 255, 255), "\n[ArchOS] Moduly Načteny.\n\n")

end

if CLIENT then
	luaroot = "archos"

    local root = "archos" .. "/"
    local _, folders = file.Find(root .. "*", "LUA")

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(root .. folder .. "/sh_*.lua", "LUA"), true) do
            MsgC(Color(0, 255, 255), "[ArchOS] Modul : " .. File .. "\n")
            include(root .. folder .. "/" .. File)
        end
    end

    for _, folder in SortedPairs(folders, true) do
        for _, File in SortedPairs(file.Find(root .. folder .. "/cl_*.lua", "LUA"), true) do
            MsgC(Color(255, 255, 0), "[ArchOS] Modul : " .. File .. "\n")
            include(root .. folder .. "/" .. File)
        end
    end

    MsgC(Color( 0, 255, 0 ), "\n[ArchOS] Moduly Načteny.\n\n")

end