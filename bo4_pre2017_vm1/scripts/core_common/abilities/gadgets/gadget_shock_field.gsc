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
function autoexec function_2dc19561() {
    system::register("gadget_shock_field", &__init__, undefined, undefined);
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 0, eflags: 0x0
// Checksum 0xc13cd67e, Offset: 0x2d8
// Size: 0x114
function __init__() {
    clientfield::register("allplayers", "shock_field", 1, 1, "int");
    ability_player::register_gadget_activation_callbacks(39, &function_be1dbd79, &function_44bc8785);
    ability_player::register_gadget_possession_callbacks(39, &function_87ef79df, &function_7a6e5295);
    ability_player::register_gadget_flicker_callbacks(39, &function_6ee8cd88);
    ability_player::register_gadget_is_inuse_callbacks(39, &function_c51245b9);
    ability_player::register_gadget_is_flickering_callbacks(39, &function_578640dd);
    callback::on_connect(&function_8baeb8be);
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 1, eflags: 0x0
// Checksum 0x1a26604f, Offset: 0x3f8
// Size: 0x22
function function_c51245b9(slot) {
    return self gadgetisactive(slot);
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 1, eflags: 0x0
// Checksum 0x494840f5, Offset: 0x428
// Size: 0xc
function function_578640dd(slot) {
    
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 2, eflags: 0x0
// Checksum 0x2d98975b, Offset: 0x440
// Size: 0x14
function function_6ee8cd88(slot, weapon) {
    
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 2, eflags: 0x0
// Checksum 0x151b11a5, Offset: 0x460
// Size: 0x34
function function_87ef79df(slot, weapon) {
    self clientfield::set("shock_field", 0);
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 2, eflags: 0x0
// Checksum 0x65653908, Offset: 0x4a0
// Size: 0x34
function function_7a6e5295(slot, weapon) {
    self clientfield::set("shock_field", 0);
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x4e0
// Size: 0x4
function function_8baeb8be() {
    
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 2, eflags: 0x0
// Checksum 0x533b7172, Offset: 0x4f0
// Size: 0x6c
function function_be1dbd79(slot, weapon) {
    self gadgetsetactivatetime(slot, gettime());
    self thread function_b7cb65ad(slot, weapon);
    self clientfield::set("shock_field", 1);
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 2, eflags: 0x0
// Checksum 0xe0b3a60d, Offset: 0x568
// Size: 0x44
function function_44bc8785(slot, weapon) {
    self notify(#"hash_1cfd23e2");
    self clientfield::set("shock_field", 0);
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 2, eflags: 0x0
// Checksum 0x9790c27c, Offset: 0x5b8
// Size: 0x2e6
function function_b7cb65ad(slot, weapon) {
    self endon(#"hash_1cfd23e2");
    self notify(#"hash_a47188d4");
    self endon(#"hash_a47188d4");
    while (true) {
        wait 0.25;
        if (!self function_c51245b9(slot)) {
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
                    entity thread function_6fed7bc4(weapon);
                    self thread function_9144a83();
                    var_2b155dcc = 0.25;
                    if (entity util::mayapplyscreeneffect()) {
                        var_2b155dcc = 0.5;
                        entity shellshock("proximity_grenade", var_2b155dcc, 0);
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
function function_6fed7bc4(weapon) {
    if (isdefined(self.var_6fed7bc4) && self.var_6fed7bc4) {
        return;
    }
    self.var_6fed7bc4 = 1;
    self playsound("wpn_taser_mine_zap");
    wait 1;
    if (isdefined(self)) {
        self.var_6fed7bc4 = 0;
    }
}

// Namespace gadget_shock_field/gadget_shock_field
// Params 0, eflags: 0x0
// Checksum 0xf3eb016d, Offset: 0x928
// Size: 0x94
function function_9144a83() {
    self endon(#"hash_1cfd23e2");
    self notify(#"hash_9144a83");
    self endon(#"hash_9144a83");
    self clientfield::set("shock_field", 0);
    wait randomfloatrange(0.03, 0.23);
    if (isdefined(self)) {
        self clientfield::set("shock_field", 1);
    }
}

