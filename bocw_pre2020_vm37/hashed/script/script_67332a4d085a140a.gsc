#using script_3dc93ca9902a9cda;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_sp;
#using scripts\cp_common\snd_utility;

#namespace namespace_61150688;

// Namespace namespace_61150688/level_preinit
// Params 1, eflags: 0x44
// Checksum 0x6894b2a0, Offset: 0x170
// Size: 0x3c
function private event_handler[level_preinit] function_b489bb7b( *eventstruct )
{
    snd::function_5e69f468( &_objective );
    snd::wait_init();
}

// Namespace namespace_61150688/event_cc819519
// Params 1, eflags: 0x44
// Checksum 0x7d7c121, Offset: 0x1b8
// Size: 0xdc
function private event_handler[event_cc819519] function_686b88aa( *eventstruct )
{
    snd::wait_init();
    snd::waitforplayers();
    players = undefined;
    
    while ( !isarray( players ) || players.size == 0 )
    {
        players = getplayers();
        waitframe( 1 );
    }
    
    assert( isarray( players ) && players.size > 0 );
    snd::client_targetname( players[ 0 ], "player" );
}

// Namespace namespace_61150688/namespace_fdf485e5
// Params 1, eflags: 0x4
// Checksum 0xe245a3e8, Offset: 0x2a0
// Size: 0xea
function private _objective( objective )
{
    switch ( objective )
    {
        case #"tkdn_heli_intro":
            break;
        case #"tkdn_heli_convoy_aslt":
            break;
        case #"tkdn_heli_trailer_park":
            break;
        case #"tkdn_heli_hotel_breach":
            break;
        case #"tkdn_heli_exfil":
            break;
        case #"no_game":
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x38>" + objective + "<dev string:x5b>" );
            #/
            
            break;
    }
}

// Namespace namespace_61150688/namespace_fdf485e5
// Params 0
// Checksum 0x5b8a6291, Offset: 0x398
// Size: 0x4c
function function_42066f2b()
{
    music::setmusicstate( "b1.5_airfield_reveal" );
    level waittill( #"hash_16829c2fef1226f0" );
    level thread function_bff4c800();
}

// Namespace namespace_61150688/namespace_fdf485e5
// Params 0
// Checksum 0xd2b96499, Offset: 0x3f0
// Size: 0x1c
function function_bff4c800()
{
    music::setmusicstate( "b5.0_battle" );
}

// Namespace namespace_61150688/namespace_fdf485e5
// Params 0
// Checksum 0x108d11b5, Offset: 0x418
// Size: 0x4c
function function_b848f0c0()
{
    music::setmusicstate( "b2.0_recon" );
    level waittill( #"hash_6b5c0d1e8b95af4c" );
    music::setmusicstate( "3.2_kill_stinger" );
}

// Namespace namespace_61150688/namespace_fdf485e5
// Params 0
// Checksum 0x6e7053b1, Offset: 0x470
// Size: 0x1c
function function_2db60235()
{
    music::setmusicstate( "2.0_assault" );
}

// Namespace namespace_61150688/namespace_fdf485e5
// Params 0
// Checksum 0x9cb88d2c, Offset: 0x498
// Size: 0x3c4
function function_e04b45ab()
{
    snd::emitter( "emt_dirt_debris_fall_sm", ( -33905, 21185, -125 ), [ 4, 16 ] );
    snd::emitter( "emt_dirt_debris_fall_sm", ( -33960, 20940, -161 ), [ 5, 16 ] );
    snd::emitter( "emt_dirt_debris_fall_sm", ( -34065, 20880, -162 ), [ 6, 16 ] );
    snd::emitter( "emt_dirt_debris_fall_sm", ( -34716, 20938, -234 ), [ 3, 16 ] );
    snd::emitter( "emt_dirt_debris_fall_sm", ( -34758, 21052, -168 ), [ 2, 16 ] );
    snd::emitter( "emt_dirt_debris_fall_sm", ( -34713, 21248, 49 ), [ 1, 16 ] );
    snd::emitter( "emt_wood_debris_crumble_md", ( -34147, 21325, -120 ), [ 6, 12 ] );
    snd::emitter( "emt_wood_debris_crumble_md", ( -34254, 21132, -176 ), [ 8, 16 ] );
    snd::emitter( "emt_wood_debris_crumble_md", ( -34318, 20969, -128 ), [ 10, 20 ] );
    snd::emitter( "emt_wood_debris_crumble_md", ( -34881, 20946, -138 ), [ 6, 12 ] );
    snd::emitter( "emt_wood_wall_crack_md", ( -34028, 21281, -179 ), [ 3, 9 ] );
    snd::emitter( "emt_wood_wall_crack_md", ( -34229, 21204, -117 ), [ 6, 12 ] );
    snd::emitter( "emt_wood_wall_crack_md", ( -34056, 20962, -233 ), [ 9, 18 ] );
    snd::emitter( "emt_wood_wall_crack_md", ( -34595, 20885, -121 ), [ 22, 44 ] );
    snd::emitter( "emt_wood_wall_crack_md", ( -34808, 21264, -171 ), [ 3, 9 ] );
}

