#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ce46999727f2f2b;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_2e9202713de2b353;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_41fbdfb1149a433e;
#using script_47851dbeea22fe66;
#using script_48e04a393ec6d855;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_683a55734f15d50e;
#using script_73ad7687b437e468;
#using script_74a56359b7d02ab6;
#using script_77357b2d180aa2b8;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_491fa2b2;

// Namespace namespace_491fa2b2/namespace_491fa2b2
// Params 0
// Checksum 0x1e5e5ce6, Offset: 0x220
// Size: 0x134
function init()
{
    namespace_41f5b853::init();
    namespace_f63bdb08::init();
    level.doa.var_f4a69294 = [];
    level.doa.var_b8ef1466 = [];
    level.doa.var_c793b1bb = [];
    level.doa.var_f4a69294[ #"green" ] = function_f143eef7();
    level.doa.var_f4a69294[ #"blue" ] = function_f143eef7();
    level.doa.var_f4a69294[ #"red" ] = function_f143eef7();
    level.doa.var_f4a69294[ #"yellow" ] = function_f143eef7();
    main();
}

// Namespace namespace_491fa2b2/namespace_491fa2b2
// Params 0
// Checksum 0xaabff2be, Offset: 0x360
// Size: 0x3a
function main()
{
    function_df55eb9d();
    level.doa.var_b8ef1466 = [];
    level.doa.var_c793b1bb = [];
}

// Namespace namespace_491fa2b2/namespace_491fa2b2
// Params 3
// Checksum 0x141fe443, Offset: 0x3a8
// Size: 0x272
function function_df55eb9d( context = 0, loottype, var_d1b6de15 )
{
    foreach ( item in level.doa.var_b8ef1466 )
    {
        if ( !isdefined( item ) )
        {
            continue;
        }
        
        if ( context != 0 && item.context != context )
        {
            continue;
        }
        
        if ( item === var_d1b6de15 )
        {
            continue;
        }
        
        if ( isdefined( loottype ) )
        {
            if ( !isdefined( item.loottype ) )
            {
                continue;
            }
            
            if ( isdefined( item.loottype ) && item.loottype != loottype )
            {
                continue;
            }
        }
        
        item delete();
    }
    
    arrayremovevalue( level.doa.var_b8ef1466, undefined );
    
    foreach ( item in level.doa.var_c793b1bb )
    {
        if ( isdefined( item ) )
        {
            item delete();
        }
    }
    
    level.doa.var_c793b1bb = [];
    
    foreach ( trigger in level.doa.var_f4a69294 )
    {
    }
}

// Namespace namespace_491fa2b2/namespace_491fa2b2
// Params 0
// Checksum 0x764e173d, Offset: 0x628
// Size: 0x2de
function function_ebbc302()
{
    self notify( "10435409a9620955" );
    self endon( "10435409a9620955" );
    self endon( #"disconnect" );
    assert( isdefined( self.doa ), "<dev string:x38>" );
    var_2158df5f = level.doa.var_f4a69294[ self.doa.color ];
    var_2158df5f setteamfortrigger( self.team );
    self clientclaimtrigger( var_2158df5f );
    var_2158df5f.player = self;
    
    while ( true )
    {
        wait 0.5;
        closest = undefined;
        items = arraysortclosest( level.doa.var_b8ef1466, self.origin, 1 );
        
        if ( items.size )
        {
            closest = items[ 0 ];
        }
        
        if ( isdefined( closest ) )
        {
            if ( closest !== self.doa.var_96175d8a )
            {
                deltaz = abs( self.origin[ 2 ] - closest.origin[ 2 ] );
                
                if ( deltaz > 128 )
                {
                    closest = undefined;
                }
                
                if ( isdefined( closest ) )
                {
                    distsq = distancesquared( self.origin, closest.origin );
                    
                    if ( distsq > sqr( 1024 ) )
                    {
                        closest = undefined;
                    }
                }
            }
        }
        
        if ( isdefined( closest ) )
        {
            if ( closest !== self.doa.var_96175d8a || function_dd626f96( closest ) )
            {
                var_2158df5f function_8328d4bc( closest );
            }
            
            self.doa.var_96175d8a = closest;
            continue;
        }
        
        var_2158df5f.origin = self.origin + ( 0, 0, -30000 );
        var_2158df5f.var_806ce8f = undefined;
        var_2158df5f sethintstring( #"" );
        var_2158df5f triggerenable( 0 );
        self.doa.var_96175d8a = undefined;
    }
}

// Namespace namespace_491fa2b2/namespace_491fa2b2
// Params 0
// Checksum 0xff2ab025, Offset: 0x910
// Size: 0x42
function function_8f5419f1()
{
    var_2158df5f = level.doa.var_f4a69294[ self.doa.color ];
    return self istouching( var_2158df5f );
}

// Namespace namespace_491fa2b2/namespace_491fa2b2
// Params 1
// Checksum 0xb8acc7b7, Offset: 0x960
// Size: 0x42
function function_dd626f96( item )
{
    if ( item.var_d6118311 === 2 )
    {
        return 1;
    }
    
    return is_true( item.locked );
}

// Namespace namespace_491fa2b2/namespace_491fa2b2
// Params 1
// Checksum 0x19141fa9, Offset: 0x9b0
// Size: 0x6fc
function function_8328d4bc( item )
{
    if ( !isdefined( item ) )
    {
        return;
    }
    
    self.origin = item.origin + ( 0, 0, 24 );
    
    if ( isdefined( item.trigger_offset ) )
    {
        self.origin += item.trigger_offset;
    }
    
    if ( !isdefined( item.var_cbff4088 ) )
    {
        item.var_cbff4088 = 0;
    }
    
    if ( item.var_cbff4088 == -1 )
    {
        item.var_cbff4088 = getplayers().size;
    }
    
    if ( !isdefined( item.var_950bcf12 ) )
    {
        item.var_950bcf12 = item.var_cbff4088;
    }
    
    self.var_806ce8f = item;
    self sethintstring( #"hash_bf1faaf9f4ab783" );
    
    switch ( item.var_d6118311 )
    {
        case 4:
            fate = item.data;
            
            if ( self.player namespace_1c2a96f9::function_afe89b8c( fate.var_c8386627 ) )
            {
                self sethintstring( #"hash_35d21b3088f19ee7" );
            }
            else
            {
                self sethintstring( #"hash_26f6da6f6ca5dfa4" );
            }
            
            break;
        case 1:
            self sethintstring( #"hash_226d9049ece37c17" );
            break;
        case 2:
            if ( isdefined( item.var_fc5f2aa0 ) && isdefined( item.var_fc5f2aa0.var_115ea089 ) && isdefined( item.var_fc5f2aa0.hintstring ) )
            {
                ent = getent( item.var_fc5f2aa0.var_115ea089, "script_noteworthy" );
                
                if ( !isdefined( ent ) )
                {
                    item.var_fc5f2aa0.hintstring = item.var_fc5f2aa0.var_e8dff5e5;
                    item.var_d6118311 = 1;
                }
            }
            
            if ( isdefined( item.var_fc5f2aa0 ) && isdefined( item.var_fc5f2aa0.hintstring ) )
            {
                self sethintstring( item.var_fc5f2aa0.hintstring );
            }
            else if ( self.player.doa.score.keys == 0 )
            {
                self sethintstring( #"hash_5c2a90001a3be8b5" );
            }
            else
            {
                self sethintstring( #"hash_156739736ad89c28" );
            }
            
            break;
        case 5:
        case 7:
            if ( is_true( item.locked ) )
            {
                if ( self.player.doa.score.keys == 0 )
                {
                    self sethintstring( #"hash_2f8c4610353b9754" );
                }
                else
                {
                    self sethintstring( #"hash_692637e6361aa6fd" );
                }
            }
            else
            {
                self sethintstring( #"hash_7c3502418402b5ea" );
            }
            
            break;
        case 6:
            if ( is_true( item.locked ) )
            {
                if ( self.player.doa.score.keys == 0 )
                {
                    self sethintstring( #"hash_39ebdbb0226b329f" );
                }
                else if ( item.var_cbff4088 > 1 && item.var_cbff4088 != item.var_950bcf12 )
                {
                    self sethintstring( #"hash_7b23848ec07aad08" );
                }
                else
                {
                    self sethintstring( #"hash_54b6fea6bd91db7c" );
                }
            }
            else
            {
                self sethintstring( #"hash_20c1284622784d1d" );
            }
            
            break;
        case 3:
            if ( is_true( item.locked ) )
            {
                if ( self.player.doa.score.keys == 0 )
                {
                    self sethintstring( #"hash_ce3afacfc4ce084" );
                }
                else
                {
                    self sethintstring( #"hash_d0088d8ea0c0b0d" );
                }
            }
            else
            {
                switch ( item.loottype )
                {
                    case 1:
                    case 2:
                    case 3:
                    case 4:
                        self sethintstring( #"hash_7dbf76733550293a" );
                        break;
                    case 6:
                        self sethintstring( #"hash_4bfbefc2b26dbccf" );
                        break;
                    default:
                        self sethintstring( #"hash_49306fb46908df39" );
                        break;
                }
            }
            
            break;
    }
    
    self triggerenable( 1 );
}

// Namespace namespace_491fa2b2/namespace_491fa2b2
// Params 0
// Checksum 0x886e690, Offset: 0x10b8
// Size: 0x80
function function_f143eef7()
{
    usetrigger = namespace_ec06fe4a::spawntrigger( "trigger_radius_use", ( 0, 0, 0 ), 0, 96, 96 );
    
    if ( isdefined( usetrigger ) )
    {
        usetrigger setcursorhint( "HINT_NOICON" );
        usetrigger callback::on_trigger( &onusecallback );
    }
    
    return usetrigger;
}

// Namespace namespace_491fa2b2/namespace_491fa2b2
// Params 1
// Checksum 0x7ad3ea57, Offset: 0x1140
// Size: 0x510
function onusecallback( trigger_struct )
{
    player = trigger_struct.activator;
    targ = self.var_806ce8f;
    
    if ( !isdefined( targ ) )
    {
        return;
    }
    
    if ( is_true( targ.activated ) )
    {
        return;
    }
    
    player.doa.var_af53a5b7 = 1;
    
    if ( isdefined( targ ) )
    {
        switch ( targ.var_d6118311 )
        {
            case 2:
                if ( isdefined( targ.var_fc5f2aa0 ) )
                {
                    if ( isdefined( targ.var_fc5f2aa0.var_115ea089 ) )
                    {
                        ent = getent( targ.var_fc5f2aa0.var_115ea089, "script_noteworthy" );
                        
                        if ( isdefined( ent ) )
                        {
                            return;
                        }
                        
                        targ.var_fc5f2aa0.completed = 1;
                        targ.var_d6118311 = 1;
                    }
                }
                else
                {
                    player playrumbleonentity( "door_kick" );
                    
                    if ( player.doa.score.keys == 0 )
                    {
                        targ namespace_e32bb68::function_3a59ec34( "door_locked" );
                        return;
                    }
                    else
                    {
                        player namespace_eccff4fb::function_849a9028();
                        player namespace_e32bb68::function_3a59ec34( "evt_doa_pickup_key_unlock" );
                        targ namespace_e32bb68::function_3a59ec34( "door_unlocked" );
                        targ.var_d6118311 = 1;
                    }
                }
            case 1:
                level thread namespace_f63bdb08::function_49957ef3( targ );
                break;
            case 4:
                fate = targ.data;
                
                if ( self.player namespace_1c2a96f9::function_afe89b8c( fate.var_c8386627 ) )
                {
                    targ namespace_e32bb68::function_3a59ec34( "fate_denied" );
                    return;
                }
                
                level thread namespace_1c2a96f9::function_42b0778( targ, player );
                break;
            case 3:
            case 5:
            case 6:
            case 7:
                if ( is_true( targ.locked ) )
                {
                    player playrumbleonentity( "door_kick" );
                    
                    if ( player.doa.score.keys == 0 )
                    {
                        targ namespace_e32bb68::function_3a59ec34( "item_locked" );
                        return;
                    }
                    
                    player namespace_eccff4fb::function_849a9028();
                    player namespace_e32bb68::function_3a59ec34( "evt_doa_pickup_key_unlock" );
                    
                    if ( !isdefined( targ.var_cbff4088 ) )
                    {
                        targ.var_cbff4088 = 1;
                    }
                    
                    assert( targ.var_cbff4088 > 0 );
                    targ.var_cbff4088--;
                    
                    if ( targ.var_cbff4088 > 0 )
                    {
                        targ namespace_e32bb68::function_3a59ec34( "item_locked" );
                        targ namespace_83eb6304::function_3ecfde67( "wild_portal_radial_burst" );
                        targ = undefined;
                        break;
                    }
                    
                    targ namespace_e32bb68::function_3a59ec34( "item_unlocked" );
                    targ.locked = 0;
                }
                
                level thread namespace_41f5b853::function_4d27013d( targ );
                break;
        }
    }
    
    if ( isdefined( targ ) )
    {
        if ( isdefined( targ.owner ) )
        {
            targ.owner.activated = 1;
        }
        
        targ.activated = 1;
        arrayremovevalue( level.doa.var_b8ef1466, targ );
        level.doa.var_c793b1bb[ level.doa.var_c793b1bb.size ] = targ;
    }
}

