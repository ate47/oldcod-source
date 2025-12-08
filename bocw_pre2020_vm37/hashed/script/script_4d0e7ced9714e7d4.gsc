#using scripts\abilities\ability_player;
#using scripts\abilities\ability_util;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\util;
#using scripts\weapons\weapon_utils;

#namespace namespace_ac5221d7;

// Namespace namespace_ac5221d7/namespace_bb79dbfe
// Params 0
// Checksum 0x2e1512eb, Offset: 0x1c8
// Size: 0x11c
function function_292592aa()
{
    function_5aed5305();
    var_9e22157a = getweapon( #"ar_standard_t9", array( "stalker" ) );
    var_d9338b9c = getweapon( #"pistol_semiauto_t9", array( "extbarrel", "fastreload" ) );
    self giveweapon( var_9e22157a );
    self givemaxammo( var_9e22157a );
    self giveweapon( var_d9338b9c );
    self givemaxammo( var_d9338b9c );
    self switchtoweaponimmediate( var_9e22157a );
}

// Namespace namespace_ac5221d7/namespace_bb79dbfe
// Params 0
// Checksum 0x8545732e, Offset: 0x2f0
// Size: 0x11c
function function_a22db743()
{
    function_5aed5305();
    var_9e22157a = getweapon( #"ar_damage_t9", array( "stalker" ) );
    var_d9338b9c = getweapon( #"tr_damagesemi_t9", array( "extbarrel", "fastreload" ) );
    self giveweapon( var_9e22157a );
    self givemaxammo( var_9e22157a );
    self giveweapon( var_d9338b9c );
    self givemaxammo( var_d9338b9c );
    self switchtoweaponimmediate( var_9e22157a );
}

// Namespace namespace_ac5221d7/namespace_bb79dbfe
// Params 0, eflags: 0x4
// Checksum 0xbb9cfd1b, Offset: 0x418
// Size: 0x124
function private function_5aed5305()
{
    self flag::wait_till( #"loadout_given" );
    var_f0e0740 = self getweaponslist();
    
    foreach ( w in var_f0e0740 )
    {
        self takeweapon( w );
    }
    
    grenade = getweapon( #"frag_grenade" );
    self giveweapon( grenade );
    self givemaxammo( grenade );
}

// Namespace namespace_ac5221d7/namespace_bb79dbfe
// Params 2
// Checksum 0x6ce9ebfd, Offset: 0x548
// Size: 0x44
function function_6f94ced5( a_ents, *str_shot )
{
    if ( !isdefined( level.var_deda09e ) )
    {
        str_shot[ #"hash_6283351922cfba88" ] delete();
    }
}

// Namespace namespace_ac5221d7/namespace_bb79dbfe
// Params 3
// Checksum 0x83071c5, Offset: 0x598
// Size: 0x200
function function_ed760ecb( var_a7f24c3d, var_b895b611 = 1, var_d3440450 = level.var_28c22d88[ 0 ] )
{
    ai = getent( var_a7f24c3d, "targetname", 1 );
    
    if ( !isalive( ai ) )
    {
        var_e582d78a = getent( var_a7f24c3d, "targetname" );
        ai = spawner::simple_spawn_single( var_e582d78a );
    }
    
    ai val::set( #"hash_4cf5e706fc89474b", "allowdeath", 0 );
    
    if ( !isdefined( level.allies ) )
    {
        level.allies = [];
    }
    else if ( !isarray( level.allies ) )
    {
        level.allies = array( level.allies );
    }
    
    if ( !isinarray( level.allies, ai ) )
    {
        level.allies[ level.allies.size ] = ai;
    }
    
    if ( is_true( var_b895b611 ) )
    {
        ai function_55623c92( var_d3440450, var_a7f24c3d );
    }
    
    ai setgoal( ai.origin );
    ai.enableterrainik = 1;
    level.( var_a7f24c3d ) = ai;
    return ai;
}

// Namespace namespace_ac5221d7/namespace_bb79dbfe
// Params 2
// Checksum 0x31f48d6b, Offset: 0x7a0
// Size: 0xfc
function function_55623c92( var_d3440450 = level.var_28c22d88[ 0 ], str_name = self.targetname )
{
    var_142cfe56 = var_d3440450 + "_" + str_name;
    s_org = struct::get( var_142cfe56, "targetname" );
    
    if ( isdefined( s_org ) )
    {
        self forceteleport( s_org.origin, s_org.angles );
        return;
    }
    
    /#
        iprintln( "<dev string:x38>" + str_name + "<dev string:x3f>" + level.var_c2ccaeac + "<dev string:x68>" );
    #/
}

// Namespace namespace_ac5221d7/namespace_bb79dbfe
// Params 0
// Checksum 0xec4dd872, Offset: 0x8a8
// Size: 0x20
function function_7b37895()
{
    if ( isdefined( level.var_deda09e ) )
    {
        return level.var_deda09e;
    }
}

// Namespace namespace_ac5221d7/namespace_bb79dbfe
// Params 3
// Checksum 0x9c6ebd4a, Offset: 0x8d0
// Size: 0x4c
function function_cfc94b81( guys, count, flag )
{
    ai::waittill_dead_or_dying( guys, count );
    level flag::set( flag );
}

// Namespace namespace_ac5221d7/namespace_bb79dbfe
// Params 4
// Checksum 0x896e1780, Offset: 0x928
// Size: 0x54
function function_d6fedf97( guys, killcount, sflag, timeout )
{
    ai::waittill_dead_or_dying( guys, killcount, timeout );
    level flag::set( sflag );
}

// Namespace namespace_ac5221d7/namespace_bb79dbfe
// Params 4
// Checksum 0x18688ff, Offset: 0x988
// Size: 0x27c
function function_603d935( var_c5827a95, n_goalradius = 200, var_dd47e22 = 0.1, var_27ff9e4 = 0.4 )
{
    self endon( #"death" );
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy === "run_to_delete" )
    {
        a_nodes = getnodearraysorted( "delete_runner_node", "targetname", self.origin, 2048 );
        
        if ( a_nodes.size )
        {
            self thread ai::force_goal( a_nodes[ 0 ], 0 );
            self thread ai::bloody_death( randomintrange( 2, 5 ) );
            return;
        }
        else
        {
            /#
                iprintlnbold( "<dev string:xa0>" );
            #/
        }
    }
    
    e_vol = getent( var_c5827a95, "targetname" );
    wait randomfloatrange( var_dd47e22, var_27ff9e4 );
    self notify( #"stop_going_to_node" );
    self val::set( #"hash_4629ea2949a36bbb", "goalradius", n_goalradius );
    self thread ai::set_goal_ent( e_vol );
    self.ignoresuppression = 1;
    self.grenadeawareness = 0;
    self ai::set_behavior_attribute( "sprint", 1 );
    self waittill( #"goal" );
    self.ignoresuppression = 0;
    self.grenadeawareness = 1;
    self ai::set_behavior_attribute( "sprint", 0 );
    self val::reset_all( #"hash_4629ea2949a36bbb" );
}

