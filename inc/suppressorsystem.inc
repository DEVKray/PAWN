/*
#include <a_samp>
#include <zcmd>

#include "./colors.inc"
*/

#include <YSI\y_hooks>

#define DIALOG_HELP 1
#define DIALOG_SUPPRESSION_HELP 2

/*

enum E_pInfo
{
    pID,
    pSuppressor,
}
*/

//new PlayerInfo[MAX_PLAYERS][E_pInfo];


hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
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
