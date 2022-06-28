AS.Items = {}
function AS.AddBaseItem( id, data )
    AS.Items = AS.Items or {}

    AS.Items[id] = data

    if data.model and not data.nomodelblacklist then
        PERM.PropBlacklist[string.lower(data.model)] = true
    end
end
-- I know this file is kind of weird. It needs to be loaded first before the rest of the item files are.