/*==================================================================================*/
/*                              Made By. Leehi                                      */
/*==================================================================================*/
//------------------------------------------------------------------------------
#include <a_samp.inc>
#include <SINI.inc>
#include <iamm_pos.inc>
//------------------------------------------------------------------------------
#define MAX_PLAYER_INVENTORIES  30
//------------------------------------------------------------------------------
#define JOB_NONE            	0
#define JOB_KNIGHT          	1
//------------------------------------------------------------------------------
#define ITEM_TYPE_NONE      	0
#define ITEM_TYPE_CONSUME   	1
#define ITEM_TYPE_EQUIPMENT 	2
//------------------------------------------------------------------------------
#define DIALOG_REGISTER 		1
#define DIALOG_LOGIN    		2
#define DIALOG_CHANGEPASS 		3 // 나중에
#define DIALOG_SET_NICKNAME 	4

#define DIALOG_MENU         	11
#define DIALOG_STATS        	12
#define DIALOG_SELLLIST     	13
#define DIALOG_INVENTORY    	14
#define DIALOG_EQUIPMENT        15

#define DIALOG_SCRIPT_END   	1000
// 앨리스, 기사 전직
#define DIALOG_SCRIPT_1     	1001
#define DIALOG_SCRIPT_2     	1002
#define DIALOG_SCRIPT_3     	1003
// 백우, 군인
#define DIALOG_SCRIPT_4     	1004
// 보겸, 창고
#define DIALOG_SCRIPT_5     	1005
// 잭슨, 의사
#define DIALOG_SCRIPT_6     	1006
// 호진, 상인
#define DIALOG_SCRIPT_7     	1007
// 홍주, 장비 상인
#define DIALOG_SCRIPT_8         1008
//------------------------------------------------------------------------------
forward AutoSaveTimer();
forward LevelUpTimer();
forward s0beit(playerid);
forward ShowMenu(playerid);
forward ShowEquipments(playerid);
forward ShowStats(playerid);
forward ShowInventoryForPlayer(playerid, showplayerid);
forward ShowSellList(playerid, itemtype);
//------------------------------------------------------------------------------
enum pInfo
{
	pPassword[128],
	pTutorial,
	pLevel,
	pEXP,
	pNickname[MAX_PLAYER_NAME],
	pAdminLevel,
	Float:pPos[4],
	pInterior,
	pWorld,
	pJob,
	pMoney,
	Float:pHealth,
	Float:pArmour
};
new PlayerInfo[MAX_PLAYERS][pInfo];

enum piInfo
{
	piItemID,
	piItemAmount
};
new PlayerInventoryInfo[MAX_PLAYERS][MAX_PLAYER_INVENTORIES][piInfo];

enum peInfo
{
	peItemID,
	peItemModel,
	Float:peItemOffset[3],
	Float:peItemRot[3],
	Float:peItemScale[3]
};
new PlayerEquipmentInfo[MAX_PLAYERS][19][peInfo];
/*
0 무기
1 ~ 18 방어구
*/

new bool:Account[MAX_PLAYERS] = { false, ... };
new bool:Logined[MAX_PLAYERS] = { false, ... };
new s0beit_Passed[MAX_PLAYERS] = { 0, ... };

new Text3D:PlayerLabel[MAX_PLAYERS] = { Text3D:INVALID_3DTEXT_ID, ... };

new bool:AutoSave = false;

new TalkingActor[MAX_PLAYERS] = { -1, ... };
new PlayerEquipedWeapon[MAX_PLAYERS] = { 0, ... };
new BuyingItemType[MAX_PLAYERS] = { 0, ... };
//------------------------------------------------------------------------------
enum itInfo
{
    itType,
    itName[24],
	itPrice,
	itModel,
	bool:itSell,
};
new ItemInfo[][itInfo] = {
	{ITEM_TYPE_CONSUME, 	"소형 회복약", 	50,		0,		true},
	{ITEM_TYPE_CONSUME, 	"중형 회복약", 	100,	0,		true},
	{ITEM_TYPE_EQUIPMENT,   "딜도",         500,    322,	true},
	{ITEM_TYPE_CONSUME, 	"대형 회복약", 	200,	0,		true},
	{ITEM_TYPE_EQUIPMENT,   "전기톱",       5000,	341,	true}
};
//------------------------------------------------------------------------------
enum aInfo
{
	aName[MAX_PLAYER_NAME],
	aSub[MAX_PLAYER_NAME],
	aModel,
	Float:aPos[4]
};
new ActorInfo[][aInfo] = {
	{"앨리스", 	"기사 전직", 	150, 	{-777.9976, 1437.6735, 13.7891, 0.0000}},
	{"백우", 	"군인", 		287, 	{-815.8527, 1447.6820, 13.9453, 0.0000}},
	{"보겸",	"창고",			187,	{-828.2936, 1500.7463, 19.3686, 0.0000}},
	{"잭슨",	"의사", 		275,	{-817.4917, 1551.0803, 27.1172, 0.0000}},
	{"호진",	"소비 상인", 	29,		{-780.1939, 1500.6450, 23.8044, 0.0000}},
	{"홍주",	"장비 상인", 	29,		{-797.5771, 1525.7927, 27.0789, 270.0000}}
};
new Text3D:ActorTag[MAX_ACTORS] = { Text3D:INVALID_3DTEXT_ID, ... };
//------------------------------------------------------------------------------
stock strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

stock GivePlayerItem(playerid, itemid, amount)
{
	if (IsPlayerConnected(playerid))
	{
	    if (amount > 0)
	    {
		    if (ItemInfo[itemid][itType] != ITEM_TYPE_NONE)
		    {
		        new inventory_index = -1;
		        for (new i; i < MAX_PLAYER_INVENTORIES; i++)
		        {
		            if (PlayerInventoryInfo[playerid][i][piItemID] == -1 ||
						PlayerInventoryInfo[playerid][i][piItemID] == itemid
					)
		            {
		                inventory_index = i;
		                break;
		            }
		        }
		        if (PlayerInventoryInfo[playerid][inventory_index][piItemID] == -1)
		        {
		            PlayerInventoryInfo[playerid][inventory_index][piItemID] = itemid;
		            PlayerInventoryInfo[playerid][inventory_index][piItemAmount] ++;
		        }
		        else if (PlayerInventoryInfo[playerid][inventory_index][piItemID] == itemid)
		        {
		            PlayerInventoryInfo[playerid][inventory_index][piItemAmount] ++;
		        }
		        return 1;
		    }
	    }
	}
	return 0;
}

stock GetWeaponModel(weaponid)
{
	new modelid = 0;
	switch (weaponid)
	{
	    case 1: modelid = 331;
	    case 2: modelid = 333;
	    case 3: modelid = 334;
	    case 4: modelid = 335;
	    case 5: modelid = 336;
	    case 6: modelid = 337;
	    case 7: modelid = 338;
	    case 8: modelid = 339;
	    case 9: modelid = 341;
	    case 10: modelid = 321;
	    case 11: modelid = 322;
	    case 12: modelid = 323;
	    case 13: modelid = 324;
	    case 14: modelid = 325;
	    case 15: modelid = 326;
	    case 16: modelid = 342;
	    case 17: modelid = 343;
	    case 18: modelid = 344;
	    case 22: modelid = 346;
	    case 23: modelid = 347;
	    case 24: modelid = 348;
	    case 25: modelid = 349;
	    case 26: modelid = 350;
	    case 27: modelid = 351;
	    case 28: modelid = 352;
	    case 29: modelid = 353;
	    case 30: modelid = 355;
	    case 31: modelid = 356;
	    case 32: modelid = 372;
	    case 33: modelid = 357;
	    case 34: modelid = 358;
	    case 35: modelid = 359;
	    case 36: modelid = 360;
	    case 37: modelid = 361;
	    case 38: modelid = 362;
	    case 39: modelid = 363;
	    case 40: modelid = 364;
	    case 41: modelid = 365;
	    case 42: modelid = 366;
	    case 43: modelid = 367;
	    case 44: modelid = 368;
	    case 45: modelid = 369;
	    case 46: modelid = 371;
	}
	return modelid;
}

stock GetActorFrontPos(actorid, Float:Distance, &Float:X, &Float:Y, &Float:Z)
{
	new Float:oldpos[3], Float:angle;
	GetActorPos(actorid, oldpos[0], oldpos[1], oldpos[2]);
	GetActorFacingAngle(actorid, angle);

	new Float:newpos[3];
	newpos[0] = oldpos[0] + (Distance * floatcos(angle + 90, degrees));
	newpos[1] = oldpos[1] + (Distance * floatsin(angle + 90, degrees));
	newpos[2] = oldpos[2];

	X = newpos[0];
	Y = newpos[1];
	Z = newpos[2];

	return 1;
}

stock SetActorLookAt(actorid, Float:x, Float:y)
{
	new Float:Px, Float:Py, Float: Pa;
	GetActorPos(actorid, Px, Py, Pa);
	Pa = floatabs(atan((y-Py)/(x-Px)));
	if (x <= Px && y >= Py) Pa = floatsub(180, Pa);
	else if (x < Px && y < Py) Pa = floatadd(Pa, 180);
	else if (x >= Px && y <= Py) Pa = floatsub(360.0, Pa);
	Pa = floatsub(Pa, 90.0);
	if (Pa >= 360.0) Pa = floatsub(Pa, 360.0);
	SetActorFacingAngle(actorid, Pa);
}

stock SendCloseMessage(Float:X, Float:Y, Float:Z, Float:distance, color, const message[])
{
	for (new i; i < GetMaxPlayers(); i++)
	    if (IsPlayerConnected(i))
	        if (Logined[i] == true)
	            if (IsPlayerInRangeOfPoint(i, distance, X, Y, Z))
					SendClientMessage(i, color, message);
}

stock SendServerMessage(color, const message[])
{
	for (new i; i < GetMaxPlayers(); i++)
	    if (IsPlayerConnected(i))
	        if (Logined[i] == true)
				SendClientMessage(i, color, message);
}

stock PlayerName(playerid)
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	return playername;
}

stock KickLog(text[])
{
	new entry[1024];
 	format(entry, 1024, "%s\n", text);
	new File:logfile = fopen("kick_log.txt", io_append);
	fwrite(logfile, entry);
	fclose(logfile);
}

stock BanLog(text[])
{
	new entry[1024];
	format(entry, 1024, "%s\n", text);
	new File:logfile = fopen("ban_log.txt", io_append);
	fwrite(logfile, entry);
	fclose(logfile);
}

stock LoadPlayer(playerid)
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, 24);
	new file[256];
	format(file, 256, "Userfiles/%s.ini", playername);
	if (INI_Exist(file))
	{
	    INI_Open(file, Read);
		strmid(PlayerInfo[playerid][pPassword], INI_Read("Password"),0, 128,128);
		PlayerInfo[playerid][pLevel] =  strval(INI_Read("Level"));
		PlayerInfo[playerid][pEXP] =  strval(INI_Read("EXP"));
		PlayerInfo[playerid][pTutorial] =  strval(INI_Read("Tutorial"));
		strmid(PlayerInfo[playerid][pNickname],INI_Read("Nickname"),0, 128,128);
		PlayerInfo[playerid][pAdminLevel] = strval(INI_Read("AdminLevel"));
		PlayerInfo[playerid][pPos][0] = floatstr(INI_Read("X"));
		PlayerInfo[playerid][pPos][1] = floatstr(INI_Read("Y"));
		PlayerInfo[playerid][pPos][2] = floatstr(INI_Read("Z"));
		PlayerInfo[playerid][pPos][3] = floatstr(INI_Read("Angle"));
		PlayerInfo[playerid][pInterior] = strval(INI_Read("Interior")); // IntSet 듀토리얼 처럼
		PlayerInfo[playerid][pWorld] = strval(INI_Read("World"));
		PlayerInfo[playerid][pJob] = strval(INI_Read("Job"));
		PlayerInfo[playerid][pMoney] = strval(INI_Read("Money"));
		PlayerInfo[playerid][pHealth] = floatstr(INI_Read("Health"));
		PlayerInfo[playerid][pArmour] = floatstr(INI_Read("Armour"));
		printf("[load] %s loaded.", playername);
		INI_Close();
		//----------------------------------------------------------------------
		GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
		SetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
		SetPlayerArmour(playerid, PlayerInfo[playerid][pArmour]);
		return 1;
	}
	return 0;
}

stock SavePlayer(playerid)
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	new file[256];
	format(file, 256, "Userfiles/%s.ini", playername);
	if (INI_Exist(file))
	{
	    GetPlayerPos(
			playerid,
			PlayerInfo[playerid][pPos][0],
			PlayerInfo[playerid][pPos][1],
			PlayerInfo[playerid][pPos][2]
		);
		GetPlayerFacingAngle(
		    playerid,
		    PlayerInfo[playerid][pPos][3]
		);
		PlayerInfo[playerid][pInterior] = GetPlayerInterior(playerid);
		PlayerInfo[playerid][pWorld] = GetPlayerVirtualWorld(playerid);
		PlayerInfo[playerid][pMoney] = GetPlayerMoney(playerid);
		GetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
		GetPlayerArmour(playerid, PlayerInfo[playerid][pArmour]);
	    if(INI_Exist(file))
	    {
		    INI_Open(file, Write);
			INI_Write("Password", PlayerInfo[playerid][pPassword]);
			INI_WriteInt("Level", PlayerInfo[playerid][pLevel]);
			INI_WriteInt("EXP", PlayerInfo[playerid][pEXP]);
			INI_WriteInt("Tutorial", PlayerInfo[playerid][pTutorial]);
			INI_Write("Nickname", PlayerInfo[playerid][pNickname]);
			INI_WriteInt("AdminLevel", PlayerInfo[playerid][pAdminLevel]);
			INI_WriteFloat("X", PlayerInfo[playerid][pPos][0]);
			INI_WriteFloat("Y", PlayerInfo[playerid][pPos][1]);
			INI_WriteFloat("Z", PlayerInfo[playerid][pPos][2]);
			INI_WriteFloat("Angle", PlayerInfo[playerid][pPos][3]);
			INI_WriteInt("Interior", PlayerInfo[playerid][pInterior]);
			INI_WriteInt("World", PlayerInfo[playerid][pWorld]);
			INI_WriteInt("Job", PlayerInfo[playerid][pJob]);
			INI_WriteInt("Money", PlayerInfo[playerid][pMoney]);
			INI_WriteFloat("Health", PlayerInfo[playerid][pHealth]);
			INI_WriteFloat("Armour", PlayerInfo[playerid][pArmour]);
			printf("[save] %s saved.", playername);
			INI_Close();
		}
		return 1;
	}
	return 1;
}

stock RegisterPlayer(playerid, password[])
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, 24);
	new file[256];
	format(file, 256, "Userfiles/%s.ini", playername);
	if (!INI_Exist(file))
	{
	    INI_Open(file, Write);
		strmid(PlayerInfo[playerid][pPassword], password, 0, 24, 24);
		INI_Write("Password", PlayerInfo[playerid][pPassword]);
		PlayerInfo[playerid][pLevel] = 1;
		INI_WriteInt("Level", PlayerInfo[playerid][pLevel]);
		PlayerInfo[playerid][pEXP] = 0;
		INI_WriteInt("EXP", PlayerInfo[playerid][pEXP]);
		PlayerInfo[playerid][pTutorial] = 0;
		INI_WriteInt("Tutorial", PlayerInfo[playerid][pTutorial]);
		strmid(PlayerInfo[playerid][pNickname], "None", 0, 24, 24);
		INI_Write("Nickname", PlayerInfo[playerid][pNickname]);
		PlayerInfo[playerid][pAdminLevel] = 0;
		INI_WriteInt("AdminLevel", PlayerInfo[playerid][pAdminLevel]);
		PlayerInfo[playerid][pPos][0] = 0.0000;
		INI_WriteFloat("X", PlayerInfo[playerid][pPos][0]);
		PlayerInfo[playerid][pPos][1] = 0.0000;
		INI_WriteFloat("Y", PlayerInfo[playerid][pPos][1]);
		PlayerInfo[playerid][pPos][2] = 0.0000;
		INI_WriteFloat("Z", PlayerInfo[playerid][pPos][2]);
		PlayerInfo[playerid][pPos][3] = 0.0000;
		INI_WriteFloat("Angle", PlayerInfo[playerid][pPos][3]);
		PlayerInfo[playerid][pInterior] = 0;
		INI_WriteInt("Interior", PlayerInfo[playerid][pInterior]);
		PlayerInfo[playerid][pWorld] = 0;
		INI_WriteInt("World", PlayerInfo[playerid][pWorld]);
		PlayerInfo[playerid][pJob] = JOB_NONE;
		INI_WriteInt("Job", PlayerInfo[playerid][pJob]);
		PlayerInfo[playerid][pMoney] = 500;
		INI_WriteInt("Money", PlayerInfo[playerid][pMoney]);
		PlayerInfo[playerid][pHealth] = 100.0;
		INI_WriteFloat("Health", PlayerInfo[playerid][pHealth]);
		PlayerInfo[playerid][pArmour] = 100.0;
		INI_WriteFloat("Armour", PlayerInfo[playerid][pArmour]);
		INI_Close();
		printf("[registry] %s registerd.", playername);
		return 1;
	}
	return 0;
}

stock LoadPlayerInventories(playerid)
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, 24);
	new file[256];
	format(file, 256, "Userfiles/Inventories/%s.ini", playername);
	if (!INI_Exist(file))
	{
	    INI_Open(file, Write);
	    INI_Close();
	}
    INI_Open(file, Read);
	new info[256];
	for (new i; i < MAX_PLAYER_INVENTORIES; i++)
    {
        format(info, 256, "%d_ID", i + 1); PlayerInventoryInfo[playerid][i][piItemID] =  strval(INI_Read(info));
		format(info, 256, "%d_Amount", i + 1); PlayerInventoryInfo[playerid][i][piItemAmount] = strval(INI_Read(info));
        if (PlayerInventoryInfo[playerid][i][piItemAmount] == 0)
            PlayerInventoryInfo[playerid][i][piItemID] = -1;
	}
	INI_Close();
	return 1;
}

stock SavePlayerInventories(playerid)
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	new file[256], info[256];
	format(file, 256, "Userfiles/Inventories/%s.ini", playername);
	INI_Open(file, Write);
	for (new i; i < MAX_PLAYER_INVENTORIES; i++)
    {
        format(info, 256, "%d_ID", i + 1); INI_WriteInt(info, PlayerInventoryInfo[playerid][i][piItemID]);
		format(info, 256, "%d_Amount", i + 1); INI_WriteInt(info, PlayerInventoryInfo[playerid][i][piItemAmount]);
	}
	INI_Close();
	return 1;
}

stock LoadPlayerEquipments(playerid)
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, 24);
	new file[256];
	format(file, 256, "Userfiles/Equipments/%s.ini", playername);
	if (!INI_Exist(file))
	{
	    INI_Open(file, Write);
	    new tmp[256];
		for (new i; i < 19; i++)
	    {
	        format(tmp, 256, "%d_ID", i + 1); INI_WriteInt(tmp, -1);
	        format(tmp, 256, "%d_Model", i + 1); INI_WriteInt(tmp, 0);
	        format(tmp, 256, "%d_OffsetX", i + 1); INI_WriteFloat(tmp, 0.0000);
	        format(tmp, 256, "%d_OffsetY", i + 1); INI_WriteFloat(tmp, 0.0000);
	        format(tmp, 256, "%d_OffsetZ", i + 1); INI_WriteFloat(tmp, 0.0000);
	        format(tmp, 256, "%d_RotX", i + 1); INI_WriteFloat(tmp, 0.0000);
	        format(tmp, 256, "%d_RotY", i + 1); INI_WriteFloat(tmp, 0.0000);
	        format(tmp, 256, "%d_RotZ", i + 1); INI_WriteFloat(tmp, 0.0000);
	        format(tmp, 256, "%d_ScaleX", i + 1); INI_WriteFloat(tmp, 0.0000);
	        format(tmp, 256, "%d_ScaleY", i + 1); INI_WriteFloat(tmp, 0.0000);
	        format(tmp, 256, "%d_ScaleZ", i + 1); INI_WriteFloat(tmp, 0.0000);
		}
	    INI_Close();
	}
    INI_Open(file, Read);
	new info[256];
	for (new i; i < 19; i++)
    {
        format(info, 256, "%d_ID", i + 1); PlayerEquipmentInfo[playerid][i][peItemID] = strval(INI_Read(info));
        format(info, 256, "%d_Model", i + 1); PlayerEquipmentInfo[playerid][i][peItemModel] = strval(INI_Read(info));
        format(info, 256, "%d_OffsetX", i + 1); PlayerEquipmentInfo[playerid][i][peItemOffset][0] = floatstr(INI_Read(info));
        format(info, 256, "%d_OffsetY", i + 1); PlayerEquipmentInfo[playerid][i][peItemOffset][1] = floatstr(INI_Read(info));
        format(info, 256, "%d_OffsetZ", i + 1); PlayerEquipmentInfo[playerid][i][peItemOffset][2] = floatstr(INI_Read(info));
       	format(info, 256, "%d_RotX", i + 1); PlayerEquipmentInfo[playerid][i][peItemRot][0] = floatstr(INI_Read(info));
        format(info, 256, "%d_RotY", i + 1); PlayerEquipmentInfo[playerid][i][peItemRot][1] = floatstr(INI_Read(info));
        format(info, 256, "%d_RotZ", i + 1); PlayerEquipmentInfo[playerid][i][peItemRot][2] = floatstr(INI_Read(info));
       	format(info, 256, "%d_ScaleX", i + 1); PlayerEquipmentInfo[playerid][i][peItemScale][0] = floatstr(INI_Read(info));
        format(info, 256, "%d_ScaleY", i + 1); PlayerEquipmentInfo[playerid][i][peItemScale][1] = floatstr(INI_Read(info));
        format(info, 256, "%d_ScaleZ", i + 1); PlayerEquipmentInfo[playerid][i][peItemScale][2] = floatstr(INI_Read(info));
	}
	INI_Close();
	if (PlayerEquipmentInfo[playerid][0][peItemID] != -1)
	{
	    new itemid = PlayerEquipmentInfo[playerid][0][peItemID];
	    switch (itemid)
	    {
	    	case 2: PlayerEquipedWeapon[playerid] = 11;
	    	case 4: PlayerEquipedWeapon[playerid] = 9;
	    }
	}
	return 1;
}

stock SavePlayerEquipments(playerid)
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	new file[256], info[256];
	format(file, 256, "Userfiles/Equipments/%s.ini", playername);
	INI_Open(file, Write);
	for (new i; i < 19; i++)
    {
        format(info, 256, "%d_ID", i + 1); INI_WriteInt(info, PlayerEquipmentInfo[playerid][i][peItemID]);
        format(info, 256, "%d_Model", i + 1); INI_WriteInt(info, PlayerEquipmentInfo[playerid][i][peItemModel]);
        format(info, 256, "%d_OffsetX", i + 1); INI_WriteFloat(info, PlayerEquipmentInfo[playerid][i][peItemOffset][0]);
        format(info, 256, "%d_OffsetY", i + 1); INI_WriteFloat(info, PlayerEquipmentInfo[playerid][i][peItemOffset][1]);
        format(info, 256, "%d_OffsetZ", i + 1); INI_WriteFloat(info, PlayerEquipmentInfo[playerid][i][peItemOffset][2]);
        format(info, 256, "%d_RotX", i + 1); INI_WriteFloat(info, PlayerEquipmentInfo[playerid][i][peItemRot][0]);
        format(info, 256, "%d_RotY", i + 1); INI_WriteFloat(info, PlayerEquipmentInfo[playerid][i][peItemRot][1]);
        format(info, 256, "%d_RotZ", i + 1); INI_WriteFloat(info, PlayerEquipmentInfo[playerid][i][peItemRot][2]);
        format(info, 256, "%d_ScaleX", i + 1); INI_WriteFloat(info, PlayerEquipmentInfo[playerid][i][peItemScale][0]);
        format(info, 256, "%d_ScaleY", i + 1); INI_WriteFloat(info, PlayerEquipmentInfo[playerid][i][peItemScale][1]);
        format(info, 256, "%d_ScaleZ", i + 1); INI_WriteFloat(info, PlayerEquipmentInfo[playerid][i][peItemScale][2]);
	}
	INI_Close();
	return 1;
}

stock GetJobName(jobid)
{
	new jobname[64];
	switch (jobid)
	{
	    case 1: jobname = "기사";
	    default: jobname = "없음";
	}
	return jobname;
}

stock GetBoneName(boneid)
{
	new bonename[64];
	switch (boneid)
	{
	    case 1: bonename = "허리";
	    case 2: bonename = "머리";
	    case 3: bonename = "왼팔 (위)";
	    case 4: bonename = "오른팔 (위)";
	    case 5: bonename = "왼손";
	    case 6: bonename = "오른손";
	    case 7: bonename = "왼쪽 허벅지";
	    case 8: bonename = "오른족 허벅지";
	    case 9: bonename = "왼발";
	    case 10: bonename = "오른발";
	    case 11: bonename = "오른쪽 종아리";
	    case 12: bonename = "왼쪽 종아리";
	    case 13: bonename = "왼쪽 팔뚝";
	    case 14: bonename = "오른쪽 팔뚝";
	    case 15: bonename = "왼쪽 어깨";
	    case 16: bonename = "오른쪽 어깨";
	    case 17: bonename = "목";
	    case 18: bonename = "턱";
	    default: bonename = "알 수 없음";
	}
	return bonename;
}

stock GetCloseActorID(playerid)
{
	new index = -1;
	for (new a; a < MAX_ACTORS; a++)
	{
	    if (ActorInfo[a][aModel] > 0)
	    {
			if (IsPlayerInRangeOfPoint(playerid, 3.0000, ActorInfo[a][aPos][0], ActorInfo[a][aPos][1], ActorInfo[a][aPos][2]))
			{
			    index = a;
			    break;
			}
		}
	}
	return index;
}

public ShowMenu(playerid)
{
	ShowPlayerDialog(playerid, DIALOG_MENU, DIALOG_STYLE_LIST, "메뉴", "내 정보\n인벤토리\n장비", "선택", "닫기");
	return 1;
}

public ShowEquipments(playerid)
{
	new info[2048], str[256];
	strcat(info, "슬롯\t이름\n");
	for (new i; i < 19; i++)
	{
	    if (i == 0)
	    {
			format(str, 256, "무기\t");
		}
		else
		{
		    format(str, 256, "방어구 (%s)\t", GetBoneName(i));
		}
		new itemid = PlayerEquipmentInfo[playerid][i][peItemID];
		if (itemid == -1)
		{
		    strcat(str, "없음"); strcat(str, "\n");
		}
		else
		{
			strcat(str, ItemInfo[itemid][itName]); strcat(str, "\n");
		}
		strcat(info, str);
	}
	ShowPlayerDialog(playerid, DIALOG_EQUIPMENT, DIALOG_STYLE_TABLIST_HEADERS, "장비", info, "해제", "닫기");
	return 1;
}

public ShowStats(playerid)
{
	new info[1024];
	new expneed = 100 + ((300 * (PlayerInfo[playerid][pLevel] - 1)));
	format(
		info,
		1024,
		"\
		    닉네임 : %s\n\
		    직업 : %s\n\
		    레벨 : %d\n\
		    경험치 : %d/%d\
		",
		PlayerInfo[playerid][pNickname],
		GetJobName(PlayerInfo[playerid][pJob]),
		PlayerInfo[playerid][pLevel],
		PlayerInfo[playerid][pEXP], expneed
	);
	ShowPlayerDialog(playerid, DIALOG_STATS, DIALOG_STYLE_MSGBOX, "내 정보", info, "닫기", "");
	return 1;
}

public ShowInventoryForPlayer(playerid, showplayerid)
{
	new info[2048], str[256];
	strcat(info, "번호\t이름\t수량\n");
	new tmp[256];
	new itmp = -1;
	for (new i; i < MAX_PLAYER_INVENTORIES; i++)
	{
	    if (PlayerInventoryInfo[playerid][i][piItemID] != -1)
	    {
         	itmp ++;
	        format(tmp, 256, "InventoryListID_%d", itmp);
	        SetPVarInt(playerid, tmp, i);
	        format(
				str, 256, "%d\t%s\t%d\n",
				itmp + 1,
				ItemInfo[PlayerInventoryInfo[playerid][i][piItemID]][itName],
				PlayerInventoryInfo[playerid][i][piItemAmount]
			);
	        strcat(info, str);
	    }
	}
	ShowPlayerDialog(showplayerid, DIALOG_INVENTORY, DIALOG_STYLE_TABLIST_HEADERS, "인벤토리", info, "선택하기", "닫기");
	return 1;
}

public ShowSellList(playerid, itemtype)
{
	new info[2048], str[256];
	strcat(info, "번호\t이름\t가격\n");
	new tmp[256];
	new itmp = -1;
	for (new i; i < sizeof(ItemInfo); i++)
	{
	    if (ItemInfo[i][itType] == itemtype)
	    {
	        if (ItemInfo[i][itSell] == true)
	        {
                itmp ++;
	            format(tmp, 256, "BuyItemListID_%d", itmp);
	            SetPVarInt(playerid, tmp, i);
		        format(str, 256, "%d\t%s\t$%d\n", itmp + 1, ItemInfo[i][itName], ItemInfo[i][itPrice]);
		        strcat(info, str);
	        }
	    }
	}
	ShowPlayerDialog(playerid, DIALOG_SELLLIST, DIALOG_STYLE_TABLIST_HEADERS, "상점", info, "선택하기", "나가기");
	return 1;
}
//------------------------------------------------------------------------------
public AutoSaveTimer()
{
	if (AutoSave == true)
	{
		for (new i; i < GetMaxPlayers(); i++)
		{
		    if (IsPlayerConnected(i))
		    {
		        if (Logined[i] == true)
		        {
		            SavePlayer(i);
		        }
		    }
		}
	}
}

public LevelUpTimer()
{
	for (new i; i < GetMaxPlayers(); i++)
	{
	    if (IsPlayerConnected(i))
	    {
	        if (Logined[i] == true)
	        {
	            new expneed = 100 + ((300 * (PlayerInfo[i][pLevel] - 1)));
	            if (PlayerInfo[i][pEXP] >= expneed)
	            {
					PlayerInfo[i][pLevel] ++;
					PlayerInfo[i][pEXP] -= expneed;
					SendClientMessage(i, -1, "레벨 업!");
	            }
	        }
	    }
	}
}

public s0beit(playerid)
{
    new Float:x, Float:y, Float:z;
	GetPlayerCameraFrontVector(playerid, x, y, z);
	#pragma unused x
	#pragma unused y
	new bool:detected = false;
	if (z < -0.7)
	{
	    detected = true;
	}
	else
	{
	    detected = false;
	}
	if (detected == true) // detected
	{
	    SendClientMessage(playerid, -1, "s0beit detected.");
	    s0beit_Passed[playerid] = 1;
	}
	else if (detected == false) // not detected
	{
	    SendClientMessage(playerid, -1, "s0beit not detected.");
	    s0beit_Passed[playerid] = 2;
	}
	SpawnPlayer(playerid);
}
//------------------------------------------------------------------------------
main()
{
	print(" ");
}
//------------------------------------------------------------------------------
public OnGameModeInit()
{
	SetGameModeText("MMORPG TEST");
	ShowPlayerMarkers(1);
	ShowNameTags(0);
	AutoSave = false;
	for (new a; a < MAX_ACTORS; a++)
	{
		if (ActorInfo[a][aModel] > 0)
		{
		    CreateActor(ActorInfo[a][aModel], ActorInfo[a][aPos][0], ActorInfo[a][aPos][1], ActorInfo[a][aPos][2], ActorInfo[a][aPos][3]);
		    new actortag[64]; format(actortag, 64, "%s\n%s", ActorInfo[a][aName], ActorInfo[a][aSub]);
	        ActorTag[a] = Create3DTextLabel(actortag, -1, ActorInfo[a][aPos][0], ActorInfo[a][aPos][1], ActorInfo[a][aPos][2] + 1.5000, 20.0000, 0, 0);
	        SetActorInvulnerable(a, true);
        }
	}
	SetTimer("AutoSaveTimer", 30000, 1);
	SetTimer("LevelUpTimer", 1000, 1);
	return 1;
}


public OnPlayerConnect(playerid)
{
	strmid(PlayerInfo[playerid][pPassword], "", 0, 24, 24);
	PlayerInfo[playerid][pTutorial] = 0;
	PlayerInfo[playerid][pLevel] = 1;
	PlayerInfo[playerid][pEXP] = 0;
	strmid(PlayerInfo[playerid][pNickname], "None", 0, 24, 24);
	PlayerInfo[playerid][pAdminLevel] = 0;
	PlayerInfo[playerid][pPos][0] = 0.0000;
	PlayerInfo[playerid][pPos][1] = 0.0000;
	PlayerInfo[playerid][pPos][2] = 0.0000;
	PlayerInfo[playerid][pPos][3] = 0.0000;
	PlayerInfo[playerid][pInterior] = 0;
	PlayerInfo[playerid][pWorld] = 0;
	PlayerInfo[playerid][pJob] = 0;
	for (new i; i < MAX_PLAYER_INVENTORIES; i++)
	{
	    PlayerInventoryInfo[playerid][i][piItemID] = -1;
	    PlayerInventoryInfo[playerid][i][piItemAmount] = -1;
	}
	for (new i; i < 19; i++)
	{
	    PlayerEquipmentInfo[playerid][i][peItemID] = -1;
	}

	Account[playerid] = false;
	Logined[playerid] = false;
	s0beit_Passed[playerid] = 0;

	PlayerLabel[playerid] = Create3DTextLabel(" ", 0xFFFFFFFF, 0.0000, 0.0000, 0.0000, 15.0000, 0, 0);

	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	new file[256];
	format(file, 256, "Userfiles/%s.ini", playername);
	if (INI_Exist(file))
	    Account[playerid] = true;
	else
		Account[playerid] = false;
	
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	Delete3DTextLabel(PlayerLabel[playerid]);
	PlayerLabel[playerid] = Text3D:INVALID_3DTEXT_ID;
	if (Logined[playerid] == true)
	{
	    SavePlayer(playerid);
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetCameraBehindPlayer(playerid);
	if (s0beit_Passed[playerid] == 0)
	{
	    TogglePlayerControllable(playerid, 0);
	    SetTimerEx("s0beit", 5000, 0, "i", playerid);
	}
	else if (s0beit_Passed[playerid] == 1)
	{
	    TogglePlayerControllable(playerid, 1);
	    Kick(playerid);
	}
	else if (s0beit_Passed[playerid] == 2)
	{
	    if (PlayerInfo[playerid][pTutorial] == 0)
	    {
	        TogglePlayerControllable(playerid, 0);
	        ShowPlayerDialog(
				playerid,
				DIALOG_SET_NICKNAME,
				DIALOG_STYLE_INPUT,
				"닉네임 설정",
				"\
					당신의 닉네임을 입력해주세요.\n\
					영어, 한글, 특수문자 등 모두 사용할 수 있습니다.\
				",
				"확인",
				""
			);
	    }
	    else
		{
		    TogglePlayerControllable(playerid, 1);
		    if (PlayerInfo[playerid][pPos][0] == 0.0000 &&
		        PlayerInfo[playerid][pPos][1] == 0.0000 &&
		        PlayerInfo[playerid][pPos][2] == 0.0000 &&
		        PlayerInfo[playerid][pPos][3] == 0.0000)
			{
		    	SetPlayerPos(playerid, 1777.6136, -1774.3833, 52.4688);
		    	SetPlayerFacingAngle(playerid, 0.0000);
		    	SetPlayerInterior(playerid, 0);
		    	SetPlayerVirtualWorld(playerid, 0);
		    }
		    else
		    {
		        SetPlayerPos(
		            playerid,
		            PlayerInfo[playerid][pPos][0],
		            PlayerInfo[playerid][pPos][1],
		            PlayerInfo[playerid][pPos][2]
				);
				SetPlayerFacingAngle(
				    playerid,
				    PlayerInfo[playerid][pPos][3]
				);
		    	SetPlayerInterior(playerid, PlayerInfo[playerid][pInterior]);
		    	SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pWorld]);
		    }
	    }
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if (Logined[playerid] == false)
	{
	    SendClientMessage(playerid, -1, "로그인을 먼저 해야합니다.");
	    return 0;
	}
	new str[1024];
	format(str, 1024, "[대화] %s: %s", PlayerInfo[playerid][pNickname], text);
	new Float:X,
	    Float:Y,
	    Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	SendCloseMessage(X, Y, Z, 15.0000, -1, str);
	/*
 	for (new i; i < GetMaxPlayers(); i++)
	{
	    if (Logined[i] == true)
	    {
			if (IsPlayerInRangeOfPoint(i, 15.0000, X, Y, Z))
			{
				SendClientMessage(i, -1, str);
			}
	    }
	}
	*/
	return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256], tmp[256], idx;
	new str[1024];
	cmd = strtok(cmdtext, idx);
	if (Logined[playerid] == false)
	{
	    return SendClientMessage(playerid, -1, "로그인을 먼저 해야합니다.");
	}
	if (strcmp(cmd, "/관리자임명", true) == 0)
	{
		if (!IsPlayerAdmin(playerid))
		{
		    SendClientMessage(playerid, -1, "권한 없음");
		    return 1;
		}
	
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
		    SendClientMessage(playerid, -1, "/관리자임명 [플레이어 번호] [레벨]");
		    return 1;
		}
		new targetid = strval(tmp);
		if (!IsPlayerConnected(targetid))
		{
		    SendClientMessage(playerid, -1, "오프라인");
		    return 1;
		}
		
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
		    SendClientMessage(playerid, -1, "/관리자임명 [플레이어 번호] [레벨]");
		    return 1;
		}
		new level = strval(tmp);
		if (level < 0)
		{
		    SendClientMessage(playerid, -1, "0 이상");
		    return 1;
		}

		PlayerInfo[targetid][pAdminLevel] = level;
		SavePlayer(targetid);
		format(str, 1024, "당신은 %s(을)를 관리자로 만들었습니다.", PlayerName(targetid));
		SendClientMessage(playerid, -1, str);
		format(str, 1024, "당신은 %s에 의해 관리자가 되었습니다.", PlayerName(playerid));
		SendClientMessage(targetid, -1, str);
		return 1;
	}
	if (strcmp(cmd, "/리붓", true) == 0)
	{
		SendRconCommand("gmx");
		return 1;
	}
	if (strcmp(cmd, "/내정보", true) == 0)
	{
		ShowStats(playerid);
	    return 1;
	}
	if (strcmp(cmd, "/인벤토리", true) == 0)
	{
		ShowInventoryForPlayer(playerid, playerid);
	    return 1;
	}
	if (strcmp(cmd, "/액터로", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
		    SendClientMessage(playerid, -1, "/액터로 [액터 번호]");
		    return 1;
		}
		new actorid = strval(tmp);
		if (IsValidActor(actorid))
		{
		    new Float:X,
		        Float:Y,
		        Float:Z;
			GetActorPos(actorid, X, Y, Z);
			SetPlayerPos(playerid, X + 1, Y + 1, Z);
			return 1;
		}
		else
		{
		    return 1;
		}
	}
	if (strcmp("/자동저장", cmdtext, true) == 0)
	{
		if (PlayerInfo[playerid][pAdminLevel] == 2)
		{
		    if (AutoSave == false)
			{
				AutoSave = true;
				SendClientMessage(playerid, -1, "자동 저장 On");
			}
			else
			{
			    AutoSave = false;
			    SendClientMessage(playerid, -1, "자동 저장 Off");
			}
			return 1;
		}
		SendClientMessage(playerid, -1, "권한이 없습니다.");
		return 1;
	}
	if (strcmp(cmd, "/소환", true) == 0)
	{
	    if (PlayerInfo[playerid][pAdminLevel] > 0)
	    {
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/소환 [플레이어 번호]");
			    return 1;
			}
			new targetid = strval(tmp);
			if (!IsPlayerConnected(targetid))
			{
			    SendClientMessage(playerid, -1, "오프라인입니다.");
			    return 1;
			}
			if (targetid == playerid)
			{
			    SendClientMessage(playerid, -1, "자기 자신을 소환할 수 없습니다.");
			    return 1;
			}
		    format(str, 1024, "당신은 %s(을)를 소환했습니다.", PlayerName(targetid));
		    SendClientMessage(playerid, -1, str);
		    format(str, 1024, "관리자 %s(이)가 당신을 소환했습니다.", PlayerName(playerid));
		    SendClientMessage(targetid, -1, str);
		    new Float:X,
		        Float:Y,
		        Float:Z,
				Float:Angle;
			GetPlayerFrontPos(playerid, 1.0000, X, Y, Z);
			GetPlayerFacingAngle(playerid, Angle);
			SetPlayerPos(targetid, X, Y, Z);
			SetPlayerFacingAngle(targetid, Angle - 180.0000);
			SetPlayerInterior(targetid, GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));
		    return 1;
	    }
	}
	if (strcmp(cmd, "/킥", true) == 0)
	{
	    if (PlayerInfo[playerid][pAdminLevel] > 0)
	    {
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/킥 [플레이어 번호]");
			    return 1;
			}
			new targetid = strval(tmp);
			if (IsPlayerConnected(targetid))
			{
			    format(str, 1024, "당신은 %s(을)를 킥했습니다.", PlayerName(targetid));
			    SendClientMessage(playerid, -1, str);
			    format(str, 1024, "당신은 %s에 의해 킥당했습니다.", PlayerName(playerid));
			    SendClientMessage(targetid, -1, str);
				format(str, 1024, "%s kicked %s.", PlayerName(playerid), PlayerName(targetid));
				KickLog(str);
				Kick(targetid);
			    return 1;
			}
	    }
	}
	if (strcmp(cmd, "/밴", true) == 0)
	{
	    if (PlayerInfo[playerid][pAdminLevel] == 2)
	    {
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/밴 [플레이어 번호]");
			    return 1;
			}
			new targetid = strval(tmp);
			if (IsPlayerConnected(targetid))
			{
			    format(str, 1024, "당신은 %s(을)를 밴했습니다.", PlayerName(targetid));
			    SendClientMessage(playerid, -1, str);
			    format(str, 1024, "당신은 %s에 의해 밴당했습니다.", PlayerName(playerid));
			    SendClientMessage(targetid, -1, str);
				format(str, 1024, "%s baned %s.", PlayerName(playerid), PlayerName(targetid));
				BanLog(str);
				Ban(targetid);
			    return 1;
			}
	    }
	}
	if (strcmp(cmd, "/닉네임변경", true) == 0)
	{
	    if (PlayerInfo[playerid][pAdminLevel] > 0)
	    {
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/닉네임변경 [플레이어 번호] [닉네임]");
			    return 1;
			}
			new targetid = strval(tmp);
			if (!IsPlayerConnected(targetid))
			{
			    SendClientMessage(playerid, -1, "오프라인");
			    return 1;
			}

			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/닉네임변경 [플레이어 번호] [닉네임]");
				return 1;
			}
			if (strlen(tmp) > MAX_PLAYER_NAME)
			{
			    SendClientMessage(playerid, -1, "너무 긴 닉네임");
			    return 1;
			}
			new old_nick_file[256];
			format(old_nick_file, 256, "UserNickName/%s.ini", PlayerInfo[targetid][pNickname]);
	        new new_nick_file[256];
	        format(new_nick_file, 256, "UserNickName/%s.ini", tmp);
	        if (!INI_Exist(new_nick_file))
	        {

				strmid(PlayerInfo[targetid][pNickname], tmp, 0, 24, 24);
				SavePlayer(targetid);

				fremove(old_nick_file);

	            INI_Open(new_nick_file, Write);
	            INI_Close();

			    format(str, 1024, "당신은 %s의 닉네임을 %s(으)로 바꾸었습니다.", PlayerName(targetid), tmp);
			    SendClientMessage(playerid, -1, str);
			    format(str, 1024, "당신은 관리자 %s에 의해 닉네임이 %s(으)로 바뀌었습니다.", PlayerName(playerid), tmp);
			    SendClientMessage(targetid, -1, str);

				return 1;
			}
			else
			{
			    // 이미 있는 닉네임
			    return 1;
			}
		}
	}
	if (strcmp(cmd, "/직업설정", true) == 0)
	{
	    if (PlayerInfo[playerid][pAdminLevel] > 0)
	    {
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/직업설정 [플레이어 번호] [직업 번호]");
			    return 1;
			}
			new targetid = strval(tmp);
			if (!IsPlayerConnected(targetid))
			{
			    SendClientMessage(playerid, -1, "오프라인");
			    return 1;
			}

			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/직업설정 [플레이어 번호] [직업 번호]");
				return 1;
			}
			new jobid = strval(tmp);
			if (jobid < 0)
			{
			    SendClientMessage(playerid, -1, "0 이상");
			    return 1;
			}

			PlayerInfo[targetid][pJob] = jobid;
			SavePlayer(targetid);

		    format(str, 1024, "당신은 %s의 직업을 %s(으)로 바꾸었습니다.", PlayerName(targetid), GetJobName(jobid));
		    SendClientMessage(playerid, -1, str);
		    format(str, 1024, "당신은 관리자 %s에 의해 직업이 %s(으)로 바뀌었습니다.", PlayerName(playerid), GetJobName(jobid));
		    SendClientMessage(targetid, -1, str);

			return 1;
		}
	}
	if (strcmp(cmd, "/레벨설정", true) == 0)
	{
	    if (PlayerInfo[playerid][pAdminLevel] > 0)
	    {
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/레벨설정 [플레이어 번호] [경험치]");
			    return 1;
			}
			new targetid = strval(tmp);
			if (!IsPlayerConnected(targetid))
			{
			    SendClientMessage(playerid, -1, "오프라인");
			    return 1;
			}

			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/레벨설정 [플레이어 번호] [경험치]");
				return 1;
			}
			new level = strval(tmp);
			if (level < 1)
			{
			    SendClientMessage(playerid, -1, "1 이상");
			    return 1;
			}

			PlayerInfo[targetid][pLevel] = level;
			SavePlayer(targetid);

		    format(str, 1024, "당신은 %s의 레벨을 %d(으)로 바꾸었습니다.", PlayerName(targetid), level);
		    SendClientMessage(playerid, -1, str);
		    format(str, 1024, "당신은 관리자 %s에 의해 레벨이 %d(으)로 바뀌었습니다.", PlayerName(playerid), level);
		    SendClientMessage(targetid, -1, str);
			
			return 1;
		}
	}
	if (strcmp(cmd, "/돈주기", true) == 0)
	{
	    if (PlayerInfo[playerid][pAdminLevel] > 0)
	    {
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/돈주기 [플레이어 번호] [돈]");
			    return 1;
			}
			new targetid = strval(tmp);
			if (!IsPlayerConnected(targetid))
			{
			    SendClientMessage(playerid, -1, "오프라인");
			    return 1;
			}

			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/돈주기 [플레이어 번호] [돈]");
				return 1;
			}
			new money = strval(tmp);
			if (money < 1)
			{
			    SendClientMessage(playerid, -1, "1 이상");
			    return 1;
			}

			GivePlayerMoney(targetid, money);
			SavePlayer(targetid);

			return 1;
		}
	}
	if (strcmp(cmd, "/경험치설정", true) == 0)
	{
	    if (PlayerInfo[playerid][pAdminLevel] > 0)
	    {
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/경험치설정 [플레이어 번호] [경험치]");
			    return 1;
			}
			new targetid = strval(tmp);
			if (!IsPlayerConnected(targetid))
			{
			    SendClientMessage(playerid, -1, "오프라인");
			    return 1;
			}

			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/경험치설정 [플레이어 번호] [경험치]");
				return 1;
			}
			new exp = strval(tmp);
			if (exp < 0)
			{
			    SendClientMessage(playerid, -1, "0 이상");
			    return 1;
			}

			PlayerInfo[targetid][pEXP] = exp;
			SavePlayer(targetid);

		    format(str, 1024, "당신은 %s의 경험치를 %d(으)로 바꾸었습니다.", PlayerName(targetid), exp);
		    SendClientMessage(playerid, -1, str);
		    format(str, 1024, "당신은 관리자 %s에 의해 경험치가 %d(으)로 바뀌었습니다.", PlayerName(playerid), exp);
		    SendClientMessage(targetid, -1, str);

			return 1;
		}
	}
	if (strcmp(cmd, "/체력", true) == 0)
	{
	    if (PlayerInfo[playerid][pAdminLevel] > 0)
	    {
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/체력 [플레이어 번호] [체력]");
			    return 1;
			}
			new targetid = strval(tmp);
			if (!IsPlayerConnected(targetid))
			{
			    SendClientMessage(playerid, -1, "오프라인");
			    return 1;
			}

			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
			    SendClientMessage(playerid, -1, "/체력 [플레이어 번호] [체력]");
				return 1;
			}
			new Float:health = floatstr(tmp);
			if (health < 0.0)
			{
			    SendClientMessage(playerid, -1, "0 이상");
			    return 1;
			}

			SetPlayerHealth(targetid, health);

		    format(str, 1024, "당신은 %s의 체력을 %.1f(으)로 바꾸었습니다.", PlayerName(targetid), health);
		    SendClientMessage(playerid, -1, str);
		    format(str, 1024, "관리자 %s(이)가 당신의 체력을 %.1f(으)로 바꾸었습니다.", PlayerName(playerid), health);
		    SendClientMessage(targetid, -1, str);

			return 1;
		}
	}
	if (strcmp(cmd, "/저장", true) == 0)
	{
		SavePlayer(playerid);
		SavePlayerInventories(playerid);
		SavePlayerEquipments(playerid);
		SendClientMessage(playerid, -1, "저장되었습니다.");
	    return 1;
	}
	if (strcmp(cmd, "/메뉴", true) == 0)
	{
	    ShowMenu(playerid);
	    return 1;
	}
	format(str, 1024, "[알림] \"%s\"라는 명령어는 존재하지 않습니다.", cmdtext);
	return SendClientMessage(playerid, -1, str);
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	if (Logined[playerid] == false)
	{
	    if (Account[playerid] == true)
		    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Enter your password.", "OK", "Cancel");
		else
		    ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Register", "Enter your password.", "OK", "Cancel");
	}
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (Logined[playerid] == false)
	{
	    return 1;
	}
	if (newkeys == KEY_YES)
	{
	    ShowMenu(playerid);
	    return 1;
	}
	if (newkeys == KEY_SECONDARY_ATTACK)
	{
	    new actor_index = GetCloseActorID(playerid);
	    if (actor_index != -1)
	    {
	        SetCameraBehindPlayer(playerid);
	        TalkingActor[playerid] = actor_index;
	        new
				Float:X,
				Float:Y,
				Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
	        SetActorLookAt(actor_index, X, Y);
	        new caption[64]; format(caption, 64, "%s(와)과의 대화", ActorInfo[actor_index][aName]);
	        new string[1024]; format(string, 1024, "[대화] %s: ", ActorInfo[actor_index][aName]);
	        switch (actor_index)
	        {
				case 0: // 앨리스
				{
					strcat(string, "나를 찾은 이유가 뭐죠?");
					SendClientMessage(playerid, -1, string);
				    ShowPlayerDialog(playerid, DIALOG_SCRIPT_1, DIALOG_STYLE_LIST, caption, "당신과 할 말이 있어요.\n난 당신을 찾지 않았어요.", "선택", "나가기");
				}
				case 1: // 백우
				{
					strcat(string, "이병, 조백우!");
					SendClientMessage(playerid, -1, string);
				    ShowPlayerDialog(playerid, DIALOG_SCRIPT_4, DIALOG_STYLE_LIST, caption, "수고해라.\n(무시한다.)", "선택", "나가기");
				}
				case 2: // 보겸
				{
					strcat(string, "무엇을 도와드릴까요?");
					SendClientMessage(playerid, -1, string);
				    ShowPlayerDialog(playerid, DIALOG_SCRIPT_5, DIALOG_STYLE_LIST, caption, "창고를 이용하려구요.\n아무 일도 아닙니다.", "선택", "나가기");
				}
				case 3: // 잭슨
				{
					strcat(string, "무엇을 도와드릴까요?");
					SendClientMessage(playerid, -1, string);
				    ShowPlayerDialog(playerid, DIALOG_SCRIPT_6, DIALOG_STYLE_LIST, caption, "저는 치료가 필요해요.\n아무 일도 아닙니다.", "선택", "나가기");
				}
				case 4: // 호진
				{
					strcat(string, "무엇을 도와드릴까요?");
					SendClientMessage(playerid, -1, string);
				    ShowPlayerDialog(playerid, DIALOG_SCRIPT_7, DIALOG_STYLE_LIST, caption, "뭘 팔고 계신지 알 수 있을까요?.\n아무 일도 아닙니다.", "선택", "나가기");
				}
				case 5: // 홍주
				{
					strcat(string, "무엇을 도와드릴까요?");
					SendClientMessage(playerid, -1, string);
				    ShowPlayerDialog(playerid, DIALOG_SCRIPT_8, DIALOG_STYLE_LIST, caption, "뭘 팔고 계신지 알 수 있을까요?.\n아무 일도 아닙니다.", "선택", "나가기");
				}
				default:
				{
				    TalkingActor[playerid] = -1;
				}
			}
	    }
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	if (Logined[playerid] == false)
	{
	    return 1;
	}
	if (s0beit_Passed[playerid] != 2)
	{
	    return 1;
	}
	new str[1024];
    format(str, 128, "%s", PlayerInfo[playerid][pNickname]);
	Update3DTextLabelText(PlayerLabel[playerid], -1, str);
	Attach3DTextLabelToPlayer(PlayerLabel[playerid], playerid, 0, 0, 0.3);
	if (GetPlayerWeapon(playerid) != PlayerEquipedWeapon[playerid])
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, PlayerEquipedWeapon[playerid], 99999);
	}
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
//------------------------------------------------------------------------------
	if (dialogid == DIALOG_REGISTER)
	{
	    if (response)
	    {
		    if (!strlen(inputtext))
		    {
		        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "가입", "패스워드를 입력해주세요.", "OK", "Cancel");
		        return 1;
		    }
		    else if (strlen(inputtext) < 4 || strlen(inputtext) > 24)
		    {
		        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "가입", "패스워드를 입력해주세요.", "OK", "Cancel");
		        return 1;
			}
		    else
		    {
		        new playername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
				new file[256];
				format(file, 256, "Userfiles/%s.ini", playername);
				if (!INI_Exist(file))
				{
				    RegisterPlayer(playerid, inputtext);
				    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "로그인", "패스워드를 입력해주세요.", "OK", "Cancel");
				    return 1;
				}
				else
				{
				    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "로그인", "패스워드를 입력해주세요.", "OK", "Cancel");
				    return 1;
				}
		    }
	    }
	    else
	    {
	        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "가입", "패스워드를 입력해주세요.", "OK", "Cancel");
			return 1;
	    }
	}
	if (dialogid == DIALOG_LOGIN)
	{
	    if (response)
	    {
		    if (!strlen(inputtext))
		    {
		        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "로그인", "패스워드를 입력해주세요.", "OK", "Cancel");
		        return 1;
		    }
		    else
		    {
		        new playername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
				new file[256];
				format(file, 256, "Userfiles/%s.ini", playername);
				if (INI_Exist(file))
				{
				    INI_Open(file, Read);
		        	if (strcmp(inputtext, INI_Read("Password"), true) == 0)
		        	{
		        	    Logined[playerid] = true;
		        	    LoadPlayer(playerid);
		        	    LoadPlayerInventories(playerid);
		        	    LoadPlayerEquipments(playerid);
		        	    SetSpawnInfo(playerid, 0, 0, 0.0000, 0.0000, 0.0000, 0.0000, 0, 0, 0, 0, 0, 0);
		        	    SpawnPlayer(playerid);
		        	    SetPlayerColor(playerid, 0xFFFFFFFF);
		        	}
		        	else
		        	{
	                    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "로그인", "패스워드를 입력해주세요.", "OK", "Cancel");
		        	}
		        	INI_Close();
		        	return 1;
				}
				else
				{
				    ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "가입", "패스워드를 입력해주세요.", "OK", "Cancel");
				    return 1;
				}
			}
		}
	}
	if (dialogid == DIALOG_SET_NICKNAME)
	{
		if (response)
		{
		    if (!strlen(inputtext))
		    {
		        ShowPlayerDialog(
					playerid,
					DIALOG_SET_NICKNAME,
					DIALOG_STYLE_INPUT,
					"닉네임 설정",
					"\
						당신의 닉네임을 입력해주세요.\n\
						영어, 한글, 특수문자 등 모두 사용할 수 있습니다.\
					",
					"확인",
					""
				);
		        return 1;
		    }
		    else
		    {
		        new file[256];
		        format(file, 256, "UserNickName/%s.ini", inputtext);
		        if (!INI_Exist(file))
		        {
		            INI_Open(file, Write);
		            INI_Close();
					strmid(PlayerInfo[playerid][pNickname], inputtext, 0, 24, 24);
					PlayerInfo[playerid][pTutorial] = 1;
					SpawnPlayer(playerid);
					SavePlayer(playerid);
		        }
				else
				{
				    ShowPlayerDialog(
						playerid,
						DIALOG_SET_NICKNAME,
						DIALOG_STYLE_INPUT,
						"닉네임 설정",
						"\
							당신의 닉네임을 입력해주세요.\n\
							영어, 한글, 특수문자 등 모두 사용할 수 있습니다.\n\
							이미 존재하는 닉네임입니다.\
						",
						"확인",
						""
					);
				}
		    }
		}
		else
		{
	        ShowPlayerDialog(
				playerid,
				DIALOG_SET_NICKNAME,
				DIALOG_STYLE_INPUT,
				"닉네임 설정",
				"\
					당신의 닉네임을 입력해주세요.\n\
					영어, 한글, 특수문자 등 모두 사용할 수 있습니다.\
				",
				"확인",
				""
			);
		    return 1;
		}
	}
//------------------------------------------------------------------------------
	if (dialogid == DIALOG_MENU)
	{
	    if (response)
	    {
	        if (listitem == 0)
	        {
	            ShowStats(playerid);
	        }
	        else if (listitem == 1)
	        {
	            ShowInventoryForPlayer(playerid, playerid);
	        }
	        else if (listitem == 2)
	        {
	            ShowEquipments(playerid);
	        }
	    }
     	return 1;
	}
	if (dialogid == DIALOG_STATS)
	{
	    if (response)
	    {
	        return 1;
	    }
	    else
	    {
	        return 1;
	    }
	}
	if (dialogid == DIALOG_SELLLIST)
	{
		if (response)
		{
			new tmp[256], string[256];
            format(tmp, 256, "BuyItemListID_%d", listitem);
            new itemid = GetPVarInt(playerid, tmp);
            for (new j; j < sizeof(ItemInfo); j++)
            {
				format(tmp, 256, "BuyItemListID_%d", j);
				DeletePVar(playerid, tmp);
            }
            if (GetPlayerMoney(playerid) >= ItemInfo[itemid][itPrice])
            {
				GivePlayerItem(playerid, itemid, 1);
				GivePlayerMoney(playerid, - ItemInfo[itemid][itPrice]);
				SavePlayerInventories(playerid);
			    format(string, 256, "[알림] 당신은 아이템 %s(을)를 $%d의 가격으로 구매했습니다.", ItemInfo[itemid][itName], ItemInfo[itemid][itPrice]);
				SendClientMessage(playerid, -1, string);
			}
			else
			{
			    format(string, 256, "[알림] 아이템 %s(을)를 구매할 돈이 없습니다.", ItemInfo[itemid][itName]);
				SendClientMessage(playerid, -1, string);
			}
			ShowSellList(playerid, BuyingItemType[playerid]);
			return 1;
		}
		else
		{
		    BuyingItemType[playerid] = ITEM_TYPE_NONE;
			return 1;
		}
	}
	if (dialogid == DIALOG_INVENTORY)
	{
		if (response)
		{
			new tmp[256];
            format(tmp, 256, "InventoryListID_%d", listitem);
            new pi_index = GetPVarInt(playerid, tmp);
            for (new j; j < MAX_PLAYER_INVENTORIES; j++)
            {
				format(tmp, 256, "InventoryListID_%d", j);
				DeletePVar(playerid, tmp);
            }
			new itemid = PlayerInventoryInfo[playerid][pi_index][piItemID];
			if (itemid == -1)
			{
			    SendClientMessage(playerid, -1, "아이템이 없습니다!");
			}
			else
			{
				if (ItemInfo[itemid][itType] == ITEM_TYPE_CONSUME)
				{
				    if (PlayerInventoryInfo[playerid][pi_index][piItemAmount] > 0)
				    {
					    PlayerInventoryInfo[playerid][pi_index][piItemAmount] --;
					    SendClientMessage(playerid, -1, "아이템을 사용하였습니다!");
				    }
					if (PlayerInventoryInfo[playerid][pi_index][piItemAmount] == 0)
					{
					    PlayerInventoryInfo[playerid][pi_index][piItemID] = -1;
					    SendClientMessage(playerid, -1, "아이템을 모두 사용하였습니다!");
					}
					//----------------------------------------------------------
					if (itemid == 0)
					{
						new Float:health;
						GetPlayerHealth(playerid, health);
						health += 10;
						SetPlayerHealth(playerid, health);
					}
					else if (itemid == 1)
					{
						new Float:health;
						GetPlayerHealth(playerid, health);
						health += 30;
						SetPlayerHealth(playerid, health);
					}
					else if (itemid == 3)
					{
						new Float:health;
						GetPlayerHealth(playerid, health);
						health += 50;
						SetPlayerHealth(playerid, health);
					}
					//----------------------------------------------------------
				}
				else if (ItemInfo[itemid][itType] == ITEM_TYPE_EQUIPMENT)
				{
					new boneid = -1;
					/*
					boneid
						0 무기
						1 ~ 18 방어구
					*/
					switch (itemid)
					{
						case 2: boneid = 0;
						case 4: boneid = 0;
					}
				    if (PlayerEquipmentInfo[playerid][boneid][peItemID] != -1)
				    {
				        SendClientMessage(playerid, -1, "이미 그 곳에 장비를 장착하고 있습니다.");
				    }
				    else
				    {
					    if (PlayerInventoryInfo[playerid][pi_index][piItemAmount] > 0)
					    {
						    PlayerInventoryInfo[playerid][pi_index][piItemAmount] --;
						    SendClientMessage(playerid, -1, "장비를 장착하였습니다!");
					    }
						if (PlayerInventoryInfo[playerid][pi_index][piItemAmount] == 0)
						{
						    PlayerInventoryInfo[playerid][pi_index][piItemID] = -1;
						}
						PlayerEquipmentInfo[playerid][boneid][peItemID] = itemid;
						if (boneid == 0)
						{
							switch (itemid)
							{
								case 2: PlayerEquipedWeapon[playerid] = 11;
								case 4: PlayerEquipedWeapon[playerid] = 9;
							}
						}
					}
					SavePlayerEquipments(playerid);
					//----------------------------------------------------------
				}
				else
				{
				    SendClientMessage(playerid, -1, "사용할 수 없는 아이템입니다!");
			    }
		    }
		    ShowInventoryForPlayer(playerid, playerid);
		    return 1;
		}
		else
		{
			return 1;
		}
	}
//------------------------------------------------------------------------------
	if (dialogid == DIALOG_EQUIPMENT)
	{
	    if (response)
	    {
			new boneid = listitem;
			new itemid = PlayerEquipmentInfo[playerid][boneid][peItemID];
			if (itemid == -1)
			{
				SendClientMessage(playerid, -1, "그 곳에 장비를 착용하지 않았습니다.");
			}
			else
			{
			    PlayerEquipmentInfo[playerid][boneid][peItemID] = -1;
			    if (boneid == 0)
			    {
					PlayerEquipedWeapon[playerid] = 0;
					ResetPlayerWeapons(playerid);
			    }
			    else
			    {
			    }
			    GivePlayerItem(playerid, itemid, 1);
			    SavePlayerEquipments(playerid);
			    SendClientMessage(playerid, -1, "장비의 장착을 해제했습니다.");
			}
			ShowEquipments(playerid);
			return 1;
	    }
		else
		{
		    return 1;
		}
	}
//------------------------------------------------------------------------------
	new actor_index = TalkingActor[playerid];
    new caption[64]; format(caption, 64, "%s(와)과의 대화", ActorInfo[actor_index][aName]);
    new actor_msg[1024]; format(actor_msg, 1024, "[대화] %s: ", ActorInfo[actor_index][aName]);
	if (dialogid == DIALOG_SCRIPT_END)
	{
		TalkingActor[playerid] = -1;
		return 1;
	}
	//--------------------------------------------------------------------------
	// 앨리스
	else if (dialogid == DIALOG_SCRIPT_1) // 나를 찾은 이유가 뭐죠?
	{
	    if (response)
	    {
			if (listitem == 0)
	        {
	            strcat(actor_msg, "나에게 하고픈 말이 뭔가요?");
	            SendClientMessage(playerid, -1, actor_msg);
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_2, DIALOG_STYLE_LIST, caption, "난 하고 싶은 일이 있습니다.\n예쁘시네요.", "선택", "나가기");
				return 1;
	        }
	        else
	        {
		        strcat(actor_msg, "그럼 수고해요.");
		        SendClientMessage(playerid, -1, actor_msg);
		        ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
		        return 1;
	        }
		}
        else
        {
	        ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
	        return 1;
        }
	}
	else if (dialogid == DIALOG_SCRIPT_2) // 나에게 하고픈 말이 뭔가요?
	{
	    if (response)
	    {
			if (listitem == 0)
	        {
	            strcat(actor_msg, "무슨 일을 하고 싶다는 거에요?");
	            SendClientMessage(playerid, -1, actor_msg);
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_3, DIALOG_STYLE_LIST, caption, "기사\n당신의 남자친구", "선택", "나가기");
				return 1;
	        }
	        else
	        {
	            strcat(actor_msg, "나도 알고 있어요!");
	            SendClientMessage(playerid, -1, actor_msg);
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
	            return 1;
	        }
		}
        else
        {
	        ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
	        return 1;
        }
	}
	else if (dialogid == DIALOG_SCRIPT_3) // 무슨 일을 하고 싶다는 거에요?
	{
	    if (response)
	    {
			if (listitem == 0) // 기사
	        {
	            if (PlayerInfo[playerid][pJob] == JOB_NONE)
	            {
		            strcat(actor_msg, "당신에게 기본적인 장구류를 주겠어요, 열심히 수련 하도록 해요.");
		            SendClientMessage(playerid, -1, actor_msg);
		            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
		            PlayerInfo[playerid][pJob] = JOB_KNIGHT;
		            SavePlayer(playerid);
					return 1;
				}
				else
				{
		            strcat(actor_msg, "당신은 이미 할 일이 있어보이는군요.");
		            SendClientMessage(playerid, -1, actor_msg);
		            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
				    return 1;
				}
	        }
	        else // 당신의 남자친구
	        {
	            strcat(actor_msg, "어머! *찰싹*");
	            SendClientMessage(playerid, -1, actor_msg);
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
	            return 1;
	        }
		}
        else
        {
	        ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
	        return 1;
        }
	}
//------------------------------------------------------------------------------
	// 백우
	else if (dialogid == DIALOG_SCRIPT_4) // 이병, 조백우!
	{
	    if (response)
	    {
			if (listitem == 0) // 수고해라.
	        {
	            strcat(actor_msg, "알겠습니다!");
	            SendClientMessage(playerid, -1, actor_msg);
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
				return 1;
	        }
	        else // (무시한다.)
	        {
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
	            return 1;
	        }
		}
        else
        {
	        ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
	        return 1;
        }
	}
//------------------------------------------------------------------------------
	// 보겸
	else if (dialogid == DIALOG_SCRIPT_5) // 무엇을 도와드릴까요?
	{
	    if (response)
	    {
			if (listitem == 0) // 창고를 이용하려구요.
	        {
	            strcat(actor_msg, "네.");
	            SendClientMessage(playerid, -1, actor_msg);
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
				return 1;
	        }
	        else // 아무일도 아닙니다.
	        {
	            strcat(actor_msg, "안녕히가세요.");
	            SendClientMessage(playerid, -1, actor_msg);
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
	            return 1;
	        }
		}
        else
        {
	        ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
	        return 1;
        }
	}
//------------------------------------------------------------------------------
	// 잭슨
	else if (dialogid == DIALOG_SCRIPT_6) // 무엇을 도와드릴까요?
	{
	    if (response)
	    {
			if (listitem == 0) // 저는 치료가 필요해요.
	        {
	            new Float:health;
	            GetPlayerHealth(playerid, health);
				if (health == 100.0000)
				{
		            strcat(actor_msg, "당신은 치료할 필요가 없어 보이는걸요.");
		            SendClientMessage(playerid, -1, actor_msg);
		            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
					return 1;
				}
				else
				{
				    SetPlayerHealth(playerid, 100.0000);
		            strcat(actor_msg, "치료해드렸습니다. 안녕히가세요.");
		            SendClientMessage(playerid, -1, actor_msg);
		            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
					return 1;
				}
	        }
	        else // 아무 일도 아닙니다.
	        {
	            strcat(actor_msg, "안녕히가세요.");
	            SendClientMessage(playerid, -1, actor_msg);
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
	            return 1;
	        }
		}
        else
        {
	        ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
	        return 1;
        }
	}
//------------------------------------------------------------------------------
	// 호진
	else if (dialogid == DIALOG_SCRIPT_7) // 무엇을 도와드릴까요?
	{
	    if (response)
	    {
			if (listitem == 0) // 뭘 팔고 계신가요?
	        {
	            strcat(actor_msg, "살펴보세요.");
	            SendClientMessage(playerid, -1, actor_msg);
				TalkingActor[playerid] = -1;
	            ShowSellList(playerid, ITEM_TYPE_CONSUME);
	            BuyingItemType[playerid] = ITEM_TYPE_CONSUME;
				return 1;
	        }
	        else // 아무 일도 아닙니다.
	        {
	            strcat(actor_msg, "아무것도 안 사려면 말 걸지 말아 줄래요?");
	            SendClientMessage(playerid, -1, actor_msg);
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
	            return 1;
	        }
		}
        else
        {
	        ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
	        return 1;
        }
	}
//------------------------------------------------------------------------------
	// 홍주
	else if (dialogid == DIALOG_SCRIPT_8) // 무엇을 도와드릴까요?
	{
	    if (response)
	    {
			if (listitem == 0) // 뭘 팔고 계신가요?
	        {
	            strcat(actor_msg, "살펴보세요.");
	            SendClientMessage(playerid, -1, actor_msg);
				TalkingActor[playerid] = -1;
	            ShowSellList(playerid, ITEM_TYPE_EQUIPMENT);
	            BuyingItemType[playerid] = ITEM_TYPE_EQUIPMENT;
				return 1;
	        }
	        else // 아무 일도 아닙니다.
	        {
	            strcat(actor_msg, "아무것도 안 사려면 말 걸지 말아 줄래요?");
	            SendClientMessage(playerid, -1, actor_msg);
	            ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
	            return 1;
	        }
		}
        else
        {
	        ShowPlayerDialog(playerid, DIALOG_SCRIPT_END, DIALOG_STYLE_MSGBOX, caption, "대화가 끝났습니다.", "확인", "");
	        return 1;
        }
	}
//------------------------------------------------------------------------------
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
