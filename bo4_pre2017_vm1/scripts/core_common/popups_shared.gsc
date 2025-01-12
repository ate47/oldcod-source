#using scripts/core_common/callbacks_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/hud_message_shared;
#using scripts/core_common/medals_shared;
#using scripts/core_common/persistence_shared;
#using scripts/core_common/rank_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weapons;
#using scripts/core_common/weapons_shared;

#namespace popups;

// Namespace popups/popups_shared
// Params 0, eflags: 0x2
// Checksum 0xd618e6cf, Offset: 0x2a8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("popups", &__init__, undefined, undefined);
}

// Namespace popups/popups_shared
// Params 0, eflags: 0x0
// Checksum 0x335eee8f, Offset: 0x2e8
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace popups/popups_shared
// Params 0, eflags: 0x0
// Checksum 0x817572e3, Offset: 0x318
// Size: 0x254
function init() {
    level.contractsettings = spawnstruct();
    level.contractsettings.waittime = 4.2;
    level.killstreaksettings = spawnstruct();
    level.killstreaksettings.waittime = 3;
    level.ranksettings = spawnstruct();
    level.ranksettings.waittime = 3;
    level.startmessage = spawnstruct();
    level.startmessagedefaultduration = 2;
    level.endmessagedefaultduration = 2;
    level.challengesettings = spawnstruct();
    level.challengesettings.waittime = 3;
    level.teammessage = spawnstruct();
    level.teammessage.waittime = 3;
    level.var_b7c0bbe1 = spawnstruct();
    level.var_b7c0bbe1.waittime = 6;
    level.var_4b4bfc3a = spawnstruct();
    level.var_4b4bfc3a.waittime = 3;
    level.momentumnotifywaittime = 0;
    level.momentumnotifywaitlasttime = 0;
    level.teammessagequeuemax = 8;
    /#
        level thread popupsfromconsole();
        level thread devgui_notif_init();
    #/
    callback::on_connecting(&on_player_connect);
}

// Namespace popups/popups_shared
// Params 0, eflags: 0x0
// Checksum 0x613b4d13, Offset: 0x578
// Size: 0x44
function on_player_connect() {
    self.resetgameoverhudrequired = 0;
    self thread function_d3829eca();
    if (!level.hardcoremode) {
        self thread function_57624cb5();
    }
}

/#

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0xd8721b01, Offset: 0x5c8
    // Size: 0x54
    function devgui_notif_getgunleveltablename() {
        if (sessionmodeiscampaigngame()) {
            return "<dev string:x28>";
        }
        if (sessionmodeiszombiesgame()) {
            return "<dev string:x4d>";
        }
        return "<dev string:x72>";
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0xbeb9a02c, Offset: 0x628
    // Size: 0x4e
    function devgui_notif_getchallengestablecount() {
        if (sessionmodeiscampaigngame()) {
            return 4;
        }
        if (sessionmodeiszombiesgame()) {
            return 4;
        }
        return 6;
    }

    // Namespace popups/popups_shared
    // Params 1, eflags: 0x0
    // Checksum 0x4eaefdd8, Offset: 0x680
    // Size: 0x8a
    function devgui_notif_getchallengestablename(tableid) {
        if (sessionmodeiscampaigngame()) {
            return ("<dev string:x97>" + tableid + "<dev string:xb9>");
        }
        if (sessionmodeiszombiesgame()) {
            return ("<dev string:xbe>" + tableid + "<dev string:xb9>");
        }
        return "<dev string:xe0>" + tableid + "<dev string:xb9>";
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0xb01ec44a, Offset: 0x718
    // Size: 0x48
    function function_2358da67() {
        if (!isdefined(level.statstableid)) {
            level.statstableid = tablelookupfindcoreasset(util::function_bc37a245());
        }
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0x30050de5, Offset: 0x768
    // Size: 0x39a
    function devgui_create_weapon_levels_table() {
        level.tbl_weaponids = [];
        if (sessionmodeismultiplayergame()) {
            for (i = 0; i < 1024; i++) {
                iteminfo = getunlockableiteminfofromindex(i);
                if (isdefined(iteminfo)) {
                    group_s = iteminfo.itemgroupname;
                    if (issubstr(group_s, "<dev string:x102>") || group_s == "<dev string:x10a>") {
                        reference_s = iteminfo.name;
                        if (reference_s != "<dev string:x10f>") {
                            level.tbl_weaponids[i]["<dev string:x110>"] = reference_s;
                            level.tbl_weaponids[i]["<dev string:x11a>"] = group_s;
                            level.tbl_weaponids[i]["<dev string:x120>"] = iteminfo.count;
                            level.tbl_weaponids[i]["<dev string:x126>"] = iteminfo.attachments;
                        }
                    }
                }
            }
            return;
        }
        function_2358da67();
        if (!isdefined(level.statstableid)) {
            return;
        }
        for (i = 0; i < 1024; i++) {
            itemrow = tablelookuprownum(level.statstableid, 0, i);
            if (itemrow > -1) {
                group_s = tablelookupcolumnforrow(level.statstableid, itemrow, 2);
                if (issubstr(group_s, "<dev string:x102>") || group_s == "<dev string:x10a>") {
                    reference_s = tablelookupcolumnforrow(level.statstableid, itemrow, 4);
                    if (reference_s != "<dev string:x10f>") {
                        weapon = getweapon(reference_s);
                        level.tbl_weaponids[i]["<dev string:x110>"] = reference_s;
                        level.tbl_weaponids[i]["<dev string:x11a>"] = group_s;
                        level.tbl_weaponids[i]["<dev string:x120>"] = int(tablelookupcolumnforrow(level.statstableid, itemrow, 5));
                        level.tbl_weaponids[i]["<dev string:x126>"] = tablelookupcolumnforrow(level.statstableid, itemrow, 8);
                    }
                }
            }
        }
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0x52354cfb, Offset: 0xb10
    // Size: 0xec
    function devgui_notif_init() {
        setdvar("<dev string:x131>", 0);
        setdvar("<dev string:x147>", 0);
        setdvar("<dev string:x163>", 0);
        setdvar("<dev string:x18d>", 0);
        setdvar("<dev string:x1b1>", 0);
        if (isdedicated()) {
            return;
        }
        level thread notif_devgui_rank();
        level thread notif_devgui_gun_rank();
        if (!sessionmodeiscampaigngame()) {
            level thread notif_devgui_challenges();
        }
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0xb72b42ef, Offset: 0xc08
    // Size: 0x11c
    function notif_devgui_rank() {
        if (!isdefined(level.ranktable)) {
            return;
        }
        notif_rank_devgui_base = "<dev string:x1d2>";
        for (i = 1; i < level.ranktable.size; i++) {
            display_level = i + 1;
            if (display_level < 10) {
                display_level = "<dev string:x1fb>" + display_level;
            }
            util::waittill_can_add_debug_command();
            adddebugcommand(notif_rank_devgui_base + display_level + "<dev string:x1fd>" + "<dev string:x200>" + "<dev string:x131>" + "<dev string:x202>" + i + "<dev string:x204>");
        }
        waitframe(1);
        level thread notif_devgui_rank_up_think();
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1ec91f0a, Offset: 0xd30
    // Size: 0xb6
    function notif_devgui_rank_up_think() {
        for (;;) {
            rank_number = getdvarint("<dev string:x131>");
            if (rank_number == 0) {
                waitframe(1);
                continue;
            }
            level.players[0] rank::codecallback_rankup({#rank:rank_number, #prestige:0, #unlock_tokens_added:1});
            setdvar("<dev string:x131>", 0);
            wait 1;
        }
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0xb1020a6b, Offset: 0xdf0
    // Size: 0x824
    function notif_devgui_gun_rank() {
        notif_gun_rank_devgui_base = "<dev string:x208>";
        gunlevel_rankid_col = 0;
        gunlevel_gunref_col = 2;
        gunlevel_attachment_unlock_col = 3;
        gunlevel_xpgained_col = 4;
        level flag::wait_till("<dev string:x230>");
        if (!isdefined(level.tbl_weaponids)) {
            devgui_create_weapon_levels_table();
        }
        if (!isdefined(level.tbl_weaponids)) {
            return;
        }
        a_weapons = [];
        a_weapons["<dev string:x244>"] = [];
        a_weapons["<dev string:x24c>"] = [];
        a_weapons["<dev string:x250>"] = [];
        a_weapons["<dev string:x254>"] = [];
        a_weapons["<dev string:x25c>"] = [];
        a_weapons["<dev string:x263>"] = [];
        a_weapons["<dev string:x26a>"] = [];
        a_weapons["<dev string:x273>"] = [];
        gun_levels_table = devgui_notif_getgunleveltablename();
        foreach (weapon in level.tbl_weaponids) {
            gun = [];
            gun["<dev string:x279>"] = weapon["<dev string:x110>"];
            gun["<dev string:x27d>"] = getitemindexfromref(weapon["<dev string:x110>"]);
            gun["<dev string:x287>"] = [];
            gun_weapon_attachments = weapon["<dev string:x126>"];
            if (isdefined(gun_weapon_attachments) && isarray(gun_weapon_attachments)) {
                foreach (attachment in gun_weapon_attachments) {
                    gun["<dev string:x287>"][attachment] = [];
                    gun["<dev string:x287>"][attachment]["<dev string:x27d>"] = getattachmenttableindex(attachment);
                    gun["<dev string:x287>"][attachment]["<dev string:x293>"] = tablelookup(gun_levels_table, gunlevel_gunref_col, gun["<dev string:x279>"], gunlevel_attachment_unlock_col, attachment, gunlevel_rankid_col);
                    gun["<dev string:x287>"][attachment]["<dev string:x29a>"] = tablelookup(gun_levels_table, gunlevel_gunref_col, gun["<dev string:x279>"], gunlevel_attachment_unlock_col, attachment, gunlevel_xpgained_col);
                }
            }
            switch (weapon["<dev string:x11a>"]) {
            case #"weapon_pistol":
                if (weapon["<dev string:x110>"] != "<dev string:x2ab>") {
                    arrayinsert(a_weapons["<dev string:x263>"], gun, 0);
                }
                break;
            case #"weapon_launcher":
                arrayinsert(a_weapons["<dev string:x26a>"], gun, 0);
                break;
            case #"weapon_assault":
                arrayinsert(a_weapons["<dev string:x244>"], gun, 0);
                break;
            case #"weapon_smg":
                arrayinsert(a_weapons["<dev string:x24c>"], gun, 0);
                break;
            case #"weapon_lmg":
                arrayinsert(a_weapons["<dev string:x250>"], gun, 0);
                break;
            case #"weapon_cqb":
                arrayinsert(a_weapons["<dev string:x254>"], gun, 0);
                break;
            case #"weapon_sniper":
                arrayinsert(a_weapons["<dev string:x25c>"], gun, 0);
                break;
            case #"weapon_knife":
                arrayinsert(a_weapons["<dev string:x273>"], gun, 0);
                break;
            default:
                break;
            }
        }
        foreach (group_name, gun_group in a_weapons) {
            foreach (gun, attachment_group in gun_group) {
                foreach (attachment, attachment_data in attachment_group["<dev string:x287>"]) {
                    devgui_cmd_gun_path = notif_gun_rank_devgui_base + group_name + "<dev string:x312>" + gun_group[gun]["<dev string:x279>"] + "<dev string:x312>" + attachment;
                    util::waittill_can_add_debug_command();
                    adddebugcommand(devgui_cmd_gun_path + "<dev string:x1fd>" + "<dev string:x200>" + "<dev string:x314>" + "<dev string:x147>" + "<dev string:x202>" + attachment_data["<dev string:x29a>"] + "<dev string:x314>" + "<dev string:x163>" + "<dev string:x202>" + attachment_data["<dev string:x27d>"] + "<dev string:x314>" + "<dev string:x18d>" + "<dev string:x202>" + gun_group[gun]["<dev string:x27d>"] + "<dev string:x314>" + "<dev string:x1b1>" + "<dev string:x202>" + attachment_data["<dev string:x293>"] + "<dev string:x204>");
                }
            }
            waitframe(1);
        }
        level thread notif_devgui_gun_level_think();
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0x461e8a1b, Offset: 0x1620
    // Size: 0x176
    function notif_devgui_gun_level_think() {
        for (;;) {
            weapon_item_index = getdvarint("<dev string:x18d>");
            if (weapon_item_index == 0) {
                waitframe(1);
                continue;
            }
            xp_reward = getdvarint("<dev string:x147>");
            attachment_index = getdvarint("<dev string:x163>");
            rank_id = getdvarint("<dev string:x1b1>");
            level.players[0] persistence::codecallback_gunchallengecomplete({#reward:xp_reward, #attachment_index:attachment_index, #item_index:weapon_item_index, #rank_id:rank_id});
            setdvar("<dev string:x147>", 0);
            setdvar("<dev string:x163>", 0);
            setdvar("<dev string:x18d>", 0);
            setdvar("<dev string:x1b1>", 0);
            wait 1;
        }
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0xd362b726, Offset: 0x17a0
    // Size: 0x334
    function notif_devgui_challenges() {
        notif_challenges_devgui_base = "<dev string:x31a>";
        for (i = 1; i <= devgui_notif_getchallengestablecount(); i++) {
            tablename = devgui_notif_getchallengestablename(i);
            rows = tablelookuprowcount(tablename);
            for (j = 1; j < rows; j++) {
                challengeid = tablelookupcolumnforrow(tablename, j, 0);
                if (challengeid != "<dev string:x10f>" && strisint(tablelookupcolumnforrow(tablename, j, 0))) {
                    challengestring = tablelookupcolumnforrow(tablename, j, 5);
                    type = tablelookupcolumnforrow(tablename, j, 3);
                    challengetier = int(tablelookupcolumnforrow(tablename, j, 1));
                    challengetierstring = "<dev string:x10f>" + challengetier;
                    if (challengetier < 10) {
                        challengetierstring = "<dev string:x1fb>" + challengetier;
                    }
                    name = tablelookupcolumnforrow(tablename, j, 5);
                    devgui_cmd_challenge_path = notif_challenges_devgui_base + type + "<dev string:x312>" + makelocalizedstring(name) + "<dev string:x312>" + challengetierstring + "<dev string:x343>" + challengeid;
                    util::waittill_can_add_debug_command();
                    adddebugcommand(devgui_cmd_challenge_path + "<dev string:x1fd>" + "<dev string:x200>" + "<dev string:x314>" + "<dev string:x349>" + "<dev string:x202>" + j + "<dev string:x314>" + "<dev string:x368>" + "<dev string:x202>" + i + "<dev string:x204>");
                    if (int(challengeid) % 10) {
                        waitframe(1);
                    }
                }
            }
        }
        level thread notif_devgui_challenges_think();
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0x6da9791, Offset: 0x1ae0
    // Size: 0x386
    function notif_devgui_challenges_think() {
        setdvar("<dev string:x349>", 0);
        setdvar("<dev string:x368>", 0);
        for (;;) {
            row = getdvarint("<dev string:x349>");
            table = getdvarint("<dev string:x368>");
            if (table < 1 || table > devgui_notif_getchallengestablecount()) {
                waitframe(1);
                continue;
            }
            tablename = devgui_notif_getchallengestablename(table);
            if (row < 1 || row > tablelookuprowcount(tablename)) {
                waitframe(1);
                continue;
            }
            type = tablelookupcolumnforrow(tablename, row, 3);
            itemindex = 0;
            if (type == "<dev string:x389>") {
                type = 0;
            } else if (type == "<dev string:x11a>") {
                itemindex = 4;
                type = 3;
            } else if (type == "<dev string:x126>") {
                itemindex = 1;
                type = 4;
            } else if (type == "<dev string:x390>") {
                type = 2;
            } else if (type == "<dev string:x399>") {
                type = 5;
            } else {
                itemindex = 23;
                type = 1;
            }
            xpreward = int(tablelookupcolumnforrow(tablename, row, 6));
            challengeid = int(tablelookupcolumnforrow(tablename, row, 0));
            maxvalue = int(tablelookupcolumnforrow(tablename, row, 2));
            level.players[0] persistence::codecallback_challengecomplete({#reward:xpreward, #max:maxvalue, #row:row, #table_number:table - 1, #challenge_type:type, #item_index:itemindex, #challenge_index:challengeid});
            setdvar("<dev string:x349>", 0);
            setdvar("<dev string:x368>", 0);
            wait 1;
        }
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0x8d849902, Offset: 0x1e70
    // Size: 0x7c8
    function popupsfromconsole() {
        while (true) {
            timeout = getdvarfloat("<dev string:x3a4>", 1);
            if (timeout == 0) {
                timeout = 1;
            }
            wait timeout;
            medal = getdvarint("<dev string:x3b2>", 0);
            challenge = getdvarint("<dev string:x3c1>", 0);
            rank = getdvarint("<dev string:x3d4>", 0);
            gun = getdvarint("<dev string:x3e2>", 0);
            contractpass = getdvarint("<dev string:x3ef>", 0);
            contractfail = getdvarint("<dev string:x405>", 0);
            gamemodemsg = getdvarint("<dev string:x41b>", 0);
            teammsg = getdvarint("<dev string:x430>", 0);
            challengeindex = getdvarint("<dev string:x441>", 1);
            for (i = 0; i < medal; i++) {
                level.players[0] medals::codecallback_medal(86);
            }
            for (i = 0; i < challenge; i++) {
                level.players[0] persistence::codecallback_challengecomplete({#reward:1000, #max:10, #row:19, #table_numuber:0, #challenge_type:0, #item_index:0, #challenge_index:18});
                level.players[0] persistence::codecallback_challengecomplete({#reward:1000, #max:1, #row:21, #table_number:0, #challenge_type:0, #item_index:0, #challenge_index:20});
                rewardxp = 500;
                maxval = 1;
                row = 1;
                tablenumber = 0;
                challengetype = 1;
                itemindex = 111;
                challengeindex = 0;
                maxval = 50;
                row = 1;
                tablenumber = 2;
                challengetype = 1;
                itemindex = 20;
                challengeindex = 512;
                maxval = 150;
                row = 100;
                tablenumber = 2;
                challengetype = 4;
                itemindex = 1;
                challengeindex = 611;
                level.players[0] persistence::codecallback_challengecomplete({#reward:rewardxp, #max:maxval, #row:row, #table_number:tablenumber, #challenge_type:challengetype, #item_index:itemindex, #challenge_index:challengeindex});
            }
            for (i = 0; i < rank; i++) {
                level.players[0] rank::codecallback_rankup({#rank:4, #prestige:0, #unlock_tokens_added:1});
            }
            for (i = 0; i < gun; i++) {
                level.players[0] persistence::codecallback_gunchallengecomplete({#reward:0, #attachment_index:20, #item_index:25, #rank_id:0});
            }
            for (i = 0; i < contractpass; i++) {
                level.players[0] persistence::function_8e1fc5b5(12, 1);
            }
            for (i = 0; i < contractfail; i++) {
                level.players[0] persistence::function_8e1fc5b5(12, 0);
            }
            for (i = 0; i < teammsg; i++) {
                player = level.players[0];
                if (isdefined(level.players[1])) {
                    player = level.players[1];
                }
                level.players[0] displayteammessagetoall(%"<dev string:x454>", player);
            }
            reset = getdvarint("<dev string:x474>", 1);
            if (reset) {
                if (medal) {
                    setdvar("<dev string:x3b2>", 0);
                }
                if (challenge) {
                    setdvar("<dev string:x3c1>", 0);
                }
                if (gun) {
                    setdvar("<dev string:x3e2>", 0);
                }
                if (rank) {
                    setdvar("<dev string:x3d4>", 0);
                }
                if (contractpass) {
                    setdvar("<dev string:x3ef>", 0);
                }
                if (contractfail) {
                    setdvar("<dev string:x405>", 0);
                }
                if (gamemodemsg) {
                    setdvar("<dev string:x41b>", 0);
                }
                if (teammsg) {
                    setdvar("<dev string:x430>", 0);
                }
            }
        }
    }

#/

// Namespace popups/popups_shared
// Params 2, eflags: 0x0
// Checksum 0xfb97af50, Offset: 0x2640
// Size: 0x94
function displaykillstreakteammessagetoall(killstreak, player) {
    if (!isdefined(level.killstreaks[killstreak])) {
        return;
    }
    if (!isdefined(level.killstreaks[killstreak].inboundtext)) {
        return;
    }
    message = level.killstreaks[killstreak].inboundtext;
    self displayteammessagetoall(message, player);
}

// Namespace popups/popups_shared
// Params 2, eflags: 0x0
// Checksum 0xb551312c, Offset: 0x26e0
// Size: 0x94
function displaykillstreakhackedteammessagetoall(killstreak, player) {
    if (!isdefined(level.killstreaks[killstreak])) {
        return;
    }
    if (!isdefined(level.killstreaks[killstreak].hackedtext)) {
        return;
    }
    message = level.killstreaks[killstreak].hackedtext;
    self displayteammessagetoall(message, player);
}

// Namespace popups/popups_shared
// Params 0, eflags: 0x0
// Checksum 0xb1deff95, Offset: 0x2780
// Size: 0x34
function shoulddisplayteammessages() {
    if (level.hardcoremode == 1 || level.splitscreen == 1) {
        return false;
    }
    return true;
}

// Namespace popups/popups_shared
// Params 2, eflags: 0x0
// Checksum 0x17def4a1, Offset: 0x27c0
// Size: 0x146
function displayteammessagetoall(message, player) {
    if (!shoulddisplayteammessages()) {
        return;
    }
    for (i = 0; i < level.players.size; i++) {
        cur_player = level.players[i];
        if (cur_player isempjammed()) {
            continue;
        }
        size = cur_player.teammessagequeue.size;
        if (size >= level.teammessagequeuemax) {
            continue;
        }
        cur_player.teammessagequeue[size] = spawnstruct();
        cur_player.teammessagequeue[size].message = message;
        cur_player.teammessagequeue[size].player = player;
        cur_player notify(#"hash_f0fa2450");
    }
}

// Namespace popups/popups_shared
// Params 3, eflags: 0x0
// Checksum 0x62bb25e0, Offset: 0x2910
// Size: 0x166
function displayteammessagetoteam(message, player, team) {
    if (!shoulddisplayteammessages()) {
        return;
    }
    for (i = 0; i < level.players.size; i++) {
        cur_player = level.players[i];
        if (cur_player.team != team) {
            continue;
        }
        if (cur_player isempjammed()) {
            continue;
        }
        size = cur_player.teammessagequeue.size;
        if (size >= level.teammessagequeuemax) {
            continue;
        }
        cur_player.teammessagequeue[size] = spawnstruct();
        cur_player.teammessagequeue[size].message = message;
        cur_player.teammessagequeue[size].player = player;
        cur_player notify(#"hash_f0fa2450");
    }
}

// Namespace popups/popups_shared
// Params 0, eflags: 0x0
// Checksum 0xdcb16278, Offset: 0x2a80
// Size: 0x164
function function_57624cb5() {
    if (!shoulddisplayteammessages()) {
        return;
    }
    self endon(#"disconnect");
    level endon(#"game_ended");
    self.teammessagequeue = [];
    for (;;) {
        if (self.teammessagequeue.size == 0) {
            self waittill("received teammessage");
        }
        if (self.teammessagequeue.size > 0) {
            nextnotifydata = self.teammessagequeue[0];
            arrayremoveindex(self.teammessagequeue, 0, 0);
            if (!isdefined(nextnotifydata.player) || !isplayer(nextnotifydata.player)) {
                continue;
            }
            if (self isempjammed()) {
                continue;
            }
            self luinotifyevent(%player_callout, 2, nextnotifydata.message, nextnotifydata.player.entnum);
        }
        wait level.teammessage.waittime;
    }
}

// Namespace popups/popups_shared
// Params 0, eflags: 0x0
// Checksum 0x58b0e1ce, Offset: 0x2bf0
// Size: 0x25a
function function_d3829eca() {
    self endon(#"disconnect");
    self.var_74e3ed71 = [];
    if (!isdefined(self.pers["challengeNotifyQueue"])) {
        self.pers["challengeNotifyQueue"] = [];
    }
    if (!isdefined(self.pers["contractNotifyQueue"])) {
        self.pers["contractNotifyQueue"] = [];
    }
    self.var_4c9e757e = [];
    self.var_f57b5d00 = [];
    self.wagernotifyqueue = [];
    while (!level.gameended) {
        if (self.var_f57b5d00.size == 0 && self.var_4c9e757e.size == 0) {
            self waittill("received award");
        }
        waittillframeend();
        if (level.gameended) {
            break;
        }
        if (self.var_f57b5d00.size > 0) {
            nextnotifydata = self.var_f57b5d00[0];
            arrayremoveindex(self.var_f57b5d00, 0, 0);
            if (isdefined(nextnotifydata.duration)) {
                duration = nextnotifydata.duration;
            } else {
                duration = level.startmessagedefaultduration;
            }
            self hud_message::function_3cb967ea(nextnotifydata, duration);
            wait duration;
            continue;
        }
        if (self.var_4c9e757e.size > 0) {
            nextnotifydata = self.var_4c9e757e[0];
            arrayremoveindex(self.var_4c9e757e, 0, 0);
            if (isdefined(nextnotifydata.duration)) {
                duration = nextnotifydata.duration;
            } else {
                duration = level.var_b7c0bbe1.waittime;
            }
            self hud_message::function_3cb967ea(nextnotifydata, duration);
            continue;
        }
        wait 1;
    }
}

// Namespace popups/popups_shared
// Params 4, eflags: 0x0
// Checksum 0xc0a92327, Offset: 0x2e58
// Size: 0x12e
function function_e370e13e(index, itemindex, type, tier) {
    level.globalchallenges++;
    if (!isdefined(type)) {
        type = "global";
    }
    size = self.pers["challengeNotifyQueue"].size;
    self.pers["challengeNotifyQueue"][size] = [];
    self.pers["challengeNotifyQueue"][size]["tier"] = tier;
    self.pers["challengeNotifyQueue"][size]["index"] = index;
    self.pers["challengeNotifyQueue"][size]["itemIndex"] = itemindex;
    self.pers["challengeNotifyQueue"][size]["type"] = type;
    self notify(#"hash_2528173");
}

