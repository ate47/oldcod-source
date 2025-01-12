#using scripts\core_common\array_shared;

#namespace namespace_9088c704;

// Namespace namespace_9088c704/namespace_9088c704
// Params 2, eflags: 0x0
// Checksum 0xc998981e, Offset: 0x70
// Size: 0x240
function initweakpoints(entity, var_8d9757a1) {
    var_c40aa8c8 = getscriptbundle(var_8d9757a1);
    if (!isdefined(var_c40aa8c8) || !isdefined(var_c40aa8c8.weakpoints)) {
        return;
    }
    entity.var_c40aa8c8 = [];
    foreach (var_216599c5 in var_c40aa8c8.weakpoints) {
        var_c5e302ee = structcopy(var_216599c5);
        var_c5e302ee.currstate = 2;
        if (isdefined(var_216599c5.activebydefault) && var_216599c5.activebydefault) {
            var_c5e302ee.currstate = 1;
        }
        if (!(isdefined(var_216599c5.absolutehealth) && var_216599c5.absolutehealth)) {
            var_c5e302ee.health = var_216599c5.health * entity.health;
        } else {
            var_c5e302ee.health = var_216599c5.health;
        }
        var_c5e302ee.maxhealth = var_c5e302ee.health;
        var_c5e302ee.hittags = [];
        if (isdefined(var_216599c5.var_778c0469)) {
            array::add(var_c5e302ee.hittags, var_216599c5.var_778c0469);
        }
        if (isdefined(var_216599c5.var_9d8e7ed2)) {
            array::add(var_c5e302ee.hittags, var_216599c5.var_9d8e7ed2);
        }
        array::add(entity.var_c40aa8c8, var_c5e302ee);
    }
}

// Namespace namespace_9088c704/namespace_9088c704
// Params 3, eflags: 0x0
// Checksum 0x890f25cb, Offset: 0x2b8
// Size: 0xda
function function_abe2d1e7(entity, hitloc, weakpointstate) {
    if (!isdefined(hitloc)) {
        return undefined;
    }
    if (isdefined(entity.var_c40aa8c8)) {
        foreach (var_216599c5 in entity.var_c40aa8c8) {
            if (isdefined(weakpointstate) && var_216599c5.currstate !== weakpointstate) {
                continue;
            }
            if (var_216599c5.hitloc === hitloc) {
                return var_216599c5;
            }
        }
    }
}

// Namespace namespace_9088c704/namespace_9088c704
// Params 3, eflags: 0x0
// Checksum 0xa412c7e3, Offset: 0x3a0
// Size: 0x1e6
function function_4ef61202(entity, point, weakpointstate) {
    if (!isdefined(point)) {
        return undefined;
    }
    if (isdefined(entity.var_c40aa8c8)) {
        var_6a87651 = undefined;
        var_dac631a7 = 2147483647;
        foreach (var_216599c5 in entity.var_c40aa8c8) {
            if (isdefined(weakpointstate) && var_216599c5.currstate !== weakpointstate) {
                continue;
            }
            if (isdefined(var_216599c5.hitradius)) {
                foreach (hittag in var_216599c5.hittags) {
                    tagorigin = entity gettagorigin(hittag);
                    distsq = distancesquared(point, tagorigin);
                    if (distsq <= var_216599c5.hitradius * var_216599c5.hitradius && var_dac631a7 > distsq) {
                        var_6a87651 = var_216599c5;
                        var_dac631a7 = distsq;
                    }
                }
            }
        }
    }
    return var_6a87651;
}

// Namespace namespace_9088c704/namespace_9088c704
// Params 3, eflags: 0x0
// Checksum 0xcfe10dd, Offset: 0x590
// Size: 0x1a0
function function_fe92de4d(entity, point, weakpointstate) {
    if (!isdefined(point)) {
        return undefined;
    }
    if (isdefined(entity.var_c40aa8c8)) {
        foreach (var_216599c5 in entity.var_c40aa8c8) {
            if (isdefined(weakpointstate) && var_216599c5.currstate !== weakpointstate) {
                continue;
            }
            if (isdefined(var_216599c5.hitradius)) {
                foreach (hittag in var_216599c5.hittags) {
                    tagorigin = entity gettagorigin(hittag);
                    distsq = distancesquared(point, tagorigin);
                    if (distsq <= var_216599c5.hitradius * var_216599c5.hitradius) {
                        return var_216599c5;
                    }
                }
            }
        }
    }
}

// Namespace namespace_9088c704/namespace_9088c704
// Params 3, eflags: 0x0
// Checksum 0x23322072, Offset: 0x738
// Size: 0x1ec
function function_fc6ac723(entity, bone, weakpointstate) {
    if (isdefined(bone) && !isstring(bone)) {
        bonename = getpartname(entity, bone);
    } else {
        bonename = bone;
    }
    if (isdefined(bonename) && isdefined(entity.var_c40aa8c8)) {
        /#
            if (getdvarint(#"scr_weakpoint_debug", 0) > 0) {
                if (!isstring(bone)) {
                    iprintlnbold("<dev string:x30>" + bonename);
                }
            }
        #/
        foreach (var_216599c5 in entity.var_c40aa8c8) {
            if (isdefined(weakpointstate) && var_216599c5.currstate !== weakpointstate) {
                continue;
            }
            foreach (hittag in var_216599c5.hittags) {
                if (hittag == bonename) {
                    return var_216599c5;
                }
            }
        }
    }
}

// Namespace namespace_9088c704/namespace_9088c704
// Params 1, eflags: 0x0
// Checksum 0x28195d21, Offset: 0x930
// Size: 0x16
function function_6c1699d5(entity) {
    return entity.var_c40aa8c8;
}

// Namespace namespace_9088c704/namespace_9088c704
// Params 2, eflags: 0x0
// Checksum 0x9af62139, Offset: 0x950
// Size: 0x52
function damageweakpoint(var_216599c5, damage) {
    var_216599c5.health -= damage;
    if (var_216599c5.health <= 0) {
        var_216599c5.currstate = 3;
    }
}

// Namespace namespace_9088c704/namespace_9088c704
// Params 2, eflags: 0x0
// Checksum 0x60a0c55a, Offset: 0x9b0
// Size: 0x22
function function_3ad01c52(var_216599c5, state) {
    var_216599c5.currstate = state;
}

// Namespace namespace_9088c704/namespace_9088c704
// Params 1, eflags: 0x0
// Checksum 0xc12323fa, Offset: 0x9e0
// Size: 0x16
function function_4abac7be(var_216599c5) {
    return var_216599c5.currstate;
}

// Namespace namespace_9088c704/namespace_9088c704
// Params 1, eflags: 0x0
// Checksum 0x2491b1e6, Offset: 0xa00
// Size: 0x62
function function_424886e0(var_216599c5) {
    var_216599c5.currstate = 2;
    if (isdefined(var_216599c5.activebydefault) && var_216599c5.activebydefault) {
        var_216599c5.currstate = 1;
    }
    var_216599c5.health = var_216599c5.maxhealth;
}

// Namespace namespace_9088c704/namespace_9088c704
// Params 2, eflags: 0x0
// Checksum 0x5d1d2419, Offset: 0xa70
// Size: 0x44
function function_305cc7a5(entity, var_216599c5) {
    if (isdefined(entity.var_c40aa8c8)) {
        arrayremovevalue(entity.var_c40aa8c8, var_216599c5, 0);
    }
}

