# Overview
Welcome to my personal [Home Assistant](https://home-assistant.io) configurations. 
 
All the automations included in this repository are working with Hass.io (Home Assistant  0.111.4) and are provided for information and guidance and with no guarantees; They are updated as and when I add or modify my home assistant implementation at home. 

Prior to introducing [Home Assistant](https://home-assistant.io) into my home I was using [Lightwave RF Gen 1](https://www.home-assistant.io/components/lightwave/) hub with various switches and lighting control (described below) around the house; I also had a [Tuya](https://www.home-assistant.io/components/tuya/) compatible HowiseAcc Smart WiFi Power Strip; these have been integrated into my Home Assistant powered system. 

Home assistant runs on a Raspberry Pi 3+ with a Z-Wave USB Adapter (Aeon Labs Z‐Stick Gen5) to allow the Pi to act as a Z-Wave Hub.

I use Z-Wave <i>sensors</i> and either [Lightwave RF](#lightwave) or Tuya <i>switches</i>. 

<b>Presence Detection</b> After various experiments with BLE fob devices, WiFi detection, Google, Owntracks and BlueTooth detection I decided that all these methods are not reliable (and that BLE is currently immature, not to be trusted). These methods are also too slow to use to trigger events that need to happen quickly (eg turn on lights when arrive home)... so use a dedicated sensor when I need to do this. I opted to use Bluetooth only with a a 30 minute period set for ''consider_home'' to determine (coarsely) if individuals are <i>at home</i> or <i>away</i>; this is not fast enough to use for automations but is OK for use in automation <i>conditions</i> (eg only trigger something if someone is home).
([Life360](https://www.home-assistant.io/components/life360/) (introduced in Home Assistant release 0.95) did not track my wife's phone very well) [Owntracks](https://www.home-assistant.io/integrations/owntracks/) didn't work either.

# <a name="top">Contents</a>
[Lounge](#lounge) | [Mancave](#mancave) | [Kitchen](#kitchen) | [Hallway](#hallway)
----------------- | ------------------- | ------------------- | -------------------
<b>[Welcome Home Automation](#welcomehome)</b> | <b>[PC](#pc)</b> | <b>[Start Automations](#startup)</b> | <b>[Lightwave RF](#lightwave)</b>
<b>[NAS Drive Integration](#nasdrive)

## <a name="lounge">Lounge</a>

[Top](#top)

In the lounge there are two things I control; a *media system* and *lighting*

The media system consists of a TV, BluRay Player, HTPC Kodi Box, AV Amplifier, PVR and Bass Amp. All these devices are controlled using a [Logitech Harmony Elite](https://www.logitech.com/en-us/product/harmony-elite?crid=60) remote control. The devices are connected to my network so are 'detectable' using [binary_sensors](https://www.home-assistant.io/integrations/binary_sensor/). The Harmony Remote is [integrated into Home Assistant](https://www.home-assistant.io/integrations/harmony/). The Bass Amp is seperately powered (controlled by a LightwaveRF switch). The Kodi Box has an attached USB Drive which is also powered via a LightwaveRF switch). I use a sensor located outside to measure how dark it is and flag when *its dark*.

### Automations
1. When it's dark, and we are at home, the lights switch on if the TV is switched on.
2. When we are at home, if the TV is switched on, if the outside sensor then detects that it is dark then the lights are switched on.
3. The Bass Amp is turned on and off in sympathy with the AV Amplifier.
4. The Kodi Box is switched on (using Wake on Lan) when the Harmony Remote changes it's current activity to "Kodi"
5. The Kodi Box is switched off when the Harmony Remote changes it's current activity to something other than "Kodi"
6. The Kodi USB Drive is turned on and off in sympathy with the Kodi Box. 

## <a name="mancave">Mancave</a>

[Top](#top)

In my mancave there are two things I control; a *media system* and *lighting*

The *media system* consists of a TV, BluRay Player, Kodi Box and AV Amplifier. All devices except the AV Amplifier are connected to my network and are 'detectable' using [binary_sensors](https://www.home-assistant.io/integrations/binary_sensor/). The Kodi Box has an attached USB Drive one of which is powered on & off using a Tuya switch.

I use my own Android App [AndyMOTE](https://andymote.abondservices.com/) to control devices in my *media system* (replacing their IR Remote Controls). [AndyMOTE](https://andymote.abondservices.com/) connects to an MQTT server to publish it's current 'state' to Home Assistant (or other components).

The *Kodi Box* itself is a Raspberry Pi 4; as Raspberry Pis cannot be switched on using Wake on Lan (like in the Lounge) an automated script (Not part of HA) does this using MQTT (See [Application Note Here](https://andymote.abondservices.com/mqtt.html#an).)

### Automations
1. When [AndyMOTE](https://andymote.abondservices.com/) indicates (using MQTT) that the media system is being used, if it is dark, the light is turned on; it is turned off 2 minutes after [AndyMOTE](https://andymote.abondservices.com/) indicates that the media system is off.
2. If the media system is being used (see 1, above) and the outside sensor detects that it is dark then the lights are switched on.
3. The Kodi USB Drives are turned on and off in sympathy with the Kodi Box. 

## <a name="kitchen">Kitchen</a>

[Top](#top)

In the kitchen there are two things I control; a *Radio* and *lighting*

### Automations
1. In the morning, when movement is detected in the hall, the Radio is switched on and tuned to our local station

## <a name="Hallway">Hallway</a>

[Top](#top)

I run Hassio on a Raspberry Pi 3+. This is located in my hallway; it is connected directly to my router which is also in the hall near my front door. I use a Z-Wave *Aeotec Multisensor 6* to realise the motion detection in my hallway. There is also a light in the hallway which is controlled through a LightwaveRF switch.

### Automations
1. When movement is detected in the hall, and the sun is down, the light is switched on; the light stays switched on until movement is no longer detected for a period of 1 minute.

## <a name="welcomehome">Welcome Home Automation</a>

[Top](#top)

*Welcome Home* switches the porch light and the hall light on for 2 minutes when movement is detected in the porch (and the sun is down); I use a <i>Neo Coolcam Motion Sensor 2 with temperature sensor</i> for the motion detection in my porch.

## <a name="pc">PC</a>

[Top](#top)

I have several USB drives attached to my main PC (Enterprise) and a second PC (Excelsior) which has several USB Drives attached. The PCs and NAS are connected to my network  so are detectable using [binary_sensors](https://www.home-assistant.io/integrations/binary_sensor/). Everything except my main PC is controllable through LightwaveRF or tuya switches.

I have a group: 'computers' which consists of my Main PC (Enterprise) and Second PC (excelsior). 

I have two other groups representing usb drives connected to computers (main_pc_usb_drives and excelsior_usb_drives).


### Automations
1. When Enterprise is switched off, all attached USB Drives are also switched off.
2. When Excelsior is switched off, all attached USB Drives are also switched off.
3. Excelsior is turned on once a day at 4:00am using wake on lan.


## <a name="startup">Start Automations Automation</a>
When commissioning my Home Assistant system I experienced problems with automations firing in an unwanted manner during startup. To fix this I used the *initial_state: false* switch in the affected automation. The *Start Automations* Automation turns these automations on 20 seconds after start-up or restart **but not** after a *reload automations* operation (in other words, beware, all such automations are *off* following a *reload automations* operation). 

## <a name="lightwave">Lightwave RF</a>

[Top](#top)

A quick note on my experience with Lightwave RF (Gen 1).

My Lightwave RF switches work as expected most of the time, but, occasionally fail to fire (switch on or off when commanded); this can be an issue when using Alexa or the Lightwave RF app and means that the command has to be re-issued sometimes. In order to get round this in Home Automation I usually invoke an on/off command more than once to make sure things get through.

## <a name="nasdrive">NAS Drive Integration</a>

[Top](#top)

I have a NAS Drive (Defiant) on my network which I use to store various files & archive data that I have accumilated over the years; it is not a media server. I want this data to be available when my PCs are switched on and I want the drive switched off when the PCs are switched off.

To achieve this I have three automations:

1. **defiant** this automation triggers when **sensor.defiant** changes from **on** to **off** and stays **off** for five minutes; the sensor is a simple ping sensor that checks that the NAS is switched on (running). When triggered, the NAS is considered to be 'off' and the automation disconnects the power from the NAS.
2. **nas_drive_on** this automation triggers whenever one of my computers is switched on (**group.computers** changes to **on**); it simply applies power to the NAS Drive (which will cause **sensor.defiant** to adopt the **on** state once the NAS has initialised).
3. **nas_drive_off** this automation triggers when **group.computers** changes to **off** for five minutes. It issues a shutdown command to the NAS using SSH.

For more details on using homeassistant as an SSH Client to access and control SSH Servers [read this article](https://github.com/OrangeReaper/homeassistant/wiki/Hassio-Integration-with-other-entities-using-SSH)

