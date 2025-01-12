#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace namespace_7f22227a;

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 0, eflags: 0x6
// Checksum 0x64207cca, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_57d25af0f70db5a0", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 0, eflags: 0x5 linked
// Checksum 0xecd813ca, Offset: 0xb8
// Size: 0x7c
function private function_70a657d8() {
    if (currentsessionmode() == 4) {
        return;
    }
    /#
        if (getdvarint(#"hash_2eda0a268022b038", 0)) {
            function_cda12fea();
        }
    #/
    callback::on_connect(&on_player_connect);
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 0, eflags: 0x5 linked
// Checksum 0xa0ab199e, Offset: 0x140
// Size: 0x34
function private on_player_connect() {
    if (!isbot(self)) {
        return;
    }
    function_293c5838(0);
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 1, eflags: 0x5 linked
// Checksum 0xf4283d40, Offset: 0x180
// Size: 0xcc
function private function_293c5838(loadoutclass) {
    loadouts = function_798e35b8();
    if (isstruct(loadouts) && isarray(loadouts.defaultloadouts) && loadouts.defaultloadouts.size > 0) {
        defaultindex = randomint(loadouts.defaultloadouts.size);
        self function_6e9256df(loadoutclass, loadouts.defaultloadouts[defaultindex], loadouts.killstreaks);
    }
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 0, eflags: 0x5 linked
// Checksum 0x34c9fd0b, Offset: 0x258
// Size: 0x7e
function private function_798e35b8() {
    sessionmode = currentsessionmode();
    if (sessionmode == 1) {
        return getscriptbundle(#"mp_default_loadouts");
    } else if (sessionmode == 3) {
        return getscriptbundle(#"wz_default_loadouts");
    }
    return undefined;
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 3, eflags: 0x5 linked
// Checksum 0x39344c4c, Offset: 0x2e0
// Size: 0x1c4
function private function_6e9256df(loadoutclass, loadout, killstreaks) {
    self function_b4a1d42a(loadoutclass);
    self function_77b1af33(loadoutclass, loadout.primary, loadout.primaryattachments, &function_29b482e0, &function_9d5e1230);
    self function_77b1af33(loadoutclass, loadout.secondary, loadout.secondaryattachments, &function_7db40dda, &function_25ac8c68);
    self function_5f0a2e93(loadoutclass, loadout.primarygrenade, loadout.var_1c89585f, &function_9a75f033);
    self function_5f0a2e93(loadoutclass, loadout.secondarygrenade, loadout.var_285151c1, &function_ac5568db);
    self function_5f0a2e93(loadoutclass, loadout.specialgrenade, loadout.var_919cf3d3, &function_493daf47);
    self function_c4df3167(loadoutclass, loadout.talents);
    self function_292a0c64(loadoutclass, loadout.bonuscards);
    self function_ff592356(loadoutclass, killstreaks);
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 5, eflags: 0x5 linked
// Checksum 0x9f44f848, Offset: 0x4b0
// Size: 0xee
function private function_77b1af33(loadoutclass, weaponname, attachments, var_c2575532, var_1b426c77) {
    if (!isdefined(weaponname)) {
        return;
    }
    self [[ var_c2575532 ]](loadoutclass, weaponname);
    if (isdefined(attachments)) {
        foreach (i, attachment in attachments) {
            attachmentname = attachment.attachment;
            if (isdefined(attachmentname)) {
                self [[ var_1b426c77 ]](loadoutclass, attachmentname, i);
            }
        }
    }
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 4, eflags: 0x5 linked
// Checksum 0xb066ba3, Offset: 0x5a8
// Size: 0x50
function private function_5f0a2e93(loadoutclass, var_31a03cfe, extragrenade, var_632ae174) {
    if (!isdefined(var_31a03cfe)) {
        return;
    }
    if (!isdefined(extragrenade)) {
        extragrenade = 0;
    }
    self [[ var_632ae174 ]](loadoutclass, var_31a03cfe, extragrenade);
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 2, eflags: 0x5 linked
// Checksum 0x87821a7d, Offset: 0x600
// Size: 0xc0
function private function_c4df3167(loadoutclass, talents) {
    if (!isdefined(talents)) {
        return;
    }
    foreach (i, talent in talents) {
        talentname = talent.talent;
        if (isdefined(talentname)) {
            self function_5a385365(loadoutclass, talentname, i);
        }
    }
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 2, eflags: 0x5 linked
// Checksum 0xaa5f77aa, Offset: 0x6c8
// Size: 0xc0
function private function_292a0c64(loadoutclass, bonuscards) {
    if (!isdefined(bonuscards)) {
        return;
    }
    foreach (i, bonuscard in bonuscards) {
        bonuscardname = bonuscard.bonuscard;
        if (isdefined(bonuscardname)) {
            self function_f9b438ba(loadoutclass, bonuscardname, i);
        }
    }
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 2, eflags: 0x5 linked
// Checksum 0x210cdce, Offset: 0x790
// Size: 0xc0
function private function_ff592356(loadoutclass, killstreaks) {
    if (!isdefined(killstreaks)) {
        return;
    }
    foreach (i, killstreak in killstreaks) {
        killstreakname = killstreak.killstreak;
        if (isdefined(killstreakname)) {
            self function_60c5f1d4(loadoutclass, killstreakname, i);
        }
    }
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 0, eflags: 0x5 linked
// Checksum 0xef05d295, Offset: 0x858
// Size: 0xd2
function private primary() {
    return array(#"ar_accurate_t9", #"ar_damage_t9", #"ar_standard_t9", #"lmg_accurate_t9", #"lmg_light_t9", #"smg_handling_t9", #"smg_heavy_t9", #"smg_standard_t9", #"sniper_quickscope_t9", #"sniper_standard_t9", #"tr_damagesemi_t9", #"tr_longburst_t9");
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 0, eflags: 0x5 linked
// Checksum 0x24d3c8c9, Offset: 0x938
// Size: 0x62
function private secondary() {
    return array(#"launcher_standard_t9", #"pistol_burst_t9", #"pistol_semiauto_t9", #"shotgun_pump_t9", #"shotgun_semiauto_t9");
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 0, eflags: 0x5 linked
// Checksum 0x5f7633a8, Offset: 0x9a8
// Size: 0x62
function private offhand_primary() {
    return array(#"eq_molotov", #"eq_sticky_grenade", #"frag_grenade", #"hatchet", #"satchel_charge");
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 0, eflags: 0x5 linked
// Checksum 0xa6d4d904, Offset: 0xa18
// Size: 0x52
function private function_d5fb303a() {
    return array(#"hash_5453c9b880261bcb", #"eq_slow_grenade", #"hash_364914e1708cb629", #"willy_pete");
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 0, eflags: 0x5 linked
// Checksum 0xb23f86b9, Offset: 0xa78
// Size: 0x92
function private offhand_special() {
    return array(#"ability_smart_cover", #"gadget_jammer", #"gadget_supplypod", #"hash_2b9efbad11308e02", #"listening_device", #"missile_turret", #"tear_gas", #"trophy_system");
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 0, eflags: 0x5 linked
// Checksum 0x2137fca8, Offset: 0xb18
// Size: 0x52
function private perk1() {
    return array(#"talent_engineer", #"talent_flakjacket", #"talent_resistance", #"hash_7321f9058ee65217");
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 0, eflags: 0x5 linked
// Checksum 0xb9757688, Offset: 0xb78
// Size: 0x62
function private perk2() {
    return array(#"hash_1942ae235ffc270f", #"hash_311283e3107dec74", #"hash_59c460a16d8c1e96", #"talent_scavenger", #"talent_tracker");
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 0, eflags: 0x5 linked
// Checksum 0x6b641f14, Offset: 0xbe8
// Size: 0x52
function private perk3() {
    return array(#"talent_coldblooded", #"talent_ghost", #"talent_gungho", #"hash_72c04b85952128e4");
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 0, eflags: 0x5 linked
// Checksum 0x74d291a8, Offset: 0xc48
// Size: 0x162
function private scorestreak() {
    return array(#"ac130", #"chopper_gunner", #"counteruav", #"helicopter_comlink", #"hero_annihilator", #"hero_flamethrower", #"hero_pineapplegun", #"hoverjet", #"jetfighter", #"napalm_strike", #"planemortar", #"recon_car", #"recon_plane", #"remote_missile", #"sig_bow_flame", #"sig_lmg", #"straferun", #"supplydrop_marker", #"uav", #"ultimate_turret", #"weapon_armor");
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 2, eflags: 0x5 linked
// Checksum 0xe2a2c66f, Offset: 0xdb8
// Size: 0xb0
function private function_20b56ee0(var_91f30a6d, overridedvar = undefined) {
    /#
        if (isdefined(overridedvar)) {
            dvarstr = getdvarstring(overridedvar, "<dev string:x38>");
            if (dvarstr == "<dev string:x3c>") {
                return [];
            }
            list = strtok(dvarstr, "<dev string:x44>");
            if (list.size > 0) {
                return list;
            }
        }
    #/
    return [[ var_91f30a6d ]]();
}

/#

    // Namespace namespace_7f22227a/namespace_7f22227a
    // Params 0, eflags: 0x4
    // Checksum 0xa8f026c3, Offset: 0xe70
    // Size: 0xf4
    function private function_cda12fea() {
        function_a6928b16(primary());
        function_a6928b16(secondary());
        function_a6928b16(offhand_primary());
        function_a6928b16(function_d5fb303a());
        function_a6928b16(offhand_special());
        function_a6928b16(scorestreak());
    }

    // Namespace namespace_7f22227a/namespace_7f22227a
    // Params 1, eflags: 0x4
    // Checksum 0x2e2351d0, Offset: 0xf70
    // Size: 0xc0
    function private function_a6928b16(weaponlist) {
        foreach (name in weaponlist) {
            weapon = getweapon(name);
            assert(isdefined(weapon), "<dev string:x49>" + name);
        }
    }

#/

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 1, eflags: 0x4
// Checksum 0x7369d514, Offset: 0x1038
// Size: 0x2ac
function private function_ac18dd0c(classindex = 0) {
    self function_a6720fe8(classindex);
    primaryweaponname = self function_c63cb64c(classindex, function_20b56ee0(&primary, #"hash_5b5f44e15bfa8dee"));
    secondaryweaponname = self function_c63cb64c(classindex, function_20b56ee0(&secondary, #"hash_41674514bd7e81e2"));
    self function_c63cb64c(classindex, function_20b56ee0(&perk1, #"hash_7e8686a7207f1d0f"));
    self function_c63cb64c(classindex, function_20b56ee0(&perk2, #"hash_7e8687a7207f1ec2"));
    self function_c63cb64c(classindex, function_20b56ee0(&perk3, #"hash_7e8688a7207f2075"));
    self function_c63cb64c(classindex, function_20b56ee0(&offhand_primary, #"hash_5c063c13c25c3b6a"));
    self function_c63cb64c(classindex, function_20b56ee0(&function_d5fb303a, #"hash_60b994f55d1226dd"));
    self function_c63cb64c(classindex, function_20b56ee0(&offhand_special, #"hash_539a0aed726d68e0"));
    self function_4af627f0(classindex);
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 2, eflags: 0x5 linked
// Checksum 0x705c931b, Offset: 0x12f0
// Size: 0x68
function private function_c63cb64c(classindex, list) {
    if (list.size <= 0) {
        return undefined;
    }
    item = list[randomint(list.size)];
    self botclassadditem(classindex, item);
    return item;
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 4, eflags: 0x4
// Checksum 0xbc622794, Offset: 0x1360
// Size: 0xac
function private function_8d38ec3(classindex, weaponname, var_1effd263, count) {
    if (!isdefined(weaponname)) {
        return;
    }
    attachments = getrandomcompatibleattachmentsforweapon(getweapon(weaponname), count);
    for (i = 0; i < attachments.size; i++) {
        self botclassaddattachment(classindex, weaponname, attachments[i], var_1effd263 + i + 1);
    }
}

// Namespace namespace_7f22227a/namespace_7f22227a
// Params 1, eflags: 0x5 linked
// Checksum 0xef1e4444, Offset: 0x1418
// Size: 0xd4
function private function_4af627f0(classindex) {
    list = function_20b56ee0(&scorestreak, #"hash_510ea418ef874618");
    for (i = 0; list.size > 0 && i < 3; i++) {
        randomindex = randomint(list.size);
        self botclassadditem(classindex, list[randomindex]);
        arrayremoveindex(list, randomindex);
    }
}

