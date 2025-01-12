#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace zm_sq_modules;

// Namespace zm_sq_modules/zm_sq_modules
// Params 9, eflags: 0x0
// Checksum 0xdfe5a482, Offset: 0x100
// Size: 0x19c
function function_8ab612a3(id, version, script_noteworthy, speed, soul_fx, var_6a9eae07, var_93c81d8d, var_d34dda04, var_7be87474 = 0) {
    if (!isdefined(level.var_b5831499)) {
        level.var_b5831499 = [];
    }
    level.var_b5831499["soul_capture" + id] = {#script_noteworthy:script_noteworthy, #speed:speed, #soul_fx:soul_fx, #var_6a9eae07:var_6a9eae07, #var_93c81d8d:var_93c81d8d, #var_d34dda04:var_d34dda04, #var_7be87474:var_7be87474};
    clientfield::register("actor", "soul_capture" + id, version, 1, "int", &soul_capture, 0, 0);
    if (var_7be87474) {
        clientfield::register("vehicle", "soul_capture" + id, version, 1, "int", &soul_capture, 0, 0);
    }
}

// Namespace zm_sq_modules/zm_sq_modules
// Params 7, eflags: 0x4
// Checksum 0x975f34cc, Offset: 0x2a8
// Size: 0x2cc
function private soul_capture(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    def = level.var_b5831499[fieldname];
    if (!isdefined(def)) {
        return;
    }
    self util::waittill_dobj(localclientnum);
    capture_points = struct::get_array(def.script_noteworthy, "script_noteworthy");
    capture_point = arraygetclosest(self.origin, capture_points);
    e_fx = spawn(localclientnum, self gettagorigin("J_Spine4"), "script_model");
    e_fx setmodel(#"tag_origin");
    e_fx playsound(localclientnum, "zmb_sq_souls_release");
    util::playfxontag(localclientnum, def.soul_fx, e_fx, "tag_origin");
    if (isdefined(def.var_93c81d8d)) {
        level [[ def.var_93c81d8d ]](localclientnum, def, capture_point, self);
    }
    time = distance(e_fx.origin, capture_point.origin) / def.speed;
    e_fx moveto(capture_point.origin, time);
    e_fx waittill(#"movedone");
    e_fx playsound(localclientnum, "zmb_sq_souls_impact");
    util::playfxontag(localclientnum, def.var_6a9eae07, e_fx, "tag_origin");
    if (isdefined(def.var_d34dda04)) {
        level [[ def.var_d34dda04 ]](localclientnum, def, capture_point);
    }
    wait 0.3;
    e_fx delete();
}

