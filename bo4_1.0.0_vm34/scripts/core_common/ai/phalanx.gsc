#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\values_shared;

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
    // Params 0, eflags: 0x8
    // Checksum 0x48386be0, Offset: 0x17e0
    // Size: 0x3e
    constructor() {
        sentienttiers_ = [];
        startsentientcount_ = 0;
        currentsentientcount_ = 0;
        breakingpoint_ = 0;
        scattered_ = 0;
    }

    // Namespace phalanx/phalanx
    // Params 0, eflags: 0x0
    // Checksum 0x29e48efd, Offset: 0x2008
    // Size: 0x16e
    function scatterphalanx() {
        if (!scattered_) {
            scattered_ = 1;
            _releasesentients(sentienttiers_[#"phalanx_tier1"]);
            sentienttiers_[#"phalanx_tier1"] = [];
            _assignphalanxstance(sentienttiers_[#"phalanx_tier2"], "crouch");
            wait randomfloatrange(5, 7);
            _releasesentients(sentienttiers_[#"phalanx_tier2"]);
            sentienttiers_[#"phalanx_tier2"] = [];
            _assignphalanxstance(sentienttiers_[#"phalanx_tier3"], "crouch");
            wait randomfloatrange(5, 7);
            _releasesentients(sentienttiers_[#"phalanx_tier3"]);
            sentienttiers_[#"phalanx_tier3"] = [];
        }
    }

    // Namespace phalanx/phalanx
    // Params 0, eflags: 0x0
    // Checksum 0x233202d8, Offset: 0x1f80
    // Size: 0x7c
    function resumefire() {
        _resumefiresentients(sentienttiers_[#"phalanx_tier1"]);
        _resumefiresentients(sentienttiers_[#"phalanx_tier2"]);
        _resumefiresentients(sentienttiers_[#"phalanx_tier3"]);
    }

    // Namespace phalanx/phalanx
    // Params 0, eflags: 0x0
    // Checksum 0x6602883a, Offset: 0x1e10
    // Size: 0x164
    function resumeadvance() {
        if (!scattered_) {
            _assignphalanxstance(sentienttiers_[#"phalanx_tier1"], "stand");
            wait 1;
            forward = vectornormalize(endposition_ - startposition_);
            _movephalanxtier(sentienttiers_[#"phalanx_tier1"], phalanxtype_, "phalanx_tier1", endposition_, forward);
            _movephalanxtier(sentienttiers_[#"phalanx_tier2"], phalanxtype_, "phalanx_tier2", endposition_, forward);
            _movephalanxtier(sentienttiers_[#"phalanx_tier3"], phalanxtype_, "phalanx_tier3", endposition_, forward);
            _assignphalanxstance(sentienttiers_[#"phalanx_tier1"], "crouch");
        }
    }

    // Namespace phalanx/phalanx
    // Params 8, eflags: 0x0
    // Checksum 0x3ffbf1b4, Offset: 0x1a58
    // Size: 0x3ac
    function initialize(phalanxtype, origin, destination, breakingpoint, maxtiersize = 10, tieronespawner = undefined, tiertwospawner = undefined, tierthreespawner = undefined) {
        assert(isstring(phalanxtype));
        assert(isint(breakingpoint));
        assert(isvec(origin));
        assert(isvec(destination));
        tierspawners = [];
        tierspawners[#"phalanx_tier1"] = tieronespawner;
        tierspawners[#"phalanx_tier2"] = tiertwospawner;
        tierspawners[#"phalanx_tier3"] = tierthreespawner;
        maxtiersize = math::clamp(maxtiersize, 1, 10);
        forward = vectornormalize(destination - origin);
        foreach (tiername in array("phalanx_tier1", "phalanx_tier2", "phalanx_tier3")) {
            sentienttiers_[tiername] = _createphalanxtier(phalanxtype, tiername, origin, forward, maxtiersize, tierspawners[tiername]);
            startsentientcount_ += sentienttiers_[tiername].size;
        }
        _assignphalanxstance(sentienttiers_[#"phalanx_tier1"], "crouch");
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
    // Checksum 0x87a2715f, Offset: 0x19c8
    // Size: 0x88
    function haltadvance() {
        if (!scattered_) {
            foreach (tier in sentienttiers_) {
                _haltadvance(tier);
            }
        }
    }

    // Namespace phalanx/phalanx
    // Params 0, eflags: 0x0
    // Checksum 0x54414541, Offset: 0x1948
    // Size: 0x78
    function haltfire() {
        foreach (tier in sentienttiers_) {
            _haltfire(tier);
        }
    }

    // Namespace phalanx/phalanx
    // Params 0, eflags: 0x4
    // Checksum 0x6d8488a3, Offset: 0x1838
    // Size: 0x104
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
    // Checksum 0xd31c8b0a, Offset: 0x17b0
    // Size: 0x28
    function private _updatephalanxthread(phalanx) {
        while ([[ phalanx ]]->_updatephalanx()) {
            wait 1;
        }
    }

    // Namespace phalanx/phalanx
    // Params 2, eflags: 0x4
    // Checksum 0xe509e4c3, Offset: 0x1708
    // Size: 0xa0
    function private _rotatevec(vector, angle) {
        return (vector[0] * cos(angle) - vector[1] * sin(angle), vector[0] * sin(angle) + vector[1] * cos(angle), vector[2]);
    }

    // Namespace phalanx/phalanx
    // Params 1, eflags: 0x4
    // Checksum 0xa03e4595, Offset: 0x1658
    // Size: 0xa8
    function private _resumefiresentients(sentients) {
        assert(isarray(sentients));
        foreach (sentient in sentients) {
            _resumefire(sentient);
        }
    }

    // Namespace phalanx/phalanx
    // Params 1, eflags: 0x4
    // Checksum 0x3efb7e95, Offset: 0x15f0
    // Size: 0x5c
    function private _resumefire(sentient) {
        if (isdefined(sentient) && isalive(sentient)) {
            sentient val::reset(#"halt_fire", "ignoreall");
        }
    }

    // Namespace phalanx/phalanx
    // Params 1, eflags: 0x4
    // Checksum 0x2d530144, Offset: 0x1530
    // Size: 0xb8
    function private _releasesentients(sentients) {
        foreach (sentient in sentients) {
            _resumefire(sentient);
            _releasesentient(sentient);
            wait randomfloatrange(0.5, 5);
        }
    }

    // Namespace phalanx/phalanx
    // Params 1, eflags: 0x4
    // Checksum 0x9b9cb37d, Offset: 0x13a8
    // Size: 0x17c
    function private _releasesentient(sentient) {
        if (isdefined(sentient) && isalive(sentient)) {
            sentient function_9f59031e();
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
    // Checksum 0xc3cb7e8b, Offset: 0x12f0
    // Size: 0xb0
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
    // Checksum 0xf823ea51, Offset: 0x10f8
    // Size: 0x1f0
    function private _movephalanxtier(sentients, phalanxtype, tier, destination, forward) {
        positions = _getphalanxpositions(phalanxtype, tier);
        angles = vectortoangles(forward);
        assert(sentients.size <= positions.size, "<dev string:x1b4>");
        foreach (index, sentient in sentients) {
            if (isdefined(sentient) && isalive(sentient)) {
                assert(isvec(positions[index]), "<dev string:x1f4>" + index + "<dev string:x221>" + tier + "<dev string:x22c>" + phalanxtype);
                orientedpos = _rotatevec(positions[index], angles[1] - 90);
                navmeshposition = getclosestpointonnavmesh(destination + orientedpos, 200);
                sentient function_3c8dce03(navmeshposition);
            }
        }
    }

    // Namespace phalanx/phalanx
    // Params 1, eflags: 0x0
    // Checksum 0x9ba617ab, Offset: 0xfc0
    // Size: 0x12c
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
    // Checksum 0x2aaaf7e4, Offset: 0xed8
    // Size: 0xe0
    function private _haltfire(sentients) {
        assert(isarray(sentients));
        foreach (sentient in sentients) {
            if (isdefined(sentient) && isalive(sentient)) {
                sentient val::set(#"halt_fire", "ignoreall", 1);
            }
        }
    }

    // Namespace phalanx/phalanx
    // Params 1, eflags: 0x4
    // Checksum 0xf217c6da, Offset: 0xda8
    // Size: 0x128
    function private _haltadvance(sentients) {
        assert(isarray(sentients));
        foreach (sentient in sentients) {
            if (isdefined(sentient) && isalive(sentient) && sentient haspath()) {
                navmeshposition = getclosestpointonnavmesh(sentient.origin, 200);
                sentient function_3c8dce03(navmeshposition);
                sentient clearpath();
            }
        }
    }

    // Namespace phalanx/phalanx
    // Params 1, eflags: 0x4
    // Checksum 0x1eee71b9, Offset: 0xce8
    // Size: 0xb4
    function private _getphalanxspawner(tier) {
        spawner = getspawnerarray(tier, "targetname");
        assert(spawner.size >= 0, "<dev string:x61>" + "<dev string:xa7>" + "<dev string:xef>");
        assert(spawner.size == 1, "<dev string:x106>" + "<dev string:x14a>" + "<dev string:x170>");
        return spawner[0];
    }

    // Namespace phalanx/phalanx
    // Params 2, eflags: 0x4
    // Checksum 0x24a38da6, Offset: 0x648
    // Size: 0x694
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
            break;
        case #"phalanx_reverse_wedge":
            switch (tier) {
            case #"phalanx_tier1":
                return array((-32, 0, 0), (32, 0, 0));
            case #"phalanx_tier2":
                return array((0, -96, 0));
            case #"phalanx_tier3":
                return array();
            }
            break;
        case #"phalanx_diagonal_left":
            switch (tier) {
            case #"phalanx_tier1":
                return array((0, 0, 0), (-48, -64, 0), (-96, -128, 0), (-144, -192, 0));
            case #"phalanx_tier2":
                return array((64, 0, 0), (16, -64, 0), (-48, -128, 0), (-112, -192, 0));
            case #"phalanx_tier3":
                return array();
            }
            break;
        case #"phalanx_diagonal_right":
            switch (tier) {
            case #"phalanx_tier1":
                return array((0, 0, 0), (48, -64, 0), (96, -128, 0), (144, -192, 0));
            case #"phalanx_tier2":
                return array((-64, 0, 0), (-16, -64, 0), (48, -128, 0), (112, -192, 0));
            case #"phalanx_tier3":
                return array();
            }
            break;
        case #"phalanx_forward":
            switch (tier) {
            case #"phalanx_tier1":
                return array((0, 0, 0), (64, 0, 0), (128, 0, 0), (192, 0, 0));
            case #"phalanx_tier2":
                return array((-32, -64, 0), (32, -64, 0), (96, -64, 0), (160, -64, 0));
            case #"phalanx_tier3":
                return array();
            }
            break;
        case #"phalanx_column":
            switch (tier) {
            case #"phalanx_tier1":
                return array((0, 0, 0), (-64, 0, 0), (0, -64, 0), (-64, -64, 0));
            case #"phalanx_tier2":
                return array((0, -128, 0), (-64, -128, 0), (0, -192, 0), (-64, -192, 0));
            case #"phalanx_tier3":
                return array((64, 0, 0), (64, -64, 0), (64, -128, 0), (64, -192, 0));
            }
            break;
        case #"phalanx_column_right":
            switch (tier) {
            case #"phalanx_tier1":
                return array((0, 0, 0), (0, -64, 0), (0, -128, 0), (0, -192, 0));
            case #"phalanx_tier2":
                return array();
            case #"phalanx_tier3":
                return array();
            }
            break;
        default:
            assert("<dev string:x30>" + phalanxtype + "<dev string:x47>");
            break;
        }
        assert("<dev string:x4a>" + tier + "<dev string:x47>");
    }

    // Namespace phalanx/phalanx
    // Params 12, eflags: 0x4
    // Checksum 0x5cf63200, Offset: 0x498
    // Size: 0x1a8
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
    // Checksum 0xfd47241b, Offset: 0x280
    // Size: 0x20c
    function private _createphalanxtier(phalanxtype, tier, phalanxposition, forward, maxtiersize, spawner = undefined) {
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
    // Checksum 0xb9b7583f, Offset: 0x1a0
    // Size: 0xd8
    function private _assignphalanxstance(sentients, stance) {
        assert(isarray(sentients));
        foreach (sentient in sentients) {
            if (isdefined(sentient) && isalive(sentient)) {
                sentient ai::set_behavior_attribute("phalanx_force_stance", stance);
            }
        }
    }

}

