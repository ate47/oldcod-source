#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/values_shared;

#namespace robotphalanx;

// Namespace robotphalanx
// Method(s) 25 Total 25
class robotphalanx {

    var breakingpoint_;
    var currentrobotcount_;
    var endposition_;
    var phalanxtype_;
    var scattered_;
    var startposition_;
    var startrobotcount_;
    var tier1robots_;
    var tier2robots_;
    var tier3robots_;

    // Namespace robotphalanx/robot_phalanx
    // Params 0, eflags: 0x0
    // Checksum 0x3d2c650a, Offset: 0x1828
    // Size: 0x58
    function constructor() {
        tier1robots_ = [];
        tier2robots_ = [];
        tier3robots_ = [];
        startrobotcount_ = 0;
        currentrobotcount_ = 0;
        breakingpoint_ = 0;
        scattered_ = 0;
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 0, eflags: 0x0
    // Checksum 0x1e5b236, Offset: 0x1f68
    // Size: 0x108
    function scatterphalanx() {
        if (!scattered_) {
            scattered_ = 1;
            _releaserobots(tier1robots_);
            tier1robots_ = [];
            _assignphalanxstance(tier2robots_, "crouch");
            wait randomfloatrange(5, 7);
            _releaserobots(tier2robots_);
            tier2robots_ = [];
            _assignphalanxstance(tier3robots_, "crouch");
            wait randomfloatrange(5, 7);
            _releaserobots(tier3robots_);
            tier3robots_ = [];
        }
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 0, eflags: 0x0
    // Checksum 0xab7f06ee, Offset: 0x1f10
    // Size: 0x4c
    function resumefire() {
        _resumefirerobots(tier1robots_);
        _resumefirerobots(tier2robots_);
        _resumefirerobots(tier3robots_);
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 0, eflags: 0x0
    // Checksum 0x16169fa6, Offset: 0x1dd0
    // Size: 0x134
    function resumeadvance() {
        if (!scattered_) {
            _assignphalanxstance(tier1robots_, "stand");
            wait 1;
            forward = vectornormalize(endposition_ - startposition_);
            _movephalanxtier(tier1robots_, phalanxtype_, "phalanx_tier1", endposition_, forward);
            _movephalanxtier(tier2robots_, phalanxtype_, "phalanx_tier2", endposition_, forward);
            _movephalanxtier(tier3robots_, phalanxtype_, "phalanx_tier3", endposition_, forward);
            _assignphalanxstance(tier1robots_, "crouch");
        }
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 8, eflags: 0x0
    // Checksum 0x9507510d, Offset: 0x1a50
    // Size: 0x374
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
        maxtiersize = math::clamp(maxtiersize, 1, 10);
        forward = vectornormalize(destination - origin);
        tier1robots_ = _createphalanxtier(phalanxtype, "phalanx_tier1", origin, forward, maxtiersize, tieronespawner);
        tier2robots_ = _createphalanxtier(phalanxtype, "phalanx_tier2", origin, forward, maxtiersize, tiertwospawner);
        tier3robots_ = _createphalanxtier(phalanxtype, "phalanx_tier3", origin, forward, maxtiersize, tierthreespawner);
        _assignphalanxstance(tier1robots_, "crouch");
        _movephalanxtier(tier1robots_, phalanxtype, "phalanx_tier1", destination, forward);
        _movephalanxtier(tier2robots_, phalanxtype, "phalanx_tier2", destination, forward);
        _movephalanxtier(tier3robots_, phalanxtype, "phalanx_tier3", destination, forward);
        startrobotcount_ = tier1robots_.size + tier2robots_.size + tier3robots_.size;
        breakingpoint_ = breakingpoint;
        startposition_ = origin;
        endposition_ = destination;
        phalanxtype_ = phalanxtype;
        self thread _updatephalanxthread(self);
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 0, eflags: 0x0
    // Checksum 0x4d7277ba, Offset: 0x19e8
    // Size: 0x5c
    function haltadvance() {
        if (!scattered_) {
            _haltadvance(tier1robots_);
            _haltadvance(tier2robots_);
            _haltadvance(tier3robots_);
        }
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 0, eflags: 0x0
    // Checksum 0x96818b8b, Offset: 0x1990
    // Size: 0x4c
    function haltfire() {
        _haltfire(tier1robots_);
        _haltfire(tier2robots_);
        _haltfire(tier3robots_);
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 0, eflags: 0x4
    // Checksum 0xb1397bdf, Offset: 0x1898
    // Size: 0xec
    function private _updatephalanx() {
        if (scattered_) {
            return false;
        }
        tier1robots_ = _prunedead(tier1robots_);
        tier2robots_ = _prunedead(tier2robots_);
        tier3robots_ = _prunedead(tier3robots_);
        currentrobotcount_ = tier1robots_.size + tier2robots_.size + tier2robots_.size;
        if (currentrobotcount_ <= startrobotcount_ - breakingpoint_) {
            scatterphalanx();
            return false;
        }
        return true;
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 1, eflags: 0x4
    // Checksum 0xd714af38, Offset: 0x17f8
    // Size: 0x28
    function private _updatephalanxthread(phalanx) {
        while ([[ phalanx ]]->_updatephalanx()) {
            wait 1;
        }
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 2, eflags: 0x4
    // Checksum 0x37ba25e8, Offset: 0x1750
    // Size: 0xa0
    function private _rotatevec(vector, angle) {
        return (vector[0] * cos(angle) - vector[1] * sin(angle), vector[0] * sin(angle) + vector[1] * cos(angle), vector[2]);
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 1, eflags: 0x4
    // Checksum 0xfbaf1ed4, Offset: 0x1680
    // Size: 0xc2
    function private _resumefirerobots(robots) {
        assert(isarray(robots));
        foreach (robot in robots) {
            _resumefire(robot);
        }
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 1, eflags: 0x4
    // Checksum 0xeb0083c8, Offset: 0x1620
    // Size: 0x54
    function private _resumefire(robot) {
        if (isdefined(robot) && isalive(robot)) {
            robot val::reset("halt_fire", "ignoreall");
        }
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 1, eflags: 0x4
    // Checksum 0xc00ab2d9, Offset: 0x1548
    // Size: 0xca
    function private _releaserobots(robots) {
        foreach (robot in robots) {
            _resumefire(robot);
            _releaserobot(robot);
            wait randomfloatrange(0.5, 5);
        }
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 1, eflags: 0x4
    // Checksum 0x7af195a4, Offset: 0x13e8
    // Size: 0x154
    function private _releaserobot(robot) {
        if (isdefined(robot) && isalive(robot)) {
            robot clearuseposition();
            robot pathmode("move delayed", 1, randomfloatrange(0.5, 1));
            robot ai::set_behavior_attribute("phalanx", 0);
            waitframe(1);
            if (isdefined(robot) && isalive(robot)) {
                robot ai::set_behavior_attribute("move_mode", "normal");
                robot ai::set_behavior_attribute("force_cover", 0);
                robot setavoidancemask("avoid all");
                aiutility::removeaioverridedamagecallback(robot, &_dampenexplosivedamage);
            }
        }
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 1, eflags: 0x4
    // Checksum 0xff46e90f, Offset: 0x1320
    // Size: 0xc0
    function private _prunedead(robots) {
        liverobots = [];
        foreach (index, robot in robots) {
            if (isdefined(robot) && isalive(robot)) {
                liverobots[index] = robot;
            }
        }
        return liverobots;
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 5, eflags: 0x4
    // Checksum 0x9fae55dd, Offset: 0x1100
    // Size: 0x212
    function private _movephalanxtier(robots, phalanxtype, tier, destination, forward) {
        positions = _getphalanxpositions(phalanxtype, tier);
        angles = vectortoangles(forward);
        assert(robots.size <= positions.size, "<dev string:x1b8>");
        foreach (index, robot in robots) {
            if (isdefined(robot) && isalive(robot)) {
                assert(isvec(positions[index]), "<dev string:x1f8>" + index + "<dev string:x225>" + tier + "<dev string:x230>" + phalanxtype);
                orientedpos = _rotatevec(positions[index], angles[1] - 90);
                navmeshposition = getclosestpointonnavmesh(destination + orientedpos, 200);
                robot useposition(navmeshposition);
            }
        }
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 1, eflags: 0x4
    // Checksum 0x26c0dff4, Offset: 0x1008
    // Size: 0xec
    function private _initializerobot(robot) {
        assert(isactor(robot));
        robot ai::set_behavior_attribute("phalanx", 1);
        robot ai::set_behavior_attribute("move_mode", "marching");
        robot ai::set_behavior_attribute("force_cover", 1);
        robot setavoidancemask("avoid none");
        aiutility::addaioverridedamagecallback(robot, &_dampenexplosivedamage, 1);
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 1, eflags: 0x4
    // Checksum 0x44078dfb, Offset: 0xf08
    // Size: 0xf2
    function private _haltfire(robots) {
        assert(isarray(robots));
        foreach (robot in robots) {
            if (isdefined(robot) && isalive(robot)) {
                robot val::set("halt_fire", "ignoreall", 1);
            }
        }
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 1, eflags: 0x4
    // Checksum 0xdd6cc4a, Offset: 0xdb0
    // Size: 0x14a
    function private _haltadvance(robots) {
        assert(isarray(robots));
        foreach (robot in robots) {
            if (isdefined(robot) && isalive(robot) && robot haspath()) {
                navmeshposition = getclosestpointonnavmesh(robot.origin, 200);
                robot useposition(navmeshposition);
                robot clearpath();
            }
        }
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 1, eflags: 0x4
    // Checksum 0x8efc0d9c, Offset: 0xce8
    // Size: 0xbc
    function private _getphalanxspawner(tier) {
        spawner = getspawnerarray(tier, "targetname");
        assert(spawner.size >= 0, "<dev string:x59>" + "<dev string:xa5>" + "<dev string:xed>");
        assert(spawner.size == 1, "<dev string:x104>" + "<dev string:x14e>" + "<dev string:x174>");
        return spawner[0];
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 2, eflags: 0x4
    // Checksum 0xaac708fa, Offset: 0x7f8
    // Size: 0x4e4
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
            goto LOC_00000188;
        case #"phalanx_diagonal_left":
            switch (tier) {
            case #"phalanx_tier1":
                return array((0, 0, 0), (-48, -64, 0), (-96, -128, 0), (-144, -192, 0));
            case #"phalanx_tier2":
                return array((64, 0, 0), (16, -64, 0), (-48, -128, 0), (-112, -192, 0));
            case #"phalanx_tier3":
                return array();
            }
        LOC_00000188:
            goto LOC_00000248;
        case #"phalanx_diagonal_right":
            switch (tier) {
            case #"phalanx_tier1":
                return array((0, 0, 0), (48, -64, 0), (96, -128, 0), (144, -192, 0));
            case #"phalanx_tier2":
                return array((-64, 0, 0), (-16, -64, 0), (48, -128, 0), (112, -192, 0));
            case #"phalanx_tier3":
                return array();
            }
        LOC_00000248:
            goto LOC_00000300;
        case #"phalanx_forward":
            switch (tier) {
            case #"phalanx_tier1":
                return array((0, 0, 0), (64, 0, 0), (128, 0, 0), (192, 0, 0));
            case #"phalanx_tier2":
                return array((-32, -64, 0), (32, -64, 0), (96, -64, 0), (160, -64, 0));
            case #"phalanx_tier3":
                return array();
            }
        LOC_00000300:
            goto LOC_000003c0;
        case #"phalanx_column":
            switch (tier) {
            case #"phalanx_tier1":
                return array((0, 0, 0), (-64, 0, 0), (0, -64, 0), (-64, -64, 0));
            case #"phalanx_tier2":
                return array((0, -128, 0), (-64, -128, 0), (0, -192, 0), (-64, -192, 0));
            case #"phalanx_tier3":
                return array();
            }
        LOC_000003c0:
            goto LOC_00000448;
        case #"phalanx_column_right":
            switch (tier) {
            case #"phalanx_tier1":
                return array((0, 0, 0), (0, -64, 0), (0, -128, 0), (0, -192, 0));
            case #"phalanx_tier2":
                return array();
            case #"phalanx_tier3":
                return array();
            }
        LOC_00000448:
            break;
        default:
            assert("<dev string:x28>" + phalanxtype + "<dev string:x3f>");
            break;
        }
        assert("<dev string:x42>" + tier + "<dev string:x3f>");
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 12, eflags: 0x4
    // Checksum 0xc4cef518, Offset: 0x628
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

    // Namespace robotphalanx/robot_phalanx
    // Params 6, eflags: 0x4
    // Checksum 0xaef8a709, Offset: 0x3c0
    // Size: 0x25e
    function private _createphalanxtier(phalanxtype, tier, phalanxposition, forward, maxtiersize, spawner) {
        if (!isdefined(spawner)) {
            spawner = undefined;
        }
        robots = [];
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
            robot = spawner spawner::spawn(1, "", navmeshposition, angles);
            if (isalive(robot)) {
                _initializerobot(robot);
                waitframe(1);
                robots[robots.size] = robot;
            }
        }
        return robots;
    }

    // Namespace robotphalanx/robot_phalanx
    // Params 2, eflags: 0x4
    // Checksum 0xf491940f, Offset: 0x2c0
    // Size: 0xf2
    function private _assignphalanxstance(robots, stance) {
        assert(isarray(robots));
        foreach (robot in robots) {
            if (isdefined(robot) && isalive(robot)) {
                robot ai::set_behavior_attribute("phalanx_force_stance", stance);
            }
        }
    }

}

