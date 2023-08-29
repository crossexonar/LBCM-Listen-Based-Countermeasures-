///Preferably put this in a large prim so it doesnt derender at distance, PHANTOM REQUIRED
key missiletrack = NULL_KEY;
integer dietimer;
float DIE_AFTER = 60.5; 

integer gTargetHash;

key gTargetKey;
vector clamp_to_sim(vector a)
{
    if (a.x > 255.99) a.x = 255.99;
    else if (a.x < 0.1) a.x = 0.1;
    if (a.y > 255.99) a.y = 255.99;
    else if (a.y < 0.1) a.y = 0.1;
    if (a.z > 4095.99) a.z = 4095.99;
    else if (a.z < 0.1) a.z = 0.1;
    return a;
}
run_timer()
{
    list od = llGetObjectDetails(gTargetKey, [OBJECT_POS, OBJECT_VELOCITY]);
    llSetRegionPos(clamp_to_sim(llList2Vector(od, 0) + llList2Vector(od, 1) * 0.075));
    if (llGetAgentInfo(gTargetKey) & (AGENT_SITTING | AGENT_ON_OBJECT))
    {
    } 
    else{llDie(); }
    if (llGetTime() >= DIE_AFTER || (llKey2Name(missiletrack)== "" && missiletrack != NULL_KEY)) llDie();
}

integer key_hash(key from_UUID, integer nonce)
{
    return (integer)("0x" + llGetSubString(llMD5String(from_UUID, nonce), 0, 6));
}
default
{
    on_rez(integer start_param)
    {
        if (start_param == 0) llResetScript();
        else
        {
            gTargetHash = start_param;
            list agents = llGetAgentList(AGENT_LIST_REGION, []);
            integer l = llGetListLength(agents);
            key id;
            while (--l >= 0)
            {
                key agent = llList2Key(agents, l);
                id = llList2Key(agents, l);
        
            if (key_hash(id, 0) == gTargetHash)
            {
                gTargetKey = id;
                llResetTime();
                llLoopSound("dad99697-e630-db26-7e47-6ab6feb8800f",1);
                key rezzer = llList2Key(llGetObjectDetails(llGetKey(),[OBJECT_REZZER_KEY]),0);
                integer hex = (integer)("0x" + llGetSubString(llMD5String((string)id,0), 0, 3));
                llListen(hex, "","","");
                integer rezhex = (integer)("0x" + llGetSubString(llMD5String((string)rezzer,0), 0, 3));
                llListen(rezhex, "","","");
                llSetLinkPrimitiveParamsFast(LINK_THIS,[PRIM_TEMP_ON_REZ,0]);
                llSetTimerEvent(0.04);
                run_timer();
                return;
            }
            }
        }
    }
    listen(integer channel, string name, key id, string msg)
    {
        if(llGetOwnerKey(id) == llGetOwner())
        {
        if(msg == "die")dietimer = 1;
        if(msg == "locked" && missiletrack == NULL_KEY)
        {
            llLoopSound("271be61f-0878-32b9-bc5e-f03b36a2aee1",1);
        }
        if(llList2String(llCSV2List(msg),0) == "incoming" && llList2Key(llCSV2List(msg),1) == gTargetKey && missiletrack == NULL_KEY)
        {
            llLoopSound("4a57385f-db6b-55db-69b9-0f70b10fa51c",.05);
            missiletrack = id;
            //llOwnerSay(llKey2Name(missiletrack));
        }
        }
    }
    state_entry()
    {
        llSetStatus(STATUS_DIE_AT_EDGE, TRUE);
        llSetStatus(STATUS_RETURN_AT_EDGE | STATUS_ROTATE_X | STATUS_ROTATE_Y | STATUS_ROTATE_Z, FALSE);
        llSetDamage(100.0); 
    }
    
    timer()
    {
        run_timer();
        if(dietimer == 1 && (missiletrack == NULL_KEY || llKey2Name(missiletrack)=="" || llKey2Name(missiletrack)=="[ESC]-[Spartan]-[SEEKER]-[Boom]"))llDie();
        if(missiletrack != NULL_KEY && llKey2Name(missiletrack)!="")
        {
            vector missilepos = llList2Vector(llGetObjectDetails(missiletrack,[OBJECT_POS]),0);
            float dist = llVecDist(llGetPos(),missilepos);
            llAdjustSoundVolume(25/dist);
        }
    }
}
