#using script_17dcb1172e441bf6;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_47851dbeea22fe66;
#using script_634ae70c663d1cc9;
#using script_774302f762d76254;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_2a2a39d4;

// Namespace namespace_2a2a39d4/namespace_2a2a39d4
// Params 0
// Checksum 0xd3c0a210, Offset: 0x230
// Size: 0x52
function init()
{
    level.doa.var_45c191a4 = getweapon( "zombietron_fireball_weapon" );
    level.doa.var_18a44fc1 = getweapon( "zombietron_fireball_weapon_gravity" );
}

// Namespace namespace_2a2a39d4/namespace_2a2a39d4
// Params 0
// Checksum 0xa9f08ba8, Offset: 0x290
// Size: 0x16
function main()
{
    level.doa.var_a8a43931 = [];
}

// Namespace namespace_2a2a39d4/namespace_2a2a39d4
// Params 0
// Checksum 0xc15afa3f, Offset: 0x2b0
// Size: 0x11c
function function_cddc7db1()
{
    self notify( "581b8d63530ee93f" );
    self endon( "581b8d63530ee93f" );
    self thread namespace_268747c0::function_978c05b5();
    result = self waittill( #"destroy_hazard" );
    
    if ( is_true( self.var_7c56394 ) && is_true( result.var_760a0807 ) )
    {
        arrayremovevalue( level.doa.var_a8a43931, self );
        namespace_1e25ad94::debugmsg( "Deleting Fireball trap permenently at:" + self.origin );
    }
    
    util::wait_network_frame();
    
    if ( isdefined( self.script_model ) )
    {
        self.script_model delete();
    }
}

// Namespace namespace_2a2a39d4/namespace_2a2a39d4
// Params 2
// Checksum 0xd9ff283f, Offset: 0x3d8
// Size: 0x138
function function_b9c75c0( trap, var_7c56394 = 0 )
{
    hazard = namespace_ec06fe4a::spawnmodel( trap.origin, "zombietron_fireball_trap" );
    
    if ( isdefined( hazard ) )
    {
        hazard.targetname = "hazard";
        hazard.var_fd5301f9 = "fireball";
        hazard.angles = trap.angles;
    }
    
    trap.script_model = hazard;
    trap.var_7c56394 = var_7c56394;
    
    if ( trap.script_parameters === "gravity" )
    {
        trap.weapon = level.doa.var_18a44fc1;
    }
    else
    {
        trap.weapon = level.doa.var_45c191a4;
    }
    
    trap.velocity = isdefined( trap.script_int ) ? int( trap.script_int ) : 200;
    trap thread function_14a55bfa();
    return trap;
}

// Namespace namespace_2a2a39d4/namespace_2a2a39d4
// Params 2
// Checksum 0xe5879e12, Offset: 0x518
// Size: 0x10c
function function_7a2f725d( trap, page = 0 )
{
    if ( !mayspawnentity() )
    {
        return;
    }
    
    if ( page )
    {
        if ( !isdefined( level.doa.var_a8a43931 ) )
        {
            level.doa.var_a8a43931 = [];
        }
        else if ( !isarray( level.doa.var_a8a43931 ) )
        {
            level.doa.var_a8a43931 = array( level.doa.var_a8a43931 );
        }
        
        level.doa.var_a8a43931[ level.doa.var_a8a43931.size ] = trap;
        return;
    }
    
    function_b9c75c0( trap );
}

// Namespace namespace_2a2a39d4/namespace_2a2a39d4
// Params 0
// Checksum 0x9510eb7f, Offset: 0x630
// Size: 0x30c
function function_d4a86caf()
{
    self notify( "1cb8399436b70342" );
    self endon( "1cb8399436b70342" );
    level endon( #"game_over" );
    
    while ( true )
    {
        wait 0.5;
        
        foreach ( trap in level.doa.var_a8a43931 )
        {
            time = gettime();
            
            if ( isdefined( trap.var_eb9d64bb ) && time < trap.var_eb9d64bb )
            {
                continue;
            }
            
            trap.var_eb9d64bb = time + 2000 + randomint( 600 );
            
            if ( !isdefined( trap.script_model ) )
            {
                activate = 0;
                
                if ( isdefined( trap.var_f8660931 ) )
                {
                    distsq = distancesquared( trap.origin, trap.var_f8660931.origin );
                    
                    if ( distsq < sqr( 3200 ) )
                    {
                        activate = 1;
                    }
                }
                
                if ( !activate )
                {
                    trap.var_f8660931 = namespace_ec06fe4a::function_6eacecf5( trap.origin, 3200 );
                    
                    if ( isdefined( trap.var_f8660931 ) )
                    {
                        activate = 1;
                    }
                    else
                    {
                        trap.var_f8660931 = namespace_ec06fe4a::function_bd3709ce( trap.origin, 1200 );
                        
                        if ( isdefined( trap.var_f8660931 ) )
                        {
                            activate = 1;
                        }
                    }
                }
                
                if ( activate )
                {
                    function_b9c75c0( trap, 1 );
                    trap.var_eb9d64bb += 5000;
                    namespace_1e25ad94::debugmsg( "Paging IN fireball trap at:" + trap.origin );
                }
                
                continue;
            }
            
            trap.var_f8660931 = namespace_ec06fe4a::function_f3eab80e( trap.origin, 3600 );
            
            if ( !isdefined( trap.var_f8660931 ) )
            {
                trap notify( #"destroy_hazard", { #var_760a0807:0 } );
                namespace_1e25ad94::debugmsg( "Paging out fireball trap at:" + trap.origin );
            }
        }
    }
}

// Namespace namespace_2a2a39d4/namespace_2a2a39d4
// Params 0
// Checksum 0xd06ab22c, Offset: 0x948
// Size: 0x130
function function_3a25f62f()
{
    level.doa.var_a8a43931 = [];
    level thread function_d4a86caf();
    
    if ( isdefined( level.doa.var_a77e6349 ) )
    {
        traps = [[ level.doa.var_a77e6349 ]]->function_87f950c1( "fireball" );
        page = 1;
    }
    else
    {
        traps = [[ level.doa.var_39e3fa99 ]]->function_242886d5( "fireball" );
    }
    
    foreach ( trap in traps )
    {
        function_7a2f725d( trap, page );
    }
}

// Namespace namespace_2a2a39d4/namespace_2a2a39d4
// Params 0
// Checksum 0x3b673cc0, Offset: 0xa80
// Size: 0x1a0
function function_14a55bfa()
{
    self notify( "7f68614433a3d94a" );
    self endon( "7f68614433a3d94a" );
    level endon( #"game_over" );
    self endon( #"destroy_hazard" );
    self thread function_cddc7db1();
    
    if ( !isdefined( self.script_model ) )
    {
        self notify( #"destroy_hazard" );
    }
    
    origin = self.script_model gettagorigin( "tag_flash_lvl3_le" );
    angles = self.script_model gettagangles( "tag_flash_lvl3_le" );
    velocity = anglestoforward( angles ) * self.velocity;
    
    while ( true )
    {
        wait randomfloatrange( 5, 10 );
        
        for ( rounds = randomintrange( 2, 8 ); rounds ; rounds-- )
        {
            missile = self.script_model magicmissile( self.weapon, origin, velocity );
            wait randomfloatrange( 1, 4 );
        }
    }
}

