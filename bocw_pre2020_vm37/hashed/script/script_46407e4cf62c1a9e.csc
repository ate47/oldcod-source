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

#namespace namespace_61150688;

// Namespace namespace_61150688/level_preinit
// Params 1, eflags: 0x40
// Checksum 0x88bd4df0, Offset: 0x118
// Size: 0x6c
function event_handler[level_preinit] function_b489bb7b( *eventstruct )
{
    snd::function_d4ec748e( &function_f2a2832d );
    snd::function_ce78b33b( &function_32ab045 );
    snd::function_5e69f468( &_objective );
}

// Namespace namespace_61150688/event_cc819519
// Params 1, eflags: 0x40
// Checksum 0x617a2433, Offset: 0x190
// Size: 0x60
function event_handler[event_cc819519] function_686b88aa( *eventstruct )
{
    level.var_936dc3f3 = 0;
    snd::wait_init();
    snd::waitforplayers();
    level.player = snd::getplayerssafe()[ 0 ];
}

// Namespace namespace_61150688/namespace_fdf485e5
// Params 2, eflags: 0x4
// Checksum 0x7832edb6, Offset: 0x1f8
// Size: 0xca
function private function_32ab045( ent, name )
{
    switch ( name )
    {
        case #"woods":
            level.woods = ent;
            ent waittill( #"death" );
            level.woods = undefined;
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x38>" + snd::function_783b69( name, "<dev string:x5d>" ) );
            #/
            
            break;
    }
}

// Namespace namespace_61150688/namespace_fdf485e5
// Params 2, eflags: 0x4
// Checksum 0x41c6b087, Offset: 0x2d0
// Size: 0xda
function private function_f2a2832d( *player, msg )
{
    switch ( msg )
    {
        case #"intro_mockup":
            thread intro_mockup();
            break;
        case #"intro_trans_out":
            level notify( #"intro_trans_out" );
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x62>" + snd::function_783b69( msg, "<dev string:x5d>" ) );
            #/
            
            break;
    }
}

// Namespace namespace_61150688/namespace_fdf485e5
// Params 1, eflags: 0x4
// Checksum 0xc7bc7b1d, Offset: 0x3b8
// Size: 0x9a
function private _objective( objective )
{
    switch ( objective )
    {
        case #"hash_65e6eae762f128ac":
            break;
        case #"no_game":
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x80>" + objective + "<dev string:x5d>" );
            #/
            
            break;
    }
}

// Namespace namespace_61150688/namespace_fdf485e5
// Params 2
// Checksum 0x383a18e7, Offset: 0x460
// Size: 0xfe
function function_23179f8( array, v )
{
    if ( !isdefined( v ) )
    {
        /#
            if ( snd::function_d78e3644() == 1 )
            {
                snd::function_3ba3cecb( "<dev string:xa3>" );
            }
        #/
        
        return;
    }
    
    isarr = isarray( array );
    
    if ( !isarr )
    {
        if ( isdefined( array ) )
        {
            array = array( array, v );
        }
        else
        {
            array = array( v );
        }
    }
    else if ( isarr )
    {
        isinarr = isinarray( array, v );
        
        if ( !isinarr )
        {
            array[ array.size ] = v;
        }
    }
    
    return array;
}

// Namespace namespace_61150688/namespace_fdf485e5
// Params 2
// Checksum 0x3d795a63, Offset: 0x568
// Size: 0x98
function function_661522c2( array, v )
{
    isarr = isarray( array );
    
    if ( !isarr )
    {
        array = undefined;
    }
    else if ( isarr )
    {
        isinarr = isinarray( array, v );
        
        if ( isinarr )
        {
            arrayremovevalue( array, v );
        }
    }
    
    return array;
}

// Namespace namespace_61150688/namespace_fdf485e5
// Params 0
// Checksum 0x578087f3, Offset: 0x608
// Size: 0x14c
function intro_mockup()
{
    var_963d1b69 = 26;
    var_5bc91147 = snd::play( "tmp_tkdn_intro_mockup_ambience_lp", level.player );
    var_c2f11cc0 = snd::play( [ 8.5, "tmp_tkdn_intro_mockup_flybys", 1 ], level.player );
    var_d012326a = snd::play( [ var_963d1b69, "tmp_tkdn_intro_mockup_helis_lp", 0 ], level.player );
    wait var_963d1b69;
    snd::stop( var_5bc91147, 0.1 );
    level waittill( #"intro_trans_out" );
    snd::stop( var_d012326a, 0.1 );
}

