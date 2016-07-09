These drivers are available for convenience to install the chipset CH340/1 arduino boards. The original drivers can be found on http://www.wch.cn/download/CH341SER_ZIP.html .


* Mac OS >= 10.9 Instructions:
- Plug in the device.
- Locate and install the driver `CH34x_Install.pkg` within the Mac OS drivers folder `/path_to_repository/drivers/arduino-mega-ch340g/mac-osx-10_9-or-higher`.
- Once finished restart your computer.
- Plug in your device if it isn't already plugged in.
- Open a terminal window and type `ls /dev/tty*`. If the driver properly installed you should see a device like `tty.wchusbserial`. 
- NOTE: If you're having trouble connecting to device in Repeiter Host, ensure your firmware is compiled with a BAUD_RATEof `115200`. 

---

* Windows >= 8 Instructions: (Original available http://www.arduined.eu/ch340-windows-8-driver-download/ )
`Note: This driver is for CH340, CH340G & CH341 (USB-SERIAL chip) V3.4 Driver Version = 08/08/2014, 3.4.2014.08.`
- Plug the Arduino Mega into USB port
- Open Device Manager > under `Other Devices`, there should be something recognized as "USB2.0-Serial" with an exclamation mark. Right click and select `Update Driver Software`.
- Select `Browse my computer for driver software`
- Locate and select the top-level driver folder in the Windows 8 or greater folder of this direction: `/path_to_repository/drivers/win8-or-greater/CH341SER`
- Complete the installation - once the installer finishes, you should see USB-SERIAL CH340 as being recognized.
- In Device Manager, this device should be listed under `Ports (COM & LPT)`.
- Happy Printing
