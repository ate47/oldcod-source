#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace zipline;

// Namespace zipline/zipline
// Params 0, eflags: 0x6
// Checksum 0x1effd0d3, Offset: 0x210
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"zipline", &preinit, undefined, undefined, undefined );
}

// Namespace zipline/zipline
// Params 0, eflags: 0x4
// Checksum 0x5473527a, Offset: 0x258
// Size: 0x44
function private preinit()
{
    registerbehaviorscriptfunctions();
    spawner::add_archetype_spawn_function( #"human", &function_c4306be2 );
}

// Namespace zipline/zipline
// Params 0, eflags: 0x4
// Checksum 0x4e203974, Offset: 0x2a8
// Size: 0x774
function private registerbehaviorscriptfunctions()
{
    assert( isscriptfunctionptr( &isziplining ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"isziplining", &isziplining );
    assert( !isdefined( &function_8de15fec ) || isscriptfunctionptr( &function_8de15fec ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    behaviortreenetworkutility::registerbehaviortreeaction( #"hash_49592f95dd588bd6", &function_8de15fec, undefined, undefined );
    assert( isscriptfunctionptr( &function_dedfe444 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_7a881cd7648d875a", &function_dedfe444 );
    assert( !isdefined( &function_54e23559 ) || isscriptfunctionptr( &function_54e23559 ) );
    assert( !isdefined( &function_f5e4c85b ) || isscriptfunctionptr( &function_f5e4c85b ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    behaviortreenetworkutility::registerbehaviortreeaction( #"hash_7ce06449bd45e2fb", &function_54e23559, &function_f5e4c85b, undefined );
    assert( !isdefined( &function_8956c060 ) || isscriptfunctionptr( &function_8956c060 ) );
    assert( !isdefined( &function_c7c70177 ) || isscriptfunctionptr( &function_c7c70177 ) );
    assert( !isdefined( &function_11b30321 ) || isscriptfunctionptr( &function_11b30321 ) );
    behaviortreenetworkutility::registerbehaviortreeaction( #"hash_4bf47859e6047df4", &function_8956c060, &function_c7c70177, &function_11b30321 );
    assert( !isdefined( &function_b253aeb ) || isscriptfunctionptr( &function_b253aeb ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    behaviortreenetworkutility::registerbehaviortreeaction( #"hash_3ff2421a40181271", &function_b253aeb, undefined, undefined );
    assert( !isdefined( &function_dd8aadf1 ) || isscriptfunctionptr( &function_dd8aadf1 ) );
    assert( !isdefined( &function_28c69db4 ) || isscriptfunctionptr( &function_28c69db4 ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    behaviortreenetworkutility::registerbehaviortreeaction( #"hash_267af6f7a7ece24f", &function_dd8aadf1, &function_28c69db4, undefined );
    assert( !isdefined( &function_574f0280 ) || isscriptfunctionptr( &function_574f0280 ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    assert( !isdefined( &function_c0a3f837 ) || isscriptfunctionptr( &function_c0a3f837 ) );
    behaviortreenetworkutility::registerbehaviortreeaction( #"hash_666c4b85dd04d173", &function_574f0280, undefined, &function_c0a3f837 );
    animationstatenetwork::registernotetrackhandlerfunction( "zipline_attach_adjust_begin", &function_daabc8cc );
}

// Namespace zipline/zipline
// Params 0, eflags: 0x4
// Checksum 0xef4bb86a, Offset: 0xa28
// Size: 0x24
function private function_c4306be2()
{
    aiutility::addaioverridekilledcallback( self, &function_d271a025 );
}

// Namespace zipline/zipline
// Params 8, eflags: 0x4
// Checksum 0x8f3115f3, Offset: 0xa58
// Size: 0x384
function private function_d271a025( *inflictor, *attacker, *damage, *meansofdeath, *weapon, vdir, *hitloc, *offsettime )
{
    if ( isziplining( self ) && isdefined( self.var_b20b0960 ) && isdefined( offsettime ) && offsettime != ( 0, 0, 0 ) )
    {
        assert( -1 );
        var_dd20ed0e = anglestoforward( self.angles );
        var_ffcdd033 = self.var_b20b0960 getspeedmph();
        var_3c5c113f = self.team == #"allies" ? 35 : 25;
        var_e7a37ff1 = var_ffcdd033 / var_3c5c113f;
        var_c434d40d = lerpfloat( 50, 90, var_e7a37ff1 );
        
        if ( isdefined( self.var_b30ec151 ) && lengthsquared( self.var_b30ec151 ) > sqr( 150 ) )
        {
            var_b7cd5898 = vectordot( offsettime, var_dd20ed0e );
            
            if ( var_b7cd5898 < -0.707107 )
            {
                self setblackboardattribute( "_zipline_state", "ZIPLINE_DEATH_BACK" );
            }
            else
            {
                self forceteleport( self.origin, vectortoangles( offsettime * ( 1, 1, 0 ) * -1 ), 0, 0 );
                self setblackboardattribute( "_zipline_state", "ZIPLINE_DEATH_FORWARD" );
            }
        }
        
        self.var_576c1daf = vectornormalize( var_dd20ed0e * 0.7 + offsettime * 0.3 ) * var_c434d40d;
        
        if ( isdefined( level.var_ebc8a996 ) )
        {
            self [[ level.var_ebc8a996 ]]();
        }
    }
    
    if ( isdefined( self.var_a4d91a0d ) )
    {
        if ( self islinkedto( self.var_a4d91a0d ) )
        {
            self unlink();
        }
        
        self.var_a4d91a0d delete();
    }
    
    if ( isdefined( self.var_b20b0960 ) )
    {
        if ( self islinkedto( self.var_b20b0960 ) )
        {
            self unlink();
        }
        
        self.var_b20b0960 delete();
    }
    
    if ( isdefined( self.var_c6b02ec0 ) )
    {
        self.var_c6b02ec0 delete();
    }
}

// Namespace zipline/zipline
// Params 1, eflags: 0x4
// Checksum 0xb580cfe0, Offset: 0xde8
// Size: 0x22
function private isziplining( entity )
{
    return is_true( entity.is_ziplining );
}

// Namespace zipline/zipline
// Params 2, eflags: 0x4
// Checksum 0x373f5d85, Offset: 0xe18
// Size: 0xba
function private function_8de15fec( entity, asmstatename )
{
    var_35e9555d = entity getblackboardattribute( "_zipline_state" );
    var_7450b2ac = 0;
    
    if ( isdefined( entity.var_576c1daf ) && var_7450b2ac < 0 )
    {
        entity thread function_353ce30d( entity.var_576c1daf );
    }
    else
    {
        animationstatenetworkutility::requeststate( entity, asmstatename );
    }
    
    entity.var_29fb8dff = undefined;
    return 5;
}

// Namespace zipline/zipline
// Params 1, eflags: 0x4
// Checksum 0xfb4cc29b, Offset: 0xee0
// Size: 0x44
function private function_353ce30d( direction )
{
    self startragdoll();
    waitframe( 1 );
    self launchragdoll( direction );
}

// Namespace zipline/zipline
// Params 1, eflags: 0x4
// Checksum 0x610271c0, Offset: 0xf30
// Size: 0x90, Type: bool
function private function_dedfe444( entity )
{
    if ( isdefined( entity.traversestartnode ) && isdefined( entity.traversestartnode.script_noteworthy ) && entity.traversestartnode.script_noteworthy == "zipline_traversal" && isdefined( entity.traversestartnode.var_9a26509a ) && entity shouldstarttraversal() )
    {
        return true;
    }
    
    return false;
}

// Namespace zipline/zipline
// Params 0, eflags: 0x4
// Checksum 0xa668da4d, Offset: 0xfc8
// Size: 0x52
function private function_536ff6cf()
{
    self endon( #"death" );
    self.var_a4d91a0d = util::spawn_model( #"tag_origin", self.origin, self.angles );
}

// Namespace zipline/zipline
// Params 0, eflags: 0x4
// Checksum 0x2ae17259, Offset: 0x1028
// Size: 0x36
function private function_11a51c07()
{
    self endon( #"death" );
    self waittill( #"movedone" );
    self.var_4901b7db = 1;
}

// Namespace zipline/zipline
// Params 2, eflags: 0x4
// Checksum 0x39defab3, Offset: 0x1068
// Size: 0xb4
function private function_54e23559( entity, asmstatename )
{
    if ( !isdefined( entity.var_660aa59f ) )
    {
        entity.allowpain = 0;
        entity setblackboardattribute( "_zipline_state", "ZIPLINE_ATTACH" );
        animationstatenetworkutility::requeststate( entity, asmstatename );
        entity.var_a4d91a0d = undefined;
        entity thread function_536ff6cf();
        
        if ( isdefined( level.var_ab0a4e81 ) )
        {
            entity [[ level.var_ab0a4e81 ]]();
        }
    }
    
    return 5;
}

// Namespace zipline/zipline
// Params 0, eflags: 0x4
// Checksum 0xbcfac1a8, Offset: 0x1128
// Size: 0x64
function private function_6d7d599e()
{
    var_4fa6735c = function_4fa6735c();
    rotated_offset = rotatepoint( ( 0, 0, -72 ), var_4fa6735c );
    return self.zipline_start.origin + rotated_offset;
}

// Namespace zipline/zipline
// Params 0, eflags: 0x4
// Checksum 0x30dcab10, Offset: 0x1198
// Size: 0x72
function private function_4fa6735c()
{
    var_9f9bac58 = getvehiclenode( self.zipline_start.target, "targetname" );
    var_8bb667c1 = var_9f9bac58.origin - self.zipline_start.origin;
    return vectortoangles( var_8bb667c1 );
}

// Namespace zipline/zipline
// Params 1, eflags: 0x4
// Checksum 0x63354b04, Offset: 0x1218
// Size: 0x2bc
function private function_daabc8cc( entity )
{
    if ( isdefined( entity.var_a4d91a0d ) )
    {
        var_2ef73c01 = animationstatenetworkutility::searchanimationmap( entity, "anim_zipline_attach" );
        var_a02589c1 = getanimlength( var_2ef73c01 );
        var_e03d49ae = getnotetracktimes( var_2ef73c01, "zipline_attach_adjust_begin" );
        var_aae5bcce = getnotetracktimes( var_2ef73c01, "zipline_attach_adjust_end" );
        
        if ( var_e03d49ae.size > 0 && var_aae5bcce.size > 0 )
        {
            var_bcb2d560 = var_a02589c1 * var_e03d49ae[ 0 ];
            var_2b699b1b = var_a02589c1 * var_aae5bcce[ 0 ];
            move_time = var_2b699b1b - var_bcb2d560;
            var_6d7d599e = entity function_6d7d599e();
            var_4fa6735c = entity function_4fa6735c();
            
            /#
                record3dtext( "<dev string:x38>", var_6d7d599e, ( 0, 1, 0 ) );
                recordsphere( var_6d7d599e, 5, ( 0, 1, 0 ) );
                recordline( var_6d7d599e, var_6d7d599e + anglestoforward( entity.zipline_start.angles ) * 30, ( 0, 1, 0 ) );
                recordsphere( entity.var_a4d91a0d.origin, 5, ( 1, 0, 0 ) );
                recordline( entity.origin, entity.var_a4d91a0d.origin, ( 1, 0, 0 ) );
                recordline( entity.var_a4d91a0d.origin, var_6d7d599e, ( 1, 1, 0 ) );
            #/
            
            entity.var_a4d91a0d moveto( var_6d7d599e, move_time );
            entity.var_a4d91a0d rotateto( var_4fa6735c, move_time );
            entity.var_a4d91a0d thread function_11a51c07();
        }
    }
}

// Namespace zipline/zipline
// Params 2, eflags: 0x4
// Checksum 0x3ab3ddb9, Offset: 0x14e0
// Size: 0x234
function private function_f5e4c85b( entity, *asmstatename )
{
    result = 5;
    asmstatename notify( #"hash_4c1bc0b351b4a76f" );
    
    if ( isdefined( asmstatename.var_660aa59f ) )
    {
        asmstatename.zipline_start = getvehiclenode( asmstatename.traversestartnode.var_9a26509a, "targetname" );
        asmstatename.var_4be77411 = asmstatename.zipline_start.var_cf56bb8f.var_afbab71e;
        result = 4;
    }
    else if ( isdefined( asmstatename.var_a4d91a0d ) && !is_true( asmstatename.var_a4d91a0d.var_14e53eac ) )
    {
        asmstatename.zipline_start = getvehiclenode( asmstatename.traversestartnode.var_9a26509a, "targetname" );
        var_cf56bb8f = asmstatename.zipline_start.var_cf56bb8f;
        
        if ( is_true( var_cf56bb8f.var_1b1aded2 ) && isdefined( var_cf56bb8f.var_d9c9a508 ) && var_cf56bb8f.var_d9c9a508.size > 2 )
        {
            var_cf56bb8f function_63d01c33();
        }
        
        asmstatename.var_a4d91a0d.origin = self.origin;
        
        /#
            record3dtext( "<dev string:x61>", self.origin, ( 1, 0.5, 0 ), "<dev string:x8d>" );
        #/
        
        asmstatename linkto( asmstatename.var_a4d91a0d );
        asmstatename.var_a4d91a0d.var_14e53eac = 1;
    }
    
    if ( asmstatename asmgetstatus() == "asm_status_complete" )
    {
        result = 4;
    }
    
    return result;
}

// Namespace zipline/zipline
// Params 0, eflags: 0x4
// Checksum 0xb7ea79e6, Offset: 0x1720
// Size: 0x22c
function private function_85ce22b4()
{
    self endon( #"death" );
    self.var_b20b0960 = spawner::simple_spawn_single( getent( "veh_zipline", "targetname" ) );
    self.var_b20b0960.origin = self.zipline_start.origin;
    var_9f9bac58 = getvehiclenode( self.zipline_start.target, "targetname" );
    var_8bb667c1 = var_9f9bac58.origin - self.zipline_start.origin;
    self.var_b20b0960.angles = vectortoangles( var_8bb667c1 );
    
    if ( isdefined( self.var_e8f98e9d ) )
    {
        var_a7a79831 = length( var_8bb667c1 );
        var_b00e3ead = vectornormalize( var_8bb667c1 );
        self.var_b20b0960.var_da287758 = self.zipline_start.origin + var_b00e3ead * var_a7a79831 * self.var_e8f98e9d;
        self.var_e8f98e9d = undefined;
    }
    
    /#
        record3dtext( "<dev string:x97>", self.var_b20b0960.origin, ( 1, 0, 0 ) );
        recordsphere( self.var_b20b0960.origin, 5, ( 1, 0, 0 ) );
        recordline( self.var_b20b0960.origin, self.var_b20b0960.origin + anglestoforward( self.var_b20b0960.angles ) * 100, ( 1, 0, 0 ) );
    #/
}

// Namespace zipline/zipline
// Params 2, eflags: 0x4
// Checksum 0x444d6c07, Offset: 0x1958
// Size: 0xb0
function private function_8956c060( entity, asmstatename )
{
    entity setblackboardattribute( "_zipline_state", "ZIPLINE_IDLE" );
    animationstatenetworkutility::requeststate( entity, asmstatename );
    entity.is_ziplining = 1;
    entity.var_c681e4c1 = 1;
    entity notify( #"hash_65134449cd95c3cb" );
    entity.var_b30ec151 = ( 0, 0, 0 );
    entity.var_b20b0960 = undefined;
    entity thread function_85ce22b4();
    return 5;
}

// Namespace zipline/zipline
// Params 3, eflags: 0x4
// Checksum 0xea6f2e77, Offset: 0x1a10
// Size: 0xc4
function private function_55f3b1df( var_1948a97, zipline_start, normalized_distance )
{
    if ( normalized_distance < 0 )
    {
        normalized_distance = 0;
    }
    else if ( normalized_distance > 1 )
    {
        normalized_distance = 1;
    }
    
    var_4be77411 = zipline_start.var_cf56bb8f.var_afbab71e;
    var_a7a79831 = length( var_4be77411.origin - zipline_start.origin );
    distance = var_a7a79831 * normalized_distance;
    var_1948a97 function_ded6dd2e( zipline_start, distance );
}

// Namespace zipline/zipline
// Params 2, eflags: 0x4
// Checksum 0x5f21ba30, Offset: 0x1ae0
// Size: 0x292
function private function_c7c70177( entity, *asmstatename )
{
    result = 5;
    
    if ( isdefined( asmstatename.var_b20b0960 ) )
    {
        if ( !is_true( asmstatename.var_b20b0960.var_2cb0aa8e ) )
        {
            asmstatename function_aeb6539c();
            var_3229ed5d = 6.5;
            
            if ( isdefined( asmstatename.zipline_start.var_cf56bb8f ) )
            {
                var_cf56bb8f = asmstatename.zipline_start.var_cf56bb8f;
                var_3229ed5d = var_cf56bb8f.var_aff2bad6 * var_cf56bb8f.var_dc6e66ea;
            }
            
            var_3c5c113f = asmstatename.team == #"allies" ? 35 : 25;
            
            if ( var_3229ed5d < 1 )
            {
                var_3229ed5d = 1;
            }
            else if ( var_3229ed5d > var_3c5c113f )
            {
                var_3229ed5d = var_3c5c113f;
            }
            
            asmstatename.var_b20b0960 setspeed( 1 );
            asmstatename thread function_25f7c630();
            asmstatename.var_b20b0960 thread vehicle::get_on_and_go_path( asmstatename.zipline_start );
            
            if ( isdefined( level.var_7428aa92 ) )
            {
                asmstatename [[ level.var_7428aa92 ]]();
            }
            
            asmstatename.var_b20b0960.var_2cb0aa8e = 1;
            
            if ( isdefined( asmstatename.var_660aa59f ) )
            {
                function_55f3b1df( asmstatename.var_b20b0960, asmstatename.zipline_start, asmstatename.var_660aa59f );
                asmstatename.var_660aa59f = undefined;
            }
            
            if ( isdefined( asmstatename.var_b20b0960.var_da287758 ) )
            {
                asmstatename thread function_9dac9d34();
            }
            
            asmstatename thread function_56e443d9();
            asmstatename.var_b20b0960 setspeed( var_3c5c113f, var_3229ed5d );
        }
        else if ( is_true( asmstatename.var_b20b0960.reached_dynamic_path_end ) )
        {
            result = 4;
        }
    }
    
    return result;
}

// Namespace zipline/zipline
// Params 0, eflags: 0x4
// Checksum 0x7ef6f101, Offset: 0x1d80
// Size: 0x8c
function private function_aeb6539c()
{
    self endon( #"disconnect" );
    
    if ( isdefined( self.var_a4d91a0d ) )
    {
        self.var_a4d91a0d delete();
    }
    
    self.var_f22c83f5 = 1;
    self.var_e75517b1 = 1;
    self linkto( self.var_b20b0960, "tag_origin", ( 0, 0, 72 * -1 ) );
}

// Namespace zipline/zipline
// Params 0, eflags: 0x4
// Checksum 0x9867c8dc, Offset: 0x1e18
// Size: 0xae
function private function_25f7c630()
{
    self.var_b20b0960 endon( #"death", #"reached_end_node", #"zipline_start_disconnect" );
    
    while ( true )
    {
        waitframe( 1 );
        velocity = self.var_b20b0960 getvelocity();
        
        if ( lengthsquared( velocity ) > lengthsquared( self.var_b30ec151 ) )
        {
            self.var_b30ec151 = velocity;
        }
    }
}

// Namespace zipline/zipline
// Params 0, eflags: 0x4
// Checksum 0x99c54933, Offset: 0x1ed0
// Size: 0x11c
function private function_9dac9d34()
{
    self.var_b20b0960 endon( #"death" );
    var_9f9bac58 = getvehiclenode( self.zipline_start.target, "targetname" );
    var_8bb667c1 = var_9f9bac58.origin - self.zipline_start.origin;
    var_b00e3ead = vectornormalize( var_8bb667c1 );
    
    while ( true )
    {
        waitframe( 1 );
        _attack_barrier_sprint = self.var_b20b0960.var_da287758 - self.var_b20b0960.origin;
        var_55ee4999 = vectordot( var_b00e3ead, _attack_barrier_sprint );
        
        if ( var_55ee4999 <= 0 )
        {
            break;
        }
    }
    
    function_c4cfe0f5();
}

// Namespace zipline/zipline
// Params 0, eflags: 0x4
// Checksum 0x8bab7a54, Offset: 0x1ff8
// Size: 0xac
function private function_56e443d9()
{
    self.var_b20b0960 endon( #"death" );
    s_results = self.var_b20b0960 waittill( #"reached_end_node", #"zipline_start_disconnect" );
    
    if ( s_results._notify === "zipline_start_disconnect" )
    {
        s_results = self.var_b20b0960 waittilltimeout( 0.35, #"reached_end_node" );
    }
    
    function_c4cfe0f5();
}

// Namespace zipline/zipline
// Params 0, eflags: 0x4
// Checksum 0xa9471719, Offset: 0x20b0
// Size: 0x38
function private function_c4cfe0f5()
{
    self.var_b20b0960.reached_dynamic_path_end = 1;
    
    if ( isdefined( level.var_42da2b06 ) )
    {
        self [[ level.var_42da2b06 ]]();
    }
}

// Namespace zipline/zipline
// Params 2, eflags: 0x4
// Checksum 0x191afeae, Offset: 0x20f0
// Size: 0x80
function private function_11b30321( entity, *asmstatename )
{
    asmstatename unlink();
    asmstatename.var_c681e4c1 = 0;
    asmstatename.is_ziplining = 0;
    asmstatename notify( #"hash_4c7ded9d08b15793" );
    
    if ( isdefined( self.var_b20b0960 ) )
    {
        asmstatename.var_b20b0960 delete();
    }
    
    return 4;
}

// Namespace zipline/zipline
// Params 2, eflags: 0x4
// Checksum 0xc6434456, Offset: 0x2178
// Size: 0x58
function private function_b253aeb( entity, asmstatename )
{
    entity setblackboardattribute( "_zipline_state", "ZIPLINE_DETACH" );
    animationstatenetworkutility::requeststate( entity, asmstatename );
    return 5;
}

// Namespace zipline/zipline
// Params 2, eflags: 0x4
// Checksum 0xac475b9f, Offset: 0x21d8
// Size: 0xac
function private function_dd8aadf1( entity, asmstatename )
{
    entity setblackboardattribute( "_zipline_state", "ZIPLINE_FALL" );
    animationstatenetworkutility::requeststate( entity, asmstatename );
    var_50588787 = entity.var_b30ec151 * ( 1, 1, 0 ) * 0.5;
    entity.var_b30ec151 = var_50588787;
    
    if ( isdefined( level.var_ad1d5b82 ) )
    {
        entity [[ level.var_ad1d5b82 ]]();
    }
    
    return 5;
}

// Namespace zipline/zipline
// Params 2, eflags: 0x4
// Checksum 0xb440f62f, Offset: 0x2290
// Size: 0x1c0
function private function_28c69db4( entity, *asmstatename )
{
    result = 5;
    
    if ( asmstatename isonground() )
    {
        if ( isdefined( level.var_4b3860d7 ) )
        {
            asmstatename [[ level.var_4b3860d7 ]]();
        }
        
        result = 4;
    }
    else
    {
        gravity = ( 0, 0, -980 );
        forward = anglestoforward( asmstatename.angles );
        velocity = asmstatename.var_b30ec151 + gravity * float( function_60d95f53() ) / 1000;
        position = asmstatename.origin + asmstatename.var_b30ec151 * float( function_60d95f53() ) / 1000 + 0.5 * gravity * sqr( float( function_60d95f53() ) / 1000 );
        asmstatename.var_b30ec151 = velocity;
        asmstatename forceteleport( position, asmstatename.angles, 0, 0 );
    }
    
    return result;
}

// Namespace zipline/zipline
// Params 0
// Checksum 0xdaead1d5, Offset: 0x2458
// Size: 0x1fc
function function_63d01c33()
{
    var_de68568b = 1;
    var_4794d60e = 0;
    var_398bbe57 = -1;
    var_eb102f19 = -1;
    
    if ( math::cointoss( 50 ) )
    {
        var_eb102f19 = 1;
    }
    
    var_dd2b8b96 = randomfloatrange( 0, 1 );
    n_pitch = 3.5 - var_dd2b8b96;
    n_roll = 4.5 - var_dd2b8b96;
    
    foreach ( var_9681c147 in self.var_d9c9a508 )
    {
        if ( var_de68568b )
        {
            var_de68568b = 0;
            continue;
        }
        
        var_9681c147.angles = ( var_398bbe57 * n_pitch, var_9681c147.angles[ 1 ], var_eb102f19 * n_roll );
        
        if ( n_pitch > 1 )
        {
            n_pitch -= 0.5;
        }
        
        if ( n_roll > 1 )
        {
            n_roll -= 0.5;
        }
        
        var_eb102f19 *= -1;
        
        if ( !var_4794d60e )
        {
            if ( math::cointoss( 50 ) )
            {
                var_398bbe57 *= -1;
            }
            else
            {
                var_4794d60e = 1;
            }
            
            continue;
        }
        
        var_398bbe57 *= -1;
        var_4794d60e = 0;
    }
}

// Namespace zipline/zipline
// Params 2, eflags: 0x4
// Checksum 0xa4ed6e1e, Offset: 0x2660
// Size: 0x58
function private function_574f0280( entity, asmstatename )
{
    entity setblackboardattribute( "_zipline_state", "ZIPLINE_LAND" );
    animationstatenetworkutility::requeststate( entity, asmstatename );
    return 5;
}

// Namespace zipline/zipline
// Params 2, eflags: 0x4
// Checksum 0xf48998d5, Offset: 0x26c0
// Size: 0x26
function private function_c0a3f837( entity, *asmstatename )
{
    asmstatename.allowpain = 1;
    return 4;
}

// Namespace zipline/zipline
// Params 3
// Checksum 0xdb1de0e3, Offset: 0x26f0
// Size: 0x92
function function_61418721( point, line_start, line_end )
{
    var_13d62e0a = point - line_start;
    var_1ad356b8 = vectornormalize( line_end - line_start );
    var_f6451fc1 = vectordot( var_13d62e0a, var_1ad356b8 );
    closest_point = line_start + var_1ad356b8 * var_f6451fc1;
    return closest_point;
}

// Namespace zipline/zipline
// Params 4
// Checksum 0x328d945f, Offset: 0x2790
// Size: 0xd8
function number_b_( var_5c57c958, var_f3e138f3, plane_point, plane_normal )
{
    var_a979e3a2 = vectordot( plane_normal, var_f3e138f3 );
    result = undefined;
    
    if ( abs( var_a979e3a2 ) > 0.001 )
    {
        var_fa608360 = plane_point - var_5c57c958;
        var_bc4566f4 = vectordot( var_fa608360, plane_normal );
        hit_time = var_bc4566f4 / var_a979e3a2;
        
        if ( hit_time >= 0 )
        {
            result = hit_time;
        }
    }
    
    return result;
}

// Namespace zipline/zipline
// Params 3
// Checksum 0x682367bf, Offset: 0x2870
// Size: 0x110
function function_a8c07396( zipline_start, var_4be77411, var_8f2ded8e )
{
    self endon( #"death" );
    
    while ( true )
    {
        waitframe( 1 );
        
        /#
            sphere( zipline_start, 2, ( 0, 1, 0 ), 0.3, 0, 8, 1 );
            line( zipline_start, var_4be77411, ( 1, 1, 0 ) );
            sphere( var_4be77411, 2, ( 0, 1, 0 ), 0.3, 0, 8, 1 );
            line( var_8f2ded8e, zipline_start, ( 1, 1, 0 ) );
            sphere( var_8f2ded8e, 2, ( 1, 0.5, 0 ), 0.3, 0, 8, 1 );
        #/
    }
}

// Namespace zipline/zipline
// Params 0
// Checksum 0x5a46ee85, Offset: 0x2988
// Size: 0xf8
function function_5ddff7e3()
{
    self endon( #"death" );
    self.var_b20b0960 endon( #"death" );
    
    while ( true )
    {
        waitframe( 1 );
        enabled = getdvarint( #"hash_6e0cbdce6b2104a3", 0 );
        
        if ( enabled )
        {
            /#
                sphere( self.var_b20b0960.origin, 2, ( 0, 1, 0 ), 0.3, 0, 8, 1 );
                line( self.var_b20b0960.origin, self.var_b20b0960.origin + ( 0, 0, 72 ), ( 1, 1, 0 ) );
            #/
        }
    }
}

