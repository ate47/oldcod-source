#using scripts\core_common\clientfield_shared;
#using scripts\core_common\microwave_turret_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\auto_turret;

#namespace guardian_turret;

// Namespace guardian_turret/guardian_turret
// Params 0, eflags: 0x6
// Checksum 0x3ad8544b, Offset: 0xe8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"guardian_turret", &preinit, undefined, undefined, undefined);
}

// Namespace guardian_turret/guardian_turret
// Params 0, eflags: 0x4
// Checksum 0x7d91dd94, Offset: 0x130
// Size: 0x2c
function private preinit() {
    vehicle::add_main_callback("microwave_turret", &function_5dfbc20a);
}

// Namespace guardian_turret/guardian_turret
// Params 0, eflags: 0x0
// Checksum 0x251aeb60, Offset: 0x168
// Size: 0x34
function function_5dfbc20a() {
    auto_turret::function_f17009ff();
    guardian_init();
    function_4dc5ff34();
}

// Namespace guardian_turret/guardian_turret
// Params 0, eflags: 0x0
// Checksum 0xbfdc0ebf, Offset: 0x1a8
// Size: 0xbc
function function_4dc5ff34() {
    guardian = self;
    guardian vehicle_ai::get_state_callbacks("combat").update_func = &function_21304ee6;
    guardian vehicle_ai::get_state_callbacks("combat").exit_func = &function_4ea89e5a;
    guardian vehicle_ai::get_state_callbacks("unaware").enter_func = &function_ab51fb9e;
    guardian vehicle_ai::set_state("unaware");
}

// Namespace guardian_turret/guardian_turret
// Params 1, eflags: 0x0
// Checksum 0x678a9e68, Offset: 0x270
// Size: 0x3c
function function_ab51fb9e(*params) {
    guardian = self;
    guardian clientfield::set("turret_microwave_open", 0);
}

// Namespace guardian_turret/guardian_turret
// Params 1, eflags: 0x0
// Checksum 0x44adf143, Offset: 0x2b8
// Size: 0x130
function function_21304ee6(*params) {
    guardian = self;
    guardian endon(#"death", #"change_state");
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
// Checksum 0x5c2f6a79, Offset: 0x3f0
// Size: 0x2c
function function_4ea89e5a(*params) {
    guardian = self;
    guardian stopmicrowave();
}

// Namespace guardian_turret/guardian_turret
// Params 0, eflags: 0x0
// Checksum 0xd0ff00a4, Offset: 0x428
// Size: 0x4c
function startmicrowave() {
    guardian = self;
    guardian clientfield::set("turret_microwave_open", 1);
    guardian microwave_turret::startmicrowave();
}

// Namespace guardian_turret/guardian_turret
// Params 0, eflags: 0x0
// Checksum 0x643a723f, Offset: 0x480
// Size: 0x3c
function stopmicrowave() {
    guardian = self;
    if (isdefined(guardian)) {
        guardian clientfield::set("turret_microwave_open", 0);
    }
}

// Namespace guardian_turret/guardian_turret
// Params 2, eflags: 0x0
// Checksum 0xf3dd0749, Offset: 0x4c8
// Size: 0xc4
function function_e341abb9(totalfiretime, *enemy) {
    guardian = self;
    guardian endon(#"death", #"change_state");
    auto_turret::sentry_turret_alert_sound();
    wait 0.1;
    weapon = guardian seatgetweapon(0);
    firetime = weapon.firetime;
    for (time = 0; time < enemy; time += firetime) {
        wait firetime;
    }
}

// Namespace guardian_turret/guardian_turret
// Params 0, eflags: 0x0
// Checksum 0x474f33f3, Offset: 0x598
// Size: 0x5a
function guardian_init() {
    guardian = self;
    guardian.maxsightdistsqrd = 450 * 450;
    guardian turret::set_on_target_angle(15, 0);
    guardian.soundmod = "hpm";
}

