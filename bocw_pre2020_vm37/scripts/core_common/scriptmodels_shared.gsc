#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace scriptmodels;

// Namespace scriptmodels/scriptmodels_shared
// Params 0, eflags: 0x6
// Checksum 0x6190d4a0, Offset: 0xa0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"scriptmodels", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace scriptmodels/scriptmodels_shared
// Params 0, eflags: 0x4
// Checksum 0xfde6f739, Offset: 0xe8
// Size: 0xa8
function private function_70a657d8() {
    a_script_models = getentarraybytype(6);
    foreach (model in a_script_models) {
        function_9abee270(model);
    }
}

// Namespace scriptmodels/scriptmodels_shared
// Params 1, eflags: 0x4
// Checksum 0x42ee1c57, Offset: 0x198
// Size: 0x124
function private function_9abee270(model) {
    assert(isdefined(model));
    if (model.classname != "script_model" && model.classname != "script_brushmodel") {
        return;
    }
    if (isdefined(model.script_health)) {
        model.health = model.script_health;
        model.maxhealth = model.script_health;
        model.takedamage = 1;
    }
    if (is_true(model.var_3ee8e0e2)) {
        model util::make_sentient();
    }
    if (isdefined(model.script_team) && model.script_team != "none") {
        model.team = model.script_team;
        model setteam(model.script_team);
    }
}

