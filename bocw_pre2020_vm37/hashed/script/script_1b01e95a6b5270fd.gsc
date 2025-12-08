#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_3faf478d5b0850fe;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using script_774302f762d76254;
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

#namespace doa_enemy;

// Namespace doa_enemy
// Method(s) 15 Total 15
class class_3593c7e6
{

    var m_name;
    var var_24544f42;
    var var_89dfe89b;
    var var_9d95490b;
    var var_c0503cf7;
    var var_c23bfa1e;
    var var_edee94ca;
    var var_fde25292;

    // Namespace class_3593c7e6/doa_enemy
    // Params 0, eflags: 0x8
    // Checksum 0xdaef4be9, Offset: 0x2c0
    // Size: 0x42
    constructor()
    {
        m_name = "";
        var_edee94ca = undefined;
        var_9d95490b = [];
        var_24544f42 = 100;
        var_c23bfa1e = undefined;
    }

    // Namespace namespace_3593c7e6/doa_enemy
    // Params 0
    // Checksum 0x9e3968d3, Offset: 0x3d0
    // Size: 0xa
    function function_10c2bd8()
    {
        return var_c0503cf7;
    }

    // Namespace namespace_3593c7e6/doa_enemy
    // Params 0
    // Checksum 0xb18f2dcc, Offset: 0x3e8
    // Size: 0xa
    function function_744739a()
    {
        return var_89dfe89b;
    }

    // Namespace namespace_3593c7e6/doa_enemy
    // Params 0
    // Checksum 0xed0a280b, Offset: 0x468
    // Size: 0xa
    function function_17454656()
    {
        return var_24544f42;
    }

    // Namespace namespace_3593c7e6/doa_enemy
    // Params 0
    // Checksum 0x7b7dee52, Offset: 0x3b8
    // Size: 0xa
    function getspawner()
    {
        return var_edee94ca;
    }

    // Namespace namespace_3593c7e6/doa_enemy
    // Params 0
    // Checksum 0x150cf57b, Offset: 0x3a0
    // Size: 0xa
    function getname()
    {
        return m_name;
    }

    // Namespace namespace_3593c7e6/doa_enemy
    // Params 1
    // Checksum 0x580ca919, Offset: 0x418
    // Size: 0x1a
    function function_3262a6e9( var_c940cca )
    {
        var_fde25292 = var_c940cca;
    }

    // Namespace namespace_3593c7e6/doa_enemy
    // Params 1
    // Checksum 0xda05d333, Offset: 0x500
    // Size: 0x24
    function function_36573e6c( name )
    {
        var_9d95490b[ var_9d95490b.size ] = name;
    }

    // Namespace namespace_3593c7e6/doa_enemy
    // Params 0
    // Checksum 0xa39857c5, Offset: 0x400
    // Size: 0xa
    function function_4a15d1dd()
    {
        return var_fde25292;
    }

    // Namespace namespace_3593c7e6/doa_enemy
    // Params 1
    // Checksum 0x99c20535, Offset: 0x440
    // Size: 0x1a
    function function_7edd7727( val )
    {
        var_24544f42 = val;
    }

    // Namespace namespace_3593c7e6/doa_enemy
    // Params 1
    // Checksum 0x2bc26786, Offset: 0x4b8
    // Size: 0x3c, Type: bool
    function function_7f3e577e( range = 100 )
    {
        return randomint( range ) < var_24544f42;
    }

    // Namespace namespace_3593c7e6/doa_enemy
    // Params 5
    // Checksum 0x9de46a58, Offset: 0x320
    // Size: 0x76
    function init( spawner, name, init_func, think_func, var_af7a3d7c )
    {
        m_name = name;
        var_edee94ca = spawner;
        var_c0503cf7 = init_func;
        var_89dfe89b = think_func;
        var_c23bfa1e = var_af7a3d7c;
        var_fde25292 = undefined;
    }

    // Namespace namespace_3593c7e6/doa_enemy
    // Params 1
    // Checksum 0xbbaff0c8, Offset: 0x530
    // Size: 0x22
    function function_baae6c9d( name )
    {
        return isinarray( var_9d95490b, name );
    }

    // Namespace namespace_3593c7e6/doa_enemy
    // Params 0
    // Checksum 0x1d7dbadb, Offset: 0x480
    // Size: 0x2a
    function canspawn()
    {
        if ( isdefined( var_c23bfa1e ) )
        {
            return [[ var_c23bfa1e ]]();
        }
        
        return 1;
    }

}

// Namespace doa_enemy/doa_enemy
// Params 0
// Checksum 0xdbd2022d, Offset: 0x858
// Size: 0x288
function init()
{
    namespace_250e9486::init();
    level.doa.var_adb2d4b9 = [];
    spawners = getspawnerarray( "doa_enemy", "targetname" );
    
    foreach ( spawner in spawners )
    {
        var_d240d5de = undefined;
        var_41157a40 = undefined;
        var_c8ceaddf = undefined;
        spawnchance = 100;
        result = level namespace_250e9486::function_2c6dd74c( spawner );
        
        if ( isdefined( result ) )
        {
            var_d240d5de = result.var_d240d5de;
            var_41157a40 = result.var_41157a40;
            var_c8ceaddf = result.var_c8ceaddf;
            spawnchance = result.spawnchance;
        }
        
        var_7a8f2a62 = function_eff7e0fb( spawner, spawner.script_noteworthy, var_d240d5de, var_41157a40, var_c8ceaddf );
        [[ var_7a8f2a62 ]]->function_7edd7727( spawnchance );
        
        if ( isdefined( result ) )
        {
            foreach ( arena in result.var_71e54e3a )
            {
                [[ var_7a8f2a62 ]]->function_36573e6c( arena );
            }
        }
        
        var_663588d = "Zombietron/AI/";
        cmdline = "scr_spawn_enemy " + [[ var_7a8f2a62 ]]->getname() + "; zombie_devgui enemy";
        util::add_devgui( var_663588d + [[ var_7a8f2a62 ]]->getname(), cmdline );
    }
}

// Namespace doa_enemy/doa_enemy
// Params 0
// Checksum 0xa08efd92, Offset: 0xae8
// Size: 0xc4
function function_2f73ff73()
{
    level.doa.var_dcbded2 = [];
    level.doa.var_af6d47dd = [];
    level.doa.var_e2e8967b = [];
    level.doa.var_329c97a3 = [];
    level.doa.var_13e8f9c9 = undefined;
    level.doa.var_f4cf4e3 = 20;
    level.doa.zombie_health = 1000;
    level.doa.var_2ad97fac = 0;
    function_83d593c5( level.doa.var_65a70dc );
}

// Namespace doa_enemy/doa_enemy
// Params 0
// Checksum 0x7ad5017e, Offset: 0xbb8
// Size: 0x2c
function main()
{
    function_2f73ff73();
    level thread function_7292bc();
}

// Namespace doa_enemy/doa_enemy
// Params 0
// Checksum 0xe917251c, Offset: 0xbf0
// Size: 0x8a
function function_c617d577()
{
    level endon( #"game_over" );
    self notify( "7b6c5e5523abdba5" );
    self endon( "7b6c5e5523abdba5" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start", #"round_over", #"doa_exit_taken" );
        level.doa.var_2ad97fac = 0;
    }
}

// Namespace doa_enemy/doa_enemy
// Params 0
// Checksum 0xb7e81704, Offset: 0xc88
// Size: 0x12e
function function_7495bd30()
{
    self notify( "53708fa6cd025270" );
    self endon( "53708fa6cd025270" );
    level endon( #"game_over" );
    level thread function_c617d577();
    level.doa.var_2ad97fac = 0;
    
    while ( true )
    {
        result = level waittilltimeout( 1, #"hash_7ca039481b460ed2" );
        
        if ( result._notify === "timeout" )
        {
            if ( level.doa.var_2ad97fac < 30 )
            {
                level.doa.var_2ad97fac++;
            }
            
            continue;
        }
        
        level.doa.var_2ad97fac -= 8;
        
        if ( level.doa.var_2ad97fac < 0 )
        {
            level.doa.var_2ad97fac = 0;
        }
    }
}

// Namespace doa_enemy/doa_enemy
// Params 0
// Checksum 0x935aa6d6, Offset: 0xdc0
// Size: 0x38, Type: bool
function function_e7e91016()
{
    if ( flag::get( "doa_round_spawning" ) )
    {
        return ( level.doa.var_2ad97fac == 30 );
    }
    
    return false;
}

// Namespace doa_enemy/doa_enemy
// Params 1
// Checksum 0xd5c054f2, Offset: 0xe00
// Size: 0x60
function function_83d593c5( var_7a8f2a62 )
{
    if ( !isinarray( level.doa.var_329c97a3, var_7a8f2a62 ) )
    {
        level.doa.var_329c97a3[ level.doa.var_329c97a3.size ] = var_7a8f2a62;
    }
}

// Namespace doa_enemy/doa_enemy
// Params 1
// Checksum 0x7128ec81, Offset: 0xe68
// Size: 0x50
function function_251ee3bd( name )
{
    def = function_d7c5adee( name );
    
    if ( isdefined( def ) )
    {
        function_83d593c5( def );
    }
    
    return def;
}

// Namespace doa_enemy/doa_enemy
// Params 5
// Checksum 0x141ad8fd, Offset: 0xec0
// Size: 0x11c
function function_eff7e0fb( spawner, name, init, think, canspawn )
{
    var_7a8f2a62 = new class_3593c7e6();
    [[ var_7a8f2a62 ]]->init( spawner, name, init, think, canspawn );
    
    if ( name == "basic_zombie" )
    {
        [[ var_7a8f2a62 ]]->function_3262a6e9( &function_8a080c79 );
        level.doa.var_65a70dc = var_7a8f2a62;
    }
    
    if ( name == "crawler_zombie" )
    {
        [[ var_7a8f2a62 ]]->function_3262a6e9( &killme );
    }
    
    if ( isdefined( [[ var_7a8f2a62 ]]->getspawner() ) )
    {
        level.doa.var_adb2d4b9[ level.doa.var_adb2d4b9.size ] = var_7a8f2a62;
    }
    
    return var_7a8f2a62;
}

// Namespace doa_enemy/doa_enemy
// Params 0
// Checksum 0x1614ae07, Offset: 0xfe8
// Size: 0x54
function function_c89f6305()
{
    if ( namespace_4dae815d::function_59a9cf1d() == 0 )
    {
        namespace_1e25ad94::debugmsg( "AI terminationg due to moveFailure at:" + self.origin + " AI Type: " + self.zombie_type, 1 );
    }
}

// Namespace doa_enemy/doa_enemy
// Params 0
// Checksum 0x1aa92c12, Offset: 0x1048
// Size: 0x3c
function function_8a080c79()
{
    self thread namespace_ec06fe4a::function_570729f0( 0.5 );
    self namespace_ed80aead::function_586ef822();
}

// Namespace doa_enemy/doa_enemy
// Params 0
// Checksum 0x47d520f2, Offset: 0x1090
// Size: 0x24
function killme()
{
    self thread namespace_ec06fe4a::function_570729f0( 0.1 );
}

// Namespace doa_enemy/doa_enemy
// Params 1
// Checksum 0x3df1a99e, Offset: 0x10c0
// Size: 0xa2
function function_d7c5adee( name )
{
    foreach ( def in level.doa.var_adb2d4b9 )
    {
        if ( [[ def ]]->getname() === name )
        {
            return def;
        }
    }
}

// Namespace doa_enemy/doa_enemy
// Params 1
// Checksum 0xe26b072e, Offset: 0x1170
// Size: 0x126
function function_924423d( ent )
{
    items = [];
    newqueue = [];
    
    foreach ( item in level.doa.var_dcbded2 )
    {
        if ( item.notifyent === ent )
        {
            items[ items.size ] = ent;
            continue;
        }
        
        if ( !isdefined( newqueue ) )
        {
            newqueue = [];
        }
        else if ( !isarray( newqueue ) )
        {
            newqueue = array( newqueue );
        }
        
        newqueue[ newqueue.size ] = item;
    }
    
    level.doa.var_dcbded2 = newqueue;
    return items;
}

// Namespace doa_enemy/doa_enemy
// Params 1
// Checksum 0x8a50da2e, Offset: 0x12a0
// Size: 0x10a
function function_f7086924( var_64a23077 )
{
    newqueue = [];
    
    foreach ( item in level.doa.var_dcbded2 )
    {
        if ( item.var_64a23077 === var_64a23077 )
        {
            continue;
        }
        
        if ( !isdefined( newqueue ) )
        {
            newqueue = [];
        }
        else if ( !isarray( newqueue ) )
        {
            newqueue = array( newqueue );
        }
        
        newqueue[ newqueue.size ] = item;
    }
    
    level.doa.var_dcbded2 = newqueue;
}

// Namespace doa_enemy/doa_enemy
// Params 10
// Checksum 0x953cccde, Offset: 0x13b8
// Size: 0x1c4
function function_a6b807ea( spawndef, count = 10, targetpoint, radius = 0, generator, enemy, var_294cccb7, arena, groupid, var_1be0f060 = 0 )
{
    if ( !isdefined( spawndef ) )
    {
        return;
    }
    
    if ( isdefined( generator ) )
    {
        if ( level.doa.var_dcbded2.size > 256 )
        {
            return;
        }
    }
    
    queueitem = spawnstruct();
    queueitem.spawndef = spawndef;
    queueitem.targetpoint = targetpoint;
    queueitem.radius = radius;
    queueitem.count = count;
    queueitem.enemy = enemy;
    queueitem.notifyent = var_294cccb7;
    queueitem.arena = arena;
    queueitem.groupid = groupid;
    queueitem.var_64a23077 = isdefined( generator ) ? [[ generator ]]->getmodel() : undefined;
    
    if ( isdefined( generator ) )
    {
        queueitem.var_d55f22cb = 1;
    }
    
    if ( !var_1be0f060 )
    {
        level.doa.var_dcbded2[ level.doa.var_dcbded2.size ] = queueitem;
        return;
    }
    
    arrayinsert( level.doa.var_dcbded2, queueitem, 0 );
}

// Namespace doa_enemy/doa_enemy
// Params 0
// Checksum 0x63f420db, Offset: 0x1588
// Size: 0x794
function function_7292bc()
{
    self notify( "cff96472e53f0fa" );
    self endon( "cff96472e53f0fa" );
    level endon( #"game_over" );
    var_1fb31dea = gettime() + 2000;
    
    while ( true )
    {
        if ( namespace_4dae815d::function_59a9cf1d() != 0 && gettime() > var_1fb31dea )
        {
            removequeue = [];
            
            foreach ( queueitem in level.doa.var_dcbded2 )
            {
                if ( is_true( queueitem.var_d55f22cb ) && !isdefined( queueitem.var_64a23077 ) )
                {
                    removequeue[ removequeue.size ] = queueitem;
                }
            }
            
            foreach ( removeitem in removequeue )
            {
                arrayremovevalue( level.doa.var_dcbded2, removeitem );
            }
            
            removequeue = [];
            var_1fb31dea = gettime() + 1000 + randomint( 1500 );
        }
        
        if ( level.doa.var_dcbded2.size > 0 && namespace_250e9486::function_60f6a9e() )
        {
            spawner::global_spawn_throttle();
            
            while ( level.doa.var_dcbded2.size )
            {
                queueitem = level.doa.var_dcbded2[ 0 ];
                
                if ( queueitem.count <= 0 )
                {
                    queueitem = undefined;
                    arrayremoveindex( level.doa.var_dcbded2, 0 );
                    continue;
                }
                
                break;
            }
            
            if ( !isdefined( queueitem ) )
            {
                waitframe( 1 );
                continue;
            }
            
            if ( isdefined( queueitem.groupid ) )
            {
                groupid = queueitem.groupid;
                sizeneeded = 0;
                idx = 0;
                
                while ( true )
                {
                    if ( level.doa.var_dcbded2.size > idx && level.doa.var_dcbded2[ idx ].groupid === groupid )
                    {
                        sizeneeded += level.doa.var_dcbded2[ idx ].count;
                        level.doa.var_dcbded2[ idx ].groupid = undefined;
                        idx++;
                        continue;
                    }
                    
                    break;
                }
                
                for ( var_44f97d52 = 10; var_44f97d52 ; var_44f97d52-- )
                {
                    var_68a09a83 = namespace_250e9486::function_17d3b57();
                    
                    if ( var_68a09a83 >= sizeneeded )
                    {
                        break;
                    }
                    
                    wait 1;
                }
            }
            
            if ( queueitem.radius > 0 )
            {
                var_190085e3 = namespace_ec06fe4a::function_65ee50ba( queueitem.targetpoint + ( randomintrange( queueitem.radius * -1, queueitem.radius ), randomintrange( queueitem.radius * -1, queueitem.radius ), 0 ) );
            }
            else
            {
                var_190085e3 = namespace_ec06fe4a::function_65ee50ba( queueitem.targetpoint );
            }
            
            ai = function_db55a448( queueitem.spawndef, var_190085e3, queueitem.enemy );
            
            if ( isdefined( ai ) )
            {
                level.doa.var_9fcf26ea++;
                queueitem.count--;
                namespace_1e25ad94::debugmsg( "Type " + [[ queueitem.spawndef ]]->getname() + " spawning; queueItem count left: " + queueitem.count );
                ai.arena = queueitem.arena;
                
                if ( isdefined( queueitem.var_64a23077 ) && isdefined( queueitem.var_64a23077.generator ) )
                {
                    [[ queueitem.var_64a23077.generator ]]->function_bcd1aaf5( ai );
                    center = [[ queueitem.var_64a23077.generator ]]->getcenter();
                    radius = [[ queueitem.var_64a23077.generator ]]->getradius();
                    ai.var_c8b974fe = center;
                    ai.var_f506c5cd = radius;
                    ai.var_32d07c96 = sqr( radius ) + ( sqr( radius ) >> 2 );
                    ai.var_5603780 = [[ queueitem.spawndef ]]->function_4a15d1dd();
                    ai.var_d55f22cb = 1;
                    queueitem.var_64a23077 = undefined;
                }
                
                if ( isdefined( queueitem.notifyent ) )
                {
                    namespace_1e25ad94::debugmsg( "ai_queue_spawned notify sending for ent:" + ai getentitynumber() + " at: " + gettime() );
                    queueitem.notifyent notify( #"hash_4c72e79bdad8315e", { #ai:ai, #time:gettime() } );
                }
            }
            
            /#
                if ( isdefined( ai ) )
                {
                    namespace_1e25ad94::debugmsg( "<dev string:x38>" + ai getentitynumber() + "<dev string:x47>" + [[ queueitem.spawndef ]]->getname() + "<dev string:x5d>" + ai.origin );
                }
                else
                {
                    namespace_1e25ad94::debugmsg( "<dev string:x6d>" + [[ queueitem.spawndef ]]->getname() );
                }
            #/
            
            continue;
        }
        
        wait 0.25;
    }
}

// Namespace doa_enemy/doa_enemy
// Params 3
// Checksum 0x7bb5ef36, Offset: 0x1d28
// Size: 0x250
function function_db55a448( spawndef, var_190085e3, enemy )
{
    ai = [[ spawndef ]]->getspawner() spawner::spawn( 1, undefined, var_190085e3 );
    
    if ( isdefined( ai ) )
    {
        ai ghost();
        
        if ( isdefined( enemy ) )
        {
            ai.favoriteenemy = enemy;
            ai setentitytarget( enemy );
        }
        
        ai.spawndef = spawndef;
        var_d240d5de = [[ spawndef ]]->function_10c2bd8();
        
        if ( !isdefined( var_d240d5de ) )
        {
            var_d240d5de = &namespace_250e9486::function_25b2c8a9;
        }
        
        ai [[ var_d240d5de ]]();
        
        if ( isdefined( ai.spawnloc ) )
        {
            if ( isactor( ai ) )
            {
                ai forceteleport( ai.spawnloc.origin, ai.spawnloc.angles );
            }
            else if ( isvehicle( ai ) )
            {
                ai.origin = ai.spawnloc.origin;
                ai.angles = ai.spawnloc.angles;
            }
        }
        else if ( isactor( ai ) )
        {
            ai forceteleport( var_190085e3 );
        }
        else if ( isvehicle( ai ) )
        {
            ai.origin = var_190085e3;
        }
        
        var_41157a40 = [[ spawndef ]]->function_744739a();
        
        if ( !isdefined( var_41157a40 ) )
        {
            var_41157a40 = &namespace_250e9486::function_8971bbb7;
        }
        
        ai thread [[ var_41157a40 ]]();
        ai thread function_b56f90d7( ai.showdelay );
    }
    
    return ai;
}

// Namespace doa_enemy/doa_enemy
// Params 1
// Checksum 0x7b0905f5, Offset: 0x1f80
// Size: 0x7c
function function_b56f90d7( delay = 0.1 )
{
    self endon( #"hash_5251ab0953e7989f" );
    self endon( #"death" );
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    self show();
    self solid();
}

// Namespace doa_enemy/doa_enemy
// Params 0
// Checksum 0x6c260bdc, Offset: 0x2008
// Size: 0x14a
function function_4b2f19cb()
{
    if ( !isdefined( self.var_f506c5cd ) )
    {
        return undefined;
    }
    
    range = randomfloatrange( 0.65, 0.98 );
    distance = self.var_f506c5cd * range;
    angle = randomint( 360 );
    vec = ( distance, 0, 0 );
    rotated = namespace_ec06fe4a::rotatevec( vec, angle );
    groundpos = groundtrace( self.var_c8b974fe + rotated + ( 0, 0, 1024 ) + ( 0, 0, 8 ), self.var_c8b974fe + rotated + ( 0, 0, 1024 ) + ( 0, 0, -100000 ), 0, self )[ #"position" ];
    return getclosestpointonnavmesh( groundpos, 10000 );
}

// Namespace doa_enemy/bhtn_action_start
// Params 1, eflags: 0x40
// Checksum 0x2d9fe8fc, Offset: 0x2160
// Size: 0x242
function event_handler[bhtn_action_start] function_704f0079( eventstruct )
{
    if ( isdefined( self.var_b467f3a1 ) )
    {
        self thread [[ self.var_b467f3a1 ]]( eventstruct );
        return;
    }
    
    notify_string = eventstruct.action;
    
    switch ( notify_string )
    {
        case #"death":
            level thread namespace_9fc66ac::function_c6daa0fc( self, notify_string, 1, 4 );
            break;
        case #"pain":
            level thread namespace_9fc66ac::function_c6daa0fc( self, notify_string, 1, 3 );
            break;
        case #"behind":
            level thread namespace_9fc66ac::function_c6daa0fc( self, notify_string, 1, 3 );
            break;
        case #"attack_melee_notetrack":
            level thread namespace_9fc66ac::function_c6daa0fc( self, "attack_melee", 1, 2, 1 );
            break;
        case #"chase_state_start":
            level thread namespace_9fc66ac::function_c6daa0fc( self, "sprint", 1, 2 );
            break;
        case #"sprint":
        case #"ambient":
        case #"crawler":
        case #"teardown":
        case #"taunt":
            level thread namespace_9fc66ac::function_c6daa0fc( self, notify_string, 0, 1 );
            break;
        case #"attack_melee":
            break;
        default:
            level thread namespace_9fc66ac::function_c6daa0fc( self, notify_string, 0, 2 );
            break;
    }
}

