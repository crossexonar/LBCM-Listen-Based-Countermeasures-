///This is for implementing with your Launcher Lock on code.
///8/13/2020
default
{
		timer()
		{
		vector offset = <0,0,0>+<0,0,0>*llGetRot();//Set this to your raycast offset, First set would be for Z height, second for x and y offsets.
		vector targetpos = llList2Vector(llGetObjectDetails(target, [OBJECT_POS]), 0);
		list rc = llCastRay(llGetPos()+offset, targetpos, [RC_REJECT_TYPES, RC_REJECT_PHYSICAL | RC_REJECT_AGENTS]);
		list smokecheck =llCastRay(llGetPos()+offset,targetpos,[RC_REJECT_TYPES,RC_REJECT_PHYSICAL|RC_REJECT_AGENTS,RC_DATA_FLAGS,RC_GET_ROOT_KEY,RC_DETECT_PHANTOM,1]);
		string smokename = llToLower(llKey2Name(llList2Key(smokecheck,0)));
		if((llList2Integer(rc, -1) < 1 || llGetOwnerKey(llList2Key(rc, 0)) == targ) && llSubStringIndex(smokename,"smoke")==-1)
		{
			//Lock Sucessfull
		}
		else if((llList2Integer(rc, -1) > 0 || llGetOwnerKey(llList2Key(rc, 0)) != targ) && llSubStringIndex(smokename,"smoke")!=-1)
		{
			//Lock Failed
		}
	}
}
