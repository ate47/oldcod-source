#using scripts\core_common\ai\archetype_civilian;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_f592a7b;

// Namespace namespace_f592a7b/namespace_45b9dd6a
// Params 0, eflags: 0x6
// Checksum 0xaa032cd4, Offset: 0x2a0
// Size: 0x4c
function private autoexec __init__system__()
{
    system::register( #"hash_2846a4f4bd094545", &preinit, &postinit, undefined, undefined );
}

// Namespace namespace_f592a7b/namespace_45b9dd6a
// Params 0, eflags: 0x4
// Checksum 0x13497f70, Offset: 0x2f8
// Size: 0xf4
function private preinit()
{
    assert( isscriptfunctionptr( &civilianpaniccoverservice ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "civilianPanicCoverService", &civilianpaniccoverservice, 1 );
    level.var_ec54dc19 = &function_251c139d;
    callback::on_ai_killed( &on_ai_killed );
    spawner::add_archetype_spawn_function( #"civilian", &function_478f2963 );
    
    /#
        adddebugcommand( "<dev string:x38>" );
    #/
}

// Namespace namespace_f592a7b/namespace_45b9dd6a
// Params 0, eflags: 0x4
// Checksum 0x8837d296, Offset: 0x3f8
// Size: 0x50
function private postinit()
{
    level.__ai_interface[ #"civilian" ][ #"_civ_mode" ][ #"callback" ] = &function_e2953db0;
}

// Namespace namespace_f592a7b/namespace_45b9dd6a
// Params 0, eflags: 0x4
// Checksum 0xdb9d2ed0, Offset: 0x450
// Size: 0x3c
function private function_478f2963()
{
    self.var_702fecae = 0;
    self thread function_f1d19be1();
    
    /#
        self thread function_a8f579e();
    #/
}

// Namespace namespace_f592a7b/namespace_45b9dd6a
// Params 1, eflags: 0x4
// Checksum 0x1a5d45e3, Offset: 0x498
// Size: 0x260, Type: bool
function private function_74f41e14( entity )
{
    goalinfo = entity function_4794d6a3();
    forcedgoal = is_true( goalinfo.goalforced );
    itsbeenawhile = gettime() > entity.nextfindbestcovertime;
    shouldfindbetterposition = itsbeenawhile;
    
    if ( forcedgoal || !shouldfindbetterposition )
    {
        return false;
    }
    
    if ( isdefined( level.var_72b8905c ) )
    {
        var_be34b5c6 = entity [[ level.var_72b8905c ]]();
        entity function_387a6908( var_be34b5c6 );
        entity.nextfindbestcovertime = 2147483647;
        return true;
    }
    
    pickedpoint = undefined;
    var_cab884f3 = randomfloat( 1 );
    
    if ( var_cab884f3 < 0.5 )
    {
        if ( is_true( entity.var_ac4fe74b ) )
        {
            pickedpoint = function_251c139d( entity, goalinfo, "civilian_region_exposed_cover_tacquery" );
        }
        else
        {
            pickedpoint = function_251c139d( entity, goalinfo, "civilian_exposed_cover_tacquery" );
        }
    }
    
    if ( !isdefined( pickedpoint ) )
    {
        if ( is_true( entity.var_ac4fe74b ) )
        {
            pickedpoint = function_251c139d( entity, goalinfo, "civilian_region_cover_tacquery" );
        }
        else
        {
            pickedpoint = function_251c139d( entity, goalinfo, "civilian_cover_tacquery" );
        }
    }
    
    if ( isdefined( pickedpoint ) && isdefined( pickedpoint.node ) )
    {
        entity function_387a6908( pickedpoint.node );
        entity.nextfindbestcovertime = gettime() + 9999999;
        return true;
    }
    else
    {
        entity.nextfindbestcovertime = gettime() + 3000;
    }
    
    return false;
}

// Namespace namespace_f592a7b/namespace_45b9dd6a
// Params 3, eflags: 0x4
// Checksum 0x57cf0f05, Offset: 0x700
// Size: 0x1e4
function private function_ddb1fd83( node, tacpoints, pickedpoint )
{
    self notify( "57202c52353ad41b" );
    self endon( "57202c52353ad41b" );
    self endon( #"death" );
    goalinfo = self function_4794d6a3();
    
    while ( true )
    {
        waitframe( 1 );
        
        /#
            line( goalinfo.goalpos, node.origin, ( 1, 0.5, 0 ), 1, 0, 1 );
        #/
        
        foreach ( tacpoint in tacpoints )
        {
            if ( tacpoint != pickedpoint )
            {
                /#
                    line( goalinfo.goalpos, tacpoint.origin, ( 1, 0.752941, 0.796078 ), 1, 0, 1 );
                #/
                
                continue;
            }
            
            /#
                print3d( tacpoint.origin, "<dev string:x65>", ( 0, 1, 0 ), 1, 1, 1 );
                line( goalinfo.goalpos, tacpoint.origin, ( 0, 1, 0 ), 1, 0, 1 );
            #/
        }
    }
}

// Namespace namespace_f592a7b/namespace_45b9dd6a
// Params 3, eflags: 0x4
// Checksum 0xd28e5053, Offset: 0x8f0
// Size: 0x210
function private function_251c139d( entity, goalinfo, var_1fe38bcc )
{
    node = getnearestnode( goalinfo.goalpos );
    tacpoints = undefined;
    pickedpoint = undefined;
    
    if ( isdefined( node ) )
    {
        pixbeginevent( var_1fe38bcc );
        aiprofile_beginentry( var_1fe38bcc );
        tacpoints = tacticalquery( var_1fe38bcc, entity.origin, entity, goalinfo.goalpos, node );
        pixendevent();
        aiprofile_endentry();
    }
    
    if ( isdefined( tacpoints ) )
    {
        foreach ( tacpoint in tacpoints )
        {
            if ( !entity isposinclaimedlocation( tacpoint.origin ) )
            {
                if ( isdefined( entity.pathgoalpos ) && entity.pathgoalpos == tacpoint.origin )
                {
                    continue;
                }
                
                pickedpoint = tacpoint;
                break;
            }
        }
        
        /#
            enabled = getdvarint( #"hash_40c63080b0f73497", 0 );
            
            if ( enabled )
            {
                entity thread function_ddb1fd83( node, tacpoints, pickedpoint );
            }
        #/
    }
    
    return pickedpoint;
}

// Namespace namespace_f592a7b/namespace_45b9dd6a
// Params 1
// Checksum 0x5d61677d, Offset: 0xb08
// Size: 0x4c
function function_387a6908( node )
{
    self endon( #"death" );
    aiutility::releaseclaimnode( self );
    aiutility::usecovernodewrapper( self, node );
}

// Namespace namespace_f592a7b/namespace_45b9dd6a
// Params 1, eflags: 0x4
// Checksum 0xf73b9a3c, Offset: 0xb60
// Size: 0x82
function private civilianpaniccoverservice( entity )
{
    result = 0;
    
    if ( entity getblackboardattribute( #"_civ_mode" ) == "panic" )
    {
        result = function_74f41e14( entity );
        
        if ( !result )
        {
            result = archetypecivilian::civilianpanicescapechooseposition( entity );
        }
    }
    
    return result;
}

// Namespace namespace_f592a7b/namespace_45b9dd6a
// Params 1, eflags: 0x4
// Checksum 0x820da4f9, Offset: 0xbf0
// Size: 0x194
function private function_9cefbbde( var_5f60ac6c )
{
    contact_point = var_5f60ac6c.origin;
    initial_force = ( 0, 0, -1 );
    
    switch ( var_5f60ac6c.var_2e23b67d )
    {
        case #"umbrella_left":
            initial_force = ( 0, 0.25, 0.5 );
            initial_force = rotatepoint( initial_force, self.angles );
            var_9fa53333 = ( 0, -10, 10 );
            var_9fa53333 = rotatepoint( var_9fa53333, self.angles );
            contact_point += var_9fa53333;
            break;
        case #"umbrella_right":
            initial_force = ( 0, -0.25, 0.5 );
            initial_force = rotatepoint( initial_force, self.angles );
            var_9fa53333 = ( 0, 10, 10 );
            var_9fa53333 = rotatepoint( var_9fa53333, self.angles );
            contact_point += var_9fa53333;
            break;
        default:
            break;
    }
    
    var_5f60ac6c unlink();
    var_5f60ac6c physicslaunch( contact_point, initial_force );
}

// Namespace namespace_f592a7b/namespace_45b9dd6a
// Params 1, eflags: 0x4
// Checksum 0xe216abf6, Offset: 0xd90
// Size: 0x110
function private on_ai_killed( params )
{
    if ( self.archetype === #"civilian" )
    {
        if ( isdefined( self.civilian_props ) )
        {
            foreach ( var_5f60ac6c in self.civilian_props )
            {
                function_9cefbbde( var_5f60ac6c );
            }
        }
        
        if ( isdefined( params.eattacker ) && isplayer( params.eattacker ) )
        {
            if ( isdefined( level.var_f4ed1999 ) )
            {
                level thread [[ level.var_f4ed1999 ]]( self, params );
            }
        }
    }
}

// Namespace namespace_f592a7b/namespace_45b9dd6a
// Params 4, eflags: 0x4
// Checksum 0x65f675b4, Offset: 0xea8
// Size: 0x114
function private function_e2953db0( entity, *attribute, oldvalue, value )
{
    if ( value != oldvalue && value == "panic" )
    {
        if ( isdefined( attribute.civilian_props ) )
        {
            foreach ( var_5f60ac6c in self.civilian_props )
            {
                function_9cefbbde( var_5f60ac6c );
            }
        }
        
        attribute setgoal( attribute.origin );
        attribute setblackboardattribute( "_prop_overlay", "NONE" );
    }
}

// Namespace namespace_f592a7b/namespace_45b9dd6a
// Params 1
// Checksum 0x63efc782, Offset: 0xfc8
// Size: 0x7c
function function_7bd21c92( value )
{
    oldvalue = self getblackboardattribute( "_prop_overlay" );
    
    if ( value === oldvalue )
    {
        return;
    }
    
    self setblackboardattribute( "_prop_overlay", value );
    function_b0876f77( value );
}

// Namespace namespace_f592a7b/namespace_45b9dd6a
// Params 3, eflags: 0x4
// Checksum 0xc6a5ceb5, Offset: 0x1050
// Size: 0xdc
function private function_5c56272f( var_df71f499, var_c72571dd, var_2e23b67d )
{
    if ( !isdefined( self.civilian_props ) )
    {
        self.civilian_props = [];
    }
    
    var_3c7fa0d6 = self gettagorigin( var_c72571dd );
    var_d0b8fd1f = self gettagangles( var_c72571dd );
    var_5f60ac6c = util::spawn_model( var_df71f499, var_3c7fa0d6, var_d0b8fd1f );
    var_5f60ac6c linkto( self, var_c72571dd );
    var_5f60ac6c.var_2e23b67d = var_2e23b67d;
    self.civilian_props[ self.civilian_props.size ] = var_5f60ac6c;
}

// Namespace namespace_f592a7b/namespace_45b9dd6a
// Params 1
// Checksum 0x4483fc5, Offset: 0x1138
// Size: 0x1b2
function function_b0876f77( value )
{
    if ( isdefined( self.civilian_props ) )
    {
        array::delete_all( self.civilian_props );
        self.civilian_props = [];
    }
    
    var_df71f499 = undefined;
    var_c72571dd = undefined;
    
    switch ( value )
    {
        case #"briefcase_left":
            function_5c56272f( "z_briefcase_01_closed", "tag_accessory_left", "BRIEFCASE_LEFT" );
            break;
        case #"umbrella_left":
            function_5c56272f( "par_umbrella_open_01", "tag_accessory_left", "UMBRELLA_LEFT" );
            break;
        case #"hash_4ac48798a0be234b":
            function_5c56272f( "par_umbrella_open_01_anim", "tag_accessory_left", "UMBRELLA_LEFT" );
            function_5c56272f( "z_briefcase_01_closed", "tag_accessory_right", "BRIEFCASE_RIGHT" );
            break;
        case #"umbrella_right":
            function_5c56272f( "par_umbrella_open_01", "tag_accessory_right", "UMBRELLA_RIGHT" );
            break;
        case #"none":
        default:
            break;
    }
}

// Namespace namespace_f592a7b/namespace_45b9dd6a
// Params 0, eflags: 0x4
// Checksum 0x477e92f9, Offset: 0x12f8
// Size: 0x35c
function private function_f1d19be1()
{
    self notify( #"hash_5048c5b7622d6841" );
    self endon( #"hash_5048c5b7622d6841" );
    self endon( #"death" );
    self addsentienteventlistener( "bulletwhizby" );
    self addsentienteventlistener( "explode" );
    self addsentienteventlistener( "grenade danger" );
    self addsentienteventlistener( "gunshot" );
    self addsentienteventlistener( "grenade danger" );
    self addsentienteventlistener( "projectile_impact" );
    
    while ( true )
    {
        if ( self getblackboardattribute( #"_civ_mode" ) != "panic" )
        {
            waitframe( 1 );
            continue;
        }
        
        if ( !self isatcovernode() )
        {
            waitframe( 1 );
            continue;
        }
        
        wait_result = self waittill( #"ai_events" );
        waittillframeend();
        
        if ( self.ignoreall || self isragdoll() )
        {
            continue;
        }
        
        foreach ( event in wait_result.events )
        {
            if ( !isdefined( event.entity ) )
            {
                continue;
            }
            
            if ( issentient( event.entity ) && ( event.entity.ignoreme || is_true( event.entity isnotarget() ) ) )
            {
                continue;
            }
            
            self.nextfindbestcovertime = gettime();
            
            /#
                enabled = getdvarint( #"hash_40c63080b0f73497", 0 );
                
                if ( enabled )
                {
                    line( self getcentroid(), event.origin, ( 1, 0.5, 0 ), 1, 0, 500 );
                    print3d( event.origin, "<dev string:x76>" + event.type, ( 1, 0.5, 0 ), 1, 1, 500 );
                }
            #/
        }
    }
}

// Namespace namespace_f592a7b/namespace_45b9dd6a
// Params 0, eflags: 0x4
// Checksum 0xc0eb35d, Offset: 0x1660
// Size: 0xf0
function private function_a8f579e()
{
    self endon( #"death" );
    
    while ( true )
    {
        waitframe( 1 );
        enabled = getdvarint( #"hash_40c63080b0f73497", 0 );
        
        if ( !enabled )
        {
            continue;
        }
        
        if ( self getblackboardattribute( #"_civ_mode" ) != "panic" )
        {
            continue;
        }
        
        if ( self isatcovernode() )
        {
            /#
                print3d( self getcentroid(), "<dev string:x7a>", ( 1, 1, 0 ), 1, 1, 1 );
            #/
        }
    }
}

