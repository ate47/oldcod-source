#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;

#namespace hind;

// Namespace hind/namespace_d7cff0a5
// Params 0, eflags: 0x6
// Checksum 0x9262f66f, Offset: 0x1d0
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"armada_hind", &preinit, undefined, undefined, undefined );
}

// Namespace hind/namespace_d7cff0a5
// Params 0, eflags: 0x4
// Checksum 0x756dde17, Offset: 0x218
// Size: 0x2c
function private preinit()
{
    vehicle::add_main_callback( "armada_hind", &function_1f03ae98 );
}

// Namespace hind/namespace_d7cff0a5
// Params 0
// Checksum 0x800d0646, Offset: 0x250
// Size: 0xf0
function function_a6337662()
{
    self.missiletags = [];
    
    if ( !isdefined( self.missiletags ) )
    {
        self.missiletags = [];
    }
    else if ( !isarray( self.missiletags ) )
    {
        self.missiletags = array( self.missiletags );
    }
    
    self.missiletags[ self.missiletags.size ] = "tag_flash3";
    
    if ( !isdefined( self.missiletags ) )
    {
        self.missiletags = [];
    }
    else if ( !isarray( self.missiletags ) )
    {
        self.missiletags = array( self.missiletags );
    }
    
    self.missiletags[ self.missiletags.size ] = "tag_flash2";
}

// Namespace hind/namespace_d7cff0a5
// Params 0
// Checksum 0xe44fc88, Offset: 0x348
// Size: 0x2c4
function function_1f03ae98()
{
    self endon( #"death" );
    self useanimtree( "generic" );
    vehicle::make_targetable( self, ( 0, 0, 0 ) );
    ai::createinterfaceforentity( self );
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    self setneargoalnotifydist( 64 );
    self sethoverparams( 15, 100, 40 );
    self.flyheight = getdvarfloat( #"g_quadrotorflyheight", 0 );
    self.fovcosine = 0;
    self.fovcosinebusy = 0.574;
    self.vehaircraftcollisionenabled = 1;
    self.original_vehicle_type = self.vehicletype;
    self.settings = getscriptbundle( self.scriptbundlesettings );
    self.var_ec0d66ce = 0.5 * ( self.settings.engagementdistmin + self.settings.engagementdistmax );
    self.var_ff6d7c88 = sqr( self.var_ec0d66ce );
    accel = self getdefaultacceleration();
    self.var_442fce01 = 1 * accel;
    self.var_f13adcf8 = 1 * self.settings.defaultmovespeed;
    self function_a6337662();
    self.overridevehicledamage = &function_9dd28496;
    self thread vehicle_ai::nudge_collision();
    
    if ( isdefined( level.vehicle_initializer_cb ) )
    {
        [[ level.vehicle_initializer_cb ]]( self );
    }
    
    self turret::_init_turret( 1 );
    self turret::set_burst_parameters( 1, 2, 1, 2, 1 );
    self setrotorspeed( 1 );
    self setheliheightcap( 1 );
    defaultrole();
}

// Namespace hind/namespace_d7cff0a5
// Params 0
// Checksum 0xab0ba9e6, Offset: 0x618
// Size: 0x17c
function defaultrole()
{
    self vehicle_ai::init_state_machine_for_role();
    self vehicle_ai::get_state_callbacks( "combat" ).enter_func = &state_combat_enter;
    self vehicle_ai::get_state_callbacks( "combat" ).update_func = &state_combat_update;
    self vehicle_ai::get_state_callbacks( "combat" ).exit_func = &state_combat_exit;
    self vehicle_ai::get_state_callbacks( "driving" ).enter_func = &function_3929047b;
    self vehicle_ai::get_state_callbacks( "scripted" ).enter_func = &function_3929047b;
    self vehicle_ai::get_state_callbacks( "death" ).enter_func = &state_death_enter;
    self vehicle_ai::get_state_callbacks( "death" ).update_func = &state_death_update;
    vehicle_ai::startinitialstate();
}

// Namespace hind/namespace_d7cff0a5
// Params 0
// Checksum 0x7f933dc5, Offset: 0x7a0
// Size: 0x74
function shut_off_fx()
{
    self endon( #"death" );
    self notify( #"death_shut_off" );
    
    if ( isdefined( self.frontscanner ) )
    {
        self.frontscanner.sndscanningent delete();
        self.frontscanner delete();
    }
}

// Namespace hind/namespace_d7cff0a5
// Params 1
// Checksum 0x9a61e28e, Offset: 0x820
// Size: 0x74
function state_death_enter( *params )
{
    self endon( #"death" );
    
    if ( isdefined( self.faketargetent ) )
    {
        self.faketargetent delete();
    }
    
    vehicle_ai::defaultstate_death_enter();
    self.inpain = 1;
    self thread shut_off_fx();
}

// Namespace hind/namespace_d7cff0a5
// Params 1
// Checksum 0xe57e6355, Offset: 0x8a0
// Size: 0x11c
function state_death_update( params )
{
    self endon( #"death" );
    death_type = vehicle_ai::get_death_type( params );
    
    if ( !isdefined( death_type ) )
    {
        params.death_type = "gibbed";
        death_type = params.death_type;
    }
    
    self vehicle_ai::clearalllookingandtargeting();
    self vehicle_ai::clearallmovement();
    self cancelaimove();
    self setspeedimmediate( 0 );
    self setvehvelocity( ( 0, 0, 0 ) );
    self setphysacceleration( ( 0, 0, 0 ) );
    self setangularvelocity( ( 0, 0, 0 ) );
    self vehicle_ai::defaultstate_death_update( params );
}

// Namespace hind/namespace_d7cff0a5
// Params 0
// Checksum 0x15d5d729, Offset: 0x9c8
// Size: 0x172
function function_ec878580()
{
    getbackpoint = undefined;
    pointonnavvolume = self getclosestpointonnavvolume( self.origin, 600 );
    
    if ( isdefined( pointonnavvolume ) )
    {
        if ( sighttracepassed( self.origin, pointonnavvolume, 0, self ) )
        {
            getbackpoint = pointonnavvolume;
        }
    }
    
    if ( !isdefined( getbackpoint ) )
    {
        queryresult = positionquery_source_navigation( self.origin, 0, 1200, 1000, self.radius, self );
        positionquery_filter_sight( queryresult, self.origin, ( 0, 0, 0 ), self, 1 );
        getbackpoint = undefined;
        
        foreach ( point in queryresult.data )
        {
            if ( point.visibility === 1 )
            {
                getbackpoint = point.origin;
                break;
            }
        }
    }
    
    return getbackpoint;
}

// Namespace hind/namespace_d7cff0a5
// Params 0
// Checksum 0xa9313f3d, Offset: 0xb48
// Size: 0x34
function disable_turrets()
{
    self turret::disable( 1 );
    self turret::disable( 2 );
}

// Namespace hind/namespace_d7cff0a5
// Params 1
// Checksum 0x1a0988ff, Offset: 0xb88
// Size: 0x7c
function state_combat_enter( *params )
{
    accel = self getdefaultacceleration();
    self setspeed( 1 * self.settings.defaultmovespeed, 1 * accel, 1 * accel );
}

// Namespace hind/namespace_d7cff0a5
// Params 1
// Checksum 0x93c221f2, Offset: 0xc10
// Size: 0x36e
function state_combat_update( *params )
{
    self endon( #"change_state", #"death" );
    self thread attack_thread_mainturret();
    self thread attack_thread_rocket();
    stuckcount = 0;
    
    for ( ;; )
    {
        goalpos = function_b1bd875a();
        
        if ( isdefined( goalpos ) )
        {
            self setspeed( self.settings.defaultmovespeed, 5, 5 );
            onnavvolume = ispointinnavvolume( self.origin, "navvolume_big" );
            
            if ( !onnavvolume && !self isplayinganimscripted() )
            {
                getbackpoint = self function_ec878580();
                self.vehaircraftcollisionenabled = 0;
                
                if ( isdefined( getbackpoint ) )
                {
                    if ( self function_a57c34b7( getbackpoint, 1, 0 ) )
                    {
                        self waittilltimeout( 10, #"near_goal" );
                    }
                }
                else
                {
                    stuckcount++;
                    
                    if ( stuckcount == 1 )
                    {
                        stucklocation = self.origin;
                    }
                    else if ( stuckcount > 10 )
                    {
                        /#
                            v_box_min = ( self.radius * -1, self.radius * -1, self.radius * -1 );
                            v_box_max = ( self.radius, self.radius, self.radius );
                            box( self.origin, v_box_min, v_box_max, self.angles[ 1 ], ( 1, 0, 0 ), 1, 0, 1000000 );
                            
                            if ( isdefined( stucklocation ) )
                            {
                                line( stucklocation, self.origin, ( 1, 0, 0 ), 1, 1, 1000000 );
                            }
                        #/
                        
                        self.origin = goalpos;
                    }
                }
            }
            else
            {
                stuckcount = 0;
                self.vehaircraftcollisionenabled = 1;
                foundpath = self function_a57c34b7( goalpos, 1, 1 );
                
                if ( foundpath )
                {
                    self setspeed( self.var_f13adcf8, 35, 35 );
                    self waittilltimeout( 10, #"near_goal" );
                }
                else
                {
                    self setspeedimmediate( 0 );
                    self setvehvelocity( ( 0, 0, 0 ) );
                    self setphysacceleration( ( 0, 0, 0 ) );
                }
            }
        }
        
        waitframe( 1 );
    }
}

// Namespace hind/namespace_d7cff0a5
// Params 1
// Checksum 0xc61c0cc3, Offset: 0xf88
// Size: 0x44
function state_combat_exit( *params )
{
    self notify( #"end_attack_thread" );
    self notify( #"end_movement_thread" );
    self turretcleartarget( 0 );
}

// Namespace hind/namespace_d7cff0a5
// Params 3
// Checksum 0xbabdb6b8, Offset: 0xfd8
// Size: 0x21c
function delay_target_toenemy_thread( point, enemy, timetohit )
{
    self endon( #"death", #"change_state", #"end_attack_thread" );
    enemy endon( #"death" );
    
    if ( !isdefined( self.faketargetent ) )
    {
        self.faketargetent = spawn( "script_origin", point );
    }
    
    self.faketargetent unlink();
    self.faketargetent.origin = point;
    self turretsettarget( 0, self.faketargetent );
    self waittill( #"turret_on_target" );
    timestart = gettime();
    offset = ( 0, 0, 0 );
    
    if ( issentient( enemy ) )
    {
        offset = enemy geteye() - enemy.origin;
    }
    
    while ( gettime() < timestart + int( timetohit * 1000 ) )
    {
        self.faketargetent.origin = lerpvector( point, enemy.origin + offset, ( gettime() - timestart ) / int( timetohit * 1000 ) );
        waitframe( 1 );
    }
    
    self.faketargetent.origin = enemy.origin + offset;
    waitframe( 1 );
    self.faketargetent linkto( enemy );
}

// Namespace hind/namespace_d7cff0a5
// Params 0
// Checksum 0xb2a757be, Offset: 0x1200
// Size: 0x230
function attack_thread_mainturret()
{
    self endon( #"death", #"change_state", #"end_attack_thread" );
    
    while ( true )
    {
        enemy = self.enemy;
        
        if ( isdefined( enemy ) && !is_true( self.inpain ) )
        {
            self vehlookat( enemy );
            
            if ( self cansee( enemy ) )
            {
                vectorfromenemy = vectornormalize( ( ( self.origin - enemy.origin )[ 0 ], ( self.origin - enemy.origin )[ 1 ], 0 ) );
                self thread delay_target_toenemy_thread( enemy.origin + vectorfromenemy * 300, enemy, 1.5 );
                self waittill( #"turret_on_target" );
                self vehicle_ai::fire_for_time( 2 + randomfloat( 0.8 ), 1, enemy );
                
                if ( isdefined( enemy ) && isai( enemy ) )
                {
                    wait 2.5 + randomfloat( 0.5 );
                }
                else
                {
                    wait 2 + randomfloat( 0.4 );
                }
            }
            else
            {
                wait 0.4;
            }
            
            continue;
        }
        
        self turretcleartarget( 0 );
        self vehclearlookat();
        wait 0.4;
    }
}

// Namespace hind/namespace_d7cff0a5
// Params 0
// Checksum 0x7db96193, Offset: 0x1438
// Size: 0x4b0
function attack_thread_rocket()
{
    self endon( #"death", #"change_state", #"end_attack_thread" );
    
    while ( true )
    {
        enemy = self.enemy;
        
        if ( !isdefined( enemy ) || is_true( self.inpain ) )
        {
            wait 1;
            continue;
        }
        
        if ( isdefined( enemy ) && self cansee( enemy ) && util::iscooldownready( "rocket_launcher" ) )
        {
            if ( isvehicle( enemy ) || isplayer( enemy ) && enemy isinvehicle() )
            {
                var_10d2ac85 = 1;
            }
            else
            {
                var_10d2ac85 = 0;
            }
            
            if ( var_10d2ac85 )
            {
                util::cooldown( "rocket_launcher", 4 );
            }
            else
            {
                util::cooldown( "rocket_launcher", 8 );
            }
            
            target = enemy.origin;
            self vehlookat( enemy );
            
            if ( var_10d2ac85 )
            {
                wait 0.5;
            }
            else
            {
                wait 1.5;
            }
            
            eye = self.origin;
            
            if ( isdefined( enemy ) )
            {
                anglestotarget = vectortoangles( enemy.origin - eye );
                angles = anglestotarget - self.angles;
                
                if ( -30 < angles[ 0 ] && angles[ 0 ] < 60 && -70 < angles[ 1 ] && angles[ 1 ] < 70 )
                {
                    target = enemy.origin;
                }
                else
                {
                    anglestotarget = vectortoangles( target - eye );
                }
            }
            else
            {
                anglestotarget = vectortoangles( target - eye );
            }
            
            rightdir = anglestoright( anglestotarget );
            offset = [];
            offset[ 0 ] = rightdir * -1 * 30 * 2 + ( randomfloatrange( 30 * -1, 30 ), randomfloatrange( 30 * -1, 30 ), 0 );
            offset[ 1 ] = rightdir * 30 * 2 + ( randomfloatrange( 30 * -1, 30 ), randomfloatrange( 30 * -1, 30 ), 0 );
            self function_cb13df0f( 0, target, offset[ 0 ], enemy );
            wait 0.5;
            
            if ( isdefined( enemy ) )
            {
                eye = self.origin;
                angles = vectortoangles( enemy.origin - eye ) - self.angles;
                
                if ( -30 < angles[ 0 ] && angles[ 0 ] < 60 && -70 < angles[ 1 ] && angles[ 1 ] < 70 )
                {
                    target = enemy.origin;
                }
            }
            
            self function_cb13df0f( 1, target, offset[ 1 ], enemy );
            wait 1;
        }
        
        wait 0.5;
    }
}

// Namespace hind/namespace_d7cff0a5
// Params 6
// Checksum 0xacbd9239, Offset: 0x18f0
// Size: 0x256
function function_cb13df0f( launcher_index, target, offset, enemy, *blinklights, *waittimeafterblinklights )
{
    self endon( #"death" );
    spawntag = self.missiletags[ offset ];
    origin = self gettagorigin( spawntag );
    angles = self gettagangles( spawntag );
    forward = anglestoforward( angles );
    up = anglestoup( angles );
    
    if ( isdefined( spawntag ) && isdefined( enemy ) )
    {
        var_48cd4f16 = 0;
        weapon = getweapon( "gunship_rockets_armada" );
        
        if ( isdefined( waittimeafterblinklights ) && is_true( self ai::function_63734291( waittimeafterblinklights ) ) )
        {
            weapon = getweapon( "gunship_rockets_armada" );
            var_48cd4f16 = 1;
        }
        
        if ( var_48cd4f16 )
        {
            v_dir = vectornormalize( waittimeafterblinklights.origin - origin );
            var_a64609fe = v_dir * 3500;
            missile = self magicmissile( weapon, origin, var_a64609fe, waittimeafterblinklights );
            return;
        }
        
        if ( isvec( enemy ) )
        {
            missile = magicbullet( weapon, origin, enemy + blinklights, self );
            return;
        }
        
        missile = magicbullet( weapon, origin, enemy.origin + blinklights, self );
    }
}

// Namespace hind/namespace_d7cff0a5
// Params 0
// Checksum 0xefe24a04, Offset: 0x1b50
// Size: 0x94
function remote_missile_life()
{
    self endon( #"death" );
    hostmigration::waitlongdurationwithhostmigrationpause( 4 );
    playfx( level.remote_mortar_fx[ #"hash_191d3387bfefeb94" ], self.origin );
    self playlocalsound( #"hash_218f0a61548364e7" );
    self delete();
}

// Namespace hind/namespace_d7cff0a5
// Params 2
// Checksum 0x741901d1, Offset: 0x1bf0
// Size: 0xf2
function getenemyarray( include_ai, include_player )
{
    enemyarray = [];
    enemy_team = #"allies";
    
    if ( is_true( include_ai ) )
    {
        aiarray = getaiteamarray( enemy_team );
        enemyarray = arraycombine( enemyarray, aiarray, 0, 0 );
    }
    
    if ( is_true( include_player ) )
    {
        playerarray = getplayers( enemy_team );
        enemyarray = arraycombine( enemyarray, playerarray, 0, 0 );
    }
    
    return enemyarray;
}

// Namespace hind/namespace_d7cff0a5
// Params 2
// Checksum 0x5fd82f8a, Offset: 0x1cf0
// Size: 0x12a
function is_point_in_view( point, do_trace )
{
    if ( !isdefined( point ) )
    {
        return 0;
    }
    
    scanner = self.frontscanner;
    vector_to_point = point - scanner.origin;
    in_view = lengthsquared( vector_to_point ) <= sqr( 10000 );
    
    if ( in_view )
    {
        in_view = util::within_fov( scanner.origin, scanner.angles, point, cos( 190 ) );
    }
    
    if ( in_view && is_true( do_trace ) && isdefined( self.enemy ) )
    {
        in_view = sighttracepassed( scanner.origin, point, 0, self.enemy );
    }
    
    return in_view;
}

// Namespace hind/namespace_d7cff0a5
// Params 2
// Checksum 0xfac41b09, Offset: 0x1e28
// Size: 0xec
function is_valid_target( target, do_trace )
{
    target_is_valid = 1;
    
    if ( is_true( target.ignoreme ) || target.health <= 0 )
    {
        target_is_valid = 0;
    }
    else if ( issentient( target ) && ( target isnotarget() || target ai::is_dead_sentient() ) )
    {
        target_is_valid = 0;
    }
    else if ( isdefined( target.origin ) && !is_point_in_view( target.origin, do_trace ) )
    {
        target_is_valid = 0;
    }
    
    return target_is_valid;
}

// Namespace hind/namespace_d7cff0a5
// Params 1
// Checksum 0x6abe5799, Offset: 0x1f20
// Size: 0x112
function get_enemies_in_view( do_trace )
{
    validenemyarray = [];
    enemyarray = getenemyarray( 1, 1 );
    
    foreach ( enemy in enemyarray )
    {
        if ( is_valid_target( enemy, do_trace ) )
        {
            if ( !isdefined( validenemyarray ) )
            {
                validenemyarray = [];
            }
            else if ( !isarray( validenemyarray ) )
            {
                validenemyarray = array( validenemyarray );
            }
            
            validenemyarray[ validenemyarray.size ] = enemy;
        }
    }
    
    return validenemyarray;
}

// Namespace hind/namespace_d7cff0a5
// Params 0
// Checksum 0xbcdbaa43, Offset: 0x2040
// Size: 0x10c
function function_2d59fe25()
{
    waitresult = self waittill( #"exit_vehicle" );
    waitresult.player val::reset( #"hunter", "ignoreme" );
    waitresult.player val::reset( #"hunter", "takedamage" );
    self setheliheightlock( 0 );
    self enableaimassist();
    self setvehicletype( self.original_vehicle_type );
    self.attachedpath = undefined;
    self setgoal( self.origin, 0, 4096, 512 );
}

// Namespace hind/namespace_d7cff0a5
// Params 1
// Checksum 0xd2833a25, Offset: 0x2158
// Size: 0x234
function function_3929047b( params )
{
    params.driver = self getseatoccupant( 0 );
    
    if ( isdefined( params.driver ) )
    {
        self disableaimassist();
        self thread vehicle_death::vehicle_damage_filter( "firestorm_turret" );
        params.driver val::set( #"hunter", "ignoreme", 1 );
        params.driver val::set( #"hunter", "takedamage", 0 );
        
        if ( isdefined( self.vehicle_weapon_override ) )
        {
            self setvehweapon( self.vehicle_weapon_override );
        }
        
        self thread function_2d59fe25();
        self thread function_e9e5bd0();
        self thread player_fire_update_side_turret_1();
        self thread player_fire_update_side_turret_2();
        self thread player_fire_update_rocket();
    }
    
    if ( isdefined( self.goal_node ) && isdefined( self.goal_node.var_db67c9d ) )
    {
        self.goal_node.var_db67c9d = undefined;
    }
    
    self turretcleartarget( 0 );
    self function_d4c687c9();
    self pathvariableoffsetclear();
    self pathfixedoffsetclear();
    self vehclearlookat();
    self resumespeed();
}

// Namespace hind/namespace_d7cff0a5
// Params 0
// Checksum 0x7cfac03d, Offset: 0x2398
// Size: 0xfe
function player_fire_update_side_turret_1()
{
    self endon( #"death", #"exit_vehicle" );
    weapon = self seatgetweapon( 1 );
    firetime = weapon.firetime;
    
    while ( true )
    {
        target = self turretgettarget( 0 );
        
        if ( isdefined( target ) )
        {
            self turretsettarget( 1, self turretgettarget( 0 ) );
            
            if ( self isdriverfiring() )
            {
                self fireweapon( 1 );
            }
        }
        
        wait firetime;
    }
}

// Namespace hind/namespace_d7cff0a5
// Params 0
// Checksum 0x233a3ebd, Offset: 0x24a0
// Size: 0xfe
function player_fire_update_side_turret_2()
{
    self endon( #"death", #"exit_vehicle" );
    weapon = self seatgetweapon( 2 );
    firetime = weapon.firetime;
    
    while ( true )
    {
        target = self turretgettarget( 0 );
        
        if ( isdefined( target ) )
        {
            self turretsettarget( 2, self turretgettarget( 0 ) );
            
            if ( self isdriverfiring() )
            {
                self fireweapon( 2 );
            }
        }
        
        wait firetime;
    }
}

// Namespace hind/namespace_d7cff0a5
// Params 0
// Checksum 0x5ec89f14, Offset: 0x25a8
// Size: 0x174
function player_fire_update_rocket()
{
    self endon( #"death", #"exit_vehicle" );
    weapon = getweapon( "gunship_rockets_armada" );
    firetime = weapon.firetime;
    driver = self getseatoccupant( 0 );
    
    while ( true )
    {
        if ( driver jumpbuttonpressed() )
        {
            spawntag0 = self.missiletags[ 0 ];
            spawntag1 = self.missiletags[ 1 ];
            origin0 = self gettagorigin( spawntag0 );
            origin1 = self gettagorigin( spawntag1 );
            target = self turretgettarget( 0 );
            magicbullet( weapon, origin0, target );
            magicbullet( weapon, origin1, target );
            wait firetime;
        }
        
        waitframe( 1 );
    }
}

// Namespace hind/namespace_d7cff0a5
// Params 0
// Checksum 0xa50aafd9, Offset: 0x2728
// Size: 0x128
function function_e9e5bd0()
{
    self endon( #"change_state", #"crash_done", #"death" );
    
    while ( true )
    {
        waitresult = self waittill( #"veh_collision" );
        velocity = waitresult.velocity;
        normal = waitresult.normal;
        driver = self getseatoccupant( 0 );
        
        if ( isdefined( driver ) && lengthsquared( velocity ) > 4900 )
        {
            earthquake( 0.25, 0.25, driver.origin, 50 );
            driver playrumbleonentity( "damage_heavy" );
        }
    }
}

// Namespace hind/namespace_d7cff0a5
// Params 0
// Checksum 0xbc31b46d, Offset: 0x2858
// Size: 0xf6
function function_15f76db9()
{
    self endon( #"death", #"emped", #"landed" );
    
    while ( isdefined( self.emped ) )
    {
        velocity = self.velocity;
        self.angles = ( self.angles[ 0 ] * 0.85, self.angles[ 1 ], self.angles[ 2 ] * 0.85 );
        ang_vel = self getangularvelocity() * 0.85;
        self setangularvelocity( ang_vel );
        self setvehvelocity( velocity );
        waitframe( 1 );
    }
}

// Namespace hind/namespace_d7cff0a5
// Params 5
// Checksum 0xc2fecae1, Offset: 0x2958
// Size: 0x1e6
function function_3787ff5( time, velocitystablizeparam, rotationstablizeparam, restorelookpoint, *emped )
{
    self endon( #"death" );
    self.painstarttime = gettime();
    
    if ( !is_true( self.inpain ) )
    {
        self.inpain = 1;
        
        while ( gettime() < self.painstarttime + int( velocitystablizeparam * 1000 ) )
        {
            self setvehvelocity( self.velocity * rotationstablizeparam );
            self setangularvelocity( self getangularvelocity() * restorelookpoint );
            wait 0.1;
        }
        
        if ( isdefined( emped ) )
        {
            restorelookent = spawn( "script_model", emped );
            restorelookent setmodel( #"tag_origin" );
            self vehclearlookat();
            self vehlookat( restorelookent );
            self turretsettarget( 0, restorelookent );
            restorelookent thread util::function_f9af3d43( 5 );
            wait 5;
            self vehclearlookat();
            self turretcleartarget( 0 );
        }
        
        self.inpain = 0;
    }
}

// Namespace hind/namespace_d7cff0a5
// Params 7
// Checksum 0xcc82638c, Offset: 0x2b48
// Size: 0x1fc
function function_7afa9936( *eattacker, *damagetype, hitpoint, hitdirection, *hitlocationinfo, *partname, emped = 0 )
{
    if ( !isdefined( hitlocationinfo ) || !isdefined( partname ) )
    {
        return;
    }
    
    if ( isdefined( self.allowpain ) && self.allowpain == 0 )
    {
        return;
    }
    
    self setvehvelocity( self.velocity + vectornormalize( partname ) * 20 );
    
    if ( !is_true( self.inpain ) )
    {
        vecright = anglestoright( self.angles );
        sign = math::sign( vectordot( vecright, partname ) );
        yaw_vel = sign * randomfloatrange( 100, 140 );
        ang_vel = self getangularvelocity();
        ang_vel += ( randomfloatrange( -120, -100 ), yaw_vel, randomfloatrange( -100, 100 ) );
        self setangularvelocity( ang_vel );
        self thread function_3787ff5( 8, 1, 0.8, hitlocationinfo, emped );
    }
}

// Namespace hind/namespace_d7cff0a5
// Params 15
// Checksum 0x55338dd4, Offset: 0x2d50
// Size: 0x1b8
function function_9dd28496( einflictor, eattacker, idamage, *idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, *vdamageorigin, *psoffsettime, *damagefromunderneath, *modelindex, partname, *vsurfacenormal )
{
    if ( isdefined( vdir ) && vdir.team == self.team )
    {
        return 0;
    }
    
    if ( !isdefined( self.damagelevel ) )
    {
        self.damagelevel = 0;
        self.newdamagelevel = self.damagelevel;
    }
    
    newdamagelevel = vehicle::should_update_damage_fx_level( self.health, shitloc, self.healthdefault );
    
    if ( newdamagelevel > self.damagelevel )
    {
        self.newdamagelevel = newdamagelevel;
    }
    
    if ( self.newdamagelevel > self.damagelevel )
    {
        self.damagelevel = self.newdamagelevel;
        function_7afa9936( vdir, vdamageorigin, damagefromunderneath, modelindex, partname, vsurfacenormal );
        vehicle::set_damage_fx_level( self.damagelevel );
    }
    
    if ( vehicle_ai::should_emp( self, psoffsettime, vdamageorigin, vpoint, vdir ) )
    {
        function_7afa9936( vdir, vdamageorigin, damagefromunderneath, modelindex, partname, vsurfacenormal, 1 );
    }
    
    return shitloc;
}

// Namespace hind/namespace_d7cff0a5
// Params 0
// Checksum 0x2cc0edd9, Offset: 0x2f10
// Size: 0x588
function function_b1bd875a()
{
    assert( isdefined( self.ai ) );
    
    if ( !isdefined( self.ai.var_88b0fd29 ) )
    {
        self.ai.var_88b0fd29 = gettime() + 1000;
        return;
    }
    
    goalinfo = self function_4794d6a3();
    assert( isdefined( goalinfo.goalpos ) );
    var_12cb92c6 = 0;
    newpos = undefined;
    point = undefined;
    
    if ( isdefined( self.favoriteenemy ) )
    {
        enemy = self.favoriteenemy;
    }
    else
    {
        enemy = self.enemy;
    }
    
    currenttime = gettime();
    forcedgoal = is_true( goalinfo.goalforced );
    isatgoal = is_true( goalinfo.isatgoal );
    haspath = self haspath();
    isapproachinggoal = !isatgoal && haspath && self isapproachinggoal();
    itsbeenawhile = currenttime >= self.ai.var_88b0fd29;
    var_ed3f071f = currenttime >= self.ai.var_88b0fd29 + 5000;
    var_48ea0381 = 0;
    
    if ( issentient( enemy ) && !haspath )
    {
        var_48ea0381 = !self seerecently( enemy, randomintrange( 3, 5 ) );
        
        if ( var_48ea0381 && issentient( enemy ) )
        {
            var_48ea0381 = !self attackedrecently( enemy, randomintrange( 5, 7 ) );
        }
    }
    
    var_3e782e85 = forcedgoal || goalinfo.goalradius < 2 * self.radius && goalinfo.goalheight < 2 * self.radius;
    var_f5ae7ee0 = isatgoal && !var_3e782e85 && ( itsbeenawhile || var_48ea0381 );
    var_633ff15a = !isatgoal && ( !isapproachinggoal || var_ed3f071f );
    var_12cb92c6 = var_f5ae7ee0 || var_633ff15a;
    
    if ( var_12cb92c6 )
    {
        if ( !isatgoal || !var_3e782e85 )
        {
            if ( var_3e782e85 )
            {
                newpos = self getclosestpointonnavvolume( goalinfo.goalpos, self.radius * 2 );
            }
            else if ( !isatgoal )
            {
                point = function_1e0d693b( goalinfo, enemy );
            }
            else if ( isdefined( enemy ) )
            {
                point = function_1e0d693b( goalinfo, enemy );
            }
            
            if ( isdefined( point ) )
            {
                newpos = point.origin;
            }
            
            if ( !isdefined( newpos ) )
            {
                newpos = self getclosestpointonnavvolume( goalinfo.goalpos, self.radius * 2 );
            }
            
            if ( !isdefined( newpos ) )
            {
                /#
                    record3dtext( "<dev string:x38>" + goalinfo.goalpos + "<dev string:x5d>" + goalinfo.goalradius + "<dev string:x6f>" + goalinfo.goalheight, self.origin + ( 0, 0, 8 ), ( 1, 0, 0 ) );
                    recordline( self.origin, goalinfo.goalpos, ( 1, 0, 0 ) );
                #/
                
                newpos = goalinfo.goalpos;
            }
            
            self.ai.var_88b0fd29 = currenttime + randomintrange( 1000, 2000 );
        }
    }
    else if ( isatgoal && var_3e782e85 )
    {
        self setspeedimmediate( 0 );
        self setvehvelocity( ( 0, 0, 0 ) );
        self setphysacceleration( ( 0, 0, 0 ) );
    }
    
    return newpos;
}

// Namespace hind/namespace_d7cff0a5
// Params 2
// Checksum 0xf4f1abeb, Offset: 0x34a0
// Size: 0xc06
function function_1e0d693b( goal, enemy )
{
    prefereddistawayfromorigin = isdefined( self.settings.var_99955aeb ) ? self.settings.var_99955aeb : 150;
    
    if ( isdefined( self.settings.engagementheightmax ) && isdefined( self.settings.engagementheightmin ) )
    {
        var_20b5eeff = 0.5 * ( self.settings.engagementheightmax + self.settings.engagementheightmin );
    }
    else
    {
        var_20b5eeff = 150;
    }
    
    var_3069c020 = isdefined( self.settings.var_2ade16ee ) ? self.settings.var_2ade16ee : 450;
    enemypos = enemy.origin;
    
    if ( function_ffa5b184( enemy ) )
    {
        enemypos = enemy.var_88f8feeb;
    }
    
    var_caa2a43c = max( prefereddistawayfromorigin, goal.goalradius + distance2d( self.origin, goal.goalpos ) );
    var_a51de54a = goal.goalheight + abs( self.origin[ 2 ] - goal.goalpos[ 2 ] );
    closedist = 1.2 * self.var_ec0d66ce;
    fardist = 3 * self.var_ec0d66ce;
    selfdisttoenemy = distance2d( self.origin, enemypos );
    querymultiplier = mapfloat( closedist, fardist, 1, 3, selfdisttoenemy );
    maxsearchradius = min( var_caa2a43c, ( isdefined( self.settings.var_3285f09a ) ? self.settings.var_3285f09a : 1000 ) * querymultiplier );
    halfheight = min( var_a51de54a / 2, ( isdefined( self.settings.var_e1d36c37 ) ? self.settings.var_e1d36c37 : 300 ) * querymultiplier );
    innerspacing = maxsearchradius / 10;
    outerspacing = innerspacing;
    queryresult = positionquery_source_navigation( enemy.origin, isdefined( self.settings.var_99955aeb ) ? self.settings.var_99955aeb : 0, maxsearchradius, halfheight, innerspacing, self, outerspacing );
    positionquery_filter_distancetogoal( queryresult, self );
    positionquery_filter_inclaimedlocation( queryresult, self );
    positionquery_filter_sight( queryresult, enemypos, self geteye() - self.origin, self, 0, enemy );
    self vehicle_ai::positionquery_filter_engagementdist( queryresult, enemy, self.settings.engagementdistmin, self.settings.engagementdistmax, var_3069c020 );
    goalheight = enemypos[ 2 ] + 0.5 * ( self.settings.engagementheightmin + self.settings.engagementheightmax );
    
    foreach ( point in queryresult.data )
    {
        if ( point.disttogoal > 0 )
        {
            score = -5000 - point.disttogoal * 2;
            
            /#
                if ( !isdefined( point._scoredebug ) )
                {
                    point._scoredebug = [];
                }
                
                if ( !isdefined( point._scoredebug[ #"outofgoalanchor" ] ) )
                {
                    point._scoredebug[ #"outofgoalanchor" ] = spawnstruct();
                }
                
                point._scoredebug[ #"outofgoalanchor" ].score = score;
                point._scoredebug[ #"outofgoalanchor" ].scorename = "<dev string:x85>";
            #/
            
            point.score += score;
        }
        
        if ( !point.visibility )
        {
            /#
                if ( !isdefined( point._scoredebug ) )
                {
                    point._scoredebug = [];
                }
                
                if ( !isdefined( point._scoredebug[ #"no visibility" ] ) )
                {
                    point._scoredebug[ #"no visibility" ] = spawnstruct();
                }
                
                point._scoredebug[ #"no visibility" ].score = -5000;
                point._scoredebug[ #"no visibility" ].scorename = "<dev string:x98>";
            #/
            
            point.score += -5000;
        }
        
        /#
            if ( !isdefined( point._scoredebug ) )
            {
                point._scoredebug = [];
            }
            
            if ( !isdefined( point._scoredebug[ #"engagementdist" ] ) )
            {
                point._scoredebug[ #"engagementdist" ] = spawnstruct();
            }
            
            point._scoredebug[ #"engagementdist" ].score = point.distawayfromengagementarea * -1;
            point._scoredebug[ #"engagementdist" ].scorename = "<dev string:xa9>";
        #/
        
        point.score += point.distawayfromengagementarea * -1;
        
        /#
            if ( !isdefined( point._scoredebug ) )
            {
                point._scoredebug = [];
            }
            
            if ( !isdefined( point._scoredebug[ #"distfromorigin" ] ) )
            {
                point._scoredebug[ #"distfromorigin" ] = spawnstruct();
            }
            
            point._scoredebug[ #"distfromorigin" ].score = mapfloat( 0, prefereddistawayfromorigin, -5000, 0, point.disttoorigin2d );
            point._scoredebug[ #"distfromorigin" ].scorename = "<dev string:xbb>";
        #/
        
        point.score += mapfloat( 0, prefereddistawayfromorigin, -5000, 0, point.disttoorigin2d );
        
        if ( point.inclaimedlocation )
        {
            /#
                if ( !isdefined( point._scoredebug ) )
                {
                    point._scoredebug = [];
                }
                
                if ( !isdefined( point._scoredebug[ #"inclaimedlocation" ] ) )
                {
                    point._scoredebug[ #"inclaimedlocation" ] = spawnstruct();
                }
                
                point._scoredebug[ #"inclaimedlocation" ].score = -5000;
                point._scoredebug[ #"inclaimedlocation" ].scorename = "<dev string:xcd>";
            #/
            
            point.score += -5000;
        }
        
        distfrompreferredheight = abs( point.origin[ 2 ] - goalheight );
        
        if ( distfrompreferredheight > var_20b5eeff )
        {
            heightscore = mapfloat( var_20b5eeff, 10000, 0, 2500, distfrompreferredheight ) * -1;
            
            /#
                if ( !isdefined( point._scoredebug ) )
                {
                    point._scoredebug = [];
                }
                
                if ( !isdefined( point._scoredebug[ #"height" ] ) )
                {
                    point._scoredebug[ #"height" ] = spawnstruct();
                }
                
                point._scoredebug[ #"height" ].score = heightscore;
                point._scoredebug[ #"height" ].scorename = "<dev string:xe2>";
            #/
            
            point.score += heightscore;
        }
        
        score = randomfloatrange( 0, 80 );
        
        /#
            if ( !isdefined( point._scoredebug ) )
            {
                point._scoredebug = [];
            }
            
            if ( !isdefined( point._scoredebug[ #"random" ] ) )
            {
                point._scoredebug[ #"random" ] = spawnstruct();
            }
            
            point._scoredebug[ #"random" ].score = score;
            point._scoredebug[ #"random" ].scorename = "<dev string:xec>";
        #/
        
        point.score += score;
    }
    
    if ( queryresult.data.size > 0 )
    {
        vehicle_ai::positionquery_postprocess_sortscore( queryresult );
        self vehicle_ai::positionquery_debugscores( queryresult );
        
        foreach ( point in queryresult.data )
        {
            return point;
        }
    }
    
    return undefined;
}

