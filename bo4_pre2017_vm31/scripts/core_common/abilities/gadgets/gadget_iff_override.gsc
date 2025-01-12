#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_iff_override;

// Namespace gadget_iff_override/gadget_iff_override
// Params 0, eflags: 0x2
// Checksum 0xd78a252c, Offset: 0x230
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_iff_override", &__init__, undefined, undefined);
}

// Namespace gadget_iff_override/gadget_iff_override
// Params 0, eflags: 0x0
// Checksum 0xc753253f, Offset: 0x270
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(24, &gadget_iff_override_on, &gadget_iff_override_off);
    ability_player::register_gadget_possession_callbacks(24, &gadget_iff_override_on_give, &gadget_iff_override_on_take);
    ability_player::register_gadget_flicker_callbacks(24, &gadget_iff_override_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(24, &gadget_iff_override_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(24, &gadget_iff_override_is_flickering);
    ability_player::register_gadget_primed_callbacks(24, &gadget_iff_override_is_primed);
    callback::on_connect(&gadget_iff_override_on_connect);
}

// Namespace gadget_iff_override/gadget_iff_override
// Params 1, eflags: 0x0
// Checksum 0x5dd6c43e, Offset: 0x380
// Size: 0x2a
function gadget_iff_override_is_inuse(slot) {
    return self flagsys::get("gadget_iff_override_on");
}

// Namespace gadget_iff_override/gadget_iff_override
// Params 1, eflags: 0x0
// Checksum 0xb3fb17ab, Offset: 0x3b8
// Size: 0x5e
function gadget_iff_override_is_flickering(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        return self [[ level.cybercom.iff_override._is_flickering ]](slot);
    }
    return 0;
}

// Namespace gadget_iff_override/gadget_iff_override
// Params 2, eflags: 0x0
// Checksum 0x31982da6, Offset: 0x420
// Size: 0x68
function gadget_iff_override_on_flicker(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        self [[ level.cybercom.iff_override._on_flicker ]](slot, weapon);
    }
}

// Namespace gadget_iff_override/gadget_iff_override
// Params 2, eflags: 0x0
// Checksum 0x6a653078, Offset: 0x490
// Size: 0x68
function gadget_iff_override_on_give(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        self [[ level.cybercom.iff_override._on_give ]](slot, weapon);
    }
}

// Namespace gadget_iff_override/gadget_iff_override
// Params 2, eflags: 0x0
// Checksum 0xb40d4200, Offset: 0x500
// Size: 0x68
function gadget_iff_override_on_take(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        self [[ level.cybercom.iff_override._on_take ]](slot, weapon);
    }
}

// Namespace gadget_iff_override/gadget_iff_override
// Params 0, eflags: 0x0
// Checksum 0x88a72b29, Offset: 0x570
// Size: 0x50
function gadget_iff_override_on_connect() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        self [[ level.cybercom.iff_override._on_connect ]]();
    }
}

// Namespace gadget_iff_override/gadget_iff_override
// Params 2, eflags: 0x0
// Checksum 0xc385b5dc, Offset: 0x5c8
// Size: 0x88
function gadget_iff_override_on(slot, weapon) {
    self flagsys::set("gadget_iff_override_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        self [[ level.cybercom.iff_override._on ]](slot, weapon);
    }
}

// Namespace gadget_iff_override/gadget_iff_override
// Params 2, eflags: 0x0
// Checksum 0xf9b2ab9c, Offset: 0x658
// Size: 0x88
function gadget_iff_override_off(slot, weapon) {
    self flagsys::clear("gadget_iff_override_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        self [[ level.cybercom.iff_override._off ]](slot, weapon);
    }
}

// Namespace gadget_iff_override/gadget_iff_override
// Params 2, eflags: 0x0
// Checksum 0x897ee4ad, Offset: 0x6e8
// Size: 0x68
function gadget_iff_override_is_primed(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        self [[ level.cybercom.iff_override._is_primed ]](slot, weapon);
    }
}

