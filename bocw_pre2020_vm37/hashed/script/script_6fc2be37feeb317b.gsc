#using script_113dd7f0ea2a1d4f;
#using script_1caf36ff04a85ff6;
#using script_355c6e84a79530cb;
#using script_5a8a1aa32dea1a04;
#using script_7d7ac1f663edcdc8;
#using script_7fc996fe8678852;
#using scripts\core_common\aat_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\aats\zm_aat;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace namespace_4b9fccd8;

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 0, eflags: 0x6
// Checksum 0x84f77916, Offset: 0x3e8
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"hash_794c3bb2e36b3278", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 0, eflags: 0x1 linked
// Checksum 0x4bfc27a2, Offset: 0x440
// Size: 0xd4
function function_70a657d8() {
    level.var_2457162c = sr_weapon_upgrade_menu::register();
    weapon = getweapon(#"bare_hands");
    aat::register_aat_exemption(weapon);
    callback::on_spawned(&function_e3af0084);
    level.var_fee1eaaf = &function_be24d7ce;
    level.var_af0de66 = array(0, 5000, 7500, 10000);
    level function_a5ed2da0();
}

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 0, eflags: 0x1 linked
// Checksum 0x29c9eff8, Offset: 0x520
// Size: 0x84
function postinit() {
    var_f5ae494f = struct::get_array(#"content_destination", "variantname");
    if (zm_utility::is_classic() && isdefined(var_f5ae494f) && var_f5ae494f.size > 0) {
        level thread function_329ecd95(var_f5ae494f[0]);
    }
}

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 0, eflags: 0x1 linked
// Checksum 0x3ee0ebad, Offset: 0x5b0
// Size: 0x320
function function_a5ed2da0() {
    level.var_dcd62c45 = [];
    var_a559259f = [];
    itemspawnlist = getscriptbundle(#"pap_weapons_list");
    var_70f9bc79 = getscriptbundle(#"pap_common_weapons_list");
    foreach (item in var_70f9bc79.itemlist) {
        point = getscriptbundle(item.var_a6762160);
        if (isdefined(point.weapon)) {
            parentweapon = point.weapon.name;
            if (isdefined(parentweapon) && isdefined(item.var_3f8c08e3)) {
                var_a559259f[parentweapon] = item.var_3f8c08e3;
            }
        }
    }
    foreach (item in itemspawnlist.itemlist) {
        point = getscriptbundle(item.var_a6762160);
        if (isdefined(point.weapon)) {
            parentweapon = point.weapon.name;
            if (isdefined(item.var_23a1d10f) && isdefined(item.var_7b0c7fe3) && isdefined(item.var_8261a18) && isdefined(item.var_8261a18) && isdefined(var_a559259f[parentweapon]) && isdefined(parentweapon) && isdefined(item.var_168e36e8)) {
                level.var_dcd62c45[parentweapon] = [#"loadout":var_a559259f[parentweapon], #"resource":var_a559259f[parentweapon], #"uncommon":item.var_3f8c08e3, #"rare":item.var_8261a18, #"epic":item.var_7b0c7fe3, #"legendary":item.var_23a1d10f, #"ultra":item.var_168e36e8];
            }
        }
    }
}

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 1, eflags: 0x1 linked
// Checksum 0xd4e63ce5, Offset: 0x8d8
// Size: 0x90
function function_cb9d309b(var_beee4994) {
    foreach (struct in var_beee4994) {
        function_e0069640(struct);
    }
}

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 1, eflags: 0x1 linked
// Checksum 0xf251ada, Offset: 0x970
// Size: 0x21c
function function_e0069640(struct) {
    assert(isstruct(struct), "<dev string:x38>");
    scriptmodel = namespace_8b6a9d79::spawn_script_model(struct, #"hash_608fac8bdc2fc87a");
    objid = gameobjects::get_next_obj_id();
    struct.objectiveid = objid;
    scriptmodel.objectiveid = objid;
    objective_add(objid, "active", scriptmodel, #"hash_1fb6c7512b2e0e38");
    if (!isdefined(level.var_6bf8ee58)) {
        level.var_6bf8ee58 = [];
    } else if (!isarray(level.var_6bf8ee58)) {
        level.var_6bf8ee58 = array(level.var_6bf8ee58);
    }
    level.var_6bf8ee58[level.var_6bf8ee58.size] = objid;
    trigger = namespace_8b6a9d79::function_214737c7(struct, &function_5b75a557, #"hash_2492283b9609c4a", undefined, 128, 128, undefined, (0, 0, 50));
    trigger.scriptmodel = scriptmodel;
    scriptmodel.trigger = trigger;
    scriptmodel clientfield::set("safehouse_machine_spawn_rob", 1);
    playfx("sr/fx9_safehouse_mchn_wonderfizz_spawn", struct.origin);
    playsoundatposition(#"hash_5c2fc4437449ddb4", struct.origin);
}

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 1, eflags: 0x1 linked
// Checksum 0xc165ff99, Offset: 0xb98
// Size: 0x11c
function function_5b75a557(eventstruct) {
    player = eventstruct.activator;
    machine = self.scriptmodel;
    assert(isdefined(machine), "<dev string:x5d>");
    if (isplayer(player)) {
        if (!level.var_2457162c sr_weapon_upgrade_menu::is_open(player) && !player clientfield::get_player_uimodel("hudItems.survivalOverlayOpen")) {
            player notify(#"hash_6dd2905cac0ff8d0");
            level.var_2457162c sr_weapon_upgrade_menu::open(player, 0);
            player thread function_4609e67c(machine, self);
            player namespace_553954de::function_14bada94();
        }
    }
}

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 0, eflags: 0x1 linked
// Checksum 0x352c07b8, Offset: 0xcc0
// Size: 0x252
function function_e3af0084() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    for (weapon = self getcurrentweapon(); true; weapon = isdefined(waitresult.weapon) ? waitresult.weapon : self getcurrentweapon()) {
        if (isdefined(weapon)) {
            if (self aat::has_aat(weapon)) {
                aat_name = aat::getaatonweapon(weapon, 1);
                self update_aat_hud(aat_name);
            } else {
                level.var_31028c5d prototype_hud::function_91ad787e(self, 0);
                level.var_31028c5d prototype_hud::function_39bce8a1(self, 0);
                level.var_31028c5d prototype_hud::function_b6156501(self, 0);
            }
        }
        networkid = item_inventory::function_ec087745();
        if (networkid != 32767) {
            var_d2648452 = item_inventory::get_inventory_item(networkid);
            if (isdefined(var_d2648452.var_a8bccf69)) {
                level.var_31028c5d prototype_hud::function_f97ebde9(self, var_d2648452.var_a8bccf69);
            } else {
                level.var_31028c5d prototype_hud::function_f97ebde9(self, 0);
            }
        } else {
            level.var_31028c5d prototype_hud::function_f97ebde9(self, 0);
        }
        waitresult = self waittill(#"weapon_change", #"hash_4de2d5115dc310e2", #"hash_75ec9942d2d5fd0f");
    }
}

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 1, eflags: 0x1 linked
// Checksum 0xf8c8a658, Offset: 0xf20
// Size: 0x39c
function update_aat_hud(aat_name) {
    aat_name = zm_aat::function_296cde87(aat_name);
    if (aat_name == "ammomod_cryofreeze") {
        level.var_31028c5d prototype_hud::function_91ad787e(self, 1);
        level.var_31028c5d prototype_hud::function_39bce8a1(self, 0);
        level.var_31028c5d prototype_hud::function_b6156501(self, 0);
        level.var_31028c5d prototype_hud::function_b51e81a5(self, 0);
        level.var_31028c5d prototype_hud::function_58ab28b5(self, 0);
        return;
    }
    if (aat_name == "ammomod_napalmburst") {
        level.var_31028c5d prototype_hud::function_91ad787e(self, 0);
        level.var_31028c5d prototype_hud::function_39bce8a1(self, 1);
        level.var_31028c5d prototype_hud::function_b6156501(self, 0);
        level.var_31028c5d prototype_hud::function_b51e81a5(self, 0);
        level.var_31028c5d prototype_hud::function_58ab28b5(self, 0);
        return;
    }
    if (aat_name == "ammomod_brainrot") {
        level.var_31028c5d prototype_hud::function_91ad787e(self, 0);
        level.var_31028c5d prototype_hud::function_39bce8a1(self, 0);
        level.var_31028c5d prototype_hud::function_b6156501(self, 1);
        level.var_31028c5d prototype_hud::function_b51e81a5(self, 0);
        level.var_31028c5d prototype_hud::function_58ab28b5(self, 0);
        return;
    }
    if (aat_name == "ammomod_deadwire") {
        level.var_31028c5d prototype_hud::function_91ad787e(self, 0);
        level.var_31028c5d prototype_hud::function_39bce8a1(self, 0);
        level.var_31028c5d prototype_hud::function_b6156501(self, 0);
        level.var_31028c5d prototype_hud::function_b51e81a5(self, 1);
        level.var_31028c5d prototype_hud::function_58ab28b5(self, 0);
        return;
    }
    if (aat_name == "ammomod_electriccherry") {
        level.var_31028c5d prototype_hud::function_91ad787e(self, 0);
        level.var_31028c5d prototype_hud::function_39bce8a1(self, 0);
        level.var_31028c5d prototype_hud::function_b6156501(self, 0);
        level.var_31028c5d prototype_hud::function_b51e81a5(self, 0);
        level.var_31028c5d prototype_hud::function_58ab28b5(self, 1);
    }
}

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 0, eflags: 0x1 linked
// Checksum 0x7dddedac, Offset: 0x12c8
// Size: 0x7e
function function_10e802ad() {
    weapon = self getcurrentweapon();
    aat = isdefined(self aat::getaatonweapon(weapon, 1)) ? self aat::getaatonweapon(weapon, 1) : "none";
    return aat;
}

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 2, eflags: 0x1 linked
// Checksum 0x910cb, Offset: 0x1350
// Size: 0xdc
function function_6c71e778(machine, trigger) {
    if (!isplayer(self) || !isdefined(level.var_2457162c)) {
        return;
    }
    if (isdefined(machine) && isdefined(trigger)) {
        trigger sethintstring(#"hash_2492283b9609c4a");
        if (isdefined(machine.objectiveid)) {
            objective_setvisibletoplayer(machine.objectiveid, self);
        }
    }
    level.var_2457162c sr_weapon_upgrade_menu::close(self);
    self namespace_553954de::function_548f282();
}

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 0, eflags: 0x1 linked
// Checksum 0x1e07f41f, Offset: 0x1438
// Size: 0x14c
function refill_ammo() {
    nullweapon = getweapon(#"none");
    var_f945fa92 = getweapon(#"bare_hands");
    currentweapon = self getcurrentweapon();
    if (currentweapon != nullweapon && currentweapon != var_f945fa92) {
        maxammo = currentweapon.maxammo;
        self setweaponammostock(currentweapon, int(maxammo));
    }
    var_824ff7c7 = self getstowedweapon();
    if (var_824ff7c7 != nullweapon && var_824ff7c7 != var_f945fa92) {
        maxammo = var_824ff7c7.maxammo;
        self setweaponammostock(var_824ff7c7, int(maxammo));
    }
}

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 1, eflags: 0x0
// Checksum 0x3d259b4b, Offset: 0x1590
// Size: 0x30
function get_pap_level(item) {
    if (isdefined(item.var_a8bccf69)) {
        return item.var_a8bccf69;
    }
    return 0;
}

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 1, eflags: 0x1 linked
// Checksum 0xd9926c98, Offset: 0x15c8
// Size: 0x30
function function_d6739845(var_461c9e9e) {
    if (!isdefined(level.var_7c5fd6a4)) {
        return undefined;
    }
    return level.var_7c5fd6a4[var_461c9e9e];
}

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 2, eflags: 0x1 linked
// Checksum 0xd9475a77, Offset: 0x1600
// Size: 0xdc
function function_a9a3d4e0(machine, trigger) {
    self endon(#"disconnect", #"death", #"hash_213991f4845a7f0f");
    while (distance2d(self.origin, machine.origin) <= 128 && !self laststand::player_is_in_laststand() && !self isinvehicle()) {
        waitframe(1);
        if (!isdefined(machine)) {
            break;
        }
    }
    self function_6c71e778(machine, trigger);
}

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 2, eflags: 0x1 linked
// Checksum 0x8000cd5b, Offset: 0x16e8
// Size: 0x1ea
function function_4df229d6(var_d393ba53, tier) {
    napalmburst = ["ammomod_napalmburst", "ammomod_napalmburst_1", "ammomod_napalmburst_2", "ammomod_napalmburst_3", "ammomod_napalmburst_4", "ammomod_napalmburst_5"];
    cryofreeze = ["ammomod_cryofreeze", "ammomod_cryofreeze_1", "ammomod_cryofreeze_2", "ammomod_cryofreeze_3", "ammomod_cryofreeze_4", "ammomod_cryofreeze_5"];
    brainrot = ["ammomod_brainrot", "ammomod_brainrot_1", "ammomod_brainrot_2", "ammomod_brainrot_3", "ammomod_brainrot_4", "ammomod_brainrot_5"];
    deadwire = ["ammomod_deadwire", "ammomod_deadwire_1", "ammomod_deadwire_2", "ammomod_deadwire_3", "ammomod_deadwire_4", "ammomod_deadwire_5"];
    switch (var_d393ba53) {
    case #"ammomod_napalmburst":
        return napalmburst[tier];
    case #"ammomod_cryofreeze":
        return cryofreeze[tier];
    case #"ammomod_brainrot":
        return brainrot[tier];
    case #"ammomod_deadwire":
        return deadwire[tier];
    }
}

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 2, eflags: 0x1 linked
// Checksum 0xda7e8686, Offset: 0x18e0
// Size: 0x646
function function_4609e67c(machine, trigger) {
    self endon(#"hash_6dd2905cac0ff8d0");
    trigger sethintstring("");
    if (isdefined(machine.objectiveid)) {
        objective_setinvisibletoplayer(machine.objectiveid, self);
    }
    self endoncallback(&function_6c71e778, #"death");
    self thread function_a9a3d4e0(machine, trigger);
    while (true) {
        waitresult = self waittill(#"menuresponse");
        menu = waitresult.menu;
        response = waitresult.response;
        intpayload = waitresult.intpayload;
        if (menu == #"sr_weapon_upgrade_menu") {
            weapon = self getcurrentweapon();
            item = item_inventory::function_230ceec4(weapon);
            switch (waitresult.response) {
            case #"hash_6235f4ca625f415":
                var_82e23366 = getunlockableiteminfofromindex(intpayload, 3);
                var_438da649 = function_b143666d(intpayload, 3);
                var_461c9e9e = var_82e23366.namehash;
                aat_name = function_d6739845(var_461c9e9e);
                var_dfa2c41b = var_438da649.var_b5ec8024;
                if (!isdefined(var_dfa2c41b)) {
                    var_dfa2c41b = 0;
                }
                var_3069fe3 = self zm_score::can_player_purchase(var_dfa2c41b);
                var_42a3b8a3 = self function_10e802ad();
                if (isdefined(item)) {
                    if (!is_true(item.var_a6762160.var_6e136726) && var_3069fe3 && !aat::is_exempt_weapon(weapon) && var_42a3b8a3 != aat_name && item.networkid != 32767) {
                        var_4f0c684c = zm_aat::function_296cde87(aat_name);
                        switch (var_4f0c684c) {
                        case #"ammomod_napalmburst":
                            self playlocalsound(#"hash_51ce55cb5e478c26");
                            break;
                        case #"ammomod_cryofreeze":
                            self playlocalsound(#"hash_110bd5fceb403850");
                            break;
                        case #"ammomod_brainrot":
                            self playlocalsound(#"hash_26a2938f2f36ad31");
                            break;
                        case #"ammomod_deadwire":
                            self playlocalsound(#"hash_55e994939fce271b");
                            break;
                        }
                        var_8c590502 = isdefined(getgametypesetting(#"hash_3c2c78e639bfd3c6")) ? getgametypesetting(#"hash_3c2c78e639bfd3c6") : 0;
                        if (var_8c590502 > 0) {
                            aat_name = function_4df229d6(var_4f0c684c, var_8c590502);
                        }
                        self zm_weapons::function_37e9e0cb(item, weapon, aat_name);
                        self refill_ammo();
                        self update_aat_hud(aat_name);
                        self zm_score::minus_to_player_score(var_dfa2c41b);
                    } else {
                        machine playsoundtoplayer(#"uin_default_action_denied", self);
                    }
                }
                break;
            case #"hash_199f079f459775b4":
                var_a8bccf69 = intpayload;
                var_340eb1b = level.var_af0de66[var_a8bccf69];
                var_3069fe3 = self zm_score::can_player_purchase(var_340eb1b);
                if (isdefined(item) && var_3069fe3 && var_a8bccf69 <= 3 && item.networkid != 32767) {
                    self playlocalsound(#"hash_1a8a0ca90d106338" + var_a8bccf69);
                    item_inventory::function_73ae3380(item, var_a8bccf69);
                    self zm_score::minus_to_player_score(var_340eb1b);
                }
                break;
            case #"hash_383c519d3bdac984":
                self notify(#"hash_213991f4845a7f0f");
                self function_6c71e778(machine, trigger);
                return;
            }
        }
    }
}

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 1, eflags: 0x1 linked
// Checksum 0x58375a0b, Offset: 0x1f30
// Size: 0xea
function function_be24d7ce(item) {
    if (isdefined(item.var_a6762160)) {
        rarity = item.var_a6762160.rarity;
        weapon = item.var_a6762160.weapon;
        if (!isdefined(rarity) || rarity == #"none") {
            return;
        }
        if (isdefined(level.var_dcd62c45[weapon.name][rarity])) {
            var_c4139485 = level.var_dcd62c45[weapon.name][rarity];
            point = function_4ba8fde(var_c4139485);
            if (isdefined(point.var_a6762160)) {
                return point;
            }
        }
    }
}

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 1, eflags: 0x1 linked
// Checksum 0x6a122c71, Offset: 0x2028
// Size: 0x44
function function_329ecd95(destination) {
    level flag::wait_till("start_zombie_round_logic");
    waittillframeend();
    function_ff03fdfb(destination);
}

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 1, eflags: 0x1 linked
// Checksum 0x211fd91, Offset: 0x2078
// Size: 0x16c
function function_ff03fdfb(destination) {
    if (isdefined(level.var_ce45839f)) {
        level waittill(level.var_ce45839f);
    }
    foreach (location in destination.locations) {
        var_55bc5738 = location.instances[#"hash_448adaf187bbb953"];
        if (isdefined(var_55bc5738)) {
            children = namespace_8b6a9d79::function_f703a5a(var_55bc5738);
            foreach (child in children) {
                function_e0069640(child);
            }
        }
    }
}

