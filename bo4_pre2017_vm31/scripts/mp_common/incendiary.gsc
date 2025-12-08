#using scripts/core_common/burnplayer;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/entityheadicons_shared;
#using scripts/core_common/killcam_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/tacticalinsertion;
#using scripts/core_common/weapons/weaponobjects;

#namespace incendiary;

// Namespace incendiary/incendiary
// Params 0, eflags: 0x2
// Checksum 0x2df6e345, Offset: 0x510
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "incendiary_grenade", &init_shared, undefined, undefined );
}

// Namespace incendiary/incendiary
// Params 0
// Checksum 0x9c76c019, Offset: 0x550
// Size: 0x134
function init_shared()
{
    level.incendiaryfiredamage = getdvarint( "scr_incendiaryfireDamage", 35 );
    level.incendiaryfiredamagehardcore = getdvarint( "scr_incendiaryfireDamageHardcore", 15 );
    level.incendiaryfireduration = getdvarint( "scr_incendiaryfireDuration", 5 );
    level.incendiaryfxduration = getdvarfloat( "scr_incendiaryfxDuration", 0.4 );
    level.incendiarydamageradius = getdvarint( "scr_incendiaryDamageRadius", 125 );
    level.incendiaryfiredamageticktime = getdvarfloat( "scr_incendiaryfireDamageTickTime", 1 );
    level.incendiarydamagethistick = [];
    callback::on_spawned( &player_spawned );
}

/#

    // Namespace incendiary/incendiary
    // Params 0
    // Checksum 0xc511bdc6, Offset: 0x690
    // Size: 0x128, Type: dev
    function updateincendiaryfromdvars()
    {
        level.incendiaryfiredamage = getdvarint( "scr_incendiaryfireDamage", level.incendiaryfiredamage );
        level.incendiaryfiredamagehardcore = getdvarint( "scr_incendiaryfireDamageHardcore", level.incendiaryfiredamagehardcore );
        level.incendiaryfireduration = getdvarint( "scr_incendiaryfireDuration", level.incendiaryfireduration );
        level.incendiarydamageradius = getdvarint( "scr_incendiaryDamageRadius", level.incendiarydamageradius );
        level.incendiaryfiredamageticktime = getdvarfloat( "scr_incendiaryfireDamageTickTime", level.incendiaryfiredamageticktime );
        level.incendiaryfxduration = getdvarfloat( "scr_incendiaryfxDuration", level.incendiaryfxduration );
    }

#/

// Namespace incendiary/incendiary
// Params 0
// Checksum 0x67a551bd, Offset: 0x7c0
// Size: 0x44
function player_spawned()
{
    self create_incendiary_watcher( "incendiary_grenade" );
    self create_incendiary_watcher( "incendiary_grenade_l2" );
}

// Namespace incendiary/incendiary
// Params 1
// Checksum 0x601ab7db, Offset: 0x810
// Size: 0x50
function create_incendiary_watcher( grenade_name )
{
    watcher = self weaponobjects::createuseweaponobjectwatcher( grenade_name, self.team );
    watcher.onspawn = &incendiary_system_spawn;
}

// Namespace incendiary/incendiary
// Params 2
// Checksum 0xea09d7ea, Offset: 0x868
// Size: 0x84
function incendiary_system_spawn( watcher, player )
{
    player endon( #"death" );
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    player addweaponstat( self.weapon, "used", 1 );
    thread watchforexplode( player );
}

// Namespace incendiary/incendiary
// Params 1
// Checksum 0x21c632cc, Offset: 0x8f8
// Size: 0x164
function watchforexplode( owner )
{
    self endon( #"hacked" );
    self endon( #"delete" );
    killcament = spawn( "script_model", self.origin );
    killcament util::deleteaftertime( 15 );
    killcament.starttime = gettime();
    killcament linkto( self );
    killcament setweapon( self.weapon );
    killcament killcam::store_killcam_entity_on_entity( self );
    waitresult = self waittill( "projectile_impact_explode" );
    killcament unlink();
    
    /#
        updateincendiaryfromdvars();
    #/
    
    playsoundatposition( "wpn_incendiary_core_start", self.origin );
    generatelocations( waitresult.position, owner, waitresult.normal, killcament );
}

// Namespace incendiary/incendiary
// Params 1
// Checksum 0x49576cee, Offset: 0xa68
// Size: 0x7e
function getstepoutdistance( normal )
{
    if ( normal[ 2 ] < 0.5 )
    {
        stepoutdistance = normal * getdvarint( "scr_incendiary_stepout_wall", 50 );
    }
    else
    {
        stepoutdistance = normal * getdvarint( "scr_incendiary_stepout_ground", 12 );
    }
    
    return stepoutdistance;
}

// Namespace incendiary/incendiary
// Params 4
// Checksum 0x8066f56d, Offset: 0xaf0
// Size: 0x2b4
function generatelocations( position, owner, normal, killcament )
{
    startpos = position + getstepoutdistance( normal );
    desiredendpos = startpos + ( 0, 0, 60 );
    phystrace = physicstrace( startpos, desiredendpos, ( -4, -4, -4 ), ( 4, 4, 4 ), self, 1 );
    goalpos = phystrace[ "fraction" ] < 1 ? phystrace[ "position" ] : desiredendpos;
    killcament moveto( goalpos, 0.5 );
    rotation = randomint( 360 );
    
    if ( normal[ 2 ] < 0.1 )
    {
        black = ( 0.1, 0.1, 0.1 );
        trace = hitpos( startpos, startpos + normal * -1 * 70 + ( 0, 0, -1 ) * 70, black );
        traceposition = trace[ "position" ];
        incendiarygrenade = getweapon( "incendiary_fire" );
        
        if ( trace[ "fraction" ] < 0.9 )
        {
            wallnormal = trace[ "normal" ];
            spawntimedfx( incendiarygrenade, trace[ "position" ], wallnormal, level.incendiaryfireduration, self.team );
        }
    }
    
    fxcount = getdvarint( "scr_incendiary_fx_count", 6 );
    spawnalllocs( owner, startpos, normal, 1, rotation, killcament, fxcount );
}

// Namespace incendiary/incendiary
// Params 5
// Checksum 0x95fc1e46, Offset: 0xdb0
// Size: 0xb6
function getlocationforfx( startpos, fxindex, fxcount, defaultdistance, rotation )
{
    currentangle = 360 / fxcount * fxindex;
    coscurrent = cos( currentangle + rotation );
    sincurrent = sin( currentangle + rotation );
    return startpos + ( defaultdistance * coscurrent, defaultdistance * sincurrent, 0 );
}

// Namespace incendiary/incendiary
// Params 7
// Checksum 0x19d482e6, Offset: 0xe70
// Size: 0x53e
function spawnalllocs( owner, startpos, normal, multiplier, rotation, killcament, fxcount )
{
    defaultdistance = getdvarint( "scr_incendiary_trace_distance", 220 ) * multiplier;
    defaultdropdistance = getdvarint( "scr_incendiary_trace_down_distance", 90 );
    colorarray = [];
    colorarray[ colorarray.size ] = ( 0.9, 0.2, 0.2 );
    colorarray[ colorarray.size ] = ( 0.2, 0.9, 0.2 );
    colorarray[ colorarray.size ] = ( 0.2, 0.2, 0.9 );
    colorarray[ colorarray.size ] = ( 0.9, 0.9, 0.9 );
    locations = [];
    locations[ "color" ] = [];
    locations[ "loc" ] = [];
    locations[ "tracePos" ] = [];
    locations[ "distSqrd" ] = [];
    locations[ "fxtoplay" ] = [];
    locations[ "radius" ] = [];
    
    for ( fxindex = 0; fxindex < fxcount ; fxindex++ )
    {
        locations[ "point" ][ fxindex ] = getlocationforfx( startpos, fxindex, fxcount, defaultdistance, rotation );
        locations[ "color" ][ fxindex ] = colorarray[ fxindex % colorarray.size ];
    }
    
    for ( count = 0; count < fxcount ; count++ )
    {
        trace = hitpos( startpos, locations[ "point" ][ count ], locations[ "color" ][ count ] );
        traceposition = trace[ "position" ];
        locations[ "tracePos" ][ count ] = traceposition;
        
        if ( trace[ "fraction" ] < 0.7 )
        {
            locations[ "loc" ][ count ] = traceposition;
            locations[ "normal" ][ count ] = trace[ "normal" ];
            continue;
        }
        
        average = startpos / 2 + traceposition / 2;
        trace = hitpos( average, average - ( 0, 0, defaultdropdistance ), locations[ "color" ][ count ] );
        
        if ( trace[ "fraction" ] != 1 )
        {
            locations[ "loc" ][ count ] = trace[ "position" ];
            locations[ "normal" ][ count ] = trace[ "normal" ];
        }
    }
    
    incendiarygrenade = getweapon( "incendiary_fire" );
    spawntimedfx( incendiarygrenade, startpos, normal, level.incendiaryfireduration, self.team );
    level.incendiarydamageradius = getdvarint( "scr_incendiaryDamageRadius", level.incendiarydamageradius );
    thread damageeffectarea( owner, startpos, level.incendiarydamageradius, level.incendiarydamageradius, killcament );
    
    for ( count = 0; count < locations[ "point" ].size ; count++ )
    {
        if ( isdefined( locations[ "loc" ][ count ] ) )
        {
            normal = locations[ "normal" ][ count ];
            spawntimedfx( incendiarygrenade, locations[ "loc" ][ count ], normal, level.incendiaryfireduration, self.team );
        }
    }
}

/#

    // Namespace incendiary/incendiary
    // Params 5
    // Checksum 0x6965fb5c, Offset: 0x13b8
    // Size: 0xbc, Type: dev
    function incendiary_debug_line( from, to, color, depthtest, time )
    {
        debug_rcbomb = getdvarint( "scr_incendiary_debug", 0 );
        
        if ( debug_rcbomb == 1 )
        {
            if ( !isdefined( time ) )
            {
                time = 100;
            }
            
            if ( !isdefined( depthtest ) )
            {
                depthtest = 1;
            }
            
            line( from, to, color, 1, depthtest, time );
        }
    }

#/

// Namespace incendiary/incendiary
// Params 5
// Checksum 0xe7afcdd, Offset: 0x1480
// Size: 0x29c
function damageeffectarea( owner, position, radius, height, killcament )
{
    trigger_radius_position = position - ( 0, 0, height );
    trigger_radius_height = height * 2;
    fireeffectarea = spawn( "trigger_radius", trigger_radius_position, 0, radius, trigger_radius_height );
    
    /#
        if ( getdvarint( "scr_draw_triggers" ) )
        {
            level thread util::drawcylinder( trigger_radius_position, radius, trigger_radius_height, undefined, "incendiary_draw_cylinder_stop" );
        }
    #/
    
    if ( isdefined( level.rapsonburnraps ) )
    {
        owner thread [[ level.rapsonburnraps ]]( fireeffectarea );
    }
    
    loopwaittime = level.incendiaryfiredamageticktime;
    durationofincendiary = level.incendiaryfireduration;
    
    while ( durationofincendiary > 0 )
    {
        durationofincendiary -= loopwaittime;
        damageapplied = 0;
        potential_targets = self getpotentialtargets( owner );
        
        foreach ( target in potential_targets )
        {
            self trytoapplyfiredamage( target, owner, position, fireeffectarea, loopwaittime, killcament );
        }
        
        wait loopwaittime;
    }
    
    if ( isdefined( killcament ) )
    {
        killcament entityheadicons::destroyentityheadicons();
    }
    
    fireeffectarea delete();
    
    /#
        if ( getdvarint( "scr_draw_triggers" ) )
        {
            level notify( #"incendiary_draw_cylinder_stop" );
        }
    #/
}

// Namespace incendiary/incendiary
// Params 1
// Checksum 0x146d00b7, Offset: 0x1728
// Size: 0x334
function getpotentialtargets( owner )
{
    owner_team = isdefined( owner ) ? owner.team : undefined;
    
    if ( level.teambased && isdefined( owner_team ) && level.friendlyfire == 0 )
    {
        enemy_team = owner_team == "axis" ? "allies" : "axis";
        potential_targets = [];
        potential_targets = arraycombine( potential_targets, getplayers( enemy_team ), 0, 0 );
        potential_targets = arraycombine( potential_targets, getaiteamarray( enemy_team ), 0, 0 );
        potential_targets = arraycombine( potential_targets, getvehicleteamarray( enemy_team ), 0, 0 );
        potential_targets[ potential_targets.size ] = owner;
        return potential_targets;
    }
    
    all_targets = [];
    all_targets = arraycombine( all_targets, level.players, 0, 0 );
    all_targets = arraycombine( all_targets, getaiarray(), 0, 0 );
    all_targets = arraycombine( all_targets, getvehiclearray(), 0, 0 );
    
    if ( level.friendlyfire > 0 )
    {
        return all_targets;
    }
    
    potential_targets = [];
    
    foreach ( target in all_targets )
    {
        if ( !isdefined( target ) )
        {
            continue;
        }
        
        if ( !isdefined( target.team ) )
        {
            continue;
        }
        
        if ( isdefined( owner ) )
        {
            if ( target != owner )
            {
                if ( !isdefined( owner_team ) )
                {
                    continue;
                }
                
                if ( target.team == owner_team )
                {
                    continue;
                }
            }
        }
        else
        {
            if ( !isdefined( self ) )
            {
                continue;
            }
            
            if ( !isdefined( self.team ) )
            {
                continue;
            }
            
            if ( target.team == self.team )
            {
                continue;
            }
        }
        
        potential_targets[ potential_targets.size ] = target;
    }
    
    return potential_targets;
}

// Namespace incendiary/incendiary
// Params 6
// Checksum 0x3403ba96, Offset: 0x1a68
// Size: 0x13c
function trytoapplyfiredamage( target, owner, position, fireeffectarea, resetfiretime, killcament )
{
    if ( !isdefined( target.infirearea ) || target.infirearea == 0 )
    {
        if ( !isdefined( target.sessionstate ) || target istouching( fireeffectarea ) && target.sessionstate == "playing" )
        {
            trace = bullettrace( position, target getshootatpos(), 0, target, 1 );
            
            if ( trace[ "fraction" ] == 1 )
            {
                target.lastburnedby = owner;
                target thread damageinfirearea( fireeffectarea, killcament, trace, position, resetfiretime );
            }
        }
    }
}

// Namespace incendiary/incendiary
// Params 5
// Checksum 0xe1f6624c, Offset: 0x1bb0
// Size: 0x1cc
function damageinfirearea( fireeffectarea, killcament, trace, position, resetfiretime )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    timer = 0;
    damage = level.incendiaryfiredamage;
    
    if ( level.hardcoremode )
    {
        damage = level.incendiaryfiredamagehardcore;
    }
    
    if ( candofiredamage( killcament, self, resetfiretime ) )
    {
        /#
            level.incendiary_debug = getdvarint( "scr_incendiary_debug", 0 );
            
            if ( level.incendiary_debug )
            {
                if ( !isdefined( level.incendiarydamagetime ) )
                {
                    level.incendiarydamagetime = gettime();
                }
                
                iprintlnbold( level.incendiarydamagetime - gettime() );
                level.incendiarydamagetime = gettime();
            }
        #/
        
        self dodamage( damage, fireeffectarea.origin, self.lastburnedby, killcament, "none", "MOD_BURNED", 0, getweapon( "incendiary_fire" ) );
        entnum = self getentitynumber();
        self thread sndfiredamage();
    }
}

// Namespace incendiary/incendiary
// Params 0
// Checksum 0x6374a14b, Offset: 0x1d88
// Size: 0x12e
function sndfiredamage()
{
    self notify( #"sndfire" );
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"sndfire" );
    
    if ( !isdefined( self.sndfireent ) )
    {
        self.sndfireent = spawn( "script_origin", self.origin );
        self.sndfireent linkto( self, "tag_origin" );
        self.sndfireent playsound( "chr_burn_start" );
        self thread sndfiredamage_deleteent( self.sndfireent );
    }
    
    self.sndfireent playloopsound( "chr_burn_start_loop", 0.5 );
    wait 3;
    self.sndfireent delete();
    self.sndfireent = undefined;
}

// Namespace incendiary/incendiary
// Params 1
// Checksum 0x925de212, Offset: 0x1ec0
// Size: 0x44
function sndfiredamage_deleteent( ent )
{
    self endon( #"disconnect" );
    self waittill( "death" );
    
    if ( isdefined( ent ) )
    {
        ent delete();
    }
}

// Namespace incendiary/incendiary
// Params 3
// Checksum 0xb0b21960, Offset: 0x1f10
// Size: 0xd8
function hitpos( start, end, color )
{
    trace = bullettrace( start, end, 0, undefined );
    
    /#
        level.incendiary_debug = getdvarint( "scr_incendiary_debug", 0 );
        
        if ( level.incendiary_debug )
        {
            debugstar( trace[ "position" ], 2000, color );
        }
        
        thread incendiary_debug_line( start, trace[ "position" ], color, 1, 80 );
    #/
    
    return trace;
}

// Namespace incendiary/incendiary
// Params 3
// Checksum 0x32f84438, Offset: 0x1ff0
// Size: 0x94, Type: bool
function candofiredamage( killcament, victim, resetfiretime )
{
    entnum = victim getentitynumber();
    
    if ( !isdefined( level.incendiarydamagethistick[ entnum ] ) )
    {
        level.incendiarydamagethistick[ entnum ] = 0;
        level thread resetfiredamage( entnum, resetfiretime );
        return true;
    }
    
    return false;
}

// Namespace incendiary/incendiary
// Params 2
// Checksum 0xed8fdcf4, Offset: 0x2090
// Size: 0x44
function resetfiredamage( entnum, time )
{
    if ( time > 0.05 )
    {
        wait time - 0.05;
    }
    
    level.incendiarydamagethistick[ entnum ] = undefined;
}

