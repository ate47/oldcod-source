#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\medals_shared;
#using scripts\core_common\persistence_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace popups;

// Namespace popups/popups_shared
// Params 0, eflags: 0x2
// Checksum 0x335bcf47, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"popups", &__init__, undefined, undefined);
}

// Namespace popups/popups_shared
// Params 0, eflags: 0x0
// Checksum 0x2c85e634, Offset: 0xf0
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace popups/popups_shared
// Params 0, eflags: 0x0
// Checksum 0x10c40a7b, Offset: 0x120
// Size: 0x1ec
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
    level.momentumnotifywaittime = 0;
    level.momentumnotifywaitlasttime = 0;
    level.teammessagequeuemax = 8;
    /#
        level thread popupsfromconsole();
        level thread devgui_notif_init();
    #/
    callback::on_connecting(&on_player_connect);
    callback::add_callback(#"team_message", &on_team_message);
}

// Namespace popups/popups_shared
// Params 0, eflags: 0x0
// Checksum 0x1317f8b6, Offset: 0x318
// Size: 0x3a
function on_player_connect() {
    self.resetgameoverhudrequired = 0;
    if (!level.hardcoremode) {
        if (shoulddisplayteammessages()) {
            self.teammessagequeue = [];
        }
    }
}

/#

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0x6c7f87fd, Offset: 0x360
    // Size: 0x64
    function devgui_notif_getgunleveltablename() {
        if (sessionmodeiscampaigngame()) {
            return #"gamedata/weapons/cp/cp_gunlevels.csv";
        }
        if (sessionmodeiszombiesgame()) {
            return #"gamedata/weapons/zm/zm_gunlevels.csv";
        }
        return #"gamedata/weapons/mp/mp_gunlevels.csv";
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0xaa8348df, Offset: 0x3d0
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
    // Checksum 0xb52a1ef5, Offset: 0x428
    // Size: 0x9a
    function devgui_notif_getchallengestablename(tableid) {
        if (sessionmodeiscampaigngame()) {
            return (#"gamedata/stats/cp/statsmilestones" + tableid + "<dev string:x30>");
        }
        if (sessionmodeiszombiesgame()) {
            return (#"gamedata/stats/zm/statsmilestones" + tableid + "<dev string:x30>");
        }
        return #"gamedata/stats/mp/statsmilestones" + tableid + "<dev string:x30>";
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0x6f0a3527, Offset: 0x4d0
    // Size: 0x18a
    function devgui_create_weapon_levels_table() {
        level.tbl_weaponids = [];
        for (i = 0; i < 1024; i++) {
            iteminfo = getunlockableiteminfofromindex(i, 0);
            if (isdefined(iteminfo)) {
                group_s = iteminfo.itemgroupname;
                if (issubstr(group_s, "<dev string:x35>") || group_s == "<dev string:x3d>") {
                    reference_s = iteminfo.namehash;
                    if (reference_s != "<dev string:x42>") {
                        level.tbl_weaponids[i][#"reference"] = reference_s;
                        level.tbl_weaponids[i][#"group"] = group_s;
                        level.tbl_weaponids[i][#"count"] = iteminfo.count;
                        level.tbl_weaponids[i][#"attachment"] = iteminfo.attachments;
                    }
                }
            }
        }
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa2d2803e, Offset: 0x668
    // Size: 0x124
    function devgui_notif_init() {
        setdvar(#"scr_notif_devgui_rank", 0);
        setdvar(#"scr_notif_devgui_gun_lvl_xp", 0);
        setdvar(#"scr_notif_devgui_gun_lvl_attachment_index", 0);
        setdvar(#"scr_notif_devgui_gun_lvl_item_index", 0);
        setdvar(#"scr_notif_devgui_gun_lvl_rank_id", 0);
        if (isdedicated()) {
            return;
        }
        if (getdvarint(#"hash_300689cb3bb5ab4d", 0) > 0) {
            return;
        }
        util::add_devgui("<dev string:x43>", "<dev string:x64>");
        level thread function_4aef816f();
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0x139d49c1, Offset: 0x798
    // Size: 0x84
    function function_4aef816f() {
        level endon(#"game_ended");
        while (true) {
            if (getdvarint(#"hash_300689cb3bb5ab4d", 0) > 0) {
                util::remove_devgui("<dev string:x86>");
                function_75ec4023();
                return;
            }
            wait 1;
        }
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0xd1ac7b29, Offset: 0x828
    // Size: 0x5c
    function function_75ec4023() {
        level thread notif_devgui_rank();
        level thread notif_devgui_gun_rank();
        if (!sessionmodeiscampaigngame()) {
            level thread notif_devgui_challenges();
        }
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0x59952adc, Offset: 0x890
    // Size: 0x10c
    function notif_devgui_rank() {
        if (!isdefined(level.ranktable)) {
            return;
        }
        notif_rank_devgui_base = "<dev string:xa9>";
        for (i = 1; i < level.ranktable.size; i++) {
            display_level = i + 1;
            if (display_level < 10) {
                display_level = "<dev string:xd2>" + display_level;
            }
            util::waittill_can_add_debug_command();
            adddebugcommand(notif_rank_devgui_base + display_level + "<dev string:xd4>" + "<dev string:xd7>" + "<dev string:xd9>" + "<dev string:xef>" + i + "<dev string:xf1>");
        }
        waitframe(1);
        level thread notif_devgui_rank_up_think();
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0xbc35a215, Offset: 0x9a8
    // Size: 0xce
    function notif_devgui_rank_up_think() {
        for (;;) {
            rank_number = getdvarint(#"scr_notif_devgui_rank", 0);
            if (rank_number == 0) {
                waitframe(1);
                continue;
            }
            level.players[0] rank::codecallback_rankup({#rank:rank_number, #prestige:0, #unlock_tokens_added:1});
            setdvar(#"scr_notif_devgui_rank", 0);
            wait 1;
        }
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa480fa34, Offset: 0xa80
    // Size: 0x9a4
    function notif_devgui_gun_rank() {
        notif_gun_rank_devgui_base = "<dev string:xf5>";
        gunlevel_rankid_col = 0;
        gunlevel_gunref_col = 2;
        gunlevel_attachment_unlock_col = 3;
        gunlevel_xpgained_col = 4;
        level flag::wait_till("<dev string:x11d>");
        if (!isdefined(level.tbl_weaponids)) {
            devgui_create_weapon_levels_table();
        }
        if (!isdefined(level.tbl_weaponids)) {
            return;
        }
        a_weapons = [];
        a_weapons[#"assault"] = [];
        a_weapons[#"tactical"] = [];
        a_weapons[#"smg"] = [];
        a_weapons[#"lmg"] = [];
        a_weapons[#"shotgun"] = [];
        a_weapons[#"sniper"] = [];
        a_weapons[#"pistol"] = [];
        a_weapons[#"launcher"] = [];
        a_weapons[#"knife"] = [];
        gun_levels_table = devgui_notif_getgunleveltablename();
        foreach (weapon in level.tbl_weaponids) {
            gun = [];
            gun[#"ref"] = weapon[#"reference"];
            gun[#"itemindex"] = getitemindexfromref(weapon[#"reference"]);
            gun[#"attachments"] = [];
            gun_weapon_attachments = weapon[#"attachment"];
            if (isdefined(gun_weapon_attachments) && isarray(gun_weapon_attachments)) {
                foreach (attachment in gun_weapon_attachments) {
                    gun[#"attachments"][attachment] = [];
                    gun[#"attachments"][attachment][#"itemindex"] = getattachmenttableindex(attachment);
                    gun[#"attachments"][attachment][#"rankid"] = tablelookup(gun_levels_table, gunlevel_gunref_col, gun[#"ref"], gunlevel_attachment_unlock_col, attachment, gunlevel_rankid_col);
                    gun[#"attachments"][attachment][#"xp"] = tablelookup(gun_levels_table, gunlevel_gunref_col, gun[#"ref"], gunlevel_attachment_unlock_col, attachment, gunlevel_xpgained_col);
                }
            }
            switch (weapon[#"group"]) {
            case #"weapon_pistol":
                if (weapon[#"reference"] != "<dev string:x131>") {
                    arrayinsert(a_weapons[#"pistol"], gun, 0);
                }
                break;
            case #"weapon_launcher":
                arrayinsert(a_weapons[#"launcher"], gun, 0);
                break;
            case #"weapon_assault":
                arrayinsert(a_weapons[#"assault"], gun, 0);
                break;
            case #"weapon_tactical":
                arrayinsert(a_weapons[#"tactical"], gun, 0);
                break;
            case #"weapon_smg":
                arrayinsert(a_weapons[#"smg"], gun, 0);
                break;
            case #"weapon_lmg":
                arrayinsert(a_weapons[#"lmg"], gun, 0);
                break;
            case #"weapon_cqb":
                arrayinsert(a_weapons[#"shotgun"], gun, 0);
                break;
            case #"weapon_sniper":
                arrayinsert(a_weapons[#"sniper"], gun, 0);
                break;
            case #"weapon_knife":
                arrayinsert(a_weapons[#"knife"], gun, 0);
                break;
            default:
                break;
            }
        }
        foreach (group_name, gun_group in a_weapons) {
            foreach (gun, attachment_group in gun_group) {
                foreach (attachment, attachment_data in attachment_group[#"attachments"]) {
                    devgui_cmd_gun_path = notif_gun_rank_devgui_base + function_15979fa9(group_name) + "<dev string:x13d>" + function_15979fa9(gun_group[gun][#"ref"]) + "<dev string:x13d>" + function_15979fa9(attachment);
                    util::waittill_can_add_debug_command();
                    adddebugcommand(devgui_cmd_gun_path + "<dev string:xd4>" + "<dev string:xd7>" + "<dev string:x13f>" + "<dev string:x145>" + "<dev string:xef>" + attachment_data[#"xp"] + "<dev string:x13f>" + "<dev string:x161>" + "<dev string:xef>" + attachment_data[#"itemindex"] + "<dev string:x13f>" + "<dev string:x18b>" + "<dev string:xef>" + gun_group[gun][#"itemindex"] + "<dev string:x13f>" + "<dev string:x1af>" + "<dev string:xef>" + attachment_data[#"rankid"] + "<dev string:xf1>");
                }
            }
            waitframe(1);
        }
        level thread notif_devgui_gun_level_think();
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0xdf79b07, Offset: 0x1430
    // Size: 0x1c6
    function notif_devgui_gun_level_think() {
        for (;;) {
            weapon_item_index = getdvarint(#"scr_notif_devgui_gun_lvl_item_index", 0);
            if (weapon_item_index == 0) {
                waitframe(1);
                continue;
            }
            xp_reward = getdvarint(#"scr_notif_devgui_gun_lvl_xp", 0);
            attachment_index = getdvarint(#"scr_notif_devgui_gun_lvl_attachment_index", 0);
            rank_id = getdvarint(#"scr_notif_devgui_gun_lvl_rank_id", 0);
            level.players[0] persistence::codecallback_gunchallengecomplete({#reward:xp_reward, #attachment_index:attachment_index, #item_index:weapon_item_index, #rank_id:rank_id});
            setdvar(#"scr_notif_devgui_gun_lvl_xp", 0);
            setdvar(#"scr_notif_devgui_gun_lvl_attachment_index", 0);
            setdvar(#"scr_notif_devgui_gun_lvl_item_index", 0);
            setdvar(#"scr_notif_devgui_gun_lvl_rank_id", 0);
            wait 1;
        }
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0xb1c87256, Offset: 0x1600
    // Size: 0x304
    function notif_devgui_challenges() {
        notif_challenges_devgui_base = "<dev string:x1d0>";
        for (i = 1; i <= devgui_notif_getchallengestablecount(); i++) {
            tablename = devgui_notif_getchallengestablename(i);
            rows = tablelookuprowcount(tablename);
            for (j = 1; j < rows; j++) {
                challengeid = tablelookupcolumnforrow(tablename, j, 0);
                if (challengeid != "<dev string:x42>" && strisint(tablelookupcolumnforrow(tablename, j, 0))) {
                    challengestring = tablelookupcolumnforrow(tablename, j, 5);
                    type = tablelookupcolumnforrow(tablename, j, 3);
                    challengetier = int(tablelookupcolumnforrow(tablename, j, 1));
                    challengetierstring = "<dev string:x42>" + challengetier;
                    if (challengetier < 10) {
                        challengetierstring = "<dev string:xd2>" + challengetier;
                    }
                    name = tablelookupcolumnforrow(tablename, j, 5);
                    devgui_cmd_challenge_path = notif_challenges_devgui_base + type + "<dev string:x13d>" + name + "<dev string:x13d>" + challengetierstring + "<dev string:x1f9>" + challengeid;
                    util::waittill_can_add_debug_command();
                    adddebugcommand(devgui_cmd_challenge_path + "<dev string:xd4>" + "<dev string:xd7>" + "<dev string:x13f>" + "<dev string:x1ff>" + "<dev string:xef>" + j + "<dev string:x13f>" + "<dev string:x21e>" + "<dev string:xef>" + i + "<dev string:xf1>");
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
    // Checksum 0xa1e1dd08, Offset: 0x1910
    // Size: 0x3ae
    function notif_devgui_challenges_think() {
        setdvar(#"scr_notif_devgui_challenge_row", 0);
        setdvar(#"scr_notif_devgui_challenge_table", 0);
        for (;;) {
            row = getdvarint(#"scr_notif_devgui_challenge_row", 0);
            table = getdvarint(#"scr_notif_devgui_challenge_table", 0);
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
            if (type == "<dev string:x23f>") {
                type = 0;
            } else if (type == "<dev string:x246>") {
                itemindex = 4;
                type = 3;
            } else if (type == "<dev string:x24c>") {
                itemindex = 1;
                type = 4;
            } else if (type == "<dev string:x257>") {
                type = 2;
            } else if (type == "<dev string:x260>") {
                type = 5;
            } else {
                itemindex = 23;
                type = 1;
            }
            xpreward = int(tablelookupcolumnforrow(tablename, row, 6));
            challengeid = int(tablelookupcolumnforrow(tablename, row, 0));
            maxvalue = int(tablelookupcolumnforrow(tablename, row, 2));
            level.players[0] persistence::codecallback_challengecomplete({#reward:xpreward, #max:maxvalue, #row:row, #table_number:table - 1, #challenge_type:type, #item_index:itemindex, #challenge_index:challengeid});
            setdvar(#"scr_notif_devgui_challenge_row", 0);
            setdvar(#"scr_notif_devgui_challenge_table", 0);
            wait 1;
        }
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0x4d44678, Offset: 0x1cc8
    // Size: 0x7f8
    function popupsfromconsole() {
        while (true) {
            timeout = getdvarfloat(#"scr_popuptime", 1);
            if (timeout == 0) {
                timeout = 1;
            }
            wait timeout;
            medal = getdvarint(#"scr_popupmedal", 0);
            challenge = getdvarint(#"scr_popupchallenge", 0);
            rank = getdvarint(#"scr_popuprank", 0);
            gun = getdvarint(#"scr_popupgun", 0);
            contractpass = getdvarint(#"scr_popupcontractpass", 0);
            contractfail = getdvarint(#"scr_popupcontractfail", 0);
            gamemodemsg = getdvarint(#"scr_gamemodeslideout", 0);
            teammsg = getdvarint(#"scr_teamslideout", 0);
            challengeindex = getdvarint(#"scr_challengeindex", 1);
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
            for (i = 0; i < teammsg; i++) {
                player = level.players[0];
                if (isdefined(level.players[1])) {
                    player = level.players[1];
                }
                level.players[0] displayteammessagetoall(#"hash_286f843fea185e5", player);
            }
            reset = getdvarint(#"scr_popupreset", 1);
            if (reset) {
                if (medal) {
                    setdvar(#"scr_popupmedal", 0);
                }
                if (challenge) {
                    setdvar(#"scr_popupchallenge", 0);
                }
                if (gun) {
                    setdvar(#"scr_popupgun", 0);
                }
                if (rank) {
                    setdvar(#"scr_popuprank", 0);
                }
                if (contractpass) {
                    setdvar(#"scr_popupcontractpass", 0);
                }
                if (contractfail) {
                    setdvar(#"scr_popupcontractfail", 0);
                }
                if (gamemodemsg) {
                    setdvar(#"scr_gamemodeslideout", 0);
                }
                if (teammsg) {
                    setdvar(#"scr_teamslideout", 0);
                }
            }
        }
    }

#/

// Namespace popups/popups_shared
// Params 2, eflags: 0x0
// Checksum 0x4a7210eb, Offset: 0x24c8
// Size: 0x84
function displaykillstreakteammessagetoall(killstreak, player) {
    if (!isdefined(level.killstreaks[killstreak])) {
        return;
    }
    if (!isdefined(level.killstreaks[killstreak].var_3e3825f6)) {
        return;
    }
    message = level.killstreaks[killstreak].var_3e3825f6;
    self displayteammessagetoall(message, player);
}

// Namespace popups/popups_shared
// Params 2, eflags: 0x0
// Checksum 0x4a9275da, Offset: 0x2558
// Size: 0x84
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
// Checksum 0x1385c337, Offset: 0x25e8
// Size: 0x36
function shoulddisplayteammessages() {
    if (level.hardcoremode == 1 || level.splitscreen == 1) {
        return false;
    }
    return true;
}

// Namespace popups/popups_shared
// Params 0, eflags: 0x0
// Checksum 0xa1a0c9ad, Offset: 0x2628
// Size: 0x34
function function_d161c284() {
    self notify(#"received teammessage");
    self callback::callback(#"team_message");
}

// Namespace popups/popups_shared
// Params 2, eflags: 0x0
// Checksum 0x28d19424, Offset: 0x2668
// Size: 0x136
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
        cur_player function_d161c284();
    }
}

// Namespace popups/popups_shared
// Params 5, eflags: 0x0
// Checksum 0x3a6c49f7, Offset: 0x27a8
// Size: 0x1a6
function displayteammessagetoteam(message, player, team, optionalarg, var_c46f27a1) {
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
        cur_player.teammessagequeue[size].optionalarg = optionalarg;
        cur_player.teammessagequeue[size].var_c46f27a1 = var_c46f27a1;
        cur_player function_d161c284();
    }
}

// Namespace popups/popups_shared
// Params 0, eflags: 0x0
// Checksum 0x96732918, Offset: 0x2958
// Size: 0x2c
function on_team_message() {
    if (!shoulddisplayteammessages()) {
        return;
    }
    function_a70085ff();
}

// Namespace popups/popups_shared
// Params 0, eflags: 0x0
// Checksum 0x74463740, Offset: 0x2990
// Size: 0x180
function function_a70085ff() {
    while (self.teammessagequeue.size > 0) {
        nextnotifydata = self.teammessagequeue[0];
        arrayremoveindex(self.teammessagequeue, 0, 0);
        if (!isdefined(nextnotifydata.player) || !isplayer(nextnotifydata.player)) {
            continue;
        }
        if (self isempjammed()) {
            continue;
        }
        notifyhash = #"player_callout";
        if (isdefined(nextnotifydata.var_c46f27a1) && nextnotifydata.var_c46f27a1) {
            notifyhash = #"hash_22b5b25be43ad2d7";
        }
        if (isdefined(nextnotifydata.optionalarg)) {
            self luinotifyevent(notifyhash, 3, nextnotifydata.message, nextnotifydata.player.entnum, nextnotifydata.optionalarg);
            continue;
        }
        self luinotifyevent(notifyhash, 2, nextnotifydata.message, nextnotifydata.player.entnum);
    }
}

