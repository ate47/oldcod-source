#namespace player_role;

// Namespace player_role/player_role
// Params 1
// Checksum 0x49885343, Offset: 0x80
// Size: 0xb4, Type: bool
function is_valid( index )
{
    if ( !isdefined( index ) )
    {
        return false;
    }
    
    /#
        if ( getdvarint( "<dev string:x28>", 0 ) == 1 )
        {
            return ( index >= 0 && index < getplayerroletemplatecount( currentsessionmode() ) );
        }
    #/
    
    return index > 0 && index < getplayerroletemplatecount( currentsessionmode() );
}

