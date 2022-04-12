local Dir, Dir2, dot, sp, ent, trace, seed, hm
local trace_normal = bit.bor(CONTENTS_SOLID, CONTENTS_OPAQUE, CONTENTS_MOVEABLE, CONTENTS_DEBRIS, CONTENTS_MONSTER, CONTENTS_HITBOX, 402653442, CONTENTS_WATER)
local trace_walls = bit.bor(CONTENTS_TESTFOGVOLUME, CONTENTS_EMPTY, CONTENTS_MONSTER, CONTENTS_HITBOX)
local NoPenetration = {[MAT_SLOSH] = true}
local NoRicochet = {[MAT_FLESH] = true, [MAT_ANTLION] = true, [MAT_BLOODYFLESH] = true, [MAT_DIRT] = true, [MAT_SAND] = true, [MAT_GLASS] = true, [MAT_ALIENFLESH] = true}
local PenMod = {[MAT_SAND] = 0.5, [MAT_DIRT] = 0.8, [MAT_METAL] = 1.1, [MAT_TILE] = 0.9, [MAT_WOOD] = 1.2}
local bul, tr = {}, {}
local SP = game.SinglePlayer()

local reg = debug.getregistry()
local GetShootPos = reg.Player.GetShootPos
local GetCurrentCommand = reg.Player.GetCurrentCommand
local CommandNumber = reg.CUserCmd.CommandNumber

function SWEP:FireBullet()
	sp = GetShootPos(self.Owner)
	math.randomseed(CurTime())
	
	Dir = (self.Owner:EyeAngles() + self.Owner:GetPunchAngle() + Angle(math.Rand(-self.CurCone, self.CurCone), math.Rand(-self.CurCone, self.CurCone), 0) * 25):Forward()

	for i = 1, self.Shots do
		Dir2 = Dir
		
		if self.ClumpSpread and self.ClumpSpread > 0 then
			Dir2 = Dir + Vector(math.Rand(-1, 1), math.Rand(-1, 1), math.Rand(-1, 1)) * self.ClumpSpread
		end
		
		bul.Num = 1
		bul.Src = sp
		bul.Dir = Dir2
		bul.Spread 	= Vector(0, 0, 0)
		if self.Tracer then
			bul.Tracer = self.Tracer
		else
			bul.Tracer = 4
		end
		bul.Force	= self.Damage * 0.1
		bul.Damage = math.Round(self.Damage)
		bul.Callback = function( attacker, tr, dmginfo )
			local damagetype = self.DamageType or DMG_BULLET
			dmginfo:SetDamageType( DMG_BULLET )
		end
		self.Owner:FireBullets(bul)
		if engine.ActiveGamemode() == "aftershock" then
			self.Owner:IncreaseSkillExperience( "weaponhandling", SKL.WeaponHandling.incamt )
		end
	end
end