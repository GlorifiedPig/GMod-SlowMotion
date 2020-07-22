
SlowMotion = SlowMotion or {}

local giVersion = 1.2

if not GlorifiedInclude or GlorifiedInclude.Version < giVersion then
    GlorifiedInclude = {
        Version = giVersion,
        Realm = {
            Server = 0,
            Client = 1,
            Shared = 2
        }
    }

    local _include = include
    local _AddCSLuaFile = AddCSLuaFile
    local _SERVER = SERVER

    local _GlorifiedInclude_Realm = GlorifiedInclude.Realm

    local includedFiles = {}
    function GlorifiedInclude.IncludeFile( fileName, realm, forceInclude, calledFromFolder, printName )
        if IsAddon == false and not calledFromFolder then fileName = GM.FolderName .. "/gamemode/" .. fileName end
        if not forceInclude and includedFiles[fileName] then return end
        includedFiles[fileName] = true

        if realm == _GlorifiedInclude_Realm.Shared or fileName:find( "sh_" ) then
            if _SERVER then _AddCSLuaFile( fileName ) end
            _include( fileName )
            if printName then
                print( printName .. " > Included SH file '" .. fileName .. "'" )
            end
        elseif realm == _GlorifiedInclude_Realm.Server or ( _SERVER and fileName:find( "sv_" ) ) then
            _include( fileName )
            if printName then
                print( printName .. " > Included SV file '" .. fileName .. "'" )
            end
        elseif realm == _GlorifiedInclude_Realm.Client or fileName:find( "cl_" ) then
            if _SERVER then _AddCSLuaFile( fileName )
            else _include( fileName ) end
            if printName then
                print( printName .. " > Included CL file '" .. fileName .. "'" )
            end
        end
    end

    function GlorifiedInclude.IncludeFolder( folderName, ignoreFiles, ignoreFolders, forceInclude, printName )
        if IsAddon == false then folderName = GM.FolderName .. "/gamemode/" .. folderName end

        if string.Right( folderName, 1 ) != "/" then folderName = folderName .. "/" end

        local filesInFolder, foldersInFolder = file.Find( folderName .. "*", "LUA" )

        if forceInclude == nil then forceInclude = false end

        if ignoreFiles != true then
            for k, v in ipairs( filesInFolder ) do
                GlorifiedInclude.IncludeFile( folderName .. v, nil, forceInclude, true, printName )
            end
        end

        if ignoreFolders != true then
            for k, v in ipairs( foldersInFolder ) do
                GlorifiedInclude.IncludeFolder( folderName .. v .. "/", ignoreFiles, ignoreFolders, forceInclude, printName )
            end
        end
    end
end

GlorifiedInclude.IncludeFolder( "slowmotion/libraries/", nil, nil, nil, "Glorified's Slow Motion Mod" )
GlorifiedInclude.IncludeFolder( "slowmotion/localization/", nil, nil, nil, "Glorified's Slow Motion Mod" )
GlorifiedInclude.IncludeFolder( "slowmotion/modules/", nil, nil, nil, "Glorified's Slow Motion Mod" )