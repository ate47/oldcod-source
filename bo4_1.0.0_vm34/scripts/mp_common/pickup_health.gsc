#using scripts\abilities\ability_player;
#using scripts\abilities\gadgets\gadget_health_regen;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\system_shared;

#namespace pickup_health;

// Namespace pickup_health/pickup_health
// Params 0, eflags: 0x2
// Checksum 0x82a9bea9, Offset: 0x108
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"pickup_health", &__init__, undefined, #"weapons");
}

// Namespace pickup_health/pickup_health
// Params 0, eflags: 0x4
// Checksum 0xb6205ff7, Offset: 0x158
// Size: 0xde
function private __init__() {
    callback::on_connect(&onconnect);
    callback::on_spawned(&onspawned);
    ability_player::register_gadget_activation_callbacks(23, &onhealthregen, &offhealthregen);
    level.healingdisabled = &offhealthregen;
    level.var_fa78a398 = getgametypesetting(#"hash_712f4c2a96bca56e");
    level.var_6756a75 = getgametypesetting(#"hash_647310a2fe3554f7");
}

// Namespace pickup_health/pickup_health
// Params 0, eflags: 0x0
// Checksum 0x531e4f0c, Offset: 0x240
// Size: 0x24a
function function_d5892da4() {
    var_fbac3d9d = getentarray("pickup_health", "targetname");
    foreach (pickup in var_fbac3d9d) {
        pickup.trigger = spawn("trigger_radius_use", pickup.origin + (0, 0, 15), 0, 120, 100);
        pickup.trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
        pickup.trigger triggerignoreteam();
        pickup.gameobject = gameobjects::create_use_object(#"neutral", pickup.trigger, [], (0, 0, 60), "pickup_health");
        pickup.gameobject gameobjects::set_objective_entity(pickup.gameobject);
        pickup.gameobject gameobjects::set_visible_team(#"any");
        pickup.gameobject gameobjects::allow_use(#"any");
        pickup.gameobject gameobjects::set_use_time(0);
        pickup.gameobject.usecount = 0;
        pickup.gameobject.var_c477841c = pickup;
        pickup.gameobject.onuse = &function_9db42dfa;
    }
}

// Namespace pickup_health/pickup_health
// Params 1, eflags: 0x0
// Checksum 0xc002b14b, Offset: 0x498
// Size: 0x8c
function function_b7e28ea0(num) {
    if (self.pers[#"pickup_health"] < level.var_fa78a398) {
        self.pers[#"pickup_health"] = self.pers[#"pickup_health"] + num;
        self function_1d93fb0f();
        return true;
    }
    return false;
}

// Namespace pickup_health/pickup_health
// Params 0, eflags: 0x4
// Checksum 0x3e31ece2, Offset: 0x530
// Size: 0x3e
function private onconnect() {
    if (!isdefined(self.pers[#"pickup_health"])) {
        self.pers[#"pickup_health"] = 0;
    }
}

// Namespace pickup_health/pickup_health
// Params 0, eflags: 0x4
// Checksum 0x67f3f656, Offset: 0x578
// Size: 0x1c
function private onspawned() {
    self function_533c23df();
}

// Namespace pickup_health/pickup_health
// Params 0, eflags: 0x0
// Checksum 0x26a20d14, Offset: 0x5a0
// Size: 0x1c
function function_533c23df() {
    waitframe(1);
    self function_1d93fb0f();
}

// Namespace pickup_health/pickup_health
// Params 2, eflags: 0x4
// Checksum 0x89fd5ff1, Offset: 0x5c8
// Size: 0x2e
function private onhealthregen(slot, weapon) {
    self.pers[#"pickup_health"]--;
}

// Namespace pickup_health/pickup_health
// Params 2, eflags: 0x4
// Checksum 0x9b9cab59, Offset: 0x600
// Size: 0x4c
function private offhealthregen(slot, weapon) {
    self gadgetdeactivate(self.gadget_health_regen_slot, self.gadget_health_regen_weapon);
    thread healingdone();
}

// Namespace pickup_health/pickup_health
// Params 0, eflags: 0x4
// Checksum 0x9ac8a962, Offset: 0x658
// Size: 0x24
function private healingdone() {
    wait 0.5;
    self function_1d93fb0f();
}

// Namespace pickup_health/pickup_health
// Params 1, eflags: 0x4
// Checksum 0xd84d33ef, Offset: 0x688
// Size: 0x184
function private function_9db42dfa(player) {
    if (isdefined(player) && isplayer(player)) {
        if (player function_b7e28ea0(1)) {
            if (isdefined(self.objectiveid)) {
                objective_setinvisibletoplayer(self.objectiveid, player);
            }
            self.var_c477841c setinvisibletoplayer(player);
            self.trigger setinvisibletoplayer(player);
            player playsoundtoplayer(#"hash_8a4d3f134fa94d7", player);
            self.usecount++;
            player gestures::function_42215dfa(#"gestable_grab", undefined, 0);
        } else {
            player iprintlnbold(#"hash_5a11b7ef0cd7e33b");
            player playsoundtoplayer(#"uin_unavailable_charging", player);
        }
    }
    if (self.usecount >= level.var_f73dd0cd) {
        self.var_c477841c delete();
        self gameobjects::disable_object(1);
    }
}

// Namespace pickup_health/pickup_health
// Params 0, eflags: 0x4
// Checksum 0x553cedee, Offset: 0x818
// Size: 0x15c
function private function_1d93fb0f() {
    if (!isdefined(self) || !isdefined(self.pers[#"pickup_health"])) {
        return;
    }
    if (self.pers[#"pickup_health"] <= 0) {
        self gadget_health_regen::power_off();
        if (isdefined(self.gadget_health_regen_slot)) {
            self function_1d590050(self.gadget_health_regen_slot, 1);
        }
        if (self.pers[#"pickup_health"] < 0) {
            self.pers[#"pickup_health"] = 0;
        }
    } else {
        self gadget_health_regen::power_on();
        if (self.pers[#"pickup_health"] > level.var_fa78a398) {
            self.pers[#"pickup_health"] = level.var_fa78a398;
        }
    }
    self clientfield::set_player_uimodel("hudItems.numHealthPickups", self.pers[#"pickup_health"]);
}

