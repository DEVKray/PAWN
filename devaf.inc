#include <a_samp>
#include <zcmd>
#include <sscanf2>
#include <foreach>
#include <streamer>

#include "./colors.inc"

#define DIALOG_HELP 0
#define DIALOG_SUPPRESSION_HELP 1


enum E_pInfo
{
	pID,

	pSuppressor,

    pTruckerjob,
    bool:pIsHoldingCrate,
}
enum E_vehInfo
{
    bool:isTruckerVehicle,
    bool:hasCrate,
}

new VehicleInfo[MAX_VEHICLES][E_vehInfo];
new PlayerInfo[MAX_PLAYERS][E_pInfo];

main()
{
	print("\n----------------------------------");
	print(" MEEKS tutorial GM");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
    SetGameModeText("MEEKS Script");
    AddPlayerClass(93, 2638.9114,-2397.3459,13.6328,293.4119, 0, 0, 0, 0, 0, 0);
    
    CreatePickup(1239, 1, 2637.9236,-2386.4905,13.6328, -1);
    Create3DTextLabel("Trucker Job\n{FFFFFF}/picktruckerjob\n/quittruckerjob", COLOR_AQUA, 2637.9236,-2386.4905,13.6328, 10.0, 0, 1);

    CreateObject(1271,2650.3015,-2385.5620,13.0328, 0.0, 0.0, 96.0); // Trucker Job BOX 1
    Create3DTextLabel("Trucker Job (Crates)\n{FFFFFF}/pickupcrate\n/delivercrate", COLOR_AQUA, 2650.3015,-2385.5620,13.6328, 10.0, 0, 1);

    new boxvilleID1, 
        boxvilleID2, 
        boxvilleID3;

    boxvilleID1 = CreateVehicle(498, 2633.7461,-2388.1558,13.6328,174.8025, -1, -1, -1, 0); // Create boxville and store the ID of the vehicle in the variable//
    VehicleInfo[boxvilleID1][isTruckerVehicle] = true;

    boxvilleID2 = CreateVehicle(498, 2628.4966,-2386.9683,13.6328,185.8418, -1, -1, -1, 0); // Create boxville and store the ID of the vehicle in the variable //
    VehicleInfo[boxvilleID2][isTruckerVehicle] = true;

    boxvilleID3 = CreateVehicle(498, 2622.3215,-2387.0586,13.6250,177.8633, -1, -1, -1, 0); // Create boxville and store the ID of the vehicle in the variable //
    VehicleInfo[boxvilleID3][isTruckerVehicle] = true;



    return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER)
    {
        new vehicleID;
        vehicleID = GetPlayerVehicleID(playerid);

        if(VehicleInfo[vehicleID][isTruckerVehicle] == true && PlayerInfo[playerid][pTruckerjob] == 0)          
            RemovePlayerFromVehicle(playerid);
    }

    return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
    PlayerInfo[playerid][pTruckerjob] = 0;
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    new i;
    if(IsPlayerAttachedObjectSlotUsed(playerid, i)) 
    RemovePlayerAttachedObject(playerid, i);
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_HELP:
        {
            if(response)
                return ShowPlayerDialog(playerid, DIALOG_SUPPRESSION_HELP, DIALOG_STYLE_LIST, "Commands", 
                	"Give Colt45\n\
                	Attach Suppressor\n\
                	Deattach Suppressor\n\
                	Give Suppressor\n\
                	Throw Suppressor", "Yes", "Exit");
        }

        case DIALOG_SUPPRESSION_HELP:
        {
            if(response)
            {
                switch(listitem)
                {
                	case 0:
                		return cmd_createcolt45(playerid, "");
                    case 1:
                        return cmd_attachsuppressor(playerid, "");
                    case 2:
                        return cmd_deattachsuppressor(playerid, "");
                    case 3:
                    	return cmd_givemesuppressor(playerid, "");
                    case 4:
                    	return cmd_throwsuppressor(playerid, "");
                }

           }
            else
            	return ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_LIST, "Commands", "Suppressor System", "Continue", "Cancel");
        }
    }
    return 1;
}  

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
//----------------------SUPPRESION SYSTEM--------------------------//
CMD:createcolt45(playerid, params[])
{
	GivePlayerWeapon(playerid, 22, 10);
	SendClientMessage(playerid, COLOR_AQUA, "You have been given a Colt 45");
	return 1;
}

CMD:givemesuppressor(playerid, params[])
{
    PlayerInfo[playerid][pSuppressor]++;
    SendClientMessage(playerid, COLOR_AQUA, "You have successfully gotten yourself a suppressor!");

    return 1; // Ending the CMD //
}

CMD:attachsuppressor(playerid, params[])
{
    if(PlayerInfo[playerid][pSuppressor] < 1) // If the player does not have suppresssor components then
        return SendClientMessage(playerid, COLOR_RED, "You do not have a Suppressor!"); // Show a message that they do not possess the component and exit out of the code. As there is a return. //
 
    if(GetPlayerWeapon(playerid) != 22) // If the weapon equipped is not a colt45
        return SendClientMessage(playerid, COLOR_RED, "You do not have a colt 45 equipped!"); // Then show an error //
 
    // If there was no error and the code reaches till here without encountering any 'return' then execute the main code which gives the silenced weapon. //
 
    GivePlayerWeapon(playerid, 22, -1); // Remove colt45 //
    GivePlayerWeapon(playerid, 23, 10); // Give the silenced wep with 10 ammo

    PlayerInfo[playerid][pSuppressor] = 1; //g_pSuppressor[playerid] = g_pSuppressor[playerid] - 1; // Both of them are same. Reduce 1 from the suppressor component. //

    SendClientMessage(playerid, COLOR_AQUA, "You have successfully attached a Suppressor to your gun"); // Send out a message. And end with return. //  
 
    return 1;
}

CMD:deattachsuppressor(playerid, params[])
{
	if(GetPlayerWeapon(playerid) == 22)
		return SendClientMessage(playerid, COLOR_RED, "You don't have a suppressor on your colt 45!");

	if(GetPlayerWeapon(playerid) != 23)
		return SendClientMessage(playerid, COLOR_RED, "You don't have your colt 45 equipped");

    GivePlayerWeapon(playerid, 22, 10);
    SendClientMessage(playerid, COLOR_AQUA, "You have successfully deattached the Suppressor from your gun");

	return 1;
}	

CMD:throwsuppressor(playerid, params[])
{
	PlayerInfo[playerid][pSuppressor] = 0;
	SendClientMessage(playerid, COLOR_AQUA, "You have sucessfully thrown away your suppressor(s)");

	return 1;
}

CMD:help(playerid)
{
	return ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_LIST, "Commands", "Suppressor System", "Continue", "Cancel");
}

CMD:gotolocker(playerid, params[])
{
    if(IsPlayerInAnyVehicle(playerid))
    {
        new vehID;
        vehID = GetPlayerVehicleID(playerid);        
        printf("%d", vehID);
        SetVehiclePos(vehID, 2734.0359,-2508.3652,13.4922);
    }
    else 
        //SetPlayerPos(playerid, 2734.0359,-2508.3652,13.4922);
        SetPlayerPos(playerid, 2650.3015,-2385.5620,13.6328);

    return 1;
}
CMD:createvehicle(playerid, params[])
{
    new vehicleID;
    if(sscanf(params, "d(411)", vehicleID))
        return SendClientMessage(playerid, -1, "{00BFFF}Usage:{FFFFFF} /createvehicle <vehicle ID>");
    new Float:pPos[3];
    GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
    CreateVehicle(vehicleID, pPos[0], pPos[1], pPos[2], 0.0, -1, -1, -1, 0);
    return 1;
}

CMD:picktruckerjob(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid, 2, 2637.9236,-2386.4905,13.6328))
    {
        PlayerInfo[playerid][pTruckerjob] = 1;
        SendClientMessage(playerid, COLOR_AQUA, "You have successfully picked up the Trucker Job!");
    }
    else
        SendClientMessage(playerid, COLOR_RED, "You are too far away to pick up the Trucker job!");

    return 1;
}

CMD:quittruckerjob(playerid, params[])
{
    if(PlayerInfo[playerid][pTruckerjob] == 1)
    {
        PlayerInfo[playerid][pTruckerjob] = 0;        
        SendClientMessage(playerid, COLOR_AQUA, "You have successfully quit your job!");

        if(IsPlayerInAnyVehicle(playerid))
        {
        	new vehID;
        	vehID = GetPlayerVehicleID(playerid);

        	if(VehicleInfo[vehID][isTruckerVehicle] == true)
        		RemovePlayerFromVehicle(playerid);
        }
    }
    return 1;
}

CMD:pickupcrate(playerid, params)
{
    if(!PlayerInfo[playerid][pTruckerjob])
        return SendClientMessage(playerid, COLOR_RED, "You do not have the Trucker Job to be able to pick up the crate");

    if(!IsPlayerInRangeOfPoint(playerid, 2.0, 2650.3015,-2385.5620,13.6328))
        return SendClientMessage(playerid, COLOR_RED, "You are not near a valid crate!");

    PlayerInfo[playerid][pIsHoldingCrate] = true;

    if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
    	RemovePlayerAttachedObject(playerid, 0);

    SetPlayerAttachedObject(playerid, 0, 1271, 6, 0.095999, 0.251999, -0.146999, -116.199989, -20.900005, 79.199981);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);

    SendClientMessage(playerid, COLOR_AQUA, "You have successfully picked up a crate. Load up the crate into the boxville");
    return 1; 
}

CMD:delivercrate(playerid)
{
	if(!PlayerInfo[playerid][pTruckerjob])
        return SendClientMessage(playerid, COLOR_RED, "Error:{FFFFFF} You do not have the Trucker Job to be able to deliver crates");

    if(!PlayerInfo[playerid][pIsHoldingCrate])
        return SendClientMessage(playerid, COLOR_RED, "Error:{FFFFFF} You do not have a crate with you!");

    new 
    	Float:vehPosX,
    	Float:vehPosY,
    	Float:vehPosZ;

   	for(new i; i < MAX_VEHICLES; i++)
   	{
   		GetVehiclePos(i, vehPosX, vehPosY, vehPosZ);

   		if(IsPlayerInRangeOfPoint(playerid, 5.0, vehPosX, vehPosY, vehPosZ))
   		{
   			if(VehicleInfo[i][isTruckerVehicle] == true)
   			{
   				if(VehicleInfo[i][hasCrate])
   					return SendClientMessage(playerid, COLOR_RED, "Error:{FFFFFF} That vehicle already has a crate in it.");
   				else
   				{
   					PlayerInfo[playerid][pIsHoldingCrate] = false;
   					VehicleInfo[i][hasCrate] = true;

   					RemovePlayerAttachedObject(playerid, 0);
   					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

   					ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.1, 0, 1, 1, 0, 1000, 1);		
   					ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.1, 0, 1, 1, 0, 1000, 1);		

   					return SendClientMessage(playerid, COLOR_AQUA, "Info:{FFFFFF} You stored the crate in the boxville");
   				}
   			}
   		}
   	}

   	SendClientMessage(playerid, COLOR_RED, "Error:{FFFFFF} You are not near the boxvilles.");

	return 1;
}