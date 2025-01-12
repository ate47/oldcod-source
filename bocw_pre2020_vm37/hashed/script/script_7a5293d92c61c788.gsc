#using script_1caf36ff04a85ff6;
#using script_355c6e84a79530cb;
#using script_3751b21462a54a7d;
#using script_5fb26eef020f9958;
#using script_7d7ac1f663edcdc8;
#using script_7fc996fe8678852;
#using scripts\core_common\armor;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;

#namespace namespace_dd7e54e3;

// Namespace namespace_dd7e54e3/namespace_dd7e54e3
// Params 0, eflags: 0x6
// Checksum 0xf8b9030e, Offset: 0x1c0
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"hash_7da9887a9375293", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace namespace_dd7e54e3/namespace_dd7e54e3
// Params 0, eflags: 0x1 linked
// Checksum 0x2e0bdb91, Offset: 0x218
// Size: 0xbc
function function_70a657d8() {
    level.var_2a994cc0 = sr_armor_menu::register();
    level.var_ade77b07 = array(#"hash_6c055e078965b4e3", #"armor_item_lv1_t9_sr", #"armor_item_lv2_t9_sr", #"armor_item_lv3_t9_sr");
    level.var_3a2e321c = array(500, 500, 1500, 3000);
    callback::on_spawned(&function_ef39f61b);
}

// Namespace namespace_dd7e54e3/namespace_dd7e54e3
// Params 0, eflags: 0x1 linked
// Checksum 0xd82a1b5f, Offset: 0x2e0
// Size: 0x84
function postinit() {
    var_f5ae494f = struct::get_array(#"content_destination", "variantname");
    if (zm_utility::is_classic() && isdefined(var_f5ae494f) && var_f5ae494f.size > 0) {
        level thread function_68649d54(var_f5ae494f[0]);
    }
}

// Namespace namespace_dd7e54e3/namespace_dd7e54e3
// Params 1, eflags: 0x1 linked
// Checksum 0x757897ad, Offset: 0x370
// Size: 0x90
function function_1cbc3614(var_beee4994) {
    foreach (struct in var_beee4994) {
        function_93a99046(struct);
    }
}

// Namespace namespace_dd7e54e3/namespace_dd7e54e3
// Params 1, eflags: 0x1 linked
// Checksum 0x836a6be2, Offset: 0x408
// Size: 0x234
function function_93a99046(struct) {
    assert(isstruct(struct), "<dev string:x38>");
    scriptmodel = namespace_8b6a9d79::spawn_script_model(struct, #"hash_7195bed75d89af1");
    if (zm_utility::is_survival()) {
        objid = gameobjects::get_next_obj_id();
        struct.objectiveid = objid;
        scriptmodel.objectiveid = objid;
        objective_add(objid, "active", scriptmodel, #"hash_25a19901af9e8467");
        if (!isdefined(level.var_6bf8ee58)) {
            level.var_6bf8ee58 = [];
        } else if (!isarray(level.var_6bf8ee58)) {
            level.var_6bf8ee58 = array(level.var_6bf8ee58);
        }
        level.var_6bf8ee58[level.var_6bf8ee58.size] = objid;
    }
    trigger = namespace_8b6a9d79::function_214737c7(struct, &function_fe5f8894, #"hash_614130df578d98f0", undefined, 128, 128, undefined, (0, 0, 50));
    trigger.scriptmodel = scriptmodel;
    scriptmodel.trigger = trigger;
    scriptmodel clientfield::set("safehouse_machine_spawn_rob", 1);
    playfx("sr/fx9_safehouse_mchn_upgrades_spawn", struct.origin);
    playsoundatposition(#"hash_5c2fc4437449ddb4", struct.origin);
}

// Namespace namespace_dd7e54e3/namespace_dd7e54e3
// Params 1, eflags: 0x1 linked
// Checksum 0xa3bc1a67, Offset: 0x648
// Size: 0x11c
function function_fe5f8894(eventstruct) {
    player = eventstruct.activator;
    machine = self.scriptmodel;
    assert(isdefined(machine), "<dev string:x5c>");
    if (isplayer(player)) {
        if (!level.var_2a994cc0 sr_armor_menu::is_open(player) && !player clientfield::get_player_uimodel("hudItems.survivalOverlayOpen")) {
            player notify(#"hash_6dd2905cac0ff8d0");
            level.var_2a994cc0 sr_armor_menu::open(player, 0);
            player thread function_cb2d9b9b(machine, self);
            player namespace_553954de::function_14bada94();
        }
    }
}

// Namespace namespace_dd7e54e3/namespace_dd7e54e3
// Params 2, eflags: 0x1 linked
// Checksum 0xc0888b93, Offset: 0x770
// Size: 0xdc
function function_6c71e778(machine, trigger) {
    if (!isplayer(self) || !isdefined(level.var_2a994cc0)) {
        return;
    }
    if (isdefined(machine) && isdefined(trigger)) {
        trigger sethintstring(#"hash_614130df578d98f0");
        if (isdefined(machine.objectiveid)) {
            objective_setvisibletoplayer(machine.objectiveid, self);
        }
    }
    level.var_2a994cc0 sr_armor_menu::close(self);
    self namespace_553954de::function_548f282();
}

// Namespace namespace_dd7e54e3/namespace_dd7e54e3
// Params 0, eflags: 0x1 linked
// Checksum 0xc754b85, Offset: 0x858
// Size: 0x9e
function function_ef39f61b() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    while (true) {
        if ((isdefined(self.armortier) ? self.armortier : 0) != 0 && self.maxarmor != 0) {
            self clientfield::set_player_uimodel("hudItems.armorPercent", self.armor / self.maxarmor);
        }
        waitframe(1);
    }
}

// Namespace namespace_dd7e54e3/namespace_dd7e54e3
// Params 2, eflags: 0x1 linked
// Checksum 0x399bee5, Offset: 0x900
// Size: 0xdc
function function_620db6a4(machine, trigger) {
    self endon(#"disconnect", #"death", #"hash_5e4c1bf6d3ef5df0");
    while (distance2d(self.origin, machine.origin) <= 128 && !self laststand::player_is_in_laststand() && !self isinvehicle()) {
        waitframe(1);
        if (!isdefined(machine)) {
            break;
        }
    }
    self function_6c71e778(machine, trigger);
}

// Namespace namespace_dd7e54e3/namespace_dd7e54e3
// Params 2, eflags: 0x1 linked
// Checksum 0x550b2ceb, Offset: 0x9e8
// Size: 0x306
function function_cb2d9b9b(machine, trigger) {
    self endon(#"hash_6dd2905cac0ff8d0");
    trigger sethintstring("");
    if (isdefined(machine.objectiveid)) {
        objective_setinvisibletoplayer(machine.objectiveid, self);
    }
    self endoncallback(&function_6c71e778, #"death");
    self thread function_620db6a4(machine, trigger);
    while (true) {
        waitresult = self waittill(#"menuresponse");
        menu = waitresult.menu;
        response = waitresult.response;
        intpayload = waitresult.intpayload;
        if (menu == #"sr_armor_menu") {
            weapon = self getcurrentweapon();
            item = item_inventory::function_230ceec4(weapon);
            switch (waitresult.response) {
            case #"hash_1028a1675bc987fe":
                var_1a988176 = level.var_ade77b07[intpayload];
                var_1d1d4a2a = level.var_3a2e321c[intpayload];
                var_3069fe3 = self zm_score::can_player_purchase(var_1d1d4a2a);
                if (var_3069fe3 && isdefined(var_1a988176) && isdefined(var_1d1d4a2a)) {
                    self playlocalsound(#"hash_500cfba1d8f28c89");
                    if (var_1a988176 == #"hash_6c055e078965b4e3") {
                        self.armor = self.maxarmor;
                    } else {
                        self give_armor(var_1a988176);
                    }
                    self zm_score::minus_to_player_score(var_1d1d4a2a);
                } else {
                    machine playsoundtoplayer(#"uin_default_action_denied", self);
                }
                break;
            case #"hash_383c519d3bdac984":
                self notify(#"hash_5e4c1bf6d3ef5df0");
                self function_6c71e778(machine, trigger);
                return;
            }
        }
    }
}

// Namespace namespace_dd7e54e3/namespace_dd7e54e3
// Params 1, eflags: 0x1 linked
// Checksum 0x1d9599da, Offset: 0xcf8
// Size: 0xd2
function give_armor(var_cc87b623) {
    point = function_4ba8fde(var_cc87b623);
    if (isdefined(point) && isdefined(point.var_a6762160)) {
        self function_b2f69241();
        var_fa3df96 = self item_inventory::function_e66dcff5(point);
        self item_inventory::give_inventory_item(point, 1, point.var_a6762160.amount, var_fa3df96);
        self item_inventory::equip_armor(point);
    }
    self.armor = self.maxarmor;
}

// Namespace namespace_dd7e54e3/namespace_dd7e54e3
// Params 0, eflags: 0x1 linked
// Checksum 0x29ba457d, Offset: 0xdd8
// Size: 0x7c
function function_b2f69241() {
    var_416640e8 = self.inventory.items[6];
    if (var_416640e8.networkid != 32767) {
        var_4d7e11d8 = self item_inventory::drop_inventory_item(var_416640e8.networkid);
        if (isdefined(var_4d7e11d8)) {
            var_4d7e11d8 delete();
        }
    }
}

// Namespace namespace_dd7e54e3/namespace_dd7e54e3
// Params 1, eflags: 0x1 linked
// Checksum 0x42a2f134, Offset: 0xe60
// Size: 0x44
function function_68649d54(destination) {
    level flag::wait_till("start_zombie_round_logic");
    waittillframeend();
    function_85834b2c(destination);
}

// Namespace namespace_dd7e54e3/namespace_dd7e54e3
// Params 1, eflags: 0x1 linked
// Checksum 0xe455a6a4, Offset: 0xeb0
// Size: 0x14c
function function_85834b2c(destination) {
    foreach (location in destination.locations) {
        var_55a59069 = location.instances[#"hash_629e563c2ebf707a"];
        if (isdefined(var_55a59069)) {
            children = namespace_8b6a9d79::function_f703a5a(var_55a59069);
            foreach (child in children) {
                function_93a99046(child);
            }
        }
    }
}

