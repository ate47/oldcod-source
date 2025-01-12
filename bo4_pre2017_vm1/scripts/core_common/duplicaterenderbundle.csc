#using scripts/core_common/callbacks_shared;
#using scripts/core_common/filter_shared;
#using scripts/core_common/gfx_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_9e20367a;

// Namespace namespace_9e20367a/duplicaterenderbundle
// Params 0, eflags: 0x2
// Checksum 0x46502423, Offset: 0x248
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("duplicate_render_bundle", &__init__, undefined, undefined);
}

// Namespace namespace_9e20367a/duplicaterenderbundle
// Params 0, eflags: 0x0
// Checksum 0xc63ca8ad, Offset: 0x288
// Size: 0x24
function __init__() {
    callback::on_localplayer_spawned(&function_58c8343a);
}

// Namespace namespace_9e20367a/duplicaterenderbundle
// Params 1, eflags: 0x0
// Checksum 0xa8a1f510, Offset: 0x2b8
// Size: 0x1c
function function_58c8343a(localclientnum) {
    function_e5e53b1a();
}

// Namespace namespace_9e20367a/duplicaterenderbundle
// Params 0, eflags: 0x0
// Checksum 0x7664e0dc, Offset: 0x2e0
// Size: 0x64
function function_e5e53b1a() {
    if (isdefined(self.var_7d9d66c0)) {
        return;
    }
    self.var_7d9d66c0 = 1;
    self.var_33b1de58 = "";
    self.var_53791ab9 = 0;
    self.var_b908ab6c = 0;
    /#
        self thread function_4d534504();
    #/
}

/#

    // Namespace namespace_9e20367a/duplicaterenderbundle
    // Params 0, eflags: 0x0
    // Checksum 0xd10d08dc, Offset: 0x350
    // Size: 0x1c0
    function function_4d534504() {
        self endon(#"death");
        setdvar("<dev string:x28>", "<dev string:x49>");
        setdvar("<dev string:x4a>", "<dev string:x49>");
        setdvar("<dev string:x6b>", "<dev string:x49>");
        while (true) {
            playbundlename = getdvarstring("<dev string:x28>");
            if (playbundlename != "<dev string:x49>") {
                self thread function_5584f24e(playbundlename);
                setdvar("<dev string:x28>", "<dev string:x49>");
            }
            stopbundlename = getdvarstring("<dev string:x4a>");
            if (stopbundlename != "<dev string:x49>") {
                self thread function_503eb424();
                setdvar("<dev string:x4a>", "<dev string:x49>");
            }
            stopbundlename = getdvarstring("<dev string:x6b>");
            if (stopbundlename != "<dev string:x49>") {
                self thread function_b908ab6c();
                setdvar("<dev string:x6b>", "<dev string:x49>");
            }
            wait 0.5;
        }
    }

#/

// Namespace namespace_9e20367a/duplicaterenderbundle
// Params 1, eflags: 0x0
// Checksum 0xe7417548, Offset: 0x518
// Size: 0x54c
function function_5584f24e(playbundlename) {
    self endon(#"death");
    function_e5e53b1a();
    function_1122e900();
    bundle = struct::get_script_bundle("duprenderbundle", playbundlename);
    if (!isdefined(bundle)) {
        /#
            println("<dev string:x8c>" + playbundlename + "<dev string:xa6>");
        #/
        return;
    }
    totalaccumtime = 0;
    filter::init_filter_indices();
    self.var_33b1de58 = playbundlename;
    localclientnum = self.localclientnum;
    looping = 0;
    enterstage = 0;
    exitstage = 0;
    finishlooponexit = 0;
    if (isdefined(bundle.looping)) {
        looping = bundle.looping;
    }
    if (isdefined(bundle.enterstage)) {
        enterstage = bundle.enterstage;
    }
    if (isdefined(bundle.exitstage)) {
        exitstage = bundle.exitstage;
    }
    if (isdefined(bundle.finishlooponexit)) {
        finishlooponexit = bundle.finishlooponexit;
    }
    if (looping) {
        num_stages = 1;
        if (enterstage) {
            num_stages++;
        }
        if (exitstage) {
            num_stages++;
        }
    } else {
        num_stages = bundle.num_stages;
    }
    for (var_7e1e79fe = 0; var_7e1e79fe < num_stages && !self.var_53791ab9; var_7e1e79fe++) {
        stageprefix = "s";
        if (var_7e1e79fe < 10) {
            stageprefix += "0";
        }
        stageprefix += var_7e1e79fe + "_";
        stagelength = bundle.(stageprefix + "length");
        if (!isdefined(stagelength)) {
            function_145785e5(localclientnum, stageprefix + " length not defined");
            return;
        }
        stagelength *= 1000;
        function_9cd899ba(localclientnum, bundle, stageprefix + "fb_", 0);
        function_9cd899ba(localclientnum, bundle, stageprefix + "dupfb_", 1);
        function_9cd899ba(localclientnum, bundle, stageprefix + "sonar_", 2);
        var_417f3f5 = enterstage && (!enterstage && var_7e1e79fe == 0 || looping && var_7e1e79fe == 1);
        accumtime = 0;
        prevtime = self getclienttime();
        while ((var_417f3f5 || accumtime < stagelength) && !self.var_53791ab9) {
            gfx::setstage(localclientnum, bundle, undefined, stageprefix, stagelength, accumtime, totalaccumtime, &function_a6aaa147);
            waitframe(1);
            currtime = self getclienttime();
            deltatime = currtime - prevtime;
            accumtime += deltatime;
            totalaccumtime += deltatime;
            prevtime = currtime;
            if (var_417f3f5) {
                while (accumtime >= stagelength) {
                    accumtime -= stagelength;
                }
                if (self.var_b908ab6c) {
                    var_417f3f5 = 0;
                    if (!finishlooponexit) {
                        break;
                    }
                }
            }
        }
        self disableduplicaterendering();
    }
    function_145785e5(localclientnum, "Finished " + playbundlename);
}

// Namespace namespace_9e20367a/duplicaterenderbundle
// Params 4, eflags: 0x0
// Checksum 0x8d92eb87, Offset: 0xa70
// Size: 0x1d4
function function_9cd899ba(localclientnum, bundle, prefix, type) {
    method = 0;
    var_c1436aeb = bundle.(prefix + "method");
    if (isdefined(var_c1436aeb)) {
        switch (var_c1436aeb) {
        case #"off":
            method = 0;
            break;
        case #"hash_3d6d0c23":
            method = 1;
            break;
        case #"hash_73beb527":
            method = 3;
            break;
        case #"hash_3debd2d2":
            method = 3;
            break;
        case #"thermal":
            method = 2;
            break;
        }
    }
    materialname = bundle.(prefix + "mc_material");
    materialid = -1;
    if (isdefined(materialname) && materialname != "") {
        materialname = "mc/" + materialname;
        materialid = filter::mapped_material_id(materialname);
        if (!isdefined(materialid)) {
            filter::map_material_helper_by_localclientnum(localclientnum, materialname);
            materialid = filter::mapped_material_id(materialname);
            if (!isdefined(materialid)) {
                materialid = -1;
            }
        }
    }
    self addduplicaterenderoption(type, method, materialid);
}

// Namespace namespace_9e20367a/duplicaterenderbundle
// Params 4, eflags: 0x0
// Checksum 0x80f7bb1e, Offset: 0xc50
// Size: 0x6c
function function_a6aaa147(localclientnum, var_402c9c53, filterid, values) {
    self mapshaderconstant(localclientnum, 0, var_402c9c53, values[0], values[1], values[2], values[3]);
}

// Namespace namespace_9e20367a/duplicaterenderbundle
// Params 2, eflags: 0x0
// Checksum 0x9318593c, Offset: 0xcc8
// Size: 0x64
function function_145785e5(localclientnum, msg) {
    /#
        if (isdefined(msg)) {
            println(msg);
        }
    #/
    self.var_53791ab9 = 0;
    self.var_b908ab6c = 0;
    self.var_33b1de58 = "";
}

// Namespace namespace_9e20367a/duplicaterenderbundle
// Params 0, eflags: 0x0
// Checksum 0xeadea46a, Offset: 0xd38
// Size: 0x2c
function function_1122e900() {
    if (self.var_33b1de58 != "") {
        function_503eb424();
    }
}

// Namespace namespace_9e20367a/duplicaterenderbundle
// Params 0, eflags: 0x0
// Checksum 0xe0f9cf50, Offset: 0xd70
// Size: 0x88
function function_503eb424() {
    if (!(isdefined(self.var_53791ab9) && self.var_53791ab9) && isdefined(self.var_33b1de58) && self.var_33b1de58 != "") {
        self.var_53791ab9 = 1;
        while (self.var_33b1de58 != "") {
            waitframe(1);
            if (!isdefined(self)) {
                return;
            }
        }
    }
}

// Namespace namespace_9e20367a/duplicaterenderbundle
// Params 0, eflags: 0x0
// Checksum 0x39668e4f, Offset: 0xe00
// Size: 0x5c
function function_b908ab6c() {
    if (!(isdefined(self.var_b908ab6c) && self.var_b908ab6c) && isdefined(self.var_33b1de58) && self.var_33b1de58 != "") {
        self.var_b908ab6c = 1;
    }
}

