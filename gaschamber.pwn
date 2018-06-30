#include <a_samp>
#include <zcmd>
#include <sscanf2>
#include <s-art>
#include <adolf.inc>
#include <CA3.inc>

#include "./colors.inc"

#define DIALOG_GAS_CHAMBER 2
#define DIALOG_GAS_CHAMBER_HELP 3
#define PRESSED(%0) \
    (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

enum E_pInfo
{
    pID,
    pGaskey
}

new PlayerInfo[MAX_PLAYERS][E_pInfo];
new vent[8];

public OnFilterScriptInit()
{
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

main()
{
	return 1;
}

public OnGameModeInit()
{
    CreateObject(19305, 299.7220, -140.8922, 1004.5377,0.0, 0.0,96.0); // Keypad GAS CHAMBER
    
    CreatePickup(1239, 1, 2670.8591,-2385.0046,13.8428, -1); // ENTER GAS CHAMBER
    CreatePickup(1239, 1, 305.3502,-141.8437,1004.0625, -1); // ENTER GAS CHAMBER 1
    CreatePickup(1239, 1, 299.9444,-141.8098,1004.0625, -1); // ENTER GAS CHAMBER 2
    CreatePickup(1239, 1, 304.5870,-141.8353,1004.0625, -1); // EXIT GAS CHAMBER 1
    CreatePickup(1239, 1, 299.2122,-141.9145,1004.0547, -1); // EXIT GAS CHAMBER 2
    Create3DTextLabel("Gas Chamber\n{FFFFFF}/enterchamber", COLOR_AQUA, 2670.8591,-2385.0046,13.8428, 10.0, 0, 1);

    CreateArt3(adolf, 1, 286.1103, -135.9860, 1003.3240, 0.0, 0.0, 90.0); 

	return 1;
}

public OnGameModeExit()
{
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
    RemoveBuildingForPlayer(playerid, 18051, 295.7734, -133.4609, 1004.5469, 0.25);
	RemoveBuildingForPlayer(playerid, 18050, 299.9453, -133.9297, 1005.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 1886, 305.7500, -130.6328, 1006.8906, 0.25);
	RemoveBuildingForPlayer(playerid, 18109, 311.0703, -137.4453, 1005.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 18053, 311.3750, -137.4219, 1004.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 18054, 311.3750, -134.7578, 1003.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 2619, 317.3750, -137.1250, 1005.6953, 0.25);

	// Support underneath
	CreateObject(2346, 293.99780, -140.66830, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 293.99350, -142.60310, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 293.99561, -138.04060, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 294.00031, -139.35210, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 293.98941, -136.71941, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 293.99170, -135.39079, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 293.98721, -134.09061, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 293.98419, -132.76511, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 293.98331, -131.45030, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 293.98999, -130.13060, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 293.99011, -128.81261, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 292.33340, -142.37350, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 291.03131, -142.37860, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 289.69241, -142.37489, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 288.36951, -142.37740, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 287.07739, -142.37920, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 285.74359, -142.37950, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 284.41599, -142.37869, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 283.09601, -142.37869, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 281.77039, -142.37801, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 280.45190, -142.37810, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 279.44339, -142.37421, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 279.78030, -141.54370, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 279.78079, -140.22231, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 279.78040, -138.90060, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 279.77979, -137.58369, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 279.77951, -136.26370, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 279.77951, -134.94370, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 279.77829, -133.62370, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 279.77850, -132.30370, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 279.78250, -130.98390, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 279.77951, -129.66370, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 292.22220, -128.13000, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 290.89850, -128.12990, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 289.56000, -128.12891, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 288.26001, -128.13000, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 286.94000, -128.13000, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 285.62061, -128.12531, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 284.29849, -128.12540, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 282.98099, -128.12531, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 281.65680, -128.12520, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 280.34000, -128.12531, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 279.45120, -128.12151, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 294.00247, -141.91711, 1002.81812,   0.00000, 0.00000, 90.00000);
	CreateObject(2346, 292.40219, -128.13000, 1002.81812,   0.00000, 0.00000, 0.00000);
	CreateObject(2346, 279.78030, -141.72369, 1002.81812,   0.00000, 0.00000, 90.00000);
	
	//Ventilation
	CreateObject(2986, 291.03717, -141.65465, 1006.13489,   0.00000, 0.00000, 0.00000);
	CreateObject(2986, 291.14459, -133.19687, 1006.13489,   0.00000, 0.00000, 0.00000);
	CreateObject(2986, 286.70346, -135.37524, 1006.13489,   0.00000, 0.00000, 0.00000);
	CreateObject(2986, 291.02820, -126.81973, 1006.13489,   0.00000, 0.00000, 0.00000);
	CreateObject(2986, 296.75290, -132.72121, 1006.13489,   0.00000, 0.00000, 0.00000);
	CreateObject(2986, 286.47980, -142.68471, 1006.13489,   0.00000, 0.00000, 0.00000);
	CreateObject(2986, 295.38120, -140.29987, 1006.13489,   0.00000, 0.00000, 0.00000);
	CreateObject(2986, 294.84290, -134.80495, 1006.13489,   0.00000, 0.00000, 0.00000);
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(PRESSED(KEY_SECONDARY_ATTACK))
    {
        if(IsPlayerInRangeOfPoint(playerid, 8.0, 299.7220, -140.8922, 1004.5377))
        {
            if(PlayerInfo[playerid][pGaskey] == 0)
            {
                ApplyAnimation(playerid, "HEIST9", "Use_SwipeCard", 10.0, 0, 0, 0, 0, 0);            
                return SendClientMessage(playerid, COLOR_RED, "You do NOT have access to this keypad!");
            }
            else
                ApplyAnimation(playerid, "HEIST9", "Use_SwipeCard", 10.0, 0, 0, 0, 0, 0);            
                return ShowPlayerDialog(playerid, DIALOG_GAS_CHAMBER, DIALOG_STYLE_LIST, "Commands", "Gas Chamber", "Continue", "Cancel");
            }
        }  
    return 1;   
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_GAS_CHAMBER:
        {
            if(response)
                return ShowPlayerDialog(playerid, DIALOG_GAS_CHAMBER, DIALOG_STYLE_LIST, "Gas Chamber",
                    "Start the ventilation\n\
                    Stop the ventilation", "Yes", "Exit");
        }

        case DIALOG_GAS_CHAMBER_HELP:
        {
            if(response)
            {
                switch(listitem)
                {
                    case 0:
                        return cmd_startventilation(playerid, "");
                    case 1:
                        return cmd_stopventilation(playerid, "");
                }
            }
            else
                return ShowPlayerDialog(playerid, DIALOG_GAS_CHAMBER, DIALOG_STYLE_LIST, "Commands", "Gas Chamber", "Continue", "Cancel");
         }
     }
    return 1;
}           
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
CMD:givegaskey(playerid, params[])
{
    PlayerInfo[playerid][pGaskey] = 1;
    SendClientMessage(playerid, COLOR_LAWNGREEN, "You have successfully given yourself the key to the chamber");

    return 1;
}
CMD:removegaskey(playerid, params[])
{
    PlayerInfo[playerid][pGaskey] = 0;
    SendClientMessage(playerid, COLOR_RED, "You have successfully removed your key to the chamber");

    return 1;
}
CMD:enterchamber(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 2.0, 2670.8591,-2385.0046,13.8428))
        return SendClientMessage(playerid, COLOR_RED, "You are not anywhere near the icon!");

    if(PlayerInfo[playerid][pGaskey] == 0)
        return SendClientMessage(playerid, COLOR_RED, "You do not have a keycard to access this door!");
        
    SetPlayerPos(playerid, 314.820983,-141.431991,999.601562);
    SetPlayerVirtualWorld(playerid, 1);
    SetPlayerInterior(playerid, 7);

    return 1;
}
CMD:enter(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid, 5.0, 305.3514,-141.7746,1004.0625))
    {
        SetPlayerPos(playerid, 304.5793,-141.9770,1004.0625);
        SetPlayerInterior(playerid, 7);
        SetPlayerVirtualWorld(playerid, 1);
    }
    if(IsPlayerInRangeOfPoint(playerid, 2.0, 299.9444,-141.8098,1004.0625))
    {
        SetPlayerPos(playerid, 297.9444,-141.8098,1004.0625);
        SetPlayerInterior(playerid, 7);
        SetPlayerVirtualWorld(playerid, 1);
    }
    return 1;
}
CMD:exit(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid, 2.0, 303.3502,-141.8437,1004.0625))
    {
        SetPlayerPos(playerid, 305.3502,-141.8437,1004.0625);
        SetPlayerInterior(playerid, 7);
        SetPlayerVirtualWorld(playerid, 1);
    }
    if(IsPlayerInRangeOfPoint(playerid, 2.0, 299.2122,-141.9145,1004.0547))
    {
        SetPlayerPos(playerid, 299.9444,-141.8098,1004.0625);
        SetPlayerInterior(playerid, 7);
        SetPlayerVirtualWorld(playerid, 1);
    }
    return 1;
}
CMD:tpgas(playerid, params[])
{
    SetPlayerPos(playerid, 300.0775,-140.1589,1004.0625);
    SetPlayerInterior(playerid, 7);
    SetPlayerVirtualWorld(playerid, 1);

    return 1;
}
CMD:stopventilation(playerid, params[])
{
	for(new i = 0; i < 8; i++)
	DestroyObject(vent[i]);
    
    return 1;
}
CMD:startventilation(playerid, params[])
{

	vent[0] = CreateObject(18748, 291.03717, -141.65465, 1004.11489,   0.00000, 0.00000, 90.00000);
	vent[1] = CreateObject(18748, 291.14459, -133.19687, 1004.11489,   0.00000, 0.00000, 90.00000);
	vent[2] = CreateObject(18748, 286.70346, -135.37524, 1004.11489,   0.00000, 0.00000, 90.00000);
	vent[3] = CreateObject(18748, 290.90723, -127.20930, 1004.11489,   0.00000, 0.00000, 90.00000);
	vent[4] = CreateObject(18748, 297.48935, -133.14328, 1004.11489,   0.00000, 0.00000, 90.00000);
	vent[5] = CreateObject(18748, 286.3423,  -135.4173,  1004.11489,   0.00000, 0.00000, 90.00000);
	vent[6] = CreateObject(18748, 295.38120, -140.29987, 1004.11489,   0.00000, 0.00000, 90.00000);
	vent[7] = CreateObject(18748, 294.85129, -135.20532, 1004.11489,   0.00000, 0.00000, 90.00000);
    
    return 1;
}
