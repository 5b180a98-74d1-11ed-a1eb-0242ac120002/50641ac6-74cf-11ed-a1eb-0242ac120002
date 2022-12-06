function EFFECT:Init(data)
	self.Vec = data:GetNormal()
	self.Col = data:GetStart()
	self.StartPos = self:GetTracerShootPos(data:GetOrigin(), data:GetEntity(), data:GetAttachment())
	
	self.Emitter = ParticleEmitter(self.StartPos)
	
	for parts = 1, 1 do
		local p = self.Emitter:Add("sprites/orangecore1", self.StartPos)
		p:SetDieTime(math.Rand(0.5, 1))
		p:SetStartSize(1)
		p:SetVelocity(self.Vec * 200)
		p:SetEndSize(math.Rand(5, 25))
		p:SetStartAlpha(255)
		p:SetEndAlpha(0)
		p:SetColor(self.Col.x, self.Col.y, self.Col.z)
		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-10, 10))
		p:SetCollide(true)
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
