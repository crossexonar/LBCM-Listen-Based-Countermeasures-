///Credit Goes to Sin Straaf for original implimentation!///
///8/13/2020 Added Instructions for different types of interceptor systems.///
default
{
    state_entry()
    {
        
    }
    on_rez(integer sp)
    {
        llResetTime();
        llSensorRepeat("", NULL_KEY, (ACTIVE|SCRIPTED), sp, TWO_PI, 0.5);//Rez parameters = Radius of Sensor, Remember this!
	// particles();
    }
    sensor(integer i)
    {
        while(i--)
        {
            string data=(string)llGetObjectDetails(hit,[OBJECT_DESC]);//Get DESC
            list parse=llCSV2List(llToUpper(data));//Parse DESC, ToUpper is used to case sensitivity
            if(llList2String(parse,-1)=="SKR")//Look for missile flag
            {
                list d = llCSV2List(desc);
                // get their max hp and filter out armor, set missile hp at 1hp
                if((integer)llList2String(d, 2) < 2)
                {
                    integer hex=(integer)("0x" + llGetSubString(llMD5String((string)llDetectedKey(i),0), 0, 3));
                    //llRegionSayTo(llDetectedKey(i),hex,(string)llDetectedKey(i)+","+(string)-1);//Missile Loses Tracking.
                    llRegionSayTo(llDetectedKey(i),hex,(string)llDetectedKey(i)+","+(string)0);//Missile Goes after flare.
                    //llRegionSayTo(llDetectedKey(i),hex,(string)llDetectedKey(i)+","+(string)1);//Missile Detonates.
                }
            }
        }
        if(llGetTime() > 5) llDie();
    }
    no_sensor()
    {
        if(llGetTime() > 5) llDie();
    }
}
