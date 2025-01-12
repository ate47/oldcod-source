#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\util_shared;

#namespace entityheadicons;

// Namespace entityheadicons/entityheadicons_shared
// Params 0, eflags: 0x0
// Checksum 0x5ce86dc1, Offset: 0x88
// Size: 0x24
function init_shared() {
    callback::on_start_gametype(&start_gametype);
}

// Namespace entityheadicons/entityheadicons_shared
// Params 0, eflags: 0x0
// Checksum 0xe4875982, Offset: 0xb8
// Size: 0x3e
function start_gametype() {
    if (!level.teambased) {
        return;
    }
    if (!isdefined(level.setentityheadicon)) {
        level.setentityheadicon = &setentityheadicon;
    }
}

// Namespace entityheadicons/entityheadicons_shared
// Params 3, eflags: 0x0
// Checksum 0x3a0ec239, Offset: 0x100
// Size: 0x1cc
function setentityheadicon(team, owner, objective) {
    if (!level.teambased && !isdefined(owner)) {
        return;
    }
    if (!isdefined(self.entityheadiconteam)) {
        self.entityheadiconteam = #"none";
        self.entityheadobjectives = [];
    }
    if (level.teambased && !isdefined(owner)) {
        if (team == self.entityheadiconteam) {
            return;
        }
        self.entityheadiconteam = team;
    }
    destroyentityheadicons();
    self.entityheadobjectives = [];
    self notify(#"kill_entity_headicon_thread");
    if (isdefined(objective)) {
        if (isdefined(owner) && !level.teambased) {
            if (!isplayer(owner)) {
                assert(isdefined(owner.owner), "<dev string:x30>");
                owner = owner.owner;
            }
            if (isdefined(objective)) {
                owner updateentityheadclientobjective(self, objective);
            }
        } else if (isdefined(owner) && team != #"none") {
            if (isdefined(objective)) {
                owner updateentityheadteamobjective(self, team, objective);
            }
        }
    }
    self thread destroyheadiconsondeath();
}

// Namespace entityheadicons/entityheadicons_shared
// Params 3, eflags: 0x0
// Checksum 0x19e7893c, Offset: 0x2d8
// Size: 0xb2
function updateentityheadteamobjective(entity, team, objective) {
    headiconobjectiveid = gameobjects::get_next_obj_id();
    objective_add(headiconobjectiveid, "active", entity, objective);
    objective_setteam(headiconobjectiveid, team);
    function_c3a2445a(headiconobjectiveid, team, 1);
    entity.entityheadobjectives[entity.entityheadobjectives.size] = headiconobjectiveid;
}

// Namespace entityheadicons/entityheadicons_shared
// Params 2, eflags: 0x0
// Checksum 0xc13261a0, Offset: 0x398
// Size: 0xa2
function updateentityheadclientobjective(entity, objective) {
    headiconobjectiveid = gameobjects::get_next_obj_id();
    objective_add(headiconobjectiveid, "active", entity, objective);
    objective_setinvisibletoall(headiconobjectiveid);
    objective_setvisibletoplayer(headiconobjectiveid, self);
    entity.entityheadobjectives[entity.entityheadobjectives.size] = headiconobjectiveid;
}

// Namespace entityheadicons/entityheadicons_shared
// Params 0, eflags: 0x0
// Checksum 0x6a1d57ea, Offset: 0x448
// Size: 0x5c
function destroyheadiconsondeath() {
    self notify(#"destroyheadiconsondeath_singleton");
    self endon(#"destroyheadiconsondeath_singleton");
    self waittill(#"death", #"hacked");
    destroyentityheadicons();
}

// Namespace entityheadicons/entityheadicons_shared
// Params 0, eflags: 0x0
// Checksum 0x46225d97, Offset: 0x4b0
// Size: 0xa2
function destroyentityheadicons() {
    if (isdefined(self.entityheadobjectives)) {
        for (i = 0; i < self.entityheadobjectives.size; i++) {
            if (isdefined(self.entityheadobjectives[i])) {
                gameobjects::release_obj_id(self.entityheadobjectives[i]);
                objective_delete(self.entityheadobjectives[i]);
            }
        }
    }
    if (isdefined(self)) {
        self.entityheadobjectives = [];
    }
}

