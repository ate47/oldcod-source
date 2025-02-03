#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\territory_util;
#using scripts\core_common\util_shared;

#namespace weapon_cache;

// Namespace weapon_cache/weapon_cache
// Params 0, eflags: 0x6
// Checksum 0x95b75cfb, Offset: 0x180
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"weapon_cache", &preinit, undefined, &finalize, undefined);
}

// Namespace weapon_cache/weapon_cache
// Params 0, eflags: 0x4
// Checksum 0xba882735, Offset: 0x1d0
// Size: 0x114
function private preinit() {
    if (!is_true(getgametypesetting(#"hash_6143c4e1e18f08fd"))) {
        return;
    }
    clientfield::register("scriptmover", "register_weapon_cache", 1, 1, "int");
    clientfield::register("toplayer", "weapon_cache_ammo_cooldown", 1, 1, "int");
    clientfield::register("toplayer", "weapon_cache_cac_cooldown", 1, 1, "int");
    level.var_b24258 = &function_b24258;
    level.var_ee39a80e = &function_ee39a80e;
    level.var_f830a9db = &function_f830a9db;
}

// Namespace weapon_cache/weapon_cache
// Params 0, eflags: 0x0
// Checksum 0xd9e04fa3, Offset: 0x2f0
// Size: 0xf0
function finalize() {
    if (!is_true(getgametypesetting(#"hash_6143c4e1e18f08fd"))) {
        return;
    }
    level.var_b5f67dff = territory::function_5c7345a3("weapon_cache");
    foreach (var_73b9e48e in level.var_b5f67dff) {
        var_73b9e48e.var_331b8fa4 = 0;
        var_73b9e48e function_4c6228cd();
    }
}

// Namespace weapon_cache/weapon_cache
// Params 0, eflags: 0x0
// Checksum 0x5da0916c, Offset: 0x3e8
// Size: 0x152
function function_4c6228cd() {
    usetrigger = spawn("trigger_radius_use", self.origin + (0, 0, 32), 0, 96, 32);
    usetrigger setcursorhint("HINT_INTERACTIVE_PROMPT");
    function_dae4ab9b(usetrigger, 0.5);
    useobject = util::spawn_model(#"hash_334445b2169a33a9", self.origin, self.angles);
    useobject.objectiveid = gameobjects::get_next_obj_id();
    objective_add(useobject.objectiveid, "active", useobject, #"weapon_cache");
    useobject clientfield::set("register_weapon_cache", 1);
    useobject disconnectpaths();
    self.entity = useobject;
}

// Namespace weapon_cache/weapon_cache
// Params 1, eflags: 0x0
// Checksum 0x728ac0ae, Offset: 0x548
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
// Params 0, eflags: 0x0
// Checksum 0xe4f03dd2, Offset: 0x790
// Size: 0x94
function function_f9502d83() {
    self endon(#"disconnect");
    var_b5f67dff = territory::function_5c7345a3("weapon_cache");
    self clientfield::set_to_player("weapon_cache_ammo_cooldown", 1);
    self waittilltimeout(60, #"death");
    self clientfield::set_to_player("weapon_cache_ammo_cooldown", 0);
}

// Namespace weapon_cache/weapon_cache
// Params 1, eflags: 0x4
// Checksum 0xb0ddf3cf, Offset: 0x830
// Size: 0x2c
function private function_b24258(*eventstruct) {
    self luinotifyevent(#"hash_c893e57629c7648");
}

// Namespace weapon_cache/weapon_cache
// Params 1, eflags: 0x4
// Checksum 0xf082131a, Offset: 0x868
// Size: 0x24
function private function_ee39a80e(*eventstruct) {
    function_692bd0bc(self);
}

// Namespace weapon_cache/weapon_cache
// Params 0, eflags: 0x0
// Checksum 0x72588900, Offset: 0x898
// Size: 0x84
function function_f830a9db() {
    self endon(#"disconnect");
    self clientfield::set_to_player("weapon_cache_cac_cooldown", 1);
    self notify(#"hash_2bc8de932f7212e7");
    self waittilltimeout(120, #"death");
    self clientfield::set_to_player("weapon_cache_cac_cooldown", 0);
}

// Namespace weapon_cache/weapon_cache
// Params 0, eflags: 0x4
// Checksum 0xaf68004a, Offset: 0x928
// Size: 0x34
function private function_6f438290() {
    var_8794b467 = arraysortclosest(level.var_b5f67dff, self.origin);
    return var_8794b467[0];
}

// Namespace weapon_cache/weapon_cache
// Params 0, eflags: 0x4
// Checksum 0x2f363848, Offset: 0x968
// Size: 0x7c
function private function_74547745() {
    var_73b9e48e = self function_6f438290();
    if (!isdefined(var_73b9e48e)) {
        return;
    }
    var_73b9e48e function_4ac19c4f();
    self waittill(#"death", #"hash_2bc8de932f7212e7");
    var_73b9e48e function_70db7bab();
}

// Namespace weapon_cache/weapon_cache
// Params 0, eflags: 0x4
// Checksum 0xb7976d61, Offset: 0x9f0
// Size: 0x5c
function private function_2909dca6() {
    var_73b9e48e = self function_6f438290();
    if (!isdefined(var_73b9e48e)) {
        return;
    }
    var_73b9e48e function_4ac19c4f();
    wait 1;
    var_73b9e48e function_70db7bab();
}

// Namespace weapon_cache/weapon_cache
// Params 0, eflags: 0x4
// Checksum 0x324c444d, Offset: 0xa58
// Size: 0x60
function private function_4ac19c4f() {
    if (!self.var_331b8fa4 && isdefined(self.entity)) {
        self.entity thread scene::play(#"hash_799443f473bbceda", "open", self.entity);
    }
    self.var_331b8fa4++;
}

// Namespace weapon_cache/weapon_cache
// Params 0, eflags: 0x4
// Checksum 0x77421a16, Offset: 0xac0
// Size: 0x6c
function private function_70db7bab() {
    if (self.var_331b8fa4 && isdefined(self.entity)) {
        self.var_331b8fa4--;
        if (!self.var_331b8fa4) {
            self.entity thread scene::play(#"hash_799443f473bbceda", "close", self.entity);
        }
    }
}

