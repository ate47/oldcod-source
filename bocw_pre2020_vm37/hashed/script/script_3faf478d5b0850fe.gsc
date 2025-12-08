#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_9fc66ac;

// Namespace namespace_9fc66ac/namespace_9fc66ac
// Params 0
// Checksum 0x80f724d1, Offset: 0x1e8
// Size: 0x4
function init()
{
    
}

// Namespace namespace_9fc66ac/namespace_9fc66ac
// Params 2
// Checksum 0xa3b1240e, Offset: 0x1f8
// Size: 0x7c
function function_a77649db( *name, onoff )
{
    if ( is_true( onoff ) )
    {
        level.var_7704256 = level.musicstate;
        function_5e3127a5( undefined, "doa_bonusroom" );
        return;
    }
    
    function_5e3127a5( undefined, level.var_7704256 );
}

// Namespace namespace_9fc66ac/namespace_9fc66ac
// Params 0
// Checksum 0xc3928e31, Offset: 0x280
// Size: 0x84
function function_5beeba99()
{
    if ( !isdefined( level.doa.var_39e3fa99 ) )
    {
        return;
    }
    
    name = [[ level.doa.var_39e3fa99 ]]->getname();
    var_8576a4b1 = level.doa.roundnumber;
    function_5e3127a5( #"arena" );
}

// Namespace namespace_9fc66ac/namespace_9fc66ac
// Params 0
// Checksum 0x7a113f53, Offset: 0x310
// Size: 0x62
function function_2fc07d61()
{
    if ( !isdefined( level.doa.var_39e3fa99 ) )
    {
        return;
    }
    
    name = [[ level.doa.var_39e3fa99 ]]->getname();
    var_8576a4b1 = level.doa.roundnumber;
}

// Namespace namespace_9fc66ac/namespace_9fc66ac
// Params 0
// Checksum 0xf9237fb5, Offset: 0x380
// Size: 0xda
function function_65fcd877()
{
    switch ( level.doa.world_state )
    {
        case 0:
            break;
        case 4:
            function_5e3127a5( #"overworld" );
            break;
        case 5:
            function_5e3127a5( #"dungeon" );
            break;
        case 1:
            function_5e3127a5( undefined, "doa_gameover" );
            break;
    }
}

// Namespace namespace_9fc66ac/namespace_9fc66ac
// Params 2
// Checksum 0xf3be75df, Offset: 0x468
// Size: 0x198
function function_5e3127a5( var_75e87d7f, var_6ea1719d = undefined )
{
    if ( !isdefined( level.var_402c5b0e ) )
    {
        level.var_402c5b0e = [];
    }
    
    if ( !isdefined( level.var_402c5b0e[ #"arena" ] ) )
    {
        level.var_402c5b0e[ #"arena" ] = [];
    }
    
    if ( !isdefined( level.var_402c5b0e[ #"overworld" ] ) )
    {
        level.var_402c5b0e[ #"overworld" ] = [];
    }
    
    if ( !isdefined( level.var_402c5b0e[ #"dungeon" ] ) )
    {
        level.var_402c5b0e[ #"dungeon" ] = [];
    }
    
    if ( isdefined( var_6ea1719d ) )
    {
        music::setmusicstate( var_6ea1719d );
        return;
    }
    
    if ( !isdefined( var_75e87d7f ) )
    {
        return;
    }
    
    if ( level.var_402c5b0e[ var_75e87d7f ].size <= 0 )
    {
        function_914016fe( var_75e87d7f );
    }
    
    music::setmusicstate( level.var_402c5b0e[ var_75e87d7f ][ 0 ] );
    level.var_402c5b0e[ var_75e87d7f ] = array::remove_index( level.var_402c5b0e[ var_75e87d7f ], 0 );
}

// Namespace namespace_9fc66ac/namespace_9fc66ac
// Params 1
// Checksum 0xa3462e44, Offset: 0x608
// Size: 0x120
function function_914016fe( var_75e87d7f )
{
    switch ( var_75e87d7f )
    {
        case #"arena":
            min = 0;
            max = 7;
            str_prefix = "arena_0";
            break;
        case #"overworld":
            min = 0;
            max = 2;
            str_prefix = "overworld_0";
            break;
        case #"dungeon":
            min = 0;
            max = 2;
            str_prefix = "dungeon_0";
            break;
    }
    
    for ( i = min; i < max + 1 ; i++ )
    {
        level.var_402c5b0e[ var_75e87d7f ][ i ] = str_prefix + i;
    }
    
    level.var_402c5b0e[ var_75e87d7f ] = array::randomize( level.var_402c5b0e[ var_75e87d7f ] );
}

// Namespace namespace_9fc66ac/namespace_9fc66ac
// Params 5
// Checksum 0x6d0571c5, Offset: 0x738
// Size: 0x36a
function function_c6daa0fc( zombie, type, override, priority, delayambientvox = 0 )
{
    zombie endon( #"death" );
    
    if ( !isdefined( zombie ) )
    {
        return;
    }
    
    if ( is_true( zombie.var_e8920729 ) )
    {
        return;
    }
    
    if ( !isdefined( zombie.voiceprefix ) )
    {
        return;
    }
    
    if ( !isdefined( priority ) )
    {
        priority = 1;
    }
    
    if ( !isdefined( zombie.currentvoxpriority ) )
    {
        zombie.currentvoxpriority = 1;
    }
    
    if ( !isdefined( zombie.talking ) )
    {
        zombie.talking = 0;
    }
    
    if ( !isdefined( self.delayambientvox ) )
    {
        self.delayambientvox = 0;
    }
    
    if ( ( type == "ambient" || type == "sprint" || type == "crawler" ) && is_true( self.delayambientvox ) )
    {
        return;
    }
    
    if ( delayambientvox )
    {
        self.delayambientvox = 1;
        self thread function_60769c6c();
    }
    
    alias = "zmb_vocals_" + zombie.voiceprefix + "_" + type;
    
    if ( sndisnetworksafe() )
    {
        if ( is_true( override ) )
        {
            if ( isdefined( zombie.currentvox ) && priority > zombie.currentvoxpriority )
            {
                zombie stopsound( zombie.currentvox );
                waitframe( 1 );
            }
            
            if ( type == "death" || type == "death_whimsy" || type == "death_nohead" )
            {
                zombie playsound( alias );
                return;
            }
        }
        
        if ( zombie.talking === 1 && ( priority < zombie.currentvoxpriority || priority === 1 ) )
        {
            return;
        }
        
        zombie.talking = 1;
        zombie.currentvox = alias;
        zombie.currentvoxpriority = priority;
        zombie playsoundontag( alias, "j_head" );
        playbacktime = float( max( isdefined( soundgetplaybacktime( alias ) ) ? soundgetplaybacktime( alias ) : 500, 500 ) ) / 1000;
        wait playbacktime;
        zombie.talking = 0;
        zombie.currentvox = undefined;
        zombie.currentvoxpriority = 1;
    }
}

// Namespace namespace_9fc66ac/namespace_9fc66ac
// Params 0
// Checksum 0x6cc849ba, Offset: 0xab0
// Size: 0x5a
function function_60769c6c()
{
    self notify( #"sndambientdelay" );
    self endon( #"sndambientdelay", #"death", #"disconnect" );
    wait 2;
    self.delayambientvox = 0;
}

// Namespace namespace_9fc66ac/namespace_9fc66ac
// Params 0
// Checksum 0xb7a49796, Offset: 0xb18
// Size: 0x50
function networksafereset()
{
    self notify( "5286eae6171e7339" );
    self endon( "5286eae6171e7339" );
    
    while ( true )
    {
        level.doa.var_3d0539c1 = 0;
        util::wait_network_frame();
    }
}

// Namespace namespace_9fc66ac/namespace_9fc66ac
// Params 0
// Checksum 0xba5e6a33, Offset: 0xb70
// Size: 0x6c, Type: bool
function sndisnetworksafe()
{
    if ( !isdefined( level.doa.var_3d0539c1 ) )
    {
        level thread networksafereset();
    }
    
    if ( level.doa.var_3d0539c1 >= 2 )
    {
        return false;
    }
    
    level.doa.var_3d0539c1++;
    return true;
}

// Namespace namespace_9fc66ac/namespace_9fc66ac
// Params 0
// Checksum 0xd54b88aa, Offset: 0xbe8
// Size: 0x170
function play_ambient_zombie_vocals()
{
    self endon( #"death" );
    
    while ( true )
    {
        type = "ambient";
        float = 3;
        
        if ( isdefined( self.zombie_move_speed ) )
        {
            switch ( self.zombie_move_speed )
            {
                case #"walk":
                    type = "ambient";
                    float = 3;
                    break;
                case #"run":
                    type = "sprint";
                    float = 3;
                    break;
                case #"sprint":
                    type = "sprint";
                    float = 3;
                    break;
            }
        }
        
        if ( is_true( self.missinglegs ) )
        {
            float = 2;
            type = "crawler";
        }
        
        bhtnactionstartevent( self, type );
        self notify( #"bhtn_action_notify", { #action:type } );
        wait randomfloatrange( 1, float );
    }
}

