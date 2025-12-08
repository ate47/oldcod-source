#using script_1162c195eb8dd834;
#using script_71527a5629b857da;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;

#namespace smart_bundle;

// Namespace smart_bundle/smart_bundle
// Params 0, eflags: 0x6
// Checksum 0xc5c0c56e, Offset: 0xf8
// Size: 0x4c
function private autoexec __init__system__()
{
    system::register( #"smart_bundle", &preinit, &function_fcaaa05f, undefined, undefined );
}

// Namespace smart_bundle/smart_bundle
// Params 0, eflags: 0x4
// Checksum 0x101b07da, Offset: 0x150
// Size: 0x1c
function private preinit()
{
    flag::init( "smart_bundle_initialized" );
}

// Namespace smart_bundle/smart_bundle
// Params 0
// Checksum 0x3656e8d2, Offset: 0x178
// Size: 0x134
function function_fcaaa05f()
{
    if ( isdefined( level.smart_bundle ) )
    {
        return;
    }
    
    sb_flags();
    callback::function_f642faf2( &function_2264f2c4 );
    level.smart_bundle = spawnstruct();
    level.smart_bundle.var_84410238 = [];
    level.smart_bundle.spawned_axis = [];
    level.smart_bundle.spawnq = [];
    level.smart_bundle.spawnq_next = 0;
    level.smart_bundle.unique_id = 0;
    level.smart_bundle gather_sb();
    level.smart_bundle thread sb_tick();
    level.smart_bundle thread function_4e82b483();
    waitframe( 3 );
    flag::set( "smart_bundle_initialized" );
}

// Namespace smart_bundle/smart_bundle
// Params 1
// Checksum 0x5d100e4e, Offset: 0x2b8
// Size: 0x170
function function_8dcff833( var_8a673bc9 )
{
    ret = [];
    
    if ( !isdefined( var_8a673bc9 ) )
    {
        var_8a673bc9 = [];
    }
    else if ( !isarray( var_8a673bc9 ) )
    {
        var_8a673bc9 = array( var_8a673bc9 );
    }
    
    foreach ( tname in var_8a673bc9 )
    {
        for ( i = 0; i < level.smart_bundle.var_84410238.size ; i++ )
        {
            if ( isdefined( level.smart_bundle.var_84410238[ i ].targetname ) && level.smart_bundle.var_84410238[ i ].targetname == tname )
            {
                ret[ ret.size ] = level.smart_bundle.var_84410238[ i ];
            }
        }
    }
    
    return ret;
}

// Namespace smart_bundle/smart_bundle
// Params 1
// Checksum 0xf33b81eb, Offset: 0x430
// Size: 0x94
function function_6c12ff6( var_63fded14 )
{
    var_84410238 = function_8dcff833( var_63fded14 );
    assert( var_84410238.size <= 1, "<dev string:x38>" + var_84410238.size + "<dev string:x46>" + var_63fded14 + "<dev string:x69>" );
    
    if ( var_84410238.size == 0 )
    {
        return undefined;
    }
    
    return var_84410238[ 0 ];
}

// Namespace smart_bundle/smart_bundle
// Params 0
// Checksum 0x49e0a37c, Offset: 0x4d0
// Size: 0x4c
function function_764d4b74()
{
    if ( isdefined( self.var_38a97b32 ) && level flag::get( self.var_38a97b32 ) )
    {
        level flag::clear( self.var_38a97b32 );
    }
}

// Namespace smart_bundle/smart_bundle
// Params 0
// Checksum 0xcc8cb432, Offset: 0x528
// Size: 0x5c
function function_d57734f6()
{
    for ( i = 0; i < level.smart_bundle.var_84410238.size ; i++ )
    {
        level.smart_bundle.var_84410238[ i ] function_764d4b74();
    }
}

// Namespace smart_bundle/smart_bundle
// Params 0
// Checksum 0x7e063cf, Offset: 0x590
// Size: 0x14
function function_92da2014()
{
    function_d57734f6();
}

// Namespace smart_bundle/smart_bundle
// Params 2
// Checksum 0x696d906a, Offset: 0x5b0
// Size: 0xb8
function function_20ba1b43( var_63fded14, resume_flag )
{
    var_84410238 = function_8dcff833( var_63fded14 );
    
    foreach ( smart_bundle in var_84410238 )
    {
        smart_bundle function_69011beb( resume_flag );
    }
}

// Namespace smart_bundle/smart_bundle
// Params 1
// Checksum 0xae96ba6, Offset: 0x670
// Size: 0x8a
function function_69011beb( resume_flag )
{
    if ( !isdefined( self.variantname ) )
    {
        assert( isdefined( self.script_noteworthy ) && self.script_noteworthy == "<dev string:xb3>" );
    }
    else
    {
        assert( self.variantname == "<dev string:xb3>" );
    }
    
    self.var_38a97b32 = resume_flag;
}

// Namespace smart_bundle/smart_bundle
// Params 1
// Checksum 0xf977081c, Offset: 0x708
// Size: 0x12e
function function_f029622c( var_268d3aa4 )
{
    self endon( #"death" );
    self endon( #"hash_740faf03c1eeca5b" );
    
    if ( !( self.var_39a8d200 == "active" || self.var_39a8d200 == "wait_deactivate" ) )
    {
        self waittill( #"active" );
    }
    
    if ( !isdefined( var_268d3aa4 ) || var_268d3aa4 > self.var_f0a4c650.size )
    {
        var_268d3aa4 = self.var_f0a4c650.size;
    }
    
    while ( self.var_fe336ab9 < var_268d3aa4 )
    {
        self waittill( #"hash_7fafbdd20ef09362" );
        waittillframeend();
    }
    
    self notify( "smart_bundle_" + string( var_268d3aa4 ) + "_ai_killed" );
    
    if ( is_true( self.ai_respawn_until_all_dead ) )
    {
        self.var_2b96e535 = 0;
        self notify( #"hash_66e053d24034aa6f" );
    }
}

// Namespace smart_bundle/smart_bundle
// Params 0
// Checksum 0x360d1b89, Offset: 0x840
// Size: 0x96
function function_e47ac090()
{
    self endon( #"death" );
    self endon( #"hash_740faf03c1eeca5b" );
    
    if ( !( self.var_39a8d200 == "active" || self.var_39a8d200 == "wait_deactivate" ) )
    {
        self waittill( #"active" );
    }
    
    while ( self.dynamic_ents.size < self.var_f0a4c650.size )
    {
        self waittill( #"bundle_ai_spawned" );
    }
}

// Namespace smart_bundle/smart_bundle
// Params 3
// Checksum 0x1b726dbb, Offset: 0x8e0
// Size: 0x26a
function function_ee872d21( var_17736c1e, var_268d3aa4, var_1cbf40f = 1 )
{
    assert( isarray( var_17736c1e ), "<dev string:xc3>" );
    max_guys = 0;
    var_455a5bec = function_58ca92b7();
    remover_array = [];
    
    foreach ( smart_bundle in var_17736c1e )
    {
        smart_bundle endon( #"death" );
        smart_bundle endon( #"hash_740faf03c1eeca5b" );
        
        if ( !( smart_bundle.var_39a8d200 == "active" || smart_bundle.var_39a8d200 == "wait_deactivate" ) )
        {
            if ( !is_true( var_1cbf40f ) )
            {
                remover_array[ remover_array.size ] = smart_bundle;
                continue;
            }
            
            smart_bundle waittill( #"active" );
        }
        
        max_guys += smart_bundle.var_f0a4c650.size;
        smart_bundle thread function_ad087e3b( var_455a5bec );
    }
    
    if ( remover_array.size > 0 )
    {
        for ( i = 0; i < remover_array.size ; i++ )
        {
            arrayremovevalue( var_17736c1e, remover_array[ i ] );
        }
    }
    
    if ( !isdefined( var_268d3aa4 ) || var_268d3aa4 > max_guys )
    {
        var_268d3aa4 = max_guys;
    }
    
    while ( function_97118cde( var_17736c1e ) < var_268d3aa4 )
    {
        level waittill( var_455a5bec );
        waittillframeend();
    }
    
    level notify( var_455a5bec + "all_done" );
}

// Namespace smart_bundle/smart_bundle
// Params 1
// Checksum 0x9af4fc10, Offset: 0xb58
// Size: 0x68
function function_ad087e3b( var_455a5bec )
{
    level endon( var_455a5bec + "all_done" );
    self endon( #"death" );
    self endon( #"hash_740faf03c1eeca5b" );
    
    while ( true )
    {
        self waittill( #"hash_7fafbdd20ef09362" );
        level notify( var_455a5bec );
    }
}

// Namespace smart_bundle/smart_bundle
// Params 1
// Checksum 0x4a8a3ee3, Offset: 0xbc8
// Size: 0x54
function function_97118cde( var_17736c1e )
{
    tot = 0;
    
    for ( i = 0; i < var_17736c1e.size ; i++ )
    {
        tot += var_17736c1e[ i ].var_fe336ab9;
    }
    
    return tot;
}

// Namespace smart_bundle/smart_bundle
// Params 3
// Checksum 0xc4555b4a, Offset: 0xc28
// Size: 0x13c
function function_f059be95( set_flag, deadcount, timeout )
{
    self endon( #"death" );
    self endon( #"hash_740faf03c1eeca5b" );
    
    if ( !( self.var_39a8d200 == "active" || self.var_39a8d200 == "wait_deactivate" ) )
    {
        self waittill( #"active" );
    }
    
    if ( isdefined( timeout ) )
    {
        self thread function_a6169d61( timeout );
    }
    
    if ( !isdefined( deadcount ) || deadcount > self.var_f0a4c650.size )
    {
        deadcount = self.var_f0a4c650.size;
    }
    
    self thread function_f029622c( deadcount );
    wait_notify = "smart_bundle_" + string( deadcount ) + "_ai_killed";
    self waittill( wait_notify, #"hash_1951ecd22ca82373" );
    level flag::set( set_flag );
}

// Namespace smart_bundle/smart_bundle
// Params 4
// Checksum 0x5120e68c, Offset: 0xd70
// Size: 0x94
function function_5ce85259( var_84410238, set_flag, deadcount, timeout )
{
    self endon( #"death" );
    self endon( #"hash_740faf03c1eeca5b" );
    
    if ( isdefined( timeout ) )
    {
        self thread function_a6169d61( timeout );
    }
    
    function_ee872d21( var_84410238, deadcount );
    level flag::set( set_flag );
}

// Namespace smart_bundle/smart_bundle
// Params 1
// Checksum 0xad111b3a, Offset: 0xe10
// Size: 0x26
function function_a6169d61( timeout )
{
    wait timeout;
    self notify( #"hash_1951ecd22ca82373" );
}

// Namespace smart_bundle/smart_bundle
// Params 2
// Checksum 0xb40aef3f, Offset: 0xe40
// Size: 0xb4
function function_1ca38b11( state, callback_function )
{
    assert( array::contains( [ "<dev string:x11b>", "<dev string:x12c>", "<dev string:x13c>", "<dev string:x146>", "<dev string:x159>" ], state ), "<dev string:x168>" + state );
    self.fn_callbacks[ state ] = callback_function;
}

// Namespace smart_bundle/smart_bundle
// Params 0
// Checksum 0x451cd194, Offset: 0xf00
// Size: 0x22
function function_44cbaa85()
{
    function_1eaaceab( self.dynamic_ents );
    return self.dynamic_ents;
}

// Namespace smart_bundle/smart_bundle
// Params 1
// Checksum 0x56952372, Offset: 0xf30
// Size: 0xb6
function function_942bcdf6( var_84410238 )
{
    guys = [];
    
    foreach ( smart_bundle in var_84410238 )
    {
        guys = arraycombine( guys, smart_bundle function_44cbaa85(), 1, 0 );
    }
    
    return guys;
}

// Namespace smart_bundle/smart_bundle
// Params 0
// Checksum 0x7b81a131, Offset: 0xff0
// Size: 0x1a
function function_97506362()
{
    if ( isdefined( self.var_fe336ab9 ) )
    {
        return self.var_fe336ab9;
    }
    
    return 0;
}

// Namespace smart_bundle/smart_bundle
// Params 0
// Checksum 0x2fefd26b, Offset: 0x1018
// Size: 0x24
function function_39cfddef()
{
    if ( isdefined( self.var_f0a4c650 ) )
    {
        return self.var_f0a4c650.size;
    }
    
    return self.spawner_ents.size;
}

// Namespace smart_bundle/smart_bundle
// Params 1
// Checksum 0x71a3f2ba, Offset: 0x1048
// Size: 0xa8
function function_92f17667( var_17736c1e )
{
    total = 0;
    
    foreach ( smart_bundle in var_17736c1e )
    {
        total += smart_bundle function_39cfddef();
    }
    
    return total;
}

// Namespace smart_bundle/smart_bundle
// Params 0
// Checksum 0x86789bbc, Offset: 0x10f8
// Size: 0x4c
function function_1f7aae9e()
{
    total = self function_39cfddef();
    killed = self function_97506362();
    return total - killed;
}

// Namespace smart_bundle/smart_bundle
// Params 1
// Checksum 0xd3cde996, Offset: 0x1150
// Size: 0xda
function function_d96e9b9b( var_17736c1e )
{
    total = 0;
    total_killed = 0;
    
    foreach ( smart_bundle in var_17736c1e )
    {
        total += smart_bundle function_39cfddef();
        total_killed += smart_bundle function_97506362();
    }
    
    return total - total_killed;
}

// Namespace smart_bundle/smart_bundle
// Params 0
// Checksum 0xb289a3d6, Offset: 0x1238
// Size: 0x36, Type: bool
function function_79e04d7f()
{
    if ( self.var_39a8d200 == "wait_deactivate" || self.var_39a8d200 == "active" )
    {
        return true;
    }
    
    return false;
}

