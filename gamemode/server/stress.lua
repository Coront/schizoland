hook.Add("EntityTakeDamage", "AS_Stress", function( target, dmginfo )
    if not tobool(GetConVar("as_stress"):GetInt()) then return end
    if not target:IsNPC() or not target:IsPlayer() or not target:IsNextBot() then return end
    local attacker = dmginfo:GetAttacker()
    local length = attacker:IsPlayer() and target:IsPlayer() and SET.PlyCombatLength or SET.CombatLength

    if target:IsPlayer() then
        target:UpdateStress( length )
        target:ResyncStress()
    end

    if attacker:IsPlayer() then
        attacker:UpdateStress( length )
        attacker:ResyncStress()
    end
end)