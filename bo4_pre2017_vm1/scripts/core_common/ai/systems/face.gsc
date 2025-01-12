#using scripts/core_common/math_shared;
#using scripts/core_common/util_shared;

#namespace face;

// Namespace face/face
// Params 1, eflags: 0x0
// Checksum 0x6c04e8b, Offset: 0x1c0
// Size: 0x11c
function saygenericdialogue(typestring) {
    if (level.disablegenericdialog) {
        return;
    }
    switch (typestring) {
    case #"attack":
        importance = 0.5;
        break;
    case #"swing":
        importance = 0.5;
        typestring = "attack";
        break;
    case #"flashbang":
        importance = 0.7;
        break;
    case #"pain_small":
        importance = 0.4;
        break;
    case #"pain_bullet":
        wait 0.01;
        importance = 0.4;
        break;
    default:
        println("<dev string:x28>" + typestring);
        importance = 0.3;
        break;
    }
    saygenericdialoguewithimportance(typestring, importance);
}

// Namespace face/face
// Params 2, eflags: 0x0
// Checksum 0x8d5d4706, Offset: 0x2e8
// Size: 0xbc
function saygenericdialoguewithimportance(typestring, importance) {
    soundalias = "dds_";
    if (isdefined(self.dds_characterid)) {
        soundalias += self.dds_characterid;
    } else {
        println("<dev string:x4b>");
        return;
    }
    soundalias += "_" + typestring;
    if (soundexists(soundalias)) {
        self thread playfacethread(undefined, soundalias, importance);
    }
}

// Namespace face/face
// Params 1, eflags: 0x0
// Checksum 0x7cca3383, Offset: 0x3b0
// Size: 0x24
function setidlefacedelayed(facialanimationarray) {
    self.a.idleface = facialanimationarray;
}

// Namespace face/face
// Params 1, eflags: 0x0
// Checksum 0xe75c8c36, Offset: 0x3e0
// Size: 0x4c
function setidleface(facialanimationarray) {
    if (!anim.usefacialanims) {
        return;
    }
    self.a.idleface = facialanimationarray;
    self playidleface();
}

// Namespace face/face
// Params 7, eflags: 0x0
// Checksum 0x545550b9, Offset: 0x438
// Size: 0x6c
function sayspecificdialogue(facialanim, soundalias, importance, notifystring, waitornot, timetowait, player_or_team) {
    self thread playfacethread(facialanim, soundalias, importance, notifystring, waitornot, timetowait, player_or_team);
}

// Namespace face/face
// Params 0, eflags: 0x0
// Checksum 0xb620a197, Offset: 0x4b0
// Size: 0x4
function playidleface() {
    
}

// Namespace face/face
// Params 7, eflags: 0x0
// Checksum 0x4954a567, Offset: 0x4c0
// Size: 0x744
function playfacethread(facialanim, str_script_alias, importance, notifystring, waitornot, timetowait, player_or_team) {
    self endon(#"death");
    if (!isdefined(str_script_alias)) {
        wait 1;
        self notify(notifystring);
        return;
    }
    str_notify_alias = str_script_alias;
    if (!isdefined(level.numberofimportantpeopletalking)) {
        level.numberofimportantpeopletalking = 0;
    }
    if (!isdefined(level.talknotifyseed)) {
        level.talknotifyseed = 0;
    }
    if (!isdefined(notifystring)) {
        notifystring = "PlayFaceThread " + str_script_alias;
    }
    if (!isdefined(self.a)) {
        self.a = spawnstruct();
    }
    if (!isdefined(self.a.facialsounddone)) {
        self.a.facialsounddone = 1;
    }
    if (!isdefined(self.istalking)) {
        self.istalking = 0;
    }
    if (self.istalking) {
        if (isdefined(self.a.currentdialogimportance)) {
            if (importance < self.a.currentdialogimportance) {
                wait 1;
                self notify(notifystring);
                return;
            } else if (importance == self.a.currentdialogimportance) {
                if (self.a.facialsoundalias == str_script_alias) {
                    return;
                }
                println("<dev string:x73>" + self.a.facialsoundalias + "<dev string:x8c>" + str_script_alias);
                while (self.istalking) {
                    self waittill("done speaking");
                }
            }
        } else {
            println("<dev string:x96>" + self.a.facialsoundalias + "<dev string:x8c>" + str_script_alias);
            self stopsound(self.a.facialsoundalias);
            self notify(#"cancel speaking");
            while (self.istalking) {
                self waittill("done speaking");
            }
        }
    }
    assert(self.a.facialsounddone);
    assert(self.a.facialsoundalias == undefined);
    assert(self.a.facialsoundnotify == undefined);
    assert(self.a.currentdialogimportance == undefined);
    assert(!self.istalking);
    self notify(#"bc_interrupt");
    self.istalking = 1;
    self.a.facialsounddone = 0;
    self.a.facialsoundnotify = notifystring;
    self.a.facialsoundalias = str_script_alias;
    self.a.currentdialogimportance = importance;
    if (importance == 1) {
        level.numberofimportantpeopletalking += 1;
    }
    /#
        if (level.numberofimportantpeopletalking > 1) {
            println("<dev string:xb3>" + str_script_alias);
        }
    #/
    uniquenotify = notifystring + " " + level.talknotifyseed;
    level.talknotifyseed += 1;
    if (isdefined(level.scr_sound) && isdefined(level.scr_sound["generic"])) {
        str_vox_file = level.scr_sound["generic"][str_script_alias];
    }
    if (!isdefined(str_vox_file) && soundexists(str_script_alias)) {
        str_vox_file = str_script_alias;
    }
    if (isdefined(str_vox_file)) {
        if (soundexists(str_vox_file)) {
            if (isdefined(player_or_team)) {
                self thread _play_sound_to_player_with_notify(str_vox_file, player_or_team, uniquenotify);
            } else if (isdefined(self gettagorigin("J_Head"))) {
                self playsoundwithnotify(str_vox_file, uniquenotify, "J_Head");
            } else {
                self playsoundwithnotify(str_vox_file, uniquenotify);
            }
        } else {
            /#
                println("<dev string:xf2>" + str_script_alias + "<dev string:x10e>");
                self thread _missing_dialog(str_script_alias, str_vox_file, uniquenotify);
            #/
        }
    } else {
        self thread _temp_dialog(str_script_alias, uniquenotify);
    }
    self waittill("death", "cancel speaking", uniquenotify);
    if (importance == 1) {
        level.numberofimportantpeopletalking -= 1;
        level.importantpeopletalkingtime = gettime();
    }
    if (isdefined(self)) {
        self.istalking = 0;
        self.a.facialsounddone = 1;
        self.a.facialsoundnotify = undefined;
        self.a.facialsoundalias = undefined;
        self.a.currentdialogimportance = undefined;
        self.lastsaytime = gettime();
    }
    self notify(#"done speaking", {#vo_line:str_notify_alias});
    self notify(notifystring);
}

// Namespace face/face
// Params 3, eflags: 0x0
// Checksum 0x9f2f4818, Offset: 0xc10
// Size: 0xfa
function _play_sound_to_player_with_notify(soundalias, player_or_team, uniquenotify) {
    self endon(#"death");
    if (isplayer(player_or_team)) {
        player_or_team endon(#"death");
        self playsoundtoplayer(soundalias, player_or_team);
    } else if (isstring(player_or_team)) {
        self playsoundtoteam(soundalias, player_or_team);
    }
    n_playbacktime = soundgetplaybacktime(soundalias);
    if (n_playbacktime > 0) {
        wait n_playbacktime * 0.001;
    } else {
        wait 1;
    }
    self notify(uniquenotify);
}

// Namespace face/face
// Params 3, eflags: 0x4
// Checksum 0x3237ca2d, Offset: 0xd18
// Size: 0x33e
function private _temp_dialog(str_line, uniquenotify, b_missing_vo) {
    if (!isdefined(b_missing_vo)) {
        b_missing_vo = 0;
    }
    setdvar("bgcache_disablewarninghints", 1);
    if (!b_missing_vo && isdefined(self.propername)) {
        str_line = self.propername + ": " + str_line;
    }
    foreach (player in level.players) {
        if (!isdefined(player getluimenu("TempDialog"))) {
            player openluimenu("TempDialog");
        }
        player setluimenudata(player getluimenu("TempDialog"), "dialogText", str_line);
        if (b_missing_vo) {
            player setluimenudata(player getluimenu("TempDialog"), "title", "MISSING VO SOUND");
            continue;
        }
        player setluimenudata(player getluimenu("TempDialog"), "title", "TEMP VO");
    }
    n_wait_time = (strtok(str_line, " ").size - 1) / 2;
    n_wait_time = math::clamp(n_wait_time, 2, 5);
    self waittilltimeout(n_wait_time, "death", "cancel speaking");
    foreach (player in level.players) {
        if (isdefined(player getluimenu("TempDialog"))) {
            player closeluimenu(player getluimenu("TempDialog"));
        }
    }
    setdvar("bgcache_disablewarninghints", 0);
    self notify(uniquenotify);
}

// Namespace face/face
// Params 3, eflags: 0x4
// Checksum 0x957c0993, Offset: 0x1060
// Size: 0x54
function private _missing_dialog(str_script_alias, str_vox_file, uniquenotify) {
    _temp_dialog("script id: " + str_script_alias + " sound alias: " + str_vox_file, uniquenotify, 1);
}

// Namespace face/face
// Params 3, eflags: 0x0
// Checksum 0x5b30884, Offset: 0x10c0
// Size: 0x62
function playface_waitfornotify(waitforstring, notifystring, killmestring) {
    self endon(#"death");
    self endon(killmestring);
    self waittill(waitforstring);
    self.a.facewaitforresult = "notify";
    self notify(notifystring);
}

// Namespace face/face
// Params 3, eflags: 0x0
// Checksum 0x5251dffb, Offset: 0x1130
// Size: 0x5a
function playface_waitfortime(time, notifystring, killmestring) {
    self endon(#"death");
    self endon(killmestring);
    wait time;
    self.a.facewaitforresult = "time";
    self notify(notifystring);
}

