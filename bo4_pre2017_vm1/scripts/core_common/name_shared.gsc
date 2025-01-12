#namespace name;

// Namespace name/name_shared
// Params 0, eflags: 0x0
// Checksum 0xe90a0122, Offset: 0x970
// Size: 0xac
function setup() {
    /#
        assert(!isdefined(level.names));
    #/
    level.names = [];
    level.namesindex = [];
    if (!isdefined(level.script)) {
        level.script = tolower(getdvarstring("mapname"));
    }
    initialize_nationality("american");
}

// Namespace name/name_shared
// Params 1, eflags: 0x0
// Checksum 0xb9360e22, Offset: 0xa28
// Size: 0x8a
function initialize_nationality(str_nationality) {
    if (!isdefined(level.names[str_nationality])) {
        level.names[str_nationality] = [];
        if (str_nationality != "civilian") {
            add_nationality_names(str_nationality);
        }
        randomize_name_list(str_nationality);
        level.nameindex[str_nationality] = 0;
    }
}

// Namespace name/name_shared
// Params 1, eflags: 0x0
// Checksum 0x8753f8b6, Offset: 0xac0
// Size: 0x18e
function add_nationality_names(str_nationality) {
    switch (str_nationality) {
    case #"american":
        american_names();
        break;
    case #"chinese":
        function_20b0d377();
        break;
    case #"egyptian":
        function_4f7cc8e7();
        break;
    case #"russian":
        function_d1c62dd1();
        break;
    case #"agent":
        function_45e8e281();
        break;
    case #"police":
        function_3a4b0ace();
        break;
    case #"seal":
        function_a5d44d83();
        break;
    case #"navy":
        function_3ff7174();
        break;
    case #"security":
        function_b1ff3e5a();
        break;
    case #"singapore_police":
        function_49c33890();
        break;
    default:
        /#
            assertmsg("<dev string:x28>" + str_nationality);
        #/
        break;
    }
}

// Namespace name/name_shared
// Params 0, eflags: 0x0
// Checksum 0x6305b8f5, Offset: 0xc58
// Size: 0xc84
function american_names() {
    add_name("american", "Adams");
    add_name("american", "Alexander");
    add_name("american", "Allen");
    add_name("american", "Anderson");
    add_name("american", "Bailey");
    add_name("american", "Baker");
    add_name("american", "Barnes");
    add_name("american", "Bell");
    add_name("american", "Bennett");
    add_name("american", "Brooks");
    add_name("american", "Brown");
    add_name("american", "Bryant");
    add_name("american", "Butler");
    add_name("american", "Campbell");
    add_name("american", "Carter");
    add_name("american", "Clark");
    add_name("american", "Coleman");
    add_name("american", "Collins");
    add_name("american", "Cook");
    add_name("american", "Cooper");
    add_name("american", "Cox");
    add_name("american", "Davis");
    add_name("american", "Diaz");
    add_name("american", "Edwards");
    add_name("american", "Evans");
    add_name("american", "Flores");
    add_name("american", "Foster");
    add_name("american", "Garcia");
    add_name("american", "Gonzales");
    add_name("american", "Gonzalez");
    add_name("american", "Gray");
    add_name("american", "Green");
    add_name("american", "Griffin");
    add_name("american", "Hall");
    add_name("american", "Harris");
    add_name("american", "Hayes");
    add_name("american", "Henderson");
    add_name("american", "Hernandez");
    add_name("american", "Hill");
    add_name("american", "Howard");
    add_name("american", "Hughes");
    add_name("american", "Jackson");
    add_name("american", "James");
    add_name("american", "Jenkins");
    add_name("american", "Johnson");
    add_name("american", "Jones");
    add_name("american", "Kelly");
    add_name("american", "King");
    add_name("american", "Lee");
    add_name("american", "Lewis");
    add_name("american", "Long");
    add_name("american", "Lopez");
    add_name("american", "Martin");
    add_name("american", "Martinez");
    add_name("american", "Miller");
    add_name("american", "Mitchell");
    add_name("american", "Moore");
    add_name("american", "Morgan");
    add_name("american", "Morris");
    add_name("american", "Murphy");
    add_name("american", "Nelson");
    add_name("american", "Parker");
    add_name("american", "Patterson");
    add_name("american", "Perez");
    add_name("american", "Perry");
    add_name("american", "Peterson");
    add_name("american", "Phillips");
    add_name("american", "Powell");
    add_name("american", "Price");
    add_name("american", "Ramirez");
    add_name("american", "Reed");
    add_name("american", "Richardson");
    add_name("american", "Rivera");
    add_name("american", "Roberts");
    add_name("american", "Robinson");
    add_name("american", "Rodriguez");
    add_name("american", "Rogers");
    add_name("american", "Ross");
    add_name("american", "Russell");
    add_name("american", "Sanchez");
    add_name("american", "Sanders");
    add_name("american", "Scott");
    add_name("american", "Simmons");
    add_name("american", "Smith");
    add_name("american", "Stewart");
    add_name("american", "Taylor");
    add_name("american", "Thomas");
    add_name("american", "Thompson");
    add_name("american", "Torres");
    add_name("american", "Turner");
    add_name("american", "Walker");
    add_name("american", "Ward");
    add_name("american", "Washington");
    add_name("american", "Watson");
    add_name("american", "White");
    add_name("american", "Williams");
    add_name("american", "Wilson");
    add_name("american", "Wood");
    add_name("american", "Wright");
    add_name("american", "Young");
}

// Namespace name/name_shared
// Params 0, eflags: 0x0
// Checksum 0xc3a7b267, Offset: 0x18e8
// Size: 0xac4
function function_4f7cc8e7() {
    add_name("egyptian", "Ababneh");
    add_name("egyptian", "Abba");
    add_name("egyptian", "Abbas");
    add_name("egyptian", "Abdel");
    add_name("egyptian", "Abdellah");
    add_name("egyptian", "Abdul");
    add_name("egyptian", "Abdulah");
    add_name("egyptian", "Abdullah");
    add_name("egyptian", "Abolhassan");
    add_name("egyptian", "Ahmad");
    add_name("egyptian", "Ahmed");
    add_name("egyptian", "Alam");
    add_name("egyptian", "Ali");
    add_name("egyptian", "Ameen");
    add_name("egyptian", "Amin");
    add_name("egyptian", "Armanjani");
    add_name("egyptian", "Awad");
    add_name("egyptian", "Ayasha");
    add_name("egyptian", "Aziz");
    add_name("egyptian", "Bari");
    add_name("egyptian", "Essa");
    add_name("egyptian", "Habib");
    add_name("egyptian", "Hadad");
    add_name("egyptian", "Haddad");
    add_name("egyptian", "Hamdan");
    add_name("egyptian", "Hamid");
    add_name("egyptian", "Hana");
    add_name("egyptian", "Hanna");
    add_name("egyptian", "Hasan");
    add_name("egyptian", "Hassan");
    add_name("egyptian", "Hossein");
    add_name("egyptian", "Hussain");
    add_name("egyptian", "Ibraheem");
    add_name("egyptian", "Ibrahim");
    add_name("egyptian", "Isa");
    add_name("egyptian", "Ismail");
    add_name("egyptian", "Issa");
    add_name("egyptian", "Jaber");
    add_name("egyptian", "Jabir");
    add_name("egyptian", "Karim");
    add_name("egyptian", "Khatib");
    add_name("egyptian", "Khoury");
    add_name("egyptian", "Mahmad");
    add_name("egyptian", "Mahmood");
    add_name("egyptian", "Mahmoud");
    add_name("egyptian", "Malik");
    add_name("egyptian", "Mansoor");
    add_name("egyptian", "Mansour");
    add_name("egyptian", "Mazin");
    add_name("egyptian", "Mousa");
    add_name("egyptian", "Murat");
    add_name("egyptian", "Musa");
    add_name("egyptian", "Mustafa");
    add_name("egyptian", "Najeeb");
    add_name("egyptian", "Najjar");
    add_name("egyptian", "Naser");
    add_name("egyptian", "Nasser");
    add_name("egyptian", "Omar");
    add_name("egyptian", "Omer");
    add_name("egyptian", "Ommar");
    add_name("egyptian", "Qasem");
    add_name("egyptian", "Qasim");
    add_name("egyptian", "Qassem");
    add_name("egyptian", "Rahman");
    add_name("egyptian", "Rasheed");
    add_name("egyptian", "Rashid");
    add_name("egyptian", "Saad");
    add_name("egyptian", "Sad");
    add_name("egyptian", "Salah");
    add_name("egyptian", "Saleh");
    add_name("egyptian", "Salih");
    add_name("egyptian", "Salman");
    add_name("egyptian", "Sam");
    add_name("egyptian", "Shadi");
    add_name("egyptian", "Shaheen");
    add_name("egyptian", "Shahriar");
    add_name("egyptian", "Shareef");
    add_name("egyptian", "Sharif");
    add_name("egyptian", "Sleiman");
    add_name("egyptian", "Sulaiman");
    add_name("egyptian", "Sulayman");
    add_name("egyptian", "Temiz");
    add_name("egyptian", "Turk");
    add_name("egyptian", "Yaseen");
    add_name("egyptian", "Yousef");
    add_name("egyptian", "Yousif");
}

// Namespace name/name_shared
// Params 0, eflags: 0x0
// Checksum 0xbb5c60b9, Offset: 0x23b8
// Size: 0x504
function function_49c33890() {
    add_name("singapore_police", "Ang");
    add_name("singapore_police", "Chan");
    add_name("singapore_police", "Chen");
    add_name("singapore_police", "Chia");
    add_name("singapore_police", "Chong");
    add_name("singapore_police", "Chua");
    add_name("singapore_police", "Feng");
    add_name("singapore_police", "He");
    add_name("singapore_police", "Ho");
    add_name("singapore_police", "Jau");
    add_name("singapore_police", "Kao");
    add_name("singapore_police", "Kiu");
    add_name("singapore_police", "Koh");
    add_name("singapore_police", "Lee");
    add_name("singapore_police", "Liang");
    add_name("singapore_police", "Lim");
    add_name("singapore_police", "Low");
    add_name("singapore_police", "Lu");
    add_name("singapore_police", "Ma");
    add_name("singapore_police", "Meng");
    add_name("singapore_police", "Ng");
    add_name("singapore_police", "Ong");
    add_name("singapore_police", "Pan");
    add_name("singapore_police", "Shi");
    add_name("singapore_police", "Sim");
    add_name("singapore_police", "Suen");
    add_name("singapore_police", "Sun");
    add_name("singapore_police", "Tan");
    add_name("singapore_police", "Tay");
    add_name("singapore_police", "Teo");
    add_name("singapore_police", "Toh");
    add_name("singapore_police", "Tuan");
    add_name("singapore_police", "Wong");
    add_name("singapore_police", "Wu");
    add_name("singapore_police", "Xie");
    add_name("singapore_police", "Yeo");
    add_name("singapore_police", "Yu");
    add_name("singapore_police", "Zhang");
    add_name("singapore_police", "Zhao");
    add_name("singapore_police", "Zhu");
}

// Namespace name/name_shared
// Params 0, eflags: 0x0
// Checksum 0x56e45ff9, Offset: 0x28c8
// Size: 0x3c4
function function_d1c62dd1() {
    add_name("russian", "Avtamonov");
    add_name("russian", "Barzilovich");
    add_name("russian", "Blyakher");
    add_name("russian", "Bulenkov");
    add_name("russian", "Datsyuk");
    add_name("russian", "Diakov");
    add_name("russian", "Dvilyansky");
    add_name("russian", "Dymarsky");
    add_name("russian", "Fedorova");
    add_name("russian", "Gerasimov");
    add_name("russian", "Ilyin");
    add_name("russian", "Ikonnikov");
    add_name("russian", "Kosteltsev");
    add_name("russian", "Krasilnikov");
    add_name("russian", "Lukin");
    add_name("russian", "Maximov");
    add_name("russian", "Melnikov");
    add_name("russian", "Nesterov");
    add_name("russian", "Pelov");
    add_name("russian", "Polubencev");
    add_name("russian", "Pokrovsky");
    add_name("russian", "Repin");
    add_name("russian", "Romanenko");
    add_name("russian", "Saslovsky");
    add_name("russian", "Sidorenko");
    add_name("russian", "Touevsky");
    add_name("russian", "Vakhitov");
    add_name("russian", "Yakubov");
    add_name("russian", "Yoslov");
    add_name("russian", "Zubarev");
}

// Namespace name/name_shared
// Params 0, eflags: 0x0
// Checksum 0x82f7323c, Offset: 0x2c98
// Size: 0x284
function function_45e8e281() {
    add_name("agent", "Bailey");
    add_name("agent", "Campbell");
    add_name("agent", "Collins");
    add_name("agent", "Cook");
    add_name("agent", "Cooper");
    add_name("agent", "Edwards");
    add_name("agent", "Evans");
    add_name("agent", "Gray");
    add_name("agent", "Howard");
    add_name("agent", "Morgan");
    add_name("agent", "Morris");
    add_name("agent", "Murphy");
    add_name("agent", "Phillips");
    add_name("agent", "Rivera");
    add_name("agent", "Roberts");
    add_name("agent", "Rogers");
    add_name("agent", "Stewart");
    add_name("agent", "Torres");
    add_name("agent", "Turner");
    add_name("agent", "Ward");
}

// Namespace name/name_shared
// Params 0, eflags: 0x0
// Checksum 0x5199e6ea, Offset: 0x2f28
// Size: 0x144
function function_20b0d377() {
    add_name("chinese", "Chan");
    add_name("chinese", "Cheng");
    add_name("chinese", "Chiang");
    add_name("chinese", "Feng");
    add_name("chinese", "Guan");
    add_name("chinese", "Hu");
    add_name("chinese", "Lai");
    add_name("chinese", "Leung");
    add_name("chinese", "Wu");
    add_name("chinese", "Zheng");
}

// Namespace name/name_shared
// Params 0, eflags: 0x0
// Checksum 0xba9d34b5, Offset: 0x3078
// Size: 0x264
function function_3ff7174() {
    add_name("navy", "Buckner");
    add_name("navy", "Coffey");
    add_name("navy", "Dashnaw");
    add_name("navy", "Dobson");
    add_name("navy", "Frank");
    add_name("navy", "Frey");
    add_name("navy", "Howe");
    add_name("navy", "Johns");
    add_name("navy", "Lee");
    add_name("navy", "Lockhart");
    add_name("navy", "Moon");
    add_name("navy", "Paiser");
    add_name("navy", "Preston");
    add_name("navy", "Reyes");
    add_name("navy", "Slater");
    add_name("navy", "Waller");
    add_name("navy", "Wong");
    add_name("navy", "Velasquez");
    add_name("navy", "York");
}

// Namespace name/name_shared
// Params 0, eflags: 0x0
// Checksum 0x5bd90acb, Offset: 0x32e8
// Size: 0x284
function function_3a4b0ace() {
    add_name("police", "Anderson");
    add_name("police", "Brown");
    add_name("police", "Davis");
    add_name("police", "Garcia");
    add_name("police", "Harris");
    add_name("police", "Jackson");
    add_name("police", "Johnson");
    add_name("police", "Jones");
    add_name("police", "Martin");
    add_name("police", "Martinez");
    add_name("police", "Miller");
    add_name("police", "Moore");
    add_name("police", "Robinson");
    add_name("police", "Smith");
    add_name("police", "Taylor");
    add_name("police", "Thomas");
    add_name("police", "Thompson");
    add_name("police", "White");
    add_name("police", "Williams");
    add_name("police", "Wilson");
}

// Namespace name/name_shared
// Params 0, eflags: 0x0
// Checksum 0x6115a590, Offset: 0x3578
// Size: 0x284
function function_b1ff3e5a() {
    add_name("security", "Anderson");
    add_name("security", "Brown");
    add_name("security", "Davis");
    add_name("security", "Garcia");
    add_name("security", "Harris");
    add_name("security", "Jackson");
    add_name("security", "Johnson");
    add_name("security", "Jones");
    add_name("security", "Martin");
    add_name("security", "Martinez");
    add_name("security", "Miller");
    add_name("security", "Moore");
    add_name("security", "Robinson");
    add_name("security", "Smith");
    add_name("security", "Taylor");
    add_name("security", "Thomas");
    add_name("security", "Thompson");
    add_name("security", "White");
    add_name("security", "Williams");
    add_name("security", "Wilson");
}

// Namespace name/name_shared
// Params 0, eflags: 0x0
// Checksum 0xb2756087, Offset: 0x3808
// Size: 0x284
function function_a5d44d83() {
    add_name("seal", "Adams");
    add_name("seal", "Carter");
    add_name("seal", "Gonzalez");
    add_name("seal", "Green");
    add_name("seal", "Hall");
    add_name("seal", "Hill");
    add_name("seal", "Hernandez");
    add_name("seal", "King");
    add_name("seal", "Lee");
    add_name("seal", "Lewis");
    add_name("seal", "Lopez");
    add_name("seal", "Maestas");
    add_name("seal", "Mitchell");
    add_name("seal", "Nelson");
    add_name("seal", "Rodriguez");
    add_name("seal", "Scott");
    add_name("seal", "Walker");
    add_name("seal", "Weichert");
    add_name("seal", "Wright");
    add_name("seal", "Young");
}

// Namespace name/name_shared
// Params 2, eflags: 0x0
// Checksum 0x5cc48534, Offset: 0x3a98
// Size: 0x40
function add_name(nationality, thename) {
    level.names[nationality][level.names[nationality].size] = thename;
}

// Namespace name/name_shared
// Params 1, eflags: 0x0
// Checksum 0x7f52a7d0, Offset: 0x3ae0
// Size: 0xea
function randomize_name_list(nationality) {
    size = level.names[nationality].size;
    for (i = 0; i < size; i++) {
        switchwith = randomint(size);
        temp = level.names[nationality][i];
        level.names[nationality][i] = level.names[nationality][switchwith];
        level.names[nationality][switchwith] = temp;
    }
}

// Namespace name/name_shared
// Params 1, eflags: 0x0
// Checksum 0xbfe7996a, Offset: 0x3bd8
// Size: 0x37a
function get(override) {
    if (!isdefined(override) && level.script == "credits") {
        self.airank = "private";
        self notify(#"hash_47341e47");
        return;
    }
    if (isdefined(self.script_friendname)) {
        if (self.script_friendname == "none") {
            self.propername = "";
        } else {
            self.propername = self.script_friendname;
            getrankfromname(self.propername);
        }
        self notify(#"hash_47341e47");
        return;
    }
    /#
        assert(isdefined(level.names));
    #/
    str_classname = self get_ai_classname();
    str_nationality = "american";
    if (issubstr(str_classname, "_civilian_")) {
        self.airank = "none";
        str_nationality = "civilian";
    } else if (self is_special_agent_member(str_classname)) {
        str_nationality = "agent";
    } else if (issubstr(str_classname, "_sco_")) {
        self.airank = "none";
        str_nationality = "chinese";
    } else if (issubstr(str_classname, "_egypt_")) {
        str_nationality = "egyptian";
    } else if (self is_police_member(str_classname)) {
        str_nationality = "police";
    } else if (self is_seal_member(str_classname)) {
        str_nationality = "seal";
    } else if (self is_navy_member(str_classname)) {
        str_nationality = "navy";
    } else if (self is_security_member(str_classname)) {
        str_nationality = "security";
    } else if (issubstr(str_classname, "_soviet_")) {
        self.airank = "none";
        str_nationality = "russian";
    } else if (issubstr(str_classname, "_ally_sing_")) {
        str_nationality = "singapore_police";
    }
    initialize_nationality(str_nationality);
    get_name_for_nationality(str_nationality);
    self notify(#"hash_47341e47");
}

// Namespace name/name_shared
// Params 0, eflags: 0x0
// Checksum 0xd393db8a, Offset: 0x3f60
// Size: 0x5c
function get_ai_classname() {
    if (isdefined(self.dr_ai_classname)) {
        str_classname = tolower(self.dr_ai_classname);
    } else {
        str_classname = tolower(self.classname);
    }
    return str_classname;
}

// Namespace name/name_shared
// Params 2, eflags: 0x0
// Checksum 0x1dcb40cb, Offset: 0x3fc8
// Size: 0x82
function add_override_name_func(nationality, func) {
    if (!isdefined(level._override_name_funcs)) {
        level._override_name_funcs = [];
    }
    /#
        assert(!isdefined(level._override_name_funcs[nationality]), "<dev string:x46>");
    #/
    level._override_name_funcs[nationality] = func;
}

// Namespace name/name_shared
// Params 1, eflags: 0x0
// Checksum 0x8e9861e0, Offset: 0x4058
// Size: 0x49c
function get_name_for_nationality(nationality) {
    /#
        assert(isdefined(level.nameindex[nationality]), nationality);
    #/
    if (isdefined(level._override_name_funcs) && isdefined(level._override_name_funcs[nationality])) {
        self.propername = [[ level._override_name_funcs[nationality] ]]();
        self.airank = "";
        return;
    }
    if (nationality == "civilian") {
        self.propername = "";
        return;
    }
    level.nameindex[nationality] = (level.nameindex[nationality] + 1) % level.names[nationality].size;
    lastname = level.names[nationality][level.nameindex[nationality]];
    if (!isdefined(lastname)) {
        lastname = "";
    }
    if (isdefined(level._override_rank_func)) {
        self [[ level._override_rank_func ]](lastname);
        return;
    }
    if (isdefined(self.airank) && self.airank == "none") {
        self.propername = lastname;
        return;
    }
    rank = randomint(100);
    if (nationality == "seal") {
        if (rank > 20) {
            fullname = "PO " + lastname;
            self.airank = "petty officer";
        } else if (rank > 10) {
            fullname = "CPO " + lastname;
            self.airank = "chief petty officer";
        } else {
            fullname = "Lt. " + lastname;
            self.airank = "lieutenant";
        }
    } else if (nationality == "navy") {
        if (rank > 60) {
            fullname = "SN " + lastname;
            self.airank = "seaman";
        } else if (rank > 20) {
            fullname = "PO " + lastname;
            self.airank = "petty officer";
        } else {
            fullname = "CPO " + lastname;
            self.airank = "chief petty officer";
        }
    } else if (nationality == "police") {
        fullname = "Officer " + lastname;
        self.airank = "police officer";
    } else if (nationality == "agent") {
        fullname = "Agent " + lastname;
        self.airank = "special agent";
    } else if (nationality == "security") {
        fullname = "Officer " + lastname;
    } else if (nationality == "singapore_police") {
        fullname = "Officer " + lastname;
        self.airank = "police officer";
    } else if (rank > 20) {
        fullname = "Pvt. " + lastname;
        self.airank = "private";
    } else if (rank > 10) {
        fullname = "Cpl. " + lastname;
        self.airank = "corporal";
    } else {
        fullname = "Sgt. " + lastname;
        self.airank = "sergeant";
    }
    self.propername = fullname;
}

// Namespace name/name_shared
// Params 1, eflags: 0x0
// Checksum 0x6945b941, Offset: 0x4500
// Size: 0x3c
function is_seal_member(str_classname) {
    if (issubstr(str_classname, "_seal_")) {
        return 1;
    }
    return 0;
}

// Namespace name/name_shared
// Params 1, eflags: 0x0
// Checksum 0x2986cf7d, Offset: 0x4548
// Size: 0x3c
function is_navy_member(str_classname) {
    if (issubstr(str_classname, "_navy_")) {
        return 1;
    }
    return 0;
}

// Namespace name/name_shared
// Params 1, eflags: 0x0
// Checksum 0xb514875a, Offset: 0x4590
// Size: 0x5c
function is_police_member(str_classname) {
    if (issubstr(str_classname, "_lapd_") || issubstr(str_classname, "_swat_")) {
        return 1;
    }
    return 0;
}

// Namespace name/name_shared
// Params 1, eflags: 0x0
// Checksum 0xdca5efc4, Offset: 0x45f8
// Size: 0x36
function is_security_member(str_classname) {
    if (issubstr(str_classname, "_security_")) {
        return true;
    }
    return false;
}

// Namespace name/name_shared
// Params 1, eflags: 0x0
// Checksum 0x22b2079d, Offset: 0x4638
// Size: 0x3c
function is_special_agent_member(str_classname) {
    if (issubstr(str_classname, "_sstactical_")) {
        return 1;
    }
    return 0;
}

// Namespace name/name_shared
// Params 1, eflags: 0x0
// Checksum 0x28c1589e, Offset: 0x4680
// Size: 0x186
function getrankfromname(name) {
    if (!isdefined(name)) {
        self.airank = "private";
    }
    tokens = strtok(name, " ");
    /#
        assert(tokens.size);
    #/
    shortrank = tokens[0];
    switch (shortrank) {
    case #"hash_62cab49":
        self.airank = "private";
        break;
    case #"hash_45176cb8":
        self.airank = "private";
        break;
    case #"hash_27db718e":
        self.airank = "corporal";
        break;
    case #"hash_ffa6d51":
        self.airank = "sergeant";
        break;
    case #"hash_83f03381":
        self.airank = "lieutenant";
        break;
    case #"hash_511ccae6":
        self.airank = "captain";
        break;
    default:
        /#
            println("<dev string:x6e>" + shortrank + "<dev string:x89>");
        #/
        self.airank = "private";
        break;
    }
}

// Namespace name/name_shared
// Params 2, eflags: 0x0
// Checksum 0x9e039f3c, Offset: 0x4810
// Size: 0xcc
function issubstr_match_any(str_match, str_search_array) {
    /#
        assert(str_search_array.size, "<dev string:x8b>");
    #/
    foreach (str_search in str_search_array) {
        if (issubstr(str_match, str_search)) {
            return true;
        }
    }
    return false;
}

