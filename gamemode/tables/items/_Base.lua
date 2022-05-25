AS.Items = {}
function AS.AddBaseItem( id, data )
    AS.Items = AS.Items or {}

    AS.Items[id] = data
end
-- I know this file is kind of weird. It needs to be loaded first before the rest of the item files are.