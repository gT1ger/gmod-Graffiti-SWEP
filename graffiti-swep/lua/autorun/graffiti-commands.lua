CreateConVar('graffiti_admins_only', 0, FCVAR_NONE, nil, 0, 1)
CreateConVar('graffiti_max_distance', 140, FCVAR_NONE, nil, 100, 100000)

concommand.Add('graffiti_clear', function(ply, cmd, args)
    if (SERVER) and (ply:IsAdmin()) and (ply:IsValid()) then
        Entity(0):RemoveAllDecals()
    end
end)
concommand.Add('graffiti_clear', function(ply, cmd, args)
    if (SERVER) and (ply:IsAdmin()) and (ply:IsValid()) then
        Entity(0):RemoveAllDecals()
    end
end)

concommand.Add('graffiti_delete_settings', function(ply, cmd, args)
    if (ply:IsValid()) then
        if (tostring(file.Find('graffiti_settings.txt', 'DATA')[1]) == 'graffiti_settings.txt') then
            file.Delete('graffiti_settings.txt')
            print('[graffiti-swep] Settings deleted!')
        end
    end
end)

local last_change_admins = 0
local last_change_distance = 0
cvars.AddChangeCallback('graffiti_admins_only', function(convar_name, value_old, value_new)
    if (last_change_admins > CurTime()) then return end
    last_change_distance = CurTime() + 3
    if (CLIENT) and (LocalPlayer():IsAdmin() == false) and (value_old != value_new) then
        RunConsoleCommand('graffiti_admins_only', value_old)
        return
    end
    print('[graffiti-swep] Admins Only: ' .. GetConVar('graffiti_admins_only'):GetInt())
end)
cvars.AddChangeCallback('graffiti_max_distance', function(convar_name, value_old, value_new)
    if (last_change_distance > CurTime()) then return end
    last_change_distance = CurTime() + 3
    if (CLIENT) and (LocalPlayer():IsAdmin() == false) and (value_old != value_new) then
        RunConsoleCommand('graffiti_max_distance', value_old)
        return
    end
    print('[graffiti-swep] Max Distance: ' .. GetConVar('graffiti_max_distance'):GetInt())
end)