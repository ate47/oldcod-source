#using scripts\core_common\stealth\debug;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\event;
#using scripts\core_common\stealth\group;

#namespace namespace_578db516;

// Namespace namespace_578db516/neutral
// Params 0
// Checksum 0x10c09c70, Offset: 0x98
// Size: 0x134
function main()
{
    if ( isdefined( self.stealth ) )
    {
        return;
    }
    
    self stealth_enemy::init_settings();
    self.neutralsenses = 1;
    self stealth_enemy::init_flags();
    stealth_group::addtogroup( self.script_stealthgroup, self );
    self stealth_enemy::setpatrolstyle_base();
    self stealth_event::event_init_entity();
    self thread stealth_enemy::monitor_damage_thread( level.stealth.damage_auto_range, level.stealth.damage_sight_range );
    
    /#
        self thread stealth_debug::debug_enemy();
    #/
    
    self stealth_enemy::set_alert_level( "reset" );
    self stealth_enemy::bt_set_stealth_state( "idle" );
    self stealth_enemy::stealth_init_goal_radius();
}

