#using scripts\core_common\callbacks_shared;
#using scripts\core_common\util_shared;

#namespace dev_shared;

// Namespace dev_shared/dev_shared
// Params 0, eflags: 0x2
// Checksum 0x22e88c25, Offset: 0xa8
// Size: 0x24
function autoexec init() {
    callback::on_localclient_connect(&function_823ed67a);
}

// Namespace dev_shared/dev_shared
// Params 1, eflags: 0x0
// Checksum 0x2fe4d253, Offset: 0xd8
// Size: 0x17c
function function_823ed67a(localclientnum) {
    var_1230f0bf = undefined;
    var_823ed67a = undefined;
    while (true) {
        n_dist = getdvarint(#"hash_4348ec71a8b13ef1", 0);
        if (n_dist > 0) {
            if (!isdefined(var_1230f0bf)) {
                var_1230f0bf = util::spawn_model(localclientnum, "tag_origin");
            }
            if (!isdefined(var_823ed67a)) {
                var_823ed67a = util::playfxontag(localclientnum, "tools/fx8_color_grade_calibration_sm", var_1230f0bf, "tag_origin");
            }
            v_pos = getcamposbylocalclientnum(localclientnum);
            v_ang = getcamanglesbylocalclientnum(localclientnum);
            v_forward = anglestoforward(v_ang);
            var_1230f0bf.origin = v_pos + v_forward * n_dist;
            var_1230f0bf.angles = v_ang;
        } else if (isdefined(var_1230f0bf)) {
            var_1230f0bf delete();
            var_823ed67a = undefined;
        }
        waitframe(1);
    }
}

