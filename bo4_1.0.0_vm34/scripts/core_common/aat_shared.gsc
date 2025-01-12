#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;

#namespace aat;

// Namespace aat/aat_shared
// Params 0, eflags: 0x2
// Checksum 0xdbc38866, Offset: 0x120
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"aat", &__init__, undefined, undefined);
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x4
// Checksum 0x8899667c, Offset: 0x168
// Size: 0x1d4
function private __init__() {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    level.aat_initializing = 1;
    level.aat = [];
    level.aat[#"none"] = spawnstruct();
    level.aat[#"none"].name = "none";
    level.aat_reroll = [];
    level.var_f11e78d5 = [];
    callback::on_connect(&on_player_connect);
    callback::function_c4f1b25e(&function_c4f1b25e);
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
// Params 0, eflags: 0x4
// Checksum 0xf6c74215, Offset: 0x348
// Size: 0xf8
function private on_player_connect() {
    self.aat = [];
    self.aat_cooldown_start = [];
    if (!isdefined(self.var_eed271c5)) {
        self.var_eed271c5 = [];
    } else if (!isarray(self.var_eed271c5)) {
        self.var_eed271c5 = array(self.var_eed271c5);
    }
    foreach (key, v in level.aat) {
        self.aat_cooldown_start[key] = 0;
    }
    self thread watch_weapon_changes();
    /#
    #/
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x4
// Checksum 0x5a153c67, Offset: 0x448
// Size: 0x74
function private function_c4f1b25e(s_event) {
    if (s_event.event === "take_weapon" && isdefined(s_event.weapon) && isdefined(self.aat[s_event.weapon])) {
        self remove(s_event.weapon);
    }
}

/#

    // Namespace aat/aat_shared
    // Params 0, eflags: 0x4
    // Checksum 0x8ca55989, Offset: 0x4c8
    // Size: 0x174
    function private setup_devgui() {
        waittillframeend();
        setdvar(#"aat_acquire_devgui", "<dev string:x30>");
        aat_devgui_base = "<dev string:x31>";
        foreach (key, v in level.aat) {
            if (key != "<dev string:x49>") {
                name = function_15979fa9(key);
                adddebugcommand(aat_devgui_base + name + "<dev string:x4e>" + "<dev string:x56>" + "<dev string:x69>" + name + "<dev string:x6b>");
            }
        }
        adddebugcommand(aat_devgui_base + "<dev string:x6f>" + "<dev string:x56>" + "<dev string:x69>" + "<dev string:x49>" + "<dev string:x6b>");
        level thread aat_devgui_think();
    }

    // Namespace aat/aat_shared
    // Params 0, eflags: 0x4
    // Checksum 0x301cd99f, Offset: 0x648
    // Size: 0x170
    function private aat_devgui_think() {
        for (;;) {
            aat_name = getdvarstring(#"aat_acquire_devgui");
            if (aat_name != "<dev string:x30>") {
                for (i = 0; i < level.players.size; i++) {
                    if (aat_name == "<dev string:x49>") {
                        level.players[i] thread remove(level.players[i] getcurrentweapon());
                    } else {
                        level.players[i] thread acquire(level.players[i] getcurrentweapon(), aat_name);
                    }
                    level.players[i] thread aat_set_debug_text(aat_name, 0, 0, 0);
                }
            }
            setdvar(#"aat_acquire_devgui", "<dev string:x30>");
            wait 0.5;
        }
    }

    // Namespace aat/aat_shared
    // Params 4, eflags: 0x4
    // Checksum 0x2b44e759, Offset: 0x7c0
    // Size: 0x202
    function private aat_set_debug_text(name, success, success_reroll, fail) {
        self notify(#"aat_set_debug_text_thread");
        self endon(#"aat_set_debug_text_thread");
        self endon(#"disconnect");
        if (!isdefined(self.aat_debug_text)) {
            return;
        }
        percentage = "<dev string:x84>";
        if (isdefined(level.aat[name]) && name != "<dev string:x49>") {
            percentage = level.aat[name].percentage;
        }
        self.aat_debug_text fadeovertime(0.05);
        self.aat_debug_text.alpha = 1;
        self.aat_debug_text settext("<dev string:x88>" + name + "<dev string:x8e>" + percentage);
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
        if ("<dev string:x49>" == name) {
            self.aat_debug_text.alpha = 0;
        }
    }

#/

// Namespace aat/aat_shared
// Params 0, eflags: 0x4
// Checksum 0xdee09ace, Offset: 0x9d0
// Size: 0x82
function private aat_cooldown_init() {
    self.aat_cooldown_start = [];
    foreach (key, v in level.aat) {
        self.aat_cooldown_start[key] = 0;
    }
}

// Namespace aat/aat_shared
// Params 15, eflags: 0x0
// Checksum 0xa98c2db2, Offset: 0xa60
// Size: 0x100
function aat_vehicle_damage_monitor(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    willbekilled = self.health - idamage <= 0;
    if (isdefined(level.aat_in_use) && level.aat_in_use) {
        self thread aat_response(willbekilled, einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, vsurfacenormal);
    }
    return idamage;
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0xe1a60f47, Offset: 0xb68
// Size: 0x34
function get_nonalternate_weapon(weapon) {
    if (isdefined(weapon) && weapon.isaltmode) {
        return weapon.altweapon;
    }
    return weapon;
}

// Namespace aat/aat_shared
// Params 13, eflags: 0x0
// Checksum 0xa2f73ce0, Offset: 0xba8
// Size: 0x6b4
function aat_response(death, inflictor, attacker, damage, flags, mod, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (!isplayer(attacker)) {
        return;
    }
    if (mod != "MOD_PISTOL_BULLET" && mod != "MOD_RIFLE_BULLET" && mod != "MOD_GRENADE" && mod != "MOD_PROJECTILE" && mod != "MOD_EXPLOSIVE" && mod != "MOD_IMPACT" && (mod != "MOD_MELEE" || !(isdefined(level.var_2df16607) && level.var_2df16607))) {
        return;
    }
    weapon = get_nonalternate_weapon(weapon);
    name = attacker.aat[weapon];
    if (!isdefined(name)) {
        return;
    }
    if (isdefined(death) && death && !level.aat[name].occurs_on_death) {
        return;
    }
    if (!isdefined(self.archetype)) {
        return;
    }
    if (isdefined(self.var_2cd0795a) && self.var_2cd0795a) {
        return;
    }
    if (isdefined(self.var_3059fa07) && self.var_3059fa07) {
        return;
    }
    if (isdefined(self.aat_turned) && self.aat_turned) {
        return;
    }
    if (isdefined(level.aat[name].immune_trigger[self.archetype]) && level.aat[name].immune_trigger[self.archetype]) {
        return;
    }
    now = float(gettime()) / 1000;
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
    if (isdefined(level.var_f11e78d5[weapon])) {
        if (level.var_f11e78d5[weapon] < percentage) {
            percentage = level.var_f11e78d5[weapon];
        }
    }
    /#
        aat_percentage_override = getdvarfloat(#"scr_aat_percentage_override", 0);
        if (aat_percentage_override > 0) {
            percentage = aat_percentage_override;
        }
    #/
    if (percentage >= randomfloat(1)) {
        success = 1;
        /#
            attacker thread aat_set_debug_text(name, 1, 0, 0);
        #/
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
                        /#
                            attacker thread aat_set_debug_text(name, 0, 1, 0);
                        #/
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
        /#
            attacker thread aat_set_debug_text(name, 0, 0, 1);
        #/
        return;
    }
    level.aat[name].cooldown_time_global_start = now;
    attacker.aat_cooldown_start[name] = now;
    self thread [[ level.aat[name].result_func ]](death, attacker, mod, weapon);
    if (isplayer(attacker)) {
        attacker playlocalsound(level.aat[name].damage_feedback_sound);
    }
}

// Namespace aat/aat_shared
// Params 11, eflags: 0x0
// Checksum 0x410bf368, Offset: 0x1268
// Size: 0x61a
function register(name, percentage, cooldown_time_entity, cooldown_time_attacker, cooldown_time_global, occurs_on_death, result_func, damage_feedback_icon, damage_feedback_sound, validation_func, catalyst) {
    assert(isdefined(level.aat_initializing) && level.aat_initializing, "<dev string:x95>");
    assert(isdefined(name), "<dev string:x100>");
    assert("<dev string:x49>" != name, "<dev string:x126>" + "<dev string:x49>" + "<dev string:x148>");
    assert(!isdefined(level.aat[name]), "<dev string:x17f>" + name + "<dev string:x196>");
    assert(isdefined(percentage), "<dev string:x17f>" + name + "<dev string:x1b4>");
    assert(0 <= percentage && 1 > percentage, "<dev string:x17f>" + name + "<dev string:x1d2>");
    assert(isdefined(cooldown_time_entity), "<dev string:x17f>" + name + "<dev string:x21b>");
    assert(0 <= cooldown_time_entity, "<dev string:x17f>" + name + "<dev string:x243>");
    assert(isdefined(cooldown_time_entity), "<dev string:x17f>" + name + "<dev string:x286>");
    assert(0 <= cooldown_time_entity, "<dev string:x17f>" + name + "<dev string:x2b0>");
    assert(isdefined(cooldown_time_global), "<dev string:x17f>" + name + "<dev string:x2f5>");
    assert(0 <= cooldown_time_global, "<dev string:x17f>" + name + "<dev string:x31d>");
    assert(isdefined(occurs_on_death), "<dev string:x17f>" + name + "<dev string:x360>");
    assert(isdefined(result_func), "<dev string:x17f>" + name + "<dev string:x383>");
    assert(isdefined(damage_feedback_icon), "<dev string:x17f>" + name + "<dev string:x3a2>");
    assert(isstring(damage_feedback_icon), "<dev string:x17f>" + name + "<dev string:x3ca>");
    assert(isdefined(damage_feedback_sound), "<dev string:x17f>" + name + "<dev string:x3f3>");
    assert(isstring(damage_feedback_sound), "<dev string:x17f>" + name + "<dev string:x41c>");
    level.aat[name] = spawnstruct();
    level.aat[name].name = name;
    level.aat[name].hash_id = stathash(name);
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
    if (isdefined(catalyst)) {
        level.aat[name].catalyst = catalyst;
    }
}

// Namespace aat/aat_shared
// Params 5, eflags: 0x0
// Checksum 0x984f835a, Offset: 0x1890
// Size: 0x1f6
function register_immunity(name, archetype, immune_trigger, immune_result_direct, immune_result_indirect) {
    while (level.aat_initializing !== 0) {
        waitframe(1);
    }
    assert(isdefined(name), "<dev string:x100>");
    assert(isdefined(archetype), "<dev string:x446>");
    assert(isdefined(immune_trigger), "<dev string:x471>");
    assert(isdefined(immune_result_direct), "<dev string:x4a1>");
    assert(isdefined(immune_result_indirect), "<dev string:x4d7>");
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
// Checksum 0x23014689, Offset: 0x1a90
// Size: 0x172
function finalize_clientfields() {
    println("<dev string:x50f>");
    if (level.aat.size > 1) {
        array::alphabetize(level.aat);
        i = 0;
        foreach (aat in level.aat) {
            aat.clientfield_index = i;
            i++;
            println("<dev string:x529>" + aat.name);
        }
        n_bits = getminbitcountfornum(level.aat.size - 1);
        clientfield::register("toplayer", "aat_current", 1, n_bits, "int");
    }
    level.aat_initializing = 0;
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0x262700cb, Offset: 0x1c10
// Size: 0x3e
function register_aat_exemption(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    level.aat_exemptions[weapon] = 1;
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0xd172ac54, Offset: 0x1c58
// Size: 0x36
function is_exempt_weapon(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    return isdefined(level.aat_exemptions[weapon]);
}

// Namespace aat/aat_shared
// Params 4, eflags: 0x0
// Checksum 0x884eb1ad, Offset: 0x1c98
// Size: 0x25e
function register_reroll(name, count, active_func, damage_feedback_icon) {
    assert(isdefined(name), "<dev string:x52e>");
    assert("<dev string:x49>" != name, "<dev string:x55c>" + "<dev string:x49>" + "<dev string:x148>");
    assert(!isdefined(level.aat[name]), "<dev string:x585>" + name + "<dev string:x196>");
    assert(isdefined(count), "<dev string:x5a9>" + name + "<dev string:x5ce>");
    assert(0 < count, "<dev string:x5a9>" + name + "<dev string:x5e7>");
    assert(isdefined(active_func), "<dev string:x5a9>" + name + "<dev string:x607>");
    assert(isdefined(damage_feedback_icon), "<dev string:x5a9>" + name + "<dev string:x3a2>");
    assert(isstring(damage_feedback_icon), "<dev string:x5a9>" + name + "<dev string:x3ca>");
    level.aat_reroll[name] = spawnstruct();
    level.aat_reroll[name].name = name;
    level.aat_reroll[name].count = count;
    level.aat_reroll[name].active_func = active_func;
    level.aat_reroll[name].damage_feedback_icon = damage_feedback_icon;
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0x5885d1ba, Offset: 0x1f00
// Size: 0xe0
function getaatonweapon(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    if (weapon == level.weaponnone || !(isdefined(level.aat_in_use) && level.aat_in_use) || is_exempt_weapon(weapon) || !isdefined(self.aat) || !isdefined(self.aat[weapon]) || !isdefined(level.aat[self.aat[weapon]])) {
        return undefined;
    }
    return level.aat[self.aat[weapon]];
}

// Namespace aat/aat_shared
// Params 2, eflags: 0x0
// Checksum 0x90649930, Offset: 0x1fe8
// Size: 0x34a
function acquire(weapon, name) {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    assert(isdefined(weapon), "<dev string:x626>");
    assert(weapon != level.weaponnone, "<dev string:x64d>");
    weapon = get_nonalternate_weapon(weapon);
    if (is_exempt_weapon(weapon)) {
        return;
    }
    if (isdefined(name)) {
        assert("<dev string:x49>" != name, "<dev string:x681>" + "<dev string:x49>" + "<dev string:x148>");
        assert(isdefined(level.aat[name]), "<dev string:x6a2>" + name + "<dev string:x6b8>");
        self.aat[weapon] = name;
    } else {
        keys = getarraykeys(level.aat);
        arrayremovevalue(keys, hash("none"));
        if (isdefined(self.aat[weapon])) {
            arrayremovevalue(keys, self.aat[weapon]);
        }
        rand = randomint(keys.size);
        name = keys[rand];
        self.aat[weapon] = name;
    }
    if (weapon == self getcurrentweapon()) {
        self clientfield::set_to_player("aat_current", level.aat[self.aat[weapon]].clientfield_index);
    }
    switch (name) {
    case #"zm_aat_brain_decay":
        self.var_eed271c5[weapon] = 2;
        break;
    case #"zm_aat_plasmatic_burst":
        self.var_eed271c5[weapon] = 3;
        break;
    case #"zm_aat_kill_o_watt":
        self.var_eed271c5[weapon] = 4;
        break;
    case #"zm_aat_frostbite":
        self.var_eed271c5[weapon] = 1;
        break;
    default:
        break;
    }
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0x63325ac1, Offset: 0x2340
// Size: 0xb4
function remove(weapon) {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    assert(isdefined(weapon), "<dev string:x6cf>");
    assert(weapon != level.weaponnone, "<dev string:x6f5>");
    weapon = get_nonalternate_weapon(weapon);
    self.aat[weapon] = undefined;
    self.var_eed271c5[weapon] = undefined;
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x0
// Checksum 0xc16a38d4, Offset: 0x2400
// Size: 0xd8
function watch_weapon_changes() {
    self endon(#"disconnect");
    while (isdefined(self)) {
        waitresult = self waittill(#"weapon_change");
        weapon = waitresult.weapon;
        weapon = get_nonalternate_weapon(weapon);
        name = "none";
        if (isdefined(self.aat[weapon])) {
            name = self.aat[weapon];
        }
        self clientfield::set_to_player("aat_current", level.aat[name].clientfield_index);
    }
}

