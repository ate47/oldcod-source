#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace gadget_shock_field;

// Namespace gadget_shock_field/gadget_shock_field
// Params 0, eflags: 0x2
// Checksum 0x276ea341, Offset: 0x298
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_shock_field", &__init__, undefined, undefined);
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 0, eflags: 0x0
// Checksum 0xc13cd67e, Offset: 0x2d8
// Size: 0x114
function __init__() {
    clientfield::register("allplayers", "shock_field", 1, 1, "int");
    ability_player::register_gadget_activation_callbacks(39, &gadget_shock_field_on, &gadget_shock_field_off);
    ability_player::register_gadget_possession_callbacks(39, &gadget_shock_field_on_give, &gadget_shock_field_on_take);
    ability_player::register_gadget_flicker_callbacks(39, &gadget_shock_field_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(39, &gadget_shock_field_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(39, &gadget_shock_field_is_flickering);
    callback::on_connect(&gadget_shock_field_on_connect);
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 1, eflags: 0x0
// Checksum 0x1a26604f, Offset: 0x3f8
// Size: 0x22
function gadget_shock_field_is_inuse(slot) {
    return self gadgetisactive(slot);
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 1, eflags: 0x0
// Checksum 0x494840f5, Offset: 0x428
// Size: 0xc
function gadget_shock_field_is_flickering(slot) {
    
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 2, eflags: 0x0
// Checksum 0x2d98975b, Offset: 0x440
// Size: 0x14
function gadget_shock_field_on_flicker(slot, weapon) {
    
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 2, eflags: 0x0
// Checksum 0x151b11a5, Offset: 0x460
// Size: 0x34
function gadget_shock_field_on_give(slot, weapon) {
    self clientfield::set("shock_field", 0);
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 2, eflags: 0x0
// Checksum 0x65653908, Offset: 0x4a0
// Size: 0x34
function gadget_shock_field_on_take(slot, weapon) {
    self clientfield::set("shock_field", 0);
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x4e0
// Size: 0x4
function gadget_shock_field_on_connect() {
    
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 2, eflags: 0x0
// Checksum 0x533b7172, Offset: 0x4f0
// Size: 0x6c
function gadget_shock_field_on(slot, weapon) {
    self gadgetsetactivatetime(slot, gettime());
    self thread shock_field_think(slot, weapon);
    self clientfield::set("shock_field", 1);
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 2, eflags: 0x0
// Checksum 0xe0b3a60d, Offset: 0x568
// Size: 0x44
function gadget_shock_field_off(slot, weapon) {
    self notify(#"shock_field_off");
    self clientfield::set("shock_field", 0);
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 2, eflags: 0x0
// Checksum 0x9790c27c, Offset: 0x5b8
// Size: 0x2e6
function shock_field_think(slot, weapon) {
    self endon(#"shock_field_off");
    self notify(#"shock_field_on");
    self endon(#"shock_field_on");
    while (true) {
        wait 0.25;
        if (!self gadget_shock_field_is_inuse(slot)) {
            return;
        }
        entities = getdamageableentarray(self.origin, weapon.gadget_shockfield_radius);
        foreach (entity in entities) {
            if (isplayer(entity)) {
                if (self getentitynumber() == entity getentitynumber()) {
                    continue;
                }
                if (self.team == entity.team) {
                    continue;
                }
                if (!isalive(entity)) {
                    continue;
                }
                if (bullettracepassed(self.origin + (0, 0, 30), entity.origin + (0, 0, 30), 1, self, undefined, 0, 1)) {
                    entity dodamage(weapon.gadget_shockfield_damage, self.origin + (0, 0, 30), self, self, 0, "MOD_GRENADE_SPLASH");
                    entity setdoublejumpenergy(0);
                    entity resetdoublejumprechargetime();
                    entity thread shock_field_zap_sound(weapon);
                    self thread flicker_field_fx();
                    shellshock_duration = 0.25;
                    if (entity util::mayapplyscreeneffect()) {
                        shellshock_duration = 0.5;
                        entity shellshock("proximity_grenade", shellshock_duration, 0);
                    }
                }
            }
        }
    }
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 1, eflags: 0x0
// Checksum 0x4b40287b, Offset: 0x8a8
// Size: 0x78
function shock_field_zap_sound(weapon) {
    if (isdefined(self.shock_field_zap_sound) && self.shock_field_zap_sound) {
        return;
    }
    self.shock_field_zap_sound = 1;
    self playsound("wpn_taser_mine_zap");
    wait 1;
    if (isdefined(self)) {
        self.shock_field_zap_sound = 0;
    }
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 0, eflags: 0x0
// Checksum 0xf3eb016d, Offset: 0x928
// Size: 0x94
function flicker_field_fx() {
    self endon(#"shock_field_off");
    self notify(#"flicker_field_fx");
    self endon(#"flicker_field_fx");
    self clientfield::set("shock_field", 0);
    wait randomfloatrange(0.03, 0.23);
    if (isdefined(self)) {
        self clientfield::set("shock_field", 1);
    }
}

