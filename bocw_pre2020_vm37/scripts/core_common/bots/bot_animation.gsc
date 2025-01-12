#using scripts\core_common\ai\systems\animation_state_machine_mocomp;

#namespace bot_animation;

// Namespace bot_animation/bot_animation
// Params 1, eflags: 0x1 linked
// Checksum 0xdbba97b2, Offset: 0x90
// Size: 0x11c
function play_animation(var_f6550bae) {
    if (!self function_4a2ac86a()) {
        return;
    }
    astresult = self astsearch(var_f6550bae);
    if (!isdefined(astresult[#"animation"])) {
        return;
    }
    animation = self animmappingsearch(astresult[#"animation"]);
    self animscripted("bot_play_animation", self.origin, self.angles, animation, "server script", undefined, undefined, astresult[#"blend_in_time"], undefined, undefined, 1);
    self thread function_33f98f4(animation, astresult[#"animation_mocomp"], astresult[#"blend_out_time"]);
}

// Namespace bot_animation/bot_animation
// Params 3, eflags: 0x5 linked
// Checksum 0xb474407f, Offset: 0x1b8
// Size: 0x1dc
function private function_33f98f4(animation, mocomp, blendout) {
    self endon(#"death", #"disconnect");
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

