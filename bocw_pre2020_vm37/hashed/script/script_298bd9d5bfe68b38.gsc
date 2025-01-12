#using script_75da5547b1822294;
#using script_d9b5c8b1ad38ef5;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace weapon_cache;

// Namespace weapon_cache/weapon_cache
// Params 0, eflags: 0x6
// Checksum 0x3e5afb04, Offset: 0x168
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"weapon_cache", &function_70a657d8, undefined, &finalize, undefined);
}

// Namespace weapon_cache/weapon_cache
// Params 0, eflags: 0x5 linked
// Checksum 0x39ce220d, Offset: 0x1b8
// Size: 0x140
function private function_70a657d8() {
    if (!is_true(getgametypesetting(#"hash_6143c4e1e18f08fd"))) {
        return;
    }
    clientfield::register("scriptmover", "register_weapon_cache", 1, 1, "int");
    clientfield::register("toplayer", "weapon_cache_ammo_cooldown", 1, 1, "int");
    clientfield::register("toplayer", "weapon_cache_cac_cooldown", 1, 1, "int");
    callback::on_connect(&onplayerconnect);
    level.var_b24258 = &function_b24258;
    level.var_ee39a80e = &function_ee39a80e;
    level.var_f830a9db = &function_f830a9db;
    level.var_50c35573 = [];
}

// Namespace weapon_cache/weapon_cache
// Params 0, eflags: 0x1 linked
// Checksum 0x741164f2, Offset: 0x300
// Size: 0x24
function onplayerconnect() {
    level.var_50c35573[self getentitynumber()] = 1;
}

// Namespace weapon_cache/weapon_cache
// Params 0, eflags: 0x1 linked
// Checksum 0xa79a8135, Offset: 0x330
// Size: 0xe0
function finalize() {
    if (!is_true(getgametypesetting(#"hash_6143c4e1e18f08fd"))) {
        return;
    }
    var_b5f67dff = territory::function_5c7345a3("weapon_cache");
    foreach (var_73b9e48e in var_b5f67dff) {
        var_73b9e48e function_4c6228cd();
    }
}

// Namespace weapon_cache/weapon_cache
// Params 0, eflags: 0x1 linked
// Checksum 0x82f5b2f1, Offset: 0x418
// Size: 0x18a
function function_4c6228cd() {
    usetrigger = spawn("trigger_radius_use", self.origin + (0, 0, 32), 0, 96, 32);
    usetrigger setcursorhint("HINT_INTERACTIVE_PROMPT");
    useobject = gameobjects::create_use_object(#"any", usetrigger, [], (0, 0, 32) * -1, #"weapon_cache", 1, 1, 1, self.angles);
    useobject gameobjects::set_visible(#"hash_5ccfd7bbbf07c770");
    useobject gameobjects::allow_use(#"hash_5ccfd7bbbf07c770");
    useobject.canuseobject = &function_43017839;
    useobject.dontlinkplayertotrigger = 1;
    useobject.keepweapon = 1;
    useobject setmodel(#"p8_fxanim_wz_supply_stash_01_mod");
    useobject clientfield::set("register_weapon_cache", 1);
    self.mdl_gameobject = useobject;
}

// Namespace weapon_cache/weapon_cache
// Params 1, eflags: 0x1 linked
// Checksum 0xce4fde79, Offset: 0x5b0
// Size: 0x23c
function function_692bd0bc(player) {
    primaryweapons = player getweaponslistprimaries();
    givemaxammo = player hasperk(#"specialty_extraammo") || player function_db654c9(player.class_num, #"hash_4a12859000892dda");
    foreach (weapon in primaryweapons) {
        player setweaponammoclip(weapon, player function_b7f1fd2c(weapon));
        if (givemaxammo) {
            player givemaxammo(weapon);
            continue;
        }
        player givestartammo(weapon);
    }
    primaryoffhand = player function_826ed2dd();
    player setweaponammoclip(primaryoffhand, player function_b7f1fd2c(primaryoffhand));
    secondaryoffhand = getweapon(player function_b958b70d(player.class_num, "secondarygrenade"));
    player setweaponammoclip(secondaryoffhand, player function_b7f1fd2c(secondaryoffhand));
    player notify(#"resupply");
    player thread function_f9502d83();
}

// Namespace weapon_cache/weapon_cache
// Params 0, eflags: 0x1 linked
// Checksum 0xdfe9db78, Offset: 0x7f8
// Size: 0xc4
function function_f9502d83() {
    self endon(#"disconnect");
    var_b5f67dff = territory::function_5c7345a3("weapon_cache");
    self clientfield::set_to_player("weapon_cache_ammo_cooldown", 1);
    level.var_50c35573[self getentitynumber()] = 0;
    wait 60;
    self clientfield::set_to_player("weapon_cache_ammo_cooldown", 0);
    level.var_50c35573[self getentitynumber()] = 1;
}

// Namespace weapon_cache/weapon_cache
// Params 1, eflags: 0x5 linked
// Checksum 0x2dc97e41, Offset: 0x8c8
// Size: 0x3e
function private function_43017839(player) {
    if (level.var_50c35573[player getentitynumber()] != 1) {
        return false;
    }
    return true;
}

// Namespace weapon_cache/weapon_cache
// Params 1, eflags: 0x5 linked
// Checksum 0xd9e83320, Offset: 0x910
// Size: 0x2c
function private function_b24258(*eventstruct) {
    self luinotifyevent(#"hash_c893e57629c7648");
}

// Namespace weapon_cache/weapon_cache
// Params 1, eflags: 0x5 linked
// Checksum 0x9593499e, Offset: 0x948
// Size: 0x24
function private function_ee39a80e(*eventstruct) {
    function_692bd0bc(self);
}

// Namespace weapon_cache/weapon_cache
// Params 0, eflags: 0x1 linked
// Checksum 0x63aa0ed1, Offset: 0x978
// Size: 0x4c
function function_f830a9db() {
    self clientfield::set_to_player("weapon_cache_cac_cooldown", 1);
    wait 120;
    self clientfield::set_to_player("weapon_cache_cac_cooldown", 0);
}

