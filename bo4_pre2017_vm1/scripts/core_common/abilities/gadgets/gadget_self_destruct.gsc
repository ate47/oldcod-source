#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace namespace_ad6bb417;

// Namespace namespace_ad6bb417/namespace_ad6bb417
// Params 0, eflags: 0x2
// Checksum 0xe0d71d07, Offset: 0x220
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_self_destruct", &__init__, undefined, undefined);
}

// Namespace namespace_ad6bb417/namespace_ad6bb417
// Params 0, eflags: 0x0
// Checksum 0x44a16afb, Offset: 0x260
// Size: 0x134
function __init__() {
    ability_player::register_gadget_activation_callbacks(55, &function_f85adafd, &function_46de2b09);
    ability_player::register_gadget_possession_callbacks(55, &function_93efc53b, &function_90c4e919);
    ability_player::register_gadget_flicker_callbacks(55, &function_7016de9c);
    ability_player::register_gadget_is_inuse_callbacks(55, &function_daabb75d);
    ability_player::register_gadget_is_flickering_callbacks(55, &function_f0b1d3e9);
    callback::on_connect(&function_f87bb792);
    callback::on_spawned(&on_player_spawned);
    clientfield::register("scriptmover", "death_fx", 1, 1, "int");
}

// Namespace namespace_ad6bb417/namespace_ad6bb417
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3a0
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace namespace_ad6bb417/namespace_ad6bb417
// Params 1, eflags: 0x0
// Checksum 0xd4d8f31d, Offset: 0x3b0
// Size: 0x22
function function_daabb75d(slot) {
    return self gadgetisactive(slot);
}

// Namespace namespace_ad6bb417/namespace_ad6bb417
// Params 1, eflags: 0x0
// Checksum 0x72d1da2c, Offset: 0x3e0
// Size: 0x22
function function_f0b1d3e9(slot) {
    return self gadgetflickering(slot);
}

// Namespace namespace_ad6bb417/namespace_ad6bb417
// Params 2, eflags: 0x0
// Checksum 0xf169276b, Offset: 0x410
// Size: 0x14
function function_7016de9c(slot, weapon) {
    
}

// Namespace namespace_ad6bb417/namespace_ad6bb417
// Params 2, eflags: 0x0
// Checksum 0x22f7b167, Offset: 0x430
// Size: 0x14
function function_93efc53b(slot, weapon) {
    
}

// Namespace namespace_ad6bb417/namespace_ad6bb417
// Params 2, eflags: 0x0
// Checksum 0x142129ac, Offset: 0x450
// Size: 0x14
function function_90c4e919(slot, weapon) {
    
}

// Namespace namespace_ad6bb417/namespace_ad6bb417
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x470
// Size: 0x4
function function_f87bb792() {
    
}

// Namespace namespace_ad6bb417/namespace_ad6bb417
// Params 2, eflags: 0x0
// Checksum 0x8a980ab7, Offset: 0x480
// Size: 0x44
function function_f85adafd(slot, weapon) {
    self thread function_a1555ab8();
    self thread function_4f21f34b();
}

// Namespace namespace_ad6bb417/namespace_ad6bb417
// Params 2, eflags: 0x0
// Checksum 0x53317a25, Offset: 0x4d0
// Size: 0x14
function function_46de2b09(slot, weapon) {
    
}

// Namespace namespace_ad6bb417/namespace_ad6bb417
// Params 0, eflags: 0x0
// Checksum 0x52db9917, Offset: 0x4f0
// Size: 0xd4
function function_a1555ab8() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"hash_d2a76be4");
    self disableweapons();
    self setclientthirdperson(1);
    wait 5;
    origin = self geteye();
    self function_b89a4868();
    radiusdamage(origin, 500, 500, 500, self, "MOD_EXPLOSIVE");
    self kill();
}

// Namespace namespace_ad6bb417/namespace_ad6bb417
// Params 0, eflags: 0x0
// Checksum 0xbb5b486, Offset: 0x5d0
// Size: 0x174
function function_b89a4868() {
    origin = self geteye();
    direction = anglestoforward(self getplayerangles());
    if (direction == (0, 0, 0)) {
        direction = (0, 0, 1);
    }
    dirvec = vectornormalize(direction);
    angles = vectortoangles(dirvec);
    fxorg = spawn("script_model", origin + (0, 0, -30), 0, angles);
    fxorg.angles = angles;
    fxorg setowner(self);
    fxorg setmodel("tag_origin");
    fxorg clientfield::set("death_fx", 1);
    level thread function_3c6f8127(fxorg);
}

// Namespace namespace_ad6bb417/namespace_ad6bb417
// Params 1, eflags: 0x0
// Checksum 0x511af48a, Offset: 0x750
// Size: 0x54
function function_3c6f8127(fxorg) {
    wait 5;
    if (isdefined(fxorg)) {
        fxorg clientfield::set("heatwave_fx", 0);
        fxorg delete();
    }
}

// Namespace namespace_ad6bb417/namespace_ad6bb417
// Params 0, eflags: 0x0
// Checksum 0x9d8d0b2e, Offset: 0x7b0
// Size: 0xb8
function function_4f21f34b() {
    self endon(#"death");
    self endon(#"disconnect");
    starttime = gettime();
    while (true) {
        if (!self usebuttonpressed()) {
            starttime = gettime();
        }
        if (starttime + 0.5 < gettime()) {
            self notify(#"hash_d2a76be4");
            self setclientthirdperson(0);
            self enableweapons();
            return;
        }
        waitframe(1);
    }
}

