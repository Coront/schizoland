hook.Add("EntityTakeDamage", "AS_Stress", function( target, dmginfo )
    if not tobool(GetConVar("as_stress"):GetInt()) then return end
    if not target:IsNPC() and not target:IsPlayer() and not target:IsNextBot() then return end
    local attacker = dmginfo:GetAttacker()
    if attacker:IsWorld() then return end
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