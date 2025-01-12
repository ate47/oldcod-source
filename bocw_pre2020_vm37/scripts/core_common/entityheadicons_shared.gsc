#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\util_shared;

#namespace entityheadicons;

// Namespace entityheadicons/entityheadicons_shared
// Params 0, eflags: 0x0
// Checksum 0x315d6755, Offset: 0x88
// Size: 0x24
function init_shared() {
    callback::on_start_gametype(&start_gametype);
}

// Namespace entityheadicons/entityheadicons_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xd64c3102, Offset: 0xb8
// Size: 0x3c
function start_gametype() {
    if (!level.teambased) {
        return;
    }
    if (!isdefined(level.setentityheadicon)) {
        level.setentityheadicon = &setentityheadicon;
    }
}

// Namespace entityheadicons/entityheadicons_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x7afdc693, Offset: 0x100
// Size: 0x1fc
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
                assert(isdefined(owner.owner), "<dev string:x38>");
                owner = owner.owner;
            }
            if (isdefined(objective)) {
                if (team !== #"none") {
                    owner updateentityheadteamobjective(self, team, objective);
                } else {
                    owner updateentityheadclientobjective(self, objective);
                }
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
// Params 3, eflags: 0x1 linked
// Checksum 0x8d3ca15, Offset: 0x308
// Size: 0xa4
function updateentityheadteamobjective(entity, team, objective) {
    headiconobjectiveid = gameobjects::get_next_obj_id();
    objective_add(headiconobjectiveid, "active", entity, objective);
    objective_setteam(headiconobjectiveid, team);
    function_29ef32ee(headiconobjectiveid, team);
    entity.entityheadobjectives[entity.entityheadobjectives.size] = headiconobjectiveid;
}

// Namespace entityheadicons/entityheadicons_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xf879a868, Offset: 0x3b8
// Size: 0x9c
function updateentityheadclientobjective(entity, objective) {
    headiconobjectiveid = gameobjects::get_next_obj_id();
    objective_add(headiconobjectiveid, "active", entity, objective);
    function_56ad6a7a(headiconobjectiveid);
    objective_setvisibletoplayer(headiconobjectiveid, self);
    entity.entityheadobjectives[entity.entityheadobjectives.size] = headiconobjectiveid;
}

// Namespace entityheadicons/entityheadicons_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x5fd5f8de, Offset: 0x460
// Size: 0x5c
function destroyheadiconsondeath() {
    self notify(#"destroyheadiconsondeath_singleton");
    self endon(#"destroyheadiconsondeath_singleton");
    self waittill(#"death", #"hacked");
    destroyentityheadicons();
}

// Namespace entityheadicons/entityheadicons_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x363424b4, Offset: 0x4c8
// Size: 0x9e
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

