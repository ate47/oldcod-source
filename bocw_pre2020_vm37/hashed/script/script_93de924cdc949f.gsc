#using script_1351b3cdb6539f9b;
#using scripts\core_common\array_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;

#namespace namespace_8589bd1a;

// Namespace namespace_8589bd1a/namespace_8589bd1a
// Params 0
// Checksum 0x80f724d1, Offset: 0xf8
// Size: 0x4
function main()
{
    
}

// Namespace namespace_8589bd1a/namespace_8589bd1a
// Params 1
// Checksum 0x84b8a722, Offset: 0x108
// Size: 0x1f4
function function_554199a0( location )
{
    self notify( "69fcf47cff35fbcb" );
    self endon( "69fcf47cff35fbcb" );
    level flag::wait_till( "level_intro_complete" );
    
    if ( isdefined( level.player ) )
    {
        var_6a25fa7 = level.player getlightingstate();
    }
    
    if ( level.var_731c10af.var_42659717 == 0 )
    {
        if ( isdefined( var_6a25fa7 ) && var_6a25fa7 != 0 )
        {
            setlightingstate( 0 );
        }
    }
    else if ( level.var_731c10af.var_42659717 == 1 )
    {
        if ( isdefined( var_6a25fa7 ) && var_6a25fa7 != 2 )
        {
            setlightingstate( 2 );
        }
    }
    else if ( level.var_731c10af.var_42659717 == 2 )
    {
        if ( isdefined( var_6a25fa7 ) && var_6a25fa7 != 0 )
        {
            setlightingstate( 0 );
        }
    }
    else if ( level.var_731c10af.var_42659717 == 3 )
    {
        if ( isdefined( var_6a25fa7 ) && var_6a25fa7 != 0 )
        {
            setlightingstate( 0 );
        }
    }
    
    if ( isdefined( location ) && ( location == "bunker" || location == "lab" ) )
    {
        if ( isdefined( var_6a25fa7 ) && var_6a25fa7 != 0 )
        {
            setlightingstate( 0 );
        }
    }
}

// Namespace namespace_8589bd1a/namespace_8589bd1a
// Params 3
// Checksum 0xfb6e8c50, Offset: 0x308
// Size: 0x250
function function_b733d218( var_accd268b, var_159584a6 = "targetname", turn_on )
{
    light_array = getentarray( var_accd268b, var_159584a6 );
    
    foreach ( light in light_array )
    {
        if ( !isdefined( light.default_intensity ) )
        {
            light.default_intensity = light getlightintensity();
        }
    }
    
    if ( isdefined( turn_on ) )
    {
        foreach ( light in light_array )
        {
            var_8b4ea7bd = light getlightintensity();
            
            if ( var_8b4ea7bd != light.default_intensity )
            {
                light setlightintensity( light.default_intensity );
            }
        }
        
        return;
    }
    
    foreach ( light in light_array )
    {
        var_8b4ea7bd = light getlightintensity();
        
        if ( var_8b4ea7bd != 0 )
        {
            light setlightintensity( 0 );
        }
    }
}

