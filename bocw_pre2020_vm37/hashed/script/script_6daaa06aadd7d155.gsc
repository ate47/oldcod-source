#using script_1b9f100b85b7e21d;
#using script_290b454abd681dd4;
#using script_37f9ff47f340fbe8;
#using script_7409560e3a0c9884;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\evac;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#using scripts\killstreaks\cp\ac130;
#using scripts\killstreaks\killstreaks_shared;

#namespace namespace_19fc4094;

// Namespace namespace_19fc4094/namespace_19fc4094
// Params 0
// Checksum 0xd7fe335, Offset: 0x5f8
// Size: 0xce
function function_aa860122()
{
    while ( true )
    {
        if ( self flag::get( "player_zero_attacker_accuracy" ) )
        {
            loc = anglestoforward( self getplayerangles() ) * 256;
            loc += self getorigin() + ( 0, 0, 16 );
            
            /#
                sphere( loc, 16, ( 1, 0, 0 ), 1, 0, 10, 1 );
            #/
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_19fc4094/namespace_19fc4094
// Params 1
// Checksum 0x91300397, Offset: 0x6d0
// Size: 0x5c
function function_4b8cec86( *var_d3440450 )
{
    level flag::set( "tundra_intro_done" );
    level thread namespace_ba979a10::setup_allies();
    level thread namespace_c1cfab6c::function_f5421481();
}

// Namespace namespace_19fc4094/namespace_19fc4094
// Params 2
// Checksum 0xda24a2c1, Offset: 0x738
// Size: 0x1e4
function outro_main( *var_d3440450, *var_50cc0d4f )
{
    level flag::wait_till( "level_is_go" );
    player = getplayers()[ 0 ];
    music = snd::function_9ae4fc6f( "mus_tmp_yamantau_digsite_lp" );
    level.var_9090a594 = #"hash_62df17fd9f467834";
    level.var_5bb760e8 = #"hash_375f464aa679494f";
    level.var_fe86dfc1 = 1;
    level.var_5e56e2a8 = 1024;
    level.var_5fc12b72 = 15;
    level.var_dd0b1f89 = 15;
    player thread evac::main( player.origin, "start_evac_heli_infil", undefined, 3 );
    player thread function_29758311();
    player thread function_df7926cc();
    level thread function_8b371bd3();
    level thread function_45a92388();
    level waittill( #"evac_helicopter_board_trigger" );
    iprintlnbold( "Come on home!" );
    wait 4;
    util::screen_fade_out( 4 );
    wait 1;
    skipto::function_1c2dfc20( "cp_ger_hub" );
}

// Namespace namespace_19fc4094/namespace_19fc4094
// Params 0
// Checksum 0x80f724d1, Offset: 0x928
// Size: 0x4
function init_flags()
{
    
}

// Namespace namespace_19fc4094/namespace_19fc4094
// Params 4
// Checksum 0x423f45c3, Offset: 0x938
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace namespace_19fc4094/namespace_19fc4094
// Params 0
// Checksum 0x6c71bbe, Offset: 0x968
// Size: 0x18c
function function_8b371bd3()
{
    level flag::wait_till( "start_evac_heli_infil" );
    iprintlnbold( "Mason: Smoke out!" );
    wait 3;
    iprintlnbold( "Pilot: Roger that." );
    wait 5;
    iprintlnbold( "Woods: Looks like we're not done here!" );
    wait 10;
    iprintlnbold( "Pilot: Chopper's just a few minutes out." );
    wait 10;
    iprintlnbold( "Woods: Reds incoming!" );
    wait 10;
    iprintlnbold( "Woods: It's an asshole parade!" );
    wait 15;
    iprintlnbold( "Pilot: Hang on. I'm nearly there!" );
    wait 10;
    iprintlnbold( "Pilot: Eyes on smoke. Touching down soon." );
    level flag::wait_till( "flag_evac_stop_smoke" );
    iprintlnbold( "Woods: About fucking time!" );
    wait 5;
    iprintlnbold( "Woods: I think Perseus is gonna get the memo." );
    iprintlnbold( "Woods: Let's head out, Mason!" );
}

// Namespace namespace_19fc4094/namespace_19fc4094
// Params 0
// Checksum 0xf2665fe8, Offset: 0xb00
// Size: 0xcc
function function_45a92388()
{
    level endon( #"hash_5dfc215255b7bf4" );
    level thread function_d78fcf75();
    level flag::wait_till( "ac130_allowed" );
    iprintlnbold( "Command: Mason, we have air support on stand-by." );
    wait 1;
    iprintlnbold( "Command: Call it in if you need it." );
    wait 15;
    iprintlnbold( "Woods: Tangos everywhere, Mason! We're outnumbered." );
    wait 15;
    iprintlnbold( "Woods: Might want to call in that air support!" );
}

// Namespace namespace_19fc4094/namespace_19fc4094
// Params 0
// Checksum 0xe68943d8, Offset: 0xbd8
// Size: 0x5c
function function_d78fcf75()
{
    level flag::wait_till( "ac130_support" );
    iprintlnbold( "Mason: Send it in!" );
    wait 7;
    iprintlnbold( "Woods: Time to rain some pain!" );
}

// Namespace namespace_19fc4094/namespace_19fc4094
// Params 0
// Checksum 0x5f29fdf6, Offset: 0xc40
// Size: 0xb4
function function_de351837()
{
    level endon( #"start_evac_heli_infil" );
    nags = [];
    nags[ nags.size ] = "Command: Mason, we can't bring the chopper down until you mark a location.";
    nags[ nags.size ] = "Command: What's your situation down there? We need some smoke.";
    wait 20;
    i = 0;
    
    while ( true )
    {
        iprintlnbold( "" + nags[ i ] );
        i++;
        
        if ( i + 1 > nags.size )
        {
            i = 0;
        }
        
        wait 15;
    }
}

// Namespace namespace_19fc4094/namespace_19fc4094
// Params 0
// Checksum 0x4df97345, Offset: 0xd00
// Size: 0x6c
function function_4ee027e8()
{
    self endon( #"stop_smoke_equip_hint" );
    waittime = 8;
    
    while ( true )
    {
        self thread util::show_hint_text( #"hash_16a606142443c29f", 0, "stop_smoke_equip_hint", waittime );
        wait waittime * 2;
    }
}

// Namespace namespace_19fc4094/namespace_19fc4094
// Params 0
// Checksum 0x79723a33, Offset: 0xd78
// Size: 0x84
function function_503fd35b()
{
    self endon( #"stop_smoke_throw_hint" );
    self waittill( #"stop_smoke_equip_hint" );
    wait 0.5;
    waittime = 8;
    
    while ( true )
    {
        self thread util::show_hint_text( #"hash_8626041b4a29d", 0, "stop_smoke_throw_hint", waittime );
        wait waittime * 2;
    }
}

// Namespace namespace_19fc4094/namespace_19fc4094
// Params 0
// Checksum 0xfca617d5, Offset: 0xe08
// Size: 0xd6
function function_b8b78cfa()
{
    self endon( #"stop_smoke_throw_hint" );
    self waittill( #"evac_smoke_out" );
    secondaryoffhand = getweapon( #"willy_pete" );
    self giveweapon( secondaryoffhand );
    self setweaponammoclip( secondaryoffhand, 1 );
    self setweaponammostock( secondaryoffhand, 1 );
    self switchtooffhand( secondaryoffhand );
    self notify( #"stop_smoke_equip_hint" );
}

// Namespace namespace_19fc4094/namespace_19fc4094
// Params 0
// Checksum 0xf17872d4, Offset: 0xee8
// Size: 0x284
function function_df7926cc()
{
    wait 5;
    self thread function_4ee027e8();
    self thread function_503fd35b();
    self notifyonplayercommand( "evac_smoke_out", "+actionslot 1" );
    thread function_b8b78cfa();
    self waittill( #"stop_smoke_equip_hint" );
    
    while ( true )
    {
        waitresult = self waittill( #"grenade_fire" );
        grenade = waitresult.projectile;
        
        if ( grenade.model == #"wpn_t9_eqp_smoke_grenade_projectile" )
        {
            break;
        }
    }
    
    self notify( #"stop_smoke_throw_hint" );
    grenade makegrenadedud();
    ret = grenade waittilltimeout( 10, [ "death", #"projectile_impact", #"explode" ] );
    level.var_a16d9e19 = grenade.origin;
    evac::function_d1e14c76( level.var_a16d9e19 );
    e_vol = getent( "volume_evac_loc", "targetname" );
    
    if ( isdefined( e_vol ) && isdefined( level.var_dc8cac2a ) )
    {
        e_vol.origin = level.var_a16d9e19;
        level.var_dc8cac2a[ level.var_dc8cac2a.size ] = e_vol;
    }
    
    self util::delay( 1, undefined, &flag::set, "start_evac_heli_infil" );
    wait 2;
    iprintlnbold( "Evac confirmed. We've got a bird inbound to your location" );
    level flag::set( "ac130_allowed" );
}

// Namespace namespace_19fc4094/namespace_19fc4094
// Params 0
// Checksum 0x2a618dd, Offset: 0x1178
// Size: 0x224
function function_29758311()
{
    level endon( #"hash_5dfc215255b7bf4" );
    level endon( #"flag_evac_exfil_ready" );
    wait 15;
    level flag::wait_till( "ac130_allowed" );
    wait 6;
    self notifyonplayercommand( "ac130_support", "+actionslot 3" );
    self thread util::show_hint_text( #"hash_61be2df0c12c63bb", 0, "ac130_support", 10 );
    self waittill( #"ac130_support" );
    weap = getweapon( "ac130" );
    
    if ( isdefined( weap ) )
    {
        self giveweapon( weap );
        self switchtoweapon( weap );
        level flag::set( "evac_start_next_wave" );
        wait 0.3;
    }
    
    namespace_8bcd067b::function_1c110d7a( getent( "ac130_center_point", "targetname" ).origin, 8000 );
    self killstreaks::give( "ac130" );
    self killstreaks::usekillstreak( "ac130", 0 );
    
    if ( isdefined( weap ) )
    {
        wait 4;
        self takeweapon( weap );
    }
    
    ret = self waittill( #"gunner_left", #"hash_b7f6494fbf8dd9d" );
}

