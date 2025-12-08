#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\oob;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace savegame;

// Namespace savegame/save
// Params 0, eflags: 0x6
// Checksum 0x6ccac9fb, Offset: 0x1b0
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"save", &preinit, undefined, undefined, undefined );
}

// Namespace savegame/save
// Params 0, eflags: 0x4
// Checksum 0xeed0c18, Offset: 0x1f8
// Size: 0x26c
function private preinit()
{
    if ( !isdefined( world.loadout ) )
    {
        world.loadout = [];
    }
    
    if ( !isdefined( world.mapdata ) )
    {
        world.mapdata = [];
    }
    
    if ( !isdefined( world.playerdata ) )
    {
        world.playerdata = [];
    }
    
    missionid = function_8136eb5a();
    
    if ( !isdefined( world.mapdata[ missionid ][ #"persistent" ] ) )
    {
        world.mapdata[ missionid ][ #"persistent" ] = spawnstruct();
    }
    
    if ( !isdefined( world.mapdata[ missionid ][ #"transient" ] ) )
    {
        world.mapdata[ missionid ][ #"transient" ] = spawnstruct();
    }
    
    sv_savegameskipto = getdvar( #"sv_savegameskipto", "" );
    
    if ( !isdefined( sv_savegameskipto ) || sv_savegameskipto.size == 0 || sv_savegameskipto == skipto::function_5011fee2( missionid ) )
    {
        function_81534803( #"transient" );
    }
    
    foreach ( trig in trigger::get_all() )
    {
        if ( is_true( trig.script_checkpoint ) )
        {
            trig thread checkpoint_trigger();
        }
    }
    
    level.var_a1cfeb5a = [];
}

// Namespace savegame/save
// Params 1
// Checksum 0xaf583d21, Offset: 0x470
// Size: 0x1cc
function save( var_116ab377 )
{
    if ( !function_7642d0c9() || level.gameended )
    {
        return;
    }
    
    if ( !isdefined( var_116ab377 ) )
    {
        var_116ab377 = function_8136eb5a();
    }
    
    savegame_create( var_116ab377 );
    var_2466c81f = getmaporder() < 0;
    
    if ( var_2466c81f )
    {
        return;
    }
    
    player = getplayers()[ 0 ];
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    missiondata = function_6440b06b( #"persistent", var_116ab377 );
    missiondata.unlocked = 1;
    player stats::set_stat( #"mapdata", var_116ab377, #"unlocked", 1 );
    currentmission = function_8136eb5a();
    player stats::set_stat( #"hash_49ab379a0e46a51f", currentmission );
    currentutctime = getutc();
    player stats::set_stat( #"mapdata", currentmission, #"hash_6addb0d6ea1de644", currentutctime );
    uploadstats( player );
}

// Namespace savegame/save
// Params 0
// Checksum 0x8f70f282, Offset: 0x648
// Size: 0x19c
function function_521de2b3()
{
    player = getplayers()[ 0 ];
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    currentmission = function_8136eb5a();
    persistent = function_6440b06b( #"persistent", currentmission );
    transient = function_6440b06b( #"transient", currentmission );
    persistent.complete = 1;
    player stats::set_stat( #"mapdata", currentmission, #"complete", persistent.complete );
    
    if ( !isdefined( persistent.var_8757a567 ) )
    {
        persistent.var_8757a567 = 0;
    }
    
    if ( !isdefined( transient.var_9ac9bc79 ) )
    {
        transient.var_9ac9bc79 = 0;
    }
    
    if ( transient.var_9ac9bc79 > persistent.var_8757a567 )
    {
        persistent.var_8757a567 = transient.var_9ac9bc79;
    }
    
    player stats::set_stat( #"mapdata", currentmission, #"highestdifficulty", persistent.var_8757a567 );
    uploadstats( player );
}

// Namespace savegame/save
// Params 0
// Checksum 0xaff67e82, Offset: 0x7f0
// Size: 0x24
function function_fa31c391()
{
    function_8d95e71c();
    function_a620739b();
}

// Namespace savegame/save
// Params 1
// Checksum 0xc213a661, Offset: 0x820
// Size: 0x9c
function function_87dafd45( name )
{
    if ( isdefined( level.var_3a8f95b4 ) && level.var_3a8f95b4 != name && level.script != "cp_ger_hub" )
    {
        errormsg( "<dev string:x38>" + level.var_3a8f95b4 + "<dev string:x61>" + name + "<dev string:x69>" );
    }
    
    level.var_3a8f95b4 = name;
}

// Namespace savegame/save
// Params 0
// Checksum 0xa4732727, Offset: 0x8c8
// Size: 0x36
function function_8136eb5a()
{
    if ( !isdefined( level.var_3a8f95b4 ) )
    {
        function_87dafd45( level.script );
    }
    
    return level.var_3a8f95b4;
}

// Namespace savegame/save
// Params 2
// Checksum 0x3530a76a, Offset: 0x908
// Size: 0xda
function function_6440b06b( dataname = #"transient", missionname = function_8136eb5a() )
{
    if ( !isdefined( world.mapdata ) )
    {
        world.mapdata = [];
    }
    
    if ( !isdefined( world.mapdata[ missionname ] ) )
    {
        world.mapdata[ missionname ] = [];
    }
    
    if ( !isdefined( world.mapdata[ missionname ][ dataname ] ) )
    {
        world.mapdata[ missionname ][ dataname ] = spawnstruct();
    }
    
    return world.mapdata[ missionname ][ dataname ];
}

// Namespace savegame/save
// Params 2
// Checksum 0x8d1b8e72, Offset: 0x9f0
// Size: 0x126
function function_81534803( dataname, missionname = function_8136eb5a() )
{
    if ( isdefined( world.mapdata ) && isdefined( world.mapdata[ missionname ] ) )
    {
        if ( isdefined( dataname ) )
        {
            if ( isdefined( world.mapdata[ missionname ][ dataname ] ) )
            {
                world.mapdata[ missionname ][ dataname ] = spawnstruct();
            }
            
            return;
        }
        
        foreach ( dataname, value in world.mapdata[ missionname ] )
        {
            world.mapdata[ missionname ][ dataname ] = spawnstruct();
        }
    }
}

// Namespace savegame/save
// Params 0
// Checksum 0xa207818c, Offset: 0xb20
// Size: 0x20
function function_a620739b()
{
    if ( isdefined( world.mapdata ) )
    {
        world.mapdata = [];
    }
}

// Namespace savegame/save
// Params 0
// Checksum 0x8d44c9eb, Offset: 0xb48
// Size: 0xec
function function_7e0e735b()
{
    missionname = function_8136eb5a();
    level.var_d6bcee66 = [];
    
    if ( isdefined( world.mapdata[ missionname ] ) )
    {
        foreach ( dataname, value in world.mapdata[ missionname ] )
        {
            level.var_d6bcee66[ dataname ] = structcopy( world.mapdata[ missionname ][ dataname ], 1 );
        }
    }
}

// Namespace savegame/save
// Params 0
// Checksum 0x207221ae, Offset: 0xc40
// Size: 0xe6
function function_9797184c()
{
    function_81534803();
    missionname = function_8136eb5a();
    
    if ( isdefined( level.var_d6bcee66 ) )
    {
        foreach ( dataname, value in level.var_d6bcee66 )
        {
            world.mapdata[ missionname ][ dataname ] = structcopy( level.var_d6bcee66[ dataname ], 1 );
        }
    }
}

// Namespace savegame/save
// Params 0
// Checksum 0xbfd83f2, Offset: 0xd30
// Size: 0x4de
function function_379f84b3()
{
    missionid = function_8136eb5a();
    world.mapdata[ missionid ][ #"transient" ].var_2e7c022f = [];
    player = getplayers()[ 0 ];
    a_weapon_list = player getweaponslist();
    current_weapon = player getcurrentweapon();
    world.mapdata[ missionid ][ #"transient" ].var_37017d9 = current_weapon.name;
    
    foreach ( weapon in a_weapon_list )
    {
        if ( isdefined( weapon.name ) )
        {
            if ( !isdefined( world.mapdata[ missionid ][ #"transient" ].var_2e7c022f ) )
            {
                world.mapdata[ missionid ][ #"transient" ].var_2e7c022f = [];
            }
            else if ( !isarray( world.mapdata[ missionid ][ #"transient" ].var_2e7c022f ) )
            {
                world.mapdata[ missionid ][ #"transient" ].var_2e7c022f = array( world.mapdata[ missionid ][ #"transient" ].var_2e7c022f );
            }
            
            world.mapdata[ missionid ][ #"transient" ].var_2e7c022f[ world.mapdata[ missionid ][ #"transient" ].var_2e7c022f.size ] = weapon.name;
            
            if ( isdefined( weapon.attachments ) && weapon.attachments.size > 0 )
            {
                world.mapdata[ missionid ][ #"transient" ].var_ba4d1bad[ weapon.name ] = [];
                
                foreach ( attachment in weapon.attachments )
                {
                    if ( !isdefined( world.mapdata[ missionid ][ #"transient" ].var_ba4d1bad[ weapon.name ] ) )
                    {
                        world.mapdata[ missionid ][ #"transient" ].var_ba4d1bad[ weapon.name ] = [];
                    }
                    else if ( !isarray( world.mapdata[ missionid ][ #"transient" ].var_ba4d1bad[ weapon.name ] ) )
                    {
                        world.mapdata[ missionid ][ #"transient" ].var_ba4d1bad[ weapon.name ] = array( world.mapdata[ missionid ][ #"transient" ].var_ba4d1bad[ weapon.name ] );
                    }
                    
                    world.mapdata[ missionid ][ #"transient" ].var_ba4d1bad[ weapon.name ][ world.mapdata[ missionid ][ #"transient" ].var_ba4d1bad[ weapon.name ].size ] = attachment;
                }
            }
        }
    }
}

// Namespace savegame/save
// Params 0
// Checksum 0xf0e94b0f, Offset: 0x1218
// Size: 0x29c
function function_7396472d()
{
    missionid = function_8136eb5a();
    player = getplayers()[ 0 ];
    
    if ( isdefined( world.mapdata[ missionid ][ #"transient" ].var_2e7c022f ) )
    {
        player takeallweapons();
        
        foreach ( weapon_name in world.mapdata[ missionid ][ #"transient" ].var_2e7c022f )
        {
            if ( isdefined( weapon_name ) )
            {
                if ( isdefined( world.mapdata[ missionid ][ #"transient" ].var_ba4d1bad[ weapon_name ] ) )
                {
                    weapon = getweapon( weapon_name, world.mapdata[ missionid ][ #"transient" ].var_ba4d1bad[ weapon_name ] );
                }
                else
                {
                    weapon = getweapon( weapon_name );
                }
                
                if ( isdefined( weapon ) )
                {
                    player giveweapon( weapon );
                }
            }
        }
        
        if ( isdefined( world.mapdata[ missionid ][ #"transient" ].var_37017d9 ) )
        {
            current_weapon = player getcurrentweapon();
            var_fc1c4650 = getweapon( world.mapdata[ missionid ][ #"transient" ].var_37017d9 );
            
            if ( isdefined( current_weapon ) && isdefined( var_fc1c4650 ) && current_weapon != var_fc1c4650 )
            {
                if ( player hasweapon( var_fc1c4650 ) )
                {
                    player switchtoweaponimmediate( var_fc1c4650 );
                }
            }
        }
    }
}

// Namespace savegame/save
// Params 2
// Checksum 0x6e6c9122, Offset: 0x14c0
// Size: 0x7e
function set_player_data( name, value )
{
    campaignmode = "CP";
    
    if ( !isdefined( world.playerdata ) )
    {
        world.playerdata = [];
    }
    
    if ( !isdefined( world.playerdata[ campaignmode ] ) )
    {
        world.playerdata[ campaignmode ] = [];
    }
    
    world.playerdata[ campaignmode ][ name ] = value;
}

// Namespace savegame/save
// Params 2
// Checksum 0xce7a1c92, Offset: 0x1548
// Size: 0x54
function function_2ee66e93( name, defval )
{
    campaignmode = "CP";
    
    if ( isdefined( world.playerdata[ campaignmode ][ name ] ) )
    {
        return world.playerdata[ campaignmode ][ name ];
    }
    
    return defval;
}

// Namespace savegame/save
// Params 0
// Checksum 0xa5c6ef, Offset: 0x15a8
// Size: 0x4c
function function_8d95e71c()
{
    campaignmode = "CP";
    
    if ( isdefined( world.playerdata ) && isdefined( world.playerdata[ campaignmode ] ) )
    {
        world.playerdata[ campaignmode ] = [];
    }
}

// Namespace savegame/save
// Params 0
// Checksum 0x52fbe0ec, Offset: 0x1600
// Size: 0x2e, Type: bool
function function_7642d0c9()
{
    return getdvarint( #"ui_blocksaves", 1 ) == 0;
}

// Namespace savegame/save
// Params 1
// Checksum 0xc06b0ed8, Offset: 0x1638
// Size: 0x7c
function function_7790f03( var_62a2ec8e = 0 )
{
    if ( is_true( level.var_815395f5 ) || getdvarint( #"hash_3a4333abc7abc233", 0 ) )
    {
        return;
    }
    
    level thread function_396464b( var_62a2ec8e );
}

// Namespace savegame/save
// Params 1, eflags: 0x4
// Checksum 0x420a7525, Offset: 0x16c0
// Size: 0xb4
function private function_396464b( var_62a2ec8e = 0 )
{
    level notify( #"checkpoint_save" );
    level endon( #"checkpoint_save", #"save_restore" );
    checkpointcreate();
    waitframe( 1 );
    waitframe( 1 );
    checkpointcommit();
    
    if ( is_true( var_62a2ec8e ) )
    {
        function_3c6da8ff();
    }
}

// Namespace savegame/save
// Params 0
// Checksum 0xe3fa5585, Offset: 0x1780
// Size: 0x3c
function checkpoint_trigger()
{
    self endon( #"death" );
    self waittill( #"trigger" );
    checkpoint_save();
}

// Namespace savegame/save
// Params 1
// Checksum 0xa8fd39a7, Offset: 0x17c8
// Size: 0x34
function checkpoint_save( var_62a2ec8e = 0 )
{
    level thread function_655f1326( var_62a2ec8e );
}

// Namespace savegame/save
// Params 0
// Checksum 0xee44c46e, Offset: 0x1808
// Size: 0x24
function function_3c6da8ff()
{
    level thread function_4baf8f0c( 1.5 );
}

// Namespace savegame/save
// Params 1
// Checksum 0x595b2df5, Offset: 0x1838
// Size: 0x2c4
function function_4baf8f0c( delay )
{
    if ( function_7642d0c9() )
    {
        wait 0.2;
        
        foreach ( player in level.players )
        {
            player player::generate_weapon_data();
            player set_player_data( "saved_weapon", player._generated_current_weapon.rootweapon.name );
            player set_player_data( "saved_weapon_attachments", util::function_2146bd83( player._generated_current_weapon ) );
            player set_player_data( "saved_weapondata", player._generated_weapons );
            player set_player_data( "lives", player.lives );
            player._generated_current_weapon = undefined;
            player._generated_weapons = undefined;
        }
        
        player = util::gethostplayer();
        
        if ( isdefined( player ) )
        {
            player set_player_data( "savegame_score", player.pers[ #"score" ] );
            player set_player_data( "savegame_kills", player.pers[ #"kills" ] );
            player set_player_data( "savegame_assists", player.pers[ #"assists" ] );
            player set_player_data( "savegame_incaps", player.pers[ #"incaps" ] );
            player set_player_data( "savegame_revives", player.pers[ #"revives" ] );
        }
        
        save();
        wait delay;
        
        if ( isdefined( player ) )
        {
            player util::function_502198f3();
        }
    }
}

// Namespace savegame/save
// Params 0
// Checksum 0x27f6b32e, Offset: 0x1b08
// Size: 0x152
function function_68cfab84()
{
    if ( is_true( level.missionfailed ) )
    {
        return 0;
    }
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            return 0;
        }
        
        if ( player clientfield::get( "burn" ) )
        {
            return 0;
        }
        
        if ( player.sessionstate == "spectator" )
        {
            firstspawn = isdefined( self.firstspawn ) ? self.firstspawn : 1;
            return firstspawn;
        }
        
        if ( player oob::isoutofbounds() )
        {
            return 0;
        }
        
        if ( is_true( player.burning ) )
        {
            return 0;
        }
    }
    
    return 1;
}

// Namespace savegame/save
// Params 1, eflags: 0x4
// Checksum 0xd9aa837d, Offset: 0x1c68
// Size: 0x13c
function private function_655f1326( var_62a2ec8e )
{
    level notify( #"hash_7608fe484d0bea80" );
    level endon( #"hash_7608fe484d0bea80", #"kill_save", #"save_restore" );
    wait 0.1;
    
    while ( true )
    {
        if ( function_51c242e9() )
        {
            wait 0.1;
            checkpointcreate();
            wait 6;
            
            for ( check_count = 0; check_count < 5 ; check_count++ )
            {
                if ( function_68cfab84() )
                {
                    break;
                }
                
                wait 1;
            }
            
            if ( check_count == 5 )
            {
                continue;
            }
            
            checkpointcommit();
            function_3c6da8ff();
            
            if ( var_62a2ec8e )
            {
                level thread function_3c6da8ff();
            }
            
            return;
        }
        
        wait 1;
    }
}

// Namespace savegame/save
// Params 2
// Checksum 0x5ac81992, Offset: 0x1db0
// Size: 0x272, Type: bool
function function_51c242e9( var_a8976c31 = 0, stealth_check = 1 )
{
    if ( !var_a8976c31 )
    {
        if ( is_true( level.var_815395f5 ) )
        {
            return false;
        }
        
        if ( getdvarint( #"hash_3a4333abc7abc233", 0 ) )
        {
            return false;
        }
    }
    
    if ( is_true( level.missionfailed ) )
    {
        return false;
    }
    
    var_e46695c4 = 0;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && player function_172f4daa( var_a8976c31 ) )
        {
            var_e46695c4++;
        }
    }
    
    var_a9a7b3a2 = level.players.size;
    
    if ( var_e46695c4 < var_a9a7b3a2 )
    {
        return false;
    }
    
    if ( !function_2ceb3570() )
    {
        return false;
    }
    
    if ( !function_6dadecb9() )
    {
        return false;
    }
    
    if ( isdefined( level.var_a1cfeb5a ) && !var_a8976c31 )
    {
        foreach ( func in level.var_a1cfeb5a )
        {
            if ( !level [[ func ]]() )
            {
                return false;
            }
        }
    }
    
    if ( stealth_check && isdefined( level.var_8bca2033 ) )
    {
        if ( ![[ level.var_8bca2033 ]]() )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace savegame/save
// Params 1, eflags: 0x4
// Checksum 0xe8eaecb6, Offset: 0x2030
// Size: 0x2a2
function private function_172f4daa( var_a8976c31 = 0 )
{
    var_e81ab8f5 = 1;
    
    if ( isdefined( self.health ) && isdefined( self.maxhealth ) && self.maxhealth > 0 )
    {
        var_e81ab8f5 = self.health / self.maxhealth;
    }
    
    if ( var_e81ab8f5 < 0.7 && !var_a8976c31 )
    {
        return 0;
    }
    
    if ( isdefined( self.lastdamagetime ) && self.lastdamagetime > gettime() - 1500 )
    {
        return 0;
    }
    
    if ( self clientfield::get( "burn" ) )
    {
        return 0;
    }
    
    if ( self ismeleeing() )
    {
        return 0;
    }
    
    if ( self isthrowinggrenade() )
    {
        return 0;
    }
    
    if ( self isfiring() )
    {
        return 0;
    }
    
    if ( self util::isflashed() )
    {
        return 0;
    }
    
    if ( self.sessionstate == "spectator" )
    {
        firstspawn = isdefined( self.firstspawn ) ? self.firstspawn : 1;
        return firstspawn;
    }
    
    if ( self oob::isoutofbounds() )
    {
        return 0;
    }
    
    if ( is_true( self.burning ) )
    {
        return 0;
    }
    
    if ( self flag::get( #"mobile_armory_in_use" ) )
    {
        return 0;
    }
    
    if ( var_a8976c31 )
    {
        return 1;
    }
    
    foreach ( weapon in self getweaponslist() )
    {
        fraction = self getfractionmaxammo( weapon );
        
        if ( fraction > 0.1 )
        {
            return 1;
        }
    }
    
    return 0;
}

// Namespace savegame/save
// Params 0, eflags: 0x4
// Checksum 0x763b6589, Offset: 0x22e0
// Size: 0x170, Type: bool
function private function_6dadecb9()
{
    if ( !getdvarint( #"hash_3c20efa8bd1aa30", 1 ) )
    {
        return true;
    }
    
    ais = getaiteamarray( #"axis" );
    
    foreach ( ai in ais )
    {
        if ( !isdefined( ai ) )
        {
            continue;
        }
        
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        if ( isactor( ai ) && ai isinscriptedstate() )
        {
            continue;
        }
        
        if ( is_true( ai.ignoreall ) )
        {
            continue;
        }
        
        playerproximity = ai function_838fa3a9();
        
        if ( playerproximity <= 80 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace savegame/save
// Params 0, eflags: 0x4
// Checksum 0x38a21429, Offset: 0x2458
// Size: 0x130, Type: bool
function private function_6f9ec10b()
{
    if ( !isdefined( self.enemy ) )
    {
        return true;
    }
    
    if ( !isplayer( self.enemy ) )
    {
        return true;
    }
    
    if ( isdefined( self.melee ) && isdefined( self.melee.target ) && isplayer( self.melee.target ) )
    {
        return false;
    }
    
    playerproximity = self function_838fa3a9();
    
    if ( playerproximity < 500 )
    {
        return false;
    }
    else if ( playerproximity > 1000 || playerproximity < 0 )
    {
        return true;
    }
    else if ( isactor( self ) && self cansee( self.enemy ) && self canshootenemy() )
    {
        return false;
    }
    
    return true;
}

// Namespace savegame/save
// Params 0
// Checksum 0xe8623813, Offset: 0x2590
// Size: 0xd6
function function_838fa3a9()
{
    mindist = -1;
    
    foreach ( player in function_a1ef346b() )
    {
        dist = distance( player.origin, self.origin );
        
        if ( dist < mindist || mindist < 0 )
        {
            mindist = dist;
        }
    }
    
    return mindist;
}

// Namespace savegame/save
// Params 0, eflags: 0x4
// Checksum 0x7f40515, Offset: 0x2670
// Size: 0x18c, Type: bool
function private function_2ceb3570()
{
    var_e1a8a025 = 0;
    
    foreach ( grenade in getentarray( "grenade", "classname" ) )
    {
        foreach ( player in function_a1ef346b() )
        {
            distsq = distancesquared( grenade.origin, player.origin );
            
            if ( distsq < 90000 )
            {
                var_e1a8a025++;
            }
        }
    }
    
    if ( var_e1a8a025 > 0 && var_e1a8a025 >= function_a1ef346b().size )
    {
        return false;
    }
    
    return true;
}

