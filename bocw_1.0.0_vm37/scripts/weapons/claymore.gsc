#using scripts\core_common\system_shared;
#using scripts\weapons\weaponobjects;

#namespace claymore;

// Namespace claymore/claymore
// Params 0, eflags: 0x6
// Checksum 0x307df265, Offset: 0xa0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"claymore", &init_shared, undefined, undefined, undefined);
}

// Namespace claymore/claymore
// Params 0, eflags: 0x0
// Checksum 0x5daf75a1, Offset: 0xe8
// Size: 0x2c
function init_shared() {
    weaponobjects::function_e6400478("claymore", &createclaymorewatcher, 0);
}

// Namespace claymore/claymore
// Params 1, eflags: 0x0
// Checksum 0xc8ae3548, Offset: 0x120
// Size: 0x252
function createclaymorewatcher(watcher) {
    watcher.watchforfire = 1;
    watcher.activatesound = #"wpn_claymore_alert";
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = undefined;
    watcher.immediatedetonation = 1;
    watcher.immunespecialty = "specialty_immunetriggerbetty";
    watcher.var_8eda8949 = (0, 0, 0);
    var_e2fa0bc6 = getweapon(#"claymore");
    if (isdefined(var_e2fa0bc6.customsettings)) {
        var_e6fbac16 = getscriptbundle(var_e2fa0bc6.customsettings);
        assert(isdefined(var_e6fbac16));
        watcher.detectiondot = cos(isdefined(var_e6fbac16.var_bec17b8b) ? var_e6fbac16.var_bec17b8b : 0);
        watcher.detectionmindist = isdefined(var_e6fbac16.var_5303bdc6) ? var_e6fbac16.var_5303bdc6 : 0;
        watcher.detectiongraceperiod = isdefined(var_e6fbac16.var_88b0248b) ? var_e6fbac16.var_88b0248b : 0;
        if (isdefined(var_e6fbac16.var_29467698) && var_e6fbac16.var_29467698 != 0) {
            watcher.detonateradius = var_e6fbac16.var_29467698;
        }
    }
    watcher.stuntime = 1;
    watcher.ondetonatecallback = &weaponobjects::proximitydetonate;
    watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
    watcher.onspawn = &function_c9893179;
    watcher.stun = &weaponobjects::weaponstun;
    watcher.var_994b472b = &function_aeb91d3;
}

// Namespace claymore/claymore
// Params 1, eflags: 0x0
// Checksum 0xc15445c6, Offset: 0x380
// Size: 0x24
function function_aeb91d3(*player) {
    self weaponobjects::weaponobjectfizzleout();
}

// Namespace claymore/claymore
// Params 2, eflags: 0x0
// Checksum 0xd372b5c3, Offset: 0x3b0
// Size: 0x52
function function_c9893179(watcher, player) {
    weaponobjects::onspawnproximitygrenadeweaponobject(watcher, player);
    self.weapon = getweapon(#"claymore");
}

