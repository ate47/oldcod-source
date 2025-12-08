#using script_1cd690a97dfca36e;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;

#namespace namespace_1b106d35;

// Namespace namespace_1b106d35/level_preinit
// Params 1, eflags: 0x40
// Checksum 0x136c8b92, Offset: 0x4b0
// Size: 0x8c
function event_handler[level_preinit] function_b489bb7b( *eventstruct )
{
    snd::function_d4ec748e( &function_f2a2832d );
    snd::function_ce78b33b( &function_32ab045 );
    snd::trigger_init( &_trigger );
    snd::function_5e69f468( &_objective );
}

// Namespace namespace_1b106d35/event_cc819519
// Params 1, eflags: 0x40
// Checksum 0xa496383e, Offset: 0x548
// Size: 0x94
function event_handler[event_cc819519] function_686b88aa( *eventstruct )
{
    snd::wait_init();
    snd::waitforplayers();
    thread function_70bfbb49();
    level.player = snd::getplayerssafe()[ 0 ];
    thread function_b3665e44();
    thread function_96ace06();
    thread function_3e460f0a();
}

// Namespace namespace_1b106d35/namespace_1b106d35
// Params 2, eflags: 0x4
// Checksum 0xf4b6629a, Offset: 0x5e8
// Size: 0x20a
function private function_32ab045( ent, name )
{
    switch ( name )
    {
        case #"hash_484b8b723a21da55":
            level.var_77be18d2 = ent;
            thread function_d9013492( ent );
            ent waittill( #"death" );
            level.var_77be18d2 = undefined;
            break;
        case #"hash_10dca2bc3c2e34e":
            level.var_77be18d2 = ent;
            level flag::set( "flg_audio_fav_started" );
            thread function_d9013492( ent );
            ent waittill( #"death" );
            level.var_77be18d2 = undefined;
            break;
        case #"hash_1bc644480960a85":
            level.var_47acec0 = ent;
            thread function_ed98c6a7( ent );
            ent waittill( #"death" );
            level.var_47acec0 = undefined;
            break;
        case #"hash_15f9e8ed7a4588e3":
            level.var_47acec0 = ent;
            thread function_a2b0a37d( ent );
            ent waittill( #"death" );
            level.var_47acec0 = undefined;
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x38>" + snd::function_783b69( name, "<dev string:x5d>" ) );
            #/
            
            break;
    }
}

// Namespace namespace_1b106d35/namespace_1b106d35
// Params 3, eflags: 0x4
// Checksum 0x12bd5754, Offset: 0x800
// Size: 0xd2
function private _trigger( *player, trigger, *var_ec80d14b )
{
    trigger_name = snd::function_ea2f17d1( var_ec80d14b.script_ambientroom, "$default" );
    
    switch ( trigger_name )
    {
        case #"hash_4f192f4756c79209":
        case #"$default":
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x62>" + trigger_name + "<dev string:x5d>" );
            #/
            
            break;
    }
}

// Namespace namespace_1b106d35/namespace_1b106d35
// Params 2, eflags: 0x4
// Checksum 0xe2e6e5b3, Offset: 0x8e0
// Size: 0x17a
function private function_f2a2832d( *player, msg )
{
    switch ( msg )
    {
        case #"hash_5261bc976db253b3":
            thread function_3478ae35();
            break;
        case #"hash_6010cf0b59441d62":
            thread function_82927216();
            break;
        case #"hash_390a58cb20fbbde2":
            level notify( #"hash_201c2ab5508a84de" );
            break;
        case #"hash_4e1c23615a77bd97":
            thread function_c2a390ee();
            break;
        case #"hash_6452914c3682f6a6":
            thread function_3e4f581();
            break;
        case #"hash_1182c9e90f5942f":
            thread function_e45db9b2();
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x86>" + snd::function_783b69( msg, "<dev string:x5d>" ) );
            #/
            
            break;
    }
}

// Namespace namespace_1b106d35/namespace_1b106d35
// Params 1, eflags: 0x4
// Checksum 0x48f40471, Offset: 0xa68
// Size: 0xfa
function private _objective( objective )
{
    switch ( objective )
    {
        case #"infil":
            break;
        case #"emp_flash":
            break;
        case #"courtyard":
            break;
        case #"catacombs":
            break;
        case #"graveyard":
            break;
        case #"hash_7433baf853004942":
            break;
        case #"no_game":
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:xa4>" + objective + "<dev string:x5d>" );
            #/
            
            break;
    }
}

// Namespace namespace_1b106d35/namespace_1b106d35
// Params 0
// Checksum 0xdc3231ee, Offset: 0xb70
// Size: 0xc64
function function_befba10a()
{
    plr = undefined;
    var_58602358 = [ [ "tmp_animal_bird", plr, [ 3, 12 ], [ 1200, 1800 ], [ -90, 90 ] ], [ "tmp_animal_dog_angry_bark", plr, [ 3, 12 ], [ 1200, 1800 ], [ -90, 90 ] ], [ "tmp_animal_donkey", plr, [ 3, 12 ], [ 1200, 1800 ], [ -90, 90 ] ], [ "tmp_animal_horse", plr, [ 3, 12 ], [ 1200, 1800 ], [ -90, 90 ] ], [ "tmp_animal_rat", plr, [ 3, 12 ], [ 1200, 1800 ], [ -90, 90 ] ], [ "tmp_animal_seagulls", plr, [ 3, 12 ], [ 1200, 1800 ], [ -90, 90 ] ], [ "tmp_animal_wolf_howls", plr, [ 3, 12 ], [ 1200, 1800 ], [ -90, 90 ] ] ];
    snd::element_init( "$default", var_58602358 );
    interior = [ [ "tmp_env_cave_int_single_drips", plr, [ 3, 12 ], [ 1200, 1800 ], [ -90, 90 ] ], [ "tmp_debris_dust", plr, [ 3, 12 ], [ 1200, 1800 ], [ -90, 90 ] ], [ "tmp_debris_glass", plr, [ 3, 12 ], [ 1200, 1800 ], [ -90, 90 ] ], [ "tmp_debris_glass_metal_lrg", plr, [ 3, 12 ], [ 1200, 1800 ], [ -90, 90 ] ], [ "tmp_debris_glass_metal_sml", plr, [ 3, 12 ], [ 1200, 1800 ], [ -90, 90 ] ], [ "tmp_debris_metal_lrg", plr, [ 3, 12 ], [ 1200, 1800 ], [ -90, 90 ] ], [ "tmp_debris_metal_med", plr, [ 3, 12 ], [ 1200, 1800 ], [ -90, 90 ] ], [ "tmp_debris_metal_sml", plr, [ 3, 12 ], [ 1200, 1800 ], [ -90, 90 ] ], [ "tmp_debris_rocks_lrg", plr, [ 3, 12 ], [ 1200, 1800 ], [ -90, 90 ] ], [ "tmp_debris_rocks_med", plr, [ 3, 12 ], [ 1200, 1800 ], [ -90, 90 ] ], [ "tmp_debris_rocks_sml", plr, [ 3, 12 ], [ 1200, 1800 ], [ -90, 90 ] ], [ "tmp_debris_wood_med", plr, [ 3, 12 ], [ 1200, 1800 ], [ -90, 90 ] ], [ "tmp_debris_wood_sml", plr, [ 3, 12 ], [ 1200, 1800 ], [ -90, 90 ] ] ];
    snd::element_init( "interior", interior );
    snd::element_init( "interior_cave", "interior" );
}

// Namespace namespace_1b106d35/namespace_1b106d35
// Params 0
// Checksum 0x79fdb1d7, Offset: 0x17e0
// Size: 0x2c
function function_b3665e44()
{
    level waittill( #"hash_5c0e295bf1c8ee37" );
    thread function_5271e091();
}

// Namespace namespace_1b106d35/namespace_1b106d35
// Params 0
// Checksum 0x59f7d357, Offset: 0x1818
// Size: 0x2c
function function_96ace06()
{
    level waittill( #"hash_73c8edce39fa397a" );
    thread function_5271e091();
}

// Namespace namespace_1b106d35/namespace_1b106d35
// Params 0
// Checksum 0x2d854cc3, Offset: 0x1850
// Size: 0x18e
function function_5271e091()
{
    if ( level flag::get( "flg_audio_fav_started" ) == 1 )
    {
        return;
    }
    
    level flag::set( "flg_audio_fav_started" );
    level.var_456dc77d = snd::play( [ 0, "tmp_veh_intro_scripted_drive_lp_lr", 1 ] );
    level.var_9b00aa65 = snd::play( [ 0, "tmp_veh_intro_scripted_drive_lp_lsrs", 1 ] );
    level waittill( #"hash_6c03cbe4da70f5c4" );
    wait 1;
    snd::stop( level.var_456dc77d, 0.5 );
    snd::stop( level.var_9b00aa65, 0.5 );
    var_d5a0eda4 = snd::play( [ "tmp_veh_intro_scripted_drive_end_lr", 0.35 ] );
}

// Namespace namespace_1b106d35/namespace_1b106d35
// Params 0
// Checksum 0x67728b99, Offset: 0x19e8
// Size: 0x34
function function_3e460f0a()
{
    level waittill( #"hash_5c0e295bf1c8ee37" );
    snd::play( "amb_aa_gun_distant_fire_lr" );
}

// Namespace namespace_1b106d35/namespace_1b106d35
// Params 1
// Checksum 0xa5fb6ec4, Offset: 0x1a28
// Size: 0xd4
function function_d9013492( ent )
{
    level waittill( #"hash_7544c8e6cd7cd946" );
    
    if ( level flag::get( "flg_audio_fav_idle" ) == 1 )
    {
        return;
    }
    
    level flag::set( "flg_audio_fav_idle" );
    var_ab2f53c3 = snd::play( [ 0.5, "veh_intro_scripted_idle_lp_lr", 2.5 ], ent );
    thread function_f82d04fd();
}

// Namespace namespace_1b106d35/namespace_1b106d35
// Params 0
// Checksum 0x7eb4d506, Offset: 0x1b08
// Size: 0xbe
function function_f82d04fd()
{
    var_ccffb456 = [ ( 7385, -3554, 176 ), ( 7588, -3548, 176 ), ( 7794, -3683, 183 ), ( 8013, -3514, 200 ), ( 7964, -3029, 182 ), ( 7779, -2814, 188 ) ];
    var_ccffb456 = snd::play( "veh_intro_scripted_npc_idle_lp", var_ccffb456 );
}

// Namespace namespace_1b106d35/namespace_1b106d35
// Params 0
// Checksum 0x75465ffa, Offset: 0x1bd0
// Size: 0x1c
function function_3478ae35()
{
    snd::play( "evt_emp_blast_screenshake_lr" );
}

// Namespace namespace_1b106d35/namespace_1b106d35
// Params 0
// Checksum 0x9f48b4c, Offset: 0x1bf8
// Size: 0x1c
function function_82927216()
{
    snd::play( "evt_emp_blast_shockwave_lr" );
}

// Namespace namespace_1b106d35/namespace_1b106d35
// Params 0
// Checksum 0x80f724d1, Offset: 0x1c20
// Size: 0x4
function function_70bfbb49()
{
    
}

// Namespace namespace_1b106d35/namespace_1b106d35
// Params 0
// Checksum 0xf20e85ec, Offset: 0x1c30
// Size: 0x2c
function function_c2a390ee()
{
    snd::play( "evt_church_door_kick_open", ( 10655, -4868, 262 ) );
}

// Namespace namespace_1b106d35/namespace_1b106d35
// Params 0
// Checksum 0xdea8110d, Offset: 0x1c68
// Size: 0x1c
function function_3e4f581()
{
    snd::play( "evt_catacombs_distant_bomb_explo" );
}

// Namespace namespace_1b106d35/namespace_1b106d35
// Params 1
// Checksum 0x76c7b62c, Offset: 0x1c90
// Size: 0x24
function function_ed98c6a7( ent )
{
    snd::play( "evt_juggernaut_door_close", ent );
}

// Namespace namespace_1b106d35/namespace_1b106d35
// Params 1
// Checksum 0xef6b8c32, Offset: 0x1cc0
// Size: 0x24
function function_a2b0a37d( ent )
{
    snd::play( "evt_juggernaut_door_open", ent );
}

// Namespace namespace_1b106d35/namespace_1b106d35
// Params 0
// Checksum 0x1bcb9139, Offset: 0x1cf0
// Size: 0x74
function function_e45db9b2()
{
    if ( level flag::get( "flg_audio_graveyard_fire" ) == 1 )
    {
        return;
    }
    
    level flag::set( "flg_audio_graveyard_fire" );
    snd::play( "emt_fire_lrg_lp_no_occ", ( 10197, -5638, 269 ) );
}

