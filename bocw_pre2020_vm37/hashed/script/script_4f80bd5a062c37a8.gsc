#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_ai_shared;

#namespace namespace_7fdfcd5b;

// Namespace namespace_7fdfcd5b/namespace_63948b76
// Params 2
// Checksum 0x227ded4d, Offset: 0x1d0
// Size: 0x3a4
function function_86bd7962( player, spot = player.origin )
{
    sentry = level.doa.pickups.var_ef3f4447 spawner::spawn( 1, "zombietron_sentry_spawner" );
    
    if ( !isdefined( sentry ) )
    {
        return;
    }
    
    sentry endon( #"death" );
    team = player.team;
    sentry.origin = spot + ( 0, 0, 2200 );
    sentry.angles = ( player.angles[ 0 ], player.angles[ 1 ], 0 );
    sentry.weapon = sentry seatgetweapon( 0 );
    sentry turretsetontargettolerance( 0, 10 );
    sentry namespace_83eb6304::function_3ecfde67( "player_trail_" + player.doa.color );
    sentry thread namespace_ec06fe4a::function_1a117d29( spot, 0.5 );
    sentry waittill( #"movedone" );
    sentry.angles = ( sentry.angles[ 0 ], sentry.angles[ 1 ], 0 );
    sentry.owner = player;
    sentry.ignoreme = 1;
    sentry.takedamage = 0;
    sentry setteam( team );
    sentry notsolid();
    sentry namespace_83eb6304::function_3ecfde67( "turret_impact" );
    sentry namespace_e32bb68::function_3a59ec34( "evt_doa_pickup_sentry_land" );
    sentry thread function_229ed59f();
    sentry thread function_5945a362();
    physicsexplosionsphere( spot, 200, 128, 2 );
    playrumbleonposition( "grenade_rumble", spot );
    timeout = player namespace_1c2a96f9::function_4808b985( 40 );
    level waittilltimeout( timeout, #"round_over", #"game_over" );
    sentry notify( #"all_done" );
    sentry namespace_e32bb68::function_3a59ec34( "evt_doa_pickup_sentry_takeoff" );
    sentry namespace_83eb6304::function_3ecfde67( "turret_impact" );
    sentry thread namespace_ec06fe4a::function_1a117d29( sentry.origin + ( 0, 0, 2200 ), 0.5 );
    sentry waittill( #"movedone" );
    sentry delete();
}

// Namespace namespace_7fdfcd5b/namespace_63948b76
// Params 0
// Checksum 0x2ca63dce, Offset: 0x580
// Size: 0x9e
function function_229ed59f()
{
    self endon( #"death", #"all_done" );
    
    while ( self.health > 0 )
    {
        self.favoriteenemy = namespace_ec06fe4a::getclosestenemy();
        
        if ( !isdefined( self.favoriteenemy ) )
        {
            self turretsettargetangles( 0, ( 0, 0, 0 ) );
        }
        else
        {
            self turretsettarget( 0, self.favoriteenemy );
        }
        
        wait 1;
    }
}

// Namespace namespace_7fdfcd5b/namespace_63948b76
// Params 0
// Checksum 0x825d5f0d, Offset: 0x628
// Size: 0x230
function function_5945a362()
{
    self endon( #"death", #"all_done" );
    wait 1.5;
    
    while ( self.health > 0 )
    {
        wait 0.25;
        
        if ( isalive( self.favoriteenemy ) && self cansee( self.favoriteenemy ) )
        {
            distsq = distancesquared( self.favoriteenemy.origin, self.origin );
            
            if ( distsq > sqr( 200 ) )
            {
                v_origin = self gettagorigin( "tag_flash" );
                v_angles = self gettagangles( "tag_flash" );
                forward = anglestoforward( v_angles );
                to_obj = vectornormalize( self.favoriteenemy.origin - v_origin );
                dot = vectordot( to_obj, forward );
                
                if ( dot < 0.5 )
                {
                    continue;
                }
            }
            
            self turretsettarget( 0, self.favoriteenemy.origin + ( 0, 0, 30 ) );
            firetime = randomfloatrange( 3, 6 );
            self vehicle_ai::fire_for_time( firetime, 0, self.favoriteenemy );
            wait 1;
        }
    }
}

