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

#namespace gadget_cleanse;

// Namespace gadget_cleanse/gadget_cleanse
// Params 0, eflags: 0x2
// Checksum 0x147c285d, Offset: 0x2d0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_cleanse", &__init__, undefined, undefined);
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 0, eflags: 0x0
// Checksum 0x9d307a21, Offset: 0x310
// Size: 0x194
function __init__() {
    ability_player::register_gadget_activation_callbacks(17, &function_c6be0179, &function_d9079385);
    ability_player::register_gadget_possession_callbacks(17, &function_e8df45df, &function_db5e1e95);
    ability_player::register_gadget_flicker_callbacks(17, &function_c8cd9188);
    ability_player::register_gadget_is_inuse_callbacks(17, &function_5e9069b9);
    ability_player::register_gadget_is_flickering_callbacks(17, &function_ba97acdd);
    clientfield::register("scriptmover", "cleanse_aoe_fx", 1, 1, "int");
    clientfield::register("allplayers", "cleansed", 1, 1, "int");
    clientfield::register("toplayer", "gadget_cleanse_on", 1, 1, "int");
    callback::on_connect(&function_e5937cbe);
    callback::on_spawned(&function_fef1c1ab);
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 1, eflags: 0x0
// Checksum 0xd8d3761a, Offset: 0x4b0
// Size: 0x2a
function function_5e9069b9(slot) {
    return self flagsys::get("gadget_cleanse_on");
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 1, eflags: 0x0
// Checksum 0xcaf054f6, Offset: 0x4e8
// Size: 0x22
function function_ba97acdd(slot) {
    return self gadgetflickering(slot);
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0x7ff891ef, Offset: 0x518
// Size: 0x34
function function_c8cd9188(slot, weapon) {
    self thread function_e35dfa9e(slot, weapon);
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0xd461dff2, Offset: 0x558
// Size: 0x14
function function_e8df45df(slot, weapon) {
    
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0x445cf394, Offset: 0x578
// Size: 0x14
function function_db5e1e95(slot, weapon) {
    
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x598
// Size: 0x4
function function_e5937cbe() {
    
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 0, eflags: 0x0
// Checksum 0x1a374923, Offset: 0x5a8
// Size: 0x24
function function_fef1c1ab() {
    self clientfield::set("cleansed", 0);
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0x2b78c0a4, Offset: 0x5d8
// Size: 0x94
function function_c6be0179(slot, weapon) {
    self thread function_4d1dfd55(slot, weapon);
    self flagsys::set("gadget_cleanse_on");
    self thread function_1e438b36(slot, weapon);
    self clientfield::set_to_player("gadget_cleanse_on", 1);
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0xf5480f16, Offset: 0x678
// Size: 0x90
function function_d9079385(slot, weapon) {
    wait 1.5;
    self function_cd9f0907(slot, weapon);
    if (isdefined(self.var_3126403f) && self.var_3126403f.size > 0) {
        function_3e8556fe(slot, weapon, self.var_3126403f);
        self.var_3126403f = [];
    }
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 3, eflags: 0x0
// Checksum 0x922a0ad3, Offset: 0x710
// Size: 0xda
function function_3e8556fe(slot, weapon, players) {
    foreach (player in players) {
        if (!isdefined(player)) {
            continue;
        }
        if (!isplayer(player)) {
            continue;
        }
        player clientfield::set("cleansed", 0);
    }
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0xbddc524, Offset: 0x7f8
// Size: 0x54
function function_cd9f0907(slot, weapon) {
    self flagsys::clear("gadget_cleanse_on");
    self clientfield::set_to_player("gadget_cleanse_on", 0);
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0x52a567ee, Offset: 0x858
// Size: 0x3a
function function_1e438b36(slot, weapon) {
    self gadgetsetactivatetime(slot, gettime());
    self notify(#"hash_c6be0179");
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 0, eflags: 0x0
// Checksum 0xbf68c570, Offset: 0x8a0
// Size: 0x74
function function_79127271() {
    self setempjammed(0);
    self setnormalhealth(self.maxhealth);
    self setdoublejumpenergy(1);
    self stopshellshock();
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0x16f5cf0, Offset: 0x920
// Size: 0x14
function wait_until_is_done(slot, timepulse) {
    
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0xdd9d6f54, Offset: 0x940
// Size: 0x20
function function_e35dfa9e(slot, weapon) {
    self endon(#"disconnect");
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0x5712532b, Offset: 0x968
// Size: 0x14
function function_a64f41f5(status, time) {
    
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0x876b775a, Offset: 0x988
// Size: 0xae
function function_4d1dfd55(slot, weapon) {
    self endon(#"disconnect");
    self notify(#"hash_4d1dfd55");
    self endon(#"hash_4d1dfd55");
    self.heroabilityactive = 1;
    var_1323b794 = function_c33c63ce(weapon);
    self thread ability_util::aoe_friendlies(weapon, var_1323b794);
    wait 0.25;
    self.heroabilityactive = 0;
    self notify(#"hash_a0c9c32");
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 1, eflags: 0x0
// Checksum 0x121f7428, Offset: 0xa40
// Size: 0x1b8
function function_c33c63ce(weapon) {
    var_1323b794 = spawnstruct();
    var_1323b794.radius = weapon.gadget_cleanse_radius;
    var_1323b794.origin = self geteye();
    var_1323b794.direction = anglestoforward(self getplayerangles());
    var_1323b794.up = anglestoup(self getplayerangles());
    var_1323b794.fxorg = function_e5325dbd(var_1323b794.origin, var_1323b794.direction);
    var_1323b794.aoe_think_singleton_event = "cleanse_aoe_think";
    var_1323b794.duration = 250;
    var_1323b794.var_758d399e = 500;
    var_1323b794.check_reapply_time_func = &function_aa3177bb;
    var_1323b794.can_apply_aoe_func = &function_a720c536;
    var_1323b794.apply_aoe_func = &function_48fb25;
    var_1323b794.var_e91f5742 = &function_d7580933;
    var_1323b794.max_applies_per_frame = 1;
    return var_1323b794;
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0x9373f108, Offset: 0xc00
// Size: 0x150
function function_e5325dbd(origin, direction) {
    if (direction == (0, 0, 0)) {
        direction = (0, 0, 1);
    }
    dirvec = vectornormalize(direction);
    angles = vectortoangles(dirvec);
    fxorg = spawn("script_model", origin + (0, 0, -30), 0, angles);
    fxorg.angles = angles;
    fxorg setowner(self);
    fxorg setmodel("tag_origin");
    fxorg clientfield::set("cleanse_aoe_fx", 1);
    fxorg.hitsomething = 0;
    self thread function_eefadae4(fxorg, direction);
    return fxorg;
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0xbb7a09a7, Offset: 0xd58
// Size: 0x84
function function_eefadae4(fxorg, direction) {
    self waittill("cleanse_aoe_think", "cleanse_aoe_think_finished");
    if (isdefined(fxorg)) {
        fxorg stoploopsound();
        fxorg clientfield::set("cleanse_aoe_fx", 0);
        fxorg delete();
    }
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 3, eflags: 0x0
// Checksum 0x24371960, Offset: 0xde8
// Size: 0x54
function function_d76ad2(weapon, friendly, var_1323b794) {
    self function_79127271();
    self clientfield::set("cleansed", 1);
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 3, eflags: 0x0
// Checksum 0xc34bc026, Offset: 0xe48
// Size: 0x46
function function_a720c536(entity, weapon, var_1323b794) {
    if (!ability_util::aoe_trace_entity(entity, var_1323b794, 50)) {
        return false;
    }
    return true;
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 1, eflags: 0x0
// Checksum 0x742231d9, Offset: 0xe98
// Size: 0x3e
function function_aa3177bb(aoe) {
    return isdefined(self.var_76199f22) && self.var_76199f22 + aoe.var_758d399e + 1 > gettime();
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 3, eflags: 0x0
// Checksum 0xb3fa9101, Offset: 0xee0
// Size: 0xca
function function_48fb25(player, weapon, aoe) {
    player function_d76ad2(weapon, aoe);
    player.var_76199f22 = gettime();
    if (!isdefined(self.var_3126403f)) {
        self.var_3126403f = [];
    } else if (!isarray(self.var_3126403f)) {
        self.var_3126403f = array(self.var_3126403f);
    }
    self.var_3126403f[self.var_3126403f.size] = player;
}

// Namespace gadget_cleanse/gadget_cleanse
// Params 3, eflags: 0x0
// Checksum 0xf5710da8, Offset: 0xfb8
// Size: 0x74
function function_d7580933(player, weapon, aoe) {
    if (player function_aa3177bb(aoe)) {
        return;
    }
    if (function_a720c536(player, weapon, aoe)) {
        function_48fb25(player, weapon, aoe);
    }
}

