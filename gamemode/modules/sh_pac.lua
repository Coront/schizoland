if pac then --I could be dumb, but pac.addhook doesnt want to work with 'CanWearParts', so i just made my own function.

    PACWhitelist = PACWhitelist or {}

    function pac.FetchWhitelist() --Will run through the database to fetch all of the whitelists.
        local db = sql.Query("SELECT * FROM pac_whitelist")
        if not db then return end --Nothing to fetch.
        for k, v in pairs( db ) do
            PACWhitelist[v.steamid] = {date = v.date, admin = v.admin}
        end
    end

    function pac.AddToWhitelist( ply, steamid )
        PACWhitelist[steamid] = {
            date = os.date( "%m/%d/%y - %I:%M %p", os.time() ),
            admin = ply:Nickname()
        }

        sql.Query("INSERT INTO pac_whitelist VALUES( " .. SQLStr( steamid ) .. ", " .. SQLStr( os.date( "%m/%d/%y - %I:%M %p", os.time() ) ) .. ", " .. SQLStr( ply:Nickname() ) .. " )")
    end

    function pac.RemoveFromWhitelist( ply, steamid )
        PACWhitelist[steamid] = nil

        sql.Query("DELETE FROM pac_whitelist WHERE steamid = " .. SQLStr( steamid ) )
    end

    function PlayerMeta:IsPACWhitelisted()
        if PACWhitelist[self:SteamID()] then return true end
        return false
    end

    function pac.PlayerCanWearParts( ply )
        if ply:IsAdmin() then return true end
        if ply:IsPACWhitelisted() then return true end
        
        ply:ChatPrint("You must be whitelisted in order to wear your PAC.")
        return false
    end

    hook.Add( "Initialize", "AS_PACWhitelist", function()
        print("Fetching PAC3 Whitelist.")
        pac.FetchWhitelist()
    end)
end