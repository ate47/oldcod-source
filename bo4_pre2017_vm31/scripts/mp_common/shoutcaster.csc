#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace shoutcaster;

// Namespace shoutcaster/shoutcaster
// Params 1
// Checksum 0x9be9d606, Offset: 0x138
// Size: 0x22
function is_shoutcaster( localclientnum )
{
    return isshoutcaster( localclientnum );
}

// Namespace shoutcaster/shoutcaster
// Params 1
// Checksum 0xf2346f37, Offset: 0x168
// Size: 0x42, Type: bool
function is_shoutcaster_using_team_identity( localclientnum )
{
    return is_shoutcaster( localclientnum ) && getshoutcastersetting( localclientnum, "shoutcaster_team_identity" );
}

// Namespace shoutcaster/shoutcaster
// Params 2
// Checksum 0xa63f57a8, Offset: 0x1b8
// Size: 0x62
function get_team_color_id( localclientnum, team )
{
    if ( team == "allies" )
    {
        return getshoutcastersetting( localclientnum, "shoutcaster_fe_team1_color" );
    }
    
    return getshoutcastersetting( localclientnum, "shoutcaster_fe_team2_color" );
}

// Namespace shoutcaster/shoutcaster
// Params 3
// Checksum 0x751c0fa6, Offset: 0x228
// Size: 0x5e
function get_team_color_fx( localclientnum, team, script_bundle )
{
    color = get_team_color_id( localclientnum, team );
    return script_bundle.objects[ color ].fx_colorid;
}

// Namespace shoutcaster/shoutcaster
// Params 2
// Checksum 0x51355e66, Offset: 0x290
// Size: 0x86
function get_color_fx( localclientnum, script_bundle )
{
    effects = [];
    effects[ "allies" ] = get_team_color_fx( localclientnum, "allies", script_bundle );
    effects[ "axis" ] = get_team_color_fx( localclientnum, "axis", script_bundle );
    return effects;
}

// Namespace shoutcaster/shoutcaster
// Params 1
// Checksum 0x79e57918, Offset: 0x320
// Size: 0xa2
function is_friendly( localclientnum )
{
    localplayer = getlocalplayer( localclientnum );
    scorepanel_flipped = getshoutcastersetting( localclientnum, "shoutcaster_flip_scorepanel" );
    
    if ( !scorepanel_flipped )
    {
        friendly = self.team == "allies";
    }
    else
    {
        friendly = self.team == "axis";
    }
    
    return friendly;
}

