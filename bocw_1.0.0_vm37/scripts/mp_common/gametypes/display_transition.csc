#using scripts\core_common\array_shared;
#using scripts\core_common\character_customization;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;

#namespace display_transition;

// Namespace display_transition/display_transition
// Params 0, eflags: 0x0
// Checksum 0x19c7b2cd, Offset: 0x170
// Size: 0x2c
function init_shared() {
    registerclientfields();
    level thread function_57e7e78e();
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x4
// Checksum 0x9f0dbea2, Offset: 0x1a8
// Size: 0xfc
function private registerclientfields() {
    if (sessionmodeiswarzonegame()) {
        clientfield::register("toplayer", "eliminated_postfx", 12000, 1, "int", &function_c73ec9a, 0, 0);
    }
    if (sessionmodeismultiplayergame()) {
        clientfield::register("world", "top_squad_begin", 1, 1, "int", &function_7adce590, 0, 0);
        clientfield::register("world", "hero_pose_begin", 1, 1, "int", &function_5628ce8, 0, 0);
    }
}

// Namespace display_transition/display_transition
// Params 7, eflags: 0x0
// Checksum 0x749827cf, Offset: 0x2b0
// Size: 0xd4
function function_c73ec9a(*local_client_num, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    isplaying = postfx::function_556665f2(#"hash_1e4c3120a3e08628");
    if (bwastimejump == 1) {
        if (!isplaying) {
            self codeplaypostfxbundle(#"hash_1e4c3120a3e08628");
        }
        return;
    }
    if (bwastimejump == 0) {
        if (isplaying) {
            self postfx::stoppostfxbundle(#"hash_1e4c3120a3e08628");
        }
    }
}

// Namespace display_transition/display_transition
// Params 0, eflags: 0x0
// Checksum 0x5e2809ae, Offset: 0x390
// Size: 0x1ac
function function_57e7e78e() {
    level endon(#"disconnect", #"game_ended");
    while (true) {
        waitresult = level waittill(#"hash_15feb9f40beffb1");
        xuids = associativearray();
        xuids[#"hash_71fa255feba2b605"] = util::function_48e57e36(waitresult.var_e278dfff);
        xuids[#"hash_71fa225feba2b0ec"] = util::function_48e57e36(waitresult.var_849e244b);
        xuids[#"hash_71fa235feba2b29f"] = util::function_48e57e36(waitresult.var_76e408d7);
        xuids[#"hash_71fa205feba2ad86"] = util::function_48e57e36(waitresult.var_a926ed5c);
        xuids[#"hash_71fa215feba2af39"] = util::function_48e57e36(waitresult.var_6f687a0c);
        xuids[#"hash_71fa1e5feba2aa20"] = util::function_48e57e36(waitresult.var_61a2de81);
        level.var_3e8dfeeb = xuids;
    }
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x4
// Checksum 0x92c2e5ab, Offset: 0x548
// Size: 0x9a
function private function_d4f9edc8(character_index, session_mode) {
    if (!function_f4bf7e3f(character_index, session_mode)) {
        return false;
    }
    var_4fa755f8 = getcharacterfields(character_index, session_mode);
    if (isdefined(var_4fa755f8) && isdefined(var_4fa755f8.requireddvar) && !getdvarint(var_4fa755f8.requireddvar, 0)) {
        return false;
    }
    return true;
}

// Namespace display_transition/display_transition
// Params 3, eflags: 0x4
// Checksum 0x1ab409d9, Offset: 0x5f0
// Size: 0xb8
function private function_707c958c(local_client_num, var_23904c1d, target_name) {
    if (isdefined(var_23904c1d)) {
        model = util::spawn_model(local_client_num, "tag_origin");
        model.targetname = target_name;
        var_d0b01271 = character_customization::function_dd295310(model, local_client_num, 0);
        [[ var_d0b01271 ]]->function_15a8906a(var_23904c1d);
        [[ var_d0b01271 ]]->update();
        [[ var_d0b01271 ]]->show_model();
        return var_d0b01271;
    }
    return undefined;
}

// Namespace display_transition/display_transition
// Params 3, eflags: 0x4
// Checksum 0xfe84b951, Offset: 0x6b0
// Size: 0x102
function private function_c4ede3a8(local_client_num, target_name, session_mode) {
    var_a2865de6 = getplayerroletemplatecount(session_mode);
    character_index = randomint(var_a2865de6);
    for (var_f8bfe003 = function_d4f9edc8(character_index, session_mode); !var_f8bfe003; var_f8bfe003 = function_d4f9edc8(character_index, session_mode)) {
        character_index = randomint(var_a2865de6);
    }
    var_23904c1d = character_customization::function_3f5625f1(session_mode, character_index);
    custom_character = function_707c958c(local_client_num, var_23904c1d, target_name);
    return custom_character;
}

// Namespace display_transition/display_transition
// Params 3, eflags: 0x4
// Checksum 0x331a954d, Offset: 0x7c0
// Size: 0x62
function private function_1b0611e0(local_client_num, xuid, target_name) {
    var_23904c1d = getcharactercustomizationforxuid(local_client_num, xuid);
    custom_character = function_707c958c(local_client_num, var_23904c1d, target_name);
    return custom_character;
}

// Namespace display_transition/display_transition
// Params 2, eflags: 0x4
// Checksum 0xc024c8d0, Offset: 0x830
// Size: 0x68
function private function_4259f9f8(local_client_num, target_name) {
    model = util::spawn_model(local_client_num, "tag_origin");
    model.targetname = target_name;
    model useanimtree("all_player");
    return model;
}

// Namespace display_transition/display_transition
// Params 7, eflags: 0x0
// Checksum 0x7e379130, Offset: 0x8a0
// Size: 0x25c
function function_7adce590(local_client_num, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    var_ec067cd3 = array();
    if (isdefined(level.var_3e8dfeeb)) {
        foreach (key, xuid in level.var_3e8dfeeb) {
            if (xuid != 0) {
                custom_character = function_1b0611e0(bwastimejump, xuid, "top_squad_" + key);
                array::add(var_ec067cd3, [[ custom_character ]]->function_217b10ed());
                continue;
            }
            if (getdvarint(#"hash_6d98441d0465c104", 0)) {
                /#
                    custom_character = function_c4ede3a8(bwastimejump, "<dev string:x38>" + key, 1);
                    array::add(var_ec067cd3, [[ custom_character ]]->function_217b10ed());
                #/
                continue;
            }
            fake_model = function_4259f9f8(bwastimejump, "top_squad_ " + key);
            array::add(var_ec067cd3, fake_model);
        }
        var_5acf682c = function_4259f9f8(bwastimejump, "top_squad_cam");
        array::add(var_ec067cd3, var_5acf682c);
    }
    level scene::play("cin_mp_outro", var_ec067cd3);
}

// Namespace display_transition/display_transition
// Params 7, eflags: 0x0
// Checksum 0x8f944e73, Offset: 0xb08
// Size: 0xcc
function function_5628ce8(local_client_num, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    for (i = 0; i < 3; i++) {
        setuimodelvalue(createuimodel(function_1df4c3b0(bwastimejump, #"hash_167abb754a193f02"), "heroPoseClientNum"), i);
        level scene::play("mtx_hero_pose_test_01");
    }
}

