#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\system_shared;

#namespace squads;

// Namespace squads/squads
// Params 0, eflags: 0x6
// Checksum 0x1fbf4ede, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"squads", &__init__, undefined, undefined, undefined );
}

// Namespace squads/squads
// Params 0
// Checksum 0x9f09ebe6, Offset: 0xd0
// Size: 0x134
function __init__()
{
    if ( currentsessionmode() != 4 )
    {
        level.var_c58668ea = getgametypesetting( #"hash_5462586bdce0346e" );
        level.var_3312552 = getgametypesetting( #"hash_7cc354dd83013a47" );
    }
    
    level.squad = { #count:function_bb1ab64b() };
    level.squads = [];
    
    for ( squad_index = 1; squad_index <= level.squad.count ; squad_index++ )
    {
        squad_name = "squad_" + squad_index;
        level.squads[ hash( "squad_" + squad_index ) ] = { #name:squad_name };
    }
}

// Namespace squads/squads
// Params 0
// Checksum 0x48154e6a, Offset: 0x210
// Size: 0x1a, Type: bool
function function_a9758423()
{
    return level.squad.count > 0;
}

// Namespace squads/squads
// Params 0, eflags: 0x4
// Checksum 0x105da5f6, Offset: 0x238
// Size: 0x22
function private function_bb1ab64b()
{
    return getdvarint( #"com_maxclients", 0 );
}

// Namespace squads/squads
// Params 0
// Checksum 0x23ff6384, Offset: 0x268
// Size: 0xa2
function function_43a7bead()
{
    foreach ( squad, _ in level.squads )
    {
        if ( self function_59396fe8( squad ) )
        {
            return squad;
        }
    }
    
    return #"none";
}

// Namespace squads/squads
// Params 1
// Checksum 0xc75c4c, Offset: 0x318
// Size: 0x42, Type: bool
function function_59396fe8( squad )
{
    var_74578e76 = function_c65231e2( squad );
    
    if ( var_74578e76.size > 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace squads/squads
// Params 1
// Checksum 0x61fc4df2, Offset: 0x368
// Size: 0xe2
function function_fc04a299( party )
{
    foreach ( member in party.party_members )
    {
        if ( self == member )
        {
            continue;
        }
        
        if ( member.squad != #"none" && member.squad != #"invalid" )
        {
            return member.squad;
        }
    }
    
    return #"none";
}

// Namespace squads/squads
// Params 1
// Checksum 0x3dc7efbd, Offset: 0x458
// Size: 0xfa
function function_c98289a5( team )
{
    teammates = getplayers( team );
    
    foreach ( player in teammates )
    {
        if ( self == player )
        {
            continue;
        }
        
        if ( player.squad != #"none" && player.squad != #"invalid" )
        {
            return player.squad;
        }
    }
    
    return #"none";
}

// Namespace squads/squads
// Params 0
// Checksum 0xffe6a191, Offset: 0x560
// Size: 0xaa
function function_faeb0876()
{
    status = self player::function_3d288f14();
    squad = self function_33843308( status );
    
    if ( squad == #"none" )
    {
        squad = function_43a7bead();
    }
    
    if ( squad == #"none" )
    {
        squad = function_4f237b02();
    }
    
    return squad;
}

// Namespace squads/squads
// Params 1
// Checksum 0x6e4fe70b, Offset: 0x618
// Size: 0x2c
function function_46edfa55( var_74578e76 )
{
    return level.var_704bcca1 - player::function_1cec6cba( var_74578e76 );
}

// Namespace squads/squads
// Params 1
// Checksum 0x1e125452, Offset: 0x650
// Size: 0xce, Type: bool
function function_a65e2082( squad )
{
    var_74578e76 = function_c65231e2( squad );
    
    if ( var_74578e76.size >= level.var_704bcca1 )
    {
        return false;
    }
    
    if ( var_74578e76.size > 0 )
    {
        if ( var_74578e76[ 0 ].team != self.team )
        {
            return false;
        }
    }
    
    available_spots = function_46edfa55( var_74578e76 );
    party = self getparty();
    
    if ( party.var_a15e4438 > available_spots )
    {
        return false;
    }
    
    return true;
}

// Namespace squads/squads
// Params 0
// Checksum 0xd0ab719b, Offset: 0x728
// Size: 0xa2
function function_4f237b02()
{
    foreach ( squad, _ in level.squads )
    {
        if ( self function_a65e2082( squad ) )
        {
            return squad;
        }
    }
    
    return #"none";
}

// Namespace squads/squads
// Params 1
// Checksum 0xa13518c9, Offset: 0x7d8
// Size: 0x12a
function function_33843308( status )
{
    foreach ( squad_name, squad in level.squads )
    {
        if ( status == #"game" )
        {
            if ( isdefined( squad.voip ) && squad.voip != #"game" )
            {
                continue;
            }
        }
        else if ( isdefined( squad.voip ) && squad.voip == #"game" )
        {
            continue;
        }
        
        if ( self function_a65e2082( squad_name ) )
        {
            return squad_name;
        }
    }
    
    return #"none";
}

// Namespace squads/squads
// Params 1
// Checksum 0x5c6c1d30, Offset: 0x910
// Size: 0x50, Type: bool
function function_b0c92599( party )
{
    if ( isdefined( level.var_7d3ed2bf ) && level.var_7d3ed2bf && isdefined( party ) && party.fill == 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace squads/squads
// Params 0, eflags: 0x4
// Checksum 0x10d249aa, Offset: 0x968
// Size: 0x62
function private function_f65acad1()
{
    if ( getdvarint( #"hash_587d8e03df4f4f8a", 0 ) )
    {
        squad = function_4f237b02();
    }
    else
    {
        squad = self function_faeb0876();
    }
    
    return squad;
}

// Namespace squads/squads
// Params 1, eflags: 0x4
// Checksum 0x4cf4eb64, Offset: 0x9d8
// Size: 0x6a
function private function_49c2a7d1( party )
{
    if ( level.var_c58668ea && function_b0c92599( party ) )
    {
        squad = function_43a7bead();
    }
    else
    {
        squad = function_f65acad1();
    }
    
    return squad;
}

// Namespace squads/squads
// Params 0
// Checksum 0xe805f7f1, Offset: 0xa50
// Size: 0x21c
function function_c70b26ea()
{
    if ( level.var_c58668ea )
    {
        squad = function_c98289a5( self.team );
        
        if ( squad == #"none" )
        {
            squad = function_43a7bead();
        }
    }
    else
    {
        squad = #"none";
        party = self getparty();
        
        if ( isdefined( party ) && party.var_a15e4438 > 1 )
        {
            squad = function_fc04a299( party );
            
            if ( squad == #"none" )
            {
                squad = function_49c2a7d1();
            }
        }
        
        if ( !isdefined( squad ) || squad == #"none" )
        {
            if ( level.var_3312552 )
            {
                squad = function_f65acad1();
            }
        }
    }
    
    /#
        var_d1f1fdbf = getdvarstring( #"hash_1c90c9250b52435a", "<dev string:x38>" );
        var_8ec96d19 = strtok( var_d1f1fdbf, "<dev string:x3c>" );
        
        if ( var_8ec96d19.size > 0 )
        {
            playersquad = var_8ec96d19[ self getentitynumber() ];
            
            if ( isdefined( playersquad ) && isdefined( level.squads[ playersquad ] ) )
            {
                squad = hash( playersquad );
            }
        }
    #/
    
    self function_ff3321ee( squad );
}

// Namespace squads/squads
// Params 1
// Checksum 0x5ff5f8aa, Offset: 0xc78
// Size: 0x13a
function function_ff3321ee( squad_name )
{
    self.pers[ #"squad" ] = squad_name;
    self.squad = squad_name;
    self.pers[ #"teammateindex" ] = 0;
    self.teammateindex = 0;
    self function_a4c9eb05();
    
    if ( isdefined( level.squads[ squad_name ] ) )
    {
        squad = level.squads[ squad_name ];
        status = self player::function_3d288f14();
        
        if ( !isdefined( squad.voip ) || status != squad.voip && status == #"game" )
        {
            if ( status == #"game" )
            {
                squad.voip = #"game";
                return;
            }
            
            squad.voip = #"none";
        }
    }
}

// Namespace squads/squads
// Params 1, eflags: 0x4
// Checksum 0x8d3e6a37, Offset: 0xdc0
// Size: 0x92
function private function_2405134( party )
{
    foreach ( index, party_member in party.party_members )
    {
        if ( party_member == self )
        {
            return index;
        }
    }
    
    return 0;
}

// Namespace squads/squads
// Params 2, eflags: 0x4
// Checksum 0x70a5b1c8, Offset: 0xe60
// Size: 0x9c, Type: bool
function private function_e249c6ae( squadmates, index )
{
    foreach ( player in squadmates )
    {
        if ( player.teammateindex == index )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace squads/squads
// Params 2, eflags: 0x4
// Checksum 0xa21236cf, Offset: 0xf08
// Size: 0x4a
function private function_114b9455( squadmates, start_index )
{
    for ( var_cd210c3e = start_index; function_e249c6ae( squadmates, var_cd210c3e ) ; var_cd210c3e++ )
    {
    }
    
    return var_cd210c3e;
}

// Namespace squads/squads
// Params 2, eflags: 0x4
// Checksum 0x8a789b8e, Offset: 0xf60
// Size: 0x12a
function private function_e034942e( squadmates, party )
{
    var_798f38a5 = [];
    last_index = 1;
    
    foreach ( party_member in party.party_members )
    {
        if ( party_member.teammateindex > 0 )
        {
            last_index = party_member.teammateindex;
        }
        else
        {
            last_index = function_114b9455( squadmates, last_index );
        }
        
        if ( !isdefined( var_798f38a5 ) )
        {
            var_798f38a5 = [];
        }
        else if ( !isarray( var_798f38a5 ) )
        {
            var_798f38a5 = array( var_798f38a5 );
        }
        
        var_798f38a5[ var_798f38a5.size ] = last_index;
    }
    
    return var_798f38a5;
}

// Namespace squads/squads
// Params 0
// Checksum 0x2bd1173d, Offset: 0x1098
// Size: 0x114
function function_a4c9eb05()
{
    if ( self.squad != #"invalid" )
    {
        squadmates = function_c65231e2( self.squad );
    }
    else
    {
        squadmates = getplayers( self.team );
    }
    
    party = self getparty();
    var_587898e8 = function_2405134( party );
    var_460d5e63 = function_e034942e( squadmates, party );
    assert( var_460d5e63.size > var_587898e8 );
    self.teammateindex = var_460d5e63[ var_587898e8 ];
    self.pers[ #"teammateindex" ] = self.teammateindex;
}

