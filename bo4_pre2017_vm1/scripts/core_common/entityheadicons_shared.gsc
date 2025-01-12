#using scripts/core_common/callbacks_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace entityheadicons;

// Namespace entityheadicons/entityheadicons_shared
// Params 0, eflags: 0x0
// Checksum 0x53badc8b, Offset: 0x170
// Size: 0x24
function init_shared() {
    callback::on_start_gametype(&start_gametype);
}

// Namespace entityheadicons/entityheadicons_shared
// Params 0, eflags: 0x0
// Checksum 0x3edb56f4, Offset: 0x1a0
// Size: 0xe0
function start_gametype() {
    if (isdefined(level.var_3d8a3717)) {
        return;
    }
    level.var_3d8a3717 = 1;
    /#
        assert(isdefined(game.var_4bce066["<dev string:x28>"]), "<dev string:x2f>");
    #/
    /#
        assert(isdefined(game.var_4bce066["<dev string:x75>"]), "<dev string:x7a>");
    #/
    if (!level.teambased) {
        return;
    }
    if (!isdefined(level.setentityheadicon)) {
        level.setentityheadicon = &setentityheadicon;
    }
    level.var_17c7d510 = [];
}

// Namespace entityheadicons/entityheadicons_shared
// Params 5, eflags: 0x0
// Checksum 0x62eb1422, Offset: 0x288
// Size: 0x3bc
function setentityheadicon(team, owner, offset, objective, var_cc32611f) {
    if (!level.teambased && !isdefined(owner)) {
        return;
    }
    if (!isdefined(var_cc32611f)) {
        var_cc32611f = 0;
    }
    if (!isdefined(self.entityheadiconteam)) {
        self.entityheadiconteam = "none";
        self.entityheadicons = [];
        self.entityheadobjectives = [];
    }
    if (level.teambased && !isdefined(owner)) {
        if (team == self.entityheadiconteam) {
            return;
        }
        self.entityheadiconteam = team;
    }
    if (isdefined(offset)) {
        self.entityheadiconoffset = offset;
    } else {
        self.entityheadiconoffset = (0, 0, 0);
    }
    if (isdefined(self.entityheadicons)) {
        for (i = 0; i < self.entityheadicons.size; i++) {
            if (isdefined(self.entityheadicons[i])) {
                self.entityheadicons[i] destroy();
            }
        }
    }
    if (isdefined(self.entityheadobjectives)) {
        for (i = 0; i < self.entityheadobjectives.size; i++) {
            if (isdefined(self.entityheadobjectives[i])) {
                objective_delete(self.entityheadobjectives[i]);
                self.entityheadobjectives[i] = undefined;
            }
        }
    }
    self.entityheadicons = [];
    self.entityheadobjectives = [];
    self notify(#"kill_entity_headicon_thread");
    if (!isdefined(objective)) {
        objective = game.var_4bce066[team];
    }
    if (isdefined(objective)) {
        if (isdefined(owner) && !level.teambased) {
            if (!isplayer(owner)) {
                /#
                    assert(isdefined(owner.owner), "<dev string:xbe>");
                #/
                owner = owner.owner;
            }
            if (isstring(objective)) {
                owner function_a7801f67(self, objective, var_cc32611f);
            } else {
                owner updateentityheadclientobjective(self, objective, var_cc32611f);
            }
        } else if (isdefined(owner) && team != "none") {
            if (isstring(objective)) {
                owner function_49af735d(self, team, objective, var_cc32611f);
            } else {
                owner updateentityheadteamobjective(self, team, objective, var_cc32611f);
            }
        }
    }
    self thread destroyheadiconsondeath();
}

// Namespace entityheadicons/entityheadicons_shared
// Params 4, eflags: 0x0
// Checksum 0x7af42bbf, Offset: 0x650
// Size: 0x1aa
function function_49af735d(entity, team, icon, var_cc32611f) {
    var_c94daf9f = array(0.584, 0.839, 0.867);
    headicon = newteamhudelem(team);
    headicon.archived = 1;
    headicon.x = entity.entityheadiconoffset[0];
    headicon.y = entity.entityheadiconoffset[1];
    headicon.z = entity.entityheadiconoffset[2];
    headicon.alpha = 0.8;
    headicon.color = (var_c94daf9f[0], var_c94daf9f[1], var_c94daf9f[2]);
    headicon setshader(icon, 6, 6);
    headicon setwaypoint(var_cc32611f);
    headicon settargetent(entity);
    entity.entityheadicons[entity.entityheadicons.size] = headicon;
}

// Namespace entityheadicons/entityheadicons_shared
// Params 3, eflags: 0x0
// Checksum 0xf1083c11, Offset: 0x808
// Size: 0x14a
function function_a7801f67(entity, icon, var_cc32611f) {
    headicon = newclienthudelem(self);
    headicon.archived = 1;
    headicon.x = entity.entityheadiconoffset[0];
    headicon.y = entity.entityheadiconoffset[1];
    headicon.z = entity.entityheadiconoffset[2];
    headicon.alpha = 0.8;
    headicon setshader(icon, 6, 6);
    headicon setwaypoint(var_cc32611f);
    headicon settargetent(entity);
    entity.entityheadicons[entity.entityheadicons.size] = headicon;
}

// Namespace entityheadicons/entityheadicons_shared
// Params 4, eflags: 0x0
// Checksum 0xc8510b01, Offset: 0x960
// Size: 0xc2
function updateentityheadteamobjective(entity, team, objective, var_cc32611f) {
    headiconobjectiveid = gameobjects::get_next_obj_id();
    objective_add(headiconobjectiveid, "active", entity, objective);
    objective_setteam(headiconobjectiveid, team);
    objective_setcolor(headiconobjectiveid, %FriendlyBlue);
    entity.entityheadobjectives[entity.entityheadobjectives.size] = headiconobjectiveid;
}

// Namespace entityheadicons/entityheadicons_shared
// Params 3, eflags: 0x0
// Checksum 0xb7f06c51, Offset: 0xa30
// Size: 0xd2
function updateentityheadclientobjective(entity, objective, var_cc32611f) {
    headiconobjectiveid = gameobjects::get_next_obj_id();
    objective_add(headiconobjectiveid, "active", entity, objective);
    objective_setinvisibletoall(headiconobjectiveid);
    objective_setvisibletoplayer(headiconobjectiveid, self);
    objective_setcolor(headiconobjectiveid, %FriendlyBlue);
    entity.entityheadobjectives[entity.entityheadobjectives.size] = headiconobjectiveid;
}

// Namespace entityheadicons/entityheadicons_shared
// Params 0, eflags: 0x0
// Checksum 0x561c90d8, Offset: 0xb10
// Size: 0x11e
function destroyheadiconsondeath() {
    self notify(#"destroyheadiconsondeath_singleton");
    self endon(#"destroyheadiconsondeath_singleton");
    self waittill("death", "hacked");
    for (i = 0; i < self.entityheadicons.size; i++) {
        if (isdefined(self.entityheadicons[i])) {
            self.entityheadicons[i] destroy();
        }
    }
    for (i = 0; i < self.entityheadobjectives.size; i++) {
        if (isdefined(self.entityheadobjectives[i])) {
            gameobjects::release_obj_id(self.entityheadobjectives[i]);
            objective_delete(self.entityheadobjectives[i]);
        }
    }
}

// Namespace entityheadicons/entityheadicons_shared
// Params 0, eflags: 0x0
// Checksum 0xc008129c, Offset: 0xc38
// Size: 0x11c
function destroyentityheadicons() {
    if (isdefined(self.entityheadicons)) {
        for (i = 0; i < self.entityheadicons.size; i++) {
            if (isdefined(self.entityheadicons[i])) {
                self.entityheadicons[i] destroy();
            }
        }
    }
    if (isdefined(self.entityheadobjectives)) {
        for (i = 0; i < self.entityheadobjectives.size; i++) {
            if (isdefined(self.entityheadobjectives[i])) {
                gameobjects::release_obj_id(self.entityheadobjectives[i]);
                objective_delete(self.entityheadobjectives[i]);
            }
        }
    }
    self.entityheadobjectives = [];
}

// Namespace entityheadicons/entityheadicons_shared
// Params 1, eflags: 0x0
// Checksum 0xc30356fc, Offset: 0xd60
// Size: 0x94
function function_29295d50(headicon) {
    headicon.x = self.origin[0] + self.entityheadiconoffset[0];
    headicon.y = self.origin[1] + self.entityheadiconoffset[1];
    headicon.z = self.origin[2] + self.entityheadiconoffset[2];
}

