#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\struct;
#using scripts\mp_common\dynamic_loadout;

#namespace pickup_ammo;

// Namespace pickup_ammo/pickup_ammo
// Params 0, eflags: 0x0
// Checksum 0xc76a6072, Offset: 0xe8
// Size: 0x24a
function function_63593f88() {
    pickup_ammos = getentarray("pickup_ammo", "targetname");
    foreach (pickup in pickup_ammos) {
        pickup.trigger = spawn("trigger_radius_use", pickup.origin + (0, 0, 15), 0, 120, 100);
        pickup.trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
        pickup.trigger triggerignoreteam();
        pickup.gameobject = gameobjects::create_use_object(#"neutral", pickup.trigger, [], (0, 0, 60), "pickup_ammo");
        pickup.gameobject gameobjects::set_objective_entity(pickup.gameobject);
        pickup.gameobject gameobjects::set_visible_team(#"any");
        pickup.gameobject gameobjects::allow_use(#"any");
        pickup.gameobject gameobjects::set_use_time(0);
        pickup.gameobject.usecount = 0;
        pickup.gameobject.var_c477841c = pickup;
        pickup.gameobject.onuse = &function_9db42dfa;
    }
}

// Namespace pickup_ammo/pickup_ammo
// Params 1, eflags: 0x0
// Checksum 0xaf0d6e4c, Offset: 0x340
// Size: 0x350
function function_c2ff9414(weapon) {
    package = struct::get_script_bundle("bountyhunterpackage", level.bountypackagelist[0]);
    slot = undefined;
    if (isdefined(self.pers[#"dynamic_loadout"].weapons[0]) && self.pers[#"dynamic_loadout"].weapons[0].name == weapon.name) {
        slot = 0;
    } else if (isdefined(self.pers[#"dynamic_loadout"].weapons[1]) && self.pers[#"dynamic_loadout"].weapons[1].name == weapon.name) {
        slot = 1;
    }
    if (!isdefined(slot)) {
        return false;
    }
    weapindex = self.pers[#"dynamic_loadout"].clientfields[slot].val - 1;
    package = struct::get_script_bundle("bountyhunterpackage", level.bountypackagelist[weapindex]);
    var_73710ff4 = package.var_674f5ce9;
    maxammo = package.refillammo;
    if (!isdefined(maxammo) || maxammo == 0) {
        maxammo = weapon.maxammo / weapon.clipsize;
    }
    clipammo = self getweaponammoclip(weapon);
    stockammo = self getweaponammostock(weapon);
    currentammo = float(clipammo + stockammo) / weapon.clipsize;
    if (weapon.statname == #"smg_capacity_t8" && weaponhasattachment(weapon, "uber")) {
        self setweaponammostock(weapon, weapon.clipsize);
    } else {
        if (currentammo >= maxammo) {
            return false;
        }
        currentammo += var_73710ff4;
        if (currentammo > maxammo) {
            currentammo = maxammo;
        }
        self setweaponammostock(weapon, int(currentammo * weapon.clipsize) - clipammo);
    }
    return true;
}

// Namespace pickup_ammo/pickup_ammo
// Params 1, eflags: 0x4
// Checksum 0x22d49766, Offset: 0x698
// Size: 0x234
function private function_9db42dfa(player) {
    if (isdefined(player) && isplayer(player)) {
        var_7a632912 = 0;
        primaries = player getweaponslistprimaries();
        foreach (weapon in primaries) {
            ammogiven = player function_c2ff9414(weapon);
            if (ammogiven) {
                var_7a632912 = 1;
            }
        }
        if (var_7a632912) {
            if (isdefined(self.objectiveid)) {
                objective_setinvisibletoplayer(self.objectiveid, player);
            }
            self.var_c477841c setinvisibletoplayer(player);
            self.trigger setinvisibletoplayer(player);
            self playsoundtoplayer(#"hash_587fec4cf4ba3ebb", player);
            self.usecount++;
            player gestures::function_42215dfa(#"gestable_grab", undefined, 0);
        } else {
            player iprintlnbold(#"hash_2ea29b19d0e205e7");
            self playsoundtoplayer(#"uin_unavailable_charging", player);
        }
    }
    if (self.usecount >= level.var_f73dd0cd) {
        self.var_c477841c delete();
        self gameobjects::disable_object(1);
    }
}

