#namespace snipercam;

// Namespace snipercam/namespace_7db676d5
// Params 5
// Checksum 0x4d8c0d59, Offset: 0x80
// Size: 0x25e
function function_83d35e98( attacker, var_4fa5c66a, attackerangles, victim, mode = 1 )
{
    parms = spawnstruct();
    var_83ca76ef = 200;
    var_3d5fa3d5 = 30;
    target_tag = "j_head";
    
    if ( mode == 2 )
    {
        target_tag = "tag_weapon_chest";
    }
    
    parms.attacker = attacker;
    parms.var_4fa5c66a = var_4fa5c66a;
    parms.attackerangles = attackerangles;
    parms.victim = victim;
    parms.startpos = var_4fa5c66a;
    parms.startpos += anglestoforward( attackerangles ) * var_83ca76ef;
    parms.targetpos = victim gettagorigin( target_tag );
    parms.targetpos += vectornormalize( parms.startpos - parms.targetpos ) * var_3d5fa3d5;
    parms.angles = vectortoangles( parms.targetpos - parms.startpos );
    parms.forward = anglestoforward( parms.angles );
    parms.startpos += parms.forward;
    parms.distance = distance( parms.targetpos, parms.startpos );
    parms.endpos = parms.startpos + parms.forward * parms.distance;
    parms.timescale = 0.5;
    parms.time = parms.distance / 1500 * parms.timescale;
    return parms;
}

