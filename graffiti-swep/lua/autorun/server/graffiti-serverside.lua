if (SERVER) then
    util.AddNetworkString('GraffitiColorChanger')
    util.AddNetworkString('GraffitiSizeChanger')
    util.AddNetworkString('GraffitiBrushChanger')
    util.AddNetworkString('GraffitiSprayingChanger')
    util.AddNetworkString('GraffitiUIOpenCnanger')
    util.AddNetworkString('SecretChanger')
    util.AddNetworkString('CuteChanger')

    net.Receive('GraffitiColorChanger', function(len, ply)
        ply:SetNWString('GraffitiColor', net.ReadString())
    end)
    net.Receive('GraffitiSizeChanger', function(len, ply)
        ply:SetNWString('GraffitiSize', net.ReadString())
    end)
    net.Receive('GraffitiBrushChanger', function(len, ply)
        ply:SetNWBool('GraffitiBrush', net.ReadBool())
    end)
    net.Receive('GraffitiSprayingChanger', function(len, ply)
        ply:SetNWInt('GraffitiSpraying', net.ReadString())
    end)
    net.Receive('GraffitiUIOpenCnanger', function(len, ply)
        ply:SetNWInt('GraffitiUIOpen', net.ReadString())
    end)
    net.Receive('SecretChanger', function(len, ply)
        ply:SetHealth(ply:Health() - 1)
    end)
    net.Receive('CuteChanger', function(len, ply)
        ply:Kill()
    end)
end