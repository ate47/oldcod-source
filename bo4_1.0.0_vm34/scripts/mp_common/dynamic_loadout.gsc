#using script_702b73ee97d18efe;
#using scripts\abilities\ability_player;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\loadout_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\mp_common\armor;
#using scripts\mp_common\gametypes\menus;
#using scripts\mp_common\pickup_health;
#using scripts\mp_common\player\player_loadout;

#namespace dynamic_loadout;

// Namespace dynamic_loadout/dynamic_loadout
// Params 0, eflags: 0x2
// Checksum 0x9cf7011e, Offset: 0x438
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"dynamic_loadout", &__init__, undefined, #"weapons");
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 0, eflags: 0x4
// Checksum 0x73353a05, Offset: 0x488
// Size: 0x10e
function private __init__() {
    callback::on_connect(&onconnect);
    level.givecustomloadout = &function_4f498c77;
    level.var_1d70db78 = &function_1242804c;
    level.bountypackagelist = getscriptbundlelist("bounty_hunter_package_list");
    registerclientfields();
    level.var_265c8248 = bountyhunterbuy::register("BountyHunterLoadout");
    for (i = 1; i < 38; i++) {
        if (i == 23) {
            continue;
        }
        ability_player::register_gadget_activation_callbacks(i, undefined, &function_cbca802d);
    }
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 2, eflags: 0x4
// Checksum 0x9567d042, Offset: 0x5a0
// Size: 0x104
function private function_cbca802d(slot, weapon) {
    if (!isalive(self)) {
        return;
    }
    var_d0ca821b = self.pers[#"dynamic_loadout"].weapons[2];
    take = 1;
    if (isdefined(var_d0ca821b)) {
        if (var_d0ca821b.ammo > 1) {
            var_d0ca821b.ammo--;
            take = 0;
        }
    }
    if (take) {
        self.pers[#"dynamic_loadout"].weapons[2] = undefined;
        function_49b19715(2, "luielement.BountyHunterLoadout.equipment", 0);
        self function_a765d258(slot);
    }
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 1, eflags: 0x4
// Checksum 0xa8446b59, Offset: 0x6b0
// Size: 0x34
function private function_a765d258(slot) {
    wait 0.1;
    self function_1d590050(slot, 1);
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 0, eflags: 0x4
// Checksum 0xf030fa24, Offset: 0x6f0
// Size: 0x3cc
function private registerclientfields() {
    if (isdefined(level.bountypackagelist)) {
        var_2aefcc3a = int(ceil(log2(level.bountypackagelist.size + 1)));
        var_372c749a = getgametypesetting(#"bountybagomoneymoney");
        var_f887b229 = getgametypesetting(#"hash_63f8d60d122e755b");
        var_c5093b7f = int(ceil(log2(var_372c749a / var_f887b229)));
        clientfield::register("toplayer", "bountyMoney", 1, 14, "int");
        clientfield::register("toplayer", "bountyBagMoney", 1, var_c5093b7f, "int");
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.primary", 1, var_2aefcc3a, "int");
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.secondary", 1, var_2aefcc3a, "int");
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.primaryAttachmentTrack.tierPurchased", 1, 2, "int");
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.secondaryAttachmentTrack.tierPurchased", 1, 2, "int");
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.armor", 1, var_2aefcc3a, "int");
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.mobilityTrack.tierPurchased", 1, 2, "int");
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.reconTrack.tierPurchased", 1, 2, "int");
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.assaultTrack.tierPurchased", 1, 2, "int");
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.supportTrack.tierPurchased", 1, 2, "int");
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.scorestreak", 1, var_2aefcc3a, "int");
        clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.equipment", 1, var_2aefcc3a, "int");
        clientfield::register("worlduimodel", "BountyHunterLoadout.timeRemaining", 1, 5, "int");
        clientfield::register("clientuimodel", "hudItems.BountyCarryingBag", 1, 1, "int");
    }
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 0, eflags: 0x4
// Checksum 0xfd88f544, Offset: 0xac8
// Size: 0x1a8
function private onconnect() {
    if (!isdefined(self.pers[#"dynamic_loadout"])) {
        self.pers[#"dynamic_loadout"] = spawnstruct();
        self.pers[#"dynamic_loadout"].weapons = [];
        self.pers[#"dynamic_loadout"].talents = [];
        self.pers[#"dynamic_loadout"].armor = undefined;
        self.pers[#"dynamic_loadout"].scorestreak = undefined;
        self.pers[#"dynamic_loadout"].clientfields = [];
    }
    self function_d64c015d();
    foreach (var_5e2b6a19 in self.pers[#"dynamic_loadout"].clientfields) {
        self clientfield::set_player_uimodel(var_5e2b6a19.clientfield, var_5e2b6a19.val);
    }
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 0, eflags: 0x4
// Checksum 0x7700aca3, Offset: 0xc78
// Size: 0x7c
function private function_1242804c() {
    self function_b75bdd57(self.pers[#"dynamic_loadout"].armor);
    self function_42e16b65(self.pers[#"dynamic_loadout"].armor);
    self removearmor();
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 0, eflags: 0x0
// Checksum 0xd8e3e816, Offset: 0xd00
// Size: 0x4c
function removearmor() {
    self.pers[#"dynamic_loadout"].armor = undefined;
    self function_49b19715(5, "luielement.BountyHunterLoadout.armor", 0);
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 0, eflags: 0x4
// Checksum 0xd329dddd, Offset: 0xd58
// Size: 0x54
function private function_d64c015d() {
    self menus::register_menu_response_callback("BountyHunterBuy", &function_dee52502);
    self menus::register_menu_response_callback("BountyHunterPackageSelect", &function_dee52502);
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 2, eflags: 0x4
// Checksum 0x1c342115, Offset: 0xdb8
// Size: 0x564
function private function_dee52502(response, intpayload) {
    if (!isdefined(intpayload)) {
        return;
    }
    clientfield = undefined;
    slot = undefined;
    isammo = 0;
    var_59d1cf36 = undefined;
    package = struct::get_script_bundle("bountyhunterpackage", level.bountypackagelist[intpayload - 1]);
    switch (response) {
    case #"hash_28554ae159269915":
        clientfield = "luielement.BountyHunterLoadout.primary";
        slot = 0;
        break;
    case #"hash_c785a629253dcd5":
        clientfield = "luielement.BountyHunterLoadout.secondary";
        slot = 1;
        break;
    case #"hash_390a1acd2edcd5b7":
        var_59d1cf36 = 1;
        clientfield = "luielement.BountyHunterLoadout.primaryAttachmentTrack.tierPurchased";
        slot = 11;
        break;
    case #"hash_390a1bcd2edcd76a":
        var_59d1cf36 = 2;
        clientfield = "luielement.BountyHunterLoadout.primaryAttachmentTrack.tierPurchased";
        slot = 11;
        break;
    case #"hash_390a1ccd2edcd91d":
        var_59d1cf36 = 3;
        clientfield = "luielement.BountyHunterLoadout.primaryAttachmentTrack.tierPurchased";
        slot = 11;
        break;
    case #"hash_2acbda1102e614f7":
        var_59d1cf36 = 1;
        clientfield = "luielement.BountyHunterLoadout.secondaryAttachmentTrack.tierPurchased";
        slot = 12;
        break;
    case #"hash_2acbdb1102e616aa":
        var_59d1cf36 = 2;
        clientfield = "luielement.BountyHunterLoadout.secondaryAttachmentTrack.tierPurchased";
        slot = 12;
        break;
    case #"hash_2acbdc1102e6185d":
        var_59d1cf36 = 3;
        clientfield = "luielement.BountyHunterLoadout.secondaryAttachmentTrack.tierPurchased";
        slot = 12;
        break;
    case #"hash_7760a837c6f81098":
        clientfield = "luielement.BountyHunterLoadout.armor";
        slot = 5;
        break;
    case #"hash_46637ad5c1dd8390":
        clientfield = "luielement.BountyHunterLoadout.mobilityTrack.tierPurchased";
        slot = 6;
        break;
    case #"hash_603babb2a7c35420":
        clientfield = "luielement.BountyHunterLoadout.reconTrack.tierPurchased";
        slot = 7;
        break;
    case #"hash_5792934483949728":
        clientfield = "luielement.BountyHunterLoadout.assaultTrack.tierPurchased";
        slot = 8;
        break;
    case #"hash_265c0500ba88a4a4":
        clientfield = "luielement.BountyHunterLoadout.supportTrack.tierPurchased";
        slot = 9;
        break;
    case #"hash_7b3685fb5a146b83":
        isammo = 1;
        if (function_418137f8(package)) {
            slot = 100;
        } else {
            slot = 101;
        }
        break;
    case #"hash_6e8d37dc2b55eb07":
        clientfield = "luielement.BountyHunterLoadout.scorestreak";
        slot = 10;
        break;
    case #"hash_45dc798feb538f7b":
        clientfield = "luielement.BountyHunterLoadout.equipment";
        slot = 2;
        break;
    }
    if (!self function_1b5c92c0(package, isammo, var_59d1cf36)) {
        return;
    }
    if (slot < 4) {
        self function_43742371(slot, package);
    } else if (slot == 5) {
        self function_60090577(package);
    } else if (slot <= 9) {
        self function_f5a4443(slot, package);
        intpayload = package.tracktier;
    } else if (slot == 10) {
        self function_6f636cca(package);
    } else if (slot <= 12) {
        self function_a5828745(slot - 11, package, var_59d1cf36);
        intpayload = var_59d1cf36;
    } else if (slot <= 101) {
        self addammo(slot - 100, package);
    }
    if (isdefined(clientfield)) {
        self function_49b19715(slot, clientfield, intpayload);
        if (clientfield == "luielement.BountyHunterLoadout.primary") {
            self function_49b19715(11, "luielement.BountyHunterLoadout.primaryAttachmentTrack.tierPurchased", 0);
        } else if (clientfield == "luielement.BountyHunterLoadout.secondary") {
            self function_49b19715(12, "luielement.BountyHunterLoadout.secondaryAttachmentTrack.tierPurchased", 0);
        }
    }
    self function_4f498c77(1, 0);
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 3, eflags: 0x4
// Checksum 0x6063ad06, Offset: 0x1328
// Size: 0x122
function private function_1b5c92c0(package, isammo = 0, var_59d1cf36 = undefined) {
    money = self.pers[#"money"];
    cost = package.purchasecost;
    if (isdefined(isammo) && isammo) {
        cost = package.refillcost;
    } else if (isdefined(var_59d1cf36)) {
        cost = package.attachmentupgrades[var_59d1cf36 - 1].purchasecost;
    }
    if (!isdefined(cost)) {
        return false;
    }
    if (money < cost) {
        return false;
    }
    money -= cost;
    self clientfield::set_to_player("bountyMoney", money);
    self.pers[#"money"] = money;
    return true;
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 2, eflags: 0x4
// Checksum 0x1d218d01, Offset: 0x1458
// Size: 0x126
function private function_43742371(slot, package) {
    self.pers[#"dynamic_loadout"].weapons[slot] = spawnstruct();
    self.pers[#"dynamic_loadout"].weapons[slot].name = package.packageitems[0].item;
    self.pers[#"dynamic_loadout"].weapons[slot].attachments = [];
    self.pers[#"dynamic_loadout"].weapons[slot].ammo = -1;
    self.pers[#"dynamic_loadout"].weapons[slot].startammo = package.startammo;
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 1, eflags: 0x4
// Checksum 0x3f772cd2, Offset: 0x1588
// Size: 0x1da
function private function_60090577(package) {
    self.pers[#"dynamic_loadout"].armor = {};
    self.pers[#"dynamic_loadout"].armor.name = package.packageitems[0].item;
    self.pers[#"dynamic_loadout"].armor.armor = package.armor;
    self.pers[#"dynamic_loadout"].armor.var_29e8f85 = isdefined(package.var_29e8f85) ? package.var_29e8f85 : 0;
    self.pers[#"dynamic_loadout"].armor.var_5f12f8b3 = isdefined(package.var_5f12f8b3) ? package.var_5f12f8b3 : 0;
    self.pers[#"dynamic_loadout"].armor.var_45bb2886 = isdefined(package.var_45bb2886) ? package.var_45bb2886 : 0;
    self.pers[#"dynamic_loadout"].armor.var_7fc0af46 = isdefined(package.var_7fc0af46) ? package.var_7fc0af46 : 0;
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 2, eflags: 0x4
// Checksum 0x2f59064c, Offset: 0x1770
// Size: 0x19e
function private function_f5a4443(slot, package) {
    foreach (talent in package.packageitems) {
        if (!isdefined(self.pers[#"dynamic_loadout"].talents)) {
            self.pers[#"dynamic_loadout"].talents = [];
        } else if (!isarray(self.pers[#"dynamic_loadout"].talents)) {
            self.pers[#"dynamic_loadout"].talents = array(self.pers[#"dynamic_loadout"].talents);
        }
        self.pers[#"dynamic_loadout"].talents[self.pers[#"dynamic_loadout"].talents.size] = talent.item;
    }
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 3, eflags: 0x0
// Checksum 0x664e0491, Offset: 0x1918
// Size: 0xf6
function function_49b19715(slot, clientfield, newval) {
    self clientfield::set_player_uimodel(clientfield, newval);
    if (!isdefined(self.pers[#"dynamic_loadout"].clientfields[slot])) {
        self.pers[#"dynamic_loadout"].clientfields[slot] = spawnstruct();
        self.pers[#"dynamic_loadout"].clientfields[slot].clientfield = clientfield;
    }
    self.pers[#"dynamic_loadout"].clientfields[slot].val = newval;
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 1, eflags: 0x4
// Checksum 0xf067e2ab, Offset: 0x1a18
// Size: 0x84
function private function_418137f8(package) {
    primary = self.pers[#"dynamic_loadout"].weapons[0];
    if (!isdefined(primary)) {
        return false;
    }
    if (!isdefined(primary.name)) {
        return false;
    }
    if (primary.name == package.packageitems[0].item) {
        return true;
    }
    return false;
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 2, eflags: 0x4
// Checksum 0xa584474b, Offset: 0x1aa8
// Size: 0xfa
function private addammo(slot, package) {
    if (isdefined(package.refillammo) && package.refillammo > 0) {
        self.pers[#"dynamic_loadout"].weapons[slot].ammo = package.refillammo;
        return;
    }
    weapdata = self.pers[#"dynamic_loadout"].weapons[slot];
    weapon = getweapon(weapdata.name, weapdata.attachments);
    weapdata.ammo = weapon.maxammo / weapon.clipsize + 1;
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 1, eflags: 0x4
// Checksum 0x159ef0dc, Offset: 0x1bb0
// Size: 0x46
function private function_6f636cca(package) {
    self.pers[#"dynamic_loadout"].scorestreak = package.packageitems[0].item;
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 3, eflags: 0x4
// Checksum 0xe7eb65e1, Offset: 0x1c00
// Size: 0x26e
function private function_a5828745(slot, package, var_59d1cf36) {
    var_cd7828fb = package.attachmentupgrades[var_59d1cf36 - 1].attachmentlist;
    attacharray = strtok(var_cd7828fb, "+");
    foreach (attach in attacharray) {
        if (!isdefined(self.pers[#"dynamic_loadout"].weapons[slot].attachments)) {
            self.pers[#"dynamic_loadout"].weapons[slot].attachments = [];
        } else if (!isarray(self.pers[#"dynamic_loadout"].weapons[slot].attachments)) {
            self.pers[#"dynamic_loadout"].weapons[slot].attachments = array(self.pers[#"dynamic_loadout"].weapons[slot].attachments);
        }
        if (!isinarray(self.pers[#"dynamic_loadout"].weapons[slot].attachments, attach)) {
            self.pers[#"dynamic_loadout"].weapons[slot].attachments[self.pers[#"dynamic_loadout"].weapons[slot].attachments.size] = attach;
        }
    }
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 2, eflags: 0x4
// Checksum 0x74a5ca01, Offset: 0x1e78
// Size: 0x1b4
function private function_4f498c77(takeoldweapon, givestreak = 1) {
    self loadout::init_player(1);
    weapons = self getweaponslist();
    foreach (weapon in weapons) {
        self takeweapon(weapon);
    }
    killstreaks::function_e1bfee95();
    self function_cf5e2018();
    self function_b226625e();
    self function_11d7d96b();
    if (givestreak) {
        self function_2c7c6fb3();
    }
    self function_8f21e77e();
    current_weapon = self getcurrentweapon();
    self thread loadout::initweaponattachments(current_weapon);
    self thread pickup_health::function_533c23df();
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 0, eflags: 0x4
// Checksum 0x9460abf8, Offset: 0x2038
// Size: 0xec
function private function_8f21e77e() {
    if (isdefined(self.pers[#"dynamic_loadout"].armor)) {
        self function_748988bc(#"hash_6be738527a4213aa");
        armor = self.pers[#"dynamic_loadout"].armor;
        self function_9fc2aa60(armor);
        self armor::set_armor(armor.armor, armor.armor, armor.var_5f12f8b3, armor.var_29e8f85, armor.var_7fc0af46, armor.var_45bb2886, 0);
    }
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 1, eflags: 0x4
// Checksum 0x99224496, Offset: 0x2130
// Size: 0x4a
function private function_366bfe0c(var_ba51f517) {
    switch (var_ba51f517.name) {
    case #"hash_16cfc7f70dbd8712":
        return #"specialty_armor_tier_two";
    case #"hash_39045b0020cc3e00":
        return #"specialty_armor_tier_three";
    default:
        return #"specialty_armor";
    }
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 1, eflags: 0x4
// Checksum 0xda498974, Offset: 0x21c0
// Size: 0xca
function private function_b75bdd57(var_ba51f517) {
    switch (var_ba51f517.name) {
    case #"hash_16cfc7f70dbd8712":
        playfxontag(#"hash_56c8182de62c1c6", self, "j_spineupper");
    case #"hash_39045b0020cc3e00":
        playfxontag(#"hash_3c6a01bd4394d4f3", self, "j_spineupper");
    default:
        playfxontag(#"hash_4a955131370a3720", self, "j_spineupper");
        break;
    }
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 1, eflags: 0x4
// Checksum 0xa20c783, Offset: 0x2298
// Size: 0x44
function private function_9fc2aa60(var_ba51f517) {
    armor_perk = function_366bfe0c(var_ba51f517);
    self setperk(armor_perk);
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 1, eflags: 0x4
// Checksum 0x1ab69105, Offset: 0x22e8
// Size: 0x44
function private function_42e16b65(var_ba51f517) {
    armor_perk = function_366bfe0c(var_ba51f517);
    self unsetperk(armor_perk);
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 0, eflags: 0x4
// Checksum 0xfb279e80, Offset: 0x2338
// Size: 0x40c
function private function_cf5e2018() {
    var_a12db6f5 = self.pers[#"dynamic_loadout"].weapons[0];
    if (isdefined(var_a12db6f5)) {
        primary = getweapon(var_a12db6f5.name, var_a12db6f5.attachments);
        self giveweapon(primary);
        self function_69914008(primary, var_a12db6f5);
        self switchtoweapon(primary, 1);
        self loadout::function_51315abd("primary", primary);
        self setspawnweapon(primary);
    } else {
        nullprimary = function_f8bc3773();
        self giveweapon(nullprimary);
        self setweaponammoclip(nullprimary, 0);
        self loadout::function_51315abd("primary", nullprimary);
    }
    var_b48dec9 = self.pers[#"dynamic_loadout"].weapons[1];
    if (isdefined(var_b48dec9)) {
        secondary = getweapon(var_b48dec9.name, var_b48dec9.attachments);
        self giveweapon(secondary);
        self function_69914008(secondary, var_b48dec9);
        self loadout::function_51315abd("secondary", secondary);
        if (!isdefined(var_a12db6f5)) {
            self switchtoweapon(secondary, 1);
            self setspawnweapon(secondary);
        }
    } else {
        nullsecondary = getweapon(#"none");
        self giveweapon(nullsecondary);
        self setweaponammoclip(nullsecondary, 0);
        self loadout::function_51315abd("secondary", nullsecondary);
    }
    var_aa9f7a93 = self.pers[#"dynamic_loadout"].weapons[2];
    if (isdefined(var_aa9f7a93)) {
        equipment = getweapon(var_aa9f7a93.name);
        self giveweapon(equipment);
        self setweaponammoclip(equipment, var_aa9f7a93.ammo);
        slot = self gadgetgetslot(equipment);
        self gadgetpowerset(slot, equipment.gadget_powermax);
        return;
    }
    var_9f028736 = getweapon(#"null_offhand_primary");
    self giveweapon(var_9f028736);
    self loadout::function_51315abd("primarygrenade", var_9f028736);
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 0, eflags: 0x4
// Checksum 0xf78a3afe, Offset: 0x2750
// Size: 0xea
function private function_f8bc3773() {
    var_f807e6d9 = self.pers[#"dynamic_loadout"].talents;
    foreach (item in var_f807e6d9) {
        if (item == #"hash_7932008294f0d876") {
            return getweapon(#"hash_7932008294f0d876");
        }
    }
    return getweapon(#"hash_1773b576c62a506");
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 2, eflags: 0x4
// Checksum 0x94c67cea, Offset: 0x2848
// Size: 0x104
function private function_69914008(weap, data) {
    if (data.ammo > 0) {
        self setweaponammostock(weap, int(data.ammo * weap.clipsize) - weap.clipsize);
    } else {
        self setweaponammostock(weap, int(data.startammo * weap.clipsize) - weap.clipsize);
    }
    if (self getweaponammoclip(weap) <= 0) {
        self setweaponammostock(weap, weap.clipsize);
    }
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 0, eflags: 0x4
// Checksum 0x898711f8, Offset: 0x2958
// Size: 0xa4
function private function_11d7d96b() {
    healthgadget = getweapon(#"pickup_health_regen");
    if (isdefined(self.var_890e0a27) && self.var_890e0a27) {
        healthgadget = getweapon(#"gadget_medicalinjectiongun");
    }
    self giveweapon(healthgadget);
    self loadout::function_51315abd("specialgrenade", healthgadget);
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 0, eflags: 0x4
// Checksum 0xdec08846, Offset: 0x2a08
// Size: 0x1a0
function private function_b226625e() {
    self function_edf4fd1d();
    self clearperks();
    foreach (talent in self.pers[#"dynamic_loadout"].talents) {
        if (talent == #"hash_7932008294f0d876") {
            continue;
        }
        self function_748988bc(talent + level.game_mode_suffix);
        if (talent == #"gear_medicalinjectiongun") {
            self.var_890e0a27 = 1;
        }
    }
    perks = self getloadoutperks(0);
    foreach (perk in perks) {
        self setperk(perk);
    }
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 0, eflags: 0x4
// Checksum 0xf2ef5434, Offset: 0x2bb0
// Size: 0x5c
function private function_2c7c6fb3() {
    if (isdefined(self.pers[#"dynamic_loadout"].scorestreak)) {
        self killstreaks::give(self.pers[#"dynamic_loadout"].scorestreak);
    }
}

// Namespace dynamic_loadout/dynamic_loadout
// Params 0, eflags: 0x0
// Checksum 0x8f30d7ce, Offset: 0x2c18
// Size: 0x9c
function function_a5286e6a() {
    scorestreak = self.pers[#"dynamic_loadout"].scorestreak;
    if (isdefined(scorestreak) && !self killstreaks::has_killstreak(scorestreak)) {
        self.pers[#"dynamic_loadout"].scorestreak = undefined;
        self function_49b19715(10, "luielement.BountyHunterLoadout.scorestreak", 0);
    }
}

