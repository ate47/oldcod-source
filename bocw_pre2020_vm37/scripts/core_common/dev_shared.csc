#using scripts\core_common\callbacks_shared;
#using scripts\core_common\util_shared;

#namespace dev_shared;

/#

    // Namespace dev_shared/dev_shared
    // Params 0, eflags: 0x2
    // Checksum 0xaf758a77, Offset: 0x70
    // Size: 0x44
    function autoexec init() {
        callback::on_localclient_connect(&function_b49b1b6b);
        self function_cbe4bccb();
    }

    // Namespace dev_shared/dev_shared
    // Params 1, eflags: 0x0
    // Checksum 0xea5f0980, Offset: 0xc0
    // Size: 0x25c
    function function_b49b1b6b(localclientnum) {
        var_39073e7a = undefined;
        var_b49b1b6b = undefined;
        a_effects = array("<dev string:x38>", "<dev string:x60>", "<dev string:x8e>");
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
                    var_39073e7a = util::spawn_model(localclientnum, "<dev string:xbf>");
                }
                if (!isdefined(var_b49b1b6b)) {
                    var_b49b1b6b = util::playfxontag(localclientnum, a_effects[var_114d05f], var_39073e7a, "<dev string:xbf>");
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
    // Checksum 0x6618d1c8, Offset: 0x328
    // Size: 0x5c
    function add_devgui_cmd(localclientnum, menu_path, cmds) {
        adddebugcommand(localclientnum, "<dev string:xcd>" + menu_path + "<dev string:xdd>" + cmds + "<dev string:xe4>");
    }

    // Namespace dev_shared/dev_shared
    // Params 0, eflags: 0x0
    // Checksum 0x6158ebe0, Offset: 0x390
    // Size: 0x84
    function function_cbe4bccb() {
        self thread function_681e8519();
        self thread function_f3346975();
        add_devgui_cmd(0, "<dev string:xea>", "<dev string:x112>");
        add_devgui_cmd(0, "<dev string:x126>", "<dev string:x14f>");
    }

    // Namespace dev_shared/dev_shared
    // Params 0, eflags: 0x0
    // Checksum 0xce01f553, Offset: 0x420
    // Size: 0x2d0
    function function_f3346975() {
        mode = currentsessionmode();
        while (mode >= 4) {
            mode = currentsessionmode();
            wait 1;
        }
        bodies = getallcharacterbodies(mode);
        foreach (playerbodytype in bodies) {
            body_name = function_2c6232e5(makelocalizedstring(getcharacterdisplayname(playerbodytype, mode))) + "<dev string:x163>" + function_9e72a96(getcharacterassetname(playerbodytype, mode));
            add_devgui_cmd(0, "<dev string:x168>" + body_name + "<dev string:x18b>", "<dev string:x197>" + playerbodytype + "<dev string:x1ab>");
            var_13240050 = function_d299ef16(playerbodytype, mode);
            for (outfitindex = 0; outfitindex < var_13240050; outfitindex++) {
                var_9cf37283 = function_d7c3cf6c(playerbodytype, outfitindex, mode);
                if (var_9cf37283.valid) {
                    var_346660ac = function_2c6232e5(makelocalizedstring(var_9cf37283.var_74996050));
                    var_1bf829f2 = outfitindex + "<dev string:x163>" + var_346660ac + "<dev string:x163>" + function_9e72a96(var_9cf37283.namehash) + "<dev string:x1b1>" + outfitindex;
                    add_devgui_cmd(0, "<dev string:x168>" + body_name + "<dev string:x1b6>" + var_1bf829f2, "<dev string:x197>" + playerbodytype + "<dev string:x1bb>" + outfitindex);
                }
            }
        }
    }

    // Namespace dev_shared/dev_shared
    // Params 1, eflags: 0x0
    // Checksum 0x1f086612, Offset: 0x6f8
    // Size: 0x44
    function function_2c6232e5(in_string) {
        out_string = strreplace(in_string, "<dev string:x1b1>", "<dev string:x1c0>");
        return out_string;
    }

    // Namespace dev_shared/dev_shared
    // Params 0, eflags: 0x0
    // Checksum 0xd0eadef6, Offset: 0x748
    // Size: 0x214
    function function_681e8519() {
        level endon(#"game_ended");
        a_weapons = enumerateweapons("<dev string:x1c4>");
        var_cab50ba0 = [];
        a_grenades = [];
        a_equipment = [];
        for (i = 0; i < a_weapons.size; i++) {
            if (strstartswith(getweaponname(a_weapons[i]), "<dev string:x1ce>")) {
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
        player_devgui_base = "<dev string:x1d5>";
        level thread function_30285c9c(player_devgui_base, "<dev string:x1ed>", var_cab50ba0, "<dev string:x209>");
        level thread function_30285c9c(player_devgui_base, "<dev string:x1ed>", a_grenades, "<dev string:x211>");
        level thread function_30285c9c(player_devgui_base, "<dev string:x1ed>", a_equipment, "<dev string:x21d>");
    }

    // Namespace dev_shared/dev_shared
    // Params 4, eflags: 0x0
    // Checksum 0xec1b20ec, Offset: 0x968
    // Size: 0x124
    function function_30285c9c(root, pname, a_weapons, weapon_type) {
        level endon(#"game_ended");
        player_devgui_root = root + pname + "<dev string:x1b6>";
        if (isdefined(a_weapons)) {
            for (i = 0; i < a_weapons.size; i++) {
                name = getweaponname(a_weapons[i]);
                displayname = a_weapons[i].displayname;
                if (displayname == #"") {
                    displayname = "<dev string:x22a>";
                } else {
                    displayname = "<dev string:x231>" + makelocalizedstring(displayname) + "<dev string:x237>";
                }
                function_8c49f3a8(player_devgui_root, weapon_type, name, displayname);
            }
        }
    }

    // Namespace dev_shared/dev_shared
    // Params 4, eflags: 0x0
    // Checksum 0x3777f016, Offset: 0xa98
    // Size: 0x7c
    function function_8c49f3a8(root, weapon_type, weap_name, displayname) {
        command = root + weapon_type + "<dev string:x1b6>" + weap_name + displayname + "<dev string:x23c>" + weap_name + "<dev string:x248>";
        adddebugcommand(0, command);
    }

#/
