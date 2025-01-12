#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/values_shared;

#namespace phalanx;

// Namespace phalanx
// Method(s) 25 Total 25
class phalanx {

    var breakingpoint_;
    var currentsentientcount_;
    var endposition_;
    var phalanxtype_;
    var scattered_;
    var sentienttiers_;
    var startposition_;
    var startsentientcount_;

    // Namespace phalanx/phalanx
    // Params 0, eflags: 0x0
    // Checksum 0xa864b817, Offset: 0x1988
    // Size: 0x40
    function constructor() {
        sentienttiers_ = [];
        startsentientcount_ = 0;
        currentsentientcount_ = 0;
        breakingpoint_ = 0;
        scattered_ = 0;
    }

    // Namespace phalanx/phalanx
    // Params 0, eflags: 0x0
    // Checksum 0xc1a6db98, Offset: 0x2260
    // Size: 0x15a
    function scatterphalanx() {
        if (!scattered_) {
            scattered_ = 1;
            _releasesentients(sentienttiers_["phalanx_tier1"]);
            sentienttiers_["phalanx_tier1"] = [];
            _assignphalanxstance(sentienttiers_["phalanx_tier2"], "crouch");
            wait randomfloatrange(5, 7);
            _releasesentients(sentienttiers_["phalanx_tier2"]);
            sentienttiers_["phalanx_tier2"] = [];
            _assignphalanxstance(sentienttiers_["phalanx_tier3"], "crouch");
            wait randomfloatrange(5, 7);
            _releasesentients(sentienttiers_["phalanx_tier3"]);
            sentienttiers_["phalanx_tier3"] = [];
        }
    }

    // Namespace phalanx/phalanx
    // Params 0, eflags: 0x0
    // Checksum 0xa9da64a3, Offset: 0x21d8
    // Size: 0x7c
    function resumefire() {
        _resumefiresentients(sentienttiers_["phalanx_tier1"]);
        _resumefiresentients(sentienttiers_["phalanx_tier2"]);
        _resumefiresentients(sentienttiers_["phalanx_tier3"]);
    }

    // Namespace phalanx/phalanx
    // Params 0, eflags: 0x0
    // Checksum 0x3b1cf72, Offset: 0x2060
    // Size: 0x16c
    function resumeadvance() {
        if (!scattered_) {
            _assignphalanxstance(sentienttiers_["phalanx_tier1"], "stand");
            wait 1;
            forward = vectornormalize(endposition_ - startposition_);
            _movephalanxtier(sentienttiers_["phalanx_tier1"], phalanxtype_, "phalanx_tier1", endposition_, forward);
            _movephalanxtier(sentienttiers_["phalanx_tier2"], phalanxtype_, "phalanx_tier2", endposition_, forward);
            _movephalanxtier(sentienttiers_["phalanx_tier3"], phalanxtype_, "phalanx_tier3", endposition_, forward);
            _assignphalanxstance(sentienttiers_["phalanx_tier1"], "crouch");
        }
    }

    // Namespace phalanx/phalanx
    // Params 8, eflags: 0x0
    // Checksum 0x6751e009, Offset: 0x1c58
    // Size: 0x3fc
    function initialize(phalanxtype, origin, destination, breakingpoint, maxtiersize, tieronespawner, tiertwospawner, tierthreespawner) {
        if (!isdefined(maxtiersize)) {
            maxtiersize = 10;
        }
        if (!isdefined(tieronespawner)) {
            tieronespawner = undefined;
        }
        if (!isdefined(tiertwospawner)) {
            tiertwospawner = undefined;
        }
        if (!isdefined(tierthreespawner)) {
            tierthreespawner = undefined;
        }
        assert(isstring(phalanxtype));
        assert(isint(breakingpoint));
        assert(isvec(origin));
        assert(isvec(destination));
        tierspawners = [];
        tierspawners["phalanx_tier1"] = tieronespawner;
        tierspawners["phalanx_tier2"] = tiertwospawner;
        tierspawners["phalanx_tier3"] = tierthreespawner;
        maxtiersize = math::clamp(maxtiersize, 1, 10);
        forward = vectornormalize(destination - origin);
        foreach (tiername in array("phalanx_tier1", "phalanx_tier2", "phalanx_tier3")) {
            sentienttiers_[tiername] = _createphalanxtier(phalanxtype, tiername, origin, forward, maxtiersize, tierspawners[tiername]);
            startsentientcount_ += sentienttiers_[tiername].size;
        }
        _assignphalanxstance(sentienttiers_["phalanx_tier1"], "crouch");
        foreach (name, tier in sentienttiers_) {
            _movephalanxtier(sentienttiers_[name], phalanxtype, name, destination, forward);
        }
        breakingpoint_ = breakingpoint;
        startposition_ = origin;
        endposition_ = destination;
        phalanxtype_ = phalanxtype;
        self thread _updatephalanxthread(self);
    }

    // Namespace phalanx/phalanx
    // Params 0, eflags: 0x0
    // Checksum 0x7b5101e9, Offset: 0x1bb0
    // Size: 0x9a
    function haltadvance() {
        if (!scattered_) {
            foreach (tier in sentienttiers_) {
                _haltadvance(tier);
            }
        }
    }

    // Namespace phalanx/phalanx
    // Params 0, eflags: 0x0
    // Checksum 0xe59ceb4a, Offset: 0x1b10
    // Size: 0x92
    function haltfire() {
        foreach (tier in sentienttiers_) {
            _haltfire(tier);
        }
    }

    // Namespace phalanx/phalanx
    // Params 0, eflags: 0x4
    // Checksum 0x16b11a6, Offset: 0x19e0
    // Size: 0x124
    function private _updatephalanx() {
        if (scattered_) {
            return false;
        }
        currentsentientcount_ = 0;
        foreach (name, tier in sentienttiers_) {
            sentienttiers_[name] = _prunedead(tier);
            currentsentientcount_ += sentienttiers_[name].size;
        }
        if (currentsentientcount_ <= startsentientcount_ - breakingpoint_) {
            scatterphalanx();
            return false;
        }
        return true;
    }

    // Namespace phalanx/phalanx
    // Params 1, eflags: 0x4
    // Checksum 0x2fb5e609, Offset: 0x1958
    // Size: 0x28
    function private _updatephalanxthread(phalanx) {
        while ([[ phalanx ]]->_updatephalanx()) {
            wait 1;
        }
    }

    // Namespace phalanx/phalanx
    // Params 2, eflags: 0x4
    // Checksum 0x6d27d831, Offset: 0x18b0
    // Size: 0xa0
    function private _rotatevec(vector, angle) {
        return (vector[0] * cos(angle) - vector[1] * sin(angle), vector[0] * sin(angle) + vector[1] * cos(angle), vector[2]);
    }

    // Namespace phalanx/phalanx
    // Params 1, eflags: 0x4
    // Checksum 0xfc46ee33, Offset: 0x17e0
    // Size: 0xc2
    function private _resumefiresentients(sentients) {
        assert(isarray(sentients));
        foreach (sentient in sentients) {
            _resumefire(sentient);
        }
    }

    // Namespace phalanx/phalanx
    // Params 1, eflags: 0x4
    // Checksum 0x1899b84b, Offset: 0x1780
    // Size: 0x54
    function private _resumefire(sentient) {
        if (isdefined(sentient) && isalive(sentient)) {
            sentient val::reset("halt_fire", "ignoreall");
        }
    }

    // Namespace phalanx/phalanx
    // Params 1, eflags: 0x4
    // Checksum 0x14f2beb7, Offset: 0x16a8
    // Size: 0xca
    function private _releasesentients(sentients) {
        foreach (sentient in sentients) {
            _resumefire(sentient);
            _releasesentient(sentient);
            wait randomfloatrange(0.5, 5);
        }
    }

    // Namespace phalanx/phalanx
    // Params 1, eflags: 0x4
    // Checksum 0x5781f033, Offset: 0x1510
    // Size: 0x18c
    function private _releasesentient(sentient) {
        if (isdefined(sentient) && isalive(sentient)) {
            sentient clearuseposition();
            sentient pathmode("move delayed", 1, randomfloatrange(0.5, 1));
            sentient ai::set_behavior_attribute("phalanx", 0);
            waitframe(1);
            if (sentient.archetype === "human") {
                sentient.allowpain = 1;
            }
            sentient setavoidancemask("avoid all");
            aiutility::removeaioverridedamagecallback(sentient, &_dampenexplosivedamage);
            if (isdefined(sentient.archetype) && sentient.archetype == "robot") {
                sentient ai::set_behavior_attribute("move_mode", "normal");
                sentient ai::set_behavior_attribute("force_cover", 0);
            }
        }
    }

    // Namespace phalanx/phalanx
    // Params 1, eflags: 0x4
    // Checksum 0xd749bd3c, Offset: 0x1448
    // Size: 0xc0
    function private _prunedead(sentients) {
        livesentients = [];
        foreach (index, sentient in sentients) {
            if (isdefined(sentient) && isalive(sentient)) {
                livesentients[index] = sentient;
            }
        }
        return livesentients;
    }

    // Namespace phalanx/phalanx
    // Params 5, eflags: 0x4
    // Checksum 0x841f6baa, Offset: 0x1228
    // Size: 0x212
    function private _movephalanxtier(sentients, phalanxtype, tier, destination, forward) {
        positions = _getphalanxpositions(phalanxtype, tier);
        angles = vectortoangles(forward);
        assert(sentients.size <= positions.size, "<dev string:x1ac>");
        foreach (index, sentient in sentients) {
            if (isdefined(sentient) && isalive(sentient)) {
                assert(isvec(positions[index]), "<dev string:x1ec>" + index + "<dev string:x219>" + tier + "<dev string:x224>" + phalanxtype);
                orientedpos = _rotatevec(positions[index], angles[1] - 90);
                navmeshposition = getclosestpointonnavmesh(destination + orientedpos, 200);
                sentient useposition(navmeshposition);
            }
        }
    }

    // Namespace phalanx/phalanx
    // Params 1, eflags: 0x0
    // Checksum 0xe1954240, Offset: 0x10d8
    // Size: 0x144
    function _initializesentient(sentient) {
        assert(isactor(sentient));
        sentient ai::set_behavior_attribute("phalanx", 1);
        if (sentient.archetype === "human") {
            sentient.allowpain = 0;
        }
        sentient setavoidancemask("avoid none");
        if (isdefined(sentient.archetype) && sentient.archetype == "robot") {
            sentient ai::set_behavior_attribute("move_mode", "marching");
            sentient ai::set_behavior_attribute("force_cover", 1);
        }
        aiutility::addaioverridedamagecallback(sentient, &_dampenexplosivedamage, 1);
    }

    // Namespace phalanx/phalanx
    // Params 1, eflags: 0x4
    // Checksum 0xcea67608, Offset: 0xfd8
    // Size: 0xf2
    function private _haltfire(sentients) {
        assert(isarray(sentients));
        foreach (sentient in sentients) {
            if (isdefined(sentient) && isalive(sentient)) {
                sentient val::set("halt_fire", "ignoreall", 1);
            }
        }
    }

    // Namespace phalanx/phalanx
    // Params 1, eflags: 0x4
    // Checksum 0x22fc16fb, Offset: 0xe80
    // Size: 0x14a
    function private _haltadvance(sentients) {
        assert(isarray(sentients));
        foreach (sentient in sentients) {
            if (isdefined(sentient) && isalive(sentient) && sentient haspath()) {
                navmeshposition = getclosestpointonnavmesh(sentient.origin, 200);
                sentient useposition(navmeshposition);
                sentient clearpath();
            }
        }
    }

    // Namespace phalanx/phalanx
    // Params 1, eflags: 0x4
    // Checksum 0x3d13f0dd, Offset: 0xdb8
    // Size: 0xbc
    function private _getphalanxspawner(tier) {
        spawner = getspawnerarray(tier, "targetname");
        assert(spawner.size >= 0, "<dev string:x59>" + "<dev string:x9f>" + "<dev string:xe7>");
        assert(spawner.size == 1, "<dev string:xfe>" + "<dev string:x142>" + "<dev string:x168>");
        return spawner[0];
    }

    // Namespace phalanx/phalanx
    // Params 2, eflags: 0x4
    // Checksum 0x5a702834, Offset: 0x800
    // Size: 0x5ac
    function private _getphalanxpositions(phalanxtype, tier) {
        switch (phalanxtype) {
        case #"phanalx_wedge":
            switch (tier) {
            case #"phalanx_tier1":
                return array((0, 0, 0), (-64, -48, 0), (64, -48, 0), (-128, -96, 0), (128, -96, 0));
            case #"phalanx_tier2":
                return array((-32, -96, 0), (32, -96, 0));
            case #"phalanx_tier3":
                return array();
            }
            goto LOC_00000150;
        case #"phalanx_reverse_wedge":
            switch (tier) {
            case #"phalanx_tier1":
                return array((-32, 0, 0), (32, 0, 0));
            case #"phalanx_tier2":
                return array((0, -96, 0));
            case #"phalanx_tier3":
                return array();
            }
        LOC_00000150:
            goto LOC_00000210;
        case #"phalanx_diagonal_left":
            switch (tier) {
            case #"phalanx_tier1":
                return array((0, 0, 0), (-48, -64, 0), (-96, -128, 0), (-144, -192, 0));
            case #"phalanx_tier2":
                return array((64, 0, 0), (16, -64, 0), (-48, -128, 0), (-112, -192, 0));
            case #"phalanx_tier3":
                return array();
            }
        LOC_00000210:
            goto LOC_000002d0;
        case #"phalanx_diagonal_right":
            switch (tier) {
            case #"phalanx_tier1":
                return array((0, 0, 0), (48, -64, 0), (96, -128, 0), (144, -192, 0));
            case #"phalanx_tier2":
                return array((-64, 0, 0), (-16, -64, 0), (48, -128, 0), (112, -192, 0));
            case #"phalanx_tier3":
                return array();
            }
        LOC_000002d0:
            goto LOC_00000388;
        case #"phalanx_forward":
            switch (tier) {
            case #"phalanx_tier1":
                return array((0, 0, 0), (64, 0, 0), (128, 0, 0), (192, 0, 0));
            case #"phalanx_tier2":
                return array((-32, -64, 0), (32, -64, 0), (96, -64, 0), (160, -64, 0));
            case #"phalanx_tier3":
                return array();
            }
        LOC_00000388:
            goto LOC_00000480;
        case #"phalanx_column":
            switch (tier) {
            case #"phalanx_tier1":
                return array((0, 0, 0), (-64, 0, 0), (0, -64, 0), (-64, -64, 0));
            case #"phalanx_tier2":
                return array((0, -128, 0), (-64, -128, 0), (0, -192, 0), (-64, -192, 0));
            case #"phalanx_tier3":
                return array((64, 0, 0), (64, -64, 0), (64, -128, 0), (64, -192, 0));
            }
        LOC_00000480:
            goto LOC_00000508;
        case #"phalanx_column_right":
            switch (tier) {
            case #"phalanx_tier1":
                return array((0, 0, 0), (0, -64, 0), (0, -128, 0), (0, -192, 0));
            case #"phalanx_tier2":
                return array();
            case #"phalanx_tier3":
                return array();
            }
        LOC_00000508:
            break;
        default:
            assert("<dev string:x28>" + phalanxtype + "<dev string:x3f>");
            break;
        }
        assert("<dev string:x42>" + tier + "<dev string:x3f>");
    }

    // Namespace phalanx/phalanx
    // Params 12, eflags: 0x4
    // Checksum 0x5f18437f, Offset: 0x630
    // Size: 0x1c8
    function private _dampenexplosivedamage(inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
        entity = self;
        isexplosive = isinarray(array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdamage);
        if (isexplosive && isdefined(inflictor) && isdefined(inflictor.weapon)) {
            weapon = inflictor.weapon;
            distancetoentity = distance(entity.origin, inflictor.origin);
            fractiondistance = 1;
            if (weapon.explosionradius > 0) {
                fractiondistance = (weapon.explosionradius - distancetoentity) / weapon.explosionradius;
            }
            return int(max(damage * fractiondistance, 1));
        }
        return damage;
    }

    // Namespace phalanx/phalanx
    // Params 6, eflags: 0x4
    // Checksum 0x821c9ace, Offset: 0x3e0
    // Size: 0x246
    function private _createphalanxtier(phalanxtype, tier, phalanxposition, forward, maxtiersize, spawner) {
        if (!isdefined(spawner)) {
            spawner = undefined;
        }
        sentients = [];
        if (!isspawner(spawner)) {
            spawner = _getphalanxspawner(tier);
        }
        positions = _getphalanxpositions(phalanxtype, tier);
        angles = vectortoangles(forward);
        foreach (index, position in positions) {
            if (index >= maxtiersize) {
                break;
            }
            orientedpos = _rotatevec(position, angles[1] - 90);
            navmeshposition = getclosestpointonnavmesh(phalanxposition + orientedpos, 200);
            if (!(spawner.spawnflags & 64)) {
                spawner.count++;
            }
            sentient = spawner spawner::spawn(1, "", navmeshposition, angles);
            _initializesentient(sentient);
            waitframe(1);
            sentients[sentients.size] = sentient;
        }
        return sentients;
    }

    // Namespace phalanx/phalanx
    // Params 2, eflags: 0x4
    // Checksum 0x8c0d15da, Offset: 0x2e0
    // Size: 0xf2
    function private _assignphalanxstance(sentients, stance) {
        assert(isarray(sentients));
        foreach (sentient in sentients) {
            if (isdefined(sentient) && isalive(sentient)) {
                sentient ai::set_behavior_attribute("phalanx_force_stance", stance);
            }
        }
    }

}

