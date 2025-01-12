#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\scoreevents_shared;

#namespace namespace_81245006;

// Namespace namespace_81245006/namespace_81245006
// Params 1, eflags: 0x1 linked
// Checksum 0xa9e39c5a, Offset: 0xa0
// Size: 0x3b6
function initweakpoints(entity) {
    var_97e1b97d = function_768b9c03(self.aitype);
    if (!isdefined(var_97e1b97d)) {
        return;
    }
    var_5ace757d = getscriptbundle(var_97e1b97d);
    if (!isdefined(var_5ace757d) || !isdefined(var_5ace757d.weakpoints)) {
        return;
    }
    entity.var_5ace757d = [];
    foreach (var_dd54fdb1 in var_5ace757d.weakpoints) {
        var_7c4db75f = function_2e532eed(var_dd54fdb1);
        var_7c4db75f.currstate = 2;
        if (is_true(var_dd54fdb1.activebydefault)) {
            var_7c4db75f.currstate = 1;
        }
        if (!is_true(var_dd54fdb1.var_5a93cd2e)) {
            var_7c4db75f.health = var_dd54fdb1.health * entity.health;
        } else {
            var_7c4db75f.health = var_dd54fdb1.health;
        }
        var_7c4db75f.maxhealth = var_7c4db75f.health;
        var_7c4db75f.hittags = [];
        if (isdefined(var_dd54fdb1.var_51e8b151)) {
            array::add(var_7c4db75f.hittags, var_dd54fdb1.var_51e8b151);
        }
        if (isdefined(var_dd54fdb1.var_910e2f9b)) {
            array::add(var_7c4db75f.hittags, var_dd54fdb1.var_910e2f9b);
        }
        var_7c4db75f.var_51e8b151 = undefined;
        var_7c4db75f.var_910e2f9b = undefined;
        var_7c4db75f.var_3d2f9bf0 = [];
        if (isdefined(var_dd54fdb1.var_60790e23)) {
            foreach (struct in var_dd54fdb1.var_60790e23) {
                array::add(var_7c4db75f.var_3d2f9bf0, struct.hitloc);
            }
        }
        var_7c4db75f.var_60790e23 = undefined;
        if (isdefined(var_7c4db75f.var_8b732142)) {
            var_7c4db75f.var_8b732142 -= 1;
        }
        array::add(entity.var_5ace757d, var_7c4db75f);
    }
    foreach (var_dd54fdb1 in entity.var_5ace757d) {
        if (isdefined(var_dd54fdb1.var_8b732142)) {
            var_dd54fdb1.var_8b732142 = entity.var_5ace757d[var_dd54fdb1.var_8b732142];
        }
    }
}

// Namespace namespace_81245006/namespace_81245006
// Params 3, eflags: 0x1 linked
// Checksum 0xb8fa8f58, Offset: 0x460
// Size: 0xf0
function function_3131f5dd(entity, hitloc, weakpointstate) {
    if (!isdefined(hitloc)) {
        return undefined;
    }
    if (isdefined(entity.var_5ace757d)) {
        foreach (var_dd54fdb1 in entity.var_5ace757d) {
            if (isdefined(weakpointstate) && var_dd54fdb1.currstate !== weakpointstate) {
                continue;
            }
            if (isinarray(var_dd54fdb1.var_3d2f9bf0, hitloc)) {
                return var_dd54fdb1;
            }
        }
    }
}

// Namespace namespace_81245006/namespace_81245006
// Params 3, eflags: 0x1 linked
// Checksum 0x2e867617, Offset: 0x558
// Size: 0x1f0
function function_73ab4754(entity, point, weakpointstate) {
    if (!isdefined(point)) {
        return undefined;
    }
    if (isdefined(entity.var_5ace757d)) {
        var_e2b4fa2b = undefined;
        var_833f593 = 2147483647;
        foreach (var_dd54fdb1 in entity.var_5ace757d) {
            if (isdefined(weakpointstate) && var_dd54fdb1.currstate !== weakpointstate) {
                continue;
            }
            if (isdefined(var_dd54fdb1.var_b7fbe51b)) {
                foreach (hittag in var_dd54fdb1.hittags) {
                    tagorigin = entity gettagorigin(hittag);
                    distsq = distancesquared(point, tagorigin);
                    if (distsq <= function_a3f6cdac(var_dd54fdb1.var_b7fbe51b) && var_833f593 > distsq) {
                        var_e2b4fa2b = var_dd54fdb1;
                        var_833f593 = distsq;
                    }
                }
            }
        }
    }
    return var_e2b4fa2b;
}

// Namespace namespace_81245006/namespace_81245006
// Params 3, eflags: 0x0
// Checksum 0x2401297b, Offset: 0x750
// Size: 0x1b6
function function_6bb685f0(entity, point, weakpointstate) {
    if (!isdefined(point)) {
        return undefined;
    }
    if (isdefined(entity.var_5ace757d)) {
        foreach (var_dd54fdb1 in entity.var_5ace757d) {
            if (isdefined(weakpointstate) && var_dd54fdb1.currstate !== weakpointstate) {
                continue;
            }
            if (isdefined(var_dd54fdb1.var_b7fbe51b)) {
                foreach (hittag in var_dd54fdb1.hittags) {
                    tagorigin = entity gettagorigin(hittag);
                    distsq = distancesquared(point, tagorigin);
                    if (distsq <= function_a3f6cdac(var_dd54fdb1.var_b7fbe51b)) {
                        return var_dd54fdb1;
                    }
                }
            }
        }
    }
}

// Namespace namespace_81245006/namespace_81245006
// Params 3, eflags: 0x1 linked
// Checksum 0x78cc9533, Offset: 0x910
// Size: 0x208
function function_37e3f011(entity, bone, weakpointstate) {
    if (!isdefined(entity)) {
        return undefined;
    }
    if (isdefined(bone) && !isstring(bone)) {
        bonename = getpartname(entity, bone);
    } else {
        bonename = bone;
    }
    if (isdefined(bonename) && isdefined(entity.var_5ace757d)) {
        /#
            if (getdvarint(#"scr_weakpoint_debug", 0) > 0) {
                if (!isstring(bone)) {
                    iprintlnbold("<dev string:x38>" + bonename);
                }
            }
        #/
        foreach (var_dd54fdb1 in entity.var_5ace757d) {
            if (isdefined(weakpointstate) && var_dd54fdb1.currstate !== weakpointstate) {
                continue;
            }
            foreach (hittag in var_dd54fdb1.hittags) {
                if (hittag == bonename) {
                    return var_dd54fdb1;
                }
            }
        }
    }
    return undefined;
}

// Namespace namespace_81245006/namespace_81245006
// Params 1, eflags: 0x1 linked
// Checksum 0x43cc08e1, Offset: 0xb20
// Size: 0x16
function function_fab3ee3e(entity) {
    return entity.var_5ace757d;
}

// Namespace namespace_81245006/namespace_81245006
// Params 2, eflags: 0x1 linked
// Checksum 0x3eb142e1, Offset: 0xb40
// Size: 0x94
function function_ef87b7e8(var_dd54fdb1, damage) {
    var_dd54fdb1.health -= damage;
    if (var_dd54fdb1.health <= 0) {
        var_dd54fdb1.currstate = 3;
        if (isdefined(var_dd54fdb1.var_8b732142) && var_dd54fdb1.var_8b732142.currstate == 2) {
            function_6c64ebd3(var_dd54fdb1.var_8b732142, 1);
        }
    }
}

// Namespace namespace_81245006/namespace_81245006
// Params 2, eflags: 0x1 linked
// Checksum 0x8536e462, Offset: 0xbe0
// Size: 0x22c
function function_76e239dc(entity, attacker) {
    var_e67ec32 = function_fab3ee3e(entity);
    if (isarray(var_e67ec32)) {
        foreach (var_7092cd34 in var_e67ec32) {
            if (var_7092cd34.type === #"armor" && var_7092cd34.health > 0) {
                function_ef87b7e8(var_7092cd34, var_7092cd34.health);
                if (isdefined(var_7092cd34.var_f371ebb0)) {
                    destructserverutils::function_8475c53a(entity, var_7092cd34.var_f371ebb0);
                    entity.var_426947c4 = 1;
                    entity.var_67f98db0 = 1;
                    if (isdefined(level.var_887c77a4) && isplayer(attacker)) {
                        if (sessionmodeiszombiesgame()) {
                            level scoreevents::doscoreeventcallback("scoreEventZM", {#attacker:attacker, #scoreevent:level.var_887c77a4});
                        }
                    }
                    if (var_7092cd34.var_f371ebb0 === "body_armor") {
                        callback::callback(#"hash_7d67d0e9046494fb");
                    }
                }
            }
        }
        entity function_2d4173a8(0);
    }
}

// Namespace namespace_81245006/namespace_81245006
// Params 2, eflags: 0x1 linked
// Checksum 0x6d9797ff, Offset: 0xe18
// Size: 0x22
function function_6c64ebd3(var_dd54fdb1, state) {
    var_dd54fdb1.currstate = state;
}

// Namespace namespace_81245006/namespace_81245006
// Params 1, eflags: 0x1 linked
// Checksum 0xd27d4dec, Offset: 0xe48
// Size: 0x16
function function_f29756fe(var_dd54fdb1) {
    return var_dd54fdb1.currstate;
}

// Namespace namespace_81245006/namespace_81245006
// Params 1, eflags: 0x0
// Checksum 0xf3cdad6a, Offset: 0xe68
// Size: 0x52
function function_26901d33(var_dd54fdb1) {
    var_dd54fdb1.currstate = 2;
    if (is_true(var_dd54fdb1.activebydefault)) {
        var_dd54fdb1.currstate = 1;
    }
    var_dd54fdb1.health = var_dd54fdb1.maxhealth;
}

// Namespace namespace_81245006/namespace_81245006
// Params 2, eflags: 0x0
// Checksum 0x73f07ed0, Offset: 0xec8
// Size: 0x44
function function_6742b846(entity, var_dd54fdb1) {
    if (isdefined(entity.var_5ace757d)) {
        arrayremovevalue(entity.var_5ace757d, var_dd54fdb1, 0);
    }
}

