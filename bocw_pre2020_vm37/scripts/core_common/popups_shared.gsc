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
// Params 0, eflags: 0x6
// Checksum 0x968f549c, Offset: 0xa0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"popups", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace popups/popups_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x1d4171c5, Offset: 0xe8
// Size: 0x24
function private function_70a657d8() {
    callback::on_start_gametype(&init);
}

// Namespace popups/popups_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x2d762b7f, Offset: 0x118
// Size: 0x1d4
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
// Params 0, eflags: 0x1 linked
// Checksum 0xfa5f98b, Offset: 0x2f8
// Size: 0x62
function on_player_connect() {
    if (isdefined(self) && !function_3132f113(self)) {
        self.resetgameoverhudrequired = 0;
        if (!level.hardcoremode) {
            if (shoulddisplayteammessages()) {
                self.teammessagequeue = [];
            }
        }
    }
}

/#

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0x5e4fa47e, Offset: 0x368
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
    // Checksum 0x16c0e18, Offset: 0x3d8
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
    // Checksum 0x41b99067, Offset: 0x430
    // Size: 0x9a
    function devgui_notif_getchallengestablename(tableid) {
        if (sessionmodeiscampaigngame()) {
            return (#"gamedata/stats/cp/statsmilestones" + tableid + "<dev string:x38>");
        }
        if (sessionmodeiszombiesgame()) {
            return (#"gamedata/stats/zm/statsmilestones" + tableid + "<dev string:x38>");
        }
        return #"gamedata/stats/mp/statsmilestones" + tableid + "<dev string:x38>";
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0x907e79a2, Offset: 0x4d8
    // Size: 0x15a
    function devgui_create_weapon_levels_table() {
        level.tbl_weaponids = [];
        for (i = 0; i < 1024; i++) {
            iteminfo = getunlockableiteminfofromindex(i, 0);
            if (isdefined(iteminfo)) {
                group_s = iteminfo.itemgroupname;
                if (issubstr(group_s, "<dev string:x40>") || group_s == "<dev string:x4b>") {
                    reference_s = iteminfo.namehash;
                    if (reference_s != "<dev string:x53>") {
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
    // Checksum 0x859364ca, Offset: 0x640
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
        util::add_devgui("<dev string:x57>", "<dev string:x7b>");
        level thread function_a65863ce();
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0x492749c7, Offset: 0x770
    // Size: 0x84
    function function_a65863ce() {
        level endon(#"game_ended");
        while (true) {
            if (getdvarint(#"hash_300689cb3bb5ab4d", 0) > 0) {
                util::remove_devgui("<dev string:x57>");
                function_ac0bfb9c();
                return;
            }
            wait 1;
        }
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0x9110604f, Offset: 0x800
    // Size: 0x5c
    function function_ac0bfb9c() {
        level thread notif_devgui_rank();
        level thread notif_devgui_gun_rank();
        if (!sessionmodeiscampaigngame()) {
            level thread notif_devgui_challenges();
        }
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0xee91771, Offset: 0x868
    // Size: 0x10c
    function notif_devgui_rank() {
        if (!isdefined(level.ranktable)) {
            return;
        }
        notif_rank_devgui_base = "<dev string:xa0>";
        for (i = 1; i < level.ranktable.size; i++) {
            display_level = i + 1;
            if (display_level < 10) {
                display_level = "<dev string:xcc>" + display_level;
            }
            util::waittill_can_add_debug_command();
            adddebugcommand(notif_rank_devgui_base + display_level + "<dev string:xd1>" + "<dev string:xd7>" + "<dev string:xdc>" + "<dev string:xf5>" + i + "<dev string:xfa>");
        }
        waitframe(1);
        level thread notif_devgui_rank_up_think();
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0x751017f, Offset: 0x980
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
    // Checksum 0x4cdc772e, Offset: 0xa58
    // Size: 0x944
    function notif_devgui_gun_rank() {
        notif_gun_rank_devgui_base = "<dev string:x101>";
        gunlevel_rankid_col = 0;
        gunlevel_gunref_col = 2;
        gunlevel_attachment_unlock_col = 3;
        gunlevel_xpgained_col = 4;
        level flag::wait_till("<dev string:x12c>");
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
                if (weapon[#"reference"] != "<dev string:x143>") {
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
                    devgui_cmd_gun_path = notif_gun_rank_devgui_base + function_9e72a96(group_name) + "<dev string:x152>" + function_9e72a96(gun_group[gun][#"ref"]) + "<dev string:x152>" + function_9e72a96(attachment);
                    util::waittill_can_add_debug_command();
                    adddebugcommand(devgui_cmd_gun_path + "<dev string:xd1>" + "<dev string:xd7>" + "<dev string:x157>" + "<dev string:x160>" + "<dev string:xf5>" + attachment_data[#"xp"] + "<dev string:x157>" + "<dev string:x17f>" + "<dev string:xf5>" + attachment_data[#"itemindex"] + "<dev string:x157>" + "<dev string:x1ac>" + "<dev string:xf5>" + gun_group[gun][#"itemindex"] + "<dev string:x157>" + "<dev string:x1d3>" + "<dev string:xf5>" + attachment_data[#"rankid"] + "<dev string:xfa>");
                }
            }
            waitframe(1);
        }
        level thread notif_devgui_gun_level_think();
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf1123564, Offset: 0x13a8
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
    // Checksum 0x5c8ebfbb, Offset: 0x1578
    // Size: 0x314
    function notif_devgui_challenges() {
        notif_challenges_devgui_base = "<dev string:x1f7>";
        for (i = 1; i <= devgui_notif_getchallengestablecount(); i++) {
            tablename = devgui_notif_getchallengestablename(i);
            rows = tablelookuprowcount(tablename);
            for (j = 1; j < rows; j++) {
                challengeid = tablelookupcolumnforrow(tablename, j, 0);
                if (challengeid != "<dev string:x53>" && strisint(tablelookupcolumnforrow(tablename, j, 0))) {
                    challengestring = tablelookupcolumnforrow(tablename, j, 5);
                    type = tablelookupcolumnforrow(tablename, j, 3);
                    challengetier = int(tablelookupcolumnforrow(tablename, j, 1));
                    challengetierstring = "<dev string:x53>" + challengetier;
                    if (challengetier < 10) {
                        challengetierstring = "<dev string:xcc>" + challengetier;
                    }
                    name = tablelookupcolumnforrow(tablename, j, 5);
                    devgui_cmd_challenge_path = notif_challenges_devgui_base + function_9e72a96(type) + "<dev string:x152>" + function_9e72a96(name) + "<dev string:x152>" + challengetierstring + "<dev string:x223>" + challengeid;
                    util::waittill_can_add_debug_command();
                    adddebugcommand(devgui_cmd_challenge_path + "<dev string:xd1>" + "<dev string:xd7>" + "<dev string:x157>" + "<dev string:x22c>" + "<dev string:xf5>" + j + "<dev string:x157>" + "<dev string:x24e>" + "<dev string:xf5>" + i + "<dev string:xfa>");
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
    // Checksum 0x8b1a5769, Offset: 0x1898
    // Size: 0x41e
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
            player = level.players[0];
            tablename = devgui_notif_getchallengestablename(table);
            if (row < 1 || row > tablelookuprowcount(tablename)) {
                waitframe(1);
                continue;
            }
            type = tablelookupcolumnforrow(tablename, row, 3);
            itemindex = 0;
            if (type == "<dev string:x272>") {
                type = 0;
            } else if (type == "<dev string:x27c>") {
                itemindex = 4;
                type = 3;
            } else if (type == "<dev string:x285>") {
                itemindex = 1;
                type = 4;
            } else if (type == "<dev string:x293>") {
                type = 2;
            } else if (type == "<dev string:x29f>") {
                type = 5;
            } else {
                itemindex = getdvarint(#"scr_challenge_itemindex", 0);
                if (itemindex == 0) {
                    currentweaponname = player.currentweapon.name;
                    itemindex = getitemindexfromref(currentweaponname);
                    if (itemindex == 0) {
                        itemindex = 225;
                    }
                }
                type = 1;
            }
            xpreward = int(tablelookupcolumnforrow(tablename, row, 6));
            challengeid = int(tablelookupcolumnforrow(tablename, row, 0));
            maxvalue = int(tablelookupcolumnforrow(tablename, row, 2));
            player persistence::codecallback_challengecomplete({#reward:xpreward, #max:maxvalue, #row:row, #s_idcv_sneakybastardpawntof:table - 1, #challenge_type:type, #item_index:itemindex, #challenge_index:challengeid});
            setdvar(#"scr_notif_devgui_challenge_row", 0);
            setdvar(#"scr_notif_devgui_challenge_table", 0);
            wait 1;
        }
    }

    // Namespace popups/popups_shared
    // Params 0, eflags: 0x0
    // Checksum 0x51867573, Offset: 0x1cc0
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
                level.players[0] medals::codecallback_medal({#medal_index:2});
            }
            for (i = 0; i < challenge; i++) {
                level.players[0] persistence::codecallback_challengecomplete({#reward:1000, #max:10, #row:19, #table_numuber:0, #challenge_type:0, #item_index:0, #challenge_index:18});
                level.players[0] persistence::codecallback_challengecomplete({#reward:1000, #max:1, #row:21, #s_idcv_sneakybastardpawntof:0, #challenge_type:0, #item_index:0, #challenge_index:20});
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
                level.players[0] persistence::codecallback_challengecomplete({#reward:rewardxp, #max:maxval, #row:row, #s_idcv_sneakybastardpawntof:tablenumber, #challenge_type:challengetype, #item_index:itemindex, #challenge_index:challengeindex});
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
// Params 2, eflags: 0x1 linked
// Checksum 0x5e273f2, Offset: 0x24c0
// Size: 0xa4
function displaykillstreakteammessagetoall(killstreak, player) {
    if (!isdefined(level.killstreaks[killstreak])) {
        return;
    }
    if (!isdefined(level.killstreaks[killstreak].script_bundle)) {
        return;
    }
    if (!isdefined(level.killstreaks[killstreak].script_bundle.var_bc2f6af9)) {
        return;
    }
    self displayteammessagetoall(level.killstreaks[killstreak].script_bundle.var_bc2f6af9, player);
}

// Namespace popups/popups_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xc921bff6, Offset: 0x2570
// Size: 0xa4
function displaykillstreakhackedteammessagetoall(killstreak, player) {
    if (!isdefined(level.killstreaks[killstreak])) {
        return;
    }
    if (!isdefined(level.killstreaks[killstreak].script_bundle)) {
        return;
    }
    if (!isdefined(level.killstreaks[killstreak].script_bundle.var_6417048f)) {
        return;
    }
    self displayteammessagetoall(level.killstreaks[killstreak].script_bundle.var_6417048f, player);
}

// Namespace popups/popups_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x8f00191c, Offset: 0x2620
// Size: 0x50
function shoulddisplayteammessages() {
    if (level.hardcoremode == 1 || level.splitscreen == 1 || sessionmodeiscampaigngame()) {
        return false;
    }
    return true;
}

// Namespace popups/popups_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x38db631e, Offset: 0x2678
// Size: 0x34
function function_eb9328f3() {
    self notify(#"received teammessage");
    self callback::callback(#"team_message");
}

// Namespace popups/popups_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x5f1b4970, Offset: 0x26b8
// Size: 0x11c
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
        cur_player function_eb9328f3();
    }
}

// Namespace popups/popups_shared
// Params 6, eflags: 0x0
// Checksum 0x321163bf, Offset: 0x27e0
// Size: 0x1dc
function displayteammessagetoteam(message, player, team, optionalarg, var_3d4cfe83, var_cf88c427 = 0) {
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
        cur_player.teammessagequeue[size].var_3d4cfe83 = var_3d4cfe83;
        cur_player.teammessagequeue[size].var_cf88c427 = var_cf88c427;
        callback::callback(#"hash_41781454d98b676a", cur_player.teammessagequeue[size]);
        cur_player function_eb9328f3();
    }
}

// Namespace popups/popups_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x7ddbb16b, Offset: 0x29c8
// Size: 0x2c
function on_team_message() {
    if (!shoulddisplayteammessages()) {
        return;
    }
    function_921657e4();
}

// Namespace popups/popups_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x41db05ac, Offset: 0x2a00
// Size: 0x1b0
function function_921657e4() {
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
        if (is_true(nextnotifydata.var_3d4cfe83)) {
            notifyhash = #"hash_22b5b25be43ad2d7";
        } else if (is_true(nextnotifydata.var_cf88c427)) {
            notifyhash = #"hash_2a3c608f65b1cead";
        }
        if (isdefined(nextnotifydata.optionalarg)) {
            self luinotifyevent(notifyhash, 3, nextnotifydata.message, nextnotifydata.player getentitynumber(), nextnotifydata.optionalarg);
            continue;
        }
        self luinotifyevent(notifyhash, 2, nextnotifydata.message, nextnotifydata.player getentitynumber());
    }
}

