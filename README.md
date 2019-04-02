# Overview
Welcome to my personal [Home Assistant](https://home-assistant.io) configurations. 

All the automations included in this repository are working with Home Assistant Version 0.90.2 and are provided for information and guidance and with no guarantees; They are updated as and when I add or modify my home assistant implementation at home. 

Prior to introducing [Home Assistant](https://home-assistant.io) into my home I was using [Lightwave RF Gen 1](https://www.home-assistant.io/components/lightwave/) hub with various switches and lighting control (described below) around the house; I also had a [Tuya](https://www.home-assistant.io/components/tuya/) compatible HowiseAcc Smart WiFi Power Strip; these have been integrated into my Home Assistant powered system.

# <a name="top">Contents</a>
[Lounge](#lounge)
[Mancave](#mancave)
[Kitchen](#kitchen)
[Hallway](#hallway)
[Welcome Home Automation](#welcomehome)
[PC](#pc)
[Start Automations](#startup)

## <a name="lounge">Lounge</a>

[Top](#top)

In the lounge there are two things I control; a *media system* and *lighting*

The media system consists of a TV, BluRay Player, Kodi Box, AV Amplifier, PVR and Bass Amp. All these devices are connected to my network so are 'detectable' using [NMap](https://www.home-assistant.io/components/device_tracker.nmap_tracker/). The Bass Amp is seperately powered (controlled by a LightwaveRF switch). The Kodi Box has an attached USB Drive which is also powered via a LightwaveRF switch).

### Automations
1. When the sun goes down, and we are at home, the lights switch on.
2. The Bass Amp is turned on and off in sympathy with the AV Amplifier.
3. The Kodi USB Drive is turned on and off in sympathy with the Kodi Box. 

## <a name="mancave">Mancave</a>

[Top](#top)

In my mancave there are two things I control; a *media system* and *lighting*

The *media system* consists of a TV, BluRay Player, Kodi Box and AV Amplifier. All devices except the AV Amplifier are connected to my network and are 'detectable' using [NMap](https://www.home-assistant.io/components/device_tracker.nmap_tracker/). The Kodi Box has two attached USB Drives one of which is powered via a LightwaveRF switch, the other via a Tuya switch.

### Automations
1. When the TV is switched on, if it is dark, the light is turned on; it is turned off 2 minutes after the TV is turned off.
2. The Kodi USB Drives are turned on and off in sympathy with the Kodi Box. 
3. When the sun goes down, if the TV is switched on, the light is turned on.

## <a name="kitchen">Kitchen</a>

[Top](#top)

In the kitchen there are two things I control; a *Radio* and *lighting*

### Automations
1. In the morning, when movement is detected in the hall, the Radio is switched on and tuned to our local station
2. *TODO* in the evening, when movement is detected in the hall, the lighting is switched on.

## <a name="Hallway">Hallway</a>

[Top](#top)

I run [Hassbian](https://www.home-assistant.io/docs/installation/hassbian/) on a Raspberry Pi 3+. This is located in the hall and connected to my router which is also in the hall near my front door. This is convenient for the presence detection used in [Welcome Home](#welcomehome) (below); I use a Z-Wave *Aeotec Multisensor 6* to realise the motion detection. There is also a light in the hallway which is controlled through a LightwaveRF switch.

### Automations
1. When movement is detected in the hall, and it is dark, the light is switched on; the light stays switched on until movement is no longer detected for a period of 1 minute.

## <a name="welcomehome">Welcome Home Automation</a>

[Top](#top)

*Welcome Home* switches the porch light and the hall light on for 2 minutes when movement is detected in the porch (and the sun is down)

## <a name="pc">PC</a>

[Top](#top)

I have several USB drives attached to my main PC (Andy-Ubuntu), a NAS Drive (Defiant) and a second PC (Excelsior) which has several USB Drives attached. The PCs and NAS are connected to my network  so are detectable using NMap. Everything except my main PC is controllable through LightwaveRF switches.

### Automations
1. When Defiant NAS is switched off it is also disconnected from mains supply.
2. When Excelsior is switched off it is also disconnected from mains power supply.
3. When my main PC is switched off all attached USB Drives are also switched off.
4. When my main PC is switched on my NAS drive is switched on using Wake-on-LAN

## <a name="startup">Start Automations Automation</a>
When commissioning my Home Assistant system I experienced problems with automations firing in an unwanted manner during startup. To fix this I used the *initial_state: false* switch in the affected automation. The *Start Automations* Automation turns these automations on 20 seconds after start-up or restart **but not** after a *reload automations* operation (in other words, beware, all such automations are *off* following a *reload automations* operation). 
