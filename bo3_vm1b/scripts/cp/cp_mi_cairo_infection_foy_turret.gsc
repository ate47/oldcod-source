#using scripts/codescripts/struct;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace foy_turret;

// Namespace foy_turret
// Method(s) 0 Total 0
class class_6fd92933
{

}

// Namespace foy_turret
// Params 0, eflags: 0x2
// Checksum 0xbf5b3d42, Offset: 0x298
// Size: 0x2a
function autoexec __init__sytem__()
{
    system::register( "foy_turret", &__init__, undefined, undefined );
}

// Namespace foy_turret
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x2d0
// Size: 0x2
function __init__()
{
    
}

#namespace cfoyturret;

// Namespace cfoyturret
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x2e0
// Size: 0x2
function __constructor()
{
    
}

// Namespace cfoyturret
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x2f0
// Size: 0x2
function __destructor()
{
    
}

// Namespace cfoyturret
// Params 3
// Checksum 0x4667b0a3, Offset: 0x300
// Size: 0xda
function turret_setup( vehicle, str_gunner_name, str_gunner_trigger )
{
    self.m_vehicle = vehicle;
    self.m_vehicle flag::init( "gunner_position_occupied" );
    
    if ( isdefined( str_gunner_name ) )
    {
        sp_gunner = getent( str_gunner_name, "targetname" );
        ai_gunner = spawner::simple_spawn_single( sp_gunner );
        ai_gunner vehicle::get_in( self.m_vehicle, "driver", 1 );
    }
    
    if ( isdefined( str_gunner_trigger ) )
    {
        self.m_t_gunner = getent( str_gunner_trigger, "targetname" );
    }
    
    self thread turret_think();
}

// Namespace cfoyturret
// Params 0
// Checksum 0xf06699b0, Offset: 0x3e8
// Size: 0x62
function turret_think()
{
    self.m_vehicle endon( #"death" );
    self thread vehicle_death();
    self waittill( #"gunner_start_think" );
    
    if ( isdefined( self.m_t_gunner ) )
    {
        self thread gunner_think( 1 );
        return;
    }
    
    self thread gunner_think( 0 );
}

// Namespace cfoyturret
// Params 0
// Checksum 0x23131268, Offset: 0x458
// Size: 0xb
function gunner_start_think()
{
    self notify( #"gunner_start_think" );
}

// Namespace cfoyturret
// Params 1
// Checksum 0xfe869fc5, Offset: 0x470
// Size: 0x1dd
function gunner_think( b_find_new_gunner )
{
    if ( !isdefined( b_find_new_gunner ) )
    {
        b_find_new_gunner = 0;
    }
    
    self.m_vehicle endon( #"death" );
    self.m_vehicle turret::set_burst_parameters( 1, 2, 0.25, 0.75, 0 );
    
    while ( true )
    {
        ai_gunner = self.m_vehicle vehicle::get_rider( "driver" );
        
        if ( isdefined( ai_gunner ) )
        {
            self.m_vehicle turret::enable( 0, 1 );
            self.m_vehicle flag::set( "gunner_position_occupied" );
            ai_gunner waittill( #"death" );
            level notify( self.m_vehicle.targetname + "_gunner_death" );
        }
        
        self.m_vehicle turret::disable( 0 );
        self.m_vehicle flag::clear( "gunner_position_occupied" );
        
        if ( b_find_new_gunner )
        {
            wait randomfloatrange( 4, 5 );
            ai_gunner_next = find_new_gunner();
            
            if ( isalive( ai_gunner_next ) )
            {
                ai_gunner_next thread vehicle::get_in( self.m_vehicle, "driver", 0 );
                ai_gunner_next util::waittill_any( "death", "in_vehicle" );
            }
            
            continue;
        }
        
        break;
    }
}

// Namespace cfoyturret
// Params 0
// Checksum 0xa204b6de, Offset: 0x658
// Size: 0x42
function delete_gunner()
{
    ai_gunner = self.m_vehicle vehicle::get_rider( "driver" );
    
    if ( isdefined( ai_gunner ) )
    {
        ai_gunner delete();
    }
}

// Namespace cfoyturret
// Params 0
// Checksum 0x95caecb0, Offset: 0x6a8
// Size: 0x2a
function vehicle_death()
{
    self.m_vehicle waittill( #"death" );
    delete_gunner();
    self.m_vehicle = undefined;
}

// Namespace cfoyturret
// Params 0
// Checksum 0x673c657f, Offset: 0x6e0
// Size: 0x117
function find_new_gunner()
{
    a_enemies = getaiteamarray( "axis" );
    a_valid = [];
    
    foreach ( e_enemy in a_enemies )
    {
        if ( isalive( e_enemy ) )
        {
            if ( e_enemy istouching( self.m_t_gunner ) )
            {
                if ( !isdefined( a_valid ) )
                {
                    a_valid = [];
                }
                else if ( !isarray( a_valid ) )
                {
                    a_valid = array( a_valid );
                }
                
                a_valid[ a_valid.size ] = e_enemy;
            }
        }
    }
    
    ai_gunner = arraysort( a_valid, self.m_vehicle.origin, 1, a_valid.size )[ 0 ];
    return ai_gunner;
}

// Namespace cfoyturret
// Params 0
// Checksum 0xf4c37130, Offset: 0x800
// Size: 0x9
function get_vehicle()
{
    return self.m_vehicle;
}

