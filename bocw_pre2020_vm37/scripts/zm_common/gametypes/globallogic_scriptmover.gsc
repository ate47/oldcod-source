#using scripts\core_common\callbacks_shared;

#namespace globallogic_scriptmover;

// Namespace globallogic_scriptmover/globallogic_scriptmover
// Params 16, eflags: 0x1 linked
// Checksum 0xe6ddb5bd, Offset: 0x68
// Size: 0x23c
function function_8c7ec52f(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, iboneindex, imodelindex, var_934bdd11, isurfacetype, vsurfacenormal) {
    if (isdefined(self.var_86a21346)) {
        idamage = self [[ self.var_86a21346 ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, iboneindex, imodelindex);
    } else if (isdefined(level.var_86a21346)) {
        idamage = self [[ level.var_86a21346 ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, iboneindex, imodelindex);
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
    params.var_934bdd11 = var_934bdd11;
    params.isurfacetype = isurfacetype;
    params.vsurfacenormal = vsurfacenormal;
    self callback::callback(#"hash_2e68909d4e4ed889", params);
    self function_f7f9c3eb(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, iboneindex, imodelindex, var_934bdd11, isurfacetype, vsurfacenormal);
}

