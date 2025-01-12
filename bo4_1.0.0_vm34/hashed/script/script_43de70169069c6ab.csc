#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_a9db3299;

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1b0
// Size: 0x4
function init() {
    
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 0, eflags: 0x0
// Checksum 0xad9198f2, Offset: 0x1c0
// Size: 0xec
function init_clientfields() {
    clientfield::register("scriptmover", "p_w_o_num", 1, getminbitcountfornum(10), "int", &function_48fb9d2f, 0, 0);
    clientfield::register("toplayer", "sp_ar_pi", 1, 1, "int", &function_d1b7b05b, 0, 0);
    clientfield::register("scriptmover", "elevator_rumble", 1, 1, "counter", &play_elevator_rumble, 0, 0);
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x2b8
// Size: 0x4
function main() {
    
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 7, eflags: 0x0
// Checksum 0x3d3b2799, Offset: 0x2c8
// Size: 0x35e
function function_48fb9d2f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        if (isdefined(self.mdl_paper)) {
            self.mdl_paper.script_int = newval;
            self.mdl_paper.b_hidden = 1;
            self.mdl_paper function_e413b84f(localclientnum);
        } else {
            self.mdl_paper = util::spawn_model(localclientnum, self.model, self.origin, self.angles);
            self.mdl_paper.script_int = newval;
            self.mdl_paper.b_hidden = 1;
            self.mdl_paper.show_function = &function_8a4354ce;
            self.mdl_paper.hide_function = &function_e413b84f;
            self.mdl_paper function_e413b84f(localclientnum);
            if (!isdefined(level.var_6da26c79)) {
                level.var_6da26c79 = [];
            } else if (!isarray(level.var_6da26c79)) {
                level.var_6da26c79 = array(level.var_6da26c79);
            }
            level.var_6da26c79[level.var_6da26c79.size] = self.mdl_paper;
        }
        return;
    }
    if (isdefined(self.mdl_paper)) {
        if (isdefined(self.mdl_paper.b_hidden) && self.mdl_paper.b_hidden) {
            self.mdl_paper.b_hidden = undefined;
        }
        self.mdl_paper.script_int = newval;
        return;
    }
    self.mdl_paper = util::spawn_model(localclientnum, self.model, self.origin, self.angles);
    self.mdl_paper.script_int = newval;
    self.mdl_paper.show_function = &function_8a4354ce;
    self.mdl_paper.hide_function = &function_e413b84f;
    self.mdl_paper function_e413b84f(localclientnum);
    if (!isdefined(level.var_6da26c79)) {
        level.var_6da26c79 = [];
    } else if (!isarray(level.var_6da26c79)) {
        level.var_6da26c79 = array(level.var_6da26c79);
    }
    level.var_6da26c79[level.var_6da26c79.size] = self.mdl_paper;
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 1, eflags: 0x0
// Checksum 0xc9b30977, Offset: 0x630
// Size: 0x16c
function function_e413b84f(localclientnum) {
    self hidepart(localclientnum, "tag_paper_on_1");
    self hidepart(localclientnum, "tag_paper_on_2");
    self hidepart(localclientnum, "tag_paper_on_3");
    self hidepart(localclientnum, "tag_paper_on_4");
    self hidepart(localclientnum, "tag_paper_on_5");
    self hidepart(localclientnum, "tag_paper_on_6");
    self hidepart(localclientnum, "tag_paper_on_7");
    self hidepart(localclientnum, "tag_paper_on_8");
    self hidepart(localclientnum, "tag_paper_on_9");
    self hidepart(localclientnum, "tag_paper_on_0");
    self showpart(localclientnum, "tag_paper_off");
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 1, eflags: 0x0
// Checksum 0x3e50e103, Offset: 0x7a8
// Size: 0x1f4
function function_8a4354ce(localclientnum) {
    self hidepart(localclientnum, "tag_paper_on_1");
    self hidepart(localclientnum, "tag_paper_on_2");
    self hidepart(localclientnum, "tag_paper_on_3");
    self hidepart(localclientnum, "tag_paper_on_4");
    self hidepart(localclientnum, "tag_paper_on_5");
    self hidepart(localclientnum, "tag_paper_on_6");
    self hidepart(localclientnum, "tag_paper_on_7");
    self hidepart(localclientnum, "tag_paper_on_8");
    self hidepart(localclientnum, "tag_paper_on_9");
    self hidepart(localclientnum, "tag_paper_on_0");
    self hidepart(localclientnum, "tag_paper_off");
    if (isdefined(self.b_hidden) && self.b_hidden) {
        return;
    }
    if (isdefined(self.script_int)) {
        if (self.script_int == 10) {
            self showpart(localclientnum, "tag_paper_on_0");
            return;
        }
        self showpart(localclientnum, "tag_paper_on_" + self.script_int);
    }
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 7, eflags: 0x0
// Checksum 0xf826c05e, Offset: 0x9a8
// Size: 0x64
function play_elevator_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self playrumbleonentity(localclientnum, #"hash_64b33287bc9d79f5");
}

// Namespace namespace_a9db3299/namespace_a9db3299
// Params 7, eflags: 0x0
// Checksum 0x468bb38f, Offset: 0xa18
// Size: 0x1fc
function function_d1b7b05b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_817b6e5f)) {
        level.var_817b6e5f = [];
    }
    if (!isdefined(level.var_817b6e5f[localclientnum])) {
        var_3cc00e05 = struct::get("s_cr_sp_pi");
        level.var_817b6e5f[localclientnum] = util::spawn_model(localclientnum, #"hash_66161656c8ef4b2d", var_3cc00e05.origin, var_3cc00e05.angles);
    }
    if (newval) {
        level.var_817b6e5f[localclientnum] showpart(localclientnum, "tag_elbow_r");
        level.var_817b6e5f[localclientnum] showpart(localclientnum, "tag_wrist_r");
        level.var_817b6e5f[localclientnum] showpart(localclientnum, "TAG_SPOON");
        return;
    }
    level.var_817b6e5f[localclientnum] hidepart(localclientnum, "tag_elbow_r");
    level.var_817b6e5f[localclientnum] hidepart(localclientnum, "tag_wrist_r");
    level.var_817b6e5f[localclientnum] hidepart(localclientnum, "TAG_SPOON");
}

