/*==================================================================================*/
/*                              Made By. Leehi                                      */
/*==================================================================================*/
#include <a_samp>
#if defined FILTERSCRIPT

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp("/horn",cmdtext,true,10)==0)
	{
		new Vehicle = GetPlayerVehicleID(playerid);
		SetPVarInt(playerid, "Status", 1);
		SetPVarInt(playerid, "carbull", CreateObject(19314,0,0,-1000,0,0,0,100));
		AttachObjectToVehicle(GetPVarInt(playerid, "carbull"), GetPlayerVehicleID(playerid), -0.000000,2.700000,-0.000000,89.099983,-0.000001,91.799980);
	}
#endif

