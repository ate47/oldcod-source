#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\item_drop;

#namespace gadget_cymbal_monkey;

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 0, eflags: 0x2
// Checksum 0x398ef801, Offset: 0xc8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"cymbal_monkey", &__init__, &__main__, undefined);
}

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 0, eflags: 0x4
// Checksum 0x4b6cec14, Offset: 0x118
// Size: 0x2c
function private __init__() {
    level.var_573faa47 = [];
    level thread function_40bce3d5();
}

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 0, eflags: 0x4
// Checksum 0xc00070c4, Offset: 0x150
// Size: 0x32
function private __main__() {
    level._effect[#"monkey_glow"] = #"zm_weapons/fx8_cymbal_monkey_light";
}

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 0, eflags: 0x4
// Checksum 0x3c983344, Offset: 0x190
// Size: 0x140
function private function_40bce3d5() {
    level endon(#"game_ended");
    var_5822d117 = 250;
    while (true) {
        for (i = 0; i < level.var_573faa47.size; i++) {
            monkey = level.var_573faa47[i];
            if (!isdefined(monkey) || isdefined(monkey.fuse_lit) && monkey.fuse_lit) {
                continue;
            }
            if (!isdefined(monkey.var_be5cf48d)) {
                monkey delete();
                continue;
            }
            if (function_46dfd5b7(monkey, var_5822d117)) {
                monkey thread function_6cb7c577();
            }
            waitframe(1);
        }
        level.var_573faa47 = array::remove_undefined(level.var_573faa47);
        waitframe(1);
    }
}

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 2, eflags: 0x4
// Checksum 0x70fba7a6, Offset: 0x2d8
// Size: 0x17a
function private function_46dfd5b7(monkey, radius) {
    nearby_players = getentitiesinradius(monkey.origin, radius, 1);
    foreach (player in nearby_players) {
        if (function_ab52e858(monkey, player)) {
            return true;
        }
    }
    var_5711b349 = getentitiesinradius(monkey.origin, radius, 15);
    foreach (actor in var_5711b349) {
        if (function_ab52e858(monkey, actor)) {
            return true;
        }
    }
    return false;
}

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 2, eflags: 0x4
// Checksum 0xb3b9d778, Offset: 0x460
// Size: 0xba
function private function_ab52e858(monkey, ent) {
    if (!isdefined(ent)) {
        return false;
    }
    if (isplayer(ent) && ent.team != monkey.team) {
        return true;
    }
    if (isactor(ent) && ent.archetype == "zombie" && ent.team != monkey.team) {
        return true;
    }
    return false;
}

// Namespace gadget_cymbal_monkey/grenade_fire
// Params 1, eflags: 0x44
// Checksum 0x6459d835, Offset: 0x528
// Size: 0x20c
function private event_handler[grenade_fire] function_649f6cc1(eventstruct) {
    if (eventstruct.weapon.name == #"cymbal_monkey") {
        e_grenade = eventstruct.projectile;
        e_grenade ghost();
        e_grenade.angles = self.angles;
        mdl_monkey = util::spawn_model(e_grenade.model, e_grenade.origin, e_grenade.angles);
        e_grenade.mdl_monkey = mdl_monkey;
        e_grenade.mdl_monkey linkto(e_grenade);
        e_grenade.mdl_monkey.var_be5cf48d = e_grenade;
        e_grenade.mdl_monkey.team = e_grenade.team;
        e_grenade.mdl_monkey clientfield::set("enemyequip", 1);
        e_grenade waittill(#"stationary", #"death");
        if (!isdefined(e_grenade) && isdefined(mdl_monkey)) {
            mdl_monkey delete();
        }
        if (isdefined(e_grenade) && isdefined(e_grenade.mdl_monkey)) {
            e_grenade.mdl_monkey.var_b7cd1dda = getclosestpointonnavmesh(e_grenade.mdl_monkey.origin, 360, 15.1875);
            array::add(level.var_573faa47, e_grenade.mdl_monkey);
        }
    }
}

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 0, eflags: 0x4
// Checksum 0x146e5640, Offset: 0x740
// Size: 0x154
function private function_6cb7c577() {
    self endon(#"death");
    item_drop::function_76bdc4bd(self);
    self.fuse_lit = 1;
    self unlink();
    self playsound(#"hash_4509539f9e7954e2");
    playfxontag(level._effect[#"monkey_glow"], self, "tag_weapon");
    self thread scene::play(#"cin_t8_monkeybomb_dance", self);
    self thread util::delay(6.5, "death", &function_1f899b08);
    var_837a47d0 = gettime() + int(8 * 1000);
    while (gettime() < var_837a47d0) {
        if (!isdefined(self.var_be5cf48d)) {
            break;
        }
        waitframe(1);
    }
    self function_f3ad05bf();
}

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 0, eflags: 0x0
// Checksum 0x4cdc5f69, Offset: 0x8a0
// Size: 0x24
function function_1f899b08() {
    self playsound(#"zmb_vox_monkey_explode");
}

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 0, eflags: 0x0
// Checksum 0x97b0e997, Offset: 0x8d0
// Size: 0x6c
function function_f3ad05bf() {
    if (isdefined(self.var_be5cf48d)) {
        playsoundatposition(#"wpn_claymore_alert", self.origin);
        self.var_be5cf48d detonate();
    }
    self delete();
}

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 1, eflags: 0x0
// Checksum 0xf38073a1, Offset: 0x948
// Size: 0x144
function function_5a3f7c0d(zombie) {
    var_cfc5fa2c = 360 * 360;
    var_9fcdd049 = undefined;
    best_monkey = undefined;
    foreach (monkey in level.var_573faa47) {
        if (!isdefined(monkey)) {
            continue;
        }
        dist_sq = distancesquared(zombie.origin, monkey.origin);
        if (isdefined(monkey) && isdefined(monkey.fuse_lit) && monkey.fuse_lit && dist_sq < var_cfc5fa2c) {
            if (!isdefined(var_9fcdd049) || dist_sq < var_9fcdd049) {
                var_9fcdd049 = dist_sq;
                best_monkey = monkey;
            }
        }
    }
    return best_monkey;
}

