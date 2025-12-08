#using script_15ddefec0f2c1a92;
#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;

#namespace namespace_79e108ed;

// Namespace namespace_79e108ed
// Method(s) 2 Total 2
class class_b382833a
{

    var adjustmentstarted;
    var var_425c4c8b;

    // Namespace class_b382833a/namespace_79e108ed
    // Params 0, eflags: 0x8
    // Checksum 0xb51c74b6, Offset: 0x1748
    // Size: 0x1a
    constructor()
    {
        adjustmentstarted = 0;
        var_425c4c8b = 1;
    }

}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 0
// Checksum 0xaf950f77, Offset: 0x280
// Size: 0x3c
function init()
{
    namespace_250e9486::function_252dff4d( "wolf_ally", &function_cd36afbf, undefined );
    registerbehaviorscriptfunctions();
}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 0
// Checksum 0xf44c3242, Offset: 0x2c8
// Size: 0x2f4
function registerbehaviorscriptfunctions()
{
    assert( isscriptfunctionptr( &function_4e970354 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_147f534982ab5107", &function_4e970354 );
    assert( isscriptfunctionptr( &function_87660c12 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_495c48ce4f6ff5d5", &function_87660c12 );
    assert( isscriptfunctionptr( &function_af59b7a5 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_27d92cd57ceec9c5", &function_af59b7a5, 2 );
    assert( isscriptfunctionptr( &function_dba8e076 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_4a484f874e45e3a2", &function_dba8e076, 1 );
    assert( isscriptfunctionptr( &function_14a8c157 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_37e69fc4aa586d70", &function_14a8c157 );
    assert( isscriptfunctionptr( &function_ba0f4046 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_618060e9f5751d51", &function_ba0f4046 );
    animationstatenetwork::registeranimationmocomp( "mocomp_zm_wolf_ally_charge_melee", &function_26fcd34f, &function_e023eac9, &function_643e9ba3 );
    animationstatenetwork::registernotetrackhandlerfunction( "wolf_ally_melee", &function_f7c7a416 );
}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 0
// Checksum 0xd42bfffe, Offset: 0x5c8
// Size: 0x11c
function function_cd36afbf()
{
    self namespace_250e9486::function_25b2c8a9();
    self.var_84f9cc2e = 0;
    self.var_951e8469 = 0;
    self.next_move_time = 0;
    self.health = 15000;
    self.maxhealth = 15000;
    self.goalradius = 80;
    level thread function_47c86b9e( self );
    self thread namespace_53a8fe5e::function_7923d25a();
    self collidewithactors( 1 );
    self setteam( "allies" );
    self clientfield::set( "wolf_fx", 0 );
    blackboard::registerblackboardattribute( self, "_should_run", "walk", &function_d5b7adb8 );
}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 1
// Checksum 0x91af7df1, Offset: 0x6f0
// Size: 0x25c
function function_47c86b9e( ai )
{
    ai endon( #"death" );
    ai namespace_ec06fe4a::function_8c808737();
    ai.takedamage = 0;
    ai setfreecameralockonallowed( 0 );
    
    if ( mayspawnentity() && validateorigin( ai.origin ) )
    {
        playsoundatposition( #"zmb_hellhound_prespawn", ai.origin );
    }
    
    wait 1.5;
    
    if ( mayspawnentity() && validateorigin( ai.origin ) )
    {
        playsoundatposition( #"zmb_hellhound_bolt", ai.origin );
    }
    
    earthquake( 0.5, 0.75, ai.origin, 1000 );
    
    if ( mayspawnentity() && validateorigin( ai.origin ) )
    {
        playsoundatposition( #"zmb_hellhound_spawn", ai.origin );
    }
    
    angles = ai.angles;
    ai dontinterpolate();
    ai forceteleport( ai.origin, angles );
    ai clientfield::increment( "wolf_spawn_fx", 1 );
    ai.takedamage = 1;
    wait 0.4;
    ai namespace_ec06fe4a::function_4f72130c();
    ai setfreecameralockonallowed( 1 );
}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 1, eflags: 0x4
// Checksum 0x74a3e291, Offset: 0x958
// Size: 0x74
function private function_4e970354( *entity )
{
    result = 0;
    player_owner = function_f00b611e();
    
    if ( isdefined( player_owner ) && isdefined( player_owner.var_772b4ad2 ) && player_owner.var_772b4ad2 * 300 >= 3000 )
    {
        result = 1;
    }
    
    return result;
}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 1, eflags: 0x4
// Checksum 0x12969ffc, Offset: 0x9d8
// Size: 0xc6
function private function_87660c12( entity )
{
    player_owner = function_f00b611e();
    
    if ( isdefined( player_owner ) )
    {
        spawn_location = player_owner function_dd63fab0();
        
        if ( isdefined( spawn_location ) )
        {
            entity forceteleport( spawn_location );
            entity setgoal( entity.origin );
            entity clientfield::increment( "wolf_spawn_fx", 1 );
        }
    }
    
    player_owner.var_15da7e3f = undefined;
    player_owner.var_772b4ad2 = undefined;
    return 5;
}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 0
// Checksum 0x49ab134f, Offset: 0xaa8
// Size: 0x52
function function_dd63fab0()
{
    spawn_location = getclosestpointonnavmesh( anglestoforward( self.angles ) * 100 + self.origin, 100 );
    return spawn_location;
}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 1, eflags: 0x4
// Checksum 0x967d439e, Offset: 0xb08
// Size: 0x22
function private get_favorite_enemy( dog )
{
    return dog namespace_ec06fe4a::getclosestenemy();
}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 1, eflags: 0x4
// Checksum 0x6bb1dc9c, Offset: 0xb38
// Size: 0x494
function private function_af59b7a5( entity )
{
    player_owner = function_f00b611e();
    
    if ( !isdefined( player_owner ) )
    {
        return;
    }
    
    if ( !isdefined( entity.favoriteenemy ) || isdefined( entity.favoriteenemy.var_15da7e3f ) )
    {
        entity.favoriteenemy = get_favorite_enemy( entity );
    }
    
    if ( gettime() > entity.var_84f9cc2e && isdefined( entity.favoriteenemy ) && isalive( entity.favoriteenemy ) )
    {
        locomotion_target = get_locomotion_target( entity );
        
        if ( isdefined( locomotion_target ) && ( !isdefined( entity.lasttargetposition ) || distancesquared( entity.lasttargetposition, locomotion_target ) > sqr( 16 ) || !entity haspath() ) )
        {
            path = generatenavmeshpath( entity.origin, locomotion_target, entity );
            
            if ( !isdefined( path ) || !isdefined( path.pathpoints ) || path.pathpoints.size == 0 )
            {
                entity.favoriteenemy.var_15da7e3f = gettime();
            }
            else
            {
                entity.lasttargetposition = locomotion_target;
                entity.favoriteenemy.var_15da7e3f = undefined;
                entity setgoal( locomotion_target );
            }
        }
        
        return;
    }
    
    if ( isdefined( player_owner.last_valid_position ) )
    {
        var_3050773c = distance2d( entity.origin, player_owner.last_valid_position );
        var_7f215628 = abs( entity.origin[ 2 ] - player_owner.last_valid_position[ 2 ] );
        var_b270b65e = 450 / 2;
        
        if ( var_7f215628 > 200 || var_3050773c > 300 || var_3050773c > var_b270b65e && !entity isingoal( entity.origin ) )
        {
            entity.var_951e8469 = 0;
            
            if ( !isdefined( player_owner.var_15da7e3f ) || gettime() > player_owner.var_15da7e3f + 300 )
            {
                path = generatenavmeshpath( entity.origin, player_owner.last_valid_position, entity );
                
                if ( !isdefined( path ) || !isdefined( path.pathpoints ) || path.pathpoints.size == 0 )
                {
                    player_owner.var_15da7e3f = gettime();
                    
                    if ( !isdefined( player_owner.var_772b4ad2 ) )
                    {
                        player_owner.var_772b4ad2 = 0;
                    }
                    
                    player_owner.var_772b4ad2 += 1;
                }
                else
                {
                    player_owner.var_15da7e3f = undefined;
                    player_owner.var_772b4ad2 = undefined;
                    entity setgoal( player_owner.last_valid_position );
                }
            }
            
            return;
        }
        
        if ( var_3050773c <= 300 && entity.var_951e8469 < 1.5 )
        {
            player_owner.var_15da7e3f = undefined;
            entity.var_951e8469 += float( function_60d95f53() ) / 1000;
            entity setgoal( entity.origin );
            return;
        }
        
        if ( gettime() > entity.next_move_time )
        {
            entity pick_new_movement_point();
        }
    }
}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 0, eflags: 0x4
// Checksum 0xe887acf4, Offset: 0xfd8
// Size: 0x186
function private pick_new_movement_point()
{
    anchor_point = self.origin;
    player_owner = function_f00b611e();
    
    if ( isdefined( player_owner ) )
    {
        anchor_point = player_owner.origin;
    }
    
    queryresult = positionquery_source_navigation( anchor_point, 96, 256, 128, 20, self );
    
    if ( queryresult.data.size )
    {
        point = queryresult.data[ randomint( queryresult.data.size ) ];
        pathsuccess = self findpath( self.origin, point.origin, 1, 0 );
        
        if ( pathsuccess )
        {
            self.companion_destination = point.origin;
        }
        else
        {
            self.next_move_time = gettime() + randomintrange( 500, 1500 );
            return;
        }
    }
    
    self setgoal( self.companion_destination, 1 );
    self.next_move_time = gettime() + randomintrange( 3000, 8000 );
}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 1, eflags: 0x4
// Checksum 0xbf4db13f, Offset: 0x1168
// Size: 0x8a
function private function_dba8e076( entity )
{
    player_owner = function_f00b611e();
    
    if ( !isdefined( player_owner ) )
    {
        players = getplayers();
        
        if ( players.size > 0 )
        {
            entity.var_93a62fe = arraygetclosest( entity.origin, players );
            return;
        }
        
        entity.var_93a62fe = undefined;
    }
}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 0, eflags: 0x4
// Checksum 0xf73cfc6e, Offset: 0x1200
// Size: 0x4a
function private function_f00b611e()
{
    result = undefined;
    
    if ( isdefined( self.player_owner ) )
    {
        result = self.player_owner;
    }
    else if ( isdefined( self.var_93a62fe ) )
    {
        result = self.var_93a62fe;
    }
    
    return result;
}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 0
// Checksum 0x406ae49b, Offset: 0x1258
// Size: 0x2e
function get_last_valid_position()
{
    if ( isplayer( self ) )
    {
        return self.last_valid_position;
    }
    
    return self.origin;
}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 1
// Checksum 0xf3136107, Offset: 0x1290
// Size: 0x232
function get_locomotion_target( behaviortreeentity )
{
    if ( !isdefined( behaviortreeentity.favoriteenemy ) )
    {
        return undefined;
    }
    
    last_valid_position = behaviortreeentity.favoriteenemy get_last_valid_position();
    
    if ( !isdefined( last_valid_position ) )
    {
        return undefined;
    }
    
    locomotion_target = last_valid_position;
    
    if ( ai::has_behavior_attribute( "spacing_value" ) )
    {
        spacing_near_dist = ai::get_behavior_attribute( "spacing_near_dist" );
        spacing_far_dist = ai::get_behavior_attribute( "spacing_far_dist" );
        spacing_horz_dist = ai::get_behavior_attribute( "spacing_horz_dist" );
        spacing_value = ai::get_behavior_attribute( "spacing_value" );
        to_enemy = behaviortreeentity.favoriteenemy.origin - behaviortreeentity.origin;
        perp = vectornormalize( ( to_enemy[ 1 ] * -1, to_enemy[ 0 ], 0 ) );
        offset = perp * spacing_horz_dist * spacing_value;
        spacing_dist = math::clamp( length( to_enemy ), spacing_near_dist, spacing_far_dist );
        lerp_amount = math::clamp( ( spacing_dist - spacing_near_dist ) / ( spacing_far_dist - spacing_near_dist ), 0, 1 );
        desired_point = last_valid_position + offset * lerp_amount;
        desired_point = getclosestpointonnavmesh( desired_point, spacing_horz_dist * 1.2, 16 );
        
        if ( isdefined( desired_point ) )
        {
            locomotion_target = desired_point;
        }
    }
    
    return locomotion_target;
}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 1
// Checksum 0x1874289a, Offset: 0x14d0
// Size: 0x26a, Type: bool
function function_14a8c157( entity )
{
    if ( 0 && isdefined( entity.enemy ) )
    {
        predictedenemypos = entity.enemy.origin;
        distancesq = distancesquared( entity.origin, entity.enemy.origin );
        
        if ( isplayer( entity.enemy ) && distancesq >= sqr( 100 ) )
        {
            if ( entity.enemy issprinting() )
            {
                enemyvelocity = vectornormalize( entity.enemy getvelocity() );
                var_7a61ad67 = vectornormalize( entity getvelocity() );
                
                if ( vectordot( var_7a61ad67, enemyvelocity ) > cos( 20 ) )
                {
                    /#
                        record3dtext( "<dev string:x38>", entity.origin + ( 0, 0, 60 ), ( 1, 0, 0 ), "<dev string:x54>" );
                    #/
                    
                    return false;
                }
            }
        }
        
        if ( abs( entity.origin[ 2 ] - entity.enemy.origin[ 2 ] ) > 64 )
        {
            return false;
        }
        
        if ( !entity cansee( entity.enemy ) )
        {
            return false;
        }
        
        if ( !tracepassedonnavmesh( entity.origin, entity.enemy.origin, entity getpathfindingradius() ) )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 5
// Checksum 0x6dddf144, Offset: 0x1808
// Size: 0x2fc
function function_26fcd34f( entity, mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration )
{
    mocompanimflag animmode( "gravity", 1 );
    mocompanimflag orientmode( "face angle", mocompanimflag.angles[ 1 ] );
    mocompanimflag.usegoalanimweight = 1;
    mocompanimflag pathmode( "dont move" );
    mocompanimflag collidewithactors( 0 );
    mocompanimflag pushplayer( 0 );
    
    if ( isdefined( mocompanimflag.enemy ) )
    {
        dirtoenemy = vectornormalize( mocompanimflag.enemy.origin - mocompanimflag.origin );
        mocompanimflag forceteleport( mocompanimflag.origin, vectortoangles( dirtoenemy ) );
    }
    
    if ( !isdefined( mocompanimflag.meleeinfo ) )
    {
        mocompanimflag.meleeinfo = new class_b382833a();
        mocompanimflag.meleeinfo.var_9bfa8497 = mocompanimflag.origin;
        mocompanimflag.meleeinfo.var_98bc84b7 = getnotetracktimes( mocompduration, "start_adjust" )[ 0 ];
        mocompanimflag.meleeinfo.var_6392c3a2 = getnotetracktimes( mocompduration, "end_adjust" )[ 0 ];
        var_e397f54c = getmovedelta( mocompduration, 0, 1 );
        mocompanimflag.meleeinfo.var_cb28f380 = mocompanimflag localtoworldcoords( var_e397f54c );
        
        /#
            movedelta = getmovedelta( mocompduration, 0, 1 );
            animendpos = mocompanimflag localtoworldcoords( movedelta );
            distance = distance( mocompanimflag.origin, animendpos );
            recordcircle( animendpos, 3, ( 0, 1, 0 ), "<dev string:x54>" );
            record3dtext( "<dev string:x5e>" + distance, animendpos, ( 0, 1, 0 ), "<dev string:x54>" );
        #/
    }
}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 5
// Checksum 0xe925b312, Offset: 0x1b10
// Size: 0xaac
function function_e023eac9( entity, mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration )
{
    assert( isdefined( mocompanimflag.meleeinfo ) );
    currentanimtime = mocompanimflag getanimtime( mocompduration );
    
    if ( isdefined( mocompanimflag.enemy ) && !mocompanimflag.meleeinfo.adjustmentstarted && mocompanimflag.meleeinfo.var_425c4c8b && currentanimtime >= mocompanimflag.meleeinfo.var_98bc84b7 )
    {
        predictedenemypos = mocompanimflag.enemy.origin;
        
        if ( isplayer( mocompanimflag.enemy ) )
        {
            velocity = mocompanimflag.enemy getvelocity();
            
            if ( length( velocity ) > 0 )
            {
                predictedenemypos += vectorscale( velocity, 0.25 );
            }
        }
        
        mocompanimflag.meleeinfo.adjustedendpos = predictedenemypos;
        var_cf699df5 = distancesquared( mocompanimflag.meleeinfo.var_9bfa8497, mocompanimflag.meleeinfo.var_cb28f380 );
        var_776ddabf = distancesquared( mocompanimflag.meleeinfo.var_cb28f380, mocompanimflag.meleeinfo.adjustedendpos );
        var_65cbfb52 = distancesquared( mocompanimflag.meleeinfo.var_9bfa8497, mocompanimflag.meleeinfo.adjustedendpos );
        var_201660e6 = tracepassedonnavmesh( mocompanimflag.meleeinfo.var_9bfa8497, mocompanimflag.meleeinfo.adjustedendpos, mocompanimflag getpathfindingradius() );
        traceresult = bullettrace( mocompanimflag.origin, mocompanimflag.meleeinfo.adjustedendpos + ( 0, 0, 30 ), 0, mocompanimflag );
        isvisible = traceresult[ #"fraction" ] == 1;
        var_535d098c = 0;
        
        if ( isdefined( traceresult[ #"hitloc" ] ) && traceresult[ #"hitloc" ] == "riotshield" )
        {
            var_cc075bd0 = vectornormalize( mocompanimflag.origin - mocompanimflag.meleeinfo.adjustedendpos );
            mocompanimflag.meleeinfo.adjustedendpos += vectorscale( var_cc075bd0, 50 );
            var_535d098c = 1;
        }
        
        if ( !var_201660e6 )
        {
            /#
                record3dtext( "<dev string:x62>", mocompanimflag.origin + ( 0, 0, 60 ), ( 1, 0, 0 ), "<dev string:x54>" );
            #/
            
            mocompanimflag.meleeinfo.var_425c4c8b = 0;
        }
        else if ( var_cf699df5 > var_65cbfb52 && var_776ddabf >= sqr( 90 ) )
        {
            /#
                record3dtext( "<dev string:x74>", mocompanimflag.origin + ( 0, 0, 60 ), ( 1, 0, 0 ), "<dev string:x54>" );
            #/
            
            mocompanimflag.meleeinfo.var_425c4c8b = 0;
        }
        else if ( var_65cbfb52 >= sqr( 300 ) )
        {
            /#
                record3dtext( "<dev string:x83>", mocompanimflag.origin + ( 0, 0, 60 ), ( 1, 0, 0 ), "<dev string:x54>" );
            #/
            
            mocompanimflag.meleeinfo.var_425c4c8b = 0;
        }
        
        if ( var_535d098c )
        {
            /#
                record3dtext( "<dev string:x92>", mocompanimflag.origin + ( 0, 0, 60 ), ( 1, 0, 0 ), "<dev string:x54>" );
            #/
            
            mocompanimflag.meleeinfo.var_425c4c8b = 1;
        }
        
        if ( mocompanimflag.meleeinfo.var_425c4c8b )
        {
            var_776ddabf = distancesquared( mocompanimflag.meleeinfo.var_cb28f380, mocompanimflag.meleeinfo.adjustedendpos );
            myforward = anglestoforward( mocompanimflag.angles );
            var_1c3641f2 = ( mocompanimflag.enemy.origin[ 0 ], mocompanimflag.enemy.origin[ 1 ], mocompanimflag.origin[ 2 ] );
            dirtoenemy = vectornormalize( var_1c3641f2 - mocompanimflag.origin );
            zdiff = mocompanimflag.meleeinfo.var_cb28f380[ 2 ] - mocompanimflag.enemy.origin[ 2 ];
            withinzrange = abs( zdiff ) <= 45;
            withinfov = vectordot( myforward, dirtoenemy ) > cos( 30 );
            var_7948b2f3 = withinzrange && withinfov;
            var_425c4c8b = ( isvisible || var_535d098c ) && var_7948b2f3;
            
            /#
                reasons = "<dev string:xa6>" + isvisible + "<dev string:xae>" + withinzrange + "<dev string:xb5>" + withinfov;
                
                if ( var_425c4c8b )
                {
                    record3dtext( reasons, mocompanimflag.origin + ( 0, 0, 60 ), ( 0, 1, 0 ), "<dev string:x54>" );
                }
                else
                {
                    record3dtext( reasons, mocompanimflag.origin + ( 0, 0, 60 ), ( 1, 0, 0 ), "<dev string:x54>" );
                }
            #/
            
            if ( var_425c4c8b )
            {
                var_90c3cdd2 = length( mocompanimflag.meleeinfo.adjustedendpos - mocompanimflag.meleeinfo.var_cb28f380 );
                timestep = function_60d95f53();
                animlength = getanimlength( mocompduration ) * 1000;
                starttime = mocompanimflag.meleeinfo.var_98bc84b7 * animlength;
                stoptime = mocompanimflag.meleeinfo.var_6392c3a2 * animlength;
                starttime = floor( starttime / timestep );
                stoptime = floor( stoptime / timestep );
                adjustduration = stoptime - starttime;
                mocompanimflag.meleeinfo.var_10b8b6d1 = vectornormalize( mocompanimflag.meleeinfo.adjustedendpos - mocompanimflag.meleeinfo.var_cb28f380 );
                mocompanimflag.meleeinfo.var_8b9a15a6 = var_90c3cdd2 / adjustduration;
                mocompanimflag.meleeinfo.var_425c4c8b = 1;
                mocompanimflag.meleeinfo.adjustmentstarted = 1;
            }
            else
            {
                mocompanimflag.meleeinfo.var_425c4c8b = 0;
            }
        }
    }
    
    if ( mocompanimflag.meleeinfo.adjustmentstarted && currentanimtime <= mocompanimflag.meleeinfo.var_6392c3a2 )
    {
        assert( isdefined( mocompanimflag.meleeinfo.var_10b8b6d1 ) && isdefined( mocompanimflag.meleeinfo.var_8b9a15a6 ) );
        
        /#
            recordsphere( mocompanimflag.meleeinfo.var_cb28f380, 3, ( 0, 1, 0 ), "<dev string:x54>" );
            recordsphere( mocompanimflag.meleeinfo.adjustedendpos, 3, ( 0, 0, 1 ), "<dev string:x54>" );
        #/
        
        adjustedorigin = mocompanimflag.origin + mocompanimflag.meleeinfo.var_10b8b6d1 * mocompanimflag.meleeinfo.var_8b9a15a6;
        mocompanimflag forceteleport( adjustedorigin );
    }
}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 5
// Checksum 0xc2cfa215, Offset: 0x25c8
// Size: 0xae
function function_643e9ba3( entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration )
{
    mocompduration.usegoalanimweight = 0;
    mocompduration pathmode( "move allowed" );
    mocompduration orientmode( "face default" );
    mocompduration collidewithactors( 1 );
    mocompduration pushplayer( 1 );
    mocompduration.meleeinfo = undefined;
}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 1, eflags: 0x4
// Checksum 0xcd16d4c6, Offset: 0x2680
// Size: 0x274
function private function_f7c7a416( entity )
{
    entity.melee_cooldown = gettime() + 1000;
    
    if ( isdefined( entity.enemy ) && !is_true( entity.enemy.ignoreme ) )
    {
        hit_enemy = entity melee();
        
        if ( isdefined( hit_enemy ) )
        {
            if ( isalive( hit_enemy ) )
            {
                var_743a2772 = entity function_f00b611e();
                n_base_damage = 750;
                hit_enemy dodamage( n_base_damage, entity.origin, var_743a2772, entity, undefined, "MOD_MELEE", 0, level.weapondefault );
                
                if ( isdefined( hit_enemy ) && randomint( 100 ) < 50 )
                {
                    hit_enemy namespace_ed80aead::gib_random_part();
                }
                
                if ( !isalive( hit_enemy ) )
                {
                    force = vectornormalize( ( hit_enemy.origin - entity.origin ) * ( 1, 1, 0 ) );
                    
                    if ( force != ( 0, 0, 1 ) && force != ( 0, 0, -1 ) )
                    {
                        side = vectorcross( force, ( 0, 0, 1 ) );
                        force = rotatepointaroundaxis( force, side, randomfloatrange( 0, 75 ) );
                        force *= randomfloatrange( 30, 85 );
                    }
                    
                    hit_enemy startragdoll();
                    hit_enemy launchragdoll( force );
                }
            }
            
            self.var_84f9cc2e = gettime() + 3000;
        }
        
        entity callback::callback( #"on_ai_melee" );
    }
}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 1, eflags: 0x4
// Checksum 0x7cb40254, Offset: 0x2900
// Size: 0xe6
function private function_ba0f4046( entity )
{
    if ( gettime() > entity.var_84f9cc2e )
    {
        if ( entity.ignoreall || !is_target_valid( entity, entity.favoriteenemy ) )
        {
            return 0;
        }
        
        if ( !is_true( level.intermission ) )
        {
            if ( distancesquared( entity.origin, entity.favoriteenemy.origin ) < sqr( 72 ) )
            {
                cansee = entity cansee( entity.favoriteenemy );
                return cansee;
            }
        }
    }
    
    return 0;
}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 2
// Checksum 0x7b10cc5, Offset: 0x29f0
// Size: 0x90, Type: bool
function is_target_valid( dog, target )
{
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    if ( !isalive( target ) )
    {
        return false;
    }
    
    if ( is_true( target.ignoreme ) )
    {
        return false;
    }
    
    if ( target isnotarget() )
    {
        return false;
    }
    
    if ( dog.team == target.team )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_79e108ed/namespace_79e108ed
// Params 0
// Checksum 0xd2061ed7, Offset: 0x2a88
// Size: 0x22a
function function_d5b7adb8()
{
    /#
        if ( is_true( self.ispuppet ) )
        {
            return "<dev string:xbe>";
        }
    #/
    
    if ( !isdefined( self.favoriteenemy ) )
    {
        owner = self function_f00b611e();
        
        if ( isdefined( owner ) )
        {
            distsq = distancesquared( self.origin, owner.origin );
            
            if ( distsq > sqr( 2048 ) )
            {
                return "run";
            }
        }
        
        return "walk";
    }
    
    cansee = self cansee( self.favoriteenemy );
    
    if ( !cansee )
    {
        distsq = distancesquared( self.origin, self.favoriteenemy.origin );
        
        if ( distsq > sqr( 1000 ) )
        {
            return "run";
        }
    }
    
    if ( self.favoriteenemy.zombie_move_speed !== "walk" )
    {
        distsq = distancesquared( self.origin, self.favoriteenemy.origin );
        
        if ( distsq > sqr( 256 ) )
        {
            return "run";
        }
    }
    
    if ( is_true( self.hasseenfavoriteenemy ) || ai::hasaiattribute( self, "sprint" ) && ai::getaiattribute( self, "sprint" ) )
    {
        return "run";
    }
    
    return "walk";
}

