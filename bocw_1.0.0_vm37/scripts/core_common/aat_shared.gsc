#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace aat;

// Namespace aat/aat_shared
// Params 0, eflags: 0x6
// Checksum 0x90a77bf1, Offset: 0x160
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"aat", &preinit, &finalize_clientfields, undefined, undefined);
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x4
// Checksum 0x66e52ac3, Offset: 0x1b8
// Size: 0x1d4
function private preinit() {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    if (!isdefined(level.aat)) {
        level.aat = [];
    }
    level.aat[#"none"] = spawnstruct();
    level.aat[#"none"].name = "none";
    level.aat_reroll = [];
    level.var_bdba6ee8 = [];
    callback::on_connect(&on_player_connect);
    callback::on_ai_damage(&on_ai_damage);
    callback::function_33f0ddd3(&function_33f0ddd3);
    spawners = getspawnerarray();
    foreach (spawner in spawners) {
        spawner spawner::add_spawn_function(&aat_cooldown_init);
    }
    level.aat_exemptions = [];
    /#
        level thread setup_devgui();
    #/
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x0
// Checksum 0xb49eb10b, Offset: 0x398
// Size: 0x90
function function_2b3bcce0() {
    if (!isdefined(level.var_e44e90d6)) {
        return;
    }
    foreach (call in level.var_e44e90d6) {
        [[ call ]]();
    }
}

// Namespace aat/aat_shared
// Params 2, eflags: 0x0
// Checksum 0xfef633b7, Offset: 0x430
// Size: 0x84
function function_571fceb(aat_name, main) {
    if (!isdefined(level.var_e44e90d6)) {
        level.var_e44e90d6 = [];
    }
    /#
        if (isdefined(level.var_e44e90d6[aat_name])) {
            println("<dev string:x38>" + aat_name + "<dev string:x64>");
        }
    #/
    level.var_e44e90d6[aat_name] = main;
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x4
// Checksum 0x26a26dbc, Offset: 0x4c0
// Size: 0xb8
function private on_player_connect() {
    self.aat = [];
    self.aat_cooldown_start = [];
    foreach (key, v in level.aat) {
        self.aat_cooldown_start[key] = 0;
    }
    self thread watch_weapon_changes();
    /#
    #/
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x4
// Checksum 0x5e9a463c, Offset: 0x580
// Size: 0x8c
function private function_33f0ddd3(s_event) {
    if (s_event.event === "take_weapon" && isdefined(s_event.weapon)) {
        weapon = function_702fb333(s_event.weapon);
        if (isdefined(self.aat[weapon])) {
            self remove(weapon);
        }
    }
}

/#

    // Namespace aat/aat_shared
    // Params 1, eflags: 0x0
    // Checksum 0xda5bff72, Offset: 0x618
    // Size: 0x19c
    function setup_devgui(var_e73fddff) {
        if (!isdefined(var_e73fddff)) {
            var_e73fddff = "<dev string:x91>";
        }
        waittillframeend();
        setdvar(#"aat_acquire_devgui", "<dev string:xac>");
        aat_devgui_base = var_e73fddff;
        foreach (key, v in level.aat) {
            if (key != "<dev string:xb0>") {
                name = function_9e72a96(key);
                adddebugcommand(aat_devgui_base + name + "<dev string:xb8>" + "<dev string:xc3>" + "<dev string:xd9>" + name + "<dev string:xde>");
            }
        }
        adddebugcommand(aat_devgui_base + "<dev string:xe5>" + "<dev string:xc3>" + "<dev string:xd9>" + "<dev string:xb0>" + "<dev string:xde>");
        level thread aat_devgui_think();
    }

    // Namespace aat/aat_shared
    // Params 0, eflags: 0x4
    // Checksum 0x2d3d2561, Offset: 0x7c0
    // Size: 0x278
    function private aat_devgui_think() {
        self notify("<dev string:xfd>");
        self endon("<dev string:xfd>");
        for (;;) {
            aat_name = getdvarstring(#"aat_acquire_devgui");
            if (aat_name != "<dev string:xac>") {
                for (i = 0; i < level.players.size; i++) {
                    if (aat_name == "<dev string:xb0>") {
                        if (sessionmodeiszombiesgame()) {
                            weapon = level.players[i] getcurrentweapon();
                            item = level.players[i] item_inventory::function_230ceec4(weapon);
                            if (isdefined(item.aat)) {
                                item.aat = undefined;
                            }
                        }
                        level.players[i] thread remove(level.players[i] getcurrentweapon());
                    } else {
                        if (sessionmodeiszombiesgame()) {
                            weapon = level.players[i] getcurrentweapon();
                            item = level.players[i] item_inventory::function_230ceec4(weapon);
                            if (isdefined(item)) {
                                item.aat = aat_name;
                            }
                        }
                        level.players[i] thread acquire(level.players[i] getcurrentweapon(), aat_name);
                    }
                    level.players[i] thread aat_set_debug_text(aat_name, 0, 0, 0);
                }
            }
            setdvar(#"aat_acquire_devgui", "<dev string:xac>");
            wait 0.5;
        }
    }

    // Namespace aat/aat_shared
    // Params 4, eflags: 0x4
    // Checksum 0x705ed20b, Offset: 0xa40
    // Size: 0x202
    function private aat_set_debug_text(name, success, success_reroll, fail) {
        self notify(#"aat_set_debug_text_thread");
        self endon(#"aat_set_debug_text_thread", #"disconnect");
        if (!isdefined(self.aat_debug_text)) {
            return;
        }
        percentage = "<dev string:x111>";
        if (isdefined(level.aat[name]) && name != "<dev string:xb0>") {
            percentage = level.aat[name].percentage;
        }
        self.aat_debug_text fadeovertime(0.05);
        self.aat_debug_text.alpha = 1;
        self.aat_debug_text settext("<dev string:x118>" + name + "<dev string:x121>" + percentage);
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
        if ("<dev string:xb0>" == name) {
            self.aat_debug_text.alpha = 0;
        }
    }

#/

// Namespace aat/aat_shared
// Params 0, eflags: 0x4
// Checksum 0x107cbabb, Offset: 0xc50
// Size: 0x90
function private aat_cooldown_init() {
    self.aat_cooldown_start = [];
    foreach (key, v in level.aat) {
        self.aat_cooldown_start[key] = 0;
    }
}

// Namespace aat/aat_shared
// Params 15, eflags: 0x0
// Checksum 0x8f6029ba, Offset: 0xce8
// Size: 0xe8
function aat_vehicle_damage_monitor(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, *vdamageorigin, psoffsettime, damagefromunderneath, *modelindex, *partname, vsurfacenormal) {
    willbekilled = self.health - weapon <= 0;
    if (is_true(level.aat_in_use)) {
        self thread aat_response(willbekilled, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    }
    return weapon;
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0x684fb830, Offset: 0xdd8
// Size: 0x62
function function_3895d220(weapon) {
    if (isdefined(weapon)) {
        if (weapon.isaltmode) {
            weapon = weapon.altweapon;
        }
        if (weapon.inventorytype == "dwlefthand") {
            weapon = weapon.dualwieldweapon;
        }
        weapon = weapon.rootweapon;
    }
    return weapon;
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0x7cd24d85, Offset: 0xe48
// Size: 0xa4
function on_ai_damage(params) {
    b_death = params.idamage > self.health;
    aat_response(b_death, params.einflictor, params.eattacker, params.idamage, params.idflags, params.smeansofdeath, params.weapon, params.vpoint, params.vdir, params.shitloc, params.psoffsettime, params.boneindex, params.surfacetype);
}

// Namespace aat/aat_shared
// Params 13, eflags: 0x0
// Checksum 0x21e59cb6, Offset: 0xef8
// Size: 0x724
function aat_response(death, *inflictor, attacker, *damage, *flags, mod, weapon, vpoint, *vdir, *shitloc, *psoffsettime, *boneindex, *surfacetype) {
    if (!isplayer(shitloc) || !isdefined(shitloc.aat) || !isdefined(boneindex)) {
        return;
    }
    if (boneindex.weapclass !== #"rocketlauncher" && psoffsettime != "MOD_PISTOL_BULLET" && psoffsettime != "MOD_RIFLE_BULLET" && psoffsettime != "MOD_GRENADE" && psoffsettime != "MOD_PROJECTILE" && psoffsettime != "MOD_EXPLOSIVE" && psoffsettime != "MOD_IMPACT" && (psoffsettime != "MOD_MELEE" || !is_true(level.var_9d1d502c))) {
        return;
    }
    name = shitloc.aat[function_702fb333(boneindex)];
    if (!isdefined(name)) {
        return;
    }
    if (is_true(vdir) && !is_true(level.aat[name].occurs_on_death)) {
        return;
    }
    if (!isdefined(self.archetype)) {
        return;
    }
    if (is_true(self.var_dd6fe31f)) {
        return;
    }
    if (is_true(self.var_69a981e6)) {
        return;
    }
    if (is_true(self.aat_turned)) {
        return;
    }
    if (is_true(level.aat[name].immune_trigger[self.archetype])) {
        return;
    }
    now = float(gettime()) / 1000;
    if (isdefined(level.var_a839c34d)) {
        if (self [[ level.var_a839c34d ]](name, now, shitloc)) {
            return;
        }
    } else {
        if (isdefined(self.aat_cooldown_start) && now <= self.aat_cooldown_start[name] + level.aat[name].cooldown_time_entity) {
            return;
        }
        if (now <= shitloc.aat_cooldown_start[name] + level.aat[name].cooldown_time_attacker) {
            return;
        }
        if (now <= level.aat[name].cooldown_time_global_start + level.aat[name].cooldown_time_global) {
            return;
        }
    }
    if (isdefined(level.aat[name].validation_func)) {
        if (![[ level.aat[name].validation_func ]]()) {
            return;
        }
    }
    success = 0;
    reroll_icon = undefined;
    percentage = level.aat[name].percentage;
    if (isdefined(level.var_bdba6ee8[boneindex])) {
        if (level.var_bdba6ee8[boneindex] < percentage) {
            percentage = level.var_bdba6ee8[boneindex];
        }
    }
    if (isdefined(shitloc.var_2defbefd)) {
        percentage = shitloc.var_2defbefd;
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
            shitloc thread aat_set_debug_text(name, 1, 0, 0);
        #/
    }
    if (!success) {
        keys = getarraykeys(level.aat_reroll);
        keys = array::randomize(keys);
        foreach (key in keys) {
            if (shitloc [[ level.aat_reroll[key].active_func ]]()) {
                for (i = 0; i < level.aat_reroll[key].count; i++) {
                    if (percentage >= randomfloat(1)) {
                        success = 1;
                        reroll_icon = level.aat_reroll[key].damage_feedback_icon;
                        /#
                            shitloc thread aat_set_debug_text(name, 0, 1, 0);
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
            shitloc thread aat_set_debug_text(name, 0, 0, 1);
        #/
        return;
    }
    level.aat[name].cooldown_time_global_start = now;
    shitloc.aat_cooldown_start[name] = now;
    self thread [[ level.aat[name].result_func ]](vdir, shitloc, psoffsettime, boneindex, surfacetype);
    if (isplayer(shitloc)) {
        shitloc playlocalsound(level.aat[name].damage_feedback_sound);
    }
}

// Namespace aat/aat_shared
// Params 11, eflags: 0x0
// Checksum 0x1d1ead6b, Offset: 0x1628
// Size: 0x65e
function register(name, percentage, cooldown_time_entity, cooldown_time_attacker, cooldown_time_global, occurs_on_death, result_func, damage_feedback_icon, damage_feedback_sound, validation_func, element) {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    if (!isdefined(level.aat)) {
        level.aat = [];
    }
    assert(!is_false(level.aat_initializing), "<dev string:x12b>");
    assert(isdefined(name), "<dev string:x199>");
    assert("<dev string:xb0>" != name, "<dev string:x1c2>" + "<dev string:xb0>" + "<dev string:x1e7>");
    assert(!isdefined(level.aat[name]), "<dev string:x221>" + name + "<dev string:x23b>");
    assert(isdefined(percentage), "<dev string:x221>" + name + "<dev string:x25c>");
    assert(0 <= percentage && 1 > percentage, "<dev string:x221>" + name + "<dev string:x27d>");
    assert(isdefined(cooldown_time_entity), "<dev string:x221>" + name + "<dev string:x2c9>");
    assert(0 <= cooldown_time_entity, "<dev string:x221>" + name + "<dev string:x2f4>");
    assert(isdefined(cooldown_time_entity), "<dev string:x221>" + name + "<dev string:x33a>");
    assert(0 <= cooldown_time_entity, "<dev string:x221>" + name + "<dev string:x367>");
    assert(isdefined(cooldown_time_global), "<dev string:x221>" + name + "<dev string:x3af>");
    assert(0 <= cooldown_time_global, "<dev string:x221>" + name + "<dev string:x3da>");
    assert(isdefined(occurs_on_death), "<dev string:x221>" + name + "<dev string:x420>");
    assert(isdefined(result_func), "<dev string:x221>" + name + "<dev string:x446>");
    assert(isdefined(damage_feedback_icon), "<dev string:x221>" + name + "<dev string:x468>");
    assert(isstring(damage_feedback_icon), "<dev string:x221>" + name + "<dev string:x493>");
    assert(isdefined(damage_feedback_sound), "<dev string:x221>" + name + "<dev string:x4bf>");
    assert(isstring(damage_feedback_sound), "<dev string:x221>" + name + "<dev string:x4eb>");
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
    if (!isdefined(level.var_7c5fd6a4)) {
        level.var_7c5fd6a4 = [];
    }
    level.var_7c5fd6a4[hash(name)] = name;
    if (isdefined(element)) {
        level.aat[name].element = element;
    }
}

// Namespace aat/aat_shared
// Params 5, eflags: 0x0
// Checksum 0xcb9a4c35, Offset: 0x1c90
// Size: 0x200
function register_immunity(name, archetype, immune_trigger, immune_result_direct, immune_result_indirect) {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    while (level.aat_initializing !== 0) {
        waitframe(1);
    }
    assert(isdefined(name), "<dev string:x199>");
    assert(isdefined(archetype), "<dev string:x518>");
    assert(isdefined(immune_trigger), "<dev string:x546>");
    assert(isdefined(immune_result_direct), "<dev string:x579>");
    assert(isdefined(immune_result_indirect), "<dev string:x5b2>");
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
// Checksum 0xe204cb69, Offset: 0x1e98
// Size: 0x180
function finalize_clientfields() {
    println("<dev string:x5ed>");
    if (isdefined(level.aat) && level.aat.size > 1) {
        array::alphabetize(level.aat);
        i = 0;
        foreach (aat in level.aat) {
            aat.clientfield_index = i;
            i++;
            println("<dev string:x60a>" + aat.name);
        }
        n_bits = getminbitcountfornum(level.aat.size - 1);
        clientfield::register("toplayer", "aat_current", 1, n_bits, "int");
    }
    level.aat_initializing = 0;
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0x9ed73090, Offset: 0x2020
// Size: 0x50
function register_aat_exemption(weapon) {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    weapon = function_702fb333(weapon);
    level.aat_exemptions[weapon] = 1;
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0xb9e25cdf, Offset: 0x2078
// Size: 0x4e
function is_exempt_weapon(weapon) {
    if (!is_true(level.aat_in_use)) {
        return false;
    }
    weapon = function_702fb333(weapon);
    return isdefined(level.aat_exemptions[weapon]);
}

// Namespace aat/aat_shared
// Params 4, eflags: 0x0
// Checksum 0x92d6a342, Offset: 0x20d0
// Size: 0x26a
function register_reroll(name, count, active_func, damage_feedback_icon) {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    assert(isdefined(name), "<dev string:x612>");
    assert("<dev string:xb0>" != name, "<dev string:x643>" + "<dev string:xb0>" + "<dev string:x1e7>");
    assert(!isdefined(level.aat[name]), "<dev string:x66f>" + name + "<dev string:x23b>");
    assert(isdefined(count), "<dev string:x696>" + name + "<dev string:x6be>");
    assert(0 < count, "<dev string:x696>" + name + "<dev string:x6da>");
    assert(isdefined(active_func), "<dev string:x696>" + name + "<dev string:x6fd>");
    assert(isdefined(damage_feedback_icon), "<dev string:x696>" + name + "<dev string:x468>");
    assert(isstring(damage_feedback_icon), "<dev string:x696>" + name + "<dev string:x493>");
    level.aat_reroll[name] = spawnstruct();
    level.aat_reroll[name].name = name;
    level.aat_reroll[name].count = count;
    level.aat_reroll[name].active_func = active_func;
    level.aat_reroll[name].damage_feedback_icon = damage_feedback_icon;
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0xcc634a0f, Offset: 0x2348
// Size: 0x72
function function_702fb333(weapon) {
    if (!is_true(level.aat_in_use)) {
        return undefined;
    }
    if (isdefined(level.var_ee5c0b6e)) {
        weapon = self [[ level.var_ee5c0b6e ]](weapon);
        return weapon;
    }
    weapon = function_3895d220(weapon);
    return weapon;
}

// Namespace aat/aat_shared
// Params 2, eflags: 0x0
// Checksum 0x9bbea444, Offset: 0x23c8
// Size: 0x110
function getaatonweapon(weapon, var_a217d0c1 = 0) {
    weapon = function_702fb333(weapon);
    if (!isdefined(weapon) || weapon == level.weaponnone || !is_true(level.aat_in_use) || is_exempt_weapon(weapon) || !isdefined(self.aat) || !isdefined(self.aat[weapon]) || !isdefined(level.aat[self.aat[weapon]])) {
        return undefined;
    }
    if (var_a217d0c1) {
        return self.aat[weapon];
    }
    return level.aat[self.aat[weapon]];
}

// Namespace aat/aat_shared
// Params 3, eflags: 0x0
// Checksum 0x378bc2c0, Offset: 0x24e0
// Size: 0x33e
function acquire(weapon, name, var_77cf85b7) {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    assert(isdefined(weapon), "<dev string:x71f>");
    assert(weapon != level.weaponnone, "<dev string:x749>");
    weapon_instance = weapon;
    weapon = function_702fb333(weapon);
    if (is_exempt_weapon(weapon)) {
        return;
    }
    if (isdefined(name)) {
        assert("<dev string:xb0>" != name, "<dev string:x780>" + "<dev string:xb0>" + "<dev string:x1e7>");
        assert(isdefined(level.aat[name]), "<dev string:x7a4>" + name + "<dev string:x7bd>");
        self.aat[weapon] = name;
    } else {
        keys = getarraykeys(level.aat);
        arrayremovevalue(keys, hash("none"));
        if (isdefined(self.aat[weapon])) {
            arrayremovevalue(keys, self.aat[weapon]);
        }
        if (isdefined(var_77cf85b7)) {
            arrayremovevalue(keys, hash(var_77cf85b7));
        }
        if (keys.size) {
            rand = randomint(keys.size);
            name = keys[rand];
            self.aat[weapon] = name;
        }
    }
    if (weapon == function_702fb333(self getcurrentweapon())) {
        self clientfield::set_to_player("aat_current", level.aat[self.aat[weapon]].clientfield_index);
    }
    if (weapon.name != #"knife_loadout" && weapon.name != #"knife_loadout_upgraded") {
        self function_bf3044dc(weapon_instance, 1);
    }
    self notify(#"aat_acquired");
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0x6133faaa, Offset: 0x2828
// Size: 0xcc
function remove(weapon) {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    assert(isdefined(weapon), "<dev string:x7d7>");
    assert(weapon != level.weaponnone, "<dev string:x800>");
    weapon_instance = weapon;
    weapon = function_702fb333(weapon);
    self.aat[weapon] = undefined;
    self function_bf3044dc(weapon_instance, 0);
}

// Namespace aat/aat_shared
// Params 0, eflags: 0x0
// Checksum 0x55c29fc4, Offset: 0x2900
// Size: 0xe0
function watch_weapon_changes() {
    self endon(#"disconnect");
    while (isdefined(self)) {
        waitresult = self waittill(#"weapon_change");
        weapon = waitresult.weapon;
        weapon = function_702fb333(weapon);
        name = "none";
        if (isdefined(self.aat[weapon])) {
            name = self.aat[weapon];
        }
        self clientfield::set_to_player("aat_current", level.aat[name].clientfield_index);
    }
}

// Namespace aat/aat_shared
// Params 1, eflags: 0x0
// Checksum 0x8a662c60, Offset: 0x29e8
// Size: 0x68
function has_aat(w_current) {
    if (!is_true(level.aat_in_use)) {
        return false;
    }
    w_current = function_702fb333(w_current);
    if (isdefined(self.aat) && isdefined(self.aat[w_current])) {
        return true;
    }
    return false;
}

// Namespace aat/aat_shared
// Params 2, eflags: 0x0
// Checksum 0xa020f468, Offset: 0x2a58
// Size: 0x1dc
function function_7a12b737(stat_name, amount = 1) {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    assert(ishash(stat_name), "<dev string:x836>");
    if (!level.onlinegame || is_true(level.zm_disable_recording_stats)) {
        return;
    }
    if (!isdefined(self)) {
        return;
    }
    self stats::function_dad108fa(stat_name, amount);
    /#
        var_ba1fb8c1 = self stats::get_stat_global(stat_name);
        if (isdefined(var_ba1fb8c1)) {
            if (isdefined(self.entity_num)) {
                println("<dev string:x853>" + self.entity_num + "<dev string:xd9>" + function_9e72a96(stat_name) + "<dev string:x85e>" + var_ba1fb8c1);
            } else {
                println("<dev string:x853>" + function_9e72a96(stat_name) + "<dev string:x85e>" + var_ba1fb8c1);
            }
        }
        if (!isdefined(var_ba1fb8c1)) {
            println("<dev string:x853>" + self.entity_num + "<dev string:xd9>" + function_9e72a96(stat_name) + "<dev string:x870>");
        }
    #/
}

