///Listen based Countermeasures - Missile
///8/13/2020
///Interfaces with Sins Countermeasure flares and others.
integer lbcmhex;
integer lbcmlisten;
///Before Default (globals)
default
{
	on_rez(integer n)
	{
  		if(n)
  		{
			llSetObjectDesc("LBA.v.,SKR");
    			lbcmhex = (integer)("0x" + llGetSubString(llMD5String((string) llGetKey(), 0), 0, 3));
    			lbcmlisten = llListen(hex, "", "", "");
  		}
	}

	listen(integer channel, string name, key id, string msg)
    	{
      		if(channel == lbcmhex)
      		{
        		list l = llParseString2List(msg, [","], []);
        		string listgt = llList2String(l, 0);
        		integer dmg = (integer) llList2String(l, 1);
        		if(listgt == (string) llGetKey())
        		{
            			if(hex != 0) llRegionSay(hex, "die");//To tell your Beep tone to die.
            			if(dmg == 0) trackkey = id; //Tracking key set to source.
            			else if(dmg < 0) trackkey = NULL_KEY; //Tracking Lost.
            			else if(dmg > 0) Kaboomfunction(); //Missile Killed.
        		}
      		}
    	}
