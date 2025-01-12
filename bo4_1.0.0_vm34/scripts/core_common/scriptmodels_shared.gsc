#using scripts\core_common\system_shared;

#namespace scriptmodels;

// Namespace scriptmodels/scriptmodels_shared
// Params 0, eflags: 0x2
// Checksum 0x6e91a730, Offset: 0x98
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"scriptmodels", &__init__, undefined, undefined);
}

// Namespace scriptmodels/scriptmodels_shared
// Params 0, eflags: 0x0
// Checksum 0x9071522e, Offset: 0xe0
// Size: 0x98
function __init__() {
    a_script_models = getentarraybytype(6);
    foreach (model in a_script_models) {
        function_55779046(model);
    }
}

// Namespace scriptmodels/scriptmodels_shared
// Params 1, eflags: 0x4
// Checksum 0x903290b8, Offset: 0x180
// Size: 0x154
function private function_55779046(model) {
    assert(isdefined(model));
    if (model.classname != "script_model" && model.classname != "script_brushmodel") {
        return;
    }
    if (isdefined(model.script_health)) {
        model.health = model.script_health;
        model.maxhealth = model.script_health;
        model.takedamage = 1;
    }
    if (isdefined(model.var_6610b01f) && model.var_6610b01f && !issentient(model)) {
        model makesentient();
    }
    if (isdefined(model.script_team) && model.script_team != "none") {
        model.team = model.script_team;
        model setteam(model.script_team);
    }
}

