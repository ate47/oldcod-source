#using script_101d8280497ff416;
#using script_3d35e2ff167b3a82;
#using script_680dddbda86931fa;
#using script_6971dbf38c33bf47;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\activecamo_shared_util;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace item_world;

// Namespace item_world/item_world
// Params 0, eflags: 0x6
// Checksum 0x1c233361, Offset: 0x3d8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"item_world", &preinit, undefined, undefined, undefined);
}

// Namespace item_world/item_world
// Params 0, eflags: 0x4
// Checksum 0xd5de62ae, Offset: 0x420
// Size: 0x10f4
function private preinit() {
    if (!item_world_util::use_item_spawns()) {
        return;
    }
    function_2777823f();
    level.showpickuphintmodel = [];
    level.var_89f832ca = [];
    level.var_62c91473 = [];
    level.var_ce95aace = [];
    level.var_7e2f5883 = [];
    level.var_19cf0be9 = [];
    level.var_d42ffee1 = [];
    level.var_418d51ad = array(#"ammo_small_caliber_item_t9", #"ammo_large_caliber_item_t9", #"ammo_ar_item_t9", #"ammo_sniper_item_t9", #"ammo_shotgun_item_t9", #"ammo_special_item_t9");
    level.var_69ee9282 = array(#"armor_item_large", #"armor_item_medium", #"armor_item_small", #"hash_2661e6734ef7668", #"armor_item_medium_t9", #"hash_101c48eb461af954", #"armor_item_lv3_t9_sr", #"armor_item_lv2_t9_sr", #"armor_item_lv1_t9_sr");
    level.var_6cb314b1 = array(#"sniperscope_wz_item", #"acog_plus_wz_item", #"reddot_wz_item", #"acog_wz_item", #"dualoptic_wz_item", #"holo_wz_item", #"reflex_wz_item", #"tritium_wz_item", #"suppressor_wz_item", #"extbarrel_wz_item", #"advmag_wz_item", #"extmag_wz_item", #"fastmag_wz_item", #"foregrip_wz_item", #"laser_sight_wz_item", #"pistol_grip_wz_item", #"stock_wz_item", #"hash_74efc2f0523a1b43", #"acog_t9_item_sr", #"hash_28efceaacc63752f", #"reflex_t9_item_sr", #"hash_af064392d860f1f", #"scope4x_t9_item_sr", #"hash_62fe2eebac0f72a4", #"hash_52158dff02a348c", #"hash_2cdf0a02b981e7ea", #"hash_628946b7b73932f2", #"hash_4675294c5c3e11d4", #"hash_3ff4acf337c05bc", #"hash_347f02dfc677355a", #"hash_19f62bc8c271d062", #"hash_57d51fc4b72dcd7b", #"hash_6d40b7ae79307bad", #"hash_7212c9ac06e56bab", #"hash_2107d3747677659d", #"hash_2551991b0ce4278e", #"extclip_t9_item_sr", #"hash_43a7c00ebad019fc", #"extclip2_t9_item_sr", #"hash_8337602f5a165af", #"mixclip_t9_item_sr", #"hash_7ec532c309e0eef7", #"mixclip2_t9_item_sr", #"hash_780b6e02fd11b515", #"hash_1e87409dae378d95", #"grip_t9_item_sr", #"grip2_t9_item_sr", #"hash_72c4fa7a2b91b0b3", #"handle_t9_item_sr", #"hash_5e8e59ff7a020c33", #"handle2_t9_item_sr", #"hash_2b8002d0d1dd882a", #"quickdraw_t9_item_sr", #"hash_776efcf8d78c80", #"quickdraw2_t9_item_sr", #"hash_12aaf0a984a5418b", #"stalker_t9_item_sr", #"hash_767e2b6d5150883b", #"stalker2_t9_item_sr", #"hash_6cd8671e4bd51c28", #"hash_57d83338a5296980", #"hash_59f84dd254fda616", #"hash_66b9864ca183b4ae");
    level.var_3fd5d8f0 = array(#"frag_grenade_wz_item", #"frag_t9_item", #"frag_t9_item_sr", #"cluster_semtex_wz_item", #"semtex_t9_item", #"semtex_t9_item_sr", #"acid_bomb_wz_item", #"molotov_wz_item", #"molotov_t9_item", #"molotov_t9_item_sr", #"wraithfire_wz_item", #"hatchet_wz_item", #"hatchet_t9_item", #"hatchet_t9_item_sr", #"tomahawk_t8_wz_item", #"seeker_mine_wz_item", #"dart_wz_item", #"hawk_wz_item", #"ultimate_turret_wz_item", #"hash_49bb95f2912e68ad", #"hash_3c9430c4ac7d082e", #"hash_6a5294b915f32d32", #"hash_6cd8041bb6cd21b1", #"hash_6a07ccefe7f84985", #"hash_17f8849a56eba20f", #"satchel_charge_t9_item", #"satchel_charge_t9_item_sr", #"hash_2c9b75b17410f2de", #"swat_grenade_wz_item", #"hash_676aa70930960427", #"concussion_wz_item", #"concussion_t9_item", #"smoke_grenade_wz_item", #"smoke_grenade_wz_item_spring_holiday", #"smoke_t9_item", #"emp_grenade_wz_item", #"spectre_grenade_wz_item", #"hash_5f67f7b32b01ae53", #"hash_725e305ff465e73d", #"concussion_t9_item_sr", #"cymbal_monkey_t9_item_sr", #"hash_76ebb51bb24696a1", #"hash_51f70aff8a2ad330", #"stimshot_t9_item_sr", #"grapple_wz_item", #"hash_12fde8b0da04d262", #"barricade_wz_item", #"spiked_barrier_wz_item", #"trophy_system_wz_item", #"concertina_wire_wz_item", #"sensor_dart_wz_item", #"supply_pod_wz_item", #"trip_wire_wz_item", #"cymbal_monkey_wz_item", #"homunculus_wz_item", #"vision_pulse_wz_item", #"flare_gun_wz_item", #"wz_snowball", #"wz_waterballoon", #"hash_1ae9ade20084359f");
    level.var_9bc8c1bc = array(#"health_item_small", #"health_item_medium", #"health_item_large", #"health_item_squad", #"hash_20699a922abaf2e1");
    level.var_683c7e30 = array(#"perk_item_stimulant", #"perk_item_awareness", #"perk_item_deadsilence", #"perk_item_lightweight", #"perk_item_drifter", #"perk_item_engineer", #"perk_item_medic", #"perk_item_reinforced", #"perk_item_looter", #"perk_item_outlander", #"perk_item_paranoia", #"perk_item_ironlungs", #"perk_item_squadlink", #"perk_item_consumer", #"perk_item_brawler");
    level.var_e93e16b = array(#"annihilator_wz_item", #"warmachine_wz_item", #"flamethrower_wz_item", #"sniper_fastrechamber_t8_gold_item", #"sniper_powerbolt_t8_gold_item", #"sniper_powersemi_t8_gold_item", #"sniper_quickscope_t8_gold_item", #"tr_longburst_t8_gold_item", #"tr_midburst_t8_gold_item", #"tr_powersemi_t8_gold_item", #"ar_accurate_t8_gold_item", #"ar_damage_t8_gold_item", #"ar_fastfire_t8_gold_item", #"ar_modular_t8_gold_item", #"ar_stealth_t8_gold_item", #"lmg_heavy_t8_gold_item", #"lmg_spray_t8_gold_item", #"lmg_standard_t8_gold_item", #"smg_accurate_t8_gold_item", #"smg_capacity_t8_gold_item", #"smg_fastfire_t8_gold_item", #"smg_handling_t8_gold_item", #"smg_standard_t8_gold_item", #"shotgun_semiauto_t8_gold_item", #"shotgun_pump_t8_gold_item", #"pistol_burst_t8_gold_item", #"pistol_revolver_t8_gold_item", #"pistol_standard_t8_gold_item");
    level.var_b9917a92 = array(#"annihilator_wz_item", #"warmachine_wz_item", #"flamethrower_wz_item", #"ray_gun_t8_item", #"launcher_standard_t8_item", #"sniper_fastrechamber_t8_item", #"sniper_powerbolt_t8_item", #"sniper_powersemi_t8_item", #"sniper_quickscope_t8_item", #"tr_leveraction_t8_item", #"tr_longburst_t8_item", #"tr_midburst_t8_item", #"tr_powersemi_t8_item", #"ar_accurate_t8_item", #"ar_damage_t8_item", #"ar_fastfire_t8_item", #"ar_galil_t8_item", #"ar_mg1909_t8_item", #"ar_modular_t8_item", #"ar_stealth_t8_item", #"lmg_double_t8_item", #"lmg_heavy_t8_item", #"lmg_spray_t8_item", #"lmg_standard_t8_item", #"smg_accurate_t8_item", #"smg_capacity_t8_item", #"smg_drum_pistol_t8_item", #"smg_fastfire_t8_item", #"smg_handling_t8_item", #"smg_mp40_t8_item", #"smg_standard_t8_item", #"smg_thompson_t8_item", #"pistol_burst_t8_item", #"pistol_revolver_t8_item", #"pistol_standard_t8_item", #"pistol_topbreak_t8_item", #"shotgun_pump_t8_item", #"shotgun_semiauto_t8_item", #"shotgun_trenchgun_t8_item", #"melee_bowie_t8_item");
    level.var_be4583aa = spawnstruct();
    level.var_be4583aa.var_2e3efdda = &function_2e3efdda;
    level.var_be4583aa.var_9b71de90 = &function_9b71de90;
    level.var_d89ef54a = getgametypesetting(#"hash_2f0beae14bf17810");
    level.weaponbasemeleeheld = getweapon(#"bare_hands");
    callback::on_localclient_connect(&_on_localclient_connect);
    callback::on_localplayer_spawned(&_on_localplayer_spawned);
    level.var_45ca79e5 = &function_9160538;
    level.var_a6c75fcb = &function_9e4552fe;
    level.var_d342a3fd = [];
    if (!isdefined(level.item_spawn_stashes)) {
        level.item_spawn_stashes = [];
    }
    if (!isdefined(level.item_spawn_drops)) {
        level.item_spawn_drops = [];
    }
    if (!isdefined(level.var_624588d5)) {
        level.var_624588d5 = [];
    }
    level thread namespace_65181344::init_spawn_system();
}

// Namespace item_world/item_world
// Params 0, eflags: 0x4
// Checksum 0xa6125ba, Offset: 0x1520
// Size: 0x1fc
function private function_2777823f() {
    clientfield::register("world", "item_world_seed", 1, 31, "int", &function_4e9220ab, 1, 0);
    clientfield::register("world", "item_world_sanity_random", 1, 16, "int", &function_7e3cc2ff, 1, 0);
    clientfield::register("world", "item_world_disable", 1, 1, "int", &function_60386766, 0, 0);
    clientfield::register_clientuimodel("hudItems.pickupHintGold", #"hud_items", #"pickuphintgold", 1, 1, "int", undefined, 0, 0);
    clientfield::register("scriptmover", "item_world_attachments", 1, 1, "int", undefined, 0, 0);
    clientfield::register("toplayer", "disableItemPickup", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.multiItemPickup.status", #"hash_23febb0b8f867ca1", #"status", 1, 3, "int", &function_38ebb2a1, 0, 1);
}

// Namespace item_world/item_world
// Params 7, eflags: 0x4
// Checksum 0xcd37ac30, Offset: 0x1728
// Size: 0x2f8
function private function_38ebb2a1(localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    clientdata = function_a7e98a1a(binitialsnap);
    if (bwastimejump == 2) {
        clientdata.var_ff9e7e43 = 1;
        if (function_a5c2a6b8(binitialsnap)) {
            clientdata.groupitems = [];
            if (is_true(level.tabbedmultiitempickup)) {
                setuimodelvalue(createuimodel(function_1df4c3b0(binitialsnap, #"hash_159966ba825013a2"), "canUseQuickInventory"), 0);
            }
        }
        return;
    }
    if (bwastimejump == 0) {
        clientdata.groupitems = [];
        player = function_27673a7(binitialsnap);
        if (isplayer(player) && isalive(player)) {
            player function_9116bb0e(binitialsnap, 1);
        }
    }
    if (is_true(level.tabbedmultiitempickup) && fieldname == 2) {
        for (i = 0; i < clientdata.inventory.var_c212de25; i++) {
            if (clientdata.inventory.items[i].networkid != 32767) {
                if (clientdata.inventory.items[i].availableaction == 1 || clientdata.inventory.items[i].availableaction == 4 || clientdata.inventory.items[i].availableaction == 2 || clientdata.inventory.items[i].availableaction == 6) {
                    setuimodelvalue(createuimodel(function_1df4c3b0(binitialsnap, #"hash_159966ba825013a2"), "canUseQuickInventory"), 1);
                    break;
                }
            }
        }
    }
}

// Namespace item_world/item_world
// Params 2, eflags: 0x0
// Checksum 0x246758bb, Offset: 0x1a28
// Size: 0xe34
function function_9116bb0e(localclientnum, closed = 0) {
    assert(isplayer(self));
    clientdata = function_a7e98a1a(localclientnum);
    var_6e2c91d0 = function_1df4c3b0(localclientnum, #"hash_23febb0b8f867ca1");
    var_cc67e8b = createuimodel(var_6e2c91d0, "count");
    if (isdefined(clientdata.groupitems) && !closed) {
        arrayremovevalue(clientdata.groupitems, undefined, 0);
        foreach (i, itemdef in clientdata.groupitems) {
            itemmodel = createuimodel(var_6e2c91d0, "item" + i);
            setuimodelvalue(createuimodel(itemmodel, "id"), itemdef.networkid);
            if (!isdefined(itemdef.itementry)) {
                setuimodelvalue(createuimodel(itemmodel, "inventoryFull"), 0);
                setuimodelvalue(createuimodel(itemmodel, "icon"), #"blacktransparent");
                setuimodelvalue(createuimodel(itemmodel, "rarity"), "none");
                setuimodelvalue(createuimodel(itemmodel, "name"), #"");
                setuimodelvalue(createuimodel(itemmodel, "claimsInventorySlot"), 0);
                setuimodelvalue(createuimodel(itemmodel, "stackCount"), 0);
                setuimodelvalue(createuimodel(itemmodel, "stashStackSize"), 0);
                setuimodelvalue(createuimodel(itemmodel, "armorTier"), 1);
                setuimodelvalue(createuimodel(itemmodel, "armor"), 0);
                setuimodelvalue(createuimodel(itemmodel, "armorMax"), 1);
                setuimodelvalue(createuimodel(itemmodel, "itemtype"), "none");
                setuimodelvalue(createuimodel(itemmodel, "specialItem"), 0);
                setuimodelvalue(createuimodel(itemmodel, "description"), #"");
                continue;
            }
            setuimodelvalue(createuimodel(itemmodel, "itemtype"), itemdef.itementry.itemtype);
            if (itemdef.itementry.itemtype === #"ammo") {
                canpickup = self function_c199bcc6(localclientnum, itemdef);
                setuimodelvalue(createuimodel(itemmodel, "inventoryFull"), !canpickup);
            } else if (itemdef.itementry.itemtype === #"armor_shard") {
                canpickup = self function_87e71bc0(localclientnum, itemdef.itementry);
                setuimodelvalue(createuimodel(itemmodel, "inventoryFull"), !canpickup);
            } else {
                setuimodelvalue(createuimodel(itemmodel, "inventoryFull"), 0);
            }
            description = isdefined(itemdef.itementry.description) ? itemdef.itementry.description : #"";
            if (description == #"" && isdefined(itemdef.itementry.weapon)) {
                itemindex = getitemindexfromref(itemdef.itementry.weapon.name);
                var_97dcd0a5 = getunlockableiteminfofromindex(itemindex);
                if (isdefined(var_97dcd0a5) && isdefined(var_97dcd0a5.description)) {
                    description = var_97dcd0a5.description;
                }
            }
            setuimodelvalue(createuimodel(itemmodel, "description"), isdefined(description) ? description : #"");
            pickupicon = isdefined(itemdef.itementry.pickupicon) ? itemdef.itementry.pickupicon : itemdef.itementry.icon;
            stashicon = isdefined(itemdef.itementry.stashicon) ? itemdef.itementry.stashicon : pickupicon;
            setuimodelvalue(createuimodel(itemmodel, "icon"), isdefined(stashicon) ? stashicon : #"blacktransparent");
            setuimodelvalue(createuimodel(itemmodel, "rarity"), itemdef.itementry.rarity);
            setuimodelvalue(createuimodel(itemmodel, "name"), get_item_name(itemdef.itementry));
            claimsinventoryslot = item_inventory::is_inventory_item(localclientnum, itemdef.itementry) && !item_inventory::function_a303c8ef(localclientnum, itemdef.itementry);
            setuimodelvalue(createuimodel(itemmodel, "claimsInventorySlot"), claimsinventoryslot);
            setuimodelvalue(createuimodel(itemmodel, "stackCount"), 0);
            setuimodelvalue(createuimodel(itemmodel, "stashStackSize"), 0);
            if (itemdef.itementry.itemtype === #"armor") {
                setuimodelvalue(createuimodel(itemmodel, "armorTier"), itemdef.itementry.armortier);
                setuimodelvalue(createuimodel(itemmodel, "armor"), isdefined(isdefined(itemdef.amount) ? itemdef.amount : itemdef.itementry.amount) ? isdefined(itemdef.amount) ? itemdef.amount : itemdef.itementry.amount : 0);
                setuimodelvalue(createuimodel(itemmodel, "armorMax"), isdefined(itemdef.itementry.amount) ? itemdef.itementry.amount : 1);
            } else {
                setuimodelvalue(createuimodel(itemmodel, "armorTier"), 1);
                setuimodelvalue(createuimodel(itemmodel, "armor"), 0);
                setuimodelvalue(createuimodel(itemmodel, "armorMax"), 1);
            }
            if (is_true(itemdef.itementry.stackable) || itemdef.itementry.itemtype === #"ammo") {
                if ((itemdef.itementry.itemtype === #"ammo" || isstruct(itemdef)) && !isdefined(itemdef.amount)) {
                    setuimodelvalue(createuimodel(itemmodel, "stackCount"), isdefined(itemdef.itementry.amount) ? itemdef.itementry.amount : 1);
                } else {
                    setuimodelvalue(createuimodel(itemmodel, "stackCount"), int(max(isdefined(itemdef.amount) ? itemdef.amount : 1, isdefined(itemdef.count) ? itemdef.count : 1)));
                }
            } else {
                setuimodelvalue(createuimodel(itemmodel, "stashStackSize"), isdefined(itemdef.count) ? itemdef.count : 1);
            }
            if (is_true(itemdef.var_41f13734)) {
                setuimodelvalue(createuimodel(itemmodel, "specialItem"), 1);
            }
        }
        currentcount = getuimodelvalue(var_cc67e8b);
        setuimodelvalue(var_cc67e8b, clientdata.groupitems.size);
        if (currentcount === clientdata.groupitems.size) {
        }
        var_aaa1adcb = createuimodel(var_6e2c91d0, "forceNotifyAmmoList");
        forcenotifyuimodel(var_aaa1adcb);
        return;
    }
    setuimodelvalue(var_cc67e8b, 0);
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0x583d2c67, Offset: 0x2868
// Size: 0x3e
function function_a5c2a6b8(localclientnum) {
    return is_true(level.tabbedmultiitempickup) || !gamepadusedlast(localclientnum);
}

// Namespace item_world/item_world
// Params 2, eflags: 0x4
// Checksum 0x2d3168b5, Offset: 0x28b0
// Size: 0xf0
function private function_3d7c12a6(localclientnum, poolsize) {
    modellist = [];
    for (i = 1; i <= poolsize; i++) {
        model = spawn(localclientnum, (0, 0, -10000), "script_model");
        model function_e082e650(localclientnum, undefined, #"tag_origin", 1);
        model hide();
        model notsolid();
        modellist[i * -1] = model;
    }
    return modellist;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0xb9813ee2, Offset: 0x29a8
// Size: 0x104
function private function_37175e73(var_fee74908) {
    level endon(#"game_ended");
    if (var_fee74908.size <= 0) {
        return;
    }
    level flag::wait_till_clear(#"hash_2d3b2a4d082ba5ee");
    level flag::wait_till(#"item_world_initialized");
    for (wordindex = 0; wordindex < var_fee74908.size; wordindex++) {
        for (bitindex = 0; bitindex < 32; bitindex++) {
            if (var_fee74908[wordindex] & 1 << bitindex) {
                itemindex = wordindex * 32 + bitindex;
                hide_item(-1, itemindex);
            }
        }
    }
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0x82b205ae, Offset: 0x2ab8
// Size: 0x2bc
function private function_952d97dc(localclientnum) {
    data = spawnstruct();
    data.modellist = function_3d7c12a6(localclientnum, 125);
    data.var_d58b471d = 0;
    data.var_79b15dd1 = 0;
    data.var_ffc1c0e1 = [];
    data.var_baf65690 = [];
    level.var_d342a3fd[localclientnum] = data;
    if (!item_inventory::function_7d5553ac()) {
        item_inventory::inventory_init(localclientnum);
    }
    level.var_d9beffb9 = util::getnextobjid(localclientnum);
    objective_add(localclientnum, level.var_d9beffb9, "invisible", #"weapon_pickup");
    level.var_383edf80 = util::getnextobjid(localclientnum);
    objective_add(localclientnum, level.var_383edf80, "invisible", #"multi_item_pickup");
    huditemsmodel = function_1df4c3b0(localclientnum, #"hud_items");
    level.showpickuphintmodel[localclientnum] = createuimodel(huditemsmodel, "showPickupHint");
    level.var_89f832ca[localclientnum] = createuimodel(huditemsmodel, "pickupHintText");
    level.var_62c91473[localclientnum] = createuimodel(huditemsmodel, "pickupHintTextOverride");
    level.var_ce95aace[localclientnum] = createuimodel(huditemsmodel, "weapon3dHintState");
    level.var_7e2f5883[localclientnum] = createuimodel(huditemsmodel, "weapon3dForcedHintItem");
    level.var_19cf0be9[localclientnum] = createuimodel(huditemsmodel, "pickupHintImage");
    level.var_d42ffee1[localclientnum] = createuimodel(huditemsmodel, "cursorHintIcon");
    callback::callback(#"clientdata_init", localclientnum);
}

/#

    // Namespace item_world/item_world
    // Params 0, eflags: 0x4
    // Checksum 0x6f007494, Offset: 0x2d80
    // Size: 0x1b4
    function private function_cdd9b388() {
        self notify("<dev string:x38>");
        self endon("<dev string:x38>");
        self endon(#"shutdown");
        while (true) {
            waitframe(1);
            if (getdvarint(#"hash_3fdd3b60f349d462", 0)) {
                if (isdefined(self)) {
                    origin = self.origin;
                    var_f4b807cb = function_2e3efdda(origin, undefined, 128, 2000);
                    foreach (item in var_f4b807cb) {
                        hidden = item.hidetime < 0 ? "<dev string:x53>" : "<dev string:x4c>";
                        print3d(item.origin, "<dev string:x57>" + item.networkid + hidden + "<dev string:x5d>" + item.itementry.name, (0, 0, 1), 1, 0.4);
                    }
                }
            }
        }
    }

#/

// Namespace item_world/item_world
// Params 2, eflags: 0x4
// Checksum 0xc38ecce6, Offset: 0x2f40
// Size: 0x6c
function private function_3ee12d25(localclientnum, model) {
    if (!isdefined(model)) {
        return;
    }
    if (isdefined(model.var_2584a90d)) {
        model function_f6e99a8d(model.var_2584a90d);
    }
    model.var_2584a90d = undefined;
    function_2990e5f(localclientnum, model);
}

// Namespace item_world/item_world
// Params 2, eflags: 0x0
// Checksum 0x38eed871, Offset: 0x2fb8
// Size: 0xc2
function function_2990e5f(localclientnum, model) {
    if (!isdefined(model)) {
        return;
    }
    if (isdefined(model.modelfx)) {
        foreach (fx in model.modelfx) {
            stopfx(localclientnum, fx);
        }
        model.modelfx = undefined;
    }
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0xa10c8793, Offset: 0x3088
// Size: 0x27a
function private function_48b8fc19(localclientnum) {
    var_7d8899cd = function_d634ed59();
    for (index = 0; index < var_7d8899cd; index++) {
        point = function_b1702735(index);
        if (!isdefined(point) || !isdefined(point.itementry)) {
            break;
        }
        xmodel = function_78a9fd5f(point);
        if (isdefined(xmodel)) {
            forcestreamxmodel(xmodel, 1, 1);
        }
        if ((index + 1) % 50 == 0) {
            waitframe(1);
        }
    }
    for (player = function_5c10bd79(localclientnum); !isdefined(player) || !isplayer(player) || !isdefined(player.type) || player.type != #"player" || player ishidden() || player isinfreefall() || player function_9a0edd92(); player = function_5c10bd79(localclientnum)) {
        waitframe(1);
    }
    wait 15;
    for (index = 0; index < var_7d8899cd; index++) {
        point = function_b1702735(index);
        if (!isdefined(point) || !isdefined(point.itementry)) {
            break;
        }
        xmodel = function_78a9fd5f(point);
        if (isdefined(xmodel)) {
            stopforcestreamingxmodel(xmodel);
        }
        if ((index + 1) % 50 == 0) {
            waitframe(1);
        }
    }
}

// Namespace item_world/item_world
// Params 3, eflags: 0x4
// Checksum 0xe15d2116, Offset: 0x3310
// Size: 0x142
function private function_c17fe536(localclientnum, clientdata, networkid) {
    model = function_839d4c20(localclientnum, clientdata, networkid);
    if (!isdefined(model) && isdefined(networkid) && item_world_util::function_2c7fc531(networkid)) {
        model = function_b1702735(networkid);
        if (!item_world_util::function_83c20f83(model)) {
            model = undefined;
        }
    }
    if (!isdefined(model)) {
        return;
    }
    var_1ba7b9c8 = arraysortclosest(level.item_spawn_stashes, model.origin, 1, 0, 12);
    if (var_1ba7b9c8.size > 0) {
        return var_1ba7b9c8[0];
    }
    var_6594679a = arraysortclosest(level.var_624588d5, model.origin, 1, 0, 12);
    if (var_6594679a.size > 0) {
        return var_6594679a[0];
    }
}

// Namespace item_world/item_world
// Params 3, eflags: 0x4
// Checksum 0x15814b94, Offset: 0x3460
// Size: 0x84
function private function_839d4c20(*localclientnum, clientdata, networkid) {
    if (!isdefined(networkid)) {
        return;
    }
    if (isdefined(clientdata.modellist[networkid])) {
        model = clientdata.modellist[networkid];
    } else if (isdefined(level.item_spawn_drops[networkid])) {
        model = level.item_spawn_drops[networkid];
    }
    return model;
}

// Namespace item_world/item_world
// Params 3, eflags: 0x4
// Checksum 0xa3cd0369, Offset: 0x34f0
// Size: 0x98
function private function_61f5d33a(localclientnum, clientdata, networkid) {
    model = function_839d4c20(localclientnum, clientdata, networkid);
    if (!isdefined(model) && item_world_util::function_2c7fc531(networkid)) {
        model = function_b1702735(networkid);
        if (!item_world_util::function_83c20f83(model)) {
            model = undefined;
        }
    }
    return model;
}

// Namespace item_world/item_world
// Params 4, eflags: 0x0
// Checksum 0x237deeab, Offset: 0x3590
// Size: 0x31a
function function_fcfd6064(localclientnum, itementry, clientdata, networkid) {
    renderbundle = #"hash_312ceb838675b80";
    if (isdefined(itementry)) {
        switch (itementry.rarity) {
        case #"none":
            if (isdefined(itementry.unlockableitemref) && itementry.itemtype != #"weapon") {
                renderbundle = #"hash_6f1ab68ac78ac2ea";
                break;
            }
        case #"resource":
            renderbundle = #"hash_312ceb838675b80";
            break;
        case #"uncommon":
            renderbundle = #"hash_70c807782a37573e";
            break;
        case #"rare":
            renderbundle = #"hash_5b08235c0b55a003";
            break;
        case #"epic":
            renderbundle = #"rob_sr_item_purple";
            break;
        case #"legendary":
            renderbundle = #"hash_64261dabb4df88cd";
            break;
        case #"ultra":
            renderbundle = #"rob_sr_item_gold";
            break;
        case #"loadout":
            renderbundle = #"hash_3088f081654a720e";
            break;
        }
        if (itementry.itemtype == #"resource") {
            renderbundle = #"hash_2f523d47697a9ce3";
        }
        if (is_true(itementry.var_47f145b4)) {
            renderbundle = #"hash_52f7937d76fafca0";
        }
        if (isdefined(itementry.var_599225da)) {
            renderbundle = itementry.var_599225da;
        }
    }
    if (isdefined(networkid) && isdefined(clientdata) && isdefined(clientdata.var_ffc1c0e1)) {
        if (isdefined(clientdata.var_ffc1c0e1[networkid]) && clientdata.var_ffc1c0e1[networkid].servertime > getservertime(localclientnum, 1)) {
            renderbundle = #"hash_3d6eb4b9bbc74fbd";
            if (isdefined(itementry)) {
                if (itementry.rarity == #"epic") {
                    renderbundle = #"hash_269ac932c6e6b81f";
                } else if (isdefined(itementry.unlockableitemref)) {
                    renderbundle = #"hash_12076df5fcd3d751";
                }
            }
        }
    }
    return renderbundle;
}

// Namespace item_world/item_world
// Params 5, eflags: 0x4
// Checksum 0xdf7e858e, Offset: 0x38b8
// Size: 0x1ac
function private function_78bf134c(localclientnum, clientdata, networkid, model, itementry) {
    if (!isdefined(model)) {
        return;
    }
    if (!isdefined(itementry)) {
        if (isdefined(model.var_bad13452)) {
            if (model.var_bad13452 == 2) {
                function_3ee12d25(localclientnum, model);
                return;
            }
        } else if (!isdefined(model.type)) {
            state = function_ffdbe8c2(model);
            if (state == 2) {
                function_3ee12d25(localclientnum, model);
                return;
            }
        }
    }
    renderbundle = function_fcfd6064(localclientnum, itementry, clientdata, networkid);
    if (isdefined(model.var_2584a90d) && model.var_2584a90d !== renderbundle) {
        model function_f6e99a8d(model.var_2584a90d);
    }
    if (isdefined(renderbundle)) {
        if (!model function_d2503806(renderbundle)) {
            model playrenderoverridebundle(renderbundle);
        }
    }
    model.var_2584a90d = renderbundle;
    if (isdefined(itementry)) {
        function_84964a9e(localclientnum, itementry, model, networkid);
    }
}

// Namespace item_world/item_world
// Params 4, eflags: 0x0
// Checksum 0xf39b0bbd, Offset: 0x3a70
// Size: 0x47c
function function_84964a9e(localclientnum, itementry, model, networkid) {
    if (isdefined(itementry) && isdefined(itementry.worldfx) && itementry.worldfx.size > 0 && !isdefined(model.modelfx) && !model ishidden()) {
        if (isdefined(networkid) && item_world_util::function_da09de95(networkid)) {
            entnum = item_world_util::function_c094ccd3(networkid);
            if (isdefined(entnum)) {
                var_95b3bee0 = getentbynum(localclientnum, entnum);
            }
        }
        if (!isdefined(var_95b3bee0) || isdefined(var_95b3bee0)) {
            model.modelfx = [];
            if (!isdefined(itementry.var_22d128f2) && !isdefined(itementry.var_22d128f2) && !isdefined(itementry.var_22d128f2)) {
                foreach (var_a6f47d78 in itementry.worldfx) {
                    model.modelfx[model.modelfx.size] = util::playfxontag(localclientnum, var_a6f47d78.worldfx, model, "tag_origin");
                }
                return;
            }
            originoffset = (isdefined(itementry.var_5dc4470b) ? itementry.var_5dc4470b : 0, isdefined(itementry.var_54a3b4ca) ? itementry.var_54a3b4ca : 0, isdefined(itementry.var_3e688854) ? itementry.var_3e688854 : 0);
            originoffset = rotatepoint(originoffset * -1, model.angles);
            originoffset += rotatepoint((isdefined(itementry.var_22d128f2) ? itementry.var_22d128f2 : 0, isdefined(itementry.var_48907470) ? itementry.var_48907470 : 0, isdefined(itementry.var_702943a1) ? itementry.var_702943a1 : 0), model.angles);
            angles = combineangles(model.angles, (isdefined(itementry.var_15b88fde) ? itementry.var_15b88fde : 0, isdefined(itementry.var_8c9a7dc8) ? itementry.var_8c9a7dc8 : 0, isdefined(itementry.var_7a51d937) ? itementry.var_7a51d937 : 0));
            forward = anglestoforward(angles);
            up = anglestoup(angles);
            foreach (var_a6f47d78 in itementry.worldfx) {
                model.modelfx[model.modelfx.size] = playfx(localclientnum, var_a6f47d78.worldfx, model.origin + originoffset, forward, up);
            }
        }
    }
}

// Namespace item_world/item_world
// Params 4, eflags: 0x4
// Checksum 0xbcf9502d, Offset: 0x3ef8
// Size: 0xb2
function private function_3bd99d2f(localclientnum, *clientdata, vehicle, clear = 0) {
    if (!isdefined(vehicle)) {
        return;
    }
    if (clear) {
        function_3ee12d25(clientdata, vehicle);
        return;
    }
    renderbundle = #"hash_3d6eb4b9bbc74fbd";
    if (!vehicle function_d2503806(renderbundle)) {
        vehicle playrenderoverridebundle(renderbundle);
    }
    vehicle.var_2584a90d = renderbundle;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0xd1eefc3, Offset: 0x3fb8
// Size: 0x92
function function_7731d23c(clientdata) {
    model = isdefined(self.networkid) ? clientdata.modellist[self.networkid] : self;
    if (isdefined(self.type) && self.type === #"missile") {
        model = self;
    }
    if (!isdefined(model) && isentity(self)) {
        model = self;
    }
    return model;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0x76a67dd9, Offset: 0x4058
// Size: 0x23e
function private function_e2c19e6b(localclientnum) {
    self endon(#"shutdown");
    clientdata = function_a7e98a1a(localclientnum);
    if (!isdefined(clientdata)) {
        return;
    }
    if (clientdata.var_d7bd75b5) {
        return;
    }
    clientdata.var_d7bd75b5 = 1;
    var_7c7fec2b = arraycopy(level.var_2b5a36e1);
    var_7b429234 = getarraykeys(var_7c7fec2b);
    servertime = getservertime(localclientnum);
    waitframe(1);
    var_f1ae160a = 0;
    for (index = 0; index < var_7b429234.size; index++) {
        var_f1ae160a++;
        var_b7d66c97 = var_7c7fec2b[var_7b429234[index]];
        if (!isdefined(var_b7d66c97) || !isdefined(var_b7d66c97.hidetime)) {
            continue;
        }
        if (var_b7d66c97.hidetime > 0 && var_b7d66c97.hidetime < servertime) {
            continue;
        }
        model = clientdata.modellist[var_b7d66c97.networkid];
        if (!isdefined(model)) {
            continue;
        }
        timeoutlength = servertime - var_b7d66c97.var_f4522f8c;
        shouldhide = int(floor(timeoutlength / 400)) % 2 == 0;
        if (shouldhide) {
            model show();
        } else {
            model hide();
        }
        if (var_f1ae160a % 50 == 0) {
            waitframe(1);
        }
    }
    clientdata.var_d7bd75b5 = 0;
}

// Namespace item_world/item_world
// Params 2, eflags: 0x4
// Checksum 0x636c4f88, Offset: 0x42a0
// Size: 0xf0e
function private _draw(localclientnum, draworigin) {
    self endon(#"shutdown");
    clientdata = function_a7e98a1a(localclientnum);
    if (!isdefined(clientdata)) {
        return;
    }
    var_5f6ea063 = is_true(self.var_5f6ea063);
    self.var_5f6ea063 = undefined;
    self.var_506495f9 = undefined;
    servertime = getservertime(localclientnum, 0);
    clientdata.var_79b15dd1 = servertime;
    clientdata.drawing = 1;
    var_6369afab = function_963d3f6e();
    if (self isinfreefall() || self function_9a0edd92()) {
        var_6369afab = 4050;
    }
    maxdist = getdvarfloat(#"hash_2cd1a08f81049564", var_6369afab);
    var_f4b807cb = function_abaeb170(draworigin, undefined, 125, maxdist, -1, 1, servertime);
    var_6665e24 = arraysortclosest(level.item_spawn_drops, draworigin, 125, 0, maxdist);
    var_13e4be37 = [];
    foreach (dynamicitem in var_6665e24) {
        if (isdefined(dynamicitem) && !item_world_util::function_83c20f83(dynamicitem)) {
            var_13e4be37[var_13e4be37.size] = dynamicitem;
        }
    }
    if (var_13e4be37.size > 0) {
        var_f4b807cb = arraycombine(var_f4b807cb, var_13e4be37, 1, 0);
        var_f4b807cb = arraysortclosest(var_f4b807cb, draworigin, 125, 0, maxdist);
    }
    waitframe(1);
    clientdata.var_89e328b4 = clientdata.modellist;
    clientdata.modellist = [];
    var_c29769e0 = [];
    index = 0;
    assert(clientdata.var_89e328b4.size == 125);
    for (index = 0; index < var_f4b807cb.size; index++) {
        item = var_f4b807cb[index];
        if (!isdefined(item)) {
            continue;
        }
        id = item.networkid;
        if (isdefined(clientdata.var_89e328b4[id])) {
            model = clientdata.var_89e328b4[id];
            clientdata.modellist[id] = model;
            clientdata.var_89e328b4[id] = undefined;
        } else {
            var_c29769e0[var_c29769e0.size] = item;
        }
        if ((index + 1) % 50 == 0) {
            waitframe(1);
        }
    }
    waitframe(1);
    arrayremovevalue(clientdata.var_89e328b4, undefined, 0);
    waitframe(1);
    assert(clientdata.var_89e328b4.size + clientdata.modellist.size == 125);
    assert(clientdata.var_89e328b4.size >= var_c29769e0.size);
    for (index = 0; index < var_c29769e0.size && index < clientdata.var_89e328b4.size; index++) {
        item = var_c29769e0[index];
        model = clientdata.var_89e328b4[index];
        model unlink();
        if (!isdefined(item)) {
            model hide();
            function_2990e5f(localclientnum, model);
            function_3ee12d25(localclientnum, model);
            clientdata.modellist[index * -1 - 1] = model;
        } else {
            model.origin = item.origin;
            model.angles = item.angles;
            model function_e082e650(localclientnum, item, function_78a9fd5f(item), item.itementry.modelscale);
            model.id = item.id;
            shouldshow = item_world_util::function_da09de95(item.networkid) && item_world_util::can_pick_up(item, servertime);
            shouldshow |= item.networkid < function_8322cf16() && item_world_util::can_pick_up(function_b1702735(item.networkid), servertime);
            shouldshow &= !(isdefined(item.type) && item.type === #"missile");
            if (shouldshow) {
                model show();
            } else {
                model hide();
                function_2990e5f(localclientnum, model);
            }
            originoffset = (isdefined(item.itementry.var_5dc4470b) ? item.itementry.var_5dc4470b : 0, isdefined(item.itementry.var_54a3b4ca) ? item.itementry.var_54a3b4ca : 0, isdefined(item.itementry.var_3e688854) ? item.itementry.var_3e688854 : 0);
            model.origin += rotatepoint(originoffset, model.angles);
            if (item_world_util::function_da09de95(item.networkid)) {
                model linkto(item);
            }
            clientdata.modellist[item.networkid] = model;
        }
        if ((index + 1) % 50 == 0) {
            waitframe(1);
        }
    }
    waitframe(1);
    assert(clientdata.var_89e328b4.size - index + clientdata.modellist.size == 125);
    while (index < clientdata.var_89e328b4.size) {
        model = clientdata.var_89e328b4[index];
        if (isdefined(model)) {
            model hide();
            function_2990e5f(localclientnum, model);
            function_3ee12d25(localclientnum, model);
            clientdata.modellist[index * -1 - 1] = model;
        }
        if ((index + 1) % 50 == 0) {
            waitframe(1);
        }
        index++;
    }
    clientdata.var_89e328b4 = undefined;
    waitframe(1);
    assert(clientdata.modellist.size == 125);
    function_b032ccd(localclientnum, clientdata.modellist);
    if (getdvarint(#"hash_220f360a2cc8359a", 1)) {
        var_b8db3f93 = arraysortclosest(level.item_spawn_drops, draworigin, undefined, maxdist);
        foreach (item in var_b8db3f93) {
            function_3ee12d25(localclientnum, item);
        }
        waitframe(1);
        var_f945c1d4 = arraysortclosest(level.item_spawn_stashes, draworigin, undefined, maxdist);
        foreach (supplystash in var_f945c1d4) {
            function_3ee12d25(localclientnum, supplystash);
        }
        waitframe(1);
        var_8f6dbb2 = arraysortclosest(level.var_624588d5, draworigin, undefined, maxdist);
        foreach (deathstash in var_8f6dbb2) {
            function_3ee12d25(localclientnum, deathstash);
        }
        waitframe(1);
        var_6665e24 = arraysortclosest(level.item_spawn_drops, draworigin, 75, 0, maxdist);
        waitframe(1);
        var_ac2b6007 = arraysortclosest(level.item_spawn_stashes, draworigin, 75, 0, maxdist);
        waitframe(1);
        var_c36bd68a = arraysortclosest(level.var_624588d5, draworigin, 75, 0, maxdist);
        waitframe(1);
        var_f4b807cb = arraycombine(var_f4b807cb, var_6665e24, 1, 0);
        waitframe(1);
        var_f4b807cb = arraycombine(var_f4b807cb, var_ac2b6007, 1, 0);
        waitframe(1);
        var_f4b807cb = arraycombine(var_f4b807cb, var_c36bd68a, 1, 0);
        waitframe(1);
        var_f4b807cb = arraysortclosest(var_f4b807cb, draworigin, 125 + var_6665e24.size, 0, maxdist);
        waitframe(1);
        if (isdefined(self) && var_5f6ea063) {
            for (index = 0; index < var_f4b807cb.size; index++) {
                item = var_f4b807cb[index];
                if (!isdefined(item)) {
                    continue;
                }
                model = item function_7731d23c(clientdata);
                function_3ee12d25(localclientnum, model);
                if ((index + 1) % 50 == 0) {
                    waitframe(1);
                }
            }
        }
        waitframe(1);
        for (index = int(min(75, var_f4b807cb.size)); index < 125 && index < var_f4b807cb.size; index++) {
            item = var_f4b807cb[index];
            if (!isdefined(item)) {
                continue;
            }
            model = item function_7731d23c(clientdata);
            function_3ee12d25(localclientnum, model);
            if ((index + 1) % 50 == 0) {
                waitframe(1);
            }
        }
        waitframe(1);
        for (index = 0; index < 75 && index < var_f4b807cb.size; index++) {
            item = var_f4b807cb[index];
            if (!isdefined(item)) {
                continue;
            }
            model = item function_7731d23c(clientdata);
            function_78bf134c(localclientnum, clientdata, item.networkid, model, item.itementry);
            if ((index + 1) % 50 == 0) {
                waitframe(1);
            }
        }
    }
    clientdata.var_844c8166 = draworigin;
    clientdata.var_f4b807cb = var_f4b807cb;
    clientdata.var_d58b471d = var_f4b807cb.size;
    clientdata.drawing = undefined;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0xa21550a1, Offset: 0x51b8
// Size: 0x1e4
function private function_78a9fd5f(point) {
    if (!isdefined(level.var_8c615e33)) {
        level.var_8c615e33 = [];
    }
    if (!isstruct(point) && isdefined(point.type == #"scriptmover") && isdefined(point.itementry.var_77d2cbb5) && point getentitynumber() < 1024) {
        return point.itementry.var_77d2cbb5;
    }
    if (!isdefined(level.var_8c615e33[point.itementry.name])) {
        if (isdefined(point.itementry.model) && point.itementry.model != "") {
            level.var_8c615e33[point.itementry.name] = point.itementry.model;
        } else if (isdefined(point.itementry.weapon) && point.itementry.weapon !== level.weaponnone) {
            level.var_8c615e33[point.itementry.name] = point.itementry.weapon.worldmodel;
        } else {
            level.var_8c615e33[point.itementry.name] = "tag_origin";
        }
    }
    return level.var_8c615e33[point.itementry.name];
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0x1ba5b077, Offset: 0x53a8
// Size: 0x22
function private function_8cf40a8c(localclientnum) {
    return getcamposbylocalclientnum(localclientnum);
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0xc30799e8, Offset: 0x53d8
// Size: 0x24
function private function_9e4552fe(var_fee74908) {
    level thread function_37175e73(var_fee74908);
}

// Namespace item_world/item_world
// Params 5, eflags: 0x4
// Checksum 0x39564a55, Offset: 0x5408
// Size: 0x652
function private function_9160538(localclientnum, eventtype, eventdata, var_c5a66313, var_567004a8) {
    waitframe(1);
    level flag::wait_till(#"item_world_initialized");
    if (!isdefined(level.var_d342a3fd[localclientnum])) {
        return;
    }
    player = function_27673a7(localclientnum);
    isalive = isalive(player);
    switch (eventtype) {
    case 2:
        function_1b11e73c();
        networkid = eventdata;
        hide_item(localclientnum, networkid);
        function_b78a9820(localclientnum);
        item = function_b1702735(networkid);
        item_inventory::function_31868137(localclientnum, item);
        play_pickup_fx(localclientnum, item);
        break;
    case 3:
        networkid = eventdata;
        showitem = is_true(var_c5a66313);
        function_1b11e73c();
        waittillframeend();
        show_item(localclientnum, networkid, showitem);
        function_b78a9820(localclientnum);
        clientdata = function_a7e98a1a(localclientnum);
        model = function_61f5d33a(localclientnum, clientdata, networkid);
        if (isdefined(model)) {
            function_a4886b1e(localclientnum, networkid, model);
        }
        play_spawn_fx(localclientnum, networkid);
        break;
    case 4:
        itemid = eventdata;
        count = var_c5a66313;
        slotid = var_567004a8 ? var_567004a8 - 1 : undefined;
        if (!isalive) {
            return;
        }
        item_inventory::function_9c4460e0(localclientnum, itemid, count, slotid);
        function_b78a9820(localclientnum);
        break;
    case 11:
        networkid = eventdata;
        if (!isalive) {
            return;
        }
        item_inventory::consume_item(localclientnum, networkid);
        break;
    case 15:
        networkid = eventdata;
        if (!isalive) {
            return;
        }
        item_inventory::function_52e537be(localclientnum, networkid);
        break;
    case 5:
        networkid = eventdata;
        if (!isalive) {
            return;
        }
        item_inventory::function_c6ff0aa2(localclientnum, networkid);
        function_b78a9820(localclientnum);
        break;
    case 6:
        networkid = eventdata;
        if (!isalive) {
            return;
        }
        item_inventory::function_3bd1836f(localclientnum, networkid);
        function_b78a9820(localclientnum);
        break;
    case 12:
        var_c9293a27 = eventdata;
        var_8f194e5a = var_c5a66313;
        if (!isalive) {
            return;
        }
        item_inventory::function_26c87da8(localclientnum, var_c9293a27, var_8f194e5a);
        break;
    case 7:
        networkid = eventdata;
        if (!isalive) {
            return;
        }
        item_inventory::function_fa372100(localclientnum, networkid);
        break;
    case 8:
        networkid = eventdata;
        function_b78a9820(localclientnum);
        break;
    case 9:
        networkid = eventdata;
        count = var_c5a66313;
        if (!isalive) {
            return;
        }
        item_inventory::update_inventory_item(localclientnum, networkid, count);
        function_b78a9820(localclientnum);
        break;
    case 10:
        item_inventory::inventory_init(localclientnum);
        break;
    case 13:
        networkid = eventdata;
        var_2ccf7a1c = var_c5a66313;
        function_347698a5(localclientnum, networkid, var_2ccf7a1c);
        break;
    case 14:
        vehicleentnum = eventdata;
        var_2ccf7a1c = var_c5a66313;
        function_d2f95c1a(localclientnum, vehicleentnum, var_2ccf7a1c);
        break;
    default:
        assertmsg("<dev string:x62>" + eventtype);
        break;
    }
}

// Namespace item_world/item_world
// Params 7, eflags: 0x4
// Checksum 0x654b3fcb, Offset: 0x5a68
// Size: 0xe8
function private function_60386766(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    level flag::wait_till(#"item_world_initialized");
    foreach (supply_stash in level.item_spawn_stashes) {
        setdynentenabled(supply_stash, !bwastimejump);
    }
}

// Namespace item_world/item_world
// Params 7, eflags: 0x4
// Checksum 0xc5e649c0, Offset: 0x5b58
// Size: 0x504
function private function_4e9220ab(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        level.var_ac56bfa4 = undefined;
        waitframe(1);
        if (isdemoplaying()) {
            function_8722e0f2(1);
        }
        if (!issplitscreenhost(fieldname)) {
            function_1b11e73c();
        }
        level flag::wait_till_clear(#"hash_2d3b2a4d082ba5ee");
        level flag::set(#"hash_2d3b2a4d082ba5ee");
        if (level flag::get(#"item_world_reset")) {
            return;
        }
        seed = bwastimejump;
        level.item_spawn_seed = seed;
        level flag::set(#"item_world_reset");
        level flag::clear(#"item_world_initialized");
        data = function_a7e98a1a(fieldname);
        if (!isdefined(data.inventory) && !item_inventory::function_7d5553ac()) {
            level item_inventory::inventory_init(fieldname);
        }
        clientdata = function_a7e98a1a(fieldname);
        if (isdefined(clientdata) && isdefined(clientdata.modellist)) {
            models = [];
            foreach (model in clientdata.modellist) {
                model notsolid();
                model hide();
                function_2990e5f(fieldname, model);
                function_3ee12d25(fieldname, model);
                models[models.size * -1 - 1] = model;
            }
            clientdata.modellist = models;
        }
        foreach (networkid, serverinfo in clientdata.var_ffc1c0e1) {
            clientdata.var_ffc1c0e1[networkid].servertime = 0;
        }
        foreach (vehicleentnum, serverinfo in clientdata.var_baf65690) {
            clientdata.var_baf65690[vehicleentnum].servertime = 0;
        }
        if (issplitscreenhost(fieldname)) {
            level item_spawn_group::setup(fieldname, seed);
        }
        level thread function_48b8fc19(fieldname);
        player = function_5c10bd79(fieldname);
        player.var_5f6ea063 = 1;
        level flag::set(#"item_world_initialized");
        level flag::clear(#"hash_2d3b2a4d082ba5ee");
        if (isdemoplaying()) {
            function_8722e0f2(0);
        }
    }
}

// Namespace item_world/item_world
// Params 7, eflags: 0x4
// Checksum 0xbcefad0d, Offset: 0x6068
// Size: 0x4c
function private function_7e3cc2ff(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    level.var_ac56bfa4 = bwastimejump;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0x9e85e38a, Offset: 0x60c0
// Size: 0x24
function private function_e2e7ee77(localclientnum) {
    self function_e1f6ddbf(localclientnum);
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0x8996fb55, Offset: 0x60f0
// Size: 0x5c
function private function_e1f6ddbf(localclientnum) {
    setting = function_ab88dbd2(localclientnum, #"warzoneprioritypickups");
    if (isdefined(setting)) {
        function_97fedb0d(localclientnum, 2, setting);
    }
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0xef723745, Offset: 0x6158
// Size: 0x3c
function private _on_localclient_connect(localclientnum) {
    function_952d97dc(localclientnum);
    self function_e2e7ee77(localclientnum);
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0xf5974826, Offset: 0x61a0
// Size: 0xdc
function private _on_localplayer_spawned(localclientnum) {
    /#
        self thread function_cdd9b388();
    #/
    if (self function_21c0fa55()) {
        self function_e2e7ee77(localclientnum);
        if (!is_true(getgametypesetting(#"hash_36c2645732ad1c3b")) || !item_inventory::function_7d5553ac()) {
            self thread _update_loop(localclientnum);
        }
        level callback::function_6231c19(&item_inventory::function_6231c19);
    }
}

// Namespace item_world/item_world
// Params 2, eflags: 0x4
// Checksum 0x81a60b0d, Offset: 0x6288
// Size: 0x268
function private _set_weapon(localclientnum, item) {
    if (isdefined(item) && isdefined(item.itementry.weapon) && !isdefined(item.itementry.model) && isdefined(item.itementry.weapon.worldmodel)) {
        weapon = item_inventory_util::function_2b83d3ff(item);
        camoweapon = undefined;
        renderoptionsweapon = undefined;
        var_fd90b0bb = undefined;
        if (isdefined(getgametypesetting(#"hash_54fe37a58b87c7a0")) ? getgametypesetting(#"hash_54fe37a58b87c7a0") : 0) {
            if (isdefined(item.weapon)) {
                weapon = item.weapon;
            }
            camoweapon = activecamo::function_b259f3e0(weapon);
            renderoptionsweapon = self getbuildkitweaponoptions(localclientnum, camoweapon);
            var_fd90b0bb = self function_1744e243(localclientnum, camoweapon);
        }
        if (isdefined(renderoptionsweapon)) {
            self useweaponmodel(level.weaponnone, "tag_origin");
            self useweaponmodel(weapon, undefined, renderoptionsweapon, var_fd90b0bb);
        } else {
            self useweaponmodel(weapon);
        }
        self useweaponhidetags(weapon);
        if (isdefined(renderoptionsweapon)) {
            self activecamo::function_6efb762c(localclientnum, camoweapon, renderoptionsweapon);
        }
        return 1;
    }
    self detachall();
    self useweaponmodel(level.weaponnone, "tag_origin");
    return 0;
}

// Namespace item_world/item_world
// Params 4, eflags: 0x4
// Checksum 0x47576707, Offset: 0x64f8
// Size: 0xfc
function private function_e082e650(localclientnum, item, newmodel, scale) {
    if (newmodel === self.model) {
        if (!isdefined(item) && self.weapon == level.weaponnone) {
            return;
        }
    }
    function_2990e5f(localclientnum, item);
    function_3ee12d25(localclientnum, self);
    self setscale(scale);
    if (isdefined(newmodel) && (!self _set_weapon(localclientnum, item) || isdefined(item.itementry.model))) {
        self setmodel(newmodel);
    }
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0x3579e504, Offset: 0x6600
// Size: 0x168
function private function_96fa1c6d(localclientnum) {
    clientdata = function_a7e98a1a(localclientnum);
    if (is_true(clientdata.drawing)) {
        return false;
    }
    if (!isdefined(clientdata.var_844c8166)) {
        return true;
    }
    if (function_1cbf351b(localclientnum)) {
        return true;
    }
    servertime = getservertime(localclientnum);
    if (servertime < clientdata.var_79b15dd1) {
        return true;
    }
    var_605384fe = function_8cf40a8c(localclientnum);
    var_48f611aa = distancesquared(clientdata.var_844c8166, var_605384fe);
    if (var_48f611aa >= sqr(72)) {
        return true;
    }
    if (is_true(self.var_5f6ea063) || is_true(self.var_506495f9)) {
        return true;
    }
    return false;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0xdd551515, Offset: 0x6770
// Size: 0x56
function private function_c7e5c26(localclientnum) {
    clientdata = function_a7e98a1a(localclientnum);
    if (is_true(clientdata.var_a4ad122e)) {
        return false;
    }
    return true;
}

// Namespace item_world/item_world
// Params 3, eflags: 0x4
// Checksum 0x9078c3a6, Offset: 0x67d0
// Size: 0x72
function private function_34418003(localclientnum, *eyepos, *angles) {
    clientdata = function_a7e98a1a(angles);
    if (is_true(clientdata.var_ff9e7e43)) {
        clientdata.var_ff9e7e43 = 0;
        return true;
    }
    return false;
}

// Namespace item_world/item_world
// Params 3, eflags: 0x4
// Checksum 0x2248ec97, Offset: 0x6850
// Size: 0x2da
function private function_5cbe24ea(&dest, &source, &order) {
    items = [];
    foreach (item in source) {
        if (!isdefined(item)) {
            continue;
        }
        itemname = item.itementry.name;
        if (!isdefined(items[itemname])) {
            items[itemname] = [];
        }
        size = items[itemname].size;
        items[itemname][size] = item;
    }
    foreach (itemname in order) {
        if (isdefined(items[itemname])) {
            foreach (item in items[itemname]) {
                dest[dest.size] = item;
            }
        }
        items[itemname] = undefined;
    }
    foreach (itemarray in items) {
        if (!isdefined(itemarray)) {
            continue;
        }
        foreach (item in itemarray) {
            if (!isdefined(item)) {
                continue;
            }
            dest[dest.size] = item;
        }
    }
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0x98a33af2, Offset: 0x6b38
// Size: 0x11ce
function private function_43d3ebe1(&items) {
    assert(isplayer(self));
    if (items.size <= 1) {
        return items;
    }
    arrayremovevalue(items, undefined, 0);
    sorted = [];
    itemtypes = [];
    stash = item_world_util::function_31f5aa51(items[0]);
    var_e30063d2 = isdefined(stash) && is_true(stash.lootlocker);
    if (var_e30063d2) {
        lootweapons = self item_inventory_util::get_loot_weapons();
        if (lootweapons.size > 0) {
            var_41f13734 = lootweapons[0];
            for (index = 0; index < items.size; index++) {
                item = items[index];
                if (!isdefined(items[index].itementry) || !isdefined(items[index].itementry.weapon)) {
                    continue;
                }
                if (items[index].itementry.weapon.name == var_41f13734) {
                    var_dd3170c7 = sorted.size;
                    sorted[var_dd3170c7] = items[index];
                    sorted[var_dd3170c7].var_41f13734 = 1;
                    arrayremoveindex(items, index, 0);
                    break;
                }
            }
        }
    }
    for (index = 0; index < items.size; index++) {
        if (!isdefined(items[index])) {
            continue;
        }
        itementry = items[index].itementry;
        if (!isdefined(itemtypes[itementry.itemtype])) {
            itemtypes[itementry.itemtype] = [];
        }
        size = itemtypes[itementry.itemtype].size;
        itemtypes[itementry.itemtype][size] = items[index];
    }
    waitframe(1);
    if (isdefined(itemtypes[#"dogtag"])) {
        foreach (entry in itemtypes[#"dogtag"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"quest"])) {
        foreach (entry in itemtypes[#"quest"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"cash"])) {
        foreach (entry in itemtypes[#"cash"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"armor"])) {
        function_5cbe24ea(sorted, itemtypes[#"armor"], level.var_69ee9282);
        waitframe(1);
    }
    if (isdefined(itemtypes[#"armor_shard"])) {
        foreach (entry in itemtypes[#"armor_shard"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"weapon"])) {
        var_610b8743 = [];
        foreach (item in itemtypes[#"weapon"]) {
            if (!isdefined(item)) {
                continue;
            }
            if (item.itementry.rarity == #"epic") {
                var_610b8743[var_610b8743.size] = item;
            }
        }
        if (isdefined(var_610b8743)) {
            function_5cbe24ea(sorted, var_610b8743, level.var_e93e16b);
            waitframe(1);
        }
    }
    if (isdefined(itemtypes[#"weapon"])) {
        weapons = [];
        foreach (item in itemtypes[#"weapon"]) {
            if (!isdefined(item)) {
                continue;
            }
            if (item.itementry.rarity != #"epic") {
                weapons[weapons.size] = item;
            }
        }
        if (isdefined(weapons)) {
            function_5cbe24ea(sorted, weapons, level.var_b9917a92);
            waitframe(1);
        }
    }
    if (isdefined(itemtypes[#"health"])) {
        function_5cbe24ea(sorted, itemtypes[#"health"], level.var_9bc8c1bc);
        waitframe(1);
    }
    if (isdefined(itemtypes[#"backpack"])) {
        foreach (entry in itemtypes[#"backpack"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"attachment"])) {
        function_5cbe24ea(sorted, itemtypes[#"attachment"], level.var_6cb314b1);
        waitframe(1);
    }
    if (isdefined(itemtypes[#"killstreak"])) {
        foreach (entry in itemtypes[#"killstreak"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"field_upgrade"])) {
        foreach (entry in itemtypes[#"field_upgrade"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"equipment"])) {
        function_5cbe24ea(sorted, itemtypes[#"equipment"], level.var_3fd5d8f0);
        waitframe(1);
    }
    if (isdefined(itemtypes[#"tactical"])) {
        foreach (entry in itemtypes[#"tactical"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"generic"])) {
        function_5cbe24ea(sorted, itemtypes[#"generic"], level.var_683c7e30);
        waitframe(1);
    }
    if (isdefined(itemtypes[#"perk_tier_1"])) {
        foreach (entry in itemtypes[#"perk_tier_1"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"perk_tier_2"])) {
        foreach (entry in itemtypes[#"perk_tier_2"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"perk_tier_3"])) {
        foreach (entry in itemtypes[#"perk_tier_3"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"scorestreak"])) {
        foreach (entry in itemtypes[#"scorestreak"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"survival_armor_shard"])) {
        foreach (entry in itemtypes[#"survival_armor_shard"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"ammo"])) {
        function_5cbe24ea(sorted, itemtypes[#"ammo"], level.var_418d51ad);
        waitframe(1);
    }
    if (isdefined(itemtypes[#"resource"])) {
        foreach (entry in itemtypes[#"resource"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"survival_essence"])) {
        foreach (entry in itemtypes[#"survival_essence"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"survival_armor_shard"])) {
        foreach (entry in itemtypes[#"survival_armor_shard"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"survival_ammo"])) {
        foreach (entry in itemtypes[#"survival_ammo"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"survival_perk"])) {
        foreach (entry in itemtypes[#"survival_perk"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"survival_scorestreak"])) {
        foreach (entry in itemtypes[#"survival_scorestreak"]) {
            sorted[sorted.size] = entry;
        }
    }
    return sorted;
}

// Namespace item_world/item_world
// Params 4, eflags: 0x4
// Checksum 0x9b93a04, Offset: 0x7d10
// Size: 0xec
function private function_b21002cb(localclientnum, objid, obj, objstate) {
    if (obj.type === "scriptmover" || obj.type === "missile") {
        objective_onentity(localclientnum, objid, obj, 0, 0, 0);
    } else {
        objective_clearentity(localclientnum, objid);
        objective_setposition(localclientnum, objid, obj.origin);
    }
    objective_setgamemodeflags(localclientnum, objid, objstate);
    objective_setstate(localclientnum, objid, "active");
}

// Namespace item_world/item_world
// Params 3, eflags: 0x4
// Checksum 0x4d19da6e, Offset: 0x7e08
// Size: 0xec
function private function_c3f5f99b(localclientnum, objid, obj) {
    objective_setstate(localclientnum, objid, "invisible");
    objective_setgamemodeflags(localclientnum, objid, 0);
    if (isdefined(obj)) {
        if (obj.type === "scriptmover" || obj.type === "missile") {
            objective_onentity(localclientnum, objid, obj, 0, 0, 0);
            return;
        }
        objective_clearentity(localclientnum, objid);
        objective_setposition(localclientnum, objid, obj.origin);
    }
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0xf18482aa, Offset: 0x7f00
// Size: 0x59a
function private function_b0af857f(localclientnum) {
    self endon(#"death");
    self notify("4f6a1500c18cfaa1");
    self endon("4f6a1500c18cfaa1");
    clientdata = function_a7e98a1a(localclientnum);
    if (is_true(clientdata.var_a4ad122e)) {
        return;
    }
    clientdata.var_a4ad122e = 1;
    var_da43934d = self function_da43934d();
    if (var_da43934d) {
        if (!self inlaststand() && !clientfield::get_to_player("disableItemPickup")) {
            eyepos = getlocalclienteyepos(localclientnum);
            angles = getlocalclientangles(localclientnum);
            maxdist = undefined;
            var_512ddf16 = self clientfield::get_player_uimodel("hudItems.multiItemPickup.status") == 2;
            if (var_512ddf16) {
                maxdist = 128;
            } else {
                model = getuimodelvalue(createuimodel(function_1df4c3b0(localclientnum, #"hash_23febb0b8f867ca1"), "currentSelection"));
                if (isdefined(model)) {
                    uimodel = createuimodel(model, "id");
                    if (isdefined(uimodel)) {
                        itemid = getuimodelvalue(uimodel);
                        if (isdefined(itemid) && itemid != 32767) {
                            setuimodelvalue(createuimodel(model, "id"), 32767);
                        }
                    }
                }
            }
            self.var_54d9f4a6 = 0;
            if (var_512ddf16) {
                self.var_9b882d22 = undefined;
                self.var_cdaade8c = undefined;
                model = getuimodelvalue(createuimodel(function_1df4c3b0(localclientnum, #"hash_23febb0b8f867ca1"), "currentSelection"));
                if (isdefined(model)) {
                    uimodel = createuimodel(model, "id");
                    if (isdefined(uimodel)) {
                        itemid = getuimodelvalue(uimodel);
                        if (isdefined(itemid) && itemid != 32767) {
                            if (item_world_util::function_2c7fc531(itemid)) {
                                self.var_9b882d22 = function_b1702735(itemid);
                            } else if (item_world_util::function_da09de95(itemid)) {
                                if (isdefined(level.item_spawn_drops[itemid])) {
                                    self.var_9b882d22 = level.item_spawn_drops[itemid];
                                }
                            }
                            if (isdefined(self.var_9b882d22)) {
                                self.var_9b882d22.var_5d97fed1 = item_world_util::function_83c20f83(self.var_9b882d22);
                            }
                        }
                    }
                }
                if (!isdefined(self.var_9b882d22)) {
                    self.var_54d9f4a6 = 1;
                    foreach (item in clientdata.groupitems) {
                        if (self item_world_util::can_pick_up(item)) {
                            self.var_9b882d22 = item;
                            self.var_9b882d22.var_5d97fed1 = item_world_util::function_83c20f83(self.var_9b882d22);
                            break;
                        }
                    }
                }
            }
            if (!var_512ddf16 || !isdefined(self.var_9b882d22)) {
                self.var_9b882d22 = function_94db1536(localclientnum, eyepos, angles, maxdist);
                if (isdefined(self.var_9b882d22)) {
                    self.var_cdaade8c = self.var_9b882d22.origin;
                }
            }
        } else {
            self.var_9b882d22 = undefined;
        }
        waitframe(1);
        function_802915bc(localclientnum);
    }
    if (is_true(self.disableitempickup)) {
        self.var_9b882d22 = undefined;
    }
    clientdata.var_a4ad122e = 0;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0x4efbddb5, Offset: 0x84a8
// Size: 0x2cc
function private function_802915bc(localclientnum) {
    if (!isdefined(level.var_62c91473) || !isdefined(level.var_62c91473[localclientnum])) {
        return;
    }
    eyepos = getlocalclienteyepos(localclientnum);
    if (isdefined(self.var_9b882d22) && self.var_9b882d22.var_5d97fed1) {
        var_1ba7b9c8 = arraysortclosest(level.var_624588d5, self.var_9b882d22.origin, 1, 0, 12);
        hinttext = #"wz/supply_stash";
        if (var_1ba7b9c8.size > 0) {
            isdeathstash = var_1ba7b9c8[0].stash_type === 2;
            hinttext = isdeathstash ? #"wz/death_stash" : #"wz/supply_drop";
        } else {
            var_1ba7b9c8 = arraysortclosest(level.item_spawn_stashes, self.var_9b882d22.origin, 1, 0, 12);
            if (var_1ba7b9c8.size > 0 && isdefined(var_1ba7b9c8[0].displayname)) {
                hinttext = var_1ba7b9c8[0].displayname;
            }
        }
        setuimodelvalue(level.var_62c91473[localclientnum], hinttext);
        return;
    }
    if (!isdefined(self.var_9b882d22) || distance2dsquared(self.var_9b882d22.origin, eyepos) > sqr(128)) {
        angles = getlocalclientangles(localclientnum);
        vehicle = item_world_util::function_6af455de(localclientnum, eyepos, angles);
        hintstring = item_world_util::function_c62ad9a7(vehicle);
        setuimodelvalue(level.var_62c91473[localclientnum], hintstring);
        return;
    }
    setuimodelvalue(level.var_62c91473[localclientnum], #"");
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0xe7103307, Offset: 0x8780
// Size: 0x6c4
function private function_c46425e0(localclientnum) {
    if (isdefined(self)) {
        var_f4b807cb = function_2e3efdda(self.origin, undefined, 64, 256, -1, 0);
        if (!isdefined(var_f4b807cb) || !var_f4b807cb.size) {
            return;
        }
        nearbyweapons = [];
        var_d61d8afa = [];
        for (index = 0; index < var_f4b807cb.size; index++) {
            item = var_f4b807cb[index];
            if (!isdefined(item)) {
                continue;
            }
            if (isdefined(item.itementry)) {
                if (item.itementry.itemtype == #"weapon") {
                    if (isdefined(item.weapon) && item.weapon != level.weaponnone && item.weapon !== item.itementry.weapon) {
                        camoweapon = activecamo::function_b259f3e0(item.weapon);
                        renderoptionsweapon = self getbuildkitweaponoptions(localclientnum, camoweapon);
                        var_fd90b0bb = self function_1744e243(localclientnum, camoweapon);
                        streamweapon = item.weapon;
                        function_d780f794(localclientnum, streamweapon, renderoptionsweapon, var_fd90b0bb);
                        nearbyweapons[streamweapon] = renderoptionsweapon;
                    } else if (isdefined(item.itementry.weapon) && item.itementry.weapon != level.weaponnone) {
                        camoweapon = activecamo::function_b259f3e0(item.itementry.weapon);
                        renderoptionsweapon = self getbuildkitweaponoptions(localclientnum, camoweapon);
                        var_fd90b0bb = self function_1744e243(localclientnum, camoweapon);
                        streamweapon = item_inventory_util::function_2b83d3ff(item);
                        function_d780f794(localclientnum, streamweapon, renderoptionsweapon, var_fd90b0bb);
                        nearbyweapons[streamweapon] = renderoptionsweapon;
                    }
                    continue;
                }
                if (item.itementry.itemtype == #"attachment") {
                    if (isdefined(item.itementry.attachments)) {
                        foreach (attachment in item.itementry.attachments) {
                            if (isdefined(attachment.attachment_type)) {
                                var_d61d8afa[attachment.attachment_type] = attachment.attachment_type;
                            }
                        }
                    }
                }
            }
        }
        currentweapon = self function_d2c2b168();
        if (isdefined(currentweapon) && currentweapon != level.weaponnone && currentweapon != level.weaponbasemeleeheld) {
            foreach (attachment in var_d61d8afa) {
                if (!weaponhasattachment(currentweapon, attachment)) {
                    weaponoptions = self function_e10e6c37();
                    streamweapon = getweapon(currentweapon.rootweapon.name, attachment);
                    if (isdefined(streamweapon) && weaponhasattachment(streamweapon, attachment)) {
                        function_d780f794(localclientnum, streamweapon, weaponoptions, 0);
                    }
                }
            }
            if (nearbyweapons.size) {
                var_1bf1ce1 = getweaponattachments(currentweapon);
                if (isdefined(var_1bf1ce1) && var_1bf1ce1.size) {
                    foreach (key, weaponoptions in nearbyweapons) {
                        nearbyweapon = weapon(key);
                        if (nearbyweapon.rootweapon != currentweapon.rootweapon) {
                            foreach (attachment in var_1bf1ce1) {
                                if (attachment !== "null" && !weaponhasattachment(nearbyweapon, attachment)) {
                                    streamweapon = getweapon(nearbyweapon.name, attachment);
                                    if (isdefined(streamweapon) && streamweapon != nearbyweapon && weaponhasattachment(streamweapon, attachment)) {
                                        function_d780f794(localclientnum, streamweapon, weaponoptions, 0);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0x41da9cc0, Offset: 0x8e50
// Size: 0x26e
function private function_48ec057f(localclientnum) {
    clientdata = function_a7e98a1a(localclientnum);
    if (!isdefined(clientdata)) {
        return;
    }
    var_f1530a67 = getservertime(localclientnum, 1);
    var_bea3e246 = [];
    foreach (networkid, serverinfo in clientdata.var_ffc1c0e1) {
        model = function_61f5d33a(localclientnum, clientdata, networkid);
        if (isdefined(model)) {
            function_a4886b1e(localclientnum, networkid, model);
        }
        if (serverinfo.servertime >= var_f1530a67) {
            var_bea3e246[networkid] = serverinfo;
        }
    }
    clientdata.var_ffc1c0e1 = var_bea3e246;
    var_bf2d48f6 = [];
    foreach (vehicleentnum, serverinfo in clientdata.var_baf65690) {
        vehicle = getentbynum(localclientnum, vehicleentnum);
        if (isdefined(vehicle) && serverinfo.servertime >= var_f1530a67 && !isvehicleoccupied(localclientnum, vehicle)) {
            var_bf2d48f6[vehicleentnum] = serverinfo;
            function_3bd99d2f(localclientnum, clientdata, vehicle);
            continue;
        }
        function_3bd99d2f(localclientnum, clientdata, vehicle, 1);
    }
    clientdata.var_baf65690 = var_bf2d48f6;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0x2390045b, Offset: 0x90c8
// Size: 0x1a6
function private _update_loop(localclientnum) {
    self endon(#"shutdown");
    self notify("4349461ce457f93f");
    self endon("4349461ce457f93f");
    waitframe(1);
    clientdata = function_a7e98a1a(localclientnum);
    clientdata.var_a4ad122e = 0;
    clientdata.var_d7bd75b5 = 0;
    function_1b11e73c();
    while (true) {
        if (!isdefined(self)) {
            return;
        }
        if (function_96fa1c6d(localclientnum)) {
            draworigin = function_8cf40a8c(localclientnum);
            self thread _draw(localclientnum, draworigin);
        }
        waitframe(1);
        function_48ec057f(localclientnum);
        function_c46425e0(localclientnum);
        waitframe(1);
        if (isalive(self)) {
            self thread function_e2c19e6b(localclientnum);
            if (function_c7e5c26(localclientnum)) {
                self thread function_b0af857f(localclientnum);
            }
            function_48ca0bbb(localclientnum);
        }
        waitframe(1);
    }
}

// Namespace item_world/item_world
// Params 2, eflags: 0x4
// Checksum 0x249d3868, Offset: 0x9278
// Size: 0x42
function private function_c199bcc6(localclientnum, item) {
    if (item_inventory::function_7d5553ac()) {
        return 0;
    }
    return item_inventory::can_pickup_ammo(localclientnum, item);
}

// Namespace item_world/item_world
// Params 2, eflags: 0x4
// Checksum 0x5d816702, Offset: 0x92c8
// Size: 0xaa
function private function_87e71bc0(localclientnum, itementry) {
    if (isdefined(level.var_75f7e612)) {
        result = [[ level.var_75f7e612 ]](localclientnum, itementry);
        assert(result === 1 || result === 0);
        return result;
    }
    if (item_inventory::function_7d5553ac()) {
        return 1;
    }
    return item_inventory::function_ad4c6116(localclientnum, itementry);
}

// Namespace item_world/item_world
// Params 2, eflags: 0x4
// Checksum 0xcaf1be56, Offset: 0x9380
// Size: 0x7c
function private function_8c4dc71f(localclientnum, itementry) {
    if (isdefined(level.var_977ee0c2)) {
        result = [[ level.var_977ee0c2 ]](localclientnum, itementry);
        assert(result === 1 || result === 0);
        return result;
    }
    return 0;
}

// Namespace item_world/item_world
// Params 2, eflags: 0x4
// Checksum 0x233268e9, Offset: 0x9408
// Size: 0xaa
function private function_76eb0584(localclientnum, itementry) {
    if (isdefined(level.var_b637a0c0)) {
        result = [[ level.var_b637a0c0 ]](localclientnum, itementry);
        assert(result === 1 || result === 0);
        return result;
    }
    if (item_inventory::function_7d5553ac()) {
        return 1;
    }
    return item_inventory::function_a243ddd6(localclientnum, itementry);
}

// Namespace item_world/item_world
// Params 2, eflags: 0x4
// Checksum 0x88585bb0, Offset: 0x94c0
// Size: 0x42
function private function_c76c61d6(localclientnum, itementry) {
    if (item_inventory::function_7d5553ac()) {
        return;
    }
    return item_inventory::function_78ed4455(localclientnum, itementry);
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0xcb0ce65a, Offset: 0x9510
// Size: 0x32
function private function_cc2f075(localclientnum) {
    if (item_inventory::function_7d5553ac()) {
        return;
    }
    return item_inventory::function_d768ea30(localclientnum);
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0x6945c7a5, Offset: 0x9550
// Size: 0xad4
function private function_48ca0bbb(localclientnum) {
    var_da43934d = self function_da43934d();
    if (var_da43934d) {
        eyepos = getlocalclienteyepos(localclientnum);
        angles = getlocalclientangles(localclientnum);
        var_1f50aeea = self clientfield::get_player_uimodel("hudItems.pickupHintWeaponIndex");
        if (!var_1f50aeea && isdefined(self.var_9b882d22) && isdefined(self.var_9b882d22.itementry) && !isdefined(getplayervehicle(self))) {
            itementry = self.var_9b882d22.itementry;
            var_77055f15 = 0;
            var_fa3df96 = undefined;
            if (itementry.itemtype == #"ammo" && !function_c199bcc6(localclientnum, self.var_9b882d22)) {
                var_77055f15 = 64;
            } else if (function_8c4dc71f(localclientnum, itementry)) {
                var_77055f15 = 2;
            } else if (function_76eb0584(localclientnum, itementry)) {
                var_77055f15 = 1;
                if (itementry.itemtype == #"attachment") {
                    var_77055f15 = 1;
                    if (function_87e71bc0(localclientnum, itementry)) {
                        var_77055f15 |= 32;
                    }
                } else if (itementry.itemtype == #"weapon") {
                    var_a4250c2b = self function_cc2f075(localclientnum);
                    if (isdefined(var_a4250c2b) && item_inventory_util::function_4bd83c04(self.var_9b882d22) && self item_inventory::has_attachments(localclientnum, var_a4250c2b)) {
                        var_77055f15 |= 512;
                    }
                } else if (itementry.itemtype == #"armor") {
                    if (!function_87e71bc0(localclientnum, itementry)) {
                        var_77055f15 = 4;
                    }
                }
            } else if (itementry.itemtype == #"weapon") {
                var_77055f15 = 2;
                var_a4250c2b = self function_cc2f075(localclientnum);
                if (isdefined(var_a4250c2b) && item_inventory_util::function_4bd83c04(self.var_9b882d22) && self item_inventory::has_attachments(localclientnum, var_a4250c2b) && !is_true(level.var_8c46cf7a)) {
                    var_77055f15 |= 512;
                }
            } else {
                var_fa3df96 = self function_c76c61d6(localclientnum, itementry);
                if (isdefined(var_fa3df96)) {
                    var_77055f15 = 2;
                    if (itementry.itemtype == #"armor") {
                        if (!function_87e71bc0(localclientnum, itementry)) {
                            var_77055f15 = 2048;
                        }
                    } else if (itementry.itemtype == #"attachment") {
                        var_fa3df96 = undefined;
                        if (function_87e71bc0(localclientnum, itementry)) {
                            var_77055f15 |= 32;
                        }
                    }
                } else if (!function_87e71bc0(localclientnum, itementry)) {
                    if (itementry.itemtype == #"resource" && item_world_util::function_41f06d9d(itementry)) {
                        var_77055f15 = 128;
                    } else {
                        var_77055f15 = 4;
                    }
                    if (itementry.itemtype == #"scorestreak" || itementry.itemtype == #"health" || item_inventory_util::function_1507e6f0(itementry) || item_world_util::function_a57773a4(itementry)) {
                        var_77055f15 |= 1024;
                    }
                    if (itementry.itemtype == #"survival_ammo") {
                        var_77055f15 = 64;
                    }
                    if (itementry.itemtype == #"survival_armor_shard") {
                        maxarmor = self function_a07288ec();
                        if (maxarmor === 0) {
                            var_77055f15 = 4096;
                        } else {
                            var_77055f15 = 2048;
                        }
                    }
                    if (itementry.name === #"self_revive_sr_item") {
                        var_77055f15 = 8192;
                    }
                } else if (itementry.itemtype == #"scorestreak" || itementry.itemtype == #"health" || item_inventory_util::function_1507e6f0(itementry) || item_world_util::function_a57773a4(itementry)) {
                    if (function_87e71bc0(localclientnum, itementry)) {
                        var_77055f15 |= 256;
                    }
                }
            }
            objstate = 0;
            if (isdefined(self.var_9b882d22.isfar) && self.var_9b882d22.isfar) {
                objstate = 1;
            }
            pickupicon = isdefined(itementry.pickupicon) ? itementry.pickupicon : itementry.icon;
            if (self.var_54d9f4a6) {
                var_77055f15 = 16;
            }
            setuimodelvalue(level.var_7e2f5883[localclientnum], isdefined(var_fa3df96) ? var_fa3df96 : -1);
            setuimodelvalue(level.var_ce95aace[localclientnum], var_77055f15);
            if (getuimodelvalue(level.var_d42ffee1[localclientnum]) !== 10) {
                setuimodelvalue(level.var_19cf0be9[localclientnum], isdefined(pickupicon) ? pickupicon : #"blacktransparent");
            }
            if (self.var_9b882d22.var_5d97fed1) {
                function_b21002cb(localclientnum, level.var_383edf80, self.var_9b882d22, objstate);
                function_c3f5f99b(localclientnum, level.var_d9beffb9);
            } else if (self item_world_util::can_pick_up(self.var_9b882d22)) {
                hintstring = self function_2fc74639();
                var_d1fce876 = #"";
                if (isdefined(itementry.hintstring)) {
                    var_d1fce876 = itementry.hintstring;
                } else if (isdefined(itementry.weapon)) {
                    var_d1fce876 = itementry.weapon.displayname;
                } else {
                    var_d1fce876 = isdefined(itementry.hintstring) ? itementry.hintstring : #"";
                }
                if (var_d1fce876 == hintstring) {
                    function_b21002cb(localclientnum, level.var_d9beffb9, self.var_9b882d22, objstate);
                    function_c3f5f99b(localclientnum, level.var_383edf80);
                } else {
                    if (!is_true(self.var_9b882d22.isclose)) {
                        function_b21002cb(localclientnum, level.var_d9beffb9, self.var_9b882d22, objstate);
                    } else {
                        function_c3f5f99b(localclientnum, level.var_d9beffb9, self.var_9b882d22);
                    }
                    function_c3f5f99b(localclientnum, level.var_383edf80, self.var_9b882d22);
                }
            }
        } else {
            if (var_1f50aeea) {
                setuimodelvalue(level.var_ce95aace[localclientnum], 16384);
            }
            if (getuimodelvalue(level.var_d42ffee1[localclientnum]) !== 10) {
                setuimodelvalue(level.var_19cf0be9[localclientnum], #"blacktransparent");
            }
            function_c3f5f99b(localclientnum, level.var_d9beffb9);
            function_c3f5f99b(localclientnum, level.var_383edf80);
        }
        if (self function_34418003(localclientnum, eyepos, angles)) {
            self function_7c84312d(localclientnum, eyepos, angles);
        }
    }
}

// Namespace item_world/item_world
// Params 4, eflags: 0x4
// Checksum 0x477ede46, Offset: 0xa030
// Size: 0x152
function private function_94db1536(localclientnum, origin, angles, maxdist = undefined) {
    assert(isplayer(self));
    clientdata = function_a7e98a1a(localclientnum);
    forward = vectornormalize(anglestoforward(angles));
    if (!isdefined(maxdist)) {
        maxdist = util::function_16fb0a3b();
    }
    var_f4b807cb = function_2e3efdda(origin, forward, 128, maxdist, 0);
    var_4bd72bfe = function_ab88dbd2(localclientnum, #"warzoneprioritypickups");
    var_9b882d22 = item_world_util::function_6061a15(var_f4b807cb, maxdist, origin, angles, forward, var_4bd72bfe, 1);
    return var_9b882d22;
}

// Namespace item_world/item_world
// Params 0, eflags: 0x4
// Checksum 0xf91dc89d, Offset: 0xa190
// Size: 0x6a
function private function_c5b6693a() {
    item = spawnstruct();
    item.amount = 0;
    item.count = 0;
    item.id = 32767;
    item.networkid = 32767;
    item.itementry = undefined;
    item.var_627c698b = undefined;
    return item;
}

// Namespace item_world/item_world
// Params 3, eflags: 0x4
// Checksum 0xf959cdb, Offset: 0xa208
// Size: 0x18c
function private function_7c84312d(localclientnum, *origin, *angles) {
    assert(isplayer(self));
    clientdata = function_a7e98a1a(angles);
    while (is_true(clientdata.var_a4ad122e)) {
        waitframe(1);
    }
    if (!isplayer(self)) {
        return;
    }
    if (isdefined(self.var_9b882d22)) {
        var_433d429 = 14;
        groupitems = function_2e3efdda(self.var_9b882d22.origin, undefined, 128, var_433d429, undefined, 1);
        groupitems = self function_43d3ebe1(groupitems);
        if (!isdefined(self)) {
            return;
        }
        arrayremovevalue(groupitems, undefined, 0);
        clientdata.groupitems = function_83e328e1(clientdata.groupitems, groupitems);
    } else {
        clientdata.groupitems = [];
    }
    self function_9116bb0e(angles);
}

// Namespace item_world/item_world
// Params 2, eflags: 0x4
// Checksum 0x217f9782, Offset: 0xa3a0
// Size: 0x336
function private function_83e328e1(var_78ddf4e2, newitems) {
    if (!isdefined(var_78ddf4e2)) {
        return newitems;
    }
    items = [];
    emptycount = 0;
    newcount = 0;
    var_21198c86 = [];
    foreach (newitem in newitems) {
        if (!isdefined(newitem)) {
            continue;
        }
        var_f613370d = newitem;
        if (isstruct(var_f613370d) && item_world_util::function_2c7fc531(var_f613370d.networkid)) {
            var_f613370d = function_b1702735(var_f613370d.networkid);
        }
        if (self item_world_util::can_pick_up(var_f613370d)) {
            var_21198c86[var_21198c86.size] = var_f613370d;
        }
    }
    foreach (var_319b917b in var_78ddf4e2) {
        var_f59eabca = var_319b917b;
        if (isstruct(var_f59eabca) && item_world_util::function_2c7fc531(var_f59eabca.networkid)) {
            var_f59eabca = function_b1702735(var_f59eabca.networkid);
        }
        if (!isdefined(var_f59eabca) || !self item_world_util::can_pick_up(var_f59eabca)) {
            emptycount++;
            items[items.size] = function_c5b6693a();
            continue;
        }
        foreach (newitem in var_21198c86) {
            if (newitem.networkid == var_f59eabca.networkid) {
                newcount++;
                items[items.size] = newitem;
            }
        }
    }
    if (var_21198c86.size == newcount && var_78ddf4e2.size == newcount + emptycount) {
        return items;
    }
    return newitems;
}

// Namespace item_world/item_world
// Params 3, eflags: 0x4
// Checksum 0xc038dc19, Offset: 0xa6e0
// Size: 0x234
function private function_1b42632a(localclientnum, clientdata, var_2ccf7a1c) {
    var_f0a9e97d = undefined;
    var_e7349b30 = undefined;
    foreach (var_7d6cdf6f, serverinfo in clientdata.var_ffc1c0e1) {
        if (serverinfo.var_2ccf7a1c == var_2ccf7a1c) {
            var_f0a9e97d = var_7d6cdf6f;
            var_e7349b30 = serverinfo;
            break;
        }
    }
    if (isdefined(var_f0a9e97d)) {
        clientdata.var_ffc1c0e1[var_f0a9e97d] = undefined;
        model = function_61f5d33a(localclientnum, clientdata, var_f0a9e97d);
        if (isdefined(model)) {
            function_a4886b1e(localclientnum, var_f0a9e97d, model);
        }
    }
    var_cd3b74d6 = undefined;
    var_e7349b30 = undefined;
    foreach (vehicleentnum, serverinfo in clientdata.var_baf65690) {
        if (serverinfo.var_2ccf7a1c == var_2ccf7a1c) {
            var_cd3b74d6 = vehicleentnum;
            var_e7349b30 = serverinfo;
            break;
        }
    }
    if (isdefined(var_cd3b74d6)) {
        clientdata.var_baf65690[var_cd3b74d6] = undefined;
        vehicle = getentbynum(localclientnum, var_cd3b74d6);
        if (isdefined(vehicle)) {
            function_3bd99d2f(localclientnum, clientdata, vehicle, 1);
        }
    }
}

// Namespace item_world/item_world
// Params 3, eflags: 0x0
// Checksum 0x503746e9, Offset: 0xa920
// Size: 0xf4
function function_347698a5(localclientnum, networkid, var_2ccf7a1c) {
    clientdata = function_a7e98a1a(localclientnum);
    function_1b42632a(localclientnum, clientdata, var_2ccf7a1c);
    endtime = getservertime(localclientnum, 1) + 60000;
    clientdata.var_ffc1c0e1[networkid] = {#servertime:endtime, #var_2ccf7a1c:var_2ccf7a1c};
    model = function_61f5d33a(localclientnum, clientdata, networkid);
    if (isdefined(model)) {
        function_a4886b1e(localclientnum, networkid, model);
    }
}

// Namespace item_world/item_world
// Params 3, eflags: 0x0
// Checksum 0xf604b343, Offset: 0xaa20
// Size: 0xec
function function_d2f95c1a(localclientnum, vehicleentnum, var_2ccf7a1c) {
    clientdata = function_a7e98a1a(localclientnum);
    function_1b42632a(localclientnum, clientdata, var_2ccf7a1c);
    endtime = getservertime(localclientnum, 1) + 60000;
    clientdata.var_baf65690[vehicleentnum] = {#servertime:endtime, #var_2ccf7a1c:var_2ccf7a1c};
    vehicle = getentbynum(localclientnum, vehicleentnum);
    function_d223645e(localclientnum, vehicle);
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0x14a67ab4, Offset: 0xab18
// Size: 0x1c
function function_a7e98a1a(localclientnum) {
    return level.var_d342a3fd[localclientnum];
}

// Namespace item_world/item_world
// Params 0, eflags: 0x0
// Checksum 0xd2e075db, Offset: 0xab40
// Size: 0x22
function function_963d3f6e() {
    return getgametypesetting(#"hash_47dd11084763c671");
}

// Namespace item_world/item_world
// Params 2, eflags: 0x0
// Checksum 0x5d69926, Offset: 0xab70
// Size: 0xba
function function_73436347(itemgroup, networkid) {
    assert(isarray(itemgroup));
    assert(isint(networkid));
    for (index = 0; index < itemgroup.size; index++) {
        item = itemgroup[index];
        if (isdefined(item) && item.networkid === networkid) {
            return index;
        }
    }
    return undefined;
}

// Namespace item_world/item_world
// Params 2, eflags: 0x0
// Checksum 0x9a8f2626, Offset: 0xac38
// Size: 0x8c
function function_d223645e(localclientnum, vehicle) {
    assert(isdefined(vehicle));
    if (!isdefined(vehicle) || !isvehicleoccupied(localclientnum, vehicle)) {
        return;
    }
    clientdata = function_a7e98a1a(localclientnum);
    function_3bd99d2f(localclientnum, clientdata, vehicle);
}

// Namespace item_world/item_world
// Params 3, eflags: 0x0
// Checksum 0x4d7504ff, Offset: 0xacd0
// Size: 0x21c
function function_a4886b1e(localclientnum, networkid, model) {
    assert(isdefined(model));
    if (!isdefined(model)) {
        return;
    }
    draworigin = function_8cf40a8c(localclientnum);
    maxdist = getdvarfloat(#"hash_2cd1a08f81049564", function_963d3f6e());
    clientdata = function_a7e98a1a(localclientnum);
    if (is_true(model.var_5d97fed1) || item_world_util::function_83c20f83(model)) {
        stash = function_c17fe536(localclientnum, clientdata, networkid);
        function_78bf134c(localclientnum, clientdata, networkid, stash);
        return;
    }
    if (distancesquared(draworigin, model.origin) <= sqr(maxdist)) {
        itementry = undefined;
        if (isdefined(networkid)) {
            if (item_world_util::function_2c7fc531(networkid)) {
                itementry = function_b1702735(networkid).itementry;
            } else if (item_world_util::function_da09de95(networkid)) {
                if (isdefined(level.item_spawn_drops[networkid])) {
                    itementry = level.item_spawn_drops[networkid].itementry;
                }
            }
        }
        function_78bf134c(localclientnum, clientdata, networkid, model, itementry);
    }
}

// Namespace item_world/item_world
// Params 2, eflags: 0x0
// Checksum 0x241ea9f0, Offset: 0xaef8
// Size: 0x19c
function play_spawn_fx(localclientnum, networkid) {
    if (!isdefined(networkid)) {
        return;
    }
    item = undefined;
    if (item_world_util::function_2c7fc531(networkid)) {
        item = function_b1702735(networkid);
    } else if (item_world_util::function_da09de95(networkid)) {
        if (isdefined(level.item_spawn_drops[networkid])) {
            item = level.item_spawn_drops[networkid];
        }
    }
    if (!isdefined(item) || !isdefined(item.itementry) || !isdefined(item.itementry.var_86d1fc36)) {
        return;
    }
    itementry = item.itementry;
    originoffset = function_7571fda9(item);
    angles = function_118d052e(item);
    forward = anglestoforward(angles);
    up = anglestoup(angles);
    playfx(localclientnum, itementry.var_86d1fc36, item.origin + originoffset, forward, up);
}

// Namespace item_world/item_world
// Params 2, eflags: 0x0
// Checksum 0x473b635c, Offset: 0xb0a0
// Size: 0x114
function play_pickup_fx(localclientnum, item) {
    if (!isdefined(item) || !isdefined(item.itementry) || !isdefined(item.itementry.var_37cd55af)) {
        return;
    }
    itementry = item.itementry;
    originoffset = function_7571fda9(item);
    angles = function_118d052e(item);
    forward = anglestoforward(angles);
    up = anglestoup(angles);
    playfx(localclientnum, itementry.var_37cd55af, item.origin + originoffset, forward, up);
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0xcf037478, Offset: 0xb1c0
// Size: 0xda
function function_7571fda9(item) {
    if (!isdefined(item) || !isdefined(item.itementry)) {
        return (0, 0, 0);
    }
    itementry = item.itementry;
    originoffset = (isdefined(itementry.var_5dc4470b) ? itementry.var_5dc4470b : 0, isdefined(itementry.var_54a3b4ca) ? itementry.var_54a3b4ca : 0, isdefined(itementry.var_3e688854) ? itementry.var_3e688854 : 0);
    originoffset = rotatepoint(originoffset * -1, item.angles);
    return originoffset;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0xa35e61cc, Offset: 0xb2a8
// Size: 0xd2
function function_118d052e(item) {
    if (!isdefined(item)) {
        return (0, 0, 0);
    }
    itementry = item.itementry;
    if (!isdefined(item.itementry)) {
        return item.angles;
    }
    angles = combineangles(item.angles, (isdefined(itementry.var_15b88fde) ? itementry.var_15b88fde : 0, isdefined(itementry.var_8c9a7dc8) ? itementry.var_8c9a7dc8 : 0, isdefined(itementry.var_7a51d937) ? itementry.var_7a51d937 : 0));
    return angles;
}

// Namespace item_world/item_world
// Params 2, eflags: 0x0
// Checksum 0x8584c475, Offset: 0xb388
// Size: 0xc0
function function_28b42f1c(localclientnum, networkid) {
    if (item_world_util::function_d9648161(networkid)) {
        if (item_world_util::function_2c7fc531(networkid)) {
            return networkid;
        } else if (item_world_util::function_da09de95(networkid)) {
            if (isdefined(level.item_spawn_drops[networkid])) {
                return level.item_spawn_drops[networkid].id;
            }
        } else if (!item_inventory::function_7d5553ac()) {
            return item_inventory::function_c48cd17f(localclientnum, networkid);
        }
    }
    return 32767;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0x552a3573, Offset: 0xb450
// Size: 0xa2
function get_item_name(item) {
    if (isdefined(item.displayname)) {
        return item.displayname;
    }
    if (isdefined(item.weapon)) {
        if (item.weapon.displayname != #"") {
            return item.weapon.displayname;
        }
    }
    return isdefined(item.displayname) ? item.displayname : #"";
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0xd9ebd817, Offset: 0xb500
// Size: 0x52
function function_6fe428b3(item) {
    if (isdefined(item.pickupicon)) {
        return item.pickupicon;
    }
    return isdefined(item.icon) ? item.icon : #"";
}

// Namespace item_world/item_world
// Params 6, eflags: 0x0
// Checksum 0xbf42b15c, Offset: 0xb560
// Size: 0x15c
function function_2e3efdda(origin, dir, maxitems, maxdistance, dot, var_653b55e5 = 0) {
    var_f4b807cb = function_abaeb170(origin, dir, maxitems, maxdistance, dot, 1, -2147483647);
    var_6665e24 = arraysortclosest(level.item_spawn_drops, origin, maxitems, 0, maxdistance);
    var_f4b807cb = arraycombine(var_f4b807cb, var_6665e24, 1, 0);
    var_f4b807cb = arraysortclosest(var_f4b807cb, origin, maxitems, 0, maxdistance);
    if (var_653b55e5) {
        stashitems = [];
        for (index = 0; index < var_f4b807cb.size; index++) {
            if (item_world_util::function_83c20f83(var_f4b807cb[index])) {
                stashitems[stashitems.size] = var_f4b807cb[index];
            }
        }
        var_f4b807cb = stashitems;
    }
    return var_f4b807cb;
}

// Namespace item_world/item_world
// Params 2, eflags: 0x0
// Checksum 0x6f95393a, Offset: 0xb6c8
// Size: 0x2ea
function hide_item(localclientnum, networkid) {
    if (item_world_util::function_2c7fc531(networkid)) {
        if (function_54ca5536(networkid, getservertime(0, 1)) == 0) {
            return;
        }
    }
    clientdata = function_a7e98a1a(localclientnum);
    if (isdefined(clientdata)) {
        if (isdefined(clientdata.modellist[networkid])) {
            clientdata.modellist[networkid] hide();
            clientdata.modellist[networkid * -1] = clientdata.modellist[networkid];
            function_2990e5f(localclientnum, clientdata.modellist[networkid]);
            arrayremoveindex(clientdata.modellist, networkid, 1);
            function_b032ccd(localclientnum, clientdata.modellist);
        }
        if (isdefined(clientdata.var_89e328b4) && isdefined(clientdata.var_89e328b4[networkid])) {
            clientdata.var_89e328b4[networkid] hide();
            clientdata.var_89e328b4[networkid * -1] = clientdata.var_89e328b4[networkid];
            function_2990e5f(localclientnum, clientdata.var_89e328b4[networkid]);
            arrayremoveindex(clientdata.var_89e328b4, networkid, 1);
            function_b032ccd(localclientnum, clientdata.modellist);
        }
        if (isarray(clientdata.groupitems)) {
            foreach (item in clientdata.groupitems) {
                if (isdefined(item) && item.networkid === networkid) {
                    if (isstruct(item)) {
                        item.hidetime = gettime();
                    }
                    break;
                }
            }
        }
    }
}

// Namespace item_world/item_world
// Params 3, eflags: 0x0
// Checksum 0xb161c242, Offset: 0xb9c0
// Size: 0x2b4
function show_item(localclientnum, networkid, showitem) {
    item = undefined;
    if (item_world_util::function_2c7fc531(networkid)) {
        function_54ca5536(networkid, showitem ? 0 : -1);
        player = function_5c10bd79(localclientnum);
        item = function_b1702735(networkid);
        var_6369afab = function_963d3f6e();
        if (!isdefined(item.origin)) {
            return;
        }
        if (isplayer(player) && distance2dsquared(item.origin, player.origin) <= sqr(var_6369afab)) {
            player.var_506495f9 = 1;
        }
    } else {
        item = level.item_spawn_drops[networkid];
    }
    clientdata = function_a7e98a1a(localclientnum);
    if (isdefined(clientdata) && isdefined(item)) {
        if (isdefined(clientdata.modellist[networkid])) {
            clientdata.modellist[networkid] show();
            function_78bf134c(localclientnum, clientdata, networkid, clientdata.modellist[networkid], item.itementry);
            function_84964a9e(localclientnum, item.itementry, clientdata.modellist[networkid], networkid);
        }
        if (isdefined(clientdata.var_89e328b4) && isdefined(clientdata.var_89e328b4[networkid])) {
            clientdata.var_89e328b4[networkid] show();
            function_78bf134c(localclientnum, clientdata, networkid, clientdata.var_89e328b4[networkid], item.itementry);
            function_84964a9e(localclientnum, item.itementry, clientdata.var_89e328b4[networkid], networkid);
        }
    }
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0xc9936ca9, Offset: 0xbc80
// Size: 0x3a
function function_b78a9820(localclientnum) {
    clientdata = function_a7e98a1a(localclientnum);
    clientdata.var_ff9e7e43 = 1;
}

// Namespace item_world/item_world
// Params 0, eflags: 0x0
// Checksum 0xdb63b133, Offset: 0xbcc8
// Size: 0x24
function function_1b11e73c() {
    level flag::wait_till(#"item_world_initialized");
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0x96ec9471, Offset: 0xbcf8
// Size: 0x4c
function function_9b71de90(localclientnum) {
    model = function_425ed700(localclientnum);
    if (isdefined(model) && isdefined(model.id)) {
        return model;
    }
}

