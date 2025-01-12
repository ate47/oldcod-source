#using scripts\core_common\callbacks_shared;

#namespace globallogic_scriptmover;

// Namespace globallogic_scriptmover/globallogic_scriptmover
// Params 16, eflags: 0x0
// Checksum 0x94a71155, Offset: 0x70
// Size: 0x2bc
function function_d786279a(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, iboneindex, imodelindex, spartname, isurfacetype, vsurfacenormal) {
    if (isdefined(self.var_6b0336c0)) {
        idamage = self [[ self.var_6b0336c0 ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, iboneindex, imodelindex);
    } else if (isdefined(level.var_6b0336c0)) {
        idamage = self [[ level.var_6b0336c0 ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, iboneindex, imodelindex);
    }
    params = spawnstruct();
    params.einflictor = einflictor;
    params.eattacker = eattacker;
    params.idamage = idamage;
    params.idflags = idflags;
    params.smeansofdeath = smeansofdeath;
    params.weapon = weapon;
    params.vpoint = vpoint;
    params.vdir = vdir;
    params.shitloc = shitloc;
    params.vdamageorigin = vdamageorigin;
    params.psoffsettime = psoffsettime;
    params.iboneindex = iboneindex;
    params.imodelindex = imodelindex;
    params.spartname = spartname;
    params.isurfacetype = isurfacetype;
    params.vsurfacenormal = vsurfacenormal;
    self callback::callback(#"hash_2e68909d4e4ed889", params);
    self function_11e7dd73(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, iboneindex, imodelindex, spartname, isurfacetype, vsurfacenormal);
}

