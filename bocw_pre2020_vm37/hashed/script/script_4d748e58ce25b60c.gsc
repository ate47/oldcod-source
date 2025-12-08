#using script_164a456ce05c3483;
#using script_179d92c110788f71;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ce46999727f2f2b;
#using script_1ee011cd0961afd7;
#using script_2474a362752098d2;
#using script_2a5bf5b4a00cee0d;
#using script_40f967ad5d18ea74;
#using script_4611af4073d18808;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_6b6510e124bad778;
#using script_74a56359b7d02ab6;
#using script_774302f762d76254;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weapons;

#namespace doa_player;

// Namespace doa_player/doa_player
// Params 0
// Checksum 0x37630ee8, Offset: 0x5b8
// Size: 0x348
function init()
{
    clientfield::register( "allplayers", "bombDrop", 1, 1, "int" );
    clientfield::register( "toplayer", "cutscene", 1, 2, "int" );
    clientfield::register( "toplayer", "controlBinding", 1, 4, "counter" );
    clientfield::register( "toplayer", "goFPS", 1, 1, "counter" );
    clientfield::register( "toplayer", "exitFPS", 1, 1, "counter" );
    clientfield::register( "toplayer", "changeCamera", 1, 1, "counter" );
    clientfield::register( "toplayer", "resetCamera", 1, 1, "counter" );
    clientfield::register( "toplayer", "lastStand", 1, 1, "int" );
    clientfield::register( "toplayer", "setCameraDown", 1, 5, "int" );
    clientfield::register( "toplayer", "showMap", 1, 1, "int" );
    clientfield::register( "toplayer", "toggleflashlight", 1, 1, "int" );
    level.laststandweapon = getweapon( #"downed_doa" );
    level.doa.var_e09e5160 = 0;
    callback::on_connect( &on_player_connect );
    callback::on_spawned( &on_player_spawned );
    callback::on_disconnect( &on_player_disconnect );
    
    if ( isdefined( level.doa.var_cf250523 ) )
    {
        level.callbackplayerkilled = level.doa.var_cf250523;
    }
    
    if ( isdefined( level.doa.var_abe40be4 ) )
    {
        level.callbackplayerdamage = level.doa.var_abe40be4;
    }
    
    if ( isdefined( level.doa.var_cd10d20a ) )
    {
        level.callbackplayerlaststand = level.doa.var_cd10d20a;
    }
}

// Namespace doa_player/doa_player
// Params 0
// Checksum 0xdf79a9ef, Offset: 0x908
// Size: 0x1e
function on_player_connect()
{
    self.ignoreme = 1;
    self.var_f5602976 = gettime();
}

// Namespace doa_player/doa_player
// Params 0
// Checksum 0xa8985aef, Offset: 0x930
// Size: 0xbe
function on_player_spawned()
{
    self namespace_7f5aeb59::function_f3143608();
    
    if ( !is_true( level.var_b62ca8c ) )
    {
        self freezecontrols( 1 );
        self thread lui::screen_fade_out( 0 );
    }
    
    if ( isdefined( level.doa.var_16a35e94 ) )
    {
        self thread [[ level.doa.var_16a35e94 ]]();
    }
    
    self thread function_eef0e695();
    self notify( #"stop_player_monitor_travel_dist" );
}

// Namespace doa_player/doa_player
// Params 0
// Checksum 0x889618ad, Offset: 0x9f8
// Size: 0x5c
function function_eef0e695()
{
    self endon( #"disconnect" );
    self thread namespace_7f5aeb59::function_d690f109();
    wait 10;
    self thread namespace_7f5aeb59::function_d690f109();
    wait 10;
    self thread namespace_7f5aeb59::function_d690f109();
}

// Namespace doa_player/doa_player
// Params 0
// Checksum 0xaeabe5d4, Offset: 0xa60
// Size: 0x6e
function on_player_disconnect()
{
    if ( isdefined( self.doa.score.var_d252ca7f ) )
    {
        level clientfield::set_world_uimodel( self.doa.score.var_d252ca7f, 0 );
    }
    
    if ( isdefined( self.doa ) )
    {
        self.doa.score = undefined;
        self.doa = undefined;
    }
}

// Namespace doa_player/doa_player
// Params 0
// Checksum 0xa881ba80, Offset: 0xad8
// Size: 0x360
function main()
{
    level endon( #"game_over" );
    level waittill( #"hash_671684f03a58b3a3" );
    
    foreach ( player in namespace_7f5aeb59::function_23e1f90f() )
    {
        player namespace_7f5aeb59::function_513831e1( 1 );
        player clientfield::increment_to_player( "controlBinding" );
        player clientfield::increment_to_player( "resetCamera" );
    }
    
    while ( true )
    {
        level waittill( #"hash_76eb5274e6de5301" );
        players = level.players;
        curcount = players.size;
        
        if ( curcount != level.doa.var_e09e5160 )
        {
            /#
                namespace_1e25ad94::debugmsg( "<dev string:x38>" + curcount );
            #/
        }
        
        level.doa.var_e09e5160 = curcount;
        aliveplayers = 0;
        
        foreach ( player in players )
        {
            if ( !is_true( player.laststand ) || player.doa.score.lives > 0 )
            {
                aliveplayers++;
            }
            
            if ( !namespace_7f5aeb59::isplayervalid( player ) )
            {
                continue;
            }
            
            if ( !is_true( player.laststand ) )
            {
                player thread function_7310b24f();
            }
            
            player namespace_dfc652ee::function_d936944a();
            player namespace_dfc652ee::function_cbae9ca3();
            player thread namespace_41cb996::updateweapon();
            player namespace_eccff4fb::function_7752515d();
            player namespace_6e90e490::updatehud();
        }
        
        if ( aliveplayers == 0 )
        {
            if ( isdefined( level.doa.var_abd5eb1e ) )
            {
                [[ level.doa.var_abd5eb1e ]]();
            }
        }
    }
}

// Namespace doa_player/doa_player
// Params 0
// Checksum 0x74d2c775, Offset: 0xe40
// Size: 0xce
function function_7310b24f()
{
    profilestart();
    
    if ( isdefined( level.var_ec5aa760 ) )
    {
        self [[ level.var_ec5aa760 ]]();
    }
    
    self function_ba8327d7();
    self function_56544e8b();
    self function_cf940b05();
    self function_74ba13d0();
    self function_902013ca();
    self function_a8cdc084();
    self function_23c07f29();
    profilestop();
}

// Namespace doa_player/doa_player
// Params 0
// Checksum 0x1298063, Offset: 0xf18
// Size: 0x146
function function_a8cdc084()
{
    if ( !isdefined( self.doa ) )
    {
        return;
    }
    
    if ( is_true( level.doa.var_a3e53b88 ) || self actionslottwobuttonpressed() && !is_true( self.doa.var_9ca03c2f ) )
    {
        self clientfield::set_to_player( "showMap", 1 );
        self.doa.var_9ca03c2f = 1;
    }
    
    if ( !is_true( level.doa.var_a3e53b88 ) && !self actionslottwobuttonpressed() && is_true( self.doa.var_9ca03c2f ) )
    {
        self clientfield::set_to_player( "showMap", 0 );
        self.doa.var_9ca03c2f = 0;
    }
}

// Namespace doa_player/doa_player
// Params 0
// Checksum 0xe44d4b01, Offset: 0x1068
// Size: 0x14e
function function_23c07f29()
{
    if ( !isdefined( self.doa ) || !is_true( self.doa.var_82fb5d17 ) )
    {
        return;
    }
    
    if ( is_true( self.doa.var_11cd9fd3 ) )
    {
        if ( self actionslotthreebuttonpressed() )
        {
            return;
        }
        
        self.doa.var_11cd9fd3 = undefined;
    }
    
    if ( self actionslotthreebuttonpressed() )
    {
        self.doa.var_11cd9fd3 = 1;
        self.doa.var_56fdd2fe = 1;
        return;
    }
    
    if ( is_true( self.doa.var_56fdd2fe ) )
    {
        self.doa.var_f583234e = !self.doa.var_f583234e;
        self clientfield::set_to_player( "toggleflashlight", self.doa.var_f583234e );
    }
    
    self.doa.var_56fdd2fe = 0;
}

// Namespace doa_player/doa_player
// Params 0
// Checksum 0xceb20a47, Offset: 0x11c0
// Size: 0x23e
function function_902013ca()
{
    if ( !isdefined( self.doa ) || gettime() < self.doa.var_99c6ee47 )
    {
        return;
    }
    
    if ( is_true( self.doa.var_a8d9dfbe ) )
    {
        if ( self actionslotonebuttonpressed() )
        {
            return;
        }
        
        self.doa.var_a8d9dfbe = undefined;
    }
    
    if ( self actionslotonebuttonpressed() )
    {
        self.doa.var_a8d9dfbe = 1;
        self.doa.var_f8fd8e97 = 1;
        return;
    }
    
    if ( self.doa.score.lives >= 1 && is_true( self.doa.var_f8fd8e97 ) )
    {
        players = arraysortclosest( namespace_7f5aeb59::function_23e1f90f(), self.origin );
        
        foreach ( player in players )
        {
            if ( self === player )
            {
                continue;
            }
            
            if ( !is_true( player.laststand ) )
            {
                continue;
            }
            
            if ( player.doa.score.lives > 0 )
            {
                continue;
            }
            
            self.doa.var_99c6ee47 = gettime() + 2000;
            self thread givealifetoplayer( player );
            break;
        }
    }
    
    self.doa.var_f8fd8e97 = 0;
}

// Namespace doa_player/doa_player
// Params 1
// Checksum 0x39ccad11, Offset: 0x1408
// Size: 0x1e4
function givealifetoplayer( target )
{
    if ( self.doa.score.lives > 0 )
    {
        self.doa.score.lives--;
        self namespace_e32bb68::function_3a59ec34( "hallelujah" );
        self thread function_cdcf0e57();
        model = namespace_ec06fe4a::spawnmodel( self.origin, "zombietron_extra_life", self.angles, "giveALifeToPlayer" );
        
        if ( isdefined( model ) )
        {
            model thread namespace_83eb6304::function_3ecfde67( "player_trail_" + self.doa.color );
            model thread namespace_83eb6304::function_3ecfde67( "glow_" + self.doa.color );
            distsq = distancesquared( target.origin, self.origin );
            time = mapfloat( 0, sqr( 1000 ), 0.25, 1, distsq );
            model moveto( target.origin, time );
            wait time;
            model delete();
        }
        
        target.doa.score.lives++;
        target namespace_7f5aeb59::function_513831e1();
    }
}

// Namespace doa_player/doa_player
// Params 0
// Checksum 0x26b25e6a, Offset: 0x15f8
// Size: 0x4d4
function function_cdcf0e57()
{
    self endon( #"disconnect" );
    roll = randomint( 100 );
    
    if ( roll == 99 )
    {
        level thread namespace_dfc652ee::itemspawn( namespace_dfc652ee::function_6265bde4( "zombietron_extra_life" ), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self );
        wait 0.5;
    }
    
    if ( roll > 88 )
    {
        level thread namespace_dfc652ee::itemspawn( namespace_dfc652ee::function_6265bde4( "zombietron_nuke" ), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self );
        wait 0.5;
        level thread namespace_dfc652ee::itemspawn( namespace_dfc652ee::function_6265bde4( "zombietron_nuke" ), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self );
        wait 0.5;
    }
    
    if ( roll > 75 )
    {
        level thread namespace_dfc652ee::itemspawn( namespace_dfc652ee::function_6265bde4( "zombietron_boost" ), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self );
        wait 0.5;
        level thread namespace_dfc652ee::itemspawn( namespace_dfc652ee::function_6265bde4( "zombietron_boost" ), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self );
        wait 0.5;
    }
    
    if ( roll > 55 )
    {
        level thread namespace_dfc652ee::itemspawn( namespace_dfc652ee::function_6265bde4( "zombietron_chicken" ), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self );
        wait 0.5;
        level thread namespace_dfc652ee::itemspawn( namespace_dfc652ee::function_6265bde4( "zombietron_chicken" ), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self );
        wait 0.5;
    }
    
    if ( roll > 35 )
    {
        level thread namespace_dfc652ee::itemspawn( namespace_dfc652ee::function_6265bde4( "zombietron_sawblade" ), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self );
        wait 0.5;
        level thread namespace_dfc652ee::itemspawn( namespace_dfc652ee::function_6265bde4( "zombietron_sawblade" ), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self );
        wait 0.5;
    }
    
    if ( roll > 15 )
    {
        level thread namespace_dfc652ee::itemspawn( namespace_dfc652ee::function_6265bde4( "zombietron_boxing_glove" ), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self );
        wait 0.5;
        level thread namespace_dfc652ee::itemspawn( namespace_dfc652ee::function_6265bde4( "zombietron_magnet" ), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self );
        wait 0.5;
    }
    
    level thread namespace_dfc652ee::itemspawn( namespace_dfc652ee::function_6265bde4( "zombietron_ammo" ), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self );
    wait 0.5;
    level thread namespace_dfc652ee::itemspawn( namespace_dfc652ee::function_6265bde4( "zombietron_ammo" ), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self );
    wait 0.5;
    level thread namespace_dfc652ee::itemspawn( namespace_dfc652ee::function_6265bde4( "zombietron_ammo" ), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self );
    wait 0.5;
    
    if ( roll == 0 )
    {
        level thread namespace_dfc652ee::itemspawn( namespace_dfc652ee::function_6265bde4( "zombietron_skeleton_key" ), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self );
    }
}

// Namespace doa_player/doa_player
// Params 0
// Checksum 0xb0941d2f, Offset: 0x1ad8
// Size: 0x10a
function function_cf940b05()
{
    if ( is_true( level.var_7dcdbe16 ) )
    {
        return;
    }
    
    if ( is_true( self.doa.var_7a27ee1b ) )
    {
        if ( self weaponswitchbuttonpressed() )
        {
            return;
        }
        
        self.doa.var_7a27ee1b = undefined;
    }
    
    if ( self weaponswitchbuttonpressed() )
    {
        if ( !is_true( self.doa.var_4f3aee7b ) )
        {
            if ( !is_true( self.doa.infps ) )
            {
                self clientfield::increment_to_player( "changeCamera" );
            }
            
            self notify( #"camera_changed" );
        }
        
        self.doa.var_7a27ee1b = 1;
    }
}

// Namespace doa_player/doa_player
// Params 0
// Checksum 0xe03748d6, Offset: 0x1bf0
// Size: 0x112
function function_74ba13d0()
{
    if ( is_true( level.var_babb5873 ) )
    {
        return;
    }
    
    if ( self namespace_491fa2b2::function_8f5419f1() )
    {
        return;
    }
    
    if ( self usebuttonpressed() )
    {
        self.doa.var_9d136ff8 = 1;
        return;
    }
    
    if ( is_true( self.doa.var_9d136ff8 ) )
    {
        if ( is_true( self.doa.var_af53a5b7 ) )
        {
            self.doa.var_9d136ff8 = undefined;
            self.doa.var_af53a5b7 = undefined;
            return;
        }
        
        if ( isdefined( self.doa.vehicle ) )
        {
            self notify( #"hash_279998c5df86c04d" );
        }
        else
        {
            self namespace_41cb996::function_8b7acf56();
        }
        
        self.doa.var_9d136ff8 = undefined;
    }
}

// Namespace doa_player/doa_player
// Params 0
// Checksum 0x881e816b, Offset: 0x1d10
// Size: 0x55c
function function_ba8327d7()
{
    if ( is_true( level.var_e1857dc3 ) )
    {
        return;
    }
    
    if ( isdefined( self.doa.vehicle ) )
    {
        return;
    }
    
    if ( is_true( self.doa.var_9049062 ) )
    {
        return;
    }
    
    if ( is_true( self.doa.var_c026f7c9 ) )
    {
        time = gettime();
        
        if ( time < self.doa.var_fdc612e3 )
        {
            self setvelocity( self.doa.var_b7001078 );
            namespace_1e25ad94::debugmsg( "Player(" + self.doa.color + ") BOOSTING active" );
            
            if ( self.doa.var_c0f32380 < time )
            {
                level notify( #"hash_50be6fd0db982086", { #origin:self.origin } );
                self.doa.var_c0f32380 = time + 250;
            }
            
            return;
        }
        
        self.doa.var_c026f7c9 = 0;
        self thread namespace_7f5aeb59::turnplayershieldon();
        
        if ( isdefined( self.doa.boosttrigger ) )
        {
            self.doa.boosttrigger delete();
        }
        
        namespace_1e25ad94::debugmsg( "Player(" + self.doa.color + ") BOOSTING deactivating" );
    }
    
    if ( is_true( self.doa.var_48d0af86 ) )
    {
        if ( self secondaryoffhandbuttonpressed() )
        {
            return;
        }
        
        self.doa.var_48d0af86 = undefined;
    }
    
    if ( self secondaryoffhandbuttonpressed() || is_true( self.doa.var_d524abd8 ) )
    {
        self.doa.var_d524abd8 = 0;
        self.doa.var_48d0af86 = 1;
        
        if ( self.doa.score.boosts > 0 )
        {
            self.doa.var_c026f7c9 = 1;
            self.doa.score.boosts--;
            self thread namespace_7f5aeb59::turnplayershieldon();
            forward = anglestoforward( self.angles );
            self namespace_e32bb68::function_3a59ec34( "evt_doa_powerup_boost_activate" );
            self.doa.boosttrigger = namespace_ec06fe4a::spawntrigger( "trigger_radius", self.origin, 1 | 512 | 8, 80, 72 );
            
            if ( isdefined( self.doa.boosttrigger ) )
            {
                self.doa.boosttrigger.targetname = "triggerBoost";
                self.doa.boosttrigger enablelinkto();
                self.doa.boosttrigger linkto( self, "tag_origin", ( 200, 0, 0 ), self.angles );
                self.doa.boosttrigger thread namespace_7f5aeb59::function_19f387a( self );
                self.doa.boosttrigger thread namespace_ec06fe4a::function_ae010bb4( self );
                self.doa.boosttrigger thread namespace_ec06fe4a::function_52afe5df( 0.6 );
            }
            
            self.doa.var_fdc612e3 = gettime() + 600;
            self.doa.var_b7001078 = forward * 2000;
            self.doa.var_b7001078 += ( 0, 0, 200 );
            self setvelocity( self.doa.var_b7001078 );
            self.doa.var_b7001078 -= ( 0, 0, 200 );
            self.doa.var_c0f32380 = 0;
            self playrumbleonentity( "zombietron_booster_rumble" );
        }
    }
}

// Namespace doa_player/doa_player
// Params 0
// Checksum 0xdbb44990, Offset: 0x2278
// Size: 0x1bc
function function_56544e8b()
{
    if ( is_true( level.var_52a59317 ) )
    {
        return;
    }
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( isdefined( self.var_abe341a1 ) )
    {
        return;
    }
    
    if ( is_true( self.doa.var_590072e2 ) )
    {
        return;
    }
    
    if ( is_true( level.var_5e26061e ) )
    {
        return;
    }
    
    if ( isdefined( self.doa.var_21eab413 ) )
    {
        if ( gettime() < self.doa.var_21eab413 )
        {
            return;
        }
        
        self.doa.var_21eab413 = undefined;
    }
    
    if ( is_true( self.doa.var_e6bdbae1 ) )
    {
        if ( self fragbuttonpressed() )
        {
            return;
        }
        
        self.doa.var_e6bdbae1 = undefined;
    }
    
    if ( self fragbuttonpressed() || is_true( self.doa.var_640df11b ) )
    {
        self.doa.var_640df11b = 0;
        self.doa.var_e6bdbae1 = 1;
        
        if ( self.doa.score.bombs > 0 )
        {
            self.doa.score.bombs--;
            self thread function_a34cf3fb();
        }
    }
}

// Namespace doa_player/doa_player
// Params 0
// Checksum 0xce09f0bb, Offset: 0x2440
// Size: 0x3bc
function function_a34cf3fb()
{
    self endon( #"disconnect" );
    player_org = self.origin;
    origin = player_org + ( 20, 0, 800 );
    self thread namespace_7f5aeb59::turnplayershieldon();
    self clientfield::set( "bombDrop", 1 );
    wait 0.4;
    level notify( #"hash_c1cceae4479f2e5", { #origin:player_org } );
    playrumbleonposition( "artillery_rumble", self.origin );
    namespace_ec06fe4a::clearallcorpses();
    util::wait_network_frame();
    level notify( #"hash_11f6c6a82650cca2" );
    
    if ( namespace_4dae815d::function_59a9cf1d() != 0 )
    {
        guys = getaiteamarray();
        guys = arraysortclosest( guys, self.origin, 60, 0, 768 );
    }
    else
    {
        guys = getaiteamarray();
    }
    
    updir = vectornormalize( origin - player_org );
    var_182c1d00 = 0.3;
    
    foreach ( guy in guys )
    {
        if ( isdefined( guy ) )
        {
            if ( is_true( guy.boss ) )
            {
                guy.nuked = gettime();
                guy ai::stun( randomfloatrange( 3, 7 ) );
                guy notify( #"nuked" );
                continue;
            }
            
            if ( isvehicle( guy ) )
            {
                guy dodamage( guy.health + 1, player_org, self, self, "none", "MOD_EXPLOSIVE", 0, getweapon( "none" ) );
                continue;
            }
            
            if ( guy.team != "axis" )
            {
                if ( !is_true( guy.guardian ) )
                {
                    continue;
                }
            }
            
            guy thread function_6dc6e670( var_182c1d00, player_org, self, updir );
        }
    }
    
    util::wait_network_frame();
    self clientfield::set( "bombDrop", 0 );
    physicsexplosionsphere( player_org, 1024, 1024, 3 );
}

// Namespace doa_player/doa_player
// Params 4, eflags: 0x4
// Checksum 0x19549cd, Offset: 0x2808
// Size: 0x3dc
function private function_6dc6e670( var_182c1d00, origin, player, *updir )
{
    self endon( #"death" );
    assert( !is_true( self.boss ) );
    
    if ( !isdefined( level.var_5c7cffec ) )
    {
        level.var_5c7cffec = sqr( 160 );
        level.var_db768440 = sqr( 512 );
        level.var_ad08a14b = 75;
        level.var_3444cdb3 = 250;
        level.var_eb2c7de4 = 1;
    }
    
    distsq = distancesquared( self.origin, player );
    var_2ef058c8 = math::clamp( distsq / level.var_db768440, 0.1, 1 );
    time = math::clamp( origin * var_2ef058c8, 0.05, origin );
    wait time;
    self.takedamage = 1;
    self.allowdeath = 1;
    self.var_418bd7f0 = 0;
    self.marked_for_death = 1;
    
    if ( !is_true( self.no_gib ) )
    {
        if ( distsq < sqr( 128 ) && !isdefined( self.boss ) )
        {
            self namespace_ed80aead::function_586ef822();
        }
        else
        {
            self thread namespace_83eb6304::function_8b4b9bdd();
            
            if ( !is_true( self.var_1b41b0e8 ) && isactor( self ) )
            {
                self namespace_83eb6304::function_3ecfde67( "burn_zombie" );
            }
            
            self namespace_ed80aead::gib_random_part( self.health );
        }
    }
    
    if ( self.archetype == "zombie" )
    {
        roll = randomint( 100 );
        
        switch ( randomint( 4 ) )
        {
            case 0:
                self namespace_83eb6304::function_3ecfde67( "boost_explode" );
                break;
            case 1:
                self namespace_83eb6304::function_3ecfde67( "gut_explode" );
                break;
            case 2:
                self namespace_83eb6304::function_3ecfde67( "saw_explode" );
                break;
            default:
                break;
        }
        
        util::wait_network_frame();
    }
    
    self dodamage( self.health + 1, player, isdefined( updir ) ? updir : undefined, undefined, "none", "MOD_EXPLOSIVE" );
}

// Namespace doa_player/doa_player
// Params 9
// Checksum 0x49ac096, Offset: 0x2bf0
// Size: 0x134
function callback_playerkilled( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    self endon( #"spawned", #"disconnect" );
    self notify( #"killed_player" );
    params = spawnstruct();
    params.einflictor = einflictor;
    params.eattacker = attacker;
    params.idamage = idamage;
    params.smeansofdeath = smeansofdeath;
    params.weapon = weapon;
    params.vdir = vdir;
    params.shitloc = shitloc;
    params.psoffsettime = psoffsettime;
    params.deathanimduration = deathanimduration;
    self callback::callback( #"on_player_killed", {} );
}

// Namespace doa_player/doa_player
// Params 13
// Checksum 0xb55a837d, Offset: 0x2d30
// Size: 0x2ec
function callback_playerdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal )
{
    if ( self getinvulnerability() || isdefined( self.doa.var_221ef439 ) )
    {
        return;
    }
    
    if ( smeansofdeath === "MOD_FALLING" && is_true( level.var_9fa19717 ) )
    {
        return;
    }
    
    if ( isdefined( self.doa.var_8b493af7 ) )
    {
        namespace_1e25ad94::debugmsg( "Player (" + self.doa.color + ") was damaged but shield is on!", 1 );
        return;
    }
    
    if ( isdefined( eattacker ) && eattacker.team == self.team )
    {
        return;
    }
    
    idamage = int( idamage );
    
    if ( level.doa.world_state == 0 )
    {
        if ( is_true( self.doa.infps ) )
        {
            idamage = 50;
        }
        else
        {
            idamage = self.maxhealth + 187;
        }
    }
    
    params = spawnstruct();
    params.einflictor = einflictor;
    params.eattacker = eattacker;
    params.idamage = idamage;
    params.idflags = idflags;
    params.smeansofdeath = smeansofdeath;
    params.weapon = weapon;
    params.vpoint = vpoint;
    params.vdir = vdir;
    params.shitloc = shitloc;
    params.vdamageorigin = vdamageorigin;
    params.psoffsettime = psoffsettime;
    self.last_damaged_time = level.time;
    idamage = int( params.idamage );
    self thread weapons::on_damage( eattacker, einflictor, weapon, smeansofdeath, idamage );
    self playrumbleonentity( "damage_heavy" );
    self finishplayerdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal );
}

// Namespace doa_player/doa_player
// Params 9
// Checksum 0x84d78829, Offset: 0x3028
// Size: 0x664
function function_c0e6e008( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, *psoffsettime, *delayoverride )
{
    if ( self laststand::player_is_in_laststand() )
    {
        return;
    }
    
    self notify( #"entering_last_stand" );
    self notify( #"player_died" );
    self.laststand = 1;
    self.deaths++;
    
    if ( isdefined( smeansofdeath ) && smeansofdeath === level.doa.silverback && is_true( smeansofdeath.collector ) )
    {
        level notify( #"hash_72523790f36bd2a8" );
    }
    
    self namespace_e32bb68::function_3a59ec34( "evt_doa_player_death" );
    
    if ( is_true( self.doa.infps ) )
    {
        self notify( #"hash_7893364bd228d63e", { #var_cff8d1e:1 } );
        self.var_bb4d9604 = undefined;
    }
    
    namespace_1e25ad94::debugmsg( "player entering last stand" );
    delta = gettime() - self.doa.var_77c8b9d4;
    
    if ( delta < 7000 || isdefined( self.doa.var_8b493af7 ) )
    {
        namespace_1e25ad94::debugmsg( "Player (" + self.doa.color + ") was killed impossibly close interval.  Shield On:" + ( isdefined( self.doa.var_8b493af7 ) ? "true" : "false" ) );
    }
    
    self.doa.var_77c8b9d4 = gettime();
    namespace_1e25ad94::debugmsg( "Player (" + self.doa.color + ") was killed by :" + ( isdefined( smeansofdeath ) && isdefined( smeansofdeath.zombie_type ) ? smeansofdeath.zombie_type : "unknown attacker" ) );
    
    if ( is_true( smeansofdeath.var_cd7dffa1 ) || getdvarint( #"hash_55b5b49e1b334929", 0 ) && isdefined( smeansofdeath ) )
    {
        if ( is_true( smeansofdeath.var_cd7dffa1 ) )
        {
            namespace_1e25ad94::debugmsg( "Player (" + self.doa.color + ") was killed by ghosted enemy :" + ( isdefined( smeansofdeath ) && isdefined( smeansofdeath.zombie_type ) ? smeansofdeath.zombie_type : "unknown attacker" ), 1 );
        }
        
        namespace_7f5aeb59::function_884143e( smeansofdeath );
    }
    
    self function_dc7906e8( idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride );
    
    if ( isdefined( level.var_f7b64ada ) )
    {
        [[ level.var_f7b64ada ]]();
    }
    
    self namespace_eccff4fb::function_f6ac4585();
    obituary( self, smeansofdeath, level.weaponnone, "MOD_DOWNED" );
    self clientfield::set_to_player( "lastStand", 1 );
    self allowjump( 0 );
    self namespace_7f5aeb59::laststand_disable_player_weapons();
    self.health = 5;
    self.laststand = 1;
    self.ignoreme = 1;
    self.ignoremelee = 1;
    callback::callback( #"on_player_laststand" );
    
    if ( !is_true( self.no_revive_trigger ) )
    {
        self revive_trigger_spawn();
    }
    
    if ( self.doa.score.lives > 0 )
    {
        bleedout_time = 5;
    }
    else
    {
        bleedout_time = 115;
        
        foreach ( player in namespace_7f5aeb59::function_23e1f90f() )
        {
            if ( player == self )
            {
                continue;
            }
            
            if ( is_true( player.laststand ) )
            {
                continue;
            }
            
            if ( player.doa.score.lives < 1 )
            {
                continue;
            }
            
            player namespace_6e90e490::showhint( 6 );
        }
    }
    
    self thread namespace_7f5aeb59::function_52392bd1( bleedout_time == 115 );
    self thread namespace_7f5aeb59::function_77785447( 1, 1 );
    self thread laststand::function_d4c9e1b5();
    self thread function_49b2bfe5( bleedout_time );
}

// Namespace doa_player/doa_player
// Params 0
// Checksum 0x2156a402, Offset: 0x3698
// Size: 0x1ba
function function_51e87eda()
{
    self endon( #"disconnect" );
    level endon( #"game_over" );
    
    while ( is_true( self.doa.respawning ) )
    {
        self.doa.var_f64d2ac0 = 0;
        players = namespace_7f5aeb59::function_23e1f90f();
        
        foreach ( player in players )
        {
            if ( is_true( player.doa.respawning ) )
            {
                continue;
            }
            
            if ( isdefined( player.doa.vehicle ) )
            {
                continue;
            }
            
            if ( !isalive( player ) )
            {
                continue;
            }
            
            distsq = distancesquared( self.origin, player.origin );
            
            if ( distsq > sqr( 48 ) )
            {
                continue;
            }
            
            self.doa.var_f64d2ac0++;
        }
        
        wait 1;
    }
}

// Namespace doa_player/doa_player
// Params 1
// Checksum 0xc21c4fe6, Offset: 0x3860
// Size: 0x2c4
function function_49b2bfe5( duration )
{
    self endon( #"disconnect" );
    self endon( #"player_respawned" );
    level endon( #"game_over" );
    var_82cfdf77 = duration == 115;
    self.doa.respawning = 1;
    self.doa.var_22e62f63 = duration * 1000;
    self.doa.var_ac8a92d4 = 0;
    self.doa.var_f64d2ac0 = 0;
    self thread function_51e87eda();
    var_58d202bd = float( function_60d95f53() ) / 1000 * 1000;
    
    for ( var_339d778e = 0; self.doa.var_ac8a92d4 < self.doa.var_22e62f63 ; var_339d778e = 0 )
    {
        if ( namespace_4dae815d::function_59a9cf1d() != 2 )
        {
            if ( var_82cfdf77 && self.doa.score.lives > 0 )
            {
                break;
            }
        }
        
        waitframe( 1 );
        self.doa.var_ac8a92d4 += var_58d202bd * ( self.doa.var_f64d2ac0 + 1 );
        
        if ( !var_339d778e && self.doa.var_f64d2ac0 > 0 )
        {
            self namespace_83eb6304::function_3ecfde67( "player_heal" );
            var_339d778e = 1;
        }
        
        if ( var_339d778e && self.doa.var_f64d2ac0 == 0 )
        {
            self namespace_83eb6304::turnofffx( "player_heal" );
        }
    }
    
    self namespace_83eb6304::turnofffx( "player_heal" );
    
    if ( isdefined( self.revivetrigger ) )
    {
        self.revivetrigger delete();
    }
    
    self.laststandparams = undefined;
    self.var_bfc8055f = undefined;
    self notify( #"player_revived" );
    self thread namespace_7f5aeb59::function_513831e1();
}

// Namespace doa_player/doa_player
// Params 7
// Checksum 0xe9f4f9de, Offset: 0x3b30
// Size: 0x25e
function function_dc7906e8( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc )
{
    self.laststandparams = spawnstruct();
    self.var_bfc8055f = spawnstruct();
    self.laststandparams.einflictor = einflictor;
    self.var_bfc8055f.var_b5346661 = isdefined( einflictor ) ? einflictor getentitynumber() : -1;
    self.laststandparams.attacker = attacker;
    self.var_bfc8055f.attackernum = isdefined( attacker ) ? attacker getentitynumber() : -1;
    self.laststandparams.attackerorigin = attacker.origin;
    
    if ( isplayer( attacker ) )
    {
        self.laststandparams.attackerangles = attacker getplayerangles();
    }
    else
    {
        self.laststandparams.attackerangles = attacker.angles;
    }
    
    self.laststandparams.idamage = idamage;
    self.laststandparams.smeansofdeath = smeansofdeath;
    self.laststandparams.weapon = weapon;
    self.laststandparams.vdir = vdir;
    self.laststandparams.shitloc = shitloc;
    self.laststandparams.laststandstarttime = gettime();
    self.laststandparams.victimorigin = self.origin;
    self.laststandparams.victimangles = self getplayerangles();
    self.laststandparams.victimweapon = self.currentweapon;
    self.laststandparams.matchtime = gettime();
    self.laststandparams.bledout = 0;
    self.laststandparams.var_59b19c1b = 1;
}

// Namespace doa_player/doa_player
// Params 0
// Checksum 0xa457e88d, Offset: 0x3d98
// Size: 0x15c
function revive_trigger_spawn()
{
    self.revivetrigger = namespace_ec06fe4a::spawntrigger( "trigger_radius", ( 0, 0, 0 ), 0, 50, 50 );
    
    if ( isdefined( self.revivetrigger ) )
    {
        self.revivetrigger sethintstring( "" );
        self.revivetrigger setcursorhint( "HINT_NOICON" );
        self.revivetrigger setmovingplatformenabled( 1 );
        self.revivetrigger enablelinkto();
        self.revivetrigger.origin = self.origin;
        self.revivetrigger linkto( self );
        self.revivetrigger.beingrevived = 0;
        self.revivetrigger.createtime = gettime();
        self.revivetrigger.radius = 50;
        self.revivetrigger setteamfortrigger( self.team );
        self thread revive_trigger_think();
    }
}

// Namespace doa_player/doa_player
// Params 0
// Checksum 0xc5bac535, Offset: 0x3f00
// Size: 0x90
function revive_trigger_think()
{
    self endon( #"death", #"stop_revive_trigger" );
    level endon( #"doa_game_is_over" );
    
    while ( true )
    {
        wait 0.1;
        
        if ( !isdefined( self.revivetrigger ) )
        {
            self notify( #"stop_revive_trigger" );
        }
        
        self.revivetrigger sethintstring( "" );
    }
}

// Namespace doa_player/enter_vehicle
// Params 1, eflags: 0x40
// Checksum 0x27d23977, Offset: 0x3f98
// Size: 0xb4
function event_handler[enter_vehicle] codecallback_vehicleenter( eventstruct )
{
    if ( isvehicle( eventstruct.vehicle ) )
    {
        vehicle = eventstruct.vehicle;
        var_7efce95 = 1;
        
        if ( isdefined( vehicle.var_7efce95 ) )
        {
            var_7efce95 = vehicle.var_7efce95;
        }
        
        if ( var_7efce95 )
        {
            self.doa.var_9d136ff8 = 1;
            self.doa.var_1b452923 = 1;
            self thread namespace_a4bedd45::function_1f704cee( 1, 0 );
        }
    }
}

// Namespace doa_player/exit_vehicle
// Params 1, eflags: 0x40
// Checksum 0x117edd85, Offset: 0x4058
// Size: 0x66
function event_handler[exit_vehicle] codecallback_vehicleexit( *eventstruct )
{
    if ( is_true( self.doa.infps ) )
    {
        self.doa.var_1b452923 = undefined;
        self notify( #"hash_7893364bd228d63e", { #var_cff8d1e:1 } );
    }
}

