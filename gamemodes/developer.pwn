#include <a_samp>
#include <zcmd>
#include <sscanf2>
#include <foreach>
#include <streamer>

#include "./colors.inc"
#include "./suppressorsystem.inc"
#include "./gaschamber.inc"
#include "./register.inc"
#include "./playerdata.inc"

#define DIALOG_HELP 1
#define DIALOG_SUPPRESSION_HELP 2
#define PRESSED(%0) \
    (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
enum E_pInfo
{
    pID,
    pTruckerjob,
    pGaskey,
    bool:pIsHoldingCrate,
    bool:pIsLoadingCrate,
}
enum E_vehInfo
{
    bool:isTruckerVehicle,
    bool:hasCrate,
}

new VehicleInfo[MAX_VEHICLES][E_vehInfo];
new PlayerInfo[MAX_PLAYERS][E_pInfo];
new pcheckpointTrucker[MAX_PLAYERS];
new engine, lights, alarm, doors, bonnet, boot, objective;

main()
{
    print("\n----------------------------------");
    print(" KRAYS tutorial GM");
    print("----------------------------------\n");
}

public OnGameModeInit()
{
    DisableInteriorEnterExits();

    SetGameModeText("MEEKS Script");
    AddPlayerClass(295, 2638.9114,-2397.3459,13.6328,293.4119, 0, 0, 0, 0, 0, 0);

    CreatePickup(1239, 1, 2637.9236,-2386.4905,13.6328, -1); // TRUCKER JOB
    Create3DTextLabel("Trucker Job\n{FFFFFF}/picktruckerjob\n/quittruckerjob", COLOR_AQUA, 2637.9236,-2386.4905,13.6328, 10.0, 0, 1);

    CreateObject(1271,2650.3015,-2385.5620,13.0328, 0.0, 0.0, 96.0); // Trucker Job BOX 1
    Create3DTextLabel("Trucker Job (Crates)\n{FFFFFF}/pickupcrate\n/loadcrate", COLOR_AQUA, 2650.3015,-2385.5620,13.6328, 10.0, 0, 1);

    CreateObject(11729,2749.5837,-2513.6943,14.6494,183.6465,2.222,0,96.0); // WEAPON SYSTEM LOCKER
    Create3DTextLabel("Restock System (Crates)\n{FFFFFF}/restockweapon", COLOR_AQUA, 2749.5837,-2513.6943,13.6494, 10.0, 0, 1);

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
public OnPlayerEnterCheckpoint(playerid)
{
    if(pcheckpointTrucker[playerid] == 1)
    {
        SetVehicleVelocity(GetPlayerVehicleID(playerid), 0.0, 0.0, 0.0);
        SetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
        SendClientMessage(playerid, COLOR_LAWNGREEN, "Unload the crate and store it inside the garage.");
    }
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

    new resetData[E_pInfo];                 // A dummy viariable for the sole purpose of resetting data //
    PlayerInfo[playerid] = resetData;       // Resets the entire enum //

    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{    
    if(IsPlayerAttachedObjectSlotUsed(playerid, 0)) 
        RemovePlayerAttachedObject(playerid, 0);

    return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    return 1;
 }
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    return 1;
}
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
    return 1;
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

CMD:pickupcrate(playerid, params[])
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

CMD:loadcrate(playerid)
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

CMD:unloadcrate(playerid, params[])
{
    if(!pcheckpointTrucker[playerid])
        return SendClientMessage(playerid, -1, "You do not have an active trucker mission");

    if(!IsPlayerInCheckpoint(playerid))
        return SendClientMessage(playerid, COLOR_RED, "You are not at the checkpoint!");

    new vehicleID;

    vehicleID = GetPlayerVehicleID(playerid);

    PlayerInfo[playerid][pIsHoldingCrate] = true;
    PlayerInfo[playerid][pIsLoadingCrate] = true;
    VehicleInfo[vehicleID][hasCrate] = false;

    RemovePlayerFromVehicle(playerid);

    SetPlayerAttachedObject(playerid, 0, 1271, 6, 0.095999, 0.251999, -0.146999, -116.199989, -20.900005, 79.199981);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
    SendClientMessage(playerid, COLOR_LAWNGREEN, "You have successfully picked up the crate. Get inside the garage!");            

    return 1;        
}

CMD:dropcrate(playerid, params[])
{
    if(!PlayerInfo[playerid][pIsHoldingCrate])
        return SendClientMessage(playerid, -1, "You don't have a crate to drop");

    PlayerInfo[playerid][pIsHoldingCrate] = false;
    RemovePlayerAttachedObject(playerid, 0);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

    SendClientMessage(playerid, COLOR_LAWNGREEN, "You dropped your crate. It broke");

    return 1;
}

CMD:starttruckermission(playerid, params[])
{
    if(!PlayerInfo[playerid][pTruckerjob])
        return SendClientMessage(playerid, COLOR_RED, "You don't have the Trucker Job!");

    new vehID;
    vehID = GetPlayerVehicleID(playerid);
    if(!VehicleInfo[vehID][isTruckerVehicle])
        return SendClientMessage(playerid, COLOR_RED, "You are not in the Boxville!");

    if(VehicleInfo[vehID][hasCrate] == false)
        return SendClientMessage(playerid, COLOR_RED, "You do not have a crate in the back of the Boxville");

    pcheckpointTrucker[playerid] = 1;
    SetPlayerCheckpoint(playerid, 2732.1318,-2508.6350,13.4922, 4.0);
    SendClientMessage(playerid, COLOR_AQUA, "Get to the checkpoint!");

    return 1;
}

CMD:canceltruckermission(playerid, params[])
{
    if(pcheckpointTrucker[playerid] == 1)
    {
        new vehID;

        vehID = GetPlayerVehicleID(playerid);

        pcheckpointTrucker[playerid] = 0;
        DisablePlayerCheckpoint(playerid);
        VehicleInfo[vehID][hasCrate] = false;
        SendClientMessage(playerid, COLOR_LAWNGREEN, "You have cancelled your mission!");
    }
    else
        SendClientMessage(playerid, COLOR_RED, "You don't have a mission to cancel!");
        
    return 1;
}
