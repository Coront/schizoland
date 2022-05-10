timer.Create( "as_autosave", 300, 0, function()
	if LocalPlayer():IsLoaded() then
		LocalPlayer():ChatPrint("Auto Saving...")
		LocalPlayer():ConCommand("as_save")
	end
end)

function GM:OnPlayerChat( ply, txt, team, dead )
	local tab = {}

	if ( IsValid( ply ) ) then
		table.insert( tab, AS.Classes[ply:GetASClass()].color )
		table.insert( tab, ply:Nickname() )
		table.insert( tab, color_white )
		table.insert( tab, ": " .. txt )
	else
		table.insert( tab, Color( 0, 180, 195 ) )
		table.insert( tab, txt )
	end

	chat.AddText( unpack(tab) )

	return true
end

function GM:DrawPhysgunBeam( ply, wep, bool, target, phys, hit )
    if ply:IsDeveloping() and not IsValid(target) then return false end
    return true
end

function GetPos( ply )
    local pos = ply:GetPos():ToTable()
    local str = "Vector( " .. math.Round(pos[1], 2) .. ", " .. math.Round(pos[2], 2) .. ", " .. math.Round(pos[3], 2) .. " )"
    ply:ChatPrint( str )
    SetClipboardText( str )
end
concommand.Add("GetPosV2", GetPos)

hook.Add( "ChatText", "AS_HideJoinLeave", function( index, name, text, type ) 
    if type == "joinleave" or type == "namechange" or type == "teamchange" then return true end
end)

hook.Add("PostDrawOpaqueRenderables", "AS_ArmorOverlay", function()
    for k, v in pairs( player.GetAll() ) do
        if not v:IsLoaded() then continue end
        if not v:Alive() then continue end
        if not v:HasArmor() then 
            v.HideDefault = false 
            timer.Simple( 0.1, function() --bruh
                if IsValid(v) and v:Alive() then 
                    v.LastArmorModel = nil 
                end 
            end) 
            continue 
        end 
        if v:HasArmor() and not v:GetArmorWep().ArmorModel then continue end

        render.SetBlend( 1 )
        render.SetLightingMode( 0 )

        local armorwep = v:GetArmorWep()
        if not IsValid( v.ArmorOverlay ) then --We'll create a new client model if they don't have one.
            v.ArmorOverlay = ClientsideModel( armorwep.ArmorModel )
            v.ArmorOverlay:SetNoDraw( true )
        end
        v.LastArmorModel = armorwep.ArmorModel

        if v.ArmorOverlay:GetModel() != armorwep.ArmorModel then
            v.ArmorOverlay:SetModel( armorwep.ArmorModel )
        end

        if armorwep.HideDefault then
            v.HideDefault = true
        else
            v.HideDefault = false
        end

        if IsValid( v.ArmorOverlay ) then
            if armorwep.BoneMerge then --Bone merging
                v.ArmorOverlay:SetParent( v )
                v.ArmorOverlay:AddEffects( EF_BONEMERGE )
            end
            if armorwep.Scale or armorwep.ScaleFemale then
                local scale = v:IsFemale() and armorwep.ScaleFemale or armorwep.Scale or 1
                for i = 0, v.ArmorOverlay:GetBoneCount() do
                    v.ArmorOverlay:ManipulateBoneScale( i, Vector( scale, scale, scale ) )
                end
            end
            v.ArmorOverlay:DrawModel()
        end
    end
end)

hook.Add("PostDrawOpaqueRenderables", "AS_DeathDollArmor", function()
    for k, v in pairs( player.GetAll() ) do
        if v:Alive() then continue end
        if v:GetRagdollEntity() and IsValid(v:GetRagdollEntity()) and v.LastArmorModel then
            local deathdoll = v:GetRagdollEntity()
            if not deathdoll.ArmorOverlay then
                deathdoll.ArmorOverlay = ClientsideModel( v.LastArmorModel )
                deathdoll.ArmorOverlay:SetNoDraw( true )
            end

            deathdoll.ArmorOverlay:SetParent( deathdoll )
            deathdoll.ArmorOverlay:AddEffects( EF_BONEMERGE )
            deathdoll.ArmorOverlay:DrawModel()
        end
    end
end)

hook.Add("PrePlayerDraw", "AS_PlayerHide", function( ply )
    if (ply:GetMoveType() == MOVETYPE_NOCLIP and not ply:InVehicle()) and not LocalPlayer():IsDeveloping() then return true end
    if ply.HideDefault then
        ply:SetMaterial( "Models/effects/vol_light001" )
    else
        ply:SetMaterial( "" )
    end
end)

hook.Add("HUDPaint", "AS_Treatment", function()
    if LocalPlayer():GetASClass() != "scientist" then return end
    local tr = LocalPlayer():TraceFromEyes( 80 )
    local ent = tr.Entity
    if not ent:IsPlayer() then return end
    if ent:Health() >= ent:GetMaxHealth() then return end

    local pos = (ent:GetPos() + ent:OBBCenter()):ToScreen()
    local txt = "Press [" .. string.upper(KEYBIND_USE) .. "] to treat wounds."
    draw.SimpleTextOutlined( txt, "TargetID", pos.x, pos.y, COLHUD_DEFAULT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
end)

hook.Add("CalcView", "AS_PlayerRagdollCamera", function( ply,pos, angle, lastfov, znear, zfar )
    if LocalPlayer():Alive() then return end --Not neccessary if player is alive.

    local doll = ply:GetRagdollEntity()
    if not IsValid(doll) then return end

    local bone = doll:LookupBone( "ValveBiped.Bip01_Head1" )
    local newpos, newang = doll:GetBonePosition( bone )

    newang:RotateAroundAxis( newang:Forward(), 270 )
    newang:RotateAroundAxis( newang:Right(), 270 )

    newpos = newpos + 6 * newang:Forward()

    local view = {
        origin = newpos,
        angles = newang,
        fov = lastfov,
        znear = 1,
    }

    return view
end)

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

AS_ClientConVar( "as_gameplay_deathstinger", "1", true, false )

net.Receive( "as_chatmessage", function()
    local tbl = net.ReadTable()
    chat.AddText( unpack( tbl ) )
end)

net.Receive( "as_deathstinger", function()
    local snd = net.ReadString()

    if tobool( GetConVar("as_gameplay_deathstinger"):GetInt() ) then 
        surface.PlaySound( snd )
    end
end)