#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_8eb9bc0a;

// Namespace namespace_8eb9bc0a/namespace_8eb9bc0a
// Params 0, eflags: 0x6
// Checksum 0x46bbe814, Offset: 0x220
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_6d3c5317001d4fc6", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_8eb9bc0a/namespace_8eb9bc0a
// Params 0, eflags: 0x5 linked
// Checksum 0xd0cead32, Offset: 0x268
// Size: 0x104
function private function_70a657d8() {
    setdvar(#"hash_6d3c5317001d4fc6", 0);
    /#
        adddebugcommand("<dev string:x38>");
        adddebugcommand("<dev string:x7e>");
        adddebugcommand("<dev string:xd2>");
        adddebugcommand("<dev string:x119>");
        adddebugcommand("<dev string:x16a>");
    #/
    var_852d7a5c = isprofilebuild();
    /#
        var_852d7a5c = 1;
    #/
    if (var_852d7a5c) {
        level thread function_97346595();
        level thread function_d379ba37();
    }
}

// Namespace namespace_8eb9bc0a/namespace_8eb9bc0a
// Params 0, eflags: 0x1 linked
// Checksum 0x6c663f98, Offset: 0x378
// Size: 0x394
function zombie_open_sesame() {
    setdvar(#"zombie_unlock_all", 1);
    level flag::set("power_on");
    level clientfield::set("zombie_power_on", 1);
    power_trigs = getentarray("use_elec_switch", "targetname");
    foreach (trig in power_trigs) {
        if (isdefined(trig.script_int)) {
            level flag::set("power_on" + trig.script_int);
            level clientfield::set("zombie_power_on", trig.script_int + 1);
        }
    }
    players = getplayers();
    zombie_doors = getentarray("zombie_door", "targetname");
    for (i = 0; i < zombie_doors.size; i++) {
        if (!is_true(zombie_doors[i].has_been_opened)) {
            zombie_doors[i] notify(#"trigger", {#activator:players[0]});
        }
        if (is_true(zombie_doors[i].power_door_ignore_flag_wait)) {
            zombie_doors[i] notify(#"power_on");
        }
        waitframe(1);
    }
    zombie_airlock_doors = getentarray("zombie_airlock_buy", "targetname");
    for (i = 0; i < zombie_airlock_doors.size; i++) {
        zombie_airlock_doors[i] notify(#"trigger", {#activator:players[0]});
        waitframe(1);
    }
    zombie_debris = getentarray("zombie_debris", "targetname");
    for (i = 0; i < zombie_debris.size; i++) {
        if (isdefined(zombie_debris[i])) {
            zombie_debris[i] notify(#"trigger", {#activator:players[0]});
        }
        waitframe(1);
    }
    level notify(#"open_sesame");
    wait 1;
    setdvar(#"zombie_unlock_all", 0);
}

// Namespace namespace_8eb9bc0a/namespace_8eb9bc0a
// Params 0, eflags: 0x1 linked
// Checksum 0xb3ca9087, Offset: 0x718
// Size: 0x28a
function function_97346595() {
    var_2e0b8925 = getdvarint(#"hash_6d3c5317001d4fc6", 0);
    while (true) {
        new_value = getdvarint(#"hash_6d3c5317001d4fc6", 0);
        players = getplayers();
        if (new_value != var_2e0b8925) {
            /#
                if (!(var_2e0b8925 && new_value)) {
                    adddebugcommand("<dev string:x1b9>");
                }
            #/
            if (new_value != 0) {
                foreach (player in players) {
                    player enableinvulnerability();
                }
                if (new_value == 2) {
                    level thread zombie_open_sesame();
                }
                remainingplayers = 4 - players.size;
                /#
                    adddebugcommand("<dev string:x1c0>" + remainingplayers);
                #/
                waitframe(1);
                /#
                    adddebugcommand("<dev string:x1e0>");
                #/
            } else {
                /#
                    adddebugcommand("<dev string:x1fc>");
                #/
                players = getplayers();
                foreach (player in players) {
                    player disableinvulnerability();
                }
            }
        }
        var_2e0b8925 = new_value;
        waitframe(1);
    }
}

// Namespace namespace_8eb9bc0a/namespace_8eb9bc0a
// Params 0, eflags: 0x1 linked
// Checksum 0x8827cd49, Offset: 0x9b0
// Size: 0xca
function function_d379ba37() {
    setdvar(#"hash_429bdf1368d1a22c", "");
    while (true) {
        if (getdvarint(#"hash_429bdf1368d1a22c", 0) > 0) {
            if (!is_true(level.var_a095060b)) {
                level thread function_57bf0556();
            }
        } else if (is_true(level.var_a095060b)) {
            level notify(#"hash_12d79bc0fed4ee5a");
        }
        waitframe(1);
    }
}

// Namespace namespace_8eb9bc0a/namespace_8eb9bc0a
// Params 0, eflags: 0x1 linked
// Checksum 0xccad2550, Offset: 0xa88
// Size: 0x328
function function_57bf0556() {
    self notify("616d873b8be1f610");
    self endon("616d873b8be1f610");
    level endon(#"hash_12d79bc0fed4ee5a");
    level.botcount = 0;
    level thread function_db3aef8f();
    level.var_a095060b = 1;
    setdvar(#"hash_2167ce61af5dc0b0", 0);
    setdvar(#"zm_instajoin", 1);
    function_f5f0c0f8("Soak Test [ON]");
    level thread function_e5266c17();
    while (level.var_a095060b) {
        if (getdvarint(#"hash_2fe8fa3077b74221", 1) > 1) {
            wait randomfloatrange(0.2, 0.6);
        } else {
            wait randomintrange(2, 6);
        }
        if (level.botcount > 0 && randomint(100) > 70) {
            bot::remove_random_bot();
            level.botcount--;
            function_f5f0c0f8("Bot is being removed.   Count=" + level.botcount);
            continue;
        }
        if (getdvarint(#"hash_4a501e2ed929dd5b", 1) && getplayers().size < 4 && randomint(100) < 30) {
            bot = bot::add_bot(#"allies", function_a161addf(), "ZM");
            bot allow_all(1);
            plr = getplayers()[0];
            bot setorigin(plr.origin);
            level.botcount++;
            function_f5f0c0f8("Bot is being added.  Count=" + level.botcount);
        }
    }
    level notify(#"hash_12d79bc0fed4ee5a");
}

// Namespace namespace_8eb9bc0a/namespace_8eb9bc0a
// Params 0, eflags: 0x1 linked
// Checksum 0x76795b97, Offset: 0xdb8
// Size: 0x44
function function_e5266c17() {
    self notify("16d5586c27557925");
    self endon("16d5586c27557925");
    level waittill(#"hash_12d79bc0fed4ee5a");
    bot::remove_bots();
}

// Namespace namespace_8eb9bc0a/namespace_8eb9bc0a
// Params 0, eflags: 0x1 linked
// Checksum 0x4cf03566, Offset: 0xe08
// Size: 0xa4
function function_db3aef8f() {
    self notify("25a90f69e2451ed7");
    self endon("25a90f69e2451ed7");
    level waittill(#"hash_12d79bc0fed4ee5a");
    level.var_a095060b = 0;
    function_f5f0c0f8("DOA Soak Test [OFF]");
    setdvar(#"hash_2167ce61af5dc0b0", 1);
    setdvar(#"zm_instajoin", 0);
}

// Namespace namespace_8eb9bc0a/namespace_8eb9bc0a
// Params 1, eflags: 0x1 linked
// Checksum 0xd9027535, Offset: 0xeb8
// Size: 0x34
function function_f5f0c0f8(var_4e2d590d) {
    println("<dev string:x219>" + var_4e2d590d);
}

// Namespace namespace_8eb9bc0a/namespace_8eb9bc0a
// Params 0, eflags: 0x1 linked
// Checksum 0x2a394e00, Offset: 0xef8
// Size: 0x128
function function_a161addf() {
    colors = array("green", "blue", "red", "yellow");
    used = [];
    guys = getplayers();
    foreach (guy in guys) {
        used[used.size] = guy.doa.color;
    }
    valid = array::exclude(colors, used);
    return "TEST MONKEY (" + valid[0] + ")";
}

// Namespace namespace_8eb9bc0a/namespace_8eb9bc0a
// Params 1, eflags: 0x1 linked
// Checksum 0x2d857163, Offset: 0x1028
// Size: 0x1cc
function allow_all(allow) {
    self.ignoreall = !allow;
    self ai::set_behavior_attribute(#"reload", allow);
    self ai::set_behavior_attribute(#"revive", allow);
    self ai::set_behavior_attribute(#"slide", allow);
    self ai::set_behavior_attribute(#"swim", allow);
    self ai::set_behavior_attribute(#"sprint", allow);
    self ai::set_behavior_attribute(#"primaryoffhand", allow);
    self ai::set_behavior_attribute(#"secondaryoffhand", allow);
    self ai::set_behavior_attribute(#"specialoffhand", allow);
    self ai::set_behavior_attribute(#"scorestreak", allow);
    if (allow) {
        self ai::set_behavior_attribute("control", "commander");
        self clearforcedgoal();
        return;
    }
    self ai::set_behavior_attribute("control", "autonomous");
    self setgoal(self.origin, 1);
}

