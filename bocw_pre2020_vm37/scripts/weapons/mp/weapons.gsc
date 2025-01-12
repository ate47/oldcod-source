#using scripts\core_common\system_shared;
#using scripts\core_common\weapons_shared;
#using scripts\weapons\weapons;

#namespace weapons;

// Namespace weapons/weapons
// Params 0, eflags: 0x6
// Checksum 0x8d0fb71, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"weapons", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace weapons/weapons
// Params 0, eflags: 0x5 linked
// Checksum 0x30f85797, Offset: 0xd8
// Size: 0x6c
function private function_70a657d8() {
    if (!isdefined(level.var_3a0bbaea)) {
        level.var_3a0bbaea = 1;
    }
    init_shared();
    if (getdvarint(#"hash_4b9236f918e3e6f3", 0) == 0) {
        function_6916626d();
    }
}

// Namespace weapons/weapons
// Params 2, eflags: 0x0
// Checksum 0xf56423e4, Offset: 0x150
// Size: 0xe4
function bestweapon_init(weapon, options) {
    weapon_data = [];
    weapon_data[#"weapon"] = weapon;
    weapon_data[#"options"] = options;
    weapon_data[#"kill_count"] = 0;
    weapon_data[#"spawned_with"] = 0;
    key = self.pers[#"bestweapon"][weapon.name].size;
    self.pers[#"bestweapon"][weapon.name][key] = weapon_data;
    return key;
}

// Namespace weapons/weapons
// Params 2, eflags: 0x0
// Checksum 0x7c812a5d, Offset: 0x240
// Size: 0x16e
function bestweapon_find(weapon, options) {
    if (!isdefined(self.pers[#"bestweapon"])) {
        self.pers[#"bestweapon"] = [];
    }
    if (!isdefined(self.pers[#"bestweapon"][weapon.name])) {
        self.pers[#"bestweapon"][weapon.name] = [];
    }
    name = weapon.name;
    size = self.pers[#"bestweapon"][name].size;
    for (index = 0; index < size; index++) {
        if (self.pers[#"bestweapon"][name][index][#"weapon"] == weapon && self.pers[#"bestweapon"][name][index][#"options"] == options) {
            return index;
        }
    }
    return undefined;
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x4e90d9c0, Offset: 0x3b8
// Size: 0x200
function bestweapon_get() {
    most_kills = 0;
    most_spawns = 0;
    if (!isdefined(self.pers[#"bestweapon"])) {
        return;
    }
    best_key = 0;
    best_index = 0;
    weapon_keys = getarraykeys(self.pers[#"bestweapon"]);
    for (key_index = 0; key_index < weapon_keys.size; key_index++) {
        key = weapon_keys[key_index];
        size = self.pers[#"bestweapon"][key].size;
        for (index = 0; index < size; index++) {
            kill_count = self.pers[#"bestweapon"][key][index][#"kill_count"];
            spawned_with = self.pers[#"bestweapon"][key][index][#"spawned_with"];
            if (kill_count > most_kills) {
                best_index = index;
                best_key = key;
                most_kills = kill_count;
                most_spawns = spawned_with;
                continue;
            }
            if (kill_count == most_kills && spawned_with > most_spawns) {
                best_index = index;
                best_key = key;
                most_kills = kill_count;
                most_spawns = spawned_with;
            }
        }
    }
    return self.pers[#"bestweapon"][best_key][best_index];
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0x73dfa33b, Offset: 0x5c0
// Size: 0x1e4
function showcaseweapon_get() {
    showcaseweapondata = self getplayershowcaseweapon();
    if (!isdefined(showcaseweapondata)) {
        return undefined;
    }
    showcase_weapon = [];
    showcase_weapon[#"weapon"] = showcaseweapondata.weapon;
    attachmentnames = [];
    for (index = 0; index < 7; index++) {
        attachmentnames[attachmentnames.size] = "none";
    }
    tokenizedattachmentinfo = strtok(showcaseweapondata.attachmentinfo, "+");
    for (index = 0; index < tokenizedattachmentinfo.size; index++) {
        attachmentnames[index] = tokenizedattachmentinfo[index];
    }
    camoindex = 0;
    paintjobslot = 15;
    showpaintshop = 0;
    tokenizedweaponrenderoptions = strtok(showcaseweapondata.weaponrenderoptions, ",");
    if (tokenizedweaponrenderoptions.size > 2) {
        camoindex = int(tokenizedweaponrenderoptions[0]);
        paintjobslot = int(tokenizedweaponrenderoptions[1]);
        showpaintshop = paintjobslot != 15;
    }
    showcase_weapon[#"options"] = self function_6eff28b5(camoindex, 0, 0, showpaintshop, 1);
    return showcase_weapon;
}

