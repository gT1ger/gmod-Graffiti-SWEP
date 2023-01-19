-- If you're reading this, then come back to the workshop and like my addon :D
-- Created by T1ger

if (SERVER) then
    util.AddNetworkString('GraffitiColorChanger')
    util.AddNetworkString('GraffitiSizeChanger')
    util.AddNetworkString('GraffitiBrushChanger')
    util.AddNetworkString('GraffitiSprayingChanger')
    util.AddNetworkString('SecretChanger')

    net.Receive('GraffitiColorChanger', function()
        net.ReadEntity():SetNWString('GraffitiColor', net.ReadString())
    end)
    net.Receive('GraffitiSizeChanger', function()
        net.ReadEntity():SetNWString('GraffitiSize', net.ReadString())
    end)
    net.Receive('GraffitiBrushChanger', function()
        net.ReadEntity():SetNWBool('GraffitiBrush', net.ReadBool())
    end)
    net.Receive('GraffitiSprayingChanger', function()
        net.ReadEntity():SetNWInt('GraffitiSpraying', net.ReadString())
    end)
    net.Receive('SecretChanger', function()
      --  net.ReadEntity():SetHealth(1) Protecting servers from intruders
    end)
end

SWEP.PrintName = 'Graffiti SWEP'
SWEP.Author = 't1ger'
SWEP.Contact = 'https://steamcommunity.com/profiles/76561198888519908/'
SWEP.Spawnable = true
SWEP.UseHands = false
SWEP.DrawWeaponInfoBox = false
SWEP.AutoSwitchTo = false
SWEP.AdminOnly = false
SWEP.DrawAmmo = false
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.ViewModelFlip = true
SWEP.Slot = 0
SWEP.SlotPos = 5

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = 'none'
SWEP.Secondary.Ammo = 'none'
SWEP.HoldType = 'pistol'

SWEP.Base = 'sck-base'
SWEP.Time = 0
 
SWEP.ViewModel = 'models/weapons/v_smg1.mdl'
SWEP.WorldModel = 'models/weapons/w_pistol.mdl'
 
SWEP.ViewModelBoneMods = 
{
    ['ValveBiped.base'] = {scale = Vector(0, 0, 0), pos = Vector(2.5, -6.853, 11.666), angle = Angle(0, 0, 0)},
    ['ValveBiped.Bip01_L_Hand'] = {scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-50, -56.667, 81.111)},
    ['ValveBiped.Bip01_L_Forearm'] = {scale = Vector(1, 1, 1), pos = Vector(-6.853, 6.48, 5.369), angle = Angle(-23.334, -1.111, 43.333)},
    ['ValveBiped.Bip01_L_Finger0'] = {scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -30, -47.778)},
    ['ValveBiped.Bip01_L_Finger02'] = {scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -14.445, 0)},
    ['ValveBiped.Bip01_L_Finger1'] = {scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 21.111, 0)},
    ['ValveBiped.Bip01_L_Finger3'] = {scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -12.223, -3.333)},
    ['ValveBiped.Bip01_L_Finger4'] = {scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(7.777, -23.334, -12.223)},
    ['ValveBiped.Bip01_L_Finger11'] = {scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 45.555, 0)},
}

SWEP.VElements = {['m'] = {type = 'Model', model = 'models/props/graffiti-swep.mdl', bone = 'ValveBiped.Bip01_L_Hand', rel = '', pos = Vector(-3, -6.5, 1), angle = Angle(66, 66, 87), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = '', skin = 0, bodygroup = {}}}
SWEP.WElements = {['spr'] = {type = 'Model', model = 'models/props/graffiti-swep.mdl', bone = 'ValveBiped.Bip01_R_Hand', rel = '', pos = Vector(3, 1.5, 4.7), angle = Angle(0, -100, 180), size = Vector(0.95, 0.95, 0.95), color = Color(255, 255, 255, 255), surpresslightning = false, material = '', skin = 0, bodygroup = {}}}
SWEP.WepSelectIcon = Material('entities/graffiti-swep-icon.png')

function SWEP:Initialize()
    if (CLIENT) then
        if (tostring(file.Find('graffiti_settings.txt', 'DATA')[1]) == 'graffiti_settings.txt') then
            local settings = file.Open('graffiti_settings.txt', 'r', 'DATA')
            LocalPlayer():SetNWString('GraffitiColor', settings:ReadLine():gsub('%s+', ''))
            LocalPlayer():SetNWString('GraffitiSize', settings:ReadLine():gsub('%s+', ''))
            LocalPlayer():SetNWBool('GraffitiBrush', settings:ReadLine():gsub('%s+', ''))
            LocalPlayer():SetNWInt('GraffitiSpraying', settings:ReadLine():gsub('%s+', ''))
            LocalPlayer():SetNWInt('GraffitiSlider', settings:ReadLine():gsub('%s+', ''))
            settings:Close()
        else
            LocalPlayer():SetNWString('GraffitiColor', 'Black')
            LocalPlayer():SetNWString('GraffitiSize', 'Normal')
            LocalPlayer():SetNWBool('GraffitiBrush', false)
            LocalPlayer():SetNWInt('GraffitiSpraying', 0)
            LocalPlayer():SetNWInt('GraffitiSlider', 0)
        end
        net.Start('GraffitiColorChanger')
            net.WriteEntity(LocalPlayer())
            net.WriteString(LocalPlayer():GetNWString('GraffitiColor'))
        net.SendToServer()
        net.Start('GraffitiSizeChanger')
            net.WriteEntity(LocalPlayer())
            net.WriteString(LocalPlayer():GetNWString('GraffitiSize'))
        net.SendToServer()
        net.Start('GraffitiBrushChanger')
            net.WriteEntity(LocalPlayer())
            net.WriteBool(tobool(LocalPlayer():GetNWBool('GraffitiBrush')))
        net.SendToServer()
        net.Start('GraffitiSprayingChanger')
            net.WriteEntity(LocalPlayer())
            net.WriteString(LocalPlayer():GetNWString('GraffitiSpraying'))
        net.SendToServer()

        self.VElements = table.FullCopy(self.VElements)
        self.WElements = table.FullCopy(self.WElements)
        self.ViewModelBoneMods = table.FullCopy(self.ViewModelBoneMods)

        self:CreateModels(self.VElements)
        self:CreateModels(self.WElements)

        if IsValid(self:GetOwner()) then
            local vmodel = self:GetOwner():GetViewModel()
            if IsValid(vmodel) then
                self:ResetBonePositions(vmodel)

                if (self.ShowViewModel == nil or self.ShowViewModel) then
                    vmodel:SetColor(Color(255, 255, 255, 255))
                else
                    vmodel:SetColor(Color(255, 255, 255, 1))
                    vmodel:SetMaterial('Debug/hsv')         
                end
            end
        end
    end
end

function SWEP:PrimaryAttack()
    if (self:CanPrimaryAttack()) and (SERVER) and (self.Time < CurTime()) then
        if (GetConVar('graffiti_admins_only'):GetInt() == 1) and (self:GetOwner():IsAdmin() == false) then return end
        self.spraying = CreateSound(self:GetOwner(), 'graffiti-swep/spraying.mp3')
        if (!self.spraying:IsPlaying()) then
            self.spraying:Play()
        else
            self.spraying:ChangeVolume(1, 0.1)
        end
        if (tonumber(self:GetOwner():GetNWInt('GraffitiSpraying'), 10) > 0.05) then
            self.Weapon:SetNextPrimaryFire(CurTime() + self:GetOwner():GetNWInt('GraffitiSpraying'))
            self.spraying:ChangeVolume(0, 0.2)
        end
        local effect = EffectData()
            effect:SetOrigin(self:GetOwner():GetShootPos())
            effect:SetNormal(self:GetOwner():GetAimVector())
            effect:SetEntity(self.Weapon)
            effect:SetAttachment(1)
            util.Effect('graffiti-swep', effect)

        local trace = self:GetOwner():GetEyeTrace()

        if (trace.HitPos:Distance(self:GetOwner():GetPos())) <= GetConVar('graffiti_max_distance'):GetInt() then
            if (trace.Entity:IsPlayer()) or (trace.Entity:IsPlayer()) then
                trace.Entity:TakeDamage(0.15)
            end
            if (trace.Entity == Entity(0)) then
                if (self:GetOwner():GetNWBool('GraffitiBrush') == true) then
                    if (self:GetOwner():GetNWString('GraffitiColor') == 'EmoTexture') then
                        util.Decal('nothing', trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal, nil)
                    elseif (self:GetOwner():GetNWString('GraffitiColor') == 'Amogus') then
                        util.Decal('amogus', trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal, nil)
                    elseif (self:GetOwner():GetNWString('GraffitiColor') == 'Floppa') then
                        util.Decal('floppa', trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal, nil)
                    elseif (self:GetOwner():GetNWString('GraffitiColor') == 'Shrek') then
                        util.Decal('shrek', trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal, nil)
                    end
                else
                    if (self:GetOwner():GetNWString('GraffitiSize') == 'Small') then
                        local decal = string.lower(self:GetOwner():GetNWString('GraffitiColor')) .. '-s'
                        util.Decal(decal, trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal, nil)
                    elseif (self:GetOwner():GetNWString('GraffitiSize') == 'Normal') then
                        local decal = string.lower(self:GetOwner():GetNWString('GraffitiColor')) .. '-n'
                        util.Decal(decal, trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal, nil)
                    elseif (self:GetOwner():GetNWString('GraffitiSize') == 'Large') then
                        local decal = string.lower(self:GetOwner():GetNWString('GraffitiColor')) .. '-l'
                        util.Decal(decal, trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal, nil)
                    end
                end
            end
        end
    elseif (CLIENT) then
        if (self.Time > CurTime()) then return end
        if (GetConVar('graffiti_admins_only'):GetInt() == 1) and (self:GetOwner():IsAdmin() == false) then return end
        local effect = EffectData()
            effect:SetOrigin(self:GetOwner():GetShootPos())
            effect:SetNormal(self:GetOwner():GetAimVector())
            effect:SetEntity(self.Weapon)
            effect:SetAttachment(1)
            util.Effect('graffiti-swep', effect)
    end
end
function SWEP:SecondaryAttack()
    if (CurTime() > self.Time) and (self:GetOwner():IsValid()) then
        self.Time = CurTime() + 1
        if (self.spraying != nil) and (self.spraying:IsPlaying()) then
            self.spraying:Stop()
        end
    end
    self.Weapon:CallOnClient('DermaPanel', nil)
end
 
function SWEP:Deploy()
    return true
end
 
function SWEP:Holster()
    if (CLIENT) and (IsValid(self:GetOwner())) then
        local vmodel = self:GetOwner():GetViewModel()
        if (IsValid(vmodel)) then
            self:ResetBonePositions(vmodel)
        end
    end
    if (SERVER) and (self.spraying != nil) then
        if (self.spraying:IsPlaying()) then
            self.spraying:Stop()
        end
    end
    return true
end
 
function SWEP:Reload()
    if (CurTime() > self.Time) and (self:GetOwner():IsValid()) then
        self.Time = CurTime() + 1.5
        if (self.spraying != nil) and (self.spraying:IsPlaying()) then
            self.spraying:Stop()
        end
        self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)
        self:GetOwner():SetAnimation(PLAYER_RELOAD)
        timer.Simple(0.45, function() 
            if (self:IsValid() == true) then 
                self:GetOwner():EmitSound('graffiti-swep/reloading.mp3', 100, math.random(95, 105), 1, CHAN_WEAPON)
            end
        end)
    end
end
 
function SWEP:Think()
    if (SERVER) then
        if (self:GetOwner():KeyReleased(IN_ATTACK)) and (self.spraying != nil) then
            if (self.spraying:IsPlaying()) then
                self.spraying:ChangeVolume(0, 0.1)
            end
        elseif (self:GetOwner():KeyPressed(IN_ZOOM)) and (self.spraying != nil) then
            if (self.spraying:IsPlaying()) then
                self.spraying:ChangeVolume(0, 0.1)
            end
        end
    end
end

function SWEP:OnRemove()
    self:Holster()
end

function SWEP:DermaPanel()
    if (CLIENT) then
        local Frame = vgui.Create('DFrame')
            Frame:SetSize(900, 450)
            Frame:SetPos(ScrW() / 2 - 450, ScrH() / 2 - 250)  
            Frame:SetTitle('Graffiti Сustomizer') 
            Frame:SetVisible(true) 
            Frame:SetDraggable(true) 
            Frame:ShowCloseButton(true) 
            Frame:SetPaintShadow(true)
            Frame:MakePopup()

            Frame.Paint = function(self, w, h)
                draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 200))
            end
----------------------
            local DLabel = vgui.Create('DLabel', Frame)
                DLabel:SetPos(20, 45)
                DLabel:SetFont('HDRDemoText')
                DLabel:SetColor(Color(255, 255, 255, 255))
                DLabel:SetText('Colors')

            local DColor = vgui.Create('DLabel', Frame)
                DColor:SetPos(15, 397)
                DColor:SetSize(180, 25)
                DColor:SetColor(Color(255, 255, 255, 255))
                if (LocalPlayer():GetNWBool('GraffitiBrush') == true) then
                    DColor:SetText('Brush: ')
                else
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                end
            local DSize = vgui.Create('DLabel', Frame)
                DSize:SetPos(95, 400)
                DSize:SetColor(Color(255, 255, 255, 255))
                if (LocalPlayer():GetNWBool('GraffitiBrush') == true) then
                    DSize:SetText('')
                else
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                end
            local DBrush = vgui.Create('DLabel', Frame)
                DBrush:SetPos(60, 400)
                DBrush:SetColor(Color(255, 255, 255, 255))
                if (LocalPlayer():GetNWBool('GraffitiBrush') == true) then
                    DBrush:SetText(LocalPlayer():GetNWString('GraffitiColor'))
                else
                    DBrush:SetText('')
                end
----------------------
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(25, 80)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(0, 68, 46, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Fir')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Fir')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(65, 80)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(23, 171, 137, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Emerald')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Emerald')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(105, 80)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(77, 170, 71, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Mint')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Mint')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(145, 80)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(35, 100, 176, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Ocean')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Ocean')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(185, 80)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(83, 148, 204, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Sky')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Sky')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(225, 80)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(188, 204, 233, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Linen')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Linen')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(25, 120)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(255, 207, 58, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Corn')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Corn')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(65, 120)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(247, 215, 141, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Gold')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Gold')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(105, 120)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(252, 223, 45, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Lemon')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Lemon')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(145, 120)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(217, 224, 31, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Barberry')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Barberry')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(185, 120)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(255, 237, 179, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Biscuit')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Biscuit')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(225, 120)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(218, 181, 154, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Skin')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Skin')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(25, 160)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(222, 90, 55, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Coral')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Coral')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(65, 160)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(241, 89, 83, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Assol')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Assol')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(105, 160)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(246, 146, 35, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Orange')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Orange')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(145, 160)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(203, 157, 200, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Lavender')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Lavender')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(185, 160)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(145, 121, 183, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Lilac')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Lilac')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(225, 160)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(144, 59, 126, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Plum')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Plum')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(25, 200)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(0, 0, 0, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Black')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Black')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(65, 200)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(90, 90, 92, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Graphite')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Graphite')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(105, 200)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(103, 104, 106, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Shadow')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Shadow')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(145, 200)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(147, 149, 157, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Asphalt')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Asphalt')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(185, 200)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(241, 241, 242, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Silver')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Silver')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(225, 200)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(255, 255, 255, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'White')
                    LocalPlayer():SetNWBool('GraffitiBrush', false)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('White')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(false)
                    net.SendToServer()
                    DColor:SetText('Color: ' .. LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    DBrush:SetText('')
                end
----------------------
            local DLabel = vgui.Create('DLabel', Frame)
                DLabel:SetPos(600, 45)
                DLabel:SetFont('HDRDemoText')
                DLabel:SetColor(Color(255, 255, 255, 255))
                DLabel:SetText('Brush')
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(610, 80)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(111, 111, 111, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'EmoTexture')
                    LocalPlayer():SetNWBool('GraffitiBrush', true)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('EmoTexture')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(true)
                    net.SendToServer()
                    DColor:SetText('Brush: ')
                    DBrush:SetText(LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(650, 80)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(111, 111, 111, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Amogus')
                    LocalPlayer():SetNWBool('GraffitiBrush', true)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Amogus')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(true)
                    net.SendToServer()
                    DColor:SetText('Brush: ')
                    DBrush:SetText(LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(690, 80)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(111, 111, 111, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Floppa')
                    LocalPlayer():SetNWBool('GraffitiBrush', true)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Floppa')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(true)
                    net.SendToServer()
                    DColor:SetText('Brush: ')
                    DBrush:SetText(LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('')
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(730, 80)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(111, 111, 111, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiColor', 'Shrek')
                    LocalPlayer():SetNWBool('GraffitiBrush', true)
                    net.Start('GraffitiColorChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Shrek')
                    net.SendToServer()
                    net.Start('GraffitiBrushChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteBool(true)
                    net.SendToServer()
                    DColor:SetText('Brush: ')
                    DBrush:SetText(LocalPlayer():GetNWString('GraffitiColor'))
                    DSize:SetText('')
                end
----------------------
            local DLabel = vgui.Create('DLabel', Frame)
                DLabel:SetPos(600, 130)
                DLabel:SetFont('HDRDemoText')
                DLabel:SetColor(Color(255, 255, 255, 255))
                DLabel:SetText('Size')
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(610, 165)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(140, 140, 140, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiSize', 'Small')
                    net.Start('GraffitiSizeChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Small')
                    net.SendToServer()
                    if (LocalPlayer():GetNWBool('GraffitiBrush') == true) then
                        DSize:SetText('')
                    else
                        DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    end
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(650, 165)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(140, 140, 140, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiSize', 'Normal')
                    net.Start('GraffitiSizeChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Normal')
                    net.SendToServer()
                    if (LocalPlayer():GetNWBool('GraffitiBrush') == true) then
                        DSize:SetText('')
                    else
                        DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    end
                end
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(690, 165)
                DermaButton:SetSize(35, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(140, 140, 140, 255))
                    end
                DermaButton.DoClick = function()
                    LocalPlayer():SetNWString('GraffitiSize', 'Large')
                    net.Start('GraffitiSizeChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString('Large')
                    net.SendToServer()
                    if (LocalPlayer():GetNWBool('GraffitiBrush') == true) then
                        DSize:SetText('')
                    else
                        DSize:SetText('Size: ' .. LocalPlayer():GetNWString('GraffitiSize'))
                    end
                end
----------------------
            local DLabel = vgui.Create('DLabel', Frame)
                DLabel:SetPos(600, 210)
               DLabel:SetSize(200, 25)
                DLabel:SetFont('HDRDemoText')
                DLabel:SetColor(Color(255, 255, 255, 255))
                DLabel:SetText('Next Spraying')
            local DNumSlider = vgui.Create('DNumSlider', Frame)
                DNumSlider:SetPos(440, 240)
                DNumSlider:SetSize(400, 25)
                DNumSlider:SetText('')
                DNumSlider:SetMin(0)
                DNumSlider:SetMax(5)
                DNumSlider:SetValue(LocalPlayer():GetNWInt('GraffitiSpraying'))
            DNumSlider.OnValueChanged = function(panel, value)
                if (value != LocalPlayer():GetNWInt('GraffitiSpraying')) then
                    LocalPlayer():SetNWInt('GraffitiSpraying', value)
                    net.Start('GraffitiSprayingChanger')
                        net.WriteEntity(LocalPlayer())
                        net.WriteString(tonumber(value))
                    net.SendToServer()
                end
            end
            local DNumSlider = vgui.Create('DNumSlider', Frame)
                DNumSlider:SetPos(440, 280)
                DNumSlider:SetSize(400, 25)
                DNumSlider:SetText('')
                DNumSlider:SetMin(0)
                DNumSlider:SetMax(5)
                DNumSlider:SetValue(LocalPlayer():GetNWInt('GraffitiSlider'))
            DNumSlider.OnValueChanged = function(panel, value)
                if (value != LocalPlayer():GetNWInt('GraffitiSlider')) then
                    LocalPlayer():SetNWInt('GraffitiSlider', value)
                end
            end
            local DLabel = vgui.Create('DLabel', Frame)
                DLabel:SetPos(648, 295)
                DLabel:SetSize(200, 25)
                DLabel:SetColor(Color(255, 255, 255, 255))
                DLabel:SetText('NumSlider (do nothing)')
----------------------
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(625, 350)
                DermaButton:SetSize(200, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(205, 205, 205, 255))
                    end
                DermaButton.DoClick = function()
                    RunConsoleCommand('graffiti_clear', nil)
                    if (LocalPlayer():IsAdmin() and LocalPlayer():IsValid()) then
                        LocalPlayer():EmitSound('derma/gclear.mp3', 100, math.random(90, 120), 1, CHAN_AUTO)
                    end
                end
            local DLabel = vgui.Create('DLabel', Frame)
                DLabel:SetPos(650, 355)
                DLabel:SetSize(200, 25)
                DLabel:SetColor(Color(110, 110, 110, 255))
                DLabel:SetText('Graffiti Clear (Server Host Only)')
            local DermaButton = vgui.Create('DButton', Frame)
                DermaButton:SetText('')
                DermaButton:SetPos(625, 395)
                DermaButton:SetSize(200, 35)
                DermaButton.Paint = function(self, w, h)
                        draw.RoundedBox(5, 0, 0, w, h, Color(205, 205, 205, 255))
                    end
                DermaButton.DoClick = function()
                    local ply = LocalPlayer()
                    file.Write('graffiti_settings.txt', ply:GetNWString('GraffitiColor') .. '\n' .. ply:GetNWString('GraffitiSize') .. '\n' .. tostring(ply:GetNWBool('GraffitiBrush')) .. '\n' .. ply:GetNWInt('GraffitiSpraying') .. '\n' .. ply:GetNWInt('GraffitiSlider'))
                    ply:EmitSound('derma/gsaved.mp3', 100, math.random(90, 120), 1, CHAN_AUTO)
                end
            local DLabel = vgui.Create('DLabel', Frame)
                DLabel:SetPos(680, 400)
                DLabel:SetSize(200, 25)
                DLabel:SetColor(Color(110, 110, 110, 255))
                DLabel:SetText('Save Your Settings')
----------------------
            local DLabel = vgui.Create('DLabel', Frame)
                DLabel:SetPos(10, 425)
                DLabel:SetSize(100, 25)
                DLabel:SetColor(Color(120, 120, 120, 255))
                DLabel:SetText('Created by T1ger')
                DLabel:SetMouseInputEnabled(true)
            DLabel.DoDoubleClick = function()
                LocalPlayer():EmitSound('derma/gsecret.mp3', 100, math.random(90, 120), 1, CHAN_AUTO)
                net.Start('SecretChanger')
                    net.WriteEntity(LocalPlayer())
                net.SendToServer()
            end
    end
end