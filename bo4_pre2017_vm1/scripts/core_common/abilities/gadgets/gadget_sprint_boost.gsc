#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace gadget_sprint_boost;

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 0, eflags: 0x2
// Checksum 0x347dc69a, Offset: 0x318
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_sprint_boost", &__init__, undefined, undefined);
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 0, eflags: 0x0
// Checksum 0x2ceb1f4b, Offset: 0x358
// Size: 0x194
function __init__() {
    ability_player::register_gadget_activation_callbacks(53, &function_27a1e5b0, &function_af7059fe);
    ability_player::register_gadget_possession_callbacks(53, &function_519579ec, &function_7a819c9a);
    ability_player::register_gadget_flicker_callbacks(53, &function_69b08fe5);
    ability_player::register_gadget_is_inuse_callbacks(53, &function_24d6ac18);
    ability_player::register_gadget_is_flickering_callbacks(53, &function_ddcf0e56);
    clientfield::register("scriptmover", "sprint_boost_aoe_fx", 1, 1, "int");
    clientfield::register("allplayers", "sprint_boost", 1, 1, "int");
    clientfield::register("toplayer", "gadget_sprint_boost_on", 1, 1, "int");
    callback::on_connect(&function_7c063fc3);
    callback::on_spawned(&function_3fcdc188);
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 1, eflags: 0x0
// Checksum 0xe4d82198, Offset: 0x4f8
// Size: 0x2a
function function_24d6ac18(slot) {
    return self flagsys::get("gadget_sprint_boost_on");
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 1, eflags: 0x0
// Checksum 0x70f04f56, Offset: 0x530
// Size: 0x22
function function_ddcf0e56(slot) {
    return self gadgetflickering(slot);
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0xa90c2ac1, Offset: 0x560
// Size: 0x34
function function_69b08fe5(slot, weapon) {
    self thread function_49a2835d(slot, weapon);
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0x9f6500bb, Offset: 0x5a0
// Size: 0x14
function function_519579ec(slot, weapon) {
    
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0xf574d016, Offset: 0x5c0
// Size: 0x14
function function_7a819c9a(slot, weapon) {
    
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x5e0
// Size: 0x4
function function_7c063fc3() {
    
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 0, eflags: 0x0
// Checksum 0xd398b06d, Offset: 0x5f0
// Size: 0x24
function function_3fcdc188() {
    self clientfield::set("sprint_boost", 0);
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0xf8477e65, Offset: 0x620
// Size: 0x94
function function_27a1e5b0(slot, weapon) {
    self thread function_ea0c66cc(slot, weapon);
    self flagsys::set("gadget_sprint_boost_on");
    self thread function_de8c04d(slot, weapon);
    self clientfield::set_to_player("gadget_sprint_boost_on", 1);
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0x5f739728, Offset: 0x6c0
// Size: 0x90
function function_af7059fe(slot, weapon) {
    wait 1.5;
    self function_b647942a(slot, weapon);
    if (isdefined(self.var_fdc803e6) && self.var_fdc803e6.size > 0) {
        function_15e582e5(slot, weapon, self.var_fdc803e6);
        self.var_fdc803e6 = [];
    }
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 3, eflags: 0x0
// Checksum 0xb1840ecf, Offset: 0x758
// Size: 0xda
function function_15e582e5(slot, weapon, players) {
    foreach (player in players) {
        if (!isdefined(player)) {
            continue;
        }
        if (!isplayer(player)) {
            continue;
        }
        player clientfield::set("sprint_boost", 0);
    }
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0x2ffe5c43, Offset: 0x840
// Size: 0x54
function function_b647942a(slot, weapon) {
    self flagsys::clear("gadget_sprint_boost_on");
    self clientfield::set_to_player("gadget_sprint_boost_on", 0);
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0x542ab431, Offset: 0x8a0
// Size: 0x3a
function function_de8c04d(slot, weapon) {
    self gadgetsetactivatetime(slot, gettime());
    self notify(#"hash_27a1e5b0");
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 1, eflags: 0x0
// Checksum 0x5a3592af, Offset: 0x8e8
// Size: 0xfc
function apply_sprint_boost(duration) {
    player = self;
    player endon(#"death");
    player endon(#"disconnect");
    player notify(#"apply_sprint_boost_singleton");
    player endon(#"apply_sprint_boost_singleton");
    player setsprintboost(1);
    duration = math::clamp(isdefined(duration) ? duration : 10, 1, 1200);
    frames_to_wait = int(duration / 0.05);
    waitframe(frames_to_wait);
    player setsprintboost(0);
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0x549ade8, Offset: 0x9f0
// Size: 0x14
function wait_until_is_done(slot, timepulse) {
    
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0x18aa45f1, Offset: 0xa10
// Size: 0x20
function function_49a2835d(slot, weapon) {
    self endon(#"disconnect");
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0x4156ff73, Offset: 0xa38
// Size: 0x14
function function_759f976(status, time) {
    
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0x9489de1e, Offset: 0xa58
// Size: 0xae
function function_ea0c66cc(slot, weapon) {
    self endon(#"disconnect");
    self notify(#"hash_ea0c66cc");
    self endon(#"hash_ea0c66cc");
    self.heroabilityactive = 1;
    var_b23522c9 = function_97b01aa3(weapon);
    self thread ability_util::aoe_friendlies(weapon, var_b23522c9);
    wait 0.25;
    self.heroabilityactive = 0;
    self notify(#"hash_7b4aab3d");
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 1, eflags: 0x0
// Checksum 0x24d318b5, Offset: 0xb10
// Size: 0x1b8
function function_97b01aa3(weapon) {
    var_b23522c9 = spawnstruct();
    var_b23522c9.radius = weapon.sprintboostradius;
    var_b23522c9.origin = self geteye();
    var_b23522c9.direction = anglestoforward(self getplayerangles());
    var_b23522c9.up = anglestoup(self getplayerangles());
    var_b23522c9.fxorg = function_df5c8ee(var_b23522c9.origin, var_b23522c9.direction);
    var_b23522c9.aoe_think_singleton_event = "sprint_boost_aoe_think";
    var_b23522c9.duration = 250;
    var_b23522c9.var_758d399e = 500;
    var_b23522c9.check_reapply_time_func = &function_d0024e78;
    var_b23522c9.can_apply_aoe_func = &function_67872ad3;
    var_b23522c9.apply_aoe_func = &function_868a9a2;
    var_b23522c9.var_e91f5742 = &function_99e4c060;
    var_b23522c9.max_applies_per_frame = 1;
    return var_b23522c9;
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0xb8059ae6, Offset: 0xcd0
// Size: 0x150
function function_df5c8ee(origin, direction) {
    if (direction == (0, 0, 0)) {
        direction = (0, 0, 1);
    }
    dirvec = vectornormalize(direction);
    angles = vectortoangles(dirvec);
    fxorg = spawn("script_model", origin + (0, 0, -30), 0, angles);
    fxorg.angles = angles;
    fxorg setowner(self);
    fxorg setmodel("tag_origin");
    fxorg clientfield::set("sprint_boost_aoe_fx", 1);
    fxorg.hitsomething = 0;
    self thread function_d18ef40b(fxorg, direction);
    return fxorg;
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 2, eflags: 0x0
// Checksum 0x5bef88f0, Offset: 0xe28
// Size: 0x84
function function_d18ef40b(fxorg, direction) {
    self waittill("sprint_boost_aoe_think", "sprint_boost_aoe_think_finished");
    if (isdefined(fxorg)) {
        fxorg stoploopsound();
        fxorg clientfield::set("sprint_boost_aoe_fx", 0);
        fxorg delete();
    }
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 3, eflags: 0x0
// Checksum 0x69a6f55c, Offset: 0xeb8
// Size: 0x74
function function_3ba3d3fd(weapon, friendly, var_b23522c9) {
    duration = weapon.sprintboostduration;
    self thread apply_sprint_boost(duration);
    self clientfield::set("sprint_boost", 1);
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 3, eflags: 0x0
// Checksum 0x7e03e147, Offset: 0xf38
// Size: 0x46
function function_67872ad3(entity, weapon, var_b23522c9) {
    if (!ability_util::aoe_trace_entity(entity, var_b23522c9, 50)) {
        return false;
    }
    return true;
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 1, eflags: 0x0
// Checksum 0x47cc563e, Offset: 0xf88
// Size: 0x3e
function function_d0024e78(aoe) {
    return isdefined(self.var_af3943a5) && self.var_af3943a5 + aoe.var_758d399e + 1 > gettime();
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 3, eflags: 0x0
// Checksum 0xbf635a5, Offset: 0xfd0
// Size: 0xca
function function_868a9a2(player, weapon, aoe) {
    player function_3ba3d3fd(weapon, aoe);
    player.var_af3943a5 = gettime();
    if (!isdefined(self.var_fdc803e6)) {
        self.var_fdc803e6 = [];
    } else if (!isarray(self.var_fdc803e6)) {
        self.var_fdc803e6 = array(self.var_fdc803e6);
    }
    self.var_fdc803e6[self.var_fdc803e6.size] = player;
}

// Namespace gadget_sprint_boost/gadget_sprint_boost
// Params 3, eflags: 0x0
// Checksum 0x5ee5cbe0, Offset: 0x10a8
// Size: 0x74
function function_99e4c060(player, weapon, aoe) {
    if (player function_d0024e78(aoe)) {
        return;
    }
    if (function_67872ad3(player, weapon, aoe)) {
        function_868a9a2(player, weapon, aoe);
    }
}

