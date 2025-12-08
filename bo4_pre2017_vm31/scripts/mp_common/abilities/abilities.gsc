#using scripts/core_common/abilities/ability_gadgets;
#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/abilities/gadgets/gadget_armor;
#using scripts/core_common/abilities/gadgets/gadget_armor_regen;
#using scripts/core_common/abilities/gadgets/gadget_camo;
#using scripts/core_common/abilities/gadgets/gadget_cleanse;
#using scripts/core_common/abilities/gadgets/gadget_clone;
#using scripts/core_common/abilities/gadgets/gadget_combat_efficiency;
#using scripts/core_common/abilities/gadgets/gadget_flashback;
#using scripts/core_common/abilities/gadgets/gadget_grapple;
#using scripts/core_common/abilities/gadgets/gadget_health_regen;
#using scripts/core_common/abilities/gadgets/gadget_heat_wave;
#using scripts/core_common/abilities/gadgets/gadget_hero_weapon;
#using scripts/core_common/abilities/gadgets/gadget_invulnerable;
#using scripts/core_common/abilities/gadgets/gadget_other;
#using scripts/core_common/abilities/gadgets/gadget_resurrect;
#using scripts/core_common/abilities/gadgets/gadget_roulette;
#using scripts/core_common/abilities/gadgets/gadget_self_destruct;
#using scripts/core_common/abilities/gadgets/gadget_shock_field;
#using scripts/core_common/abilities/gadgets/gadget_speed_burst;
#using scripts/core_common/abilities/gadgets/gadget_sprint_boost;
#using scripts/core_common/abilities/gadgets/gadget_thief;
#using scripts/core_common/abilities/gadgets/gadget_vision_pulse;
#using scripts/core_common/array_shared;
#using scripts/core_common/bots/bot;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace abilities;

// Namespace abilities/abilities
// Params 0, eflags: 0x2
// Checksum 0xebaed4dc, Offset: 0x780
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "abilities", &__init__, undefined, undefined );
}

// Namespace abilities/abilities
// Params 0
// Checksum 0x80f724d1, Offset: 0x7c0
// Size: 0x4
function __init__()
{
    
}

