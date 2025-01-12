#using scripts\core_common\clientfield_shared;
#using scripts\core_common\microwave_turret_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\auto_turret;

#namespace guardian_turret;

// Namespace guardian_turret/guardian_turret
// Params 0, eflags: 0x2
// Checksum 0x41e93360, Offset: 0xe0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"guardian_turret", &__init__, undefined, undefined);
}

// Namespace guardian_turret/guardian_turret
// Params 0, eflags: 0x0
// Checksum 0x41c48c12, Offset: 0x128
// Size: 0x2c
function __init__() {
    vehicle::add_main_callback("microwave_turret", &function_50526ce6);
}

// Namespace guardian_turret/guardian_turret
// Params 0, eflags: 0x0
// Checksum 0x1e5eb7c6, Offset: 0x160
// Size: 0x34
function function_50526ce6() {
    auto_turret::function_ea5943d6();
    guardian_init();
    function_ee2443b7();
}

// Namespace guardian_turret/guardian_turret
// Params 0, eflags: 0x0
// Checksum 0x271e041e, Offset: 0x1a0
// Size: 0xbc
function function_ee2443b7() {
    guardian = self;
    guardian vehicle_ai::get_state_callbacks("combat").update_func = &function_3d5cb7fe;
    guardian vehicle_ai::get_state_callbacks("combat").exit_func = &function_c80e5b01;
    guardian vehicle_ai::get_state_callbacks("unaware").enter_func = &function_338c2c48;
    guardian vehicle_ai::set_state("unaware");
}

// Namespace guardian_turret/guardian_turret
// Params 1, eflags: 0x0
// Checksum 0xe8e815d9, Offset: 0x268
// Size: 0x3c
function function_338c2c48(params) {
    guardian = self;
    guardian clientfield::set("turret_microwave_open", 0);
}

// Namespace guardian_turret/guardian_turret
// Params 1, eflags: 0x0
// Checksum 0xa33d2f43, Offset: 0x2b0
// Size: 0x138
function function_3d5cb7fe(params) {
    guardian = self;
    guardian endon(#"death");
    guardian endon(#"change_state");
    if (isdefined(guardian.enemy)) {
        auto_turret::sentry_turret_alert_sound();
        wait 0.5;
    }
    guardian startmicrowave();
    while (true) {
        guardian.turretrotscale = 1;
        if (isdefined(guardian.enemy) && isalive(guardian.enemy) && guardian cansee(guardian.enemy)) {
            guardian turretsettarget(0, guardian.enemy);
        }
        guardian vehicle_ai::evaluate_connections();
        wait 0.5;
    }
}

// Namespace guardian_turret/guardian_turret
// Params 1, eflags: 0x0
// Checksum 0x1e9b6efe, Offset: 0x3f0
// Size: 0x2c
function function_c80e5b01(params) {
    guardian = self;
    guardian stopmicrowave();
}

// Namespace guardian_turret/guardian_turret
// Params 0, eflags: 0x0
// Checksum 0xd04b75ce, Offset: 0x428
// Size: 0x4c
function startmicrowave() {
    guardian = self;
    guardian clientfield::set("turret_microwave_open", 1);
    guardian microwave_turret::startmicrowave();
}

// Namespace guardian_turret/guardian_turret
// Params 0, eflags: 0x0
// Checksum 0x382841b5, Offset: 0x480
// Size: 0x3c
function stopmicrowave() {
    guardian = self;
    if (isdefined(guardian)) {
        guardian clientfield::set("turret_microwave_open", 0);
    }
}

// Namespace guardian_turret/guardian_turret
// Params 2, eflags: 0x0
// Checksum 0x886f1aca, Offset: 0x4c8
// Size: 0xd8
function function_10ebfc2c(totalfiretime, enemy) {
    guardian = self;
    guardian endon(#"death");
    guardian endon(#"change_state");
    auto_turret::sentry_turret_alert_sound();
    wait 0.1;
    weapon = guardian seatgetweapon(0);
    firetime = weapon.firetime;
    for (time = 0; time < totalfiretime; time += firetime) {
        wait firetime;
    }
}

// Namespace guardian_turret/guardian_turret
// Params 0, eflags: 0x0
// Checksum 0xfa684a3, Offset: 0x5a8
// Size: 0x5e
function guardian_init() {
    guardian = self;
    guardian.maxsightdistsqrd = 450 * 450;
    guardian turret::set_on_target_angle(15, 0);
    guardian.soundmod = "hpm";
}

