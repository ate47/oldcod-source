#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\bouncingbetty;
#using scripts\weapons\weaponobjects;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_placeable_mine;

#namespace bouncingbetty;

// Namespace bouncingbetty/zm_weap_bouncingbetty
// Params 0, eflags: 0x6
// Checksum 0x54b1ae22, Offset: 0xb8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"bouncingbetty", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace bouncingbetty/zm_weap_bouncingbetty
// Params 0, eflags: 0x4
// Checksum 0x3195c109, Offset: 0x100
// Size: 0x114
function private function_70a657d8() {
    level._proximityweaponobjectdetonation_override = &proximityweaponobjectdetonation_override;
    init_shared();
    zm_placeable_mine::add_mine_type("bouncingbetty", #"zombie/betty_pickup");
    level.bettyjumpheight = 55;
    level.bettydamagemax = 1000;
    level.bettydamagemin = 800;
    level.bettydamageheight = level.bettyjumpheight;
    /#
        setdvar(#"betty_damage_max", level.bettydamagemax);
        setdvar(#"betty_damage_min", level.bettydamagemin);
        setdvar(#"betty_jump_height_onground", level.bettyjumpheight);
    #/
}

// Namespace bouncingbetty/zm_weap_bouncingbetty
// Params 1, eflags: 0x0
// Checksum 0xa042f3e6, Offset: 0x220
// Size: 0x170
function proximityweaponobjectdetonation_override(watcher) {
    self endon(#"death", #"hacked", #"kill_target_detection");
    weaponobjects::proximityweaponobject_activationdelay(watcher);
    damagearea = weaponobjects::proximityweaponobject_createdamagearea(watcher);
    up = anglestoup(self.angles);
    traceorigin = self.origin + up;
    while (true) {
        waitresult = damagearea waittill(#"trigger");
        ent = waitresult.activator;
        if (!weaponobjects::proximityweaponobject_validtriggerentity(watcher, ent)) {
            continue;
        }
        if (weaponobjects::proximityweaponobject_isspawnprotected(watcher, ent)) {
            continue;
        }
        if (ent damageconetrace(traceorigin, self) > 0) {
            thread weaponobjects::proximityweaponobject_dodetonation(watcher, ent, traceorigin);
        }
    }
}

