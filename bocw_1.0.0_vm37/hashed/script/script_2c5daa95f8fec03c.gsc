#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;

#namespace namespace_81245006;

// Namespace namespace_81245006/namespace_81245006
// Params 0, eflags: 0x6
// Checksum 0xa4a7ce07, Offset: 0xd0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_130a49b747d3bf82", &preinit, undefined, undefined, undefined);
}

// Namespace namespace_81245006/namespace_81245006
// Params 0, eflags: 0x4
// Checksum 0xe580cb07, Offset: 0x118
// Size: 0xcc
function private preinit() {
    if (!sessionmodeiszombiesgame()) {
        return;
    }
    for (i = 0; i < 4; i++) {
        clientfield::register("actor", "" + #"weakpoint_state" + i, 1, 1, "int");
        clientfield::register("actor", "" + #"weakpoint_fx" + i, 1, 1, "counter");
    }
}

// Namespace namespace_81245006/namespace_81245006
// Params 1, eflags: 0x0
// Checksum 0x194e3dfe, Offset: 0x1f0
// Size: 0x488
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
        var_7c4db75f = structcopy(var_dd54fdb1);
        function_6c64ebd3(var_7c4db75f, 2);
        if (!is_true(var_dd54fdb1.absolutehealth)) {
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
        var_7c4db75f.hitlocs = [];
        if (isdefined(var_dd54fdb1.var_60790e23)) {
            foreach (struct in var_dd54fdb1.var_60790e23) {
                array::add(var_7c4db75f.hitlocs, struct.hitloc);
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
    if (sessionmodeiszombiesgame() && isdefined(var_5ace757d.var_8009bee)) {
        function_bd0bd9f4(entity, var_5ace757d.var_8009bee);
    }
    foreach (var_dd54fdb1 in entity.var_5ace757d) {
        if (is_true(var_dd54fdb1.activebydefault)) {
            function_6c64ebd3(var_dd54fdb1, 1);
        }
    }
}

// Namespace namespace_81245006/namespace_81245006
// Params 2, eflags: 0x0
// Checksum 0x2224cf76, Offset: 0x680
// Size: 0x160
function function_bd0bd9f4(entity, &var_426069a) {
    clientfield_index = 0;
    foreach (var_8cc382e6 in var_426069a) {
        if (!isdefined(var_8cc382e6.var_4aa216c9) || !isdefined(var_8cc382e6.weakpoint)) {
            continue;
        }
        entity.var_5ace757d[var_8cc382e6.weakpoint - 1].var_ee8794bf = "" + #"weakpoint_state" + clientfield_index;
        entity.var_5ace757d[var_8cc382e6.weakpoint - 1].var_98634dc5 = "" + #"weakpoint_fx" + clientfield_index;
        clientfield_index++;
        assert(clientfield_index <= 4, "<dev string:x38>");
    }
}

// Namespace namespace_81245006/namespace_81245006
// Params 1, eflags: 0x0
// Checksum 0x1c8437d, Offset: 0x7e8
// Size: 0xb4
function hasarmor(entity) {
    if (!isdefined(entity.var_5ace757d)) {
        return false;
    }
    foreach (var_dd54fdb1 in entity.var_5ace757d) {
        if (var_dd54fdb1.type === #"armor") {
            return true;
        }
    }
    return false;
}

// Namespace namespace_81245006/namespace_81245006
// Params 3, eflags: 0x0
// Checksum 0x3ea79d7, Offset: 0x8a8
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
            if (isinarray(var_dd54fdb1.hitlocs, hitloc)) {
                return var_dd54fdb1;
            }
        }
    }
}

// Namespace namespace_81245006/namespace_81245006
// Params 3, eflags: 0x0
// Checksum 0xd4e91642, Offset: 0x9a0
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
            if (isdefined(var_dd54fdb1.hitradius)) {
                foreach (hittag in var_dd54fdb1.hittags) {
                    tagorigin = entity gettagorigin(hittag);
                    distsq = distancesquared(point, tagorigin);
                    if (distsq <= sqr(var_dd54fdb1.hitradius) && var_833f593 > distsq) {
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
// Checksum 0x334c1ab0, Offset: 0xb98
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
            if (isdefined(var_dd54fdb1.hitradius)) {
                foreach (hittag in var_dd54fdb1.hittags) {
                    tagorigin = entity gettagorigin(hittag);
                    distsq = distancesquared(point, tagorigin);
                    if (distsq <= sqr(var_dd54fdb1.hitradius)) {
                        return var_dd54fdb1;
                    }
                }
            }
        }
    }
}

// Namespace namespace_81245006/namespace_81245006
// Params 3, eflags: 0x0
// Checksum 0x6581f479, Offset: 0xd58
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
                    iprintlnbold("<dev string:x61>" + bonename);
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
// Params 1, eflags: 0x0
// Checksum 0x588a5591, Offset: 0xf68
// Size: 0x16
function function_fab3ee3e(entity) {
    return entity.var_5ace757d;
}

// Namespace namespace_81245006/namespace_81245006
// Params 2, eflags: 0x0
// Checksum 0x62902e90, Offset: 0xf88
// Size: 0xf4
function damageweakpoint(var_dd54fdb1, damage) {
    var_dd54fdb1.health -= damage;
    if (isactor(self) && isdefined(var_dd54fdb1.var_98634dc5)) {
        self clientfield::increment(var_dd54fdb1.var_98634dc5);
    }
    if (var_dd54fdb1.health <= 0) {
        function_6c64ebd3(var_dd54fdb1, 3);
        if (isdefined(var_dd54fdb1.var_8b732142) && var_dd54fdb1.var_8b732142.currstate == 2) {
            function_6c64ebd3(var_dd54fdb1.var_8b732142, 1);
        }
    }
}

// Namespace namespace_81245006/namespace_81245006
// Params 2, eflags: 0x0
// Checksum 0x8e9c2baf, Offset: 0x1088
// Size: 0x22c
function function_76e239dc(entity, attacker) {
    var_e67ec32 = function_fab3ee3e(entity);
    if (isarray(var_e67ec32)) {
        foreach (var_7092cd34 in var_e67ec32) {
            if (var_7092cd34.type === #"armor" && var_7092cd34.health > 0) {
                damageweakpoint(var_7092cd34, var_7092cd34.health);
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
// Params 2, eflags: 0x0
// Checksum 0x2dbaef12, Offset: 0x12c0
// Size: 0x74
function function_6c64ebd3(var_dd54fdb1, state) {
    if (!isdefined(var_dd54fdb1)) {
        return;
    }
    var_dd54fdb1.currstate = state;
    if (isactor(self) && isdefined(var_dd54fdb1.var_ee8794bf)) {
        self clientfield::set(var_dd54fdb1.var_ee8794bf, state == 1);
    }
}

// Namespace namespace_81245006/namespace_81245006
// Params 1, eflags: 0x0
// Checksum 0x5862639d, Offset: 0x1340
// Size: 0x16
function function_f29756fe(var_dd54fdb1) {
    return var_dd54fdb1.currstate;
}

// Namespace namespace_81245006/namespace_81245006
// Params 1, eflags: 0x0
// Checksum 0xcd0990e7, Offset: 0x1360
// Size: 0x76
function function_26901d33(var_dd54fdb1) {
    if (is_true(var_dd54fdb1.activebydefault)) {
        function_6c64ebd3(var_dd54fdb1, 1);
    } else {
        function_6c64ebd3(var_dd54fdb1, 2);
    }
    var_dd54fdb1.health = var_dd54fdb1.maxhealth;
}

// Namespace namespace_81245006/namespace_81245006
// Params 2, eflags: 0x0
// Checksum 0x9fce23e0, Offset: 0x13e0
// Size: 0x44
function function_6742b846(entity, var_dd54fdb1) {
    if (isdefined(entity.var_5ace757d)) {
        arrayremovevalue(entity.var_5ace757d, var_dd54fdb1, 0);
    }
}

