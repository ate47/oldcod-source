#using scripts\core_common\ai\archetype_aivsaimelee;
#using scripts\core_common\ai\archetype_cover_utility;
#using scripts\core_common\ai\archetype_human_cover;
#using scripts\core_common\ai\archetype_mocomps_utility;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\systems\shared;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace aiutility;

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x6
// Checksum 0xc207db5e, Offset: 0x980
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"archetype_utility", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x5 linked
// Checksum 0x1af1b9dc, Offset: 0x9c8
// Size: 0x14
function private function_70a657d8() {
    registerbehaviorscriptfunctions();
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x5 linked
// Checksum 0x2a6ba4b6, Offset: 0x9e8
// Size: 0x233c
function private registerbehaviorscriptfunctions() {
    assert(iscodefunctionptr(&btapi_forceragdoll));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_forceragdoll", &btapi_forceragdoll);
    assert(iscodefunctionptr(&btapi_hasammo));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_hasammo", &btapi_hasammo);
    assert(iscodefunctionptr(&btapi_haslowammo));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_haslowammo", &btapi_haslowammo);
    assert(isscriptfunctionptr(&function_2de6da8));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6a474bfdd215a3f4", &function_2de6da8);
    assert(isscriptfunctionptr(&function_a9bc841));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_185ec143f3641fa6", &function_a9bc841);
    assert(iscodefunctionptr(&btapi_hasenemy));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_hasenemy", &btapi_hasenemy);
    assert(isscriptfunctionptr(&function_e0454a8b));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_10923e11cc70c83f", &function_e0454a8b);
    assert(isscriptfunctionptr(&issafefromgrenades));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_issafefromgrenades", &issafefromgrenades);
    assert(isscriptfunctionptr(&issafefromgrenades));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"issafefromgrenades", &issafefromgrenades);
    assert(isscriptfunctionptr(&function_865ea8e6));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2ff118c59ed4bd9e", &function_865ea8e6);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_78488585a31af367", &function_8f12f910);
    assert(isscriptfunctionptr(&recentlysawenemy));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"recentlysawenemy", &recentlysawenemy);
    assert(isscriptfunctionptr(&shouldbeaggressive));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldbeaggressive", &shouldbeaggressive);
    assert(isscriptfunctionptr(&shouldonlyfireaccurately));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldonlyfireaccurately", &shouldonlyfireaccurately);
    assert(isscriptfunctionptr(&canblindfire));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"canblindfire", &canblindfire);
    assert(isscriptfunctionptr(&shouldreacttonewenemy));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldreacttonewenemy", &shouldreacttonewenemy);
    assert(isscriptfunctionptr(&shouldreacttonewenemy));
    behaviorstatemachine::registerbsmscriptapiinternal(#"shouldreacttonewenemy", &shouldreacttonewenemy);
    assert(isscriptfunctionptr(&function_fa6d93ea));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2ec2006a59a43ce", &function_fa6d93ea);
    assert(isscriptfunctionptr(&hasweaponmalfunctioned));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hasweaponmalfunctioned", &hasweaponmalfunctioned);
    assert(isscriptfunctionptr(&shouldstopmoving));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldstopmoving", &shouldstopmoving);
    assert(isscriptfunctionptr(&shouldstopmoving));
    behaviorstatemachine::registerbsmscriptapiinternal(#"shouldstopmoving", &shouldstopmoving);
    assert(isscriptfunctionptr(&function_abb9c007));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_750c8220e46d9ba", &function_abb9c007);
    assert(isscriptfunctionptr(&function_abb9c007));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_750c8220e46d9ba", &function_abb9c007);
    assert(isscriptfunctionptr(&choosebestcovernodeasap));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"choosebestcovernodeasap", &choosebestcovernodeasap);
    assert(isscriptfunctionptr(&choosebettercoverservicecodeversion));
    behaviortreenetworkutility::registerbehaviortreescriptapi("chooseBetterCoverService", &choosebettercoverservicecodeversion, 1);
    assert(isscriptfunctionptr(&sensenearbyplayers));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"sensenearbyplayers", &sensenearbyplayers);
    assert(iscodefunctionptr(&btapi_trackcoverparamsservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_trackcoverparamsservice", &btapi_trackcoverparamsservice);
    assert(iscodefunctionptr(&btapi_refillammo));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_refillammoifneededservice", &btapi_refillammo);
    assert(isscriptfunctionptr(&trystoppingservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"trystoppingservice", &trystoppingservice);
    assert(isscriptfunctionptr(&isfrustrated));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isfrustrated", &isfrustrated);
    assert(isscriptfunctionptr(&function_22766ccd));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7a7ca1fd075b9349", &function_22766ccd);
    assert(isscriptfunctionptr(&function_d116f6b4));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_40e03ac97f371cb1", &function_d116f6b4);
    assert(iscodefunctionptr(&btapi_updatefrustrationlevel));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_updatefrustrationlevel", &btapi_updatefrustrationlevel);
    assert(isscriptfunctionptr(&islastknownenemypositionapproachable));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"islastknownenemypositionapproachable", &islastknownenemypositionapproachable);
    assert(isscriptfunctionptr(&tryadvancingonlastknownpositionbehavior));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"tryadvancingonlastknownpositionbehavior", &tryadvancingonlastknownpositionbehavior);
    assert(isscriptfunctionptr(&function_15b9bbef));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6eddb51350d11f58", &function_15b9bbef);
    assert(isscriptfunctionptr(&trygoingtoclosestnodetoenemybehavior));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"trygoingtoclosestnodetoenemybehavior", &trygoingtoclosestnodetoenemybehavior);
    assert(isscriptfunctionptr(&tryrunningdirectlytoenemybehavior));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"tryrunningdirectlytoenemybehavior", &tryrunningdirectlytoenemybehavior);
    assert(isscriptfunctionptr(&flagenemyunattackableservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"flagenemyunattackableservice", &flagenemyunattackableservice);
    assert(isscriptfunctionptr(&keepclaimnode));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"keepclaimnode", &keepclaimnode);
    assert(isscriptfunctionptr(&keepclaimnode));
    behaviorstatemachine::registerbsmscriptapiinternal(#"keepclaimnode", &keepclaimnode);
    assert(isscriptfunctionptr(&releaseclaimnode));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"releaseclaimnode", &releaseclaimnode);
    assert(isscriptfunctionptr(&releaseclaimnode));
    behaviorstatemachine::registerbsmscriptapiinternal(#"releaseclaimnode", &releaseclaimnode);
    assert(isscriptfunctionptr(&scriptstartragdoll));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"startragdoll", &scriptstartragdoll);
    assert(isscriptfunctionptr(&notstandingcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"notstandingcondition", &notstandingcondition);
    assert(isscriptfunctionptr(&notcrouchingcondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"notcrouchingcondition", &notcrouchingcondition);
    assert(isscriptfunctionptr(&function_736c20e1));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_34d02056cda999ed", &function_736c20e1);
    assert(isscriptfunctionptr(&function_4aff5b9d));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_67f7516b1162e7ee", &function_4aff5b9d);
    assert(isscriptfunctionptr(&function_4aff5b9d));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_67f7516b1162e7ee", &function_4aff5b9d);
    assert(isscriptfunctionptr(&meleeacquiremutex));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"meleeacquiremutex", &meleeacquiremutex);
    assert(isscriptfunctionptr(&meleereleasemutex));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"meleereleasemutex", &meleereleasemutex);
    assert(isscriptfunctionptr(&prepareforexposedmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"prepareforexposedmelee", &prepareforexposedmelee);
    assert(isscriptfunctionptr(&cleanupmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupmelee", &cleanupmelee);
    assert(iscodefunctionptr(&btapi_shouldnormalmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_shouldnormalmelee", &btapi_shouldnormalmelee);
    assert(iscodefunctionptr(&btapi_shouldnormalmelee));
    behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldnormalmelee", &btapi_shouldnormalmelee);
    assert(iscodefunctionptr(&btapi_shouldmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_shouldmelee", &btapi_shouldmelee);
    assert(iscodefunctionptr(&btapi_shouldmelee));
    behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldmelee", &btapi_shouldmelee);
    assert(isscriptfunctionptr(&isbalconydeath));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isbalconydeath", &isbalconydeath);
    assert(isscriptfunctionptr(&balconydeath));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"balconydeath", &balconydeath);
    assert(isscriptfunctionptr(&usecurrentposition));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"usecurrentposition", &usecurrentposition);
    assert(isscriptfunctionptr(&isunarmed));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isunarmed", &isunarmed);
    assert(isscriptfunctionptr(&function_459c5ea7));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_712bff7525e4a6b8", &function_459c5ea7);
    assert(isscriptfunctionptr(&function_b375c36c));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3da552249ce651af", &function_b375c36c);
    assert(isscriptfunctionptr(&function_39c7ce7f));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_a8b8446f4206a0a", &function_39c7ce7f);
    assert(iscodefunctionptr(&btapi_shouldchargemelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_shouldchargemelee", &btapi_shouldchargemelee);
    assert(iscodefunctionptr(&btapi_shouldchargemelee));
    behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldchargemelee", &btapi_shouldchargemelee);
    assert(isscriptfunctionptr(&cleanupchargemelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupchargemelee", &cleanupchargemelee);
    assert(isscriptfunctionptr(&cleanupchargemeleeattack));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupchargemeleeattack", &cleanupchargemeleeattack);
    assert(isscriptfunctionptr(&setupchargemeleeattack));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"setupchargemeleeattack", &setupchargemeleeattack);
    assert(isscriptfunctionptr(&function_de7e2d3f));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_209f67e4390a01e4", &function_de7e2d3f);
    assert(isscriptfunctionptr(&function_9414b79f));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_6cd29429666ea22d", &function_9414b79f);
    assert(isscriptfunctionptr(&function_bcbf3f38));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_6ae246561f9295e4", &function_bcbf3f38);
    assert(isscriptfunctionptr(&shouldchoosespecialpain));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchoosespecialpain", &shouldchoosespecialpain);
    assert(isscriptfunctionptr(&function_9b0e7a22));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_50fc16dcf1175197", &function_9b0e7a22);
    assert(isscriptfunctionptr(&shouldchoosespecialpronepain));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchoosespecialpronepain", &shouldchoosespecialpronepain);
    assert(isscriptfunctionptr(&function_89cb7bfd));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_78675d76c0c51e10", &function_89cb7bfd);
    assert(isscriptfunctionptr(&shouldchoosespecialdeath));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchoosespecialdeath", &shouldchoosespecialdeath);
    assert(isscriptfunctionptr(&shouldchoosespecialpronedeath));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchoosespecialpronedeath", &shouldchoosespecialpronedeath);
    assert(isscriptfunctionptr(&setupexplosionanimscale));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"setupexplosionanimscale", &setupexplosionanimscale);
    function_7a62f47d();
    assert(iscodefunctionptr(&btapi_isinphalanx));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_isinphalanx", &btapi_isinphalanx);
    assert(isscriptfunctionptr(&isinphalanx));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isinphalanx", &isinphalanx);
    assert(isscriptfunctionptr(&isinphalanxstance));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isinphalanxstance", &isinphalanxstance);
    assert(isscriptfunctionptr(&togglephalanxstance));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"togglephalanxstance", &togglephalanxstance);
    assert(isscriptfunctionptr(&isatattackobject));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatattackobject", &isatattackobject);
    assert(isscriptfunctionptr(&shouldattackobject));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldattackobject", &shouldattackobject);
    assert(isscriptfunctionptr(&generictryreacquireservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"generictryreacquireservice", &generictryreacquireservice);
    behaviortreenetworkutility::registerbehaviortreeaction(#"defaultaction", undefined, undefined, undefined);
    archetype_aivsaimelee::registeraivsaimeleebehaviorfunctions();
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x3f92f70c, Offset: 0x2d30
// Size: 0x235c
function function_7a62f47d() {
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldstealth", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealthreactcondition", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"locomotionshouldstealth", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldstealthresume", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealthreactstart", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealthreactterminate", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealthidleterminate", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6015c026b1fa3b68", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6903274957b06c58", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"ifinstealth", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_30483c99fb320ecb", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5d5935e442748f9e", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2b4b5597da9bc2f8", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_8374ad58022a136", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_652e009b8323c31b", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealth_enemy_updateeveryframe", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_65e89f484bba20bb", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_14f8e3d6eda75d6a", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_458e9a34b803db29", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7ed5e6ee9b115c2a", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_77e5c00cfcf7002e", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5d73de1aab3eb35d", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_ae56f63cd9fbe86", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealth_shouldinvestigate", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6431cd50d65a767c", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_31b933dc0e7c5c84", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1e0ad4032a3da41f", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1c37119295b3cc48", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6a892d952d9c58b7", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_247b034a88a7e3b", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_540afeb2906c14c7", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_44e72b8fcdaf3ff8", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealth_shouldhunt", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1432a729e25120ac", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4691e67cad7d9b37", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6c20630dac281d70", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7c50b51a79eba680", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1a2cb215f0adfdab", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_a287df3d9435b4c", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4429fadb560937b5", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4d4262f789528f48", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6623ac05b3e89d2", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_c3501ebe051547e", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_633bd00a4c6c070d", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_38670b1f6bfc60d6", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_219ee8817462ba75", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_56707481883cec89", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_72041acc7d1e9e99", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_a1c1fb228689f9c", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_fef2a96c4de38c7", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3cb50e01a7d9b2e0", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7faa7f08cbd182e0", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2792d75a8b597397", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealth_neutral_updateeveryframe", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_15db81c49c83357e", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"ifshoulddosmartobject", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"dosmartobject", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"dosmartobject_init", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_792be4bd91e1c9e2", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4ab3a0d2b8ce1d48", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3fb32d4ff7ddb9f7", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2fa97de855da1e4f", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_23286b53d24487b4", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_22ca87c523f21d6d", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1d1883695574917c", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1cad32c846c91188", &function_8f12f910);
    assert(isscriptfunctionptr(&function_865ea8e6));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_37829e514d614663", &function_865ea8e6);
    assert(isscriptfunctionptr(&function_865ea8e6));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_66bfafd78f8a2da4", &function_865ea8e6);
    assert(isscriptfunctionptr(&function_865ea8e6));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_28aa53308dae6714", &function_865ea8e6);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_77e5c00cfcf7002e", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5d73de1aab3eb35d", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_ae56f63cd9fbe86", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_76d6aa4d32b2559c", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1082b3ce4938748d", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldstealth", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_6015c026b1fa3b68", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_6903274957b06c58", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviorstatemachine::registerbsmscriptapiinternal(#"stealthreactcondition", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_34ba896ad71ef639", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_247b034a88a7e3b", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_540afeb2906c14c7", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_44e72b8fcdaf3ff8", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_2fa97de855da1e4f", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7cd1f4f1d328c8c", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_344cc9226dda1596", &function_8f12f910);
    assert(isscriptfunctionptr(&function_8f12f910));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_1082b3ce4938748d", &function_8f12f910);
    assert(isscriptfunctionptr(&function_865ea8e6));
    behaviorstatemachine::registerbsmscriptapiinternal(#"alwaystrue", &function_865ea8e6);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x3db455bd, Offset: 0x5098
// Size: 0xe
function function_8f12f910(*entity) {
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x3e6fbf02, Offset: 0x50b0
// Size: 0x10
function function_865ea8e6(*entity) {
    return true;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x5 linked
// Checksum 0x5fa3bf73, Offset: 0x50c8
// Size: 0x152
function private bb_getstairsnumskipsteps() {
    assert(isdefined(self._stairsstartnode) && isdefined(self._stairsendnode));
    numtotalsteps = self getblackboardattribute("_staircase_num_total_steps");
    stepssofar = self getblackboardattribute("_staircase_num_steps");
    direction = self getblackboardattribute("_staircase_direction");
    numoutsteps = 2;
    totalstepswithoutout = numtotalsteps - numoutsteps;
    assert(stepssofar < totalstepswithoutout);
    remainingsteps = totalstepswithoutout - stepssofar;
    if (remainingsteps >= 8) {
        return "staircase_skip_8";
    } else if (remainingsteps >= 6) {
        return "staircase_skip_6";
    }
    assert(remainingsteps >= 3);
    return "staircase_skip_3";
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x861ac480, Offset: 0x5228
// Size: 0x5c
function function_459c5ea7(entity) {
    return function_27675652(entity) === "_vault_over_drop" || function_b375c36c(entity) || function_39c7ce7f(entity);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x403a3928, Offset: 0x5290
// Size: 0x2c
function function_b375c36c(entity) {
    return function_27675652(entity) === "_vault_jump_up_drop";
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x6b0f088f, Offset: 0x52c8
// Size: 0x2c
function function_39c7ce7f(entity) {
    return function_27675652(entity) === "_vault_jump_down_drop";
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x26ce9863, Offset: 0x5300
// Size: 0x37e
function function_27675652(entity) {
    assert(isdefined(entity.var_854857c6));
    traversaltype = entity getblackboardattribute("_parametric_traversal_type");
    if (!isdefined(traversaltype) || traversaltype != "mantle_traversal") {
        return undefined;
    }
    if (!isdefined(entity.var_854857c6)) {
        return undefined;
    }
    if (!isdefined(entity.ai.var_e233df10)) {
        entity.ai.var_e233df10 = [];
        bundle = getscriptbundle(entity.var_854857c6);
        entity.ai.var_e233df10[#"min"] = bundle.var_f850cb73;
        entity.ai.var_e233df10[#"max"] = bundle.var_f724517b;
    }
    if (!isdefined(entity.ai.var_e233df10[#"min"])) {
        entity.ai.var_e233df10[#"min"] = 0.8;
    }
    if (!isdefined(entity.ai.var_e233df10[#"max"])) {
        entity.ai.var_e233df10[#"max"] = 1.2;
    }
    startnode = entity.traversestartnode;
    endnode = entity.traverseendnode;
    mantlenode = entity.traversemantlenode;
    if (!isdefined(mantlenode)) {
        return undefined;
    }
    startheight = mantlenode.origin[2] - startnode.origin[2];
    var_b6b9b5f0 = mantlenode.origin[2] - endnode.origin[2];
    /#
        if (startheight == 0 || var_b6b9b5f0 == 0) {
            assertmsg("<dev string:x38>" + mantlenode.origin[0] + "<dev string:x62>" + mantlenode.origin[1] + "<dev string:x62>" + mantlenode.origin[2] + "<dev string:x68>");
        }
    #/
    ratio = abs(var_b6b9b5f0 / startheight);
    if (ratio < entity.ai.var_e233df10[#"min"]) {
        return "_vault_jump_up_drop";
    }
    if (ratio > entity.ai.var_e233df10[#"max"]) {
        return "_vault_jump_down_drop";
    }
    return "_vault_over_drop";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x5 linked
// Checksum 0xc334ba52, Offset: 0x5688
// Size: 0x8a
function private function_36e869c5() {
    entity = self;
    startnode = entity.traversestartnode;
    mantlenode = entity.traversemantlenode;
    if (!isdefined(mantlenode)) {
        return undefined;
    }
    startheight = abs(mantlenode.origin[2] - startnode.origin[2]);
    return startheight;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x5 linked
// Checksum 0x6b676a4e, Offset: 0x5720
// Size: 0x8a
function private function_975e9355() {
    entity = self;
    endnode = entity.traverseendnode;
    mantlenode = entity.traversemantlenode;
    if (!isdefined(mantlenode)) {
        return undefined;
    }
    var_b6b9b5f0 = abs(mantlenode.origin[2] - endnode.origin[2]);
    return var_b6b9b5f0;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x5 linked
// Checksum 0x735ce9d5, Offset: 0x57b8
// Size: 0x25c
function private bb_gettraversalheight() {
    entity = self;
    startposition = entity.traversalstartpos;
    endposition = entity.traversalendpos;
    if (isdefined(entity.traveseheightoverride)) {
        /#
            record3dtext("<dev string:x6e>" + entity.traveseheightoverride, self.origin + (0, 0, 32), (1, 0, 0), "<dev string:x83>");
        #/
        return entity.traveseheightoverride;
    }
    if (isdefined(entity.traversemantlenode) || entity function_dd4f686e()) {
        pivotorigin = archetype_mocomps_utility::calculatepivotoriginfromedge(entity, entity.traversemantlenode, entity.origin);
        traversalheight = pivotorigin[2] - (is_true(entity.var_fad2bca9) && isdefined(entity.traversalstartpos) ? entity.traversalstartpos[2] : entity.origin[2]);
        /#
            record3dtext("<dev string:x6e>" + traversalheight, self.origin + (0, 0, 32), (1, 0, 0), "<dev string:x83>");
        #/
        return traversalheight;
    } else if (isdefined(startposition) && isdefined(endposition)) {
        traversalheight = endposition[2] - startposition[2];
        if (bb_getparametrictraversaltype() == "jump_across_traversal") {
            traversalheight = abs(traversalheight);
        }
        /#
            record3dtext("<dev string:x6e>" + traversalheight, self.origin + (0, 0, 32), (1, 0, 0), "<dev string:x83>");
        #/
        return traversalheight;
    }
    return 0;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x5 linked
// Checksum 0x65e2c7c8, Offset: 0x5a20
// Size: 0x124
function private bb_gettraversalwidth() {
    entity = self;
    startposition = entity.traversalstartpos;
    endposition = entity.traversalendpos;
    if (isdefined(entity.travesewidthoverride)) {
        /#
            record3dtext("<dev string:x8d>" + entity.travesewidthoverride, self.origin + (0, 0, 48), (1, 0, 0), "<dev string:x83>");
        #/
        return entity.travesewidthoverride;
    }
    if (isdefined(startposition) && isdefined(endposition)) {
        var_d4b651b8 = distance2d(startposition, endposition);
        /#
            record3dtext("<dev string:x8d>" + var_d4b651b8, self.origin + (0, 0, 48), (1, 0, 0), "<dev string:x83>");
        #/
        return var_d4b651b8;
    }
    return 0;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x36320620, Offset: 0x5b50
// Size: 0x2d2
function bb_getparametrictraversaltype() {
    entity = self;
    if (entity function_3c566724()) {
        if (entity function_dd4f686e()) {
            return "mantle_traversal";
        }
        startposition = entity.traversalstartpos;
        endposition = entity.traversalendpos;
        if (isdefined(startposition) && isdefined(endposition)) {
            traversaldistance = distance2d(startposition, endposition);
            isendpointaboveorsamelevel = startposition[2] <= endposition[2];
            if (traversaldistance >= 108 && abs(endposition[2] - startposition[2]) <= 100) {
                return "jump_across_traversal";
            }
            if (isendpointaboveorsamelevel) {
                return "jump_up_traversal";
            }
            return "jump_down_traversal";
        }
        return "unknown_traversal";
    }
    entity = self;
    startposition = entity.traversalstartpos;
    endposition = entity.traversalendpos;
    if (!isdefined(entity.traversestartnode) || entity.traversestartnode.type != "Volume" || !isdefined(entity.traverseendnode) || entity.traverseendnode.type != "Volume") {
        return "unknown_traversal";
    }
    if (isdefined(entity.traversestartnode) && isdefined(entity.traversemantlenode)) {
        return "mantle_traversal";
    }
    if (isdefined(startposition) && isdefined(endposition)) {
        traversaldistance = distance2d(startposition, endposition);
        isendpointaboveorsamelevel = startposition[2] <= endposition[2];
        if (traversaldistance >= 108 && abs(endposition[2] - startposition[2]) <= 100) {
            return "jump_across_traversal";
        }
        if (isendpointaboveorsamelevel) {
            if (is_true(entity.traverseendnode.hanging_traversal) && is_true(entity.var_1731eda3)) {
                return "jump_up_hanging_traversal";
            } else {
                return "jump_up_traversal";
            }
        }
        return "jump_down_traversal";
    }
    return "unknown_traversal";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x1b51ec80, Offset: 0x5e30
// Size: 0xa
function bb_getawareness() {
    return self.awarenesslevelcurrent;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xf6085f73, Offset: 0x5e48
// Size: 0xa
function bb_getawarenessprevious() {
    return self.awarenesslevelprevious;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x4ff42f14, Offset: 0x5e60
// Size: 0xb2
function function_cc26899f() {
    if (isdefined(self.zombie_move_speed)) {
        if (self.zombie_move_speed == "walk") {
            return "locomotion_speed_walk";
        } else if (self.zombie_move_speed == "run") {
            return "locomotion_speed_run";
        } else if (self.zombie_move_speed == "sprint") {
            return "locomotion_speed_sprint";
        } else if (self.zombie_move_speed == "super_sprint") {
            return "locomotion_speed_super_sprint";
        } else if (self.zombie_move_speed == "super_super_sprint") {
            return "locomotion_speed_super_super_sprint";
        }
    }
    return "locomotion_speed_walk";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x5 linked
// Checksum 0x5dd7afd9, Offset: 0x5f20
// Size: 0xa6
function private bb_getgibbedlimbs() {
    entity = self;
    rightarmgibbed = gibserverutils::isgibbed(entity, 16);
    leftarmgibbed = gibserverutils::isgibbed(entity, 32);
    if (rightarmgibbed && leftarmgibbed) {
        return "both_arms";
    } else if (rightarmgibbed) {
        return "right_arm";
    } else if (leftarmgibbed) {
        return "left_arm";
    }
    return "none";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x5 linked
// Checksum 0xe28a7a45, Offset: 0x5fd0
// Size: 0x11a
function private bb_getyawtocovernode() {
    if (!isdefined(self.node)) {
        return 0;
    }
    disttonodesqr = distance2dsquared(self getnodeoffsetposition(self.node), self.origin);
    if (is_true(self.keepclaimednode)) {
        if (disttonodesqr > function_a3f6cdac(64)) {
            return 0;
        }
    } else if (disttonodesqr > function_a3f6cdac(24)) {
        return 0;
    }
    angletonode = ceil(angleclamp180(self.angles[1] - self getnodeoffsetangles(self.node)[1]));
    return angletonode;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0x8dd6e397, Offset: 0x60f8
// Size: 0x84
function bb_gethigheststance() {
    if (self isatcovernodestrict() && self shouldusecovernode()) {
        higheststance = self gethighestnodestance(self.node);
        return higheststance;
    }
    return self getblackboardattribute("_stance");
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x85e2c843, Offset: 0x6188
// Size: 0xba
function bb_getlocomotionfaceenemyquadrantprevious() {
    if (isdefined(self.prevrelativedir)) {
        direction = self.prevrelativedir;
        switch (direction) {
        case 0:
            return "locomotion_face_enemy_none";
        case 1:
            return "locomotion_face_enemy_front";
        case 2:
            return "locomotion_face_enemy_right";
        case 3:
            return "locomotion_face_enemy_left";
        case 4:
            return "locomotion_face_enemy_back";
        }
    }
    return "locomotion_face_enemy_none";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xdd9623b6, Offset: 0x6250
// Size: 0x1a
function bb_getcurrentcovernodetype() {
    return getcovertype(self.node);
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xa03d6c4, Offset: 0x6278
// Size: 0x2e
function bb_getcoverconcealed() {
    if (iscoverconcealed(self.node)) {
        return "concealed";
    }
    return "unconcealed";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x7b3d3e18, Offset: 0x62b0
// Size: 0x7a
function bb_getcurrentlocationcovernodetype() {
    if (isdefined(self.node) && distancesquared(self.origin, self.node.origin) < function_a3f6cdac(48)) {
        return bb_getcurrentcovernodetype();
    }
    return bb_getpreviouscovernodetype();
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xd73eba59, Offset: 0x6338
// Size: 0x2a
function bb_getshouldturn() {
    if (isdefined(self.should_turn) && self.should_turn) {
        return "should_turn";
    }
    return "should_not_turn";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x7f32a2a, Offset: 0x6370
// Size: 0x3a
function bb_getarmsposition() {
    if (isdefined(self.zombie_arms_position)) {
        if (self.zombie_arms_position == "up") {
            return "arms_up";
        }
        return "arms_down";
    }
    return "arms_up";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x72acedaa, Offset: 0x63b8
// Size: 0x1e
function bb_gethaslegsstatus() {
    if (self.missinglegs) {
        return "has_legs_no";
    }
    return "has_legs_yes";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x3ced9766, Offset: 0x63e0
// Size: 0x2e
function function_f61d3341() {
    if (gibserverutils::isgibbed(self, 256)) {
        return "has_left_leg_no";
    }
    return "has_left_leg_yes";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xecc98768, Offset: 0x6418
// Size: 0x2e
function function_9b395e55() {
    if (gibserverutils::isgibbed(self, 128)) {
        return "has_right_leg_no";
    }
    return "has_right_leg_yes";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x59916ae, Offset: 0x6450
// Size: 0x2e
function function_99e55609() {
    if (gibserverutils::isgibbed(self, 32)) {
        return "has_left_arm_no";
    }
    return "has_left_arm_yes";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x9b395587, Offset: 0x6488
// Size: 0x2e
function function_aa8f1e69() {
    if (gibserverutils::isgibbed(self, 16)) {
        return "has_right_arm_no";
    }
    return "has_right_arm_yes";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x81ad58cc, Offset: 0x64c0
// Size: 0x1e
function function_5b03a448() {
    if (isdefined(self.e_grapplee)) {
        return "has_grapplee_yes";
    }
    return "has_grapplee_no";
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x1 linked
// Checksum 0xde7995fb, Offset: 0x64e8
// Size: 0x162
function actorgetpredictedyawtoenemy(entity, lookaheadtime) {
    if (isdefined(entity.predictedyawtoenemy) && isdefined(entity.predictedyawtoenemytime) && entity.predictedyawtoenemytime == gettime()) {
        return entity.predictedyawtoenemy;
    }
    selfpredictedpos = entity.origin;
    moveangle = entity.angles[1] + entity getmotionangle();
    selfpredictedpos += (cos(moveangle), sin(moveangle), 0) * 200 * lookaheadtime;
    yaw = vectortoangles(entity lastknownpos(entity.enemy) - selfpredictedpos)[1] - entity.angles[1];
    yaw = absangleclamp360(yaw);
    entity.predictedyawtoenemy = yaw;
    entity.predictedyawtoenemytime = gettime();
    return yaw;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xeb952d35, Offset: 0x6658
// Size: 0x1e
function function_e28a3ee5() {
    if (isdefined(self.var_920617c1)) {
        return self.var_920617c1;
    }
    return "stealth_investigate_height_default";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xdebda5e7, Offset: 0x6680
// Size: 0x5e
function bb_actorispatroling() {
    entity = self;
    if (entity ai::has_behavior_attribute("patrol") && entity ai::get_behavior_attribute("patrol")) {
        return "patrol_enabled";
    }
    return "patrol_disabled";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xd4e43646, Offset: 0x66e8
// Size: 0x2e
function bb_actorhasenemy() {
    entity = self;
    if (isdefined(entity.enemy)) {
        return "has_enemy";
    }
    return "no_enemy";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xa0837dd8, Offset: 0x6720
// Size: 0x6c
function function_b3f35a07() {
    c_door = self.ai.doortoopen;
    if (!isdefined(c_door)) {
        return "door_will_open_no";
    }
    if (is_true(self.ai.door_opened)) {
        return "door_will_open_yes";
    }
    return "door_will_open_no";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x4873386b, Offset: 0x6798
// Size: 0x3c
function function_7970d18b() {
    if (is_true(self.ai.var_10150769)) {
        return "door_overlay_disabled";
    }
    return "door_overlay_enabled";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xbfdccadc, Offset: 0x67e0
// Size: 0x162
function function_19574f85() {
    c_door = self.ai.doortoopen;
    if (!isdefined(c_door)) {
        return 999999;
    }
    var_203b2da1 = c_door.var_85f2454d.doorbottomcenter;
    if (!isdefined(var_203b2da1)) {
        var_203b2da1 = c_door.origin;
    }
    var_f56439f = c_door.var_85f2454d.var_c4269c41;
    if (!isdefined(var_f56439f)) {
        var_f56439f = anglestoright(c_door.angles);
    }
    var_a003c4d6 = math::vec_to_angles(var_f56439f);
    var_93b76ac5 = var_203b2da1 - self.origin;
    var_3ea61d84 = math::vec_to_angles(var_93b76ac5);
    angle_diff = var_a003c4d6 - var_3ea61d84;
    angle_diff = angleclamp180(angle_diff);
    var_deeb5ea3 = undefined;
    if (angle_diff < 0) {
        var_deeb5ea3 = angle_diff + 90;
    } else {
        var_deeb5ea3 = angle_diff - 90;
    }
    return var_deeb5ea3;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xe090f391, Offset: 0x6950
// Size: 0x4a
function bb_actorgetenemyyaw() {
    enemy = self.enemy;
    if (!isdefined(enemy)) {
        return 0;
    }
    toenemyyaw = actorgetpredictedyawtoenemy(self, 0.2);
    return toenemyyaw;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xab55c7e, Offset: 0x69a8
// Size: 0xd8
function bb_actorgetperfectenemyyaw() {
    enemy = isdefined(self.var_2df45b5d) ? self.var_2df45b5d : self.enemy;
    if (!isdefined(enemy)) {
        return 0;
    }
    toenemyyaw = vectortoangles(enemy.origin - self.origin)[1] - self.angles[1];
    toenemyyaw = absangleclamp360(toenemyyaw);
    /#
        record3dtext("<dev string:xa1>" + toenemyyaw, self.origin, (1, 0, 0), "<dev string:xaf>", self);
    #/
    return toenemyyaw;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x3347c657, Offset: 0x6a88
// Size: 0xb4
function function_caea19a8() {
    result = self.angles[1];
    if (isdefined(self.stealth.patrol_react_pos) && isdefined(self.stealth) && isdefined(self.stealth.patrol_react_time) && gettime() - self.stealth.patrol_react_time < 2000) {
        deltaorigin = self.stealth.patrol_react_pos - self.origin;
        result = vectortoangles(deltaorigin)[1];
    }
    return result;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xe147a69b, Offset: 0x6b48
// Size: 0x42
function bb_actorgetreactyaw() {
    return absangleclamp360(self.angles[1] - self getblackboardattribute("_react_yaw_world"));
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x59463cb1, Offset: 0x6b98
// Size: 0xbc
function function_bee4de6() {
    result = self.angles[1];
    if (isdefined(self.var_5aaa7f76)) {
        deltaorigin = self.var_5aaa7f76 - self.origin;
        /#
            recordstar(self.var_5aaa7f76, (1, 0, 1), "<dev string:x83>", self);
            recordline(self.origin, self.var_5aaa7f76, (1, 0, 1), "<dev string:x83>", self);
        #/
        result = vectortoangles(deltaorigin)[1];
    }
    return result;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xf02f2660, Offset: 0x6c60
// Size: 0x90
function function_6568cc68() {
    angle = absangleclamp360(self.angles[1] - self getblackboardattribute("_zombie_react_yaw_world"));
    /#
        record3dtext("<dev string:xbd>" + angle, self.origin, (1, 0, 1), "<dev string:x83>", self);
    #/
    return angle;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x7e174f69, Offset: 0x6cf8
// Size: 0x7a
function function_abb9c007(*entity) {
    if (isdefined(self.stealth)) {
        if (is_true(self.stealth.var_7f670ead)) {
            return 0;
        }
        return is_true(self.stealth.var_527ef51c);
    }
    return self haspath();
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x708d8043, Offset: 0x6d80
// Size: 0xb2
function getangleusingdirection(direction) {
    directionyaw = vectortoangles(direction)[1];
    yawdiff = directionyaw - self.angles[1];
    yawdiff *= 0.00277778;
    flooredyawdiff = floor(yawdiff + 0.5);
    turnangle = (yawdiff - flooredyawdiff) * 360;
    return absangleclamp360(turnangle);
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xa243c30a, Offset: 0x6e40
// Size: 0x13c
function wasatcovernode() {
    if (isdefined(self.prevnode)) {
        if (self.prevnode.type == #"cover left" || self.prevnode.type == #"cover right" || self.prevnode.type == #"cover pillar" || self.prevnode.type == #"cover stand" || self.prevnode.type == #"conceal stand" || self.prevnode.type == #"cover crouch" || self.prevnode.type == #"cover crouch window" || self.prevnode.type == #"conceal crouch") {
            return true;
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x2c28b915, Offset: 0x6f88
// Size: 0x636
function bb_getlocomotionexityaw(*blackboard, *yaw) {
    if (self haspath()) {
        predictedlookaheadinfo = self predictexit();
        status = predictedlookaheadinfo[#"path_prediction_status"];
        if (!isdefined(self.pathgoalpos)) {
            return -1;
        }
        if (status == 3) {
            start = self.origin;
            end = start + vectorscale((0, predictedlookaheadinfo[#"path_prediction_travel_vector"][1], 0), 100);
            angletoexit = vectortoangles(predictedlookaheadinfo[#"path_prediction_travel_vector"])[1];
            exityaw = absangleclamp360(angletoexit - self.prevnode.angles[1]);
            /#
                record3dtext("<dev string:xcf>" + int(exityaw), self.origin - (0, 0, 5), (1, 0, 0), "<dev string:xaf>", undefined, 0.4);
            #/
            return exityaw;
        } else if (status == 4) {
            start = self.origin;
            end = start + vectorscale((0, predictedlookaheadinfo[#"path_prediction_travel_vector"][1], 0), 100);
            angletoexit = vectortoangles(predictedlookaheadinfo[#"path_prediction_travel_vector"])[1];
            exityaw = absangleclamp360(angletoexit - self.angles[1]);
            /#
                record3dtext("<dev string:xcf>" + int(exityaw), self.origin - (0, 0, 5), (1, 0, 0), "<dev string:xaf>", undefined, 0.4);
            #/
            return exityaw;
        } else if (status == 0) {
            if (wasatcovernode() && distancesquared(self.prevnode.origin, self.origin) < 25) {
                end = self.pathgoalpos;
                angletodestination = vectortoangles(end - self.origin)[1];
                exityaw = absangleclamp360(angletodestination - self.prevnode.angles[1]);
                /#
                    record3dtext("<dev string:xcf>" + int(exityaw), self.origin - (0, 0, 5), (1, 0, 0), "<dev string:xaf>", undefined, 0.4);
                #/
                return exityaw;
            }
            start = predictedlookaheadinfo[#"path_prediction_start_point"];
            end = start + predictedlookaheadinfo[#"path_prediction_travel_vector"];
            exityaw = getangleusingdirection(predictedlookaheadinfo[#"path_prediction_travel_vector"]);
            /#
                record3dtext("<dev string:xcf>" + int(exityaw), self.origin - (0, 0, 5), (1, 0, 0), "<dev string:xaf>", undefined, 0.4);
            #/
            return exityaw;
        } else if (status == 2) {
            if (wasatcovernode() && distancesquared(self.prevnode.origin, self.origin) < 25) {
                end = self.pathgoalpos;
                angletodestination = vectortoangles(end - self.origin)[1];
                exityaw = absangleclamp360(angletodestination - self.prevnode.angles[1]);
                /#
                    record3dtext("<dev string:xcf>" + int(exityaw), self.origin - (0, 0, 5), (1, 0, 0), "<dev string:xaf>", undefined, 0.4);
                #/
                return exityaw;
            }
            exityaw = getangleusingdirection(vectornormalize(self.pathgoalpos - self.origin));
            /#
                record3dtext("<dev string:xcf>" + int(exityaw), self.origin - (0, 0, 5), (1, 0, 0), "<dev string:xaf>", undefined, 0.4);
            #/
            return exityaw;
        }
    }
    return -1;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xc077f526, Offset: 0x75c8
// Size: 0x14a
function bb_getlocomotionfaceenemyquadrant() {
    /#
        walkstring = getdvarstring(#"tacticalwalkdirection");
        switch (walkstring) {
        case #"right":
            return "<dev string:xdd>";
        case #"left":
            return "<dev string:xfc>";
        case #"back":
            return "<dev string:x11a>";
        }
    #/
    if (isdefined(self.relativedir)) {
        direction = self.relativedir;
        switch (direction) {
        case 0:
            return "locomotion_face_enemy_front";
        case 1:
            return "locomotion_face_enemy_front";
        case 2:
            return "locomotion_face_enemy_right";
        case 3:
            return "locomotion_face_enemy_left";
        case 4:
            return "locomotion_face_enemy_back";
        }
    }
    return "locomotion_face_enemy_front";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xe4c52ae8, Offset: 0x7720
// Size: 0x26a
function bb_getlocomotionpaintype() {
    if (self haspath()) {
        predictedlookaheadinfo = self predictpath();
        status = predictedlookaheadinfo[#"path_prediction_status"];
        startpos = self.origin;
        furthestpointtowardsgoalclear = 1;
        if (status == 2) {
            furthestpointalongtowardsgoal = startpos + vectorscale(self.lookaheaddir, 300);
            furthestpointtowardsgoalclear = self findpath(startpos, furthestpointalongtowardsgoal, 0, 0) && self maymovetopoint(furthestpointalongtowardsgoal);
        }
        if (furthestpointtowardsgoalclear) {
            forwarddir = anglestoforward(self.angles);
            possiblepaintypes = [];
            endpos = startpos + vectorscale(forwarddir, 300);
            if (self maymovetopoint(endpos) && self findpath(startpos, endpos, 0, 0)) {
                possiblepaintypes[possiblepaintypes.size] = "locomotion_moving_pain_long";
            }
            endpos = startpos + vectorscale(forwarddir, 200);
            if (self maymovetopoint(endpos) && self findpath(startpos, endpos, 0, 0)) {
                possiblepaintypes[possiblepaintypes.size] = "locomotion_moving_pain_med";
            }
            endpos = startpos + vectorscale(forwarddir, 150);
            if (self maymovetopoint(endpos) && self findpath(startpos, endpos, 0, 0)) {
                possiblepaintypes[possiblepaintypes.size] = "locomotion_moving_pain_short";
            }
            if (possiblepaintypes.size) {
                return array::random(possiblepaintypes);
            }
        }
    }
    return "locomotion_inplace_pain";
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xbfab3a4e, Offset: 0x7998
// Size: 0x42
function bb_getlookaheadangle() {
    return absangleclamp360(vectortoangles(self.lookaheaddir)[1] - self.angles[1]);
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xbe29ca4, Offset: 0x79e8
// Size: 0x1a
function bb_getpreviouscovernodetype() {
    return getcovertype(self.prevnode);
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xce3310f4, Offset: 0x7a10
// Size: 0x3f6
function bb_actorgettrackingturnyaw() {
    var_71a0045b = undefined;
    if (isdefined(self.enemy)) {
        if (self cansee(self.enemy)) {
            var_71a0045b = self.enemy.origin;
        } else if (issentient(self.enemy)) {
            if (self.highlyawareradius && distance2dsquared(self.enemy.origin, self.origin) < function_a3f6cdac(self.highlyawareradius)) {
                var_71a0045b = self.enemy.origin;
            } else {
                var_18c9035f = self function_18c9035f(self.enemy);
                attackedrecently = self attackedrecently(self.enemy, self.var_dd892e0e / 1000);
                if (attackedrecently && isdefined(var_18c9035f)) {
                    if (self canshoot(var_18c9035f)) {
                        var_71a0045b = var_18c9035f;
                    }
                }
                lastknownpostime = undefined;
                if (!isdefined(var_71a0045b)) {
                    if (issentient(self.enemy)) {
                        lastknownpostime = self lastknowntime(self.enemy);
                        lastknownpos = self lastknownpos(self.enemy);
                    } else {
                        lastknownpostime = gettime();
                        lastknownpos = self.enemy.origin;
                    }
                    if (gettime() <= lastknownpostime + self.var_dd892e0e) {
                        if (sighttracepassed(self geteye(), lastknownpos, 0, self, self.enemy)) {
                            var_71a0045b = lastknownpos;
                        }
                    }
                }
                if (!isdefined(var_71a0045b)) {
                    if (self isatcovernode() && isdefined(self.var_79f94433) && lastknownpostime < self.var_79f94433) {
                        var_2ca7ef36 = self.node.type == #"exposed" && self.node.spawnflags & 128;
                        if (!var_2ca7ef36) {
                            nodeforward = anglestoforward(self.node.angles);
                            var_71a0045b = self.node.origin + nodeforward * 500;
                        }
                    }
                }
            }
        }
    } else if (isdefined(self.ai.var_3af1add3)) {
        var_71a0045b = [[ self.ai.var_3af1add3 ]](self);
    } else if (isdefined(self.likelyenemyposition)) {
        if (self canshoot(self.likelyenemyposition)) {
            var_71a0045b = self.likelyenemyposition;
        }
    }
    if (isdefined(var_71a0045b)) {
        turnyaw = absangleclamp360(self.angles[1] - vectortoangles(var_71a0045b - self.origin)[1]);
        return turnyaw;
    }
    return 0;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xa8533982, Offset: 0x7e10
// Size: 0x11a
function bb_getweaponclass() {
    weaponclass = isdefined(self.weaponclass) ? self.weaponclass : "rifle";
    switch (weaponclass) {
    case #"rifle":
        return "rifle";
    case #"rifle":
        return "rifle";
    case #"mg":
        return "mg";
    case #"smg":
        return "smg";
    case #"spread":
        return "spread";
    case #"pistol":
        return "pistol";
    case #"grenade":
        return "grenade";
    case #"rocketlauncher":
        return "rocketlauncher";
    default:
        return "rifle";
    }
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x2526f5a2, Offset: 0x7f38
// Size: 0x42
function function_6f949118() {
    angles = self gettagangles("tag_origin");
    return angleclamp180(angles[0]);
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x1b3b6611, Offset: 0x7f88
// Size: 0x4a
function function_38855dc8() {
    if (!isdefined(self.favoriteenemy)) {
        return 0;
    }
    velocity = self.favoriteenemy getvelocity();
    return length(velocity);
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x1a788650, Offset: 0x7fe0
// Size: 0x36
function function_ebaa4b7c() {
    if (!isdefined(self.enemy)) {
        return 0;
    }
    return self.enemy.origin[2] - self.origin[2];
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xa1e67ad0, Offset: 0x8020
// Size: 0x42
function function_6ecd367e() {
    if (!isdefined(self.traversestartnode) || !isdefined(self.traversestartnode.type)) {
        return "NONE";
    }
    return self.traversestartnode.type;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x5d12cee, Offset: 0x8070
// Size: 0x40
function notstandingcondition(entity) {
    if (entity getblackboardattribute("_stance") != "stand") {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x2f86424f, Offset: 0x80b8
// Size: 0x40
function notcrouchingcondition(entity) {
    if (entity getblackboardattribute("_stance") != "crouch") {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x634bf94f, Offset: 0x8100
// Size: 0x40
function function_736c20e1(entity) {
    if (entity getblackboardattribute("_stance") != "prone") {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xcf9858a6, Offset: 0x8148
// Size: 0x52
function function_4aff5b9d(entity) {
    var_899a4d57 = 0;
    if (notstandingcondition(entity)) {
        if (!entity isatcovernodestrict()) {
            var_899a4d57 = 1;
        }
    }
    return var_899a4d57;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x47dc1d1c, Offset: 0x81a8
// Size: 0x24
function scriptstartragdoll(entity) {
    entity startragdoll();
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xff40dd01, Offset: 0x81d8
// Size: 0xf4
function private prepareforexposedmelee(entity) {
    keepclaimnode(entity);
    meleeacquiremutex(entity);
    currentstance = entity getblackboardattribute("_stance");
    if (isdefined(entity.enemy) && entity.enemy.scriptvehicletype === "firefly") {
        entity setblackboardattribute("_melee_enemy_type", "fireflyswarm");
    }
    if (currentstance == "crouch") {
        entity setblackboardattribute("_desired_stance", "stand");
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xc243f062, Offset: 0x82d8
// Size: 0x3c
function isfrustrated(entity) {
    return isdefined(entity.ai.frustrationlevel) && entity.ai.frustrationlevel > 0;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x97649e63, Offset: 0x8320
// Size: 0x96
function function_22766ccd(entity) {
    if (isdefined(entity.ai.frustrationlevel) && entity.ai.frustrationlevel >= 2) {
        if (entity isatcovernode() && isdefined(entity.var_79f94433)) {
            var_7153a971 = gettime() - entity.var_79f94433;
            if (var_7153a971 >= 3000) {
                return true;
            }
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x8868a585, Offset: 0x83c0
// Size: 0x24
function flagenemyunattackableservice(entity) {
    entity flagenemyunattackable();
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xcf062b66, Offset: 0x83f0
// Size: 0x90
function islastknownenemypositionapproachable(entity) {
    if (isdefined(entity.enemy)) {
        lastknownpositionofenemy = entity lastknownpos(entity.enemy);
        if (entity isingoal(lastknownpositionofenemy) && entity findpath(entity.origin, lastknownpositionofenemy, 1, 0)) {
            return true;
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x11b5639f, Offset: 0x8488
// Size: 0x22
function function_d116f6b4(entity) {
    return is_true(entity.fixednode);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xe945b90c, Offset: 0x84b8
// Size: 0xdc
function tryadvancingonlastknownpositionbehavior(entity) {
    if (isdefined(entity.enemy)) {
        if (is_true(entity.aggressivemode)) {
            lastknownpositionofenemy = entity lastknownpos(entity.enemy);
            if (entity isingoal(lastknownpositionofenemy) && entity findpath(entity.origin, lastknownpositionofenemy, 1, 0)) {
                entity function_a57c34b7(lastknownpositionofenemy, lastknownpositionofenemy);
                setnextfindbestcovertime(entity);
                return true;
            }
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xc8f377b8, Offset: 0x85a0
// Size: 0x7e
function function_15b9bbef(entity) {
    if (function_d116f6b4(entity) || entity.goalforced) {
        return false;
    }
    if (shouldonlyfireaccurately(entity)) {
        return false;
    }
    if (!isdefined(entity.var_df6c21d4)) {
        return true;
    }
    if (gettime() > entity.var_df6c21d4) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xf122c2bf, Offset: 0x8628
// Size: 0x274
function trygoingtoclosestnodetoenemybehavior(entity) {
    var_be8baf32 = randomintrange(30000, 60000);
    if (entity.aggressivemode) {
        var_be8baf32 /= 2;
    }
    entity.var_df6c21d4 = gettime() + var_be8baf32;
    if (isdefined(entity.weapon) && isdefined(entity.weapon.weapclass) && entity.weapon.weapclass == "spread") {
        if (!is_true(entity.var_64a1455c) && isdefined(entity.team) && entity.team !== #"allies") {
            var_75f2bdf3 = tryrunningdirectlytoenemybehavior(entity);
            if (var_75f2bdf3) {
                return true;
            }
        }
    }
    if (isdefined(entity.enemy)) {
        lastknownpositionofenemy = entity lastknownpos(entity.enemy);
        closestrandomnode = undefined;
        nodes = entity findbestcovernodes();
        if (nodes.size > 0) {
            var_abe95912 = min(nodes.size, 15);
            bestnodes = array::slice(nodes, 0, var_abe95912 - 1);
            var_1a11849e = arraysortclosest(bestnodes, lastknownpositionofenemy, 1);
            closestrandomnode = var_1a11849e[0];
        }
        if (isdefined(closestrandomnode) && entity isingoal(closestrandomnode.origin)) {
            releaseclaimnode(entity);
            usecovernodewrapper(entity, closestrandomnode);
            return true;
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xe781c417, Offset: 0x88a8
// Size: 0x22c
function tryrunningdirectlytoenemybehavior(entity) {
    if (isdefined(entity.enemy) && is_true(entity.aggressivemode)) {
        origin = entity.enemy.origin;
        var_4bb69ed1 = 0;
        if (entity isingoal(origin)) {
            var_4bb69ed1 = 1;
        } else {
            goalinfo = self function_4794d6a3();
            if (isdefined(goalinfo.goalvolume)) {
                var_28fe9101 = goalinfo.goalvolume.maxs - goalinfo.goalvolume.mins;
                var_2e7904ce = (var_28fe9101[0] + var_28fe9101[1]) / 2;
                var_9fd6b922 = var_2e7904ce * 0.5;
                var_7ccdb9a2 = function_1ec73db4(origin, goalinfo.goalvolume);
                if (var_7ccdb9a2 < var_9fd6b922) {
                    var_4bb69ed1 = 1;
                }
            } else {
                var_d1530255 = goalinfo.goalradius * 0.5;
                var_30a12270 = distance(origin, goalinfo.goalpos) - goalinfo.goalradius;
                if (var_30a12270 < var_d1530255) {
                    var_4bb69ed1 = 1;
                }
            }
        }
        if (var_4bb69ed1 && entity findpath(entity.origin, origin, 1, 0)) {
            function_106ea3ab(entity, origin);
            thread function_97d5dde9(entity, entity.enemy);
            return true;
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x5 linked
// Checksum 0xcb161368, Offset: 0x8ae0
// Size: 0x82
function private function_106ea3ab(entity, origin) {
    entity function_a57c34b7(origin);
    releaseclaimnode(entity);
    setnextfindbestcovertime(entity);
    if (entity.nextfindbestcovertime - gettime() < 20000) {
        entity.nextfindbestcovertime = gettime() + 20000;
    }
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x5 linked
// Checksum 0x74ac8cd9, Offset: 0x8b70
// Size: 0x140
function private function_97d5dde9(entity, currentenemy) {
    entity endon(#"death", #"entitydeleted");
    self notify("7af6d8200a8bd2fb");
    self endon("7af6d8200a8bd2fb");
    while (true) {
        if (!isdefined(entity.enemy)) {
            entity function_d4c687c9();
            return;
        }
        if (entity.enemy != currentenemy) {
            function_106ea3ab(entity, entity.enemy.origin);
            currentenemy = entity.enemy;
        }
        if (gettime() > entity.nextfindbestcovertime) {
            entity function_d4c687c9();
            return;
        }
        if (entity cansee(entity.enemy)) {
            function_106ea3ab(entity, entity.enemy.origin);
        }
        wait 1;
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x73c0510e, Offset: 0x8cb8
// Size: 0x16
function shouldreacttonewenemy(entity) {
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xbd5b43d7, Offset: 0x8d58
// Size: 0x7e
function function_fa6d93ea(entity) {
    if (btapi_locomotionbehaviorcondition(entity) && !entity shouldholdgroundagainstenemy()) {
        return false;
    }
    if (btapi_isatcovercondition(entity)) {
        if (!archetype_human_cover::function_1fa73a96(entity)) {
            return false;
        }
    }
    return true;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xf1d6727f, Offset: 0x8de0
// Size: 0x22
function hasweaponmalfunctioned(entity) {
    return is_true(entity.malfunctionreaction);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x68aa28d8, Offset: 0x8e10
// Size: 0x48
function function_2de6da8(entity) {
    if (btapi_hasammo(entity) || function_5ac894ba(entity)) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xe468eff3, Offset: 0x8e60
// Size: 0x4a
function function_a9bc841(entity) {
    if (btapi_haslowammo(entity) && !function_5ac894ba(entity)) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x52e4673b, Offset: 0x8eb8
// Size: 0x44
function function_e0454a8b(entity) {
    if (btapi_hasenemy(entity)) {
        return true;
    }
    if (isdefined(entity.var_38754eac)) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xf71e10e4, Offset: 0x8f08
// Size: 0x22
function issafefromgrenades(entity) {
    return entity issafefromgrenade();
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xd21168b1, Offset: 0x8f38
// Size: 0x50
function recentlysawenemy(entity) {
    if (isdefined(entity.enemy) && entity seerecently(entity.enemy, 6)) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x9c6ae184, Offset: 0x8f90
// Size: 0x2e
function shouldonlyfireaccurately(entity) {
    if (is_true(entity.accuratefire)) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x655258cf, Offset: 0x8fc8
// Size: 0x2e
function canblindfire(entity) {
    if (is_true(entity.var_57314c74)) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xe00409c, Offset: 0x9000
// Size: 0x2e
function shouldbeaggressive(entity) {
    if (is_true(entity.aggressivemode)) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x574df007, Offset: 0x9038
// Size: 0xee
function usecovernodewrapper(entity, node) {
    samenode = entity.node === node;
    entity usecovernode(node);
    if (!samenode) {
        entity setblackboardattribute("_cover_mode", "cover_mode_none");
        entity setblackboardattribute("_previous_cover_mode", "cover_mode_none");
    }
    if (samenode) {
        setnextfindbestcovertime(entity);
    } else {
        entity.var_11b1735a = 1;
    }
    entity.ai.var_47823ae7 = gettime() + 1000;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xab5a0eb8, Offset: 0x9130
// Size: 0x2a
function setnextfindbestcovertime(entity) {
    entity.nextfindbestcovertime = entity getnextfindbestcovertime();
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x1fcc0b83, Offset: 0x9168
// Size: 0x4c
function choosebestcovernodeasap(entity) {
    node = getbestcovernodeifavailable(entity);
    if (isdefined(node)) {
        usecovernodewrapper(entity, node);
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x96989764, Offset: 0x91c0
// Size: 0x11a
function function_9773a8aa(entity) {
    var_edbb5c0d = 0;
    if (isdefined(entity.ai.var_bb3caa0f)) {
        goalinfo = self function_4794d6a3();
        if (isdefined(goalinfo.overridegoalpos)) {
            if (distancesquared(entity.ai.var_21eb2c42, goalinfo.overridegoalpos) < 1) {
                var_edbb5c0d = 1;
            }
        }
    }
    if (var_edbb5c0d) {
        if (!goalinfo.var_9e404264) {
            return true;
        }
        var_b7761338 = entity.ai.var_bb3caa0f + 5000 <= gettime();
        var_74ecd4b4 = !var_b7761338;
        var_2b3852c3 = entity.nextfindbestcovertime <= gettime();
        if (var_74ecd4b4 || !var_2b3852c3) {
            return true;
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xe8ba4aa3, Offset: 0x92e8
// Size: 0x29e
function choosebettercoverservicecodeversion(entity) {
    if (!isalive(entity)) {
        return false;
    }
    if (isdefined(entity.stealth) && entity ai::get_behavior_attribute("stealth")) {
        return false;
    }
    if (is_true(entity.fixednode)) {
        var_d4302a98 = 0;
        if (isdefined(entity getgoalvolume())) {
            if (!isdefined(entity.node) || !entity isapproachinggoal()) {
                var_d4302a98 = 1;
            }
        }
        if (!var_d4302a98) {
            return false;
        }
    }
    if (is_true(entity.avoid_cover)) {
        return false;
    }
    if (!issafefromgrenades(entity)) {
        entity.nextfindbestcovertime = 0;
    } else {
        if (entity isatcovernode() && issuppressedatcovercondition(entity)) {
            return false;
        }
        if (function_22766ccd(entity) && function_15b9bbef(entity)) {
            return false;
        }
    }
    if (function_9773a8aa(entity)) {
        return false;
    }
    if (is_true(entity.keepclaimednode)) {
        return false;
    }
    var_eef1785f = !is_true(entity.var_11b1735a);
    newnode = entity choosebettercovernode(1, !var_eef1785f);
    if (isdefined(newnode)) {
        usecovernodewrapper(entity, newnode);
        return true;
    }
    var_c8d2b0aa = is_true(entity.var_11b1735a);
    if (gettime() > entity.nextfindbestcovertime && !var_c8d2b0aa) {
        setnextfindbestcovertime(entity);
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x7557a634, Offset: 0x9590
// Size: 0x198
function private sensenearbyplayers(entity) {
    if (isdefined(entity.stealth) && entity ai::get_behavior_attribute("stealth")) {
        return 0;
    }
    players = getplayers();
    foreach (player in players) {
        distancesq = distancesquared(player.origin, entity.origin);
        if (distancesq <= function_a3f6cdac(360)) {
            distancetoplayer = sqrt(distancesq);
            randchance = 1 - distancetoplayer / 360;
            var_56e2d5dc = randomfloat(1);
            if (var_56e2d5dc < randchance) {
                entity getperfectinfo(player);
            }
        }
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x9a59c0ee, Offset: 0x9730
// Size: 0xa2
function getbestcovernodeifavailable(entity) {
    node = entity findbestcovernode();
    if (!isdefined(node)) {
        return undefined;
    }
    if (entity nearclaimnode()) {
        currentnode = self.node;
    }
    if (isdefined(currentnode) && node == currentnode) {
        return undefined;
    }
    if (isdefined(entity.covernode) && node == entity.covernode) {
        return undefined;
    }
    return node;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x7eda8bcc, Offset: 0x97e0
// Size: 0xca
function getsecondbestcovernodeifavailable(entity) {
    nodes = entity findbestcovernodes();
    if (nodes.size > 1) {
        node = nodes[1];
    }
    if (!isdefined(node)) {
        return undefined;
    }
    if (entity nearclaimnode()) {
        currentnode = self.node;
    }
    if (isdefined(currentnode) && node == currentnode) {
        return undefined;
    }
    if (isdefined(entity.covernode) && node == entity.covernode) {
        return undefined;
    }
    return node;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x97d39a31, Offset: 0x98b8
// Size: 0x1c6
function getcovertype(node) {
    if (isdefined(node)) {
        if (node.type == #"cover pillar") {
            return "cover_pillar";
        } else if (node.type == #"cover left") {
            return "cover_left";
        } else if (node.type == #"cover right") {
            return "cover_right";
        } else if (node.type == #"cover stand" || node.type == #"conceal stand") {
            return "cover_stand";
        } else if (node.type == #"cover crouch" || node.type == #"cover crouch window" || node.type == #"conceal crouch") {
            return "cover_crouch";
        } else if (node.type == #"exposed" || node.type == #"guard") {
            return "cover_exposed";
        } else if (node.type == #"turret") {
            return "cover_turret";
        }
    }
    return "cover_none";
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x7643754f, Offset: 0x9a88
// Size: 0x52
function iscoverconcealed(node) {
    if (isdefined(node)) {
        return (node.type == #"conceal crouch" || node.type == #"conceal stand");
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 0, eflags: 0x0
// Checksum 0xadc7e8fe, Offset: 0x9ae8
// Size: 0x494
function canseeenemywrapper() {
    if (!isdefined(self.enemy)) {
        return 0;
    }
    if (!isdefined(self.node)) {
        return self cansee(self.enemy);
    }
    node = self.node;
    enemyeye = self.enemy geteye();
    yawtoenemy = angleclamp180(node.angles[1] - vectortoangles(enemyeye - node.origin)[1]);
    if (node.type == #"cover left" || node.type == #"cover right") {
        if (yawtoenemy > 60 || yawtoenemy < -60) {
            return 0;
        }
        if (self function_c97b59f8("stand", node)) {
            if (node.type == #"cover left" && yawtoenemy > 10) {
                return 0;
            }
            if (node.type == #"cover right" && yawtoenemy < -10) {
                return 0;
            }
        }
    }
    nodeoffset = (0, 0, 0);
    if (node.type == #"cover pillar") {
        assert(!(isdefined(node.spawnflags) && (node.spawnflags & 2048) == 2048) || !(isdefined(node.spawnflags) && (node.spawnflags & 1024) == 1024));
        canseefromleft = 1;
        canseefromright = 1;
        nodeoffset = (-32, 3.7, 60);
        lookfrompoint = calculatenodeoffsetposition(node, nodeoffset);
        canseefromleft = sighttracepassed(lookfrompoint, enemyeye, 0, undefined);
        nodeoffset = (32, 3.7, 60);
        lookfrompoint = calculatenodeoffsetposition(node, nodeoffset);
        canseefromright = sighttracepassed(lookfrompoint, enemyeye, 0, undefined);
        return (canseefromright || canseefromleft);
    }
    if (node.type == #"cover left") {
        nodeoffset = (-36, 7, 63);
    } else if (node.type == #"cover right") {
        nodeoffset = (36, 7, 63);
    } else if (node.type == #"cover stand" || node.type == #"conceal stand") {
        nodeoffset = (-3.7, -22, 63);
    } else if (node.type == #"cover crouch" || node.type == #"cover crouch window" || node.type == #"conceal crouch") {
        nodeoffset = (3.5, -12.5, 45);
    }
    lookfrompoint = calculatenodeoffsetposition(node, nodeoffset);
    if (sighttracepassed(lookfrompoint, enemyeye, 0, undefined)) {
        return 1;
    }
    return 0;
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x1 linked
// Checksum 0xff25c20f, Offset: 0x9f88
// Size: 0x94
function calculatenodeoffsetposition(node, nodeoffset) {
    right = anglestoright(node.angles);
    forward = anglestoforward(node.angles);
    return node.origin + vectorscale(right, nodeoffset[0]) + vectorscale(forward, nodeoffset[1]) + (0, 0, nodeoffset[2]);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x537740f4, Offset: 0xa028
// Size: 0x49a
function gethighestnodestance(node) {
    assert(isdefined(node));
    assert(isdefined(self));
    if (self function_c97b59f8("stand", node)) {
        return "stand";
    }
    if (self function_c97b59f8("crouch", node)) {
        return "crouch";
    }
    if (self function_c97b59f8("prone", node)) {
        return "prone";
    }
    /#
        var_f078bbdd = [];
        if (doesnodeallowstance(node, "<dev string:x138>")) {
            var_f078bbdd[var_f078bbdd.size] = "<dev string:x138>";
        }
        if (doesnodeallowstance(node, "<dev string:x141>")) {
            var_f078bbdd[var_f078bbdd.size] = "<dev string:x141>";
        }
        if (doesnodeallowstance(node, "<dev string:x14b>")) {
            var_f078bbdd[var_f078bbdd.size] = "<dev string:x14b>";
        }
        var_58cb7691 = [];
        if (self function_f0e4aede("<dev string:x138>", node)) {
            var_58cb7691[var_58cb7691.size] = "<dev string:x138>";
        }
        if (self function_f0e4aede("<dev string:x141>", node)) {
            var_58cb7691[var_58cb7691.size] = "<dev string:x141>";
        }
        if (self function_f0e4aede("<dev string:x14b>", node)) {
            var_58cb7691[var_58cb7691.size] = "<dev string:x14b>";
        }
        msg1 = "<dev string:x154>" + self.aitype + "<dev string:x15f>" + node.type + "<dev string:x177>" + node.origin + "<dev string:x184>";
        msg2 = "<dev string:x1a0>";
        if (var_f078bbdd.size == 0) {
            msg2 += "<dev string:x1bc>";
        } else {
            foreach (stance in var_f078bbdd) {
                msg2 += "<dev string:x1c7>" + stance + "<dev string:x1cd>";
            }
        }
        msg2 += "<dev string:x1d2>";
        var_251bd303 = "<dev string:x1d8>";
        if (var_58cb7691.size == 0) {
            var_251bd303 += "<dev string:x1bc>";
        } else {
            foreach (stance in var_58cb7691) {
                var_251bd303 += "<dev string:x1c7>" + stance + "<dev string:x1cd>";
            }
        }
        var_251bd303 += "<dev string:x1d2>";
        errormsg("<dev string:x1f5>" + msg1 + "<dev string:x1f5>" + msg2 + "<dev string:x1f5>" + var_251bd303);
    #/
    if (node.type == #"cover crouch" || node.type == #"cover crouch window" || node.type == #"conceal crouch") {
        return "crouch";
    }
    return "stand";
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x88a5d3a3, Offset: 0xa4d0
// Size: 0x94
function function_c97b59f8(stance, node) {
    assert(isdefined(stance));
    assert(isdefined(node));
    assert(isdefined(self));
    return doesnodeallowstance(node, stance) && self function_f0e4aede(stance, node);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x9debdfc4, Offset: 0xa570
// Size: 0x6e
function trystoppingservice(entity) {
    if (entity shouldholdgroundagainstenemy()) {
        entity clearpath();
        keepclaimnode(entity);
        return true;
    }
    releaseclaimnode(entity);
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x89472195, Offset: 0xa5e8
// Size: 0x2e
function shouldstopmoving(entity) {
    if (entity shouldholdgroundagainstenemy()) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xc272e5cd, Offset: 0xa620
// Size: 0x8e
function setcurrentweapon(weapon) {
    self.weapon = weapon;
    self.weaponclass = weapon.weapclass;
    if (weapon != level.weaponnone) {
        assert(isdefined(weapon.worldmodel), "<dev string:x1fa>" + weapon.name + "<dev string:x205>");
    }
    self.weaponmodel = weapon.worldmodel;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xf9942bd2, Offset: 0xa6b8
// Size: 0x7c
function setprimaryweapon(weapon) {
    self.primaryweapon = weapon;
    self.primaryweaponclass = weapon.weapclass;
    if (weapon != level.weaponnone) {
        assert(isdefined(weapon.worldmodel), "<dev string:x1fa>" + weapon.name + "<dev string:x205>");
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x5c739b3d, Offset: 0xa740
// Size: 0x7c
function setsecondaryweapon(weapon) {
    self.secondaryweapon = weapon;
    self.secondaryweaponclass = weapon.weapclass;
    if (weapon != level.weaponnone) {
        assert(isdefined(weapon.worldmodel), "<dev string:x1fa>" + weapon.name + "<dev string:x205>");
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x69aaa8d5, Offset: 0xa7c8
// Size: 0x1e
function keepclaimnode(entity) {
    entity.keepclaimednode = 1;
    return true;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x7eb54d52, Offset: 0xa7f0
// Size: 0x1a
function releaseclaimnode(entity) {
    entity.keepclaimednode = 0;
    return true;
}

// Namespace aiutility/archetype_utility
// Params 3, eflags: 0x1 linked
// Checksum 0xfd2d2c0d, Offset: 0xa818
// Size: 0x7a
function getaimyawtoenemyfromnode(entity, node, *enemy) {
    return angleclamp180(vectortoangles(node lastknownpos(node.enemy) - enemy.origin)[1] - enemy.angles[1]);
}

// Namespace aiutility/archetype_utility
// Params 3, eflags: 0x1 linked
// Checksum 0xc4dd39eb, Offset: 0xa8a0
// Size: 0x7a
function getaimpitchtoenemyfromnode(entity, node, *enemy) {
    return angleclamp180(vectortoangles(node lastknownpos(node.enemy) - enemy.origin)[0] - enemy.angles[0]);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x2018deac, Offset: 0xa928
// Size: 0x7c
function choosefrontcoverdirection(entity) {
    coverdirection = entity getblackboardattribute("_cover_direction");
    entity setblackboardattribute("_previous_cover_direction", coverdirection);
    entity setblackboardattribute("_cover_direction", "cover_front_direction");
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x85a7f3ed, Offset: 0xa9b0
// Size: 0x70
function locomotionshouldpatrol(entity) {
    if (entity haspath() && entity ai::has_behavior_attribute("patrol") && entity ai::get_behavior_attribute("patrol")) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x773551e2, Offset: 0xaa28
// Size: 0x74
function private _dropriotshield(riotshieldinfo) {
    entity = self;
    entity shared::throwweapon(riotshieldinfo.weapon, riotshieldinfo.tag, 1, 0);
    if (isdefined(entity)) {
        entity detach(riotshieldinfo.model, riotshieldinfo.tag);
    }
}

// Namespace aiutility/archetype_utility
// Params 4, eflags: 0x0
// Checksum 0x40c44724, Offset: 0xaaa8
// Size: 0x92
function attachriotshield(entity, riotshieldweapon, riotshieldmodel, riotshieldtag) {
    riotshield = spawnstruct();
    riotshield.weapon = riotshieldweapon;
    riotshield.tag = riotshieldtag;
    riotshield.model = riotshieldmodel;
    entity attach(riotshieldmodel, riotshield.tag);
    entity.riotshield = riotshield;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xa61cb24, Offset: 0xab48
// Size: 0x54
function dropriotshield(entity) {
    if (isdefined(entity.riotshield)) {
        riotshieldinfo = entity.riotshield;
        entity.riotshield = undefined;
        entity thread _dropriotshield(riotshieldinfo);
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xdbb21a58, Offset: 0xaba8
// Size: 0x90
function meleeacquiremutex(entity) {
    if (isdefined(entity) && isdefined(entity.enemy)) {
        entity.meleeenemy = entity.enemy;
        if (isplayer(entity.meleeenemy)) {
            if (!isdefined(entity.meleeenemy.meleeattackers)) {
                entity.meleeenemy.meleeattackers = 0;
            }
            entity.meleeenemy.meleeattackers++;
        }
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x3e5e9d47, Offset: 0xac40
// Size: 0xaa
function meleereleasemutex(entity) {
    if (isdefined(entity.meleeenemy)) {
        if (isplayer(entity.meleeenemy)) {
            if (isdefined(entity.meleeenemy.meleeattackers)) {
                entity.meleeenemy.meleeattackers -= 1;
                if (entity.meleeenemy.meleeattackers <= 0) {
                    entity.meleeenemy.meleeattackers = undefined;
                }
            }
        }
    }
    entity.meleeenemy = undefined;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x6d9d00e, Offset: 0xacf8
// Size: 0x22
function shouldmutexmelee(entity) {
    return function_3d91d94b(entity);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xc46f30bb, Offset: 0xad28
// Size: 0x22
function shouldnormalmelee(entity) {
    return hascloseenemytomelee(entity);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x171b4ad2, Offset: 0xad58
// Size: 0x22
function shouldmelee(entity) {
    return btapi_shouldmelee(entity);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x80adf305, Offset: 0xad88
// Size: 0x22
function hascloseenemytomelee(entity) {
    return btapi_shouldnormalmelee(entity);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x190449c9, Offset: 0xadb8
// Size: 0x22
function shouldchargemelee(entity) {
    return btapi_shouldchargemelee(entity);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x858ef5a7, Offset: 0xade8
// Size: 0x94
function private setupchargemeleeattack(entity) {
    if (isdefined(entity.enemy) && entity.enemy.scriptvehicletype === "firefly") {
        entity setblackboardattribute("_melee_enemy_type", "fireflyswarm");
    }
    meleeacquiremutex(entity);
    keepclaimnode(entity);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xeceed8d1, Offset: 0xae88
// Size: 0xe4
function private cleanupmelee(entity) {
    meleereleasemutex(entity);
    releaseclaimnode(entity);
    entity setblackboardattribute("_melee_enemy_type", undefined);
    if (isdefined(entity.ai.var_aba9dcfd) && isdefined(entity.ai.var_38ee3a42)) {
        entity pathmode("move delayed", 1, randomfloatrange(entity.ai.var_aba9dcfd, entity.ai.var_38ee3a42));
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xddeba218, Offset: 0xaf78
// Size: 0xb4
function private cleanupchargemelee(entity) {
    entity.ai.nextchargemeleetime = gettime() + 2000;
    entity setblackboardattribute("_melee_enemy_type", undefined);
    meleereleasemutex(entity);
    releaseclaimnode(entity);
    entity pathmode("move delayed", 1, randomfloatrange(0.75, 1.5));
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x2b03e7c, Offset: 0xb038
// Size: 0x124
function cleanupchargemeleeattack(entity) {
    meleereleasemutex(entity);
    releaseclaimnode(entity);
    entity setblackboardattribute("_melee_enemy_type", undefined);
    if (isdefined(entity.ai.var_aba9dcfd) && isdefined(entity.ai.var_38ee3a42)) {
        entity pathmode("move delayed", 1, randomfloatrange(entity.ai.var_aba9dcfd, entity.ai.var_38ee3a42));
        return;
    }
    entity pathmode("move delayed", 1, randomfloatrange(0.5, 1));
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x1665fb5, Offset: 0xb168
// Size: 0x56
function private shouldchoosespecialpronepain(entity) {
    stance = entity getblackboardattribute("_stance");
    return stance == "prone_back" || stance == "prone_front";
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x921b8327, Offset: 0xb1c8
// Size: 0x20
function private function_9b0e7a22(entity) {
    return entity.var_40543c03 === "concussion";
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x2222221c, Offset: 0xb1f0
// Size: 0x18
function private shouldchoosespecialpain(entity) {
    return isdefined(entity.var_40543c03);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xefc2fb81, Offset: 0xb210
// Size: 0x16
function private function_89cb7bfd(entity) {
    return entity.var_ab2486b4;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x1fca0be, Offset: 0xb230
// Size: 0x32
function private shouldchoosespecialdeath(entity) {
    if (isdefined(entity.damageweapon)) {
        return entity.damageweapon.specialpain;
    }
    return 0;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xa0875d76, Offset: 0xb270
// Size: 0x56
function private shouldchoosespecialpronedeath(entity) {
    stance = entity getblackboardattribute("_stance");
    return stance == "prone_back" || stance == "prone_front";
}

// Namespace aiutility/archetype_utility
// Params 2, eflags: 0x5 linked
// Checksum 0x91369e2a, Offset: 0xb2d0
// Size: 0x40
function private setupexplosionanimscale(*entity, *asmstatename) {
    self.animtranslationscale = 2;
    self asmsetanimationrate(0.7);
    return 4;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xb35d6812, Offset: 0xb318
// Size: 0x1ae
function isbalconydeath(entity) {
    if (!isdefined(entity.node)) {
        return false;
    }
    if (!(entity.node.spawnflags & 1024 || entity.node.spawnflags & 2048)) {
        return false;
    }
    if (isdefined(entity.node.script_balconydeathchance) && randomint(100) > int(100 * entity.node.script_balconydeathchance)) {
        return false;
    }
    distsq = distancesquared(entity.origin, entity.node.origin);
    if (distsq > function_a3f6cdac(64)) {
        return false;
    }
    anglediff = math::angle_dif(int(entity.node.angles[1]), int(entity.angles[1]));
    if (abs(anglediff) > 15) {
        return false;
    }
    self.b_balcony_death = 1;
    return true;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x56f88906, Offset: 0xb4d0
// Size: 0x9c
function balconydeath(entity) {
    entity.clamptonavmesh = 0;
    if (entity.node.spawnflags & 1024) {
        entity setblackboardattribute("_special_death", "balcony");
        return;
    }
    if (entity.node.spawnflags & 2048) {
        entity setblackboardattribute("_special_death", "balcony_norail");
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x8c0307a6, Offset: 0xb578
// Size: 0x2c
function usecurrentposition(entity) {
    entity function_a57c34b7(entity.origin);
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xb298b08, Offset: 0xb5b0
// Size: 0x2c
function isunarmed(entity) {
    if (entity.weapon == level.weaponnone) {
        return true;
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0xe9da1c75, Offset: 0xb5e8
// Size: 0x2b8
function preshootlaserandglinton(ai) {
    ai endon(#"death");
    if (!isdefined(ai.laserstatus)) {
        ai.laserstatus = 0;
    }
    sniper_glint = #"hash_422e679c079f94e9";
    var_910f361 = ai.weapon;
    while (true) {
        ai waittill(#"about_to_fire");
        if (ai.weapon != var_910f361) {
            continue;
        }
        if (ai.laserstatus !== 1) {
            ai.laserstatus = 1;
            var_e2e89b43 = ai gettagorigin("tag_scope");
            if (isdefined(var_e2e89b43)) {
                var_8d597aeb = ai gettagangles("tag_scope");
                var_c3a43cf5 = anglestoforward(var_8d597aeb);
                var_e3cd0253 = anglestoup(var_8d597aeb);
                var_fd041107 = var_e2e89b43 + var_c3a43cf5 * 7 + var_e3cd0253 * 1.25;
                fxent = util::spawn_model("tag_origin", var_fd041107);
                fxent linkto(ai, "tag_scope");
                playfxontag(sniper_glint, fxent, "tag_origin");
                wait 0.75;
                fxent delete();
                continue;
            }
            tag_name = undefined;
            if (!isdefined(tag_name)) {
                if (isdefined(ai gettagorigin("tag_flash"))) {
                    tag_name = "tag_flash";
                }
            }
            if (!isdefined(tag_name)) {
                if (isdefined(ai gettagorigin("tag_eye"))) {
                    tag_name = "tag_eye";
                }
            }
            assert(isdefined(tag_name));
            playfxontag(sniper_glint, ai, tag_name);
        }
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x0
// Checksum 0x75f7167b, Offset: 0xb8a8
// Size: 0x66
function postshootlaserandglintoff(ai) {
    ai endon(#"death");
    while (true) {
        ai waittill(#"stopped_firing");
        if (ai.laserstatus === 1) {
            ai.laserstatus = 0;
        }
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x3863c3c, Offset: 0xb918
// Size: 0x2a
function private isinphalanx(entity) {
    return entity ai::get_behavior_attribute("phalanx");
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x9cf40eec, Offset: 0xb950
// Size: 0xb6
function private isinphalanxstance(entity) {
    phalanxstance = entity ai::get_behavior_attribute("phalanx_force_stance");
    currentstance = entity getblackboardattribute("_stance");
    switch (phalanxstance) {
    case #"stand":
        return (currentstance == "stand");
    case #"crouch":
        return (currentstance == "crouch");
    }
    return true;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xc0598762, Offset: 0xba10
// Size: 0xba
function private togglephalanxstance(entity) {
    phalanxstance = entity ai::get_behavior_attribute("phalanx_force_stance");
    switch (phalanxstance) {
    case #"stand":
        entity setblackboardattribute("_desired_stance", "stand");
        break;
    case #"crouch":
        entity setblackboardattribute("_desired_stance", "crouch");
        break;
    }
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xa978aa4e, Offset: 0xbad8
// Size: 0xb2
function isatattackobject(entity) {
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        return false;
    }
    if (isdefined(entity.attackable) && is_true(entity.attackable.is_active)) {
        if (!isdefined(entity.attackable_slot)) {
            return false;
        }
        if (entity isatgoal()) {
            entity.is_at_attackable = 1;
            return true;
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xc76a4121, Offset: 0xbb98
// Size: 0x96
function shouldattackobject(entity) {
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        return false;
    }
    if (isdefined(entity.attackable) && is_true(entity.attackable.is_active)) {
        if (is_true(entity.is_at_attackable)) {
            return true;
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 4, eflags: 0x0
// Checksum 0x81a78d7a, Offset: 0xbc38
// Size: 0xaa
function meleeattributescallback(entity, attribute, *oldvalue, value) {
    switch (oldvalue) {
    case #"can_melee":
        if (value) {
            attribute.canmelee = 1;
        } else {
            attribute.canmelee = 0;
        }
        break;
    case #"can_be_meleed":
        if (value) {
            attribute.canbemeleed = 1;
        } else {
            attribute.canbemeleed = 0;
        }
        break;
    }
}

// Namespace aiutility/archetype_utility
// Params 4, eflags: 0x0
// Checksum 0x1fe5eec5, Offset: 0xbcf0
// Size: 0x82
function arrivalattributescallback(entity, attribute, *oldvalue, value) {
    switch (oldvalue) {
    case #"disablearrivals":
        if (value) {
            attribute.ai.disablearrivals = 1;
        } else {
            attribute.ai.disablearrivals = 0;
        }
        break;
    }
}

// Namespace aiutility/archetype_utility
// Params 4, eflags: 0x0
// Checksum 0xa4176f69, Offset: 0xbd80
// Size: 0x82
function function_eef4346c(entity, attribute, *oldvalue, value) {
    switch (oldvalue) {
    case #"disablepeek":
        if (value) {
            attribute.ai.disablepeek = 1;
        } else {
            attribute.ai.disablepeek = 0;
        }
        break;
    }
}

// Namespace aiutility/archetype_utility
// Params 4, eflags: 0x0
// Checksum 0xe8645df0, Offset: 0xbe10
// Size: 0x82
function function_1cd75f29(entity, attribute, *oldvalue, value) {
    switch (oldvalue) {
    case #"disablelean":
        if (value) {
            attribute.ai.disablelean = 1;
        } else {
            attribute.ai.disablelean = 0;
        }
        break;
    }
}

// Namespace aiutility/archetype_utility
// Params 4, eflags: 0x0
// Checksum 0x2cb4b3a, Offset: 0xbea0
// Size: 0x5a
function phalanxattributecallback(entity, *attribute, *oldvalue, value) {
    if (value) {
        oldvalue.ai.phalanx = 1;
        return;
    }
    oldvalue.ai.phalanx = 0;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x579d29d5, Offset: 0xbf08
// Size: 0x2c6
function private generictryreacquireservice(entity) {
    if (!isdefined(entity.reacquire_state)) {
        entity.reacquire_state = 0;
    }
    if (!isdefined(entity.enemy)) {
        entity.reacquire_state = 0;
        return false;
    }
    if (entity haspath()) {
        entity.reacquire_state = 0;
        return false;
    }
    if (is_true(entity.fixednode)) {
        entity.reacquire_state = 0;
        return false;
    }
    if (entity seerecently(entity.enemy, 4)) {
        entity.reacquire_state = 0;
        return false;
    }
    dirtoenemy = vectornormalize(entity.enemy.origin - entity.origin);
    forward = anglestoforward(entity.angles);
    if (vectordot(dirtoenemy, forward) < 0.5) {
        entity.reacquire_state = 0;
        return false;
    }
    switch (entity.reacquire_state) {
    case 0:
    case 1:
    case 2:
        step_size = 32 + entity.reacquire_state * 32;
        reacquirepos = entity reacquirestep(step_size);
        break;
    case 4:
        if (!entity cansee(entity.enemy) || !entity canshootenemy()) {
            entity flagenemyunattackable();
        }
        break;
    default:
        if (entity.reacquire_state > 15) {
            entity.reacquire_state = 0;
            return false;
        }
        break;
    }
    if (isvec(reacquirepos)) {
        entity function_a57c34b7(reacquirepos);
        return true;
    }
    entity.reacquire_state++;
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x5 linked
// Checksum 0x1289466e, Offset: 0xc1d8
// Size: 0x266
function private function_bcbf3f38(*entity) {
    if (!isdefined(self.enemy)) {
        return false;
    }
    animation = self asmgetcurrentdeltaanimation();
    currenttime = self getanimtime(animation);
    notes = getnotetracktimes(animation, "melee_fire");
    if (!isdefined(notes)) {
        return false;
    }
    meleetime = notes[0];
    if (meleetime > currenttime && meleetime - currenttime < 0.05) {
        weapon = self.weapon;
        if (isdefined(self.meleeweapon) && self.meleeweapon != getweapon(#"none")) {
            weapon = self.meleeweapon;
        }
        if (!isdefined(weapon)) {
            return false;
        }
        distancetotarget = distance(self.origin, self.enemy.origin);
        if (distancetotarget <= weapon.aimeleerange) {
            return false;
        }
        settingsbundle = self ai::function_9139c839();
        if (!(isdefined(settingsbundle) && isdefined(settingsbundle.var_158394c8))) {
            return false;
        }
        if (distancetotarget > weapon.aimeleerange + settingsbundle.var_158394c8) {
            return true;
        }
        toenemy = vectornormalize(self.enemy.origin - self.origin);
        dot = vectordot(toenemy, self getweaponforwarddir());
        if (dot < 0 || acos(dot) > 80) {
            return true;
        }
    }
    return false;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xc83224c6, Offset: 0xc448
// Size: 0x58
function private function_de7e2d3f(entity) {
    entity setblackboardattribute("_charge_melee_anim", math::cointoss());
    entity setupchargemeleeattack(entity);
    return true;
}

// Namespace aiutility/archetype_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xe532fff, Offset: 0xc4a8
// Size: 0x28
function private function_9414b79f(entity) {
    entity cleanupchargemelee(entity);
    return true;
}

