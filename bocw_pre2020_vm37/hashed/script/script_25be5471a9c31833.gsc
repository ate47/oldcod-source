#using script_355c6e84a79530cb;
#using script_3751b21462a54a7d;
#using script_55b68e9c3e3a915b;
#using script_7d7ac1f663edcdc8;
#using script_7fc996fe8678852;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;

#namespace namespace_82b4c2d1;

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 0, eflags: 0x6
// Checksum 0xbfca9584, Offset: 0x240
// Size: 0x64
function private autoexec __init__system__() {
    system::register(#"hash_79fe34c9f8a0e44c", &function_70a657d8, &postinit, &finalize, #"hash_f81b9dea74f0ee");
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 0, eflags: 0x1 linked
// Checksum 0xc8310436, Offset: 0x2b0
// Size: 0x1c
function function_70a657d8() {
    level.var_5df76d0 = sr_perk_machine_choice::register();
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 0, eflags: 0x1 linked
// Checksum 0x5559f630, Offset: 0x2d8
// Size: 0x84
function postinit() {
    var_f5ae494f = struct::get_array(#"content_destination", "variantname");
    if (zm_utility::is_classic() && isdefined(var_f5ae494f) && var_f5ae494f.size > 0) {
        level thread function_8605eb86(var_f5ae494f[0]);
    }
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x368
// Size: 0x4
function finalize() {
    
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 0, eflags: 0x0
// Checksum 0xd6e3cf01, Offset: 0x378
// Size: 0x2b8
function function_1532e0b6() {
    foreach (location in level.var_7d45d0d4.locations) {
        function_999594fe(location.var_fe2612fe[#"hash_158cc8ce18ad2dbc"], #"hash_5c11dcd882aa848a", #"p7_zm_vending_jugg", #"talent_juggernog", function_cce40d6d(#"talent_juggernog"));
        function_999594fe(location.var_fe2612fe[#"hash_7ee78beca217d7fe"], #"hash_249eb4d334db41f4", #"p7_zm_vending_revive", #"hash_7f98b3dd3cce95aa", function_cce40d6d(#"hash_7f98b3dd3cce95aa"));
        function_999594fe(location.var_fe2612fe[#"hash_560082c9da5ef68e"], #"hash_5a2711fd4875c104", #"p7_zm_vending_sleight", #"hash_5930cf0eb070e35a", function_cce40d6d(#"hash_5930cf0eb070e35a"));
        function_999594fe(location.var_fe2612fe[#"hash_6e55d13f9423215a"], #"hash_56e1ed93d9ce235c", #"hash_43372808f8cd00cb", #"hash_4110e6372aa77f7e", function_cce40d6d(#"hash_4110e6372aa77f7e"));
        function_999594fe(location.var_fe2612fe[#"perk_machine_choice"], #"hash_4af85251966549b8", #"hash_7394911732c68226", #"hash_3eac5ec7a888ddfb", 0);
    }
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 5, eflags: 0x1 linked
// Checksum 0x8a7ce6a, Offset: 0x638
// Size: 0xe0
function function_999594fe(var_beee4994, hint_string, model, var_c024c2e0, cost) {
    if (!isdefined(var_beee4994)) {
        return;
    }
    foreach (var_7d0e37f8 in var_beee4994) {
        if (isdefined(var_7d0e37f8.content_key)) {
            function_744f2a2(var_7d0e37f8, var_7d0e37f8.content_key, model, hint_string, var_c024c2e0, cost, &function_472f16d8);
        }
    }
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 7, eflags: 0x1 linked
// Checksum 0xfe4977a, Offset: 0x720
// Size: 0x31c
function function_744f2a2(struct, var_a0f07ebc, modelname, hint_string, var_c024c2e0, cost, callbackfunction) {
    assert(isstruct(struct), "<dev string:x38>");
    assert(isfunctionptr(callbackfunction), "<dev string:x5c>");
    assert(isdefined(modelname), "<dev string:x87>");
    assert(isdefined(hint_string), "<dev string:xaf>");
    assert(isdefined(var_c024c2e0), "<dev string:xdd>");
    assert(isdefined(cost), "<dev string:x104>");
    scriptmodel = namespace_8b6a9d79::spawn_script_model(struct, modelname);
    if (zm_utility::is_survival()) {
        objid = gameobjects::get_next_obj_id();
        struct.objectiveid = objid;
        scriptmodel.objectiveid = objid;
        objective_add(objid, "active", scriptmodel, #"hash_75209b2b8f60e888");
        if (!isdefined(level.var_6bf8ee58)) {
            level.var_6bf8ee58 = [];
        } else if (!isarray(level.var_6bf8ee58)) {
            level.var_6bf8ee58 = array(level.var_6bf8ee58);
        }
        level.var_6bf8ee58[level.var_6bf8ee58.size] = objid;
    }
    trigger = namespace_8b6a9d79::function_214737c7(struct, callbackfunction, hint_string, undefined, 128, 128, undefined, (0, 0, 50));
    trigger.scriptmodel = scriptmodel;
    trigger.var_a0f07ebc = var_a0f07ebc;
    trigger.var_c024c2e0 = var_c024c2e0;
    trigger.var_87abc3a0 = cost;
    scriptmodel.trigger = trigger;
    if (modelname == #"hash_7394911732c68226") {
        struct thread function_dc1b3863(scriptmodel);
        scriptmodel thread function_fb26782d("random");
        return;
    }
    struct function_8d0d8a65();
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 0, eflags: 0x1 linked
// Checksum 0x22109383, Offset: 0xa48
// Size: 0x54
function function_8d0d8a65() {
    playfx("sr/fx9_safehouse_mchn_wonderfizz_spawn", self.origin);
    playsoundatposition(#"hash_5c2fc4437449ddb4", self.origin);
    wait 1;
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 1, eflags: 0x1 linked
// Checksum 0xd1a2f2d0, Offset: 0xaa8
// Size: 0x9c
function function_dc1b3863(scriptmodel) {
    scriptmodel clientfield::set("safehouse_machine_spawn_rob", 1);
    playfx("sr/fx9_safehouse_mchn_wonderfizz_spawn", self.origin);
    playsoundatposition(#"hash_5c2fc4437449ddb4", self.origin);
    wait 1;
    scriptmodel playloopsound(#"zmb_rand_perk_sparks");
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 3, eflags: 0x0
// Checksum 0xdbf11b34, Offset: 0xb50
// Size: 0x1c
function perk_random_loop_anim(*n_piece, *s_anim_1, *s_anim_2) {
    
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 1, eflags: 0x1 linked
// Checksum 0x17a13f55, Offset: 0xb78
// Size: 0x2d4
function function_472f16d8(eventstruct) {
    player = eventstruct.activator;
    machine = self.scriptmodel;
    var_da8463d0 = self.var_a0f07ebc;
    var_c024c2e0 = self.var_c024c2e0;
    var_87abc3a0 = self.var_87abc3a0;
    assert(isdefined(machine), "<dev string:x12b>");
    assert(isdefined(var_da8463d0), "<dev string:x151>");
    assert(isdefined(var_c024c2e0), "<dev string:x179>");
    assert(isdefined(var_87abc3a0), "<dev string:x1a4>");
    if (isplayer(player)) {
        if (var_c024c2e0 == #"hash_3eac5ec7a888ddfb") {
            if (!level.var_5df76d0 sr_perk_machine_choice::is_open(player) && !player clientfield::get_player_uimodel("hudItems.survivalOverlayOpen")) {
                player notify(#"hash_6dd2905cac0ff8d0");
                level.var_5df76d0 sr_perk_machine_choice::open(player, 0);
                player thread function_4513f006(machine, self);
                player namespace_553954de::function_14bada94();
            }
            return;
        }
        var_11868f5d = player namespace_791d0451::function_b852953c(var_c024c2e0);
        var_3069fe3 = player zm_score::can_player_purchase(var_87abc3a0);
        if (var_3069fe3 && !player namespace_791d0451::function_56cedda7(var_11868f5d)) {
            player playsoundtoplayer(#"hash_70f9bc3fce59c959", player);
            player namespace_791d0451::function_f7886822(var_11868f5d);
            player zm_score::minus_to_player_score(var_87abc3a0);
            player namespace_791d0451::function_3fecad82(var_11868f5d);
            return;
        }
        machine playsoundtoplayer(#"uin_default_action_denied", player);
    }
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 2, eflags: 0x1 linked
// Checksum 0x8f805764, Offset: 0xe58
// Size: 0xdc
function function_6c71e778(machine, trigger) {
    if (!isplayer(self) || !isdefined(level.var_5df76d0)) {
        return;
    }
    if (isdefined(machine) && isdefined(trigger)) {
        trigger sethintstring(#"hash_4af85251966549b8");
        if (isdefined(machine.objectiveid)) {
            objective_setvisibletoplayer(machine.objectiveid, self);
        }
    }
    level.var_5df76d0 sr_perk_machine_choice::close(self);
    self namespace_553954de::function_548f282();
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 1, eflags: 0x1 linked
// Checksum 0x3771b7f1, Offset: 0xf40
// Size: 0x6a
function function_cce40d6d(var_ecde8ba) {
    item_index = getitemindexfromref(var_ecde8ba);
    var_438da649 = function_b143666d(item_index, 5);
    return function_2c5b6acc(var_438da649);
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 1, eflags: 0x1 linked
// Checksum 0xc1476714, Offset: 0xfb8
// Size: 0x16
function function_2c5b6acc(var_438da649) {
    return var_438da649.var_b5ec8024;
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 1, eflags: 0x1 linked
// Checksum 0x7670de8a, Offset: 0xfd8
// Size: 0xa6
function function_5d21ed88(var_82e23366) {
    var_8c590502 = isdefined(getgametypesetting(#"hash_3c2c78e639bfd3c6")) ? getgametypesetting(#"hash_3c2c78e639bfd3c6") : 0;
    if (var_8c590502 > 0) {
        if (isdefined(var_82e23366.name)) {
            return namespace_791d0451::function_1b16bd84(var_82e23366.name, var_8c590502);
        }
    }
    return var_82e23366.namehash;
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 2, eflags: 0x1 linked
// Checksum 0x23320cbf, Offset: 0x1088
// Size: 0xdc
function function_3fec008f(machine, trigger) {
    self endon(#"disconnect", #"death", #"hash_2a909cd1a72f625b");
    while (distance2d(self.origin, machine.origin) <= 128 && !self laststand::player_is_in_laststand() && !self isinvehicle()) {
        waitframe(1);
        if (!isdefined(machine)) {
            break;
        }
    }
    self function_6c71e778(machine, trigger);
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 2, eflags: 0x1 linked
// Checksum 0xeedaa6bd, Offset: 0x1170
// Size: 0x326
function function_4513f006(machine, trigger) {
    self endon(#"hash_6dd2905cac0ff8d0");
    trigger sethintstring("");
    if (isdefined(machine.objectiveid)) {
        objective_setinvisibletoplayer(machine.objectiveid, self);
    }
    self endoncallback(&function_6c71e778, #"death");
    self thread function_3fec008f(machine, trigger);
    while (true) {
        waitresult = self waittill(#"menuresponse");
        menu = waitresult.menu;
        response = waitresult.response;
        intpayload = waitresult.intpayload;
        if (menu == #"sr_perk_machine_choice") {
            switch (waitresult.response) {
            case #"hash_5c8984efe0e105db":
                var_82e23366 = getunlockableiteminfofromindex(intpayload, 5);
                var_438da649 = function_b143666d(intpayload, 5);
                talent = function_5d21ed88(var_82e23366);
                var_87abc3a0 = function_2c5b6acc(var_438da649);
                if (!isdefined(var_87abc3a0)) {
                    var_87abc3a0 = 0;
                }
                var_3069fe3 = self zm_score::can_player_purchase(var_87abc3a0);
                if (isdefined(talent) && var_3069fe3 && !self namespace_791d0451::function_56cedda7(talent)) {
                    self namespace_791d0451::function_f7886822(talent);
                    self zm_score::minus_to_player_score(var_87abc3a0);
                    self namespace_791d0451::function_3fecad82(talent);
                    machine thread function_10ccf991(talent);
                } else {
                    machine playsoundtoplayer(#"hash_5334aa3b6d25f949", self);
                }
                break;
            case #"hash_383c519d3bdac984":
                self notify(#"hash_2a909cd1a72f625b");
                self function_6c71e778(machine, trigger);
                return;
            }
        }
    }
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 1, eflags: 0x1 linked
// Checksum 0xc65f15ba, Offset: 0x14a0
// Size: 0x36e
function function_10ccf991(var_11868f5d) {
    self endon(#"death");
    if (is_true(self.var_c000552f)) {
        return;
    }
    str_alias = undefined;
    switch (var_11868f5d) {
    case #"talent_juggernog":
    case #"hash_afdc57f440fb620":
    case #"hash_afdc67f440fb7d3":
    case #"hash_afdc97f440fbcec":
    case #"hash_afdcb7f440fc052":
    case #"hash_afdcc7f440fc205":
        str_alias = #"mus_perks_jugganog_sting";
        break;
    case #"hash_504b3ef717f88e01":
    case #"hash_504b3ff717f88fb4":
    case #"hash_504b40f717f89167":
    case #"hash_504b41f717f8931a":
    case #"hash_7f98b3dd3cce95aa":
    case #"hash_504b3df717f88c4e":
        str_alias = #"mus_perks_revive_sting";
        break;
    case #"hash_520b59b0216b70be":
    case #"hash_520b5ab0216b7271":
    case #"hash_520b5bb0216b7424":
    case #"hash_520b5cb0216b75d7":
    case #"hash_520b5db0216b778a":
    case #"hash_5930cf0eb070e35a":
        str_alias = #"mus_perks_speed_sting";
        break;
    case #"hash_1f95b08e4a49d87e":
    case #"hash_1f95b18e4a49da31":
    case #"hash_1f95b28e4a49dbe4":
    case #"hash_1f95b38e4a49dd97":
    case #"hash_1f95b48e4a49df4a":
    case #"hash_210097a75bb6c49a":
        str_alias = #"mus_perks_deadshot_sting";
        break;
    case #"hash_17ccbaee64daa05b":
    case #"hash_17ccbbee64daa20e":
    case #"hash_17ccbcee64daa3c1":
    case #"hash_17ccbdee64daa574":
    case #"hash_17ccbeee64daa727":
    case #"hash_602a1b6107105f07":
        str_alias = #"mus_perks_stamin_sting";
        break;
    case #"hash_79774256f321d408":
    case #"hash_79774356f321d5bb":
    case #"hash_79774556f321d921":
    case #"hash_79774856f321de3a":
    case #"hash_79774956f321dfed":
    case #"hash_51b6cc6dbafb7f31":
        str_alias = #"mus_perks_elementalpop_sting";
        break;
    }
    if (isdefined(str_alias)) {
        self.var_c000552f = 1;
        self playsound(str_alias);
        wait 5;
        self.var_c000552f = 0;
    }
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 1, eflags: 0x1 linked
// Checksum 0x749c0285, Offset: 0x1818
// Size: 0x18a
function function_fb26782d(str_type) {
    self endon(#"death");
    if (str_type == "random") {
        var_3354472e = array("mus_perks_jugganog_jingle", "mus_perks_speed_jingle", "mus_perks_revive_jingle", "mus_perks_stamin_jingle", "mus_perks_deadshot_jingle", "mus_perks_elementalpop_jingle");
    }
    while (true) {
        wait randomintrange(90, 240);
        if (!is_true(self.var_c000552f)) {
            self.var_c000552f = 1;
            var_8f2bdcca = var_3354472e[randomintrange(0, var_3354472e.size)];
            var_dfeb1fd = float(max(isdefined(soundgetplaybacktime(var_8f2bdcca)) ? soundgetplaybacktime(var_8f2bdcca) : 500, 500)) / 1000;
            self playsound(var_8f2bdcca);
            wait var_dfeb1fd;
            self.var_c000552f = 0;
        }
    }
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 1, eflags: 0x1 linked
// Checksum 0xa05926fa, Offset: 0x19b0
// Size: 0x44
function function_8605eb86(destination) {
    level flag::wait_till("start_zombie_round_logic");
    waittillframeend();
    function_d9cdb025(destination);
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 1, eflags: 0x1 linked
// Checksum 0x5b397aad, Offset: 0x1a00
// Size: 0x194
function function_d9cdb025(destination) {
    foreach (location in destination.locations) {
        var_4064e964 = location.instances[#"perk_machine_choice"];
        if (isdefined(var_4064e964)) {
            children = namespace_8b6a9d79::function_f703a5a(var_4064e964);
            foreach (child in children) {
                function_744f2a2(child, #"perk_machine_choice", #"hash_7394911732c68226", #"hash_4af85251966549b8", #"hash_3eac5ec7a888ddfb", 0, &function_472f16d8);
            }
        }
    }
}

