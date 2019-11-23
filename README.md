# Overview
Welcome to my personal [Home Assistant](https://home-assistant.io) configurations. 
 
All the automations included in this repository are working with Hass.io (Home Assistant 0.102.1 and are provided for information and guidance and with no guarantees; They are updated as and when I add or modify my home assistant implementation at home. 

Prior to introducing [Home Assistant](https://home-assistant.io) into my home I was using [Lightwave RF Gen 1](https://www.home-assistant.io/components/lightwave/) hub with various switches and lighting control (described below) around the house; I also had a [Tuya](https://www.home-assistant.io/components/tuya/) compatible HowiseAcc Smart WiFi Power Strip; these have been integrated into my Home Assistant powered system. 

Home assistant runs on a Raspberry Pi 3+ with a Z-Wave USB Adapter (Aeon Labs Z‐Stick Gen5) to allow the Pi to act as a Z-Wave Hub.

I use Z-Wave <i>sensors</i> and either [Lightwave RF](#lightwave) or Tuya <i>switches</i>. 

<b>Presence Detection</b> After various experiments with BLE fob devices, WiFi detection and BlueTooth detection I decided that all these methods are not reliable (and that BLE is currently immature, not to be trusted). I decided that these methods are too slow to use to trigger events that need to happen quickly (eg turn on lights when arrive home)... so use a dedicated sensor for this; I opted to use a combination of Bluetooth, Wifi and [Google Maps](https://www.home-assistant.io/components/google_maps/) location sharing to determine (coarsely) if individuals are <i>at home</i> or <i>away</i>; this is not fast enough to use for automations but is OK for use in automation <i>conditions</i> (eg only trigger something if someone is home).
([Life360](https://www.home-assistant.io/components/life360/) (introduced in Home Assistant release 0.95) did not track my wife's phone very well)

# <a name="top">Contents</a>
[Lounge](#lounge) | [Mancave](#mancave) | [Kitchen](#kitchen) | [Hallway](#hallway)
----------------- | ------------------- | ------------------- | -------------------
<b>[Welcome Home Automation](#welcomehome)</b> | <b>[PC](#pc)</b> | <b>[Start Automations](#startup)</b> | <b>[Lightwave RF](#lightwave)</b>

## <a name="lounge">Lounge</a>

[Top](#top)

In the lounge there are two things I control; a *media system* and *lighting*

The media system consists of a TV, BluRay Player, Kodi Box, AV Amplifier, PVR and Bass Amp. All these devices are connected to my network so are 'detectable' using [NMap](https://www.home-assistant.io/components/device_tracker.nmap_tracker/). The Bass Amp is seperately powered (controlled by a LightwaveRF switch). The Kodi Box has an attached USB Drive which is also powered via a LightwaveRF switch). I use a sensor located outside to measure how dark it is and flag when *its dark*.

### Automations
1. When it's dark, and we are at home, the lights switch on if the TV is switched on.
2. When we are at home, if the TV is switched on, if the outside sensor then detects that it is dark then the lights are switched on.
3. The Bass Amp is turned on and off in sympathy with the AV Amplifier.
4. The Kodi USB Drive is turned on and off in sympathy with the Kodi Box. 

## <a name="mancave">Mancave</a>

[Top](#top)

In my mancave there are two things I control; a *media system* and *lighting*

The *media system* consists of a TV, BluRay Player, Kodi Box and AV Amplifier. All devices except the AV Amplifier are connected to my network and are 'detectable' using [NMap](https://www.home-assistant.io/components/device_tracker.nmap_tracker/). The Kodi Box has two attached USB Drives one of which is powered via a LightwaveRF switch, the other via a Tuya switch.

### Automations
1. When the TV is switched on, if it is dark, the light is turned on; it is turned off 2 minutes after the TV is turned off.
2. If the TV is switched on, and the outside sensor then detects that it is dark then the lights are switched on.
3. The Kodi USB Drives are turned on and off in sympathy with the Kodi Box. 
4. When the sun goes down, if the TV is switched on, the light is turned on.

## <a name="kitchen">Kitchen</a>

[Top](#top)

In the kitchen there are two things I control; a *Radio* and *lighting*

### Automations
1. In the morning, when movement is detected in the hall, the Radio is switched on and tuned to our local station

## <a name="Hallway">Hallway</a>

[Top](#top)

I run [Hassbian](https://www.home-assistant.io/docs/installation/hassbian/) on a Raspberry Pi 3+. This is located in the hall and connected to my router which is also in the hall near my front door. This is convenient for the presence detection used in [Welcome Home](#welcomehome) (below); I use a Z-Wave *Aeotec Multisensor 6* to realise the motion detection. There is also a light in the hallway which is controlled through a LightwaveRF switch.

### Automations
1. When movement is detected in the hall, and the sun is down, the light is switched on; the light stays switched on until movement is no longer detected for a period of 1 minute.

## <a name="welcomehome">Welcome Home Automation</a>

[Top](#top)

*Welcome Home* switches the porch light and the hall light on for 2 minutes when movement is detected in the porch (and the sun is down); I use a <i>Neo Coolcam Motion Sensor 2 with temperature sensor</i> for the motion detection.

## <a name="pc">PC</a>

[Top](#top)

I have several USB drives attached to my main PC (Andy-Ubuntu), a NAS Drive (Defiant) and a second PC (Excelsior) which has several USB Drives attached. The PCs and NAS are connected to my network  so are detectable using NMap. Everything except my main PC is controllable through LightwaveRF or tuya switches.

I have a group: 'computers' which consists of my Main PC and Second PC (excelsior). 

I have two other groups representing usb drives connected to computers (main_pc_usb_drives and excelsior_usb_drives).


### Automations
1. When Defiant NAS is switched off it is also disconnected from mains supply.
2. When Excelsior is switched off it is also disconnected from mains power supply.
3. When my main PC is switched off, all attached USB Drives are also switched off.
3. When Excelsior is switched off, all attached USB Drives and power to Excelsior are also switched off.
4. When a PC in group 'computers' is switched on my NAS drive is switched on using Wake-on-LAN
5. When all PCs in group 'computers' are switched off my NAS drive is switched off using script.turn_off_defiant
6. Excelsior is turned on once a day at 4:00am.

### Excelsior
My Excelsior PC has a wake_on_lan component associated with it [See Here](https://www.home-assistant.io/components/wake_on_lan/). This component is used to switch the PC off via a lovelace Entity Button.

Excelsior can be switched off from the lovelace interface; this uses a shell command and ssh. This switch off can be unconditional (forced) or by request. In the former case Excelsior will be shutdown immediately, in the latter case a request is sent and Exelsior shutd down when it is ready to do so.

### Defiant
Defiant is an (ancient but still going strong) Netgear ReadyNAS Duo v2.

My Defiant NAS PC has a wake_on_lan component associated with it [See Here](https://www.home-assistant.io/components/wake_on_lan/). This component is used to switch the NAS off via a lovelace Entity Button.

Defiant can be manually and unconditionally switched off from the lovelace interface; this uses a shell command and ssh.


## <a name="startup">Start Automations Automation</a>
When commissioning my Home Assistant system I experienced problems with automations firing in an unwanted manner during startup. To fix this I used the *initial_state: false* switch in the affected automation. The *Start Automations* Automation turns these automations on 20 seconds after start-up or restart **but not** after a *reload automations* operation (in other words, beware, all such automations are *off* following a *reload automations* operation). 

## <a name="lightwave">Lightwave RF</a>

[Top](#top)

A quick note on my experience with Lightwave RF (Gen 1).

My Lightwave RF switches work as expected most of the time, but, occasionally fail to fire (switch on or off when commanded); this can be an issue when using Alexa or the Lightwave RF app and means that the command has to be re-issued sometimes. In order to get round this in Home Automation I usually invoke an on/off command more than once to make sure things get through.
