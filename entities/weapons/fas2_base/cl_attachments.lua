local found, t, num, wep, att, total

function SWEP.PlayerBindPress(ply, b, p)
	if p then
		wep = ply:GetActiveWeapon()

		if wep.IsFAS2Weapon then
			if b == "+menu_context" and not wep.NoAttachmentMenu then
				if wep.dt.Status != FAS_STAT_ADS then
					if not wep.dt.Bipod then
						if wep.Attachments then
							wep.ShowStats = false
						else
							wep.ShowStats = true
						end
						
						RunConsoleCommand("fas2_togglegunpimper")
						return true
					end
				else
					wep.Peeking = true
					return true
				end
			end
			
			if b == "+use" then
				if wep.dt.Status == FAS_STAT_CUSTOMIZE then
					if wep.Attachments then
						wep.ShowStats = !wep.ShowStats
					end
					
					return true
				end
			end
			
			if wep.Attachments then
				if wep.dt.Status == FAS_STAT_CUSTOMIZE then
					if b:find("slot") then
						if wep.ShowStats then
							return true
						end
					
						num = tonumber(string.Right(b, 1))
						
						if wep.Attachments[num] then
							att = wep:CycleAttachments(num)
							
							if not att then
								wep:Detach(num)
							else
								wep:Attach(num, att)
							end
						end
						
						return true
					end
				end
			end
		end
	else
		if b == "+menu_context" then
			wep.Peeking = false
		end
	end
end

hook.Add("PlayerBindPress", "SWEP.PlayerBindPress (FAS2)", SWEP.PlayerBindPress)

function SWEP:CycleAttachments(group)
	t = self.Attachments[group]
	found = false
	total = 0
	
	for k, v in ipairs(t.atts) do
		if not t.last then
			t.last = {}
		end
		
		if table.HasValue(FAS2AttOnMe, v) then
			total = total + 1
			
			if not t.last[v] then
				found = v
				break
			end
		end
	end
	
	if total == 0 then
		surface.PlaySound("weapons/noattachments.wav")
	end
	
	return found
end

function SWEP:Detach(att)
	self.Owner:ConCommand("fas2_detach " .. att)
end

function SWEP:Attach(group, att)
	self.Owner:ConCommand("fas2_attach " .. group .. " " .. att)
end

function SWEP:AttachBodygroup(att)
	if self.AttachmentBGs and self.AttachmentBGs[att] then
		self.Wep:SetBodygroup(self.AttachmentBGs[att].bg, self.AttachmentBGs[att].sbg)
	end
end

function SWEP:DetachBodygroup(att)
	if self.Attachments[att].active and self.AttachmentBGs and self.AttachmentBGs[self.Attachments[att].active] then
		self.Wep:SetBodygroup(self.AttachmentBGs[self.Attachments[att].active].bg, 0)
	end
end