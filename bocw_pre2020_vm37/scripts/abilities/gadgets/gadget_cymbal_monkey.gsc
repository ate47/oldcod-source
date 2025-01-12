#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace gadget_cymbal_monkey;

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 0, eflags: 0x6
// Checksum 0x8197d124, Offset: 0xc0
// Size: 0x54
function private autoexec __init__system__() {
    system::register(#"cymbal_monkey", &function_70a657d8, &postinit, &finalize, undefined);
}

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 0, eflags: 0x5 linked
// Checksum 0xa5843bde, Offset: 0x120
// Size: 0x3c
function private function_70a657d8() {
    level.var_7d95e1ed = [];
    level.var_7c5c96dc = &function_4f90c4c2;
    level thread function_a23699fe();
}

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 0, eflags: 0x5 linked
// Checksum 0x2004df9d, Offset: 0x168
// Size: 0x2c
function private postinit() {
    level._effect[#"monkey_glow"] = #"hash_5d0dd3293cfdb3dd";
}

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 0, eflags: 0x5 linked
// Checksum 0x67726d64, Offset: 0x1a0
// Size: 0x50
function private finalize() {
    if (isdefined(level.var_a5dacbea)) {
        [[ level.var_a5dacbea ]](getweapon(#"cymbal_monkey"), &function_127fb8f3);
    }
}

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 0, eflags: 0x5 linked
// Checksum 0xe40c9398, Offset: 0x1f8
// Size: 0x10e
function private function_a23699fe() {
    level endon(#"game_ended");
    var_cf4e80a7 = 250;
    while (true) {
        for (i = 0; i < level.var_7d95e1ed.size; i++) {
            monkey = level.var_7d95e1ed[i];
            if (!isdefined(monkey) || is_true(monkey.fuse_lit)) {
                continue;
            }
            if (!isdefined(monkey.var_38af96b9)) {
                monkey delete();
                continue;
            }
            monkey thread function_b9934c1d();
            waitframe(1);
        }
        arrayremovevalue(level.var_7d95e1ed, undefined);
        waitframe(1);
    }
}

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 2, eflags: 0x4
// Checksum 0x90a2a2b4, Offset: 0x310
// Size: 0x182
function private function_7e60533f(monkey, radius) {
    nearby_players = getentitiesinradius(monkey.origin, radius, 1);
    foreach (player in nearby_players) {
        if (function_17c51c94(monkey, player)) {
            return true;
        }
    }
    var_b1de6a06 = getentitiesinradius(monkey.origin, radius, 15);
    foreach (actor in var_b1de6a06) {
        if (function_17c51c94(monkey, actor)) {
            return true;
        }
    }
    return false;
}

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 2, eflags: 0x5 linked
// Checksum 0xa70478c6, Offset: 0x4a0
// Size: 0xc8
function private function_17c51c94(monkey, ent) {
    if (!isdefined(ent)) {
        return false;
    }
    if (isplayer(ent) && util::function_fbce7263(ent.team, monkey.team)) {
        return true;
    }
    if (isactor(ent) && ent.archetype == "zombie" && util::function_fbce7263(ent.team, monkey.team)) {
        return true;
    }
    return false;
}

// Namespace gadget_cymbal_monkey/grenade_fire
// Params 1, eflags: 0x44
// Checksum 0x8028bea3, Offset: 0x570
// Size: 0x21c
function private event_handler[grenade_fire] function_4776caf4(eventstruct) {
    if (eventstruct.weapon.name == #"cymbal_monkey" && !isdefined(level.var_3c9fec21)) {
        e_grenade = eventstruct.projectile;
        e_grenade ghost();
        e_grenade.angles = self.angles;
        var_bdd70f6a = util::spawn_model(e_grenade.model, e_grenade.origin, e_grenade.angles);
        e_grenade.var_bdd70f6a = var_bdd70f6a;
        e_grenade.var_bdd70f6a linkto(e_grenade);
        e_grenade.var_bdd70f6a.var_38af96b9 = e_grenade;
        e_grenade.var_bdd70f6a.team = e_grenade.team;
        e_grenade.var_bdd70f6a clientfield::set("enemyequip", 1);
        e_grenade waittill(#"stationary", #"death");
        if (!isdefined(e_grenade) && isdefined(var_bdd70f6a)) {
            var_bdd70f6a delete();
        }
        if (isdefined(self) && isdefined(e_grenade) && isdefined(e_grenade.var_bdd70f6a)) {
            e_grenade.var_bdd70f6a.var_acdc8d71 = getclosestpointonnavmesh(e_grenade.var_bdd70f6a.origin, 720, 15.1875);
            array::add(level.var_7d95e1ed, e_grenade.var_bdd70f6a);
            self callback::callback(#"hash_3c09ead7e9d8a968", e_grenade.var_bdd70f6a);
        }
    }
}

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 0, eflags: 0x1 linked
// Checksum 0x635c26d8, Offset: 0x798
// Size: 0x16c
function function_b9934c1d() {
    self endon(#"death");
    if (isdefined(level.var_2746aef8)) {
        [[ level.var_2746aef8 ]](self);
    }
    self unlink();
    self.fuse_lit = 1;
    self playsound(#"hash_4509539f9e7954e2");
    playfxontag(level._effect[#"monkey_glow"], self, "tag_weapon");
    self thread scene::play(#"cin_t8_monkeybomb_dance", self);
    self thread util::delay(6.5, "death", &function_4e61e1d);
    var_de3026af = gettime() + int(8 * 1000);
    while (gettime() < var_de3026af) {
        if (!isdefined(self.var_38af96b9)) {
            break;
        }
        waitframe(1);
    }
    self function_4f90c4c2();
}

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 0, eflags: 0x1 linked
// Checksum 0x91356107, Offset: 0x910
// Size: 0x24
function function_4e61e1d() {
    self playsound(#"zmb_vox_monkey_explode");
}

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 0, eflags: 0x1 linked
// Checksum 0xc41f22a4, Offset: 0x940
// Size: 0x8c
function function_4f90c4c2() {
    if (isdefined(self.var_38af96b9)) {
        self callback::callback(#"hash_6aa0232dd3c8376a");
        playsoundatposition(#"wpn_claymore_alert", self.origin);
        self.var_38af96b9 detonate();
    }
    self delete();
}

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 1, eflags: 0x1 linked
// Checksum 0xbbeeeff7, Offset: 0x9d8
// Size: 0x152
function function_4a5dff80(zombie) {
    var_2d9e38fc = function_a3f6cdac(720);
    var_128c12c9 = undefined;
    best_monkey = undefined;
    foreach (monkey in level.var_7d95e1ed) {
        if (!isdefined(monkey)) {
            continue;
        }
        dist_sq = distancesquared(zombie.origin, monkey.origin);
        if (isdefined(monkey) && is_true(monkey.fuse_lit) && dist_sq < var_2d9e38fc) {
            if (!isdefined(var_128c12c9) || dist_sq < var_128c12c9) {
                var_128c12c9 = dist_sq;
                best_monkey = monkey;
            }
        }
    }
    return best_monkey;
}

// Namespace gadget_cymbal_monkey/gadget_cymbal_monkey
// Params 2, eflags: 0x1 linked
// Checksum 0x94f5b172, Offset: 0xb38
// Size: 0x11c
function function_127fb8f3(cymbal_monkey, *attackingplayer) {
    attackingplayer endon(#"death");
    randangle = randomfloat(360);
    if (isdefined(level._equipment_emp_destroy_fx)) {
        playfx(level._equipment_emp_destroy_fx, attackingplayer.origin + (0, 0, 5), (cos(randangle), sin(randangle), 0), anglestoup(attackingplayer.angles));
    }
    wait 1.1;
    playfx(#"hash_65c5042becfbaa7d", attackingplayer.origin);
    attackingplayer function_4f90c4c2();
}

