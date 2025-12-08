#using script_35ae72be7b4fec10;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\util;

#namespace prompts;

// Namespace prompts/prompts
// Params 0, eflags: 0x6
// Checksum 0x8f098f58, Offset: 0x358
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"prompts", &preload, undefined, undefined, undefined );
}

// Namespace prompts/prompts
// Params 0, eflags: 0x4
// Checksum 0x32f8fc3f, Offset: 0x3a0
// Size: 0xb04
function private preload()
{
    level.prompts[ #"use" ] = { #button_text:#"hash_5797cba717dc64d5", #var_92bb1cb1:&function_99bb5bbe, #var_9a98e590:&function_ab46a161, #notify_string:"trigger" };
    level.prompts[ #"melee" ] = { #button_text:#"hash_18d0a7d5aff08dd8", #var_92bb1cb1:&function_99bb5bbe, #var_9a98e590:&function_ab46a161, #notify_string:"damage" };
    level.prompts[ #"melee_hold" ] = { #button_action:#"hash_2d1efe88663d0c48", #button_text:#"hash_18d0a7d5aff08dd8", #var_92bb1cb1:&function_99bb5bbe, #var_9a98e590:&function_ab46a161, #notify_string:"grab" };
    level.prompts[ #"attack" ] = { #button_text:#"hash_3c124085ee45de36", #var_92bb1cb1:&function_99bb5bbe, #var_9a98e590:&function_ab46a161, #notify_string:"attack" };
    level.prompts[ #"reload" ] = { #button_text:#"hash_27324f18b09b7a6d", #var_92bb1cb1:&function_99bb5bbe, #var_9a98e590:&function_ab46a161, #notify_string:"reload" };
    level.prompts[ #"frag" ] = { #button_text:#"hash_c7de853806860ce", #var_92bb1cb1:&function_99bb5bbe, #var_9a98e590:&function_ab46a161, #notify_string:"frag" };
    level.prompts[ #"stance" ] = { #button_text:#"hash_34ccc944003048fe", #var_92bb1cb1:&function_99bb5bbe, #var_9a98e590:&function_ab46a161, #notify_string:"stance", #var_b753c5a5:"BUTTON_BIT_ANY_DOWN" };
    level.prompts[ #"weapnext" ] = { #button_text:#"hash_4b3f0bed118eaaf1", #var_92bb1cb1:&function_99bb5bbe, #var_9a98e590:&function_ab46a161, #notify_string:"weapnext" };
    level.prompts[ #"ads" ] = { #button_text:#"hash_41f7ff5095b74d02", #var_92bb1cb1:&function_99bb5bbe, #var_9a98e590:&function_ab46a161, #notify_string:"aim" };
    level.prompts[ #"vehicle_attack" ] = { #button_text:#"hash_6a2aef10bb120a0d", #var_92bb1cb1:&function_99bb5bbe, #var_9a98e590:&function_ab46a161, #notify_string:"attack" };
    level.prompts[ #"confirm" ] = { #button_text:#"hash_686cc531969c8555", #var_92bb1cb1:&function_eee54dd8, #var_9a98e590:&function_ab46a161, #notify_string:"select", #var_e4c7b05f:#"hash_7179662091387b23" };
    level.prompts[ #"cancel" ] = { #button_text:#"hash_2ac0a4c8c1d0c8d", #var_92bb1cb1:&function_eee54dd8, #var_9a98e590:&function_ab46a161, #notify_string:"cancel", #var_e4c7b05f:#"hash_2eb2f3b39714ea5f" };
    level.prompts[ #"alt1" ] = { #button_text:#"hash_1fb4a5c9d34c7339", #var_92bb1cb1:&function_eee54dd8, #var_9a98e590:&function_ab46a161, #notify_string:"alt1", #var_e4c7b05f:#"hash_7179672091387cd6", #lui_button:7, #var_b35ba5c:"MOUSE2" };
    level.prompts[ #"alt2" ] = { #button_text:#"hash_7b5f7a069d7cd3a", #var_92bb1cb1:&function_eee54dd8, #var_9a98e590:&function_ab46a161, #notify_string:"alt2", #var_e4c7b05f:#"hash_7179682091387e89", #lui_button:8, #var_b35ba5c:"MOUSE3" };
    level.var_a8ea96e8 = [];
    level.var_6a7fb742 = &function_c97a48c7;
    level.var_a29d8d23 = &function_a4cf2cde;
    level.var_3626dfc = &remove;
    level.var_503dffcb = [];
    callback::on_spawned( &on_player_spawned );
    util::init_dvar( "cg_cpMaxHoldDurationIgnore", 0, &function_5baa8d71 );
    
    /#
        util::init_dvar( "<dev string:x38>", 0, &function_db698ba5 );
        util::init_dvar( "<dev string:x4b>", 0, &function_db698ba5 );
        util::init_dvar( "<dev string:x62>", 0, &function_db698ba5 );
        util::init_dvar( "<dev string:x7e>", 0, &function_db698ba5 );
        util::init_dvar( "<dev string:x9b>", -1, &function_db698ba5 );
        util::init_dvar( "<dev string:xb3>", -1, &function_db698ba5 );
        util::init_dvar( "<dev string:xcc>", -1, &function_db698ba5 );
        util::init_dvar( "<dev string:xe7>", -1, &function_db698ba5 );
        util::init_dvar( "<dev string:x102>", 0, &function_db698ba5 );
    #/
}

// Namespace prompts/prompts
// Params 1, eflags: 0x4
// Checksum 0x548d9c1b, Offset: 0xeb0
// Size: 0x28
function private function_5baa8d71( dvar )
{
    level.var_503dffcb[ dvar.name ] = dvar.value;
}

/#

    // Namespace prompts/prompts
    // Params 1, eflags: 0x4
    // Checksum 0x4073ba3a, Offset: 0xee0
    // Size: 0x2c, Type: dev
    function private function_db698ba5( dvar )
    {
        level.var_a48f9f79[ dvar.name ] = dvar.value;
    }

#/

// Namespace prompts/prompts
// Params 0
// Checksum 0xa8c8af72, Offset: 0xf18
// Size: 0xca
function on_player_spawned()
{
    self endon( #"death" );
    
    if ( !isdefined( self.var_b3c804a4 ) )
    {
        self.var_b3c804a4 = [];
    }
    
    time_interval = 1;
    var_f08f2050 = pow( 528 * time_interval, 2 );
    
    while ( true )
    {
        last_pos = self.origin;
        wait time_interval;
        
        if ( distancesquared( self.origin, last_pos ) > var_f08f2050 )
        {
            self notify( #"teleported" );
        }
    }
}

// Namespace prompts/prompts
// Params 5
// Checksum 0xd86ac94a, Offset: 0xff0
// Size: 0x84
function register( prompt, var_92bb1cb1, button_text, notify_string, var_9a98e590 )
{
    level.prompts[ prompt ] = { #button_text:button_text, #var_92bb1cb1:var_92bb1cb1, #var_9a98e590:var_9a98e590, #notify_string:notify_string };
}

// Namespace prompts/prompts
// Params 17
// Checksum 0x724983de, Offset: 0x1080
// Size: 0x1d4
function create( prompt = #"use", prompt_text, complete_callback, var_531201f1, notify_string, offset, tag, var_754bedbb, var_de6f0004, var_4ac77177, var_71b9f0c0, var_87c991f3, var_5e83875a, var_8ce60046, var_9a27c4ee, var_be77841a, flags )
{
    prompt_struct = { #prompt_text:prompt_text, #complete_callback:complete_callback, #var_531201f1:var_531201f1, #notify_string:notify_string, #offset:offset, #tag:tag, #var_754bedbb:var_754bedbb, #var_de6f0004:var_de6f0004, #var_4ac77177:var_4ac77177, #var_71b9f0c0:var_71b9f0c0, #var_87c991f3:var_87c991f3, #var_5e83875a:var_5e83875a, #var_8ce60046:var_8ce60046, #var_9a27c4ee:var_9a27c4ee, #var_be77841a:var_be77841a, #flags:flags };
    self function_c97a48c7( prompt, prompt_struct );
}

// Namespace prompts/prompts
// Params 2
// Checksum 0xc8b7b1e0, Offset: 0x1260
// Size: 0x63c
function function_c97a48c7( prompt, prompt_struct )
{
    assert( isdefined( prompt ), "<dev string:x113>" );
    assert( isdefined( level.prompts[ prompt ] ), "<dev string:x158>" );
    assert( isentity( self ) || isstruct( self ) && isdefined( self.origin ) && isdefined( self.angles ), "<dev string:x207>" );
    self remove( prompt, 1 );
    var_a23c5e1 = !isdefined( self.var_3e95b88f );
    
    if ( !isdefined( self.var_3e95b88f ) )
    {
        self.var_3e95b88f = {};
    }
    
    if ( !isdefined( self.var_3e95b88f.prompts ) )
    {
        self.var_3e95b88f.prompts = [];
    }
    
    if ( !isdefined( self.var_3e95b88f.var_294a441e ) )
    {
        self.var_3e95b88f.var_294a441e = [];
    }
    
    if ( !isdefined( self.var_3e95b88f.hud ) )
    {
        self.var_3e95b88f.hud = isplayer( self );
    }
    
    if ( !isdefined( prompt_struct.var_de6f0004 ) )
    {
        prompt_struct.var_de6f0004 = 0.5;
    }
    
    if ( !isdefined( prompt_struct.var_4ac77177 ) )
    {
        prompt_struct.var_4ac77177 = 0.1;
    }
    
    if ( !isdefined( prompt_struct.var_71b9f0c0 ) )
    {
        prompt_struct.var_71b9f0c0 = 240;
    }
    
    if ( !isdefined( prompt_struct.var_9c89c587 ) )
    {
        prompt_struct.var_9c89c587 = 0;
    }
    
    if ( !isdefined( prompt_struct.var_f17a78a7 ) )
    {
        prompt_struct.var_f17a78a7 = 180;
    }
    
    if ( !isdefined( prompt_struct.var_87c991f3 ) )
    {
        prompt_struct.var_87c991f3 = 85;
    }
    
    if ( !isdefined( prompt_struct.var_5e83875a ) )
    {
        prompt_struct.var_5e83875a = 30;
    }
    
    if ( !isdefined( prompt_struct.var_7faab93d ) )
    {
        prompt_struct.var_7faab93d = 1;
    }
    
    if ( !isdefined( prompt_struct.var_8ce60046 ) )
    {
        prompt_struct.var_8ce60046 = 1;
    }
    
    if ( !isdefined( prompt_struct.var_9a27c4ee ) )
    {
        prompt_struct.var_9a27c4ee = 1;
    }
    
    if ( !isdefined( prompt_struct.var_be77841a ) )
    {
        prompt_struct.var_be77841a = 1;
    }
    
    prompt_struct.state = 0;
    priority = isdefined( prompt_struct.priority ) ? prompt_struct.priority : 1;
    
    if ( !isdefined( self.var_3e95b88f.var_294a441e[ prompt ] ) )
    {
        for ( priority = int( priority * 10 ); isinarray( self.var_3e95b88f.var_294a441e, priority ) ; priority++ )
        {
        }
        
        self.var_3e95b88f.var_294a441e[ prompt ] = priority;
    }
    else
    {
        priority = self.var_3e95b88f.var_294a441e[ prompt ];
    }
    
    if ( isdefined( prompt_struct.groups ) && !isarray( prompt_struct.groups ) )
    {
        prompt_struct.groups = array( prompt_struct.groups );
    }
    
    self.var_3e95b88f.prompts[ prompt ] = structcopy( prompt_struct );
    self.var_3e95b88f.prompts[ prompt ].priority = priority;
    self.var_3e95b88f.prompts[ prompt ].flags = 0;
    
    if ( isdefined( prompt_struct.flags ) )
    {
        foreach ( flag in prompt_struct.flags )
        {
            self.var_3e95b88f.prompts[ prompt ].flags |= 1 << flag;
        }
    }
    
    self.var_3e95b88f.prompts[ prompt ].var_de6f0004 = int( prompt_struct.var_de6f0004 * 1000 );
    self.var_3e95b88f.prompts[ prompt ].var_4ac77177 = int( prompt_struct.var_4ac77177 * 1000 );
    self function_a4cf2cde( { #offset:prompt_struct.offset, #tag:prompt_struct.tag, #var_754bedbb:prompt_struct.var_754bedbb } );
    self notify( "prompt_added_" + prompt );
    
    if ( var_a23c5e1 )
    {
        self thread _think();
    }
}

// Namespace prompts/prompts
// Params 2
// Checksum 0x3bd57048, Offset: 0x18a8
// Size: 0x132
function function_46df0bc7( prompt, priority )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x283>" );
    assert( isdefined( self.var_3e95b88f.prompts[ prompt ] ), "<dev string:x2e0>" + function_9e72a96( prompt ) + "<dev string:x341>" );
    priority = int( priority * 10 );
    arrayremoveindex( self.var_3e95b88f.var_294a441e, prompt, 1 );
    
    while ( isinarray( self.var_3e95b88f.var_294a441e, priority ) )
    {
        priority++;
    }
    
    self.var_3e95b88f.var_294a441e[ prompt ] = priority;
    self.var_3e95b88f.prompts[ prompt ].priority = priority;
}

// Namespace prompts/prompts
// Params 1
// Checksum 0xbbfb8b1b, Offset: 0x19e8
// Size: 0x2a6
function function_a4cf2cde( offset_struct )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x346>" );
    var_68131ee = 0;
    offset = ( 0, 0, 0 );
    
    if ( !self function_5a11b8f6() )
    {
        self.var_3e95b88f.var_80778410 = 0;
    }
    else
    {
        self.var_3e95b88f.var_80778410 = 1;
    }
    
    if ( iscorpse( self ) )
    {
        offset_struct.var_754bedbb = 0;
        offset_struct.tag = undefined;
    }
    else if ( isdefined( offset_struct.tag ) && self haspart( offset_struct.tag ) )
    {
        origin = self.origin;
        
        if ( isentity( self ) && is_true( offset_struct.var_754bedbb ) )
        {
            origin += rotatepoint( self getboundsmidpoint(), self.angles );
        }
        
        offset = rotatepoint( self gettagorigin( offset_struct.tag ) - origin, self.angles * -1 );
    }
    
    if ( isdefined( offset_struct.offset ) )
    {
        offset += offset_struct.offset;
    }
    else if ( isplayer( self ) )
    {
        offset = ( 914.286, 675, 0 );
    }
    
    if ( offset != ( 0, 0, 0 ) )
    {
        self.var_3e95b88f.offset = offset;
        var_68131ee = 1;
    }
    
    if ( isdefined( offset_struct.var_754bedbb ) )
    {
        self.var_3e95b88f.var_754bedbb = offset_struct.var_754bedbb;
        var_68131ee = 1;
    }
    
    if ( isdefined( offset_struct.var_51f93e19 ) )
    {
        self.var_3e95b88f.var_80778410 = offset_struct.var_51f93e19;
        var_68131ee = 1;
    }
    
    if ( var_68131ee )
    {
        self notify( #"hash_17cbfac9e551855a" );
    }
}

// Namespace prompts/prompts
// Params 2
// Checksum 0x444f1f03, Offset: 0x1c98
// Size: 0x8e
function function_92127496( var_80534db1, var_a5ce465f = 0 )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x3a0>" );
    
    if ( !isplayer( self ) )
    {
        self.var_3e95b88f.hud = var_80534db1;
        self.var_3e95b88f.var_a5ce465f = var_a5ce465f;
    }
}

// Namespace prompts/prompts
// Params 1
// Checksum 0x38b95d34, Offset: 0x1d30
// Size: 0x94
function function_309bf7c2( image )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x3a0>" );
    self.var_3e95b88f.image = image;
    
    if ( isdefined( self.var_3e95b88f.uid ) )
    {
        scripted_widgets::function_309bf7c2( self.var_3e95b88f.uid, image );
        globallogic_ui::function_ec25f500( " ", 0 );
    }
}

// Namespace prompts/prompts
// Params 1
// Checksum 0x3fbc5438, Offset: 0x1dd0
// Size: 0x94
function function_3a1a483b( progress )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x3a0>" );
    self.var_3e95b88f.var_fc01e65d = progress;
    
    if ( isdefined( self.var_3e95b88f.uid ) )
    {
        scripted_widgets::function_b1e6d7a8( self.var_3e95b88f.uid, progress );
        globallogic_ui::function_ec25f500( " ", 0 );
    }
}

// Namespace prompts/prompts
// Params 2
// Checksum 0xfad90cc, Offset: 0x1e70
// Size: 0xc4
function function_dade5b1a( name, team )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x3a0>" );
    self.var_3e95b88f.display_name = name;
    self.var_3e95b88f.team = util::getteamindex( isdefined( team ) ? team : self getteam() );
    
    if ( isdefined( self.var_3e95b88f.uid ) )
    {
        globallogic_ui::function_ec25f500( name, team );
    }
}

// Namespace prompts/prompts
// Params 2
// Checksum 0xb58b5ca4, Offset: 0x1f40
// Size: 0x184
function function_263320e2( prompt, prompt_text )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x283>" );
    assert( isdefined( self.var_3e95b88f.prompts[ prompt ] ), "<dev string:x2e0>" + function_9e72a96( prompt ) + "<dev string:x341>" );
    self.var_3e95b88f.prompts[ prompt ].prompt_text = prompt_text;
    
    if ( isdefined( self.var_3e95b88f.uid ) )
    {
        if ( isdefined( prompt_text ) )
        {
            scripted_widgets::function_f2a9266( self.var_3e95b88f.uid, self.var_3e95b88f.var_294a441e[ prompt ], "text", prompt_text, self.var_3e95b88f.var_db58523e );
            return;
        }
        
        scripted_widgets::function_f2a9266( self.var_3e95b88f.uid, self.var_3e95b88f.var_294a441e[ prompt ], "text", #"", self.var_3e95b88f.var_db58523e );
    }
}

// Namespace prompts/prompts
// Params 2
// Checksum 0x551e69a, Offset: 0x20d0
// Size: 0xb2
function function_75d5e526( prompt, complete_callback )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x283>" );
    assert( isdefined( self.var_3e95b88f.prompts[ prompt ] ), "<dev string:x2e0>" + function_9e72a96( prompt ) + "<dev string:x341>" );
    self.var_3e95b88f.prompts[ prompt ].complete_callback = complete_callback;
}

// Namespace prompts/prompts
// Params 2
// Checksum 0x7a4bad7, Offset: 0x2190
// Size: 0xb2
function function_a4a9acfc( prompt, var_531201f1 )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x283>" );
    assert( isdefined( self.var_3e95b88f.prompts[ prompt ] ), "<dev string:x2e0>" + function_9e72a96( prompt ) + "<dev string:x341>" );
    self.var_3e95b88f.prompts[ prompt ].var_531201f1 = var_531201f1;
}

// Namespace prompts/prompts
// Params 2
// Checksum 0x9536e7cc, Offset: 0x2250
// Size: 0xb2
function function_cd2391cb( prompt, notify_string )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x283>" );
    assert( isdefined( self.var_3e95b88f.prompts[ prompt ] ), "<dev string:x2e0>" + function_9e72a96( prompt ) + "<dev string:x341>" );
    self.var_3e95b88f.prompts[ prompt ].notify_string = notify_string;
}

// Namespace prompts/prompts
// Params 4
// Checksum 0xf0f84027, Offset: 0x2310
// Size: 0x7c
function set_offset( offset, tag, var_754bedbb, var_51f93e19 )
{
    self function_a4cf2cde( { #offset:offset, #tag:tag, #var_754bedbb:var_754bedbb, #var_51f93e19:var_51f93e19 } );
}

// Namespace prompts/prompts
// Params 2
// Checksum 0xad312891, Offset: 0x2398
// Size: 0x62
function function_46f198( uid, var_db58523e )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x283>" );
    self.var_3e95b88f.uid = uid;
    self.var_3e95b88f.var_db58523e = var_db58523e;
}

// Namespace prompts/prompts
// Params 2
// Checksum 0xc8d484a8, Offset: 0x2408
// Size: 0x32
function function_816ddada( prompt, var_1df3804c )
{
    self.var_3e95b88f.prompts[ prompt ].var_1df3804c = var_1df3804c;
}

// Namespace prompts/prompts
// Params 3
// Checksum 0x26c05f5b, Offset: 0x2448
// Size: 0x24c
function function_44d7831a( prompt, flags, var_cca4e0db = 0 )
{
    if ( var_cca4e0db )
    {
        self.var_3e95b88f.prompts[ prompt ].flags |= flags;
    }
    else
    {
        if ( !isdefined( flags ) )
        {
            flags = [];
        }
        else if ( !isarray( flags ) )
        {
            flags = array( flags );
        }
        
        foreach ( flag in flags )
        {
            self.var_3e95b88f.prompts[ prompt ].flags |= 1 << flag;
        }
    }
    
    uid = self.var_3e95b88f.uid;
    
    if ( isdefined( uid ) && scripted_widgets::function_cd59371c( uid, self.var_3e95b88f.var_294a441e[ prompt ], self.var_3e95b88f.var_db58523e ) && !is_true( self.var_3e95b88f.prompts[ prompt ].removing ) )
    {
        scripted_widgets::function_9bc1d2f1( uid, self.var_3e95b88f.var_294a441e[ prompt ], self.var_3e95b88f.prompts[ prompt ].flags, 1 );
    }
}

// Namespace prompts/prompts
// Params 3
// Checksum 0x116dd876, Offset: 0x26a0
// Size: 0x234
function function_4b556f63( prompt, flags, var_cca4e0db = 0 )
{
    if ( var_cca4e0db )
    {
        self.var_3e95b88f.prompts[ prompt ].flags &= ~flags;
    }
    else
    {
        if ( !isdefined( flags ) )
        {
            flags = [];
        }
        else if ( !isarray( flags ) )
        {
            flags = array( flags );
        }
        
        foreach ( flag in flags )
        {
            self.var_3e95b88f.prompts[ prompt ].flags &= ~flag;
        }
    }
    
    uid = self.var_3e95b88f.uid;
    
    if ( isdefined( uid ) && scripted_widgets::function_cd59371c( uid, self.var_3e95b88f.var_294a441e[ prompt ], self.var_3e95b88f.var_db58523e ) && !is_true( self.var_3e95b88f.prompts[ prompt ].removing ) )
    {
        scripted_widgets::function_e8c19a33( uid, self.var_3e95b88f.var_294a441e[ prompt ], flags, 1 );
    }
}

// Namespace prompts/prompts
// Params 2
// Checksum 0x26aaae13, Offset: 0x28e0
// Size: 0xd2
function function_d03d79d6( prompt, var_de6f0004 )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x283>" );
    assert( isdefined( self.var_3e95b88f.prompts[ prompt ] ), "<dev string:x2e0>" + function_9e72a96( prompt ) + "<dev string:x341>" );
    self.var_3e95b88f.prompts[ prompt ].var_de6f0004 = int( var_de6f0004 * 1000 );
}

// Namespace prompts/prompts
// Params 2
// Checksum 0xbde1803d, Offset: 0x29c0
// Size: 0xd2
function function_8f5eb0a6( prompt, var_4ac77177 )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x283>" );
    assert( isdefined( self.var_3e95b88f.prompts[ prompt ] ), "<dev string:x2e0>" + function_9e72a96( prompt ) + "<dev string:x341>" );
    self.var_3e95b88f.prompts[ prompt ].var_4ac77177 = int( var_4ac77177 * 1000 );
}

// Namespace prompts/prompts
// Params 2
// Checksum 0x965b13d2, Offset: 0x2aa0
// Size: 0xb2
function function_5fe46a16( prompt, var_71b9f0c0 )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x283>" );
    assert( isdefined( self.var_3e95b88f.prompts[ prompt ] ), "<dev string:x2e0>" + function_9e72a96( prompt ) + "<dev string:x341>" );
    self.var_3e95b88f.prompts[ prompt ].var_71b9f0c0 = var_71b9f0c0;
}

// Namespace prompts/prompts
// Params 2
// Checksum 0x576489cb, Offset: 0x2b60
// Size: 0xb2
function function_cf884581( prompt, var_79a4cbfc )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x283>" );
    assert( isdefined( self.var_3e95b88f.prompts[ prompt ] ), "<dev string:x2e0>" + function_9e72a96( prompt ) + "<dev string:x341>" );
    self.var_3e95b88f.prompts[ prompt ].var_9c89c587 = var_79a4cbfc;
}

// Namespace prompts/prompts
// Params 2
// Checksum 0x9b7f20b0, Offset: 0x2c20
// Size: 0xb2
function function_5698d1c9( prompt, var_5f57572a )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x283>" );
    assert( isdefined( self.var_3e95b88f.prompts[ prompt ] ), "<dev string:x2e0>" + function_9e72a96( prompt ) + "<dev string:x341>" );
    self.var_3e95b88f.prompts[ prompt ].var_f17a78a7 = var_5f57572a;
}

// Namespace prompts/prompts
// Params 2
// Checksum 0x336e1c6, Offset: 0x2ce0
// Size: 0xb2
function function_68782902( prompt, var_87c991f3 )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x283>" );
    assert( isdefined( self.var_3e95b88f.prompts[ prompt ] ), "<dev string:x2e0>" + function_9e72a96( prompt ) + "<dev string:x341>" );
    self.var_3e95b88f.prompts[ prompt ].var_87c991f3 = var_87c991f3;
}

// Namespace prompts/prompts
// Params 2
// Checksum 0x3d97a69a, Offset: 0x2da0
// Size: 0xb2
function function_2557566( prompt, var_7faab93d )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x283>" );
    assert( isdefined( self.var_3e95b88f.prompts[ prompt ] ), "<dev string:x2e0>" + function_9e72a96( prompt ) + "<dev string:x341>" );
    self.var_3e95b88f.prompts[ prompt ].var_7faab93d = var_7faab93d;
}

// Namespace prompts/prompts
// Params 2
// Checksum 0xf11ca089, Offset: 0x2e60
// Size: 0xb2
function function_b95d71cd( prompt, var_5e83875a )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x283>" );
    assert( isdefined( self.var_3e95b88f.prompts[ prompt ] ), "<dev string:x2e0>" + function_9e72a96( prompt ) + "<dev string:x341>" );
    self.var_3e95b88f.prompts[ prompt ].var_5e83875a = var_5e83875a;
}

// Namespace prompts/prompts
// Params 2
// Checksum 0xb4b8ba1e, Offset: 0x2f20
// Size: 0xb2
function function_1a5e1da6( prompt, var_3c8a8153 )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x283>" );
    assert( isdefined( self.var_3e95b88f.prompts[ prompt ] ), "<dev string:x2e0>" + function_9e72a96( prompt ) + "<dev string:x341>" );
    self.var_3e95b88f.prompts[ prompt ].var_3c8a8153 = var_3c8a8153;
}

// Namespace prompts/prompts
// Params 2
// Checksum 0xb81e65b3, Offset: 0x2fe0
// Size: 0xb2
function function_4cb5d3a1( prompt, var_8ce60046 )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x283>" );
    assert( isdefined( self.var_3e95b88f.prompts[ prompt ] ), "<dev string:x2e0>" + function_9e72a96( prompt ) + "<dev string:x341>" );
    self.var_3e95b88f.prompts[ prompt ].var_8ce60046 = var_8ce60046;
}

// Namespace prompts/prompts
// Params 2
// Checksum 0xc7883cb7, Offset: 0x30a0
// Size: 0xb2
function function_dcf99fad( prompt, var_9a27c4ee )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x283>" );
    assert( isdefined( self.var_3e95b88f.prompts[ prompt ] ), "<dev string:x2e0>" + function_9e72a96( prompt ) + "<dev string:x341>" );
    self.var_3e95b88f.prompts[ prompt ].var_9a27c4ee = var_9a27c4ee;
}

// Namespace prompts/prompts
// Params 2
// Checksum 0xac1aceae, Offset: 0x3160
// Size: 0xb2
function function_2bd2431a( prompt, var_be77841a )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x283>" );
    assert( isdefined( self.var_3e95b88f.prompts[ prompt ] ), "<dev string:x2e0>" + function_9e72a96( prompt ) + "<dev string:x341>" );
    self.var_3e95b88f.prompts[ prompt ].var_be77841a = var_be77841a;
}

// Namespace prompts/prompts
// Params 2
// Checksum 0xb701314b, Offset: 0x3220
// Size: 0xf6
function function_3171730f( prompt, groups )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x283>" );
    assert( isdefined( self.var_3e95b88f.prompts[ prompt ] ), "<dev string:x2e0>" + function_9e72a96( prompt ) + "<dev string:x341>" );
    
    if ( !isdefined( groups ) )
    {
        groups = [];
    }
    else if ( !isarray( groups ) )
    {
        groups = array( groups );
    }
    
    self.var_3e95b88f.prompts[ prompt ].groups = groups;
}

// Namespace prompts/prompts
// Params 1
// Checksum 0xf30372d8, Offset: 0x3320
// Size: 0x5c
function function_e79f51ec( groups )
{
    if ( !isdefined( groups ) )
    {
        groups = [];
    }
    else if ( !isarray( groups ) )
    {
        groups = array( groups );
    }
    
    level.var_a8ea96e8 = groups;
}

// Namespace prompts/prompts
// Params 0
// Checksum 0x868a53e1, Offset: 0x3388
// Size: 0x10
function function_398ab9eb()
{
    level.var_a8ea96e8 = [];
}

// Namespace prompts/prompts
// Params 2
// Checksum 0xb8609cb3, Offset: 0x33a0
// Size: 0xb2
function function_2e6d74f5( prompt, pause )
{
    assert( isdefined( self.var_3e95b88f ), "<dev string:x283>" );
    assert( isdefined( self.var_3e95b88f.prompts[ prompt ] ), "<dev string:x2e0>" + function_9e72a96( prompt ) + "<dev string:x341>" );
    self.var_3e95b88f.prompts[ prompt ].var_f14d06ca = pause;
}

// Namespace prompts/prompts
// Params 2
// Checksum 0x716fab1d, Offset: 0x3460
// Size: 0x17c
function remove( prompt, immediate )
{
    if ( isdefined( self.var_3e95b88f ) && isdefined( self.var_3e95b88f.prompts[ prompt ] ) && !is_true( self.var_3e95b88f.prompts[ prompt ].removing ) )
    {
        self notify( #"prompt_removed", { #prompt:prompt } );
        self notify( "prompt_removed_" + prompt );
        
        if ( isdefined( self.var_3e95b88f.uid ) && isdefined( self.var_3e95b88f.var_294a441e[ prompt ] ) )
        {
            function_17578ab7( prompt, self.var_3e95b88f );
            scripted_widgets::function_7239e030( self.var_3e95b88f.uid, self.var_3e95b88f.var_294a441e[ prompt ], self.var_3e95b88f.var_db58523e );
        }
        
        self.var_3e95b88f.prompts[ prompt ].removing = 1;
        self thread function_660c618b( prompt, immediate );
    }
}

// Namespace prompts/prompts
// Params 2, eflags: 0x4
// Checksum 0x5e066ada, Offset: 0x35e8
// Size: 0x256
function private function_660c618b( prompt, immediate )
{
    self endon( #"all_prompts_removed", "prompt_added_" + prompt, #"death" );
    
    if ( !is_true( immediate ) )
    {
        waittillframeend();
    }
    
    if ( isdefined( self.var_3e95b88f ) && isdefined( self.var_3e95b88f.prompts[ prompt ] ) )
    {
        arrayremoveindex( self.var_3e95b88f.prompts, prompt, 1 );
        arrayremoveindex( self.var_3e95b88f.var_294a441e, prompt, 1 );
        player = getplayers()[ 0 ];
        
        if ( player.var_b3c804a4[ prompt ] === self )
        {
            player.var_b3c804a4[ prompt ] = undefined;
        }
        
        if ( self.var_3e95b88f.prompts.size == 0 )
        {
            if ( isdefined( self.var_3e95b88f.uid ) )
            {
                if ( !isdefined( self.var_3e95b88f.var_db58523e ) )
                {
                    self function_8de9a77a();
                }
                else if ( isdefined( self.var_3e95b88f.var_294a441e ) )
                {
                    foreach ( index in self.var_3e95b88f.var_294a441e )
                    {
                        scripted_widgets::function_7239e030( self.var_3e95b88f.uid, index, self.var_3e95b88f.var_db58523e );
                    }
                }
            }
            
            self.var_3e95b88f = undefined;
            self notify( #"all_prompts_removed" );
        }
    }
}

// Namespace prompts/prompts
// Params 1
// Checksum 0x5cbc5ce3, Offset: 0x3848
// Size: 0x160
function remove_group( group )
{
    if ( isdefined( self.var_3e95b88f.prompts ) )
    {
        var_c94d18f6 = [];
        
        foreach ( prompt, prompt_struct in self.var_3e95b88f.prompts )
        {
            if ( isdefined( prompt_struct.groups ) && isinarray( prompt_struct.groups, group ) )
            {
                var_c94d18f6[ var_c94d18f6.size ] = prompt;
            }
        }
        
        foreach ( prompt in var_c94d18f6 )
        {
            self thread remove( prompt, 1 );
        }
    }
}

// Namespace prompts/prompts
// Params 0
// Checksum 0x5da8e754, Offset: 0x39b0
// Size: 0x174
function function_334e020()
{
    if ( isdefined( self.var_3e95b88f ) )
    {
        var_393b6e18 = self.origin;
        
        if ( isentity( self ) )
        {
            if ( iscorpse( self ) )
            {
                var_393b6e18 = self getcorpsephysicsorigin() + ( 0, 0, 6 );
            }
            else if ( is_true( self.var_3e95b88f.var_754bedbb ) )
            {
                var_393b6e18 += rotatepoint( self getboundsmidpoint(), self.angles );
            }
        }
        
        if ( isdefined( self.var_3e95b88f.offset ) && self.var_3e95b88f.offset != ( 0, 0, 0 ) )
        {
            if ( is_true( self.var_3e95b88f.var_80778410 ) )
            {
                var_393b6e18 += rotatepoint( self.var_3e95b88f.offset, self.angles );
            }
            else
            {
                var_393b6e18 += self.var_3e95b88f.offset;
            }
        }
        
        return var_393b6e18;
    }
    
    return undefined;
}

// Namespace prompts/prompts
// Params 0
// Checksum 0x722a27fa, Offset: 0x3b30
// Size: 0x24
function function_86eedc()
{
    self flag::set( "prompts_disabled" );
}

// Namespace prompts/prompts
// Params 0
// Checksum 0x7b57105c, Offset: 0x3b60
// Size: 0x24
function function_d675f5a4()
{
    self flag::clear( "prompts_disabled" );
}

// Namespace prompts/prompts
// Params 3, eflags: 0x4
// Checksum 0x28ab6c1e, Offset: 0x3b90
// Size: 0x30a, Type: bool
function private function_d626d354( prompt, player, dist )
{
    var_62bce5b6 = self.var_3e95b88f.prompts[ prompt ];
    
    if ( self flag::get( "prompts_disabled" ) || level flag::get( "prompts_disabled" ) )
    {
        return false;
    }
    
    if ( level.var_a8ea96e8.size > 0 )
    {
        if ( !isdefined( var_62bce5b6.groups ) )
        {
            return false;
        }
        
        var_a4d18ab4 = 0;
        
        foreach ( var_405c2a4c in level.var_a8ea96e8 )
        {
            if ( isinarray( var_62bce5b6.groups, var_405c2a4c ) )
            {
                var_a4d18ab4 = 1;
                break;
            }
        }
        
        if ( !var_a4d18ab4 )
        {
            return false;
        }
    }
    
    if ( self != player )
    {
        var_71b9f0c0 = var_62bce5b6.var_71b9f0c0;
        
        /#
            if ( level.var_a48f9f79[ #"hash_648d8b504449ecd3" ] > 0 )
            {
                var_71b9f0c0 = level.var_a48f9f79[ #"hash_648d8b504449ecd3" ];
            }
        #/
        
        if ( dist > var_71b9f0c0 )
        {
            return false;
        }
        
        self.var_3e95b88f.var_98fa5077 = 1;
        require_los = var_62bce5b6.var_8ce60046;
        
        /#
            if ( level.var_a48f9f79[ #"hash_3cdd945161669bf5" ] >= 0 )
            {
                require_los = level.var_a48f9f79[ #"hash_3cdd945161669bf5" ] > 0;
            }
        #/
        
        if ( require_los )
        {
            var_393b6e18 = self function_334e020();
            var_27a7ecaa = isdefined( var_62bce5b6.var_27a7ecaa ) ? var_62bce5b6.var_27a7ecaa : player;
            
            if ( !sighttracepassed( player getplayercamerapos(), var_393b6e18, 1, self, var_27a7ecaa ) )
            {
                return false;
            }
        }
    }
    
    if ( isdefined( var_62bce5b6.var_531201f1 ) && !self [[ var_62bce5b6.var_531201f1 ]]( { #prompt:prompt, #player:player } ) )
    {
        return false;
    }
    
    return true;
}

// Namespace prompts/prompts
// Params 6, eflags: 0x4
// Checksum 0xd5fe1ffb, Offset: 0x3ea8
// Size: 0x58a, Type: bool
function private function_12186571( prompt, var_62bce5b6, player, dist, var_393b6e18, var_693a4fcf )
{
    if ( self != player )
    {
        if ( isdefined( player.var_b3c804a4[ prompt ] ) && player.var_b3c804a4[ prompt ] != self )
        {
            return false;
        }
        
        hud = self.var_3e95b88f.hud;
        var_343e3ef2 = 0;
        
        /#
            if ( level.var_a48f9f79[ #"hash_464a6e9e035a826e" ] > 0 )
            {
                hud = 1;
                var_343e3ef2 = 1;
            }
            else if ( level.var_a48f9f79[ #"hash_464a6e9e035a826e" ] < 0 )
            {
                hud = 0;
            }
        #/
        
        if ( hud )
        {
            foreach ( var_3388fe0e in player.var_b3c804a4 )
            {
                if ( isdefined( var_3388fe0e ) && var_3388fe0e != self && ( var_3388fe0e == player || var_343e3ef2 || var_3388fe0e.var_3e95b88f.hud ) )
                {
                    return false;
                }
            }
        }
        
        var_87c991f3 = var_62bce5b6.var_87c991f3;
        
        /#
            if ( level.var_a48f9f79[ #"hash_5188f09d68ab049b" ] > 0 )
            {
                var_87c991f3 = level.var_a48f9f79[ #"hash_5188f09d68ab049b" ];
            }
        #/
        
        if ( dist > var_87c991f3 )
        {
            return false;
        }
        
        var_45913153 = is_true( var_62bce5b6.var_3c8a8153 ) && level.var_7315ba31 === self;
        var_b0cb5e43 = undefined;
        
        if ( !var_45913153 && var_693a4fcf < 180 )
        {
            var_b0cb5e43 = vectornormalize( var_393b6e18 - player getplayercamerapos() );
            angle_delta = acos( vectordot( anglestoforward( player getplayerangles() ), var_b0cb5e43 ) );
            
            /#
                if ( level.var_a48f9f79[ #"hash_4415d97cf206beca" ] > 0 )
                {
                    var_693a4fcf = level.var_a48f9f79[ #"hash_4415d97cf206beca" ];
                }
            #/
            
            if ( angle_delta > var_693a4fcf )
            {
                return false;
            }
        }
        
        if ( isdefined( self.angles ) )
        {
            var_9c89c587 = var_62bce5b6.var_9c89c587;
            var_f17a78a7 = var_62bce5b6.var_f17a78a7;
            
            /#
                if ( level.var_a48f9f79[ #"hash_2665c3284c087179" ] >= 0 )
                {
                    var_9c89c587 = level.var_a48f9f79[ #"hash_2665c3284c087179" ];
                }
                
                if ( level.var_a48f9f79[ #"hash_264ad5284bf1c857" ] > 0 )
                {
                    var_f17a78a7 = level.var_a48f9f79[ #"hash_264ad5284bf1c857" ];
                }
            #/
            
            if ( var_9c89c587 > 0 || var_f17a78a7 < 180 )
            {
                if ( !isdefined( var_b0cb5e43 ) )
                {
                    var_b0cb5e43 = vectornormalize( var_393b6e18 - player getplayercamerapos() );
                }
                
                angle_delta = acos( vectordot( anglestoforward( self.angles ), var_b0cb5e43 ) );
                
                if ( angle_delta < var_9c89c587 || angle_delta > var_f17a78a7 )
                {
                    return false;
                }
            }
        }
        
        var_9a27c4ee = is_true( var_62bce5b6.var_9a27c4ee ) || var_45913153;
        
        /#
            if ( level.var_a48f9f79[ #"hash_d71edc1fface7ff" ] >= 0 )
            {
                var_9a27c4ee = level.var_a48f9f79[ #"hash_d71edc1fface7ff" ] > 0;
            }
        #/
        
        var_1e4cbecf = isdefined( var_62bce5b6.var_1e4cbecf ) ? var_62bce5b6.var_1e4cbecf : player;
        
        if ( !var_9a27c4ee && !bullettracepassed( player getplayercamerapos(), var_393b6e18, 1, self, var_1e4cbecf ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace prompts/prompts
// Params 1, eflags: 0x4
// Checksum 0x361c0b2f, Offset: 0x4440
// Size: 0x214
function private function_99bb5bbe( prompt_struct )
{
    if ( !prompt_struct.player gamepadusedlast() && isdefined( level.prompts[ prompt_struct.prompt ].var_b753c5a5 ) )
    {
        return prompt_struct.player buttonbitstate( level.prompts[ prompt_struct.prompt ].var_b753c5a5 );
    }
    
    switch ( prompt_struct.prompt )
    {
        case #"use":
            return prompt_struct.player usebuttonpressed();
        case #"melee_hold":
        case #"melee":
            return prompt_struct.player meleebuttonpressed();
        case #"attack":
            return prompt_struct.player attackbuttonpressed();
        case #"reload":
            return prompt_struct.player reloadbuttonpressed();
        case #"frag":
            return prompt_struct.player fragbuttonpressed();
        case #"stance":
            return prompt_struct.player stancebuttonpressed();
        case #"weapnext":
            return prompt_struct.player weaponswitchbuttonpressed();
        case #"ads":
            return prompt_struct.player adsbuttonpressed();
        case #"vehicle_attack":
            return prompt_struct.player vehicleattackbuttonpressed();
    }
    
    return 0;
}

// Namespace prompts/prompts
// Params 1, eflags: 0x4
// Checksum 0x21878d63, Offset: 0x4660
// Size: 0x374
function private function_eee54dd8( prompt_struct )
{
    switch ( prompt_struct.prompt )
    {
        case #"confirm":
            return prompt_struct.player scripted_widgets::function_affb1af1();
        case #"cancel":
            return prompt_struct.player scripted_widgets::function_57fbd346();
        case #"alt1":
            return prompt_struct.player scripted_widgets::function_e4d62f9a();
        case #"alt2":
            return prompt_struct.player scripted_widgets::function_728aec47();
        default:
            model = undefined;
            
            if ( prompt_struct.player gamepadusedlast() )
            {
                assert( isdefined( level.prompts[ prompt_struct.prompt ].lui_button ), "<dev string:x3f7>" + function_9e72a96( prompt_struct.prompt ) );
                var_d75b2384 = function_90d058e8( #"buttons" );
                model = getuimodel( var_d75b2384, string( level.prompts[ prompt_struct.prompt ].lui_button ) );
                assert( isdefined( model ), "<dev string:x421>" + level.prompts[ prompt_struct.prompt ].lui_button + "<dev string:x42f>" + function_9e72a96( prompt_struct.prompt ) );
            }
            else
            {
                assert( isdefined( level.prompts[ prompt_struct.prompt ].var_b35ba5c ), "<dev string:x447>" + function_9e72a96( prompt_struct.prompt ) );
                var_31a34837 = function_90d058e8( #"hash_48b37823078b5999" );
                model = getuimodel( var_31a34837, level.prompts[ prompt_struct.prompt ].var_b35ba5c );
                assert( isdefined( model ), "<dev string:x475>" + level.prompts[ prompt_struct.prompt ].var_b35ba5c + "<dev string:x42f>" + function_9e72a96( prompt_struct.prompt ) );
            }
            
            return ( getuimodelvalue( model ) > 0 );
    }
    
    return 0;
}

// Namespace prompts/prompts
// Params 1, eflags: 0x4
// Checksum 0x76ee3deb, Offset: 0x49e0
// Size: 0xb4
function private function_cd5cbae1( player )
{
    player endon( #"death" );
    self endon( #"all_prompts_removed" );
    level endon( #"level_restarting" );
    self waittill( #"death" );
    
    if ( isdefined( self.var_3e95b88f.uid ) )
    {
        function_17578ab7( undefined, self.var_3e95b88f );
    }
    
    arrayremovevalue( player.var_b3c804a4, self, 1 );
}

// Namespace prompts/prompts
// Params 0, eflags: 0x4
// Checksum 0x808cf933, Offset: 0x4aa0
// Size: 0x388
function private _think()
{
    self endon( #"death", #"all_prompts_removed" );
    level endon( #"level_restarting" );
    
    for ( player = getplayers()[ 0 ]; !isdefined( player ) ; player = getplayers()[ 0 ] )
    {
        waitframe( 1 );
    }
    
    if ( self != player )
    {
        player endon( #"death" );
        self thread function_cd5cbae1( player );
    }
    
    waittillframeend();
    
    while ( isdefined( self.var_3e95b88f ) )
    {
        dist = 0;
        
        if ( self != player )
        {
            dist = distance( player getplayercamerapos(), isdefined( self function_334e020() ) ? self function_334e020() : self.origin );
        }
        
        var_3808d0ab = 0;
        
        foreach ( prompt, var_62bce5b6 in self.var_3e95b88f.prompts )
        {
            if ( self function_d626d354( prompt, player, dist ) )
            {
                var_3808d0ab = 1;
                break;
            }
        }
        
        if ( var_3808d0ab )
        {
            self function_e8006b47();
            arrayremovevalue( player.var_b3c804a4, self, 1 );
            
            if ( isdefined( self.var_3e95b88f.uid ) )
            {
                if ( !isdefined( self.var_3e95b88f.var_db58523e ) )
                {
                    self function_8de9a77a();
                }
                else
                {
                    foreach ( index in self.var_3e95b88f.var_294a441e )
                    {
                        scripted_widgets::function_7239e030( self.var_3e95b88f.uid, index, self.var_3e95b88f.var_db58523e );
                    }
                }
            }
            
            continue;
        }
        
        player waittilltimeout( max( float( function_60d95f53() ) / 1000, dist / 528 ), #"teleported" );
    }
}

// Namespace prompts/prompts
// Params 0, eflags: 0x4
// Checksum 0x4b356d36, Offset: 0x4e30
// Size: 0x766
function private function_e8006b47()
{
    self endon( #"death", #"all_prompts_removed", #"hash_17cbfac9e551855a" );
    level endon( #"level_restarting" );
    player = getplayers()[ 0 ];
    
    if ( self != player )
    {
        player endon( #"death" );
    }
    
    if ( !isdefined( self.var_3e95b88f.var_db58523e ) )
    {
        self function_a6104953();
    }
    
    waitframe( 1 );
    uid = self.var_3e95b88f.uid;
    state = 0;
    var_6dbb4310 = 0;
    self.var_3e95b88f.var_98fa5077 = 1;
    
    while ( self.var_3e95b88f.var_98fa5077 )
    {
        var_bc26f34b = 0;
        var_e24c19de = 0;
        old_state = state;
        dist = 0;
        var_4921a894 = 0;
        var_b6a8b668 = 0;
        
        if ( self != player )
        {
            var_393b6e18 = self function_334e020();
            var_7f3f225e = player getplayercamerapos();
            dist = distance( var_7f3f225e, var_393b6e18 );
            self.var_3e95b88f.var_98fa5077 = 0;
            
            /#
                if ( level.var_a48f9f79[ #"hash_a1f059a85f5bed3" ] != 0 )
                {
                    print3d( var_393b6e18, "<dev string:x341>", ( 0, 0, 1 ), undefined, undefined, undefined, 1 );
                }
            #/
        }
        
        foreach ( prompt, var_62bce5b6 in self.var_3e95b88f.prompts )
        {
            self function_263b3850( uid, prompt );
            var_62bce5b6.old_state = var_62bce5b6.state;
            reset_interaction = 1;
            
            if ( self function_d626d354( prompt, player, dist - 12 ) )
            {
                var_bc26f34b = 1;
                
                if ( var_62bce5b6.state == 3 )
                {
                    var_e24c19de = 1;
                    continue;
                }
                
                var_5e83875a = var_62bce5b6.var_5e83875a;
                
                if ( var_62bce5b6.state != 0 && var_62bce5b6.state != 4 )
                {
                    var_5e83875a += var_62bce5b6.var_7faab93d;
                }
                
                if ( function_12186571( prompt, var_62bce5b6, player, dist, var_393b6e18, var_5e83875a ) )
                {
                    var_e24c19de = 1;
                    var_a33acc5d = self function_6b2492cb( prompt, var_62bce5b6, player );
                    reset_interaction = !var_a33acc5d.var_9ad09916;
                    var_4921a894 = var_4921a894 || var_a33acc5d.var_4921a894;
                    var_b6a8b668 = var_b6a8b668 || var_a33acc5d.var_b6a8b668;
                }
                else if ( var_62bce5b6.flags & 2 )
                {
                    var_62bce5b6.state = 4;
                }
                else
                {
                    var_62bce5b6.state = 0;
                }
            }
            else
            {
                if ( var_62bce5b6.state == 0 || var_62bce5b6.state == 4 )
                {
                    reset_interaction = 0;
                }
                
                var_62bce5b6.state = 0;
            }
            
            if ( ( var_62bce5b6.state == 0 || var_62bce5b6.state == 4 ) && player.var_b3c804a4[ prompt ] === self )
            {
                player.var_b3c804a4[ prompt ] = undefined;
            }
            
            if ( reset_interaction )
            {
                self function_9309081b( uid, prompt );
            }
            
            if ( var_62bce5b6.old_state != var_62bce5b6.state )
            {
                self function_f4bf235a( uid, prompt, self.var_3e95b88f.prompts[ prompt ].state );
            }
        }
        
        if ( var_e24c19de )
        {
            state = 3;
        }
        else if ( var_bc26f34b )
        {
            state = 2;
        }
        else if ( self.var_3e95b88f.var_98fa5077 )
        {
            state = 1;
        }
        else
        {
            break;
        }
        
        if ( old_state != state )
        {
            scripted_widgets::set_state( uid, state );
            
            if ( isdefined( self.var_3e95b88f.var_b003a020 ) )
            {
                if ( state == 2 )
                {
                    scripted_widgets::set_alpha( self.var_3e95b88f.var_b003a020, 0.9 );
                }
                else
                {
                    scripted_widgets::set_alpha( self.var_3e95b88f.var_b003a020, 0 );
                }
            }
        }
        
        if ( var_6dbb4310 != var_4921a894 )
        {
            var_6dbb4310 = var_4921a894;
            self notify( #"hash_5ede0284920c4c56", { #interactable:var_4921a894 } );
        }
        
        if ( self flag::get( #"hash_305ce4d5b74a637a" ) != var_b6a8b668 )
        {
            if ( var_b6a8b668 )
            {
                player val::set( #"hash_599ec0eee77657ef", "disable_usability", 1 );
                player flag::set( #"hash_599ec0eee77657ef" );
                self flag::set( #"hash_305ce4d5b74a637a" );
            }
            else
            {
                player val::reset( #"hash_599ec0eee77657ef", "disable_usability" );
                player flag::clear( #"hash_599ec0eee77657ef" );
                self flag::clear( #"hash_305ce4d5b74a637a" );
            }
        }
        
        waitframe( 1 );
    }
}

// Namespace prompts/prompts
// Params 3, eflags: 0x4
// Checksum 0x27ceb1e7, Offset: 0x55a0
// Size: 0x204
function private function_6b2492cb( prompt, var_62bce5b6, player )
{
    player.var_b3c804a4[ prompt ] = self;
    var_62bce5b6.state = 1;
    lower = 0;
    hud = self.var_3e95b88f.hud;
    
    /#
        if ( level.var_a48f9f79[ #"hash_464a6e9e035a826e" ] > 0 )
        {
            hud = 1;
        }
        else if ( level.var_a48f9f79[ #"hash_464a6e9e035a826e" ] < 0 )
        {
            hud = 0;
        }
    #/
    
    if ( hud )
    {
        lower = var_62bce5b6.flags & 1;
        
        /#
            if ( level.var_a48f9f79[ #"hash_464a6e9e035a826e" ] == 2 )
            {
                lower = 0;
            }
            else if ( level.var_a48f9f79[ #"hash_464a6e9e035a826e" ] == 3 )
            {
                lower = 1;
            }
        #/
    }
    
    var_9ad09916 = 0;
    
    if ( self [[ level.prompts[ prompt ].var_92bb1cb1 ]]( { #prompt:prompt, #var_62bce5b6:var_62bce5b6, #player:player } ) && !is_true( var_62bce5b6.var_5a8a10f2 ) )
    {
        self function_fcef5f5b( prompt, var_62bce5b6, player );
        var_9ad09916 = 1;
    }
    
    return { #var_9ad09916:var_9ad09916, #var_b6a8b668:lower, #var_4921a894:hud && !lower };
}

// Namespace prompts/prompts
// Params 3, eflags: 0x4
// Checksum 0x5b325d3e, Offset: 0x57b0
// Size: 0x24c
function private function_fcef5f5b( prompt, var_62bce5b6, player )
{
    if ( is_true( var_62bce5b6.var_f14d06ca ) )
    {
        if ( isdefined( var_62bce5b6.var_c570a6f9 ) )
        {
            var_62bce5b6.var_c570a6f9 += float( function_60d95f53() ) / 1000;
        }
        
        return;
    }
    
    var_62bce5b6.var_5a8a10f2 = undefined;
    
    if ( !isdefined( var_62bce5b6.var_c570a6f9 ) )
    {
        var_62bce5b6.var_c570a6f9 = gettime();
    }
    
    if ( !player gamepadusedlast() && var_62bce5b6.var_de6f0004 <= level.var_503dffcb[ #"cg_cpmaxholddurationignore" ] )
    {
        var_62bce5b6.state = 2;
        self function_efb98d80( prompt, var_62bce5b6, player );
        return;
    }
    
    if ( gettime() - var_62bce5b6.var_c570a6f9 >= var_62bce5b6.var_4ac77177 )
    {
        var_62bce5b6.state = 2;
        pct = var_62bce5b6.var_de6f0004 < 0 ? 1 : 0;
        
        if ( pct < 1 )
        {
            pct = math::clamp( ( gettime() - var_62bce5b6.var_c570a6f9 - var_62bce5b6.var_4ac77177 ) / var_62bce5b6.var_de6f0004, 0, 1 );
        }
        
        scripted_widgets::function_f2a9266( self.var_3e95b88f.uid, self.var_3e95b88f.var_294a441e[ prompt ], "fraction", pct, self.var_3e95b88f.var_db58523e );
        
        if ( pct >= 1 )
        {
            self function_efb98d80( prompt, var_62bce5b6, player );
        }
    }
}

// Namespace prompts/prompts
// Params 3, eflags: 0x4
// Checksum 0xe3289517, Offset: 0x5a08
// Size: 0x2bc
function private function_efb98d80( prompt, var_62bce5b6, player )
{
    var_1df3804c = isdefined( var_62bce5b6.var_1df3804c ) ? var_62bce5b6.var_1df3804c : self;
    var_1df3804c notify( "interactive_prompt_" + prompt );
    var_1df3804c notify( #"interact", { #prompt:prompt, #player:player } );
    bb::function_a0d15803( var_62bce5b6.prompt_text, self function_334e020(), player );
    
    if ( prompt == #"use" )
    {
        player function_58b29f4f();
    }
    
    if ( isdefined( level.prompts[ prompt ].notify_string ) )
    {
        var_1df3804c notify( level.prompts[ prompt ].notify_string, { #activator:player, #prompt:prompt } );
    }
    
    if ( isdefined( var_62bce5b6.notify_string ) )
    {
        var_1df3804c notify( var_62bce5b6.notify_string );
    }
    
    if ( isdefined( var_62bce5b6.complete_callback ) )
    {
        var_1df3804c thread [[ var_62bce5b6.complete_callback ]]( { #prompt:prompt, #player:player } );
    }
    
    if ( !is_true( var_62bce5b6.removing ) )
    {
        var_62bce5b6.state = 3;
        endons = [ "all_prompts_removed", "death" ];
        
        if ( var_62bce5b6.var_be77841a )
        {
            self thread util::delay( 0.25, endons, &remove, prompt );
            return;
        }
        
        var_62bce5b6.var_5a8a10f2 = 1;
        endons[ endons.size ] = "prompt_removed_" + prompt;
        self thread util::delay( 0.25, endons, &function_f4bf235a, self.var_3e95b88f.uid, prompt, 0 );
    }
}

// Namespace prompts/prompts
// Params 3, eflags: 0x4
// Checksum 0x81a1735a, Offset: 0x5cd0
// Size: 0x13c
function private function_f4bf235a( uid, prompt, state )
{
    if ( is_true( self.var_3e95b88f.prompts[ prompt ].removing ) )
    {
        return;
    }
    
    if ( isdefined( self.var_3e95b88f.prompts[ prompt ] ) )
    {
        self.var_3e95b88f.prompts[ prompt ].state = state;
    }
    
    self notify( #"hash_4de92efaa3e2025e", { #prompt:prompt, #state:state } );
    
    if ( isdefined( self.var_3e95b88f.var_294a441e[ prompt ] ) && isdefined( self.var_3e95b88f.uid ) )
    {
        scripted_widgets::function_f2a9266( uid, self.var_3e95b88f.var_294a441e[ prompt ], "state", state, self.var_3e95b88f.var_db58523e );
    }
}

// Namespace prompts/prompts
// Params 2, eflags: 0x4
// Checksum 0x296e137c, Offset: 0x5e18
// Size: 0xbc
function private function_9309081b( uid, prompt )
{
    if ( isdefined( self.var_3e95b88f.prompts[ prompt ].var_c570a6f9 ) )
    {
        self.var_3e95b88f.prompts[ prompt ].var_5a8a10f2 = undefined;
        self.var_3e95b88f.prompts[ prompt ].var_c570a6f9 = undefined;
        scripted_widgets::function_f2a9266( uid, self.var_3e95b88f.var_294a441e[ prompt ], "fraction", 0, self.var_3e95b88f.var_db58523e );
    }
}

// Namespace prompts/prompts
// Params 2, eflags: 0x4
// Checksum 0x666ccc5f, Offset: 0x5ee0
// Size: 0x244
function private function_ab46a161( prompt, var_62bce5b6 )
{
    self endon( #"death", "prompt_removed_" + prompt );
    player = getplayers()[ 0 ];
    player endon( #"death" );
    var_1ea21098 = undefined;
    uid = var_62bce5b6.uid;
    
    while ( isdefined( var_62bce5b6.uid ) )
    {
        is_disabled = isdefined( var_62bce5b6.prompts[ prompt ].state ) && ( var_62bce5b6.prompts[ prompt ].state == 0 || var_62bce5b6.prompts[ prompt ].state == 4 );
        
        if ( self [[ level.prompts[ prompt ].var_92bb1cb1 ]]( { #prompt:prompt, #var_62bce5b6:var_62bce5b6, #player:player } ) && ( is_true( var_62bce5b6.prompts[ prompt ].var_f14d06ca ) || is_disabled ) )
        {
            self function_2e6d74f5( prompt, 1 );
        }
        else
        {
            self function_2e6d74f5( prompt, 0 );
        }
        
        if ( var_1ea21098 !== is_disabled )
        {
            if ( is_disabled )
            {
                function_17578ab7( prompt, var_62bce5b6 );
            }
            else
            {
                function_f619081c( prompt, var_62bce5b6 );
            }
            
            var_1ea21098 = is_disabled;
        }
        
        waitframe( 1 );
    }
    
    if ( isdefined( uid ) && !is_true( var_1ea21098 ) )
    {
        function_17578ab7( prompt, var_62bce5b6, uid );
    }
}

// Namespace prompts/prompts
// Params 3, eflags: 0x4
// Checksum 0xbbba16fd, Offset: 0x6130
// Size: 0x138
function private function_6d9e6b7d( player, prompt, uid )
{
    player endon( #"death" );
    self endon( #"hash_1316225507a4f1bb", "reset_button_inputs_" + prompt );
    
    while ( true )
    {
        player waittill( #"weapon_fired" );
        weapon = player getcurrentweapon();
        
        if ( is_true( weapon.isboltaction ) || player getweaponammoclip( weapon ) == 0 && player getweaponammostock( weapon ) > 0 )
        {
            player val::reset( uid, "disable_weapon_reload" );
            wait 0.5;
            player val::set( uid, "disable_weapon_reload", 1 );
        }
    }
}

// Namespace prompts/prompts
// Params 2, eflags: 0x4
// Checksum 0xa7bd1f66, Offset: 0x6270
// Size: 0x49a
function private function_f619081c( prompt, var_62bce5b6 )
{
    player = getplayers()[ 0 ];
    
    switch ( prompt )
    {
        case #"use":
            player val::set( var_62bce5b6.uid, "disable_usability", 1 );
            
            if ( player gamepadusedlast() )
            {
                player val::set( var_62bce5b6.uid, "disable_weapon_reload", 1 );
                self thread function_6d9e6b7d( player, prompt, var_62bce5b6.uid );
            }
            
            break;
        case #"melee_hold":
        case #"melee":
            player val::set( var_62bce5b6.uid, "allow_melee", 0 );
            break;
        case #"attack":
            player val::set( var_62bce5b6.uid, "disable_weapon_fire", 1 );
            break;
        case #"reload":
            player val::set( var_62bce5b6.uid, "disable_weapon_reload", 1 );
            self thread function_6d9e6b7d( player, prompt, var_62bce5b6.uid );
            
            if ( player gamepadusedlast() )
            {
                player val::set( var_62bce5b6.uid, "disable_usability", 1 );
            }
            
            break;
        case #"frag":
            player val::set( var_62bce5b6.uid, "disable_offhand_weapons", 1 );
            break;
        case #"stance":
            stance = player getstance();
            
            if ( stance == "stand" )
            {
                player val::set( var_62bce5b6.uid, "allow_stand", 1 );
                player val::set( var_62bce5b6.uid, "allow_crouch", 0 );
                player val::set( var_62bce5b6.uid, "allow_prone", 0 );
            }
            else if ( stance == "crouch" )
            {
                player val::set( var_62bce5b6.uid, "allow_stand", 0 );
                player val::set( var_62bce5b6.uid, "allow_crouch", 1 );
                player val::set( var_62bce5b6.uid, "allow_prone", 0 );
            }
            else if ( stance == "prone" )
            {
                player val::set( var_62bce5b6.uid, "allow_stand", 0 );
                player val::set( var_62bce5b6.uid, "allow_crouch", 0 );
                player val::set( var_62bce5b6.uid, "allow_prone", 1 );
            }
            
            break;
        case #"weapnext":
            player val::set( var_62bce5b6.uid, "disable_weapon_cycling", 1 );
            break;
        case #"ads":
            player val::set( var_62bce5b6.uid, "allow_ads", 0 );
            break;
    }
}

// Namespace prompts/prompts
// Params 3, eflags: 0x4
// Checksum 0xab80a025, Offset: 0x6718
// Size: 0x414
function private function_17578ab7( prompt, var_62bce5b6, uid = var_62bce5b6.uid )
{
    player = getplayers()[ 0 ];
    
    if ( isdefined( uid ) && isdefined( player ) )
    {
        if ( !isdefined( prompt ) )
        {
            player val::reset_all( uid );
            self notify( #"hash_1316225507a4f1bb" );
            return;
        }
        
        switch ( prompt )
        {
            case #"use":
                player val::reset( uid, "disable_usability" );
                
                if ( player gamepadusedlast() )
                {
                    player val::reset( uid, "disable_weapon_reload" );
                }
                
                break;
            case #"melee_hold":
            case #"melee":
                player val::reset( uid, "allow_melee" );
                break;
            case #"attack":
                player val::reset( uid, "disable_weapon_fire" );
                break;
            case #"reload":
                player val::reset( uid, "disable_weapon_reload" );
                
                if ( player gamepadusedlast() )
                {
                    player val::reset( uid, "disable_usability" );
                }
                
                break;
            case #"frag":
                player val::reset( uid, "disable_offhand_weapons" );
                break;
            case #"stance":
                stance = player getstance();
                
                if ( stance == "stand" )
                {
                    player val::reset( uid, "allow_stand" );
                    player val::reset( uid, "allow_crouch" );
                    player val::reset( uid, "allow_prone" );
                }
                else if ( stance == "crouch" )
                {
                    player val::reset( uid, "allow_stand" );
                    player val::reset( uid, "allow_crouch" );
                    player val::reset( uid, "allow_prone" );
                }
                else if ( stance == "prone" )
                {
                    player val::reset( uid, "allow_stand" );
                    player val::reset( uid, "allow_crouch" );
                    player val::reset( uid, "allow_prone" );
                }
                
                break;
            case #"weapnext":
                player val::reset( uid, "disable_weapon_cycling" );
                break;
            case #"ads":
                player val::reset( uid, "allow_ads" );
                break;
        }
        
        self notify( "reset_button_inputs_" + prompt );
    }
}

// Namespace prompts/prompts
// Params 0, eflags: 0x4
// Checksum 0xd3a3ee1f, Offset: 0x6b38
// Size: 0x55c
function private function_a6104953()
{
    if ( !isdefined( level.var_f4f784c9 ) )
    {
        level.var_f4f784c9 = 0;
    }
    
    if ( !isdefined( self.var_3e95b88f.var_9215353e ) )
    {
        self.var_3e95b88f.var_9215353e = "prompt_" + level.var_f4f784c9;
        level.var_f4f784c9++;
    }
    
    self.var_3e95b88f.uid = self.var_3e95b88f.var_9215353e;
    uid = self.var_3e95b88f.uid;
    var_3a6b0af4 = undefined;
    clamp = 1;
    hud = self.var_3e95b88f.hud;
    
    /#
        if ( level.var_a48f9f79[ #"hash_464a6e9e035a826e" ] > 0 )
        {
            hud = 1;
        }
        else if ( level.var_a48f9f79[ #"hash_464a6e9e035a826e" ] < 0 )
        {
            hud = 0;
        }
    #/
    
    if ( hud )
    {
        scripted_widgets::create( uid, #"hash_2a9f8d08dadef41e" );
        self thread function_17533001( uid );
        
        if ( isentity( self ) )
        {
            self thread scripted_widgets::delete_on_death( uid );
        }
        
        if ( !is_true( self.var_3e95b88f.var_a5ce465f ) && !isplayer( self ) && ( !isactor( self ) || isdefined( self.var_3e95b88f.prompts[ #"use" ] ) ) )
        {
            self.var_3e95b88f.var_b003a020 = uid + "_circle";
            var_3a6b0af4 = self.var_3e95b88f.var_b003a020;
            clamp = 0;
            scripted_widgets::create( var_3a6b0af4, #"hash_28d1565bae3236e" );
            scripted_widgets::function_309bf7c2( var_3a6b0af4, #"uie_ui_icon_cp_interact_circle_outer" );
            scripted_widgets::set_width( var_3a6b0af4, 36 );
            scripted_widgets::set_height( var_3a6b0af4, 36 );
            scripted_widgets::set_alpha( var_3a6b0af4, 0.9 );
            scripted_widgets::set_scale( var_3a6b0af4, 0.9 );
            scripted_widgets::set_color( var_3a6b0af4, 0.85, 0.85, 0.85 );
        }
    }
    else
    {
        scripted_widgets::create( uid, #"hash_57fd5ecbc8126b21" );
        var_3a6b0af4 = uid;
    }
    
    if ( isdefined( var_3a6b0af4 ) )
    {
        scripted_widgets::set_ent( var_3a6b0af4, self );
        offset = isdefined( self.var_3e95b88f.offset ) ? self.var_3e95b88f.offset : ( 0, 0, 0 );
        
        if ( !self function_5a11b8f6() )
        {
            offset += self.origin;
            self.var_3e95b88f.var_80778410 = 0;
        }
        
        if ( offset != ( 0, 0, 0 ) )
        {
            if ( offset[ 0 ] != 0 )
            {
                scripted_widgets::function_4d9fbc9d( var_3a6b0af4, offset[ 0 ] );
            }
            
            if ( offset[ 1 ] != 0 )
            {
                scripted_widgets::function_52dbc715( var_3a6b0af4, offset[ 1 ] );
            }
            
            if ( offset[ 2 ] != 0 )
            {
                scripted_widgets::function_60856268( var_3a6b0af4, offset[ 2 ] );
            }
        }
        
        scripted_widgets::function_e648abd8( var_3a6b0af4, is_true( self.var_3e95b88f.var_754bedbb ) );
        scripted_widgets::function_9c3ced73( var_3a6b0af4, self.var_3e95b88f.var_80778410 );
        scripted_widgets::function_eb16868b( var_3a6b0af4, 1 );
        scripted_widgets::function_4ef79fca( var_3a6b0af4, clamp );
    }
    
    scripted_widgets::function_b1e6d7a8( uid, 0 );
    scripted_widgets::set_state( uid, 0 );
    scripted_widgets::function_330981ed( uid );
}

// Namespace prompts/prompts
// Params 2, eflags: 0x4
// Checksum 0x6303b448, Offset: 0x70a0
// Size: 0x494
function private function_263b3850( uid, prompt )
{
    if ( !scripted_widgets::function_cd59371c( uid, self.var_3e95b88f.var_294a441e[ prompt ], self.var_3e95b88f.var_db58523e ) && !is_true( self.var_3e95b88f.prompts[ prompt ].removing ) )
    {
        var_7125b341 = 0;
        
        if ( isdefined( self.var_3e95b88f.prompts[ prompt ].prompt_text ) )
        {
            scripted_widgets::function_f2a9266( uid, self.var_3e95b88f.var_294a441e[ prompt ], "text", self.var_3e95b88f.prompts[ prompt ].prompt_text, self.var_3e95b88f.var_db58523e );
            var_7125b341 = 1;
        }
        
        if ( isdefined( level.prompts[ prompt ].button_text ) )
        {
            if ( ispc() && isdefined( level.prompts[ prompt ].var_e4c7b05f ) )
            {
                self thread function_93551c9a( uid, prompt );
            }
            else
            {
                scripted_widgets::function_f2a9266( uid, self.var_3e95b88f.var_294a441e[ prompt ], "button_text", level.prompts[ prompt ].button_text, self.var_3e95b88f.var_db58523e );
            }
            
            var_7125b341 = 1;
        }
        
        if ( isdefined( level.prompts[ prompt ].button_action ) )
        {
            scripted_widgets::function_f2a9266( uid, self.var_3e95b88f.var_294a441e[ prompt ], "button_action", level.prompts[ prompt ].button_action, self.var_3e95b88f.var_db58523e );
            var_7125b341 = 1;
        }
        
        if ( isdefined( self.var_3e95b88f.prompts[ prompt ].var_de6f0004 ) && self.var_3e95b88f.prompts[ prompt ].var_de6f0004 > 0 )
        {
            scripted_widgets::function_f2a9266( uid, self.var_3e95b88f.var_294a441e[ prompt ], "fraction", 0, self.var_3e95b88f.var_db58523e );
        }
        
        if ( var_7125b341 )
        {
            scripted_widgets::function_f2a9266( uid, self.var_3e95b88f.var_294a441e[ prompt ], "state", self.var_3e95b88f.prompts[ prompt ].state, self.var_3e95b88f.var_db58523e );
        }
        
        flags = self.var_3e95b88f.prompts[ prompt ].flags;
        
        /#
            if ( level.var_a48f9f79[ #"hash_464a6e9e035a826e" ] == 2 )
            {
                flags &= ~1;
            }
            else if ( level.var_a48f9f79[ #"hash_464a6e9e035a826e" ] == 3 )
            {
                flags |= 1;
            }
        #/
        
        scripted_widgets::function_9bc1d2f1( uid, self.var_3e95b88f.var_294a441e[ prompt ], flags, 1, "flags", self.var_3e95b88f.var_db58523e );
        
        if ( isdefined( level.prompts[ prompt ].var_9a98e590 ) )
        {
            self thread [[ level.prompts[ prompt ].var_9a98e590 ]]( prompt, self.var_3e95b88f );
        }
    }
}

// Namespace prompts/prompts
// Params 0, eflags: 0x4
// Checksum 0x4e4013a0, Offset: 0x7540
// Size: 0x13e
function private function_8de9a77a()
{
    scripted_widgets::remove( self.var_3e95b88f.uid );
    
    if ( isdefined( self.var_3e95b88f.var_b003a020 ) )
    {
        scripted_widgets::remove( self.var_3e95b88f.var_b003a020 );
        self.var_3e95b88f.var_b003a020 = undefined;
    }
    
    if ( self flag::get( #"hash_305ce4d5b74a637a" ) )
    {
        self flag::clear( #"hash_305ce4d5b74a637a" );
        player = getplayers()[ 0 ];
        player flag::clear( #"hash_599ec0eee77657ef" );
        player val::reset( #"hash_599ec0eee77657ef", "disable_usability" );
    }
    
    self notify( #"hash_7d3af7cbbc793b23" );
    self.var_3e95b88f.uid = undefined;
}

// Namespace prompts/prompts
// Params 2, eflags: 0x4
// Checksum 0xec9f5cf3, Offset: 0x7688
// Size: 0x1a0
function private function_93551c9a( uid, prompt )
{
    self endon( #"death", "prompt_removed_" + prompt, #"hash_7d3af7cbbc793b23" );
    player = getplayers()[ 0 ];
    player endon( #"death" );
    gamepad = player gamepadusedlast();
    button_text[ 0 ] = level.prompts[ prompt ].var_e4c7b05f;
    button_text[ 1 ] = level.prompts[ prompt ].button_text;
    scripted_widgets::function_f2a9266( uid, self.var_3e95b88f.var_294a441e[ prompt ], "button_text", button_text[ gamepad ], self.var_3e95b88f.var_db58523e );
    
    while ( true )
    {
        waitframe( 1 );
        
        if ( gamepad != player gamepadusedlast() )
        {
            gamepad = !gamepad;
            scripted_widgets::function_f2a9266( uid, self.var_3e95b88f.var_294a441e[ prompt ], "button_text", button_text[ gamepad ], self.var_3e95b88f.var_db58523e );
        }
    }
}

// Namespace prompts/prompts
// Params 1, eflags: 0x4
// Checksum 0xaa0c583e, Offset: 0x7830
// Size: 0x2b0
function private function_17533001( uid )
{
    self endoncallback( &function_74f42405, #"death", #"all_prompts_removed", #"hash_7d3af7cbbc793b23" );
    level endon( #"level_restarting" );
    actor_name = isdefined( self.var_3e95b88f.display_name ) ? self.var_3e95b88f.display_name : self function_7f0363e8();
    var_2d3f59fc = isdefined( self.var_3e95b88f.team ) ? self.var_3e95b88f.team : util::getteamindex( self getteam() );
    
    if ( actor_name === "" )
    {
        actor_name = undefined;
    }
    
    while ( true )
    {
        ret = self waittill( #"hash_5ede0284920c4c56" );
        
        if ( ret.interactable )
        {
            if ( isdefined( self.var_3e95b88f.image ) )
            {
                scripted_widgets::function_309bf7c2( uid, self.var_3e95b88f.image );
                scripted_widgets::function_b1e6d7a8( uid, isdefined( self.var_3e95b88f.var_fc01e65d ) ? self.var_3e95b88f.var_fc01e65d : 0 );
                self globallogic_ui::function_ec25f500( " ", 0 );
            }
            else if ( isdefined( actor_name ) )
            {
                self globallogic_ui::function_ec25f500( actor_name, var_2d3f59fc );
            }
            
            continue;
        }
        
        if ( isdefined( self.var_3e95b88f.image ) )
        {
            scripted_widgets::function_309bf7c2( uid, #"" );
            scripted_widgets::function_b1e6d7a8( uid, 0 );
            self globallogic_ui::function_109202c3();
            continue;
        }
        
        if ( isdefined( actor_name ) )
        {
            self globallogic_ui::function_109202c3();
        }
    }
}

// Namespace prompts/prompts
// Params 1, eflags: 0x4
// Checksum 0xddf484d8, Offset: 0x7ae8
// Size: 0x24
function private function_74f42405( *end_on )
{
    self globallogic_ui::function_109202c3();
}

// Namespace prompts/prompts
// Params 0, eflags: 0x4
// Checksum 0x618ff9b4, Offset: 0x7b18
// Size: 0x58, Type: bool
function private function_5a11b8f6()
{
    if ( isstruct( self ) || self.classname === "script_origin" || isplayer( self ) )
    {
        return false;
    }
    
    return true;
}

