function EFFECT:Init(data)
    self.Vector = data:GetNormal()
    self.StartPos = self:GetTracerShootPos(data:GetOrigin(), data:GetEntity(), data:GetAttachment())
    self.Emitter = ParticleEmitter(self.StartPos)

    for i = 1, 5 do
        local particle = self.Emitter:Add('sprites/orangecore1', self.StartPos)
        particle:SetDieTime(math.Rand(0.3, 0.4))
        particle:SetStartSize(0.5)
        particle:SetVelocity(self.Vector * 200)
        particle:SetEndSize(math.Rand(5, 15))
        particle:SetStartAlpha(255)
        particle:SetEndAlpha(0)
        particle:SetColor(50, 50, 50)
        particle:SetRoll(math.Rand(-10, 10))
        particle:SetRollDelta(math.Rand(-10, 10))
        particle:SetCollide(true)
    end
end

function EFFECT:Think()
    return false
end

function EFFECT:Render()
end