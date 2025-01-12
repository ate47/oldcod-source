#namespace character;

// Namespace character/character
// Params 1, eflags: 0x0
// Checksum 0xf584d43d, Offset: 0xd8
// Size: 0x3c
function setmodelfromarray(a) {
    self setmodel(a[randomint(a.size)]);
}

// Namespace character/character
// Params 1, eflags: 0x0
// Checksum 0x8ffd820b, Offset: 0x120
// Size: 0x28
function randomelement(a) {
    return a[randomint(a.size)];
}

// Namespace character/character
// Params 1, eflags: 0x0
// Checksum 0xcd9e771c, Offset: 0x150
// Size: 0x44
function attachfromarray(a) {
    self attach(randomelement(a), "", 1);
}

// Namespace character/character
// Params 0, eflags: 0x0
// Checksum 0x3c96a2cd, Offset: 0x1a0
// Size: 0x68
function newcharacter() {
    self detachall();
    oldgunhand = self.anim_gunhand;
    if (!isdefined(oldgunhand)) {
        return;
    }
    self.anim_gunhand = "none";
    self [[ anim.putguninhand ]](oldgunhand);
}

// Namespace character/character
// Params 0, eflags: 0x0
// Checksum 0x232ad768, Offset: 0x210
// Size: 0x1b0
function save() {
    info["gunHand"] = self.anim_gunhand;
    info["gunInHand"] = self.anim_guninhand;
    info["model"] = self.model;
    info["hatModel"] = self.hatmodel;
    info["gearModel"] = self.gearmodel;
    if (isdefined(self.name)) {
        info["name"] = self.name;
        println("<dev string:x28>", self.name);
    } else {
        println("<dev string:x3c>");
    }
    attachsize = self getattachsize();
    for (i = 0; i < attachsize; i++) {
        info["attach"][i]["model"] = self getattachmodelname(i);
        info["attach"][i]["tag"] = self getattachtagname(i);
    }
    return info;
}

// Namespace character/character
// Params 1, eflags: 0x0
// Checksum 0xf414ac06, Offset: 0x3c8
// Size: 0x1a6
function load(info) {
    self detachall();
    self.anim_gunhand = info["gunHand"];
    self.anim_guninhand = info["gunInHand"];
    self setmodel(info["model"]);
    self.hatmodel = info["hatModel"];
    self.gearmodel = info["gearModel"];
    if (isdefined(info["name"])) {
        self.name = info["name"];
        println("<dev string:x53>", self.name);
    } else {
        println("<dev string:x67>");
    }
    attachinfo = info["attach"];
    attachsize = attachinfo.size;
    for (i = 0; i < attachsize; i++) {
        self attach(attachinfo[i]["model"], attachinfo[i]["tag"]);
    }
}

// Namespace character/character
// Params 1, eflags: 0x0
// Checksum 0x26fcd2e, Offset: 0x578
// Size: 0x216
function get_random_character(amount) {
    self_info = strtok(self.classname, "_");
    if (self_info.size <= 2) {
        return randomint(amount);
    }
    group = "auto";
    index = undefined;
    prefix = self_info[2];
    if (isdefined(self.script_char_index)) {
        index = self.script_char_index;
    }
    if (isdefined(self.script_char_group)) {
        type = "grouped";
        group = "group_" + self.script_char_group;
    }
    if (!isdefined(level.character_index_cache)) {
        level.character_index_cache = [];
    }
    if (!isdefined(level.character_index_cache[prefix])) {
        level.character_index_cache[prefix] = [];
    }
    if (!isdefined(level.character_index_cache[prefix][group])) {
        initialize_character_group(prefix, group, amount);
    }
    if (!isdefined(index)) {
        index = get_least_used_index(prefix, group);
        if (!isdefined(index)) {
        }
    }
    for (index = randomint(5000); index >= amount; index -= amount) {
    }
    level.character_index_cache[prefix][group][index]++;
    return index;
}

// Namespace character/character
// Params 2, eflags: 0x0
// Checksum 0x23d319b9, Offset: 0x798
// Size: 0x162
function get_least_used_index(prefix, group) {
    lowest_indices = [];
    lowest_use = level.character_index_cache[prefix][group][0];
    lowest_indices[0] = 0;
    for (i = 1; i < level.character_index_cache[prefix][group].size; i++) {
        if (level.character_index_cache[prefix][group][i] > lowest_use) {
            continue;
        }
        if (level.character_index_cache[prefix][group][i] < lowest_use) {
            lowest_indices = [];
            lowest_use = level.character_index_cache[prefix][group][i];
        }
        lowest_indices[lowest_indices.size] = i;
    }
    assert(lowest_indices.size, "<dev string:x7e>");
    return random(lowest_indices);
}

// Namespace character/character
// Params 3, eflags: 0x0
// Checksum 0x1e6def15, Offset: 0x908
// Size: 0x64
function initialize_character_group(prefix, group, amount) {
    for (i = 0; i < amount; i++) {
        level.character_index_cache[prefix][group][i] = 0;
    }
}

// Namespace character/character
// Params 1, eflags: 0x0
// Checksum 0x1837c839, Offset: 0x978
// Size: 0x56
function random(array) {
    keys = getarraykeys(array);
    return array[keys[randomint(keys.size)]];
}

