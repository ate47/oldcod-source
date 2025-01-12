#using script_1caf36ff04a85ff6;
#using script_7fc996fe8678852;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;

#namespace namespace_c09ae6c3;

// Namespace namespace_c09ae6c3/namespace_c09ae6c3
// Params 0, eflags: 0x6
// Checksum 0x218214a0, Offset: 0x118
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"hash_50d62958d724dac2", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace namespace_c09ae6c3/namespace_c09ae6c3
// Params 0, eflags: 0x1 linked
// Checksum 0x6b580078, Offset: 0x170
// Size: 0x2c
function function_70a657d8() {
    namespace_8b6a9d79::function_b3464a7c("ammo_cache", &function_9ed7339b);
}

// Namespace namespace_c09ae6c3/namespace_c09ae6c3
// Params 0, eflags: 0x1 linked
// Checksum 0xefab2a13, Offset: 0x1a8
// Size: 0x84
function postinit() {
    var_f5ae494f = struct::get_array(#"content_destination", "variantname");
    if (!zm_utility::is_survival() && isdefined(var_f5ae494f) && var_f5ae494f.size > 0) {
        level thread function_b99f518f(var_f5ae494f[0]);
    }
}

// Namespace namespace_c09ae6c3/namespace_c09ae6c3
// Params 1, eflags: 0x1 linked
// Checksum 0x112e21b8, Offset: 0x238
// Size: 0x218
function function_9ed7339b(struct) {
    assert(isstruct(struct), "<dev string:x38>");
    spawn_points = struct.var_fe2612fe[#"hash_6873efb1dfa0ebea"];
    foreach (point in spawn_points) {
        spawn_struct = point;
        scriptmodel = namespace_8b6a9d79::spawn_script_model(spawn_struct, #"p8_fxanim_wz_supply_stash_01_mod", 1);
        scriptmodel.var_e55c8b4e = gameobjects::get_next_obj_id();
        objective_add(scriptmodel.var_e55c8b4e, "active", scriptmodel, #"hash_669c000075d7222");
        trigger = namespace_8b6a9d79::function_214737c7(spawn_struct, &function_e4ff673, #"hash_47f37dccf2dfd164", undefined, 128, 128, undefined, (0, 0, 50));
        trigger.scriptmodel = scriptmodel;
        struct.trigger = trigger;
        struct.scriptmodel = scriptmodel;
        playfx("sr/fx9_safehouse_mchn_upgrades_spawn", struct.origin);
        playsoundatposition(#"hash_5c2fc4437449ddb4", struct.origin);
    }
}

// Namespace namespace_c09ae6c3/namespace_c09ae6c3
// Params 1, eflags: 0x1 linked
// Checksum 0x613a07f4, Offset: 0x458
// Size: 0x2ac
function function_e4ff673(eventstruct) {
    player = eventstruct.activator;
    model = self.scriptmodel;
    assert(isdefined(model), "<dev string:x5c>");
    if (isplayer(player)) {
        var_3069fe3 = player zm_score::can_player_purchase(500);
        if (var_3069fe3 && !player function_f300168a()) {
            nullweapon = getweapon(#"none");
            var_f945fa92 = getweapon(#"bare_hands");
            primaryweapon = player namespace_a0d533d1::function_2b83d3ff(player item_inventory::function_2e711614(17 + 1));
            if (isdefined(primaryweapon) && primaryweapon != nullweapon && primaryweapon != var_f945fa92) {
                maxammo = primaryweapon.maxammo;
                player setweaponammostock(primaryweapon, maxammo);
            }
            var_824ff7c7 = player namespace_a0d533d1::function_2b83d3ff(player item_inventory::function_2e711614(17 + 1 + 8 + 1));
            if (isdefined(var_824ff7c7) && var_824ff7c7 != nullweapon && var_824ff7c7 != var_f945fa92) {
                maxammo = var_824ff7c7.maxammo;
                player setweaponammostock(var_824ff7c7, maxammo);
            }
            player playsoundtoplayer(#"zmb_cha_ching", player);
            self playsound(#"fly_pickup_ammo_box");
            player zm_score::minus_to_player_score(500);
            return;
        }
        player playsoundtoplayer(#"zmb_no_cha_ching", player);
    }
}

// Namespace namespace_c09ae6c3/namespace_c09ae6c3
// Params 0, eflags: 0x5 linked
// Checksum 0xbbadfc16, Offset: 0x710
// Size: 0x160
function private function_f300168a() {
    var_e20637be = 1;
    nullweapon = getweapon(#"none");
    var_f945fa92 = getweapon(#"bare_hands");
    currentweapon = self getcurrentweapon();
    if (currentweapon != nullweapon && currentweapon != var_f945fa92) {
        maxammo = currentweapon.maxammo;
        currentammostock = self getweaponammostock(currentweapon);
        if (currentammostock < maxammo) {
            var_e20637be = 0;
        }
    }
    var_824ff7c7 = self getstowedweapon();
    if (var_824ff7c7 != nullweapon && var_824ff7c7 != var_f945fa92) {
        maxammo = var_824ff7c7.maxammo;
        var_22baab7c = self getweaponammostock(var_824ff7c7);
        if (var_22baab7c < maxammo) {
            var_e20637be = 0;
        }
    }
    return var_e20637be;
}

// Namespace namespace_c09ae6c3/namespace_c09ae6c3
// Params 1, eflags: 0x1 linked
// Checksum 0x50e6abc4, Offset: 0x878
// Size: 0x44
function function_b99f518f(destination) {
    level flag::wait_till("start_zombie_round_logic");
    waittillframeend();
    function_7b19802a(destination);
}

// Namespace namespace_c09ae6c3/namespace_c09ae6c3
// Params 1, eflags: 0x1 linked
// Checksum 0x9a0f8573, Offset: 0x8c8
// Size: 0xc0
function function_7b19802a(destination) {
    foreach (location in destination.locations) {
        ammo_cache = location.instances[#"ammo_cache"];
        if (isdefined(ammo_cache)) {
            namespace_8b6a9d79::function_20d7e9c7(ammo_cache);
        }
    }
}

