::visit Rootjunky.com

::Set our Window Title
@title Simple ADB app Installer

::Set our default parameters
@echo off
color 0b



:menuLOOP

	call:header
	::Print our header
	::call:header
	
	::Load up our menu selections
	echo.--------------------------------------------------------------------------------
	for /f "tokens=1,2,* delims=_ " %%A in ('"C:/Windows/system32/findstr.exe /b /c:":menu_" "%~f0""') do echo.  %%B  %%C

	call:printstatus

	set choice=
	echo.&set /p choice= Please make a selection or hit ENTER to exit: ||GOTO:EOF
	echo.&call:menu_%choice%
	
GOTO:menuLOOP

:menu_1 Install Apps over IP                       (EXAMPLE any Android TV Device)
cls
color 0b
echo.--------------------------------------------------------------------------------
echo.
adb kill-server
adb start-server
echo.--------------------------------------------------------------------------------
echo. First you must turn on ADB DEBUGGING in your fire tv settings menu's
echo. Enter IP address from Amazon Fire TV in
echo. settings/system/about/network IP address number 
echo. example 000.00.0.0 then press enter
echo.--------------------------------------------------------------------------------
echo Enter IP Number
set /p IP=""
adb connect "%IP%"
adb devices
timeout 5 > nul
cls
goto:installer2

:menu_2 Install Apps over USB 	                (EXAMPLE Phones or Tablets)
cls
color 0b
echo.--------------------------------------------------------------------------------
echo. Make sure your usb debugging / adb debugging drivers are installed
echo. on your device. To turn on usb debugging go to settings, about phone,
echo. tap on your build number 7 times then in settings select developer options
echo. to turn on usb debuggin mode. 
echo.--------------------------------------------------------------------------------
echo. you can get drivers for your android device here RootJunkysdl.com
echo.--------------------------------------------------------------------------------
pause
cls
goto:installer1

:menu_3 Visit RootJunkysdl.com
cls
color 0b
start www.rootjunkysdl.com
for /f "tokens=1,2,* delims=_ " %%A in ('"C:/Windows/system32/findstr.exe /b /c:":menu_" "%~f0""') do echo.  %%B  %%C
	
	call:printstatus

	set choice=
	echo.&set /p choice= Please make a selection or hit ENTER to exit: ||GOTO:EOF
	echo.&call:menu_%choice%


:header  
cls        
color 0e
echo.[////////////////////////////      //////////            //////////////////////]                                                                           
echo.[///////////////////////////  ///   //////////////  ///////////////////////////]                                                                            
echo.[//////////////////////////  ////  //////////////  ////////////////////////////]                                                                    
echo.[/////////////////////////  //   ///////////////  /////////////////////////////]                                       
echo.[////////////////////////  ////  /////////  ///  //////////////////////////////]                                  
echo.[///////////////////////  //////  /////////    ////////////////////////////////]
echo.				  RootJunkys V2
echo. 		            Simple ADB App installer  
echo. 		                  Rootjunky.com 
echo.--------------------------------------------------------------------------------
adb devices
adb kill-server
timeout 6 > nul
cls	
color 0b
GOTO:EOF


:printstatus
echo.
echo. Simple and easy
echo.--------------------------------------------------------------------------------
GOTO:EOF


:installer1
echo.--------------------------------------------------------------------------------
echo. Select the APK you want to install from the popup or close this window to exit
echo.--------------------------------------------------------------------------------
setlocal enabledelayedexpansion
:: Does powershell.exe exist within %PATH%?
for %%I in (`powershell.exe`) do if "%%~$PATH:I" neq "" (
    set chooser=powershell "Add-Type -AssemblyName System.windows.forms|Out-Null;$f=New-Object System.Windows.Forms.OpenFileDialog;$f.InitialDirectory='%cd%';$f.Filter='All Files (*.*)|*.*';$f.showHelp=$true;$f.ShowDialog()|Out-Null;$f.FileName"
) else (
rem :: If not, compose and link C# application to open file browser dialog
    set chooser=%temp%\chooser.exe
    >"%temp%\c.cs" echo using System;using System.Windows.Forms;
    >>"%temp%\c.cs" echo class dummy{
    >>"%temp%\c.cs" echo public static void Main^(^){
    >>"%temp%\c.cs" echo OpenFileDialog f=new OpenFileDialog^(^);
    >>"%temp%\c.cs" echo f.InitialDirectory=Environment.CurrentDirectory;
    >>"%temp%\c.cs" echo f.Filter="Apps (*.apk)|*.apk|All Files (*.*)|*.*";
    >>"%temp%\c.cs" echo f.ShowHelp=true;
    >>"%temp%\c.cs" echo f.ShowDialog^(^);
    >>"%temp%\c.cs" echo Console.Write^(f.FileName^);}}
    for /f "delims=" %%I in ('dir /b /s "%windir%\microsoft.net\*csc.exe"') do (
        if not exist "!chooser!" "%%I" /nologo /out:"!chooser!" "%temp%\c.cs" 2>NUL
    )
    del "%temp%\c.cs"    
)

:: capture choice to a variable
for /f "delims=" %%I in ('%chooser%') do set "filename=%%I"
echo. Installing APP Now.....
adb install "%filename%"
:: Clean up the mess
del "%temp%\chooser.exe" 2>NUL
echo.--------------------------------------------------------------------------------
pause
cls
echo.--------------------------------------------------------------------------------
	for /f "tokens=1,2,* delims=_ " %%A in ('"C:/Windows/system32/findstr.exe /b /c:":menu_" "%~f0""') do echo.  %%B  %%C
	
	call:printstatus

	set choice=
	echo.&set /p choice= Please make a selection or hit ENTER to exit: ||GOTO:end
	echo.&call:menu_%choice%


:installer2
echo.--------------------------------------------------------------------------------
echo. Select the APK you want to install from the popup or close this window to exit
echo.--------------------------------------------------------------------------------
setlocal enabledelayedexpansion
:: Does powershell.exe exist within %PATH%?
for %%I in (`powershell.exe`) do if "%%~$PATH:I" neq "" (
    set chooser=powershell "Add-Type -AssemblyName System.windows.forms|Out-Null;$f=New-Object System.Windows.Forms.OpenFileDialog;$f.InitialDirectory='%cd%';$f.Filter='All Files (*.*)|*.*';$f.showHelp=$true;$f.ShowDialog()|Out-Null;$f.FileName"
) else (
rem :: If not, compose and link C# application to open file browser dialog
    set chooser=%temp%\chooser.exe
    >"%temp%\c.cs" echo using System;using System.Windows.Forms;
    >>"%temp%\c.cs" echo class dummy{
    >>"%temp%\c.cs" echo public static void Main^(^){
    >>"%temp%\c.cs" echo OpenFileDialog f=new OpenFileDialog^(^);
    >>"%temp%\c.cs" echo f.InitialDirectory=Environment.CurrentDirectory;
    >>"%temp%\c.cs" echo f.Filter="Apps (*.apk)|*.apk|All Files (*.*)|*.*";
    >>"%temp%\c.cs" echo f.ShowHelp=true;
    >>"%temp%\c.cs" echo f.ShowDialog^(^);
    >>"%temp%\c.cs" echo Console.Write^(f.FileName^);}}
    for /f "delims=" %%I in ('dir /b /s "%windir%\microsoft.net\*csc.exe"') do (
        if not exist "!chooser!" "%%I" /nologo /out:"!chooser!" "%temp%\c.cs" 2>NUL
    )
    del "%temp%\c.cs"    
)

:: capture choice to a variable
for /f "delims=" %%I in ('%chooser%') do set "filename=%%I"
echo. Installing APP Now.....
adb install "%filename%"
:: Clean up the mess
del "%temp%\chooser.exe" 2>NUL
echo.--------------------------------------------------------------------------------
echo. Press and button to continue installing apk's or close window to exit
pause > Nul
cls
goto:installer2


:end
adb kill-server
exit
