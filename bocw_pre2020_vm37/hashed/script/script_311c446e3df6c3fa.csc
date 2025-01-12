#using script_74e3c3cd261ec799;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace objective_manager;

// Namespace objective_manager/objective_manager
// Params 0, eflags: 0x6
// Checksum 0xeea793cd, Offset: 0x178
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"objective_manager", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace objective_manager/objective_manager
// Params 0, eflags: 0x5 linked
// Checksum 0x9c853ccf, Offset: 0x1c0
// Size: 0x2bc
function private function_70a657d8() {
    clientfield::register("actor", "" + #"hash_501374858f77990b", 1, 1, "int", &function_95190421, 0, 0);
    clientfield::register("actor", "objective_cf_callout_rob", 1, 2, "int", &function_b8c3e9f4, 0, 0);
    clientfield::register("toplayer", "sr_defend_timer", 18000, getminbitcountfornum(540), "int", &function_bb753058, 0, 1);
    clientfield::register("scriptmover", "" + #"hash_501374858f77990b", 1, 1, "int", &function_95190421, 0, 0);
    clientfield::register("scriptmover", "objective_cf_callout_rob", 1, 2, "int", &function_b8c3e9f4, 0, 0);
    clientfield::register("vehicle", "objective_cf_callout_rob", 1, 2, "int", &function_b8c3e9f4, 0, 0);
    clientfield::function_5b7d846d("hudItems.warzone.objectiveTotal", #"hash_593f03dd48d5bc1f", #"objectivetotal", 1, 5, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.warzone.objectivesCompleted", #"hash_593f03dd48d5bc1f", #"objectivescompleted", 1, 5, "int", undefined, 0, 0);
    callback::on_localclient_connect(&on_localplayer_connect);
    level.var_4f12f6d0 = sr_objective_timer::register();
}

// Namespace objective_manager/objective_manager
// Params 7, eflags: 0x1 linked
// Checksum 0xc5573fe7, Offset: 0x488
// Size: 0x6c
function function_95190421(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        function_239993de(fieldname, "sr/fx9_zmb_spawn_portal", self, "tag_origin");
    }
}

// Namespace objective_manager/objective_manager
// Params 7, eflags: 0x5 linked
// Checksum 0xb1249696, Offset: 0x500
// Size: 0xf4
function private function_b8c3e9f4(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self function_dd2493cc(#"hash_67ab6fd22ae1e4ac", #"rob_sonar_set_friendly_zm_ls");
        return;
    }
    if (bwastimejump == 2) {
        self function_dd2493cc(#"rob_sonar_set_friendly_zm_ls", #"hash_67ab6fd22ae1e4ac");
        return;
    }
    self function_dd2493cc(undefined, #"hash_67ab6fd22ae1e4ac", #"rob_sonar_set_friendly_zm_ls");
}

// Namespace objective_manager/objective_manager
// Params 2, eflags: 0x25 linked variadic
// Checksum 0x76288c27, Offset: 0x600
// Size: 0xf0
function private function_dd2493cc(var_c5dfdae0, ...) {
    if (isdefined(var_c5dfdae0) && !self function_d2503806(var_c5dfdae0)) {
        self playrenderoverridebundle(var_c5dfdae0);
    }
    foreach (rob in vararg) {
        if (self function_d2503806(rob)) {
            self stoprenderoverridebundle(rob);
        }
    }
}

// Namespace objective_manager/objective_manager
// Params 7, eflags: 0x5 linked
// Checksum 0xa945e0e0, Offset: 0x6f8
// Size: 0xc4
function private function_bb753058(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!function_65b9eb0f(fieldname)) {
        timer_model = function_c8b7588d(fieldname);
        duration_msec = bwastimejump * 1000;
        setuimodelvalue(timer_model, getservertime(fieldname, 1) + duration_msec);
    }
}

// Namespace objective_manager/objective_manager
// Params 1, eflags: 0x5 linked
// Checksum 0x327d2d03, Offset: 0x7c8
// Size: 0x44
function private on_localplayer_connect(localclientnum) {
    timer_model = function_c8b7588d(localclientnum);
    setuimodelvalue(timer_model, 0);
}

// Namespace objective_manager/objective_manager
// Params 1, eflags: 0x5 linked
// Checksum 0xa57238fc, Offset: 0x818
// Size: 0x52
function private function_c8b7588d(*localclientnum) {
    var_4fa1ce7b = getuimodel(function_5f72e972(#"hash_593f03dd48d5bc1f"), "srProtoTimer");
    return var_4fa1ce7b;
}

