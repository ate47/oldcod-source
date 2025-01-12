#using scripts\core_common\ai\systems\animation_state_machine_mocomp;

#namespace bot_animation;

// Namespace bot_animation/bot_animation
// Params 1, eflags: 0x0
// Checksum 0xe8b724c7, Offset: 0x98
// Size: 0x124
function play_animation(var_2c95ed43) {
    if (!self function_2009f642()) {
        return;
    }
    astresult = self astsearch(var_2c95ed43);
    if (!isdefined(astresult[#"animation"])) {
        return;
    }
    animation = self animmappingsearch(astresult[#"animation"]);
    self animscripted("bot_play_animation", self.origin, self.angles, animation, "server script", undefined, undefined, astresult[#"blend_in_time"], undefined, undefined, 1);
    self thread function_f04f05ac(animation, astresult[#"animation_mocomp"], astresult[#"blend_out_time"]);
}

// Namespace bot_animation/bot_animation
// Params 3, eflags: 0x4
// Checksum 0x22760eab, Offset: 0x1c8
// Size: 0x1f4
function private function_f04f05ac(animation, mocomp, blendout) {
    self endon(#"death");
    self endon(#"disconnect");
    animinfo = spawnstruct();
    animinfo.name = mocomp;
    animinfo.entity = self;
    animinfo.delta_anim = animation;
    animinfo.blend_out_time = blendout;
    animinfo.duration = max(0, getanimlength(animation) - blendout);
    animinfo.status = 0;
    animationstatenetwork::runanimationmocomp(animinfo);
    animlength = getanimlength(animation);
    animtime = self getanimtime(animation) * animlength;
    while (self isplayinganimscripted() && animtime < animinfo.duration) {
        animtime = self getanimtime(animation) * animlength;
        animinfo.status = 1;
        animationstatenetwork::runanimationmocomp(animinfo);
        waitframe(1);
    }
    animinfo.status = 2;
    animationstatenetwork::runanimationmocomp(animinfo);
    self stopanimscripted(blendout);
}

