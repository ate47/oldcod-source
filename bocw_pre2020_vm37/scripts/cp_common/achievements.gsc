#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace achievements;

// Namespace achievements/achievements
// Params 0, eflags: 0x6
// Checksum 0xa278da12, Offset: 0x140
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"achievements", &preinit, undefined, undefined, undefined );
}

// Namespace achievements/achievements
// Params 0, eflags: 0x4
// Checksum 0xf5d1a9dd, Offset: 0x188
// Size: 0xec
function private preinit()
{
    callback::on_connect( &on_player_connect );
    callback::on_ai_spawned( &on_ai_spawned );
    callback::on_ai_damage( &on_ai_damage );
    callback::on_ai_killed( &on_ai_killed );
    callback::on_player_killed( &on_player_death );
    spawner::add_archetype_spawn_function( #"wasp", &function_3b89bc8c, 3 );
    function_df1192a7();
}

// Namespace achievements/achievements
// Params 0
// Checksum 0x80f724d1, Offset: 0x280
// Size: 0x4
function function_df1192a7()
{
    
}

// Namespace achievements/achievements
// Params 2
// Checksum 0xf133ee1f, Offset: 0x290
// Size: 0xc4
function give_achievement( achievement, *var_a299f0b3 )
{
    assert( ishash( var_a299f0b3 ), "<dev string:x38>" );
    
    /#
        printtoprightln( "<dev string:x59>" + function_9e72a96( var_a299f0b3 ), ( 1, 1, 1 ) );
        println( "<dev string:x59>" + function_9e72a96( var_a299f0b3 ) );
    #/
    
    self giveachievement( var_a299f0b3 );
}

// Namespace achievements/achievements
// Params 0
// Checksum 0x3ff96cfe, Offset: 0x360
// Size: 0xe8
function on_player_connect()
{
    self endon( #"disconnect" );
    self.var_8e5e0541 = spawnstruct();
    self.var_8e5e0541.var_d3879c8e = 0;
    self.var_8e5e0541.var_ca87baa4 = 0;
    self.var_8e5e0541.kills = [];
    self.var_8e5e0541.var_f79c95f9 = [];
    self thread wall_run();
    self thread function_fd51b8a8();
    
    while ( true )
    {
        waitresult = self waittill( #"give_achievement" );
        give_achievement( waitresult.id );
    }
}

// Namespace achievements/achievements
// Params 3
// Checksum 0x7a6a9280, Offset: 0x450
// Size: 0x74
function function_20254235( eplayer, levelname, difficulty )
{
    if ( !isdefined( levelname ) || !isdefined( level.var_a67e7ff2[ levelname ] ) )
    {
        return;
    }
    
    if ( difficulty < 2 )
    {
        return;
    }
    
    eplayer give_achievement( level.var_a67e7ff2[ levelname ] );
}

// Namespace achievements/achievements
// Params 1
// Checksum 0x34ab38bb, Offset: 0x4d0
// Size: 0x23c
function function_cc2216e2( eplayer )
{
    var_b0abc67b = [];
    
    for ( index = 0; index <= 4 ; index++ )
    {
        var_b0abc67b[ index ] = 0;
    }
    
    mission_list = skipto::function_228558fd();
    var_d8222c25 = 0;
    
    foreach ( msn in mission_list )
    {
        if ( !eplayer stats::get_stat( #"playerstatsbymap", msn, #"hasbeencompleted" ) )
        {
            continue;
        }
        
        highestdifficulty = eplayer stats::get_stat( #"playerstatsbymap", msn, #"higheststats", #"highest_difficulty" );
        
        if ( !isdefined( var_b0abc67b[ highestdifficulty ] ) )
        {
            var_b0abc67b[ highestdifficulty ] = 0;
        }
        
        var_b0abc67b[ highestdifficulty ]++;
        var_d8222c25++;
    }
    
    var_7a34e971 = mission_list.size;
    
    if ( var_d8222c25 == var_7a34e971 )
    {
        eplayer give_achievement( #"hash_53599c8b078dc365" );
    }
    
    if ( var_b0abc67b[ 2 ] + var_b0abc67b[ 3 ] + var_b0abc67b[ 4 ] == var_7a34e971 )
    {
        eplayer give_achievement( #"hash_44658787e7fec380" );
    }
    
    if ( var_b0abc67b[ 4 ] == var_7a34e971 )
    {
        eplayer give_achievement( #"hash_bba8387a0f1b68d" );
    }
}

// Namespace achievements/achievements
// Params 4
// Checksum 0x1b2e992, Offset: 0x718
// Size: 0x6c
function function_f854bc50( eplayer, levelname, difficulty, var_540bb16f = 0 )
{
    if ( !var_540bb16f )
    {
        function_20254235( eplayer, levelname, difficulty );
        function_cc2216e2( eplayer );
    }
}

// Namespace achievements/achievements
// Params 0
// Checksum 0x678359b0, Offset: 0x790
// Size: 0x160
function wall_run()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"wallrun_begin" );
        v_start = self.origin;
        self waittill( #"wallrun_end" );
        var_1ab613d5 = distance( v_start, self.origin );
        var_ed0c1ff8 = self stats::get_stat( #"achievements", #"hash_f08aa26fabae647" );
        var_ed0c1ff8 += var_1ab613d5;
        
        /#
            printtoprightln( var_ed0c1ff8, ( 1, 1, 1 ) );
        #/
        
        if ( var_ed0c1ff8 >= 9843 )
        {
            give_achievement( #"hash_f08aa26fabae647" );
            return;
        }
        
        self stats::set_stat( #"achievements", #"hash_f08aa26fabae647", int( var_ed0c1ff8 ) );
    }
}

// Namespace achievements/achievements
// Params 0
// Checksum 0x80f724d1, Offset: 0x8f8
// Size: 0x4
function on_ai_spawned()
{
    
}

// Namespace achievements/achievements
// Params 1
// Checksum 0x47e066b8, Offset: 0x908
// Size: 0x5a
function on_ai_damage( s_params )
{
    self.var_e2f6147a = undefined;
    
    if ( isplayer( s_params.eattacker ) )
    {
        if ( s_params.idflags & 8 )
        {
            self.var_e2f6147a = s_params.eattacker;
        }
    }
}

// Namespace achievements/achievements
// Params 1
// Checksum 0xc58a9580, Offset: 0x970
// Size: 0x4e
function on_player_death( *s_params )
{
    self.var_8e5e0541.var_d3879c8e = 0;
    self.var_8e5e0541.var_ca87baa4 = 0;
    self.var_8e5e0541.kills = [];
    self.var_8e5e0541.var_f79c95f9 = [];
}

// Namespace achievements/achievements
// Params 2, eflags: 0x4
// Checksum 0x2f9c776d, Offset: 0x9c8
// Size: 0x164
function private function_467369b2( var_668b29af, evictim )
{
    if ( isdefined( var_668b29af.hijacked_vehicle_entity ) )
    {
        var_a8f62552 = distance( var_668b29af.hijacked_vehicle_entity.origin, evictim.origin );
    }
    else
    {
        var_a8f62552 = distance( var_668b29af.origin, evictim.origin );
    }
    
    if ( var_a8f62552 >= 3937 )
    {
        var_41db60bc = var_668b29af stats::get_stat( #"achievements", #"hash_5740a8698a4d0345" );
        var_41db60bc++;
        
        /#
            printtoprightln( "<dev string:x73>" + var_a8f62552 + "<dev string:x77>" + var_41db60bc, ( 1, 1, 1 ) );
        #/
        
        if ( var_41db60bc >= 5 )
        {
            var_668b29af give_achievement( #"hash_5740a8698a4d0345" );
            return;
        }
        
        var_668b29af stats::set_stat( #"achievements", #"hash_5740a8698a4d0345", var_41db60bc );
    }
}

// Namespace achievements/achievements
// Params 4, eflags: 0x4
// Checksum 0xd9030e0, Offset: 0xb38
// Size: 0x424
function private function_77815cb9( player, evictim, weapon, einflictor )
{
    if ( !isdefined( weapon ) )
    {
        return;
    }
    
    if ( !isdefined( player.var_aeefcc44 ) )
    {
        player.var_aeefcc44 = [];
        player.var_aeefcc44[ #"hash_408fb2adbfc8c813" ] = 0;
        player.var_aeefcc44[ #"hash_285b1aaee58defd5" ] = 0;
    }
    
    var_851f395f = 0;
    
    if ( weapon.name == "gadget_firefly_swarm" || weapon.name == "gadget_firefly_swarm_upgraded" )
    {
        function_4a76a0ba( player );
        var_851f395f = 1;
    }
    else if ( isdefined( player.var_8e5e0541.var_ace2d1f ) && weapon.name == "gadget_unstoppable_force" || weapon.name == "gadget_unstoppable_force_upgraded" )
    {
        player.var_8e5e0541.var_ace2d1f++;
        
        if ( player.var_8e5e0541.var_ace2d1f >= 5 )
        {
            player give_achievement( #"hash_779a3ec1f59b3b75" );
        }
    }
    else if ( isdefined( player.hijacked_vehicle_entity ) )
    {
        if ( isdefined( player.hijacked_vehicle_entity.killcount ) )
        {
            player.hijacked_vehicle_entity.killcount++;
        }
        else
        {
            player.hijacked_vehicle_entity.killcount = 1;
        }
        
        if ( player.hijacked_vehicle_entity.scriptvehicletype == #"wasp" && player.hijacked_vehicle_entity.killcount >= 20 )
        {
            if ( !player.var_aeefcc44[ #"hash_408fb2adbfc8c813" ] )
            {
                player give_achievement( #"hash_408fb2adbfc8c813" );
                player.var_aeefcc44[ #"hash_408fb2adbfc8c813" ] = 1;
            }
        }
        
        if ( player.hijacked_vehicle_entity.killcount >= 10 )
        {
            if ( !player.var_aeefcc44[ #"hash_285b1aaee58defd5" ] )
            {
                player give_achievement( #"hash_285b1aaee58defd5" );
                player.var_aeefcc44[ #"hash_285b1aaee58defd5" ] = 1;
            }
        }
    }
    else if ( isai( einflictor ) && isdefined( einflictor.remote_owner ) && einflictor.remote_owner == player )
    {
        if ( isdefined( einflictor.killcount ) )
        {
            einflictor.killcount++;
        }
        else
        {
            einflictor.killcount = 1;
        }
        
        if ( einflictor.killcount >= 10 )
        {
            if ( !player.var_aeefcc44[ #"hash_285b1aaee58defd5" ] )
            {
                player give_achievement( #"hash_285b1aaee58defd5" );
                player.var_aeefcc44[ #"hash_285b1aaee58defd5" ] = 1;
            }
        }
    }
    
    if ( isdefined( evictim.swarm ) && !var_851f395f )
    {
        function_4a76a0ba( player );
    }
    
    if ( isdefined( player.var_8e5e0541.var_ff703578 ) && player.var_8e5e0541.var_ff703578 >= 6 )
    {
        player give_achievement( #"hash_28244516dbc82179" );
    }
}

// Namespace achievements/achievements
// Params 3, eflags: 0x4
// Checksum 0xe9f26bbc, Offset: 0xf68
// Size: 0x14c
function private function_4239da84( player, *var_6d2d969a, *weapon )
{
    weapon.var_8e5e0541.var_ca87baa4++;
    currentindex = weapon.var_8e5e0541.var_d3879c8e;
    weapon.var_8e5e0541.kills[ currentindex ] = gettime();
    weapon.var_8e5e0541.var_d3879c8e = ( currentindex + 1 ) % 10;
    
    if ( weapon.var_8e5e0541.var_ca87baa4 < 10 )
    {
        return;
    }
    
    startindex = ( currentindex + 1 ) % 10;
    starttime = weapon.var_8e5e0541.kills[ startindex ];
    endtime = weapon.var_8e5e0541.kills[ currentindex ];
    
    if ( weapon.var_8e5e0541.var_ca87baa4 >= 10 && endtime - starttime <= 3000 )
    {
        weapon give_achievement( #"hash_1e7fe721b8911e57" );
    }
}

// Namespace achievements/achievements
// Params 2, eflags: 0x4
// Checksum 0xc5416682, Offset: 0x10c0
// Size: 0x16c
function private function_b25a404e( player, weapon )
{
    baseindex = getbaseweaponitemindex( weapon );
    
    if ( !isdefined( baseindex ) || baseindex < 1 || baseindex > 60 )
    {
        return;
    }
    
    player.var_8e5e0541.var_f79c95f9[ weapon.rootweapon.name ] = gettime();
    var_5f546d20 = 0;
    var_9aecaf58 = gettime() - 30000;
    
    if ( var_9aecaf58 < 0 )
    {
        var_9aecaf58 = 0;
    }
    
    foreach ( lastkilltime in player.var_8e5e0541.var_f79c95f9 )
    {
        if ( lastkilltime > var_9aecaf58 )
        {
            var_5f546d20++;
        }
    }
    
    if ( var_5f546d20 >= 5 )
    {
        player give_achievement( #"hash_1a6ca2f96f903656" );
    }
}

// Namespace achievements/achievements
// Params 3, eflags: 0x4
// Checksum 0xeb63156, Offset: 0x1238
// Size: 0x214
function private function_4fb1deb6( eplayer, evictim, *eweapon )
{
    if ( !eweapon util::function_614b5d1() || eweapon.team !== #"axis" )
    {
        return;
    }
    
    if ( !isdefined( evictim.var_8e5e0541.var_d10792d9 ) )
    {
        evictim.var_8e5e0541.var_d10792d9 = [];
    }
    
    if ( !isdefined( evictim.var_8e5e0541.var_d10792d9 ) )
    {
        evictim.var_8e5e0541.var_d10792d9 = [];
    }
    else if ( !isarray( evictim.var_8e5e0541.var_d10792d9 ) )
    {
        evictim.var_8e5e0541.var_d10792d9 = array( evictim.var_8e5e0541.var_d10792d9 );
    }
    
    evictim.var_8e5e0541.var_d10792d9[ evictim.var_8e5e0541.var_d10792d9.size ] = gettime();
    startindex = evictim.var_8e5e0541.var_d10792d9.size - 1;
    maxtime = gettime() - 3000;
    
    for ( timeindex = startindex; timeindex >= 0 ; timeindex-- )
    {
        if ( evictim.var_8e5e0541.var_d10792d9[ timeindex ] < maxtime )
        {
            arrayremoveindex( evictim.var_8e5e0541.var_d10792d9, timeindex );
        }
    }
    
    if ( evictim.var_8e5e0541.var_d10792d9.size >= 5 )
    {
        evictim give_achievement( #"hash_280dd71e1361f183" );
    }
}

// Namespace achievements/achievements
// Params 3, eflags: 0x4
// Checksum 0xb826f501, Offset: 0x1458
// Size: 0xdc
function private function_f1035da6( player, *victim, inflictor )
{
    if ( !isdefined( inflictor.weapon ) || !isdefined( self.scriptvehicletype ) || self.scriptvehicletype != "wasp" || inflictor.weapon.type != "grenade" )
    {
        return;
    }
    
    if ( !isdefined( inflictor.var_c4fa031e ) )
    {
        inflictor.var_c4fa031e = 1;
    }
    else
    {
        inflictor.var_c4fa031e++;
    }
    
    if ( inflictor.var_c4fa031e >= 3 )
    {
        victim give_achievement( #"hash_77033bac01562c98" );
    }
}

// Namespace achievements/achievements
// Params 3
// Checksum 0x37593aef, Offset: 0x1540
// Size: 0xb4
function function_2240fcb8( eattacker, *evictim, *eweapon )
{
    if ( isdefined( eweapon.var_628ca13e ) && isplayer( eweapon.var_628ca13e ) )
    {
        if ( isdefined( eweapon.killcount ) )
        {
            eweapon.killcount++;
        }
        else
        {
            eweapon.killcount = 1;
        }
        
        if ( eweapon.killcount >= 10 )
        {
            eweapon.var_628ca13e give_achievement( #"hash_285b1aaee58defd5" );
        }
    }
}

// Namespace achievements/achievements
// Params 2
// Checksum 0xf8d02dc1, Offset: 0x1600
// Size: 0x7c
function function_8b531812( eplayer, evictim )
{
    if ( isdefined( evictim.var_e2f6147a ) && evictim.var_e2f6147a == eplayer && evictim.team !== #"allies" )
    {
        eplayer give_achievement( #"hash_1f0a3ec94eff5513" );
    }
}

// Namespace achievements/achievements
// Params 1
// Checksum 0x7bdc2d7a, Offset: 0x1688
// Size: 0x5c
function function_6e3f345f( eplayer )
{
    var_71c7cc3a = eplayer getmeleechaincount();
    
    if ( 2 <= var_71c7cc3a )
    {
        eplayer give_achievement( #"hash_42303e6214910391" );
    }
}

// Namespace achievements/achievements
// Params 1
// Checksum 0xe84b2f01, Offset: 0x16f0
// Size: 0x174
function on_ai_killed( s_params )
{
    if ( isplayer( s_params.eattacker ) )
    {
        player = s_params.eattacker;
        function_467369b2( player, self );
        function_77815cb9( player, self, s_params.weapon, s_params.einflictor );
        function_6e3f345f( player );
        function_4239da84( player, self, s_params.weapon );
        function_b25a404e( player, s_params.weapon );
        function_f1035da6( player, self, s_params.einflictor );
        function_4fb1deb6( player, self, s_params.weapon );
        function_8b531812( player, self );
        return;
    }
    
    if ( isai( s_params.eattacker ) )
    {
        function_2240fcb8( s_params.eattacker, self, s_params.weapon );
    }
}

// Namespace achievements/achievements
// Params 1
// Checksum 0x3550884, Offset: 0x1870
// Size: 0xc
function function_3b89bc8c( *n_count )
{
    
}

// Namespace achievements/achievements
// Params 1, eflags: 0x4
// Checksum 0xf7933b24, Offset: 0x1888
// Size: 0x50
function private function_4a76a0ba( player )
{
    if ( !isdefined( player.var_8e5e0541.var_ff703578 ) )
    {
        player.var_8e5e0541.var_ff703578 = 1;
        return;
    }
    
    player.var_8e5e0541.var_ff703578++;
}

// Namespace achievements/achievements
// Params 0, eflags: 0x4
// Checksum 0xb66290e3, Offset: 0x18e0
// Size: 0xa4
function private function_fd51b8a8()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        waitresult = self waittill( #"gun_level_complete" );
        
        if ( waitresult.is_last_rank && waitresult.item_index >= 1 && waitresult.item_index <= 60 )
        {
            self give_achievement( #"hash_30b6860e2869b596" );
            break;
        }
    }
}

// Namespace achievements/achievements
// Params 1
// Checksum 0xe62aae64, Offset: 0x1990
// Size: 0x3c
function function_c3541c14( var_71d636c6 )
{
    if ( var_71d636c6 == 3 )
    {
        self give_achievement( #"hash_5f39b2b443875e95" );
    }
}

// Namespace achievements/achievements
// Params 0
// Checksum 0x4d2fb9ea, Offset: 0x19d8
// Size: 0xb2
function function_cc7c4ef7()
{
    if ( level.var_bbf69fe8 == 0 )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player.var_8e5e0541.var_ff703578 ) )
            {
                continue;
            }
            
            player.var_8e5e0541.var_ff703578 = undefined;
        }
    }
}

// Namespace achievements/achievements
// Params 1
// Checksum 0x33d681d1, Offset: 0x1a98
// Size: 0x1e
function function_ff833026( player )
{
    player.var_8e5e0541.var_ace2d1f = 0;
}

// Namespace achievements/achievements
// Params 1
// Checksum 0x86c7e708, Offset: 0x1ac0
// Size: 0x26
function function_8eac3923( eai )
{
    if ( isdefined( eai.killcount ) )
    {
        eai.killcount = undefined;
    }
}

