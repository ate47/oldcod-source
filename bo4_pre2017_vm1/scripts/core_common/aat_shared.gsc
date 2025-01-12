#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace aat;

// Namespace aat/aat_shared
// Params 0, eflags: 0x2
// Checksum 0xcbdd634b, Offset: 0x220
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("aat", &__init__, &__main__, undefined);
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x4
// Checksum 0xe6d376e6, Offset: 0x268
// Size: 0x1bc
function private __init__() {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    level.aat_initializing = 1;
    level.aat = [];
    level.aat["none"] = spawnstruct();
    level.aat["none"].name = "none";
    level.aat_reroll = [];
    callback::on_connect(&on_player_connect);
    spawners = getspawnerarray();
    foreach (spawner in spawners) {
        spawner spawner::add_spawn_function(&aat_cooldown_init);
    }
    level.aat_exemptions = [];
    callback::on_finalize_initialization(&finalize_clientfields);
    /#
        level thread setup_devgui();
    #/
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x0
// Checksum 0x55e1828a, Offset: 0x430
// Size: 0x24
function __main__() {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x4
// Checksum 0x1445d145, Offset: 0x460
// Size: 0xe0
function private on_player_connect() {
    self.aat = [];
    self.aat_cooldown_start = [];
    keys = getarraykeys(level.aat);
    foreach (key in keys) {
        self.aat_cooldown_start[key] = 0;
    }
    self thread watch_weapon_changes();
    /#
    #/
}

/#

    // Namespace aat/aat_shared
    // Params 0, eflags: 0x4
    // Checksum 0x76a0a945, Offset: 0x548
    // Size: 0x184
    function private setup_devgui() {
        waittillframeend();
        setdvar("<dev string:x28>", "<dev string:x3b>");
        aat_devgui_base = "<dev string:x3c>";
        keys = getarraykeys(level.aat);
        foreach (key in keys) {
            if (key != "<dev string:x54>") {
                adddebugcommand(aat_devgui_base + key + "<dev string:x59>" + "<dev string:x28>" + "<dev string:x61>" + key + "<dev string:x63>");
            }
        }
        adddebugcommand(aat_devgui_base + "<dev string:x67>" + "<dev string:x28>" + "<dev string:x61>" + "<dev string:x54>" + "<dev string:x63>");
        level thread aat_devgui_think();
    }

    // Namespace aat/aat_shared
    // Params 0, eflags: 0x4
    // Checksum 0xc1337d6d, Offset: 0x6d8
    // Size: 0x170
    function private aat_devgui_think() {
        for (;;) {
            aat_name = getdvarstring("<dev string:x28>");
            if (aat_name != "<dev string:x3b>") {
                for (i = 0; i < level.players.size; i++) {
                    if (aat_name == "<dev string:x54>") {
                        level.players[i] thread remove(level.players[i] getcurrentweapon());
                    } else {
                        level.players[i] thread acquire(level.players[i] getcurrentweapon(), aat_name);
                    }
                    level.players[i] thread aat_set_debug_text(aat_name, 0, 0, 0);
                }
            }
            setdvar("<dev string:x28>", "<dev string:x3b>");
            wait 0.5;
        }
    }

    // Namespace aat/aat_shared
    // Params 0, eflags: 0x4
    // Checksum 0xf42aed04, Offset: 0x850
    // Size: 0x174
    function private function_6d77b957() {
        self.aat_debug_text = newclienthudelem(self);
        self.aat_debug_text.elemtype = "<dev string:x7c>";
        self.aat_debug_text.font = "<dev string:x81>";
        self.aat_debug_text.fontscale = 1.8;
        self.aat_debug_text.horzalign = "<dev string:x8b>";
        self.aat_debug_text.vertalign = "<dev string:x90>";
        self.aat_debug_text.alignx = "<dev string:x8b>";
        self.aat_debug_text.aligny = "<dev string:x90>";
        self.aat_debug_text.x = 15;
        self.aat_debug_text.y = 15;
        self.aat_debug_text.sort = 2;
        self.aat_debug_text.color = (1, 1, 1);
        self.aat_debug_text.alpha = 1;
        self.aat_debug_text.hidewheninmenu = 1;
        self thread function_3d05ca49();
    }

    // Namespace aat/aat_shared
    // Params 0, eflags: 0x4
    // Checksum 0xdf27f1e9, Offset: 0x9d0
    // Size: 0xb0
    function private function_3d05ca49() {
        self endon(#"disconnect");
        while (true) {
            waitresult = self waittill("<dev string:x94>");
            weapon = waitresult.weapon;
            name = "<dev string:x54>";
            if (isdefined(self.aat[weapon])) {
                name = self.aat[weapon];
            }
            self thread aat_set_debug_text(name, 0, 0, 0);
        }
    }

#/

// Namespace aat/aat_shared
// Params 4, eflags: 0x4
// Checksum 0xcddeee47, Offset: 0xa88
// Size: 0x220
function private aat_set_debug_text(name, success, success_reroll, fail) {
    /#
        self notify(#"aat_set_debug_text_thread");
        self endon(#"aat_set_debug_text_thread");
        self endon(#"disconnect");
        if (!isdefined(self.aat_debug_text)) {
            return;
        }
        percentage = "<dev string:xa2>";
        if (isdefined(level.aat[name]) && name != "<dev string:x54>") {
            percentage = level.aat[name].percentage;
        }
        self.aat_debug_text fadeovertime(0.05);
        self.aat_debug_text.alpha = 1;
        self.aat_debug_text settext("<dev string:xa6>" + name + "<dev string:xac>" + percentage);
        if (success) {
            self.aat_debug_text.color = (0, 1, 0);
        } else if (success_reroll) {
            self.aat_debug_text.color = (0.8, 0, 0.8);
        } else if (fail) {
            self.aat_debug_text.color = (1, 0, 0);
        } else {
            self.aat_debug_text.color = (1, 1, 1);
        }
        wait 1;
        self.aat_debug_text fadeovertime(1);
        self.aat_debug_text.color = (1, 1, 1);
        if ("<dev string:x54>" == name) {
            self.aat_debug_text.alpha = 0;
        }
    #/
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x4
// Checksum 0x13617862, Offset: 0xcb0
// Size: 0xb8
function private aat_cooldown_init() {
    self.aat_cooldown_start = [];
    keys = getarraykeys(level.aat);
    foreach (key in keys) {
        self.aat_cooldown_start[key] = 0;
    }
}

// Namespace aat/aat_shared
// Params 15, eflags: 0x0
// Checksum 0x50a73d59, Offset: 0xd70
// Size: 0x108
function aat_vehicle_damage_monitor(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    willbekilled = self.health - idamage <= 0;
    if (isdefined(level.aat_in_use) && level.aat_in_use) {
        self thread aat_response(willbekilled, einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, vsurfacenormal);
    }
    return idamage;
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0xa9e570cf, Offset: 0xe80
// Size: 0x38
function get_nonalternate_weapon(weapon) {
    if (isdefined(weapon) && weapon.isaltmode) {
        return weapon.altweapon;
    }
    return weapon;
}

// Namespace aat/aat_shared
// Params 13, eflags: 0x0
// Checksum 0x229987c8, Offset: 0xec0
// Size: 0x644
function aat_response(death, inflictor, attacker, damage, flags, mod, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (!isplayer(attacker)) {
        return;
    }
    if (mod != "MOD_PISTOL_BULLET" && mod != "MOD_RIFLE_BULLET" && mod != "MOD_GRENADE" && mod != "MOD_PROJECTILE" && mod != "MOD_EXPLOSIVE" && mod != "MOD_IMPACT") {
        return;
    }
    weapon = get_nonalternate_weapon(weapon);
    name = attacker.aat[weapon];
    if (!isdefined(name)) {
        return;
    }
    if (death && !level.aat[name].occurs_on_death) {
        return;
    }
    if (!isdefined(self.archetype)) {
        return;
    }
    if (isdefined(level.aat[name].immune_trigger[self.archetype]) && level.aat[name].immune_trigger[self.archetype]) {
        return;
    }
    now = gettime() / 1000;
    if (now <= self.aat_cooldown_start[name] + level.aat[name].cooldown_time_entity) {
        return;
    }
    if (now <= attacker.aat_cooldown_start[name] + level.aat[name].cooldown_time_attacker) {
        return;
    }
    if (now <= level.aat[name].cooldown_time_global_start + level.aat[name].cooldown_time_global) {
        return;
    }
    if (isdefined(level.aat[name].validation_func)) {
        if (![[ level.aat[name].validation_func ]]()) {
            return;
        }
    }
    success = 0;
    reroll_icon = undefined;
    percentage = level.aat[name].percentage;
    /#
        aat_percentage_override = getdvarfloat("<dev string:xb3>");
        if (aat_percentage_override > 0) {
            percentage = aat_percentage_override;
        }
    #/
    if (percentage >= randomfloat(1)) {
        success = 1;
        attacker thread aat_set_debug_text(name, 1, 0, 0);
    }
    if (!success) {
        keys = getarraykeys(level.aat_reroll);
        keys = array::randomize(keys);
        foreach (key in keys) {
            if (attacker [[ level.aat_reroll[key].active_func ]]()) {
                for (i = 0; i < level.aat_reroll[key].count; i++) {
                    if (percentage >= randomfloat(1)) {
                        success = 1;
                        reroll_icon = level.aat_reroll[key].damage_feedback_icon;
                        attacker thread aat_set_debug_text(name, 0, 1, 0);
                        break;
                    }
                }
            }
            if (success) {
                break;
            }
        }
    }
    if (!success) {
        attacker thread aat_set_debug_text(name, 0, 0, 1);
        return;
    }
    level.aat[name].cooldown_time_global_start = now;
    attacker.aat_cooldown_start[name] = now;
    self thread [[ level.aat[name].result_func ]](death, attacker, mod, weapon);
    attacker thread damagefeedback::update_override(level.aat[name].damage_feedback_icon, level.aat[name].damage_feedback_sound, reroll_icon);
}

// Namespace aat/aat_shared
// Params 10, eflags: 0x0
// Checksum 0xa6d97959, Offset: 0x1510
// Size: 0x630
function register(name, percentage, cooldown_time_entity, cooldown_time_attacker, cooldown_time_global, occurs_on_death, result_func, damage_feedback_icon, damage_feedback_sound, validation_func) {
    /#
        assert(isdefined(level.aat_initializing) && level.aat_initializing, "<dev string:xcf>");
    #/
    /#
        assert(isdefined(name), "<dev string:x13a>");
    #/
    /#
        assert("<dev string:x54>" != name, "<dev string:x160>" + "<dev string:x54>" + "<dev string:x182>");
    #/
    /#
        assert(!isdefined(level.aat[name]), "<dev string:x1b9>" + name + "<dev string:x1d0>");
    #/
    /#
        assert(isdefined(percentage), "<dev string:x1b9>" + name + "<dev string:x1ee>");
    #/
    /#
        assert(0 <= percentage && 1 > percentage, "<dev string:x1b9>" + name + "<dev string:x20c>");
    #/
    /#
        assert(isdefined(cooldown_time_entity), "<dev string:x1b9>" + name + "<dev string:x255>");
    #/
    /#
        assert(0 <= cooldown_time_entity, "<dev string:x1b9>" + name + "<dev string:x27d>");
    #/
    /#
        assert(isdefined(cooldown_time_entity), "<dev string:x1b9>" + name + "<dev string:x2c0>");
    #/
    /#
        assert(0 <= cooldown_time_entity, "<dev string:x1b9>" + name + "<dev string:x2ea>");
    #/
    /#
        assert(isdefined(cooldown_time_global), "<dev string:x1b9>" + name + "<dev string:x32f>");
    #/
    /#
        assert(0 <= cooldown_time_global, "<dev string:x1b9>" + name + "<dev string:x357>");
    #/
    /#
        assert(isdefined(occurs_on_death), "<dev string:x1b9>" + name + "<dev string:x39a>");
    #/
    /#
        assert(isdefined(result_func), "<dev string:x1b9>" + name + "<dev string:x3bd>");
    #/
    /#
        assert(isdefined(damage_feedback_icon), "<dev string:x1b9>" + name + "<dev string:x3dc>");
    #/
    /#
        assert(isstring(damage_feedback_icon), "<dev string:x1b9>" + name + "<dev string:x404>");
    #/
    /#
        assert(isdefined(damage_feedback_sound), "<dev string:x1b9>" + name + "<dev string:x42d>");
    #/
    /#
        assert(isstring(damage_feedback_sound), "<dev string:x1b9>" + name + "<dev string:x456>");
    #/
    level.aat[name] = spawnstruct();
    level.aat[name].name = name;
    level.aat[name].hash_id = hashstring(name);
    level.aat[name].percentage = percentage;
    level.aat[name].cooldown_time_entity = cooldown_time_entity;
    level.aat[name].cooldown_time_attacker = cooldown_time_attacker;
    level.aat[name].cooldown_time_global = cooldown_time_global;
    level.aat[name].cooldown_time_global_start = 0;
    level.aat[name].occurs_on_death = occurs_on_death;
    level.aat[name].result_func = result_func;
    level.aat[name].damage_feedback_icon = damage_feedback_icon;
    level.aat[name].damage_feedback_sound = damage_feedback_sound;
    level.aat[name].validation_func = validation_func;
    level.aat[name].immune_trigger = [];
    level.aat[name].immune_result_direct = [];
    level.aat[name].immune_result_indirect = [];
}

// Namespace aat/aat_shared
// Params 5, eflags: 0x0
// Checksum 0x67fdf54c, Offset: 0x1b48
// Size: 0x242
function register_immunity(name, archetype, immune_trigger, immune_result_direct, immune_result_indirect) {
    while (level.aat_initializing !== 0) {
        waitframe(1);
    }
    /#
        assert(isdefined(name), "<dev string:x13a>");
    #/
    /#
        assert(isdefined(archetype), "<dev string:x480>");
    #/
    /#
        assert(isdefined(immune_trigger), "<dev string:x4ab>");
    #/
    /#
        assert(isdefined(immune_result_direct), "<dev string:x4db>");
    #/
    /#
        assert(isdefined(immune_result_indirect), "<dev string:x511>");
    #/
    if (!isdefined(level.aat[name].immune_trigger)) {
        level.aat[name].immune_trigger = [];
    }
    if (!isdefined(level.aat[name].immune_result_direct)) {
        level.aat[name].immune_result_direct = [];
    }
    if (!isdefined(level.aat[name].immune_result_indirect)) {
        level.aat[name].immune_result_indirect = [];
    }
    level.aat[name].immune_trigger[archetype] = immune_trigger;
    level.aat[name].immune_result_direct[archetype] = immune_result_direct;
    level.aat[name].immune_result_indirect[archetype] = immune_result_indirect;
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x0
// Checksum 0x9a3ca256, Offset: 0x1d98
// Size: 0x18c
function finalize_clientfields() {
    /#
        println("<dev string:x549>");
    #/
    if (level.aat.size > 1) {
        array::alphabetize(level.aat);
        i = 0;
        foreach (aat in level.aat) {
            aat.clientfield_index = i;
            i++;
            /#
                println("<dev string:x563>" + aat.name);
            #/
        }
        n_bits = getminbitcountfornum(level.aat.size - 1);
        clientfield::register("toplayer", "aat_current", 1, n_bits, "int");
    }
    level.aat_initializing = 0;
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0x1cf69d71, Offset: 0x1f30
// Size: 0x3e
function register_aat_exemption(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    level.aat_exemptions[weapon] = 1;
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0xa3361f70, Offset: 0x1f78
// Size: 0x3a
function is_exempt_weapon(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    return isdefined(level.aat_exemptions[weapon]);
}

// Namespace aat/aat_shared
// Params 4, eflags: 0x0
// Checksum 0x67da6b5d, Offset: 0x1fc0
// Size: 0x278
function register_reroll(name, count, active_func, damage_feedback_icon) {
    /#
        assert(isdefined(name), "<dev string:x568>");
    #/
    /#
        assert("<dev string:x54>" != name, "<dev string:x596>" + "<dev string:x54>" + "<dev string:x182>");
    #/
    /#
        assert(!isdefined(level.aat[name]), "<dev string:x5bf>" + name + "<dev string:x1d0>");
    #/
    /#
        assert(isdefined(count), "<dev string:x5e3>" + name + "<dev string:x608>");
    #/
    /#
        assert(0 < count, "<dev string:x5e3>" + name + "<dev string:x621>");
    #/
    /#
        assert(isdefined(active_func), "<dev string:x5e3>" + name + "<dev string:x641>");
    #/
    /#
        assert(isdefined(damage_feedback_icon), "<dev string:x5e3>" + name + "<dev string:x3dc>");
    #/
    /#
        assert(isstring(damage_feedback_icon), "<dev string:x5e3>" + name + "<dev string:x404>");
    #/
    level.aat_reroll[name] = spawnstruct();
    level.aat_reroll[name].name = name;
    level.aat_reroll[name].count = count;
    level.aat_reroll[name].active_func = active_func;
    level.aat_reroll[name].damage_feedback_icon = damage_feedback_icon;
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0x84b12c8f, Offset: 0x2240
// Size: 0xe0
function getaatonweapon(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    if (!isdefined(self.aat) || weapon == level.weaponnone || !(isdefined(level.aat_in_use) && level.aat_in_use) || is_exempt_weapon(weapon) || !isdefined(self.aat[weapon]) || !isdefined(level.aat[self.aat[weapon]])) {
        return undefined;
    }
    return level.aat[self.aat[weapon]];
}

// Namespace aat/aat_shared
// Params 2, eflags: 0x0
// Checksum 0x481a8853, Offset: 0x2328
// Size: 0x284
function acquire(weapon, name) {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    /#
        assert(isdefined(weapon), "<dev string:x660>");
    #/
    /#
        assert(weapon != level.weaponnone, "<dev string:x687>");
    #/
    weapon = get_nonalternate_weapon(weapon);
    if (is_exempt_weapon(weapon)) {
        return;
    }
    if (isdefined(name)) {
        /#
            assert("<dev string:x54>" != name, "<dev string:x6bb>" + "<dev string:x54>" + "<dev string:x182>");
        #/
        /#
            assert(isdefined(level.aat[name]), "<dev string:x6dc>" + name + "<dev string:x6f2>");
        #/
        self.aat[weapon] = name;
    } else {
        keys = getarraykeys(level.aat);
        arrayremovevalue(keys, "none");
        if (isdefined(self.aat[weapon])) {
            arrayremovevalue(keys, self.aat[weapon]);
        }
        rand = randomint(keys.size);
        self.aat[weapon] = keys[rand];
    }
    if (weapon == self getcurrentweapon()) {
        self clientfield::set_to_player("aat_current", level.aat[self.aat[weapon]].clientfield_index);
    }
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0xbbf6e4e7, Offset: 0x25b8
// Size: 0xb0
function remove(weapon) {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    /#
        assert(isdefined(weapon), "<dev string:x709>");
    #/
    /#
        assert(weapon != level.weaponnone, "<dev string:x72f>");
    #/
    weapon = get_nonalternate_weapon(weapon);
    self.aat[weapon] = undefined;
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x0
// Checksum 0xc3440d7f, Offset: 0x2670
// Size: 0xe8
function watch_weapon_changes() {
    self endon(#"disconnect");
    self endon(#"death");
    while (isdefined(self)) {
        waitresult = self waittill("weapon_change");
        weapon = waitresult.weapon;
        weapon = get_nonalternate_weapon(weapon);
        name = "none";
        if (isdefined(self.aat[weapon])) {
            name = self.aat[weapon];
        }
        self clientfield::set_to_player("aat_current", level.aat[name].clientfield_index);
    }
}

