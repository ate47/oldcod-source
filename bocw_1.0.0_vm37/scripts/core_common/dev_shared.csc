#using scripts\core_common\callbacks_shared;
#using scripts\core_common\util_shared;

#namespace dev_shared;

/#

    // Namespace dev_shared/dev_shared
    // Params 0, eflags: 0x2
    // Checksum 0x27913475, Offset: 0x70
    // Size: 0x44
    function autoexec init() {
        callback::on_localclient_connect(&function_b49b1b6b);
        self function_cbe4bccb();
    }

    // Namespace dev_shared/dev_shared
    // Params 1, eflags: 0x0
    // Checksum 0x45713180, Offset: 0xc0
    // Size: 0x27c
    function function_b49b1b6b(localclientnum) {
        var_39073e7a = undefined;
        var_b49b1b6b = undefined;
        a_effects = array("<dev string:x38>", "<dev string:x60>", "<dev string:x8e>", "<dev string:xb8>", "<dev string:xe6>", "<dev string:x117>", "<dev string:x148>");
        var_767a6d22 = 0;
        while (true) {
            n_dist = getdvarint(#"hash_4348ec71a8b13ef1", 0);
            var_114d05f = int(min(getdvarint(#"hash_4ead99200e3cc72c", 0), a_effects.size - 1));
            if (n_dist > 0) {
                if (var_114d05f != var_767a6d22 && isdefined(var_b49b1b6b)) {
                    killfx(localclientnum, var_b49b1b6b);
                    var_b49b1b6b = undefined;
                }
                if (!isdefined(var_39073e7a)) {
                    var_39073e7a = util::spawn_model(localclientnum, "<dev string:x181>");
                }
                if (!isdefined(var_b49b1b6b)) {
                    var_b49b1b6b = util::playfxontag(localclientnum, a_effects[var_114d05f], var_39073e7a, "<dev string:x181>");
                }
                v_pos = getcamposbylocalclientnum(localclientnum);
                v_ang = getcamanglesbylocalclientnum(localclientnum);
                v_forward = anglestoforward(v_ang);
                var_39073e7a.origin = v_pos + v_forward * n_dist;
                var_39073e7a.angles = v_ang;
            } else if (isdefined(var_39073e7a)) {
                killfx(localclientnum, var_b49b1b6b);
                var_39073e7a delete();
                var_b49b1b6b = undefined;
            }
            var_767a6d22 = var_114d05f;
            waitframe(1);
        }
    }

    // Namespace dev_shared/dev_shared
    // Params 3, eflags: 0x0
    // Checksum 0x73c5bc21, Offset: 0x348
    // Size: 0x5c
    function add_devgui_cmd(localclientnum, menu_path, cmds) {
        adddebugcommand(localclientnum, "<dev string:x18f>" + menu_path + "<dev string:x19f>" + cmds + "<dev string:x1a6>");
    }

    // Namespace dev_shared/dev_shared
    // Params 0, eflags: 0x0
    // Checksum 0x5d75ad26, Offset: 0x3b0
    // Size: 0x84
    function function_cbe4bccb() {
        self thread function_681e8519();
        self thread function_f3346975();
        add_devgui_cmd(0, "<dev string:x1ac>", "<dev string:x1d4>");
        add_devgui_cmd(0, "<dev string:x1e8>", "<dev string:x211>");
    }

    // Namespace dev_shared/dev_shared
    // Params 0, eflags: 0x0
    // Checksum 0x4af2f219, Offset: 0x440
    // Size: 0x2d0
    function function_f3346975() {
        mode = currentsessionmode();
        while (mode >= 4) {
            mode = currentsessionmode();
            wait 1;
        }
        bodies = getallcharacterbodies(mode);
        foreach (playerbodytype in bodies) {
            body_name = function_2c6232e5(makelocalizedstring(getcharacterdisplayname(playerbodytype, mode))) + "<dev string:x225>" + function_9e72a96(getcharacterassetname(playerbodytype, mode));
            add_devgui_cmd(0, "<dev string:x22a>" + body_name + "<dev string:x24d>", "<dev string:x259>" + playerbodytype + "<dev string:x26d>");
            var_13240050 = function_d299ef16(playerbodytype, mode);
            for (outfitindex = 0; outfitindex < var_13240050; outfitindex++) {
                var_9cf37283 = function_d7c3cf6c(playerbodytype, outfitindex, mode);
                if (var_9cf37283.valid) {
                    var_346660ac = function_2c6232e5(makelocalizedstring(var_9cf37283.var_74996050));
                    var_1bf829f2 = outfitindex + "<dev string:x225>" + var_346660ac + "<dev string:x225>" + function_9e72a96(var_9cf37283.namehash) + "<dev string:x273>" + outfitindex;
                    add_devgui_cmd(0, "<dev string:x22a>" + body_name + "<dev string:x278>" + var_1bf829f2, "<dev string:x259>" + playerbodytype + "<dev string:x27d>" + outfitindex);
                }
            }
        }
    }

    // Namespace dev_shared/dev_shared
    // Params 1, eflags: 0x0
    // Checksum 0xb88450, Offset: 0x718
    // Size: 0x44
    function function_2c6232e5(in_string) {
        out_string = strreplace(in_string, "<dev string:x273>", "<dev string:x282>");
        return out_string;
    }

    // Namespace dev_shared/dev_shared
    // Params 0, eflags: 0x0
    // Checksum 0x41e03d1d, Offset: 0x768
    // Size: 0x214
    function function_681e8519() {
        level endon(#"game_ended");
        a_weapons = enumerateweapons("<dev string:x286>");
        var_cab50ba0 = [];
        a_grenades = [];
        a_equipment = [];
        for (i = 0; i < a_weapons.size; i++) {
            if (strstartswith(getweaponname(a_weapons[i]), "<dev string:x290>")) {
                arrayinsert(a_equipment, a_weapons[i], 0);
                continue;
            }
            if (is_true(a_weapons[i].isprimary) && isdefined(a_weapons[i].worldmodel)) {
                arrayinsert(var_cab50ba0, a_weapons[i], 0);
                continue;
            }
            if (is_true(a_weapons[i].isgrenadeweapon)) {
                arrayinsert(a_grenades, a_weapons[i], 0);
            }
        }
        player_devgui_base = "<dev string:x297>";
        level thread function_30285c9c(player_devgui_base, "<dev string:x2af>", var_cab50ba0, "<dev string:x2cb>");
        level thread function_30285c9c(player_devgui_base, "<dev string:x2af>", a_grenades, "<dev string:x2d3>");
        level thread function_30285c9c(player_devgui_base, "<dev string:x2af>", a_equipment, "<dev string:x2df>");
    }

    // Namespace dev_shared/dev_shared
    // Params 4, eflags: 0x0
    // Checksum 0x9dd10364, Offset: 0x988
    // Size: 0x124
    function function_30285c9c(root, pname, a_weapons, weapon_type) {
        level endon(#"game_ended");
        player_devgui_root = root + pname + "<dev string:x278>";
        if (isdefined(a_weapons)) {
            for (i = 0; i < a_weapons.size; i++) {
                name = getweaponname(a_weapons[i]);
                displayname = a_weapons[i].displayname;
                if (displayname == #"") {
                    displayname = "<dev string:x2ec>";
                } else {
                    displayname = "<dev string:x2f3>" + makelocalizedstring(displayname) + "<dev string:x2f9>";
                }
                function_8c49f3a8(player_devgui_root, weapon_type, name, displayname);
            }
        }
    }

    // Namespace dev_shared/dev_shared
    // Params 4, eflags: 0x0
    // Checksum 0x473bbde7, Offset: 0xab8
    // Size: 0x7c
    function function_8c49f3a8(root, weapon_type, weap_name, displayname) {
        command = root + weapon_type + "<dev string:x278>" + weap_name + displayname + "<dev string:x2fe>" + weap_name + "<dev string:x30a>";
        adddebugcommand(0, command);
    }

#/
