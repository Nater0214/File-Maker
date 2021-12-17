;initialization
#SingleInstance, Force
SetWorkingDir, %A_WorkingDir%\File Maker Output

;starter gui
Gui, New
Gui, Add, Edit, x5 y5 w100 h20 vFileSize, Size
Gui, Add, DropDownList, x105 y5 w60 h20 r3 Choose1 vUnit, KB|MB|GB
Gui, Add, Edit, x5 y30 w160 h20 vAmount, Amount
Gui, Add, Edit, x5 y55 w130 h20 vName, Name
Gui, Add, Edit, x135 y55 w30 h20 vExt, Ext
Gui, Add, Checkbox, x5 y80 w160 h20 vIsCustomText, Fill files with custom text?
Gui, Add, Button, x5 y105 w160 h20 Default, OK
Gui, Show, w170 h130
Return

ButtonOK: ;ok button pressed
Gui, Submit
Txt := Name
Txt .= "."
Txt .= Ext
If FileExist(Txt) {
    Gui, New
    Gui, Add, Text, x5 y5 w350 h20, File with the same name found. Do you wish to copy that file instead?
    Gui, Add, Button, x5 y20 w175 h20, Yes
    Gui, Add, Button, x180 y20 w175 h20, No
    Gui, Show, w360 h50
    IsCopy := True
} Else If (IsCustomText) {
    
} Else {
    IsCopy := False
    Gosub, ButtonYes
}
Return

ButtonYes:
Gui, Submit
If (!((FileSize-FileSize)=0)) ;check if number
    ExitApp
If (!(Mod(FileSize, 1) = 0)) ;check if whole number
    ExitApp

If (!((Amount-Amount)=0)) ;check if number
    ExitApp
If (!(Mod(Amount, 1) = 0)) ;check if whole number
    ExitApp

;convert units
Gui, New
Output := ""
If IsCopy {
    Gui, Add, Progress, x5 y5 w500 h20 Range0-1 vFileProgress
    Gui, Add, Text, x5 y30 w500 h20 +Center vProgressLabel, 0/1 KB
    Gui, Show, h55 w510
} Else If (Unit = "KB") {
    Gui, Add, Progress, x5 y5 w500 h20 Range0-1 vFileProgress
    Gui, Add, Text, x5 y30 w500 h20 +Center vProgressLabel, 0/1 KB
    Gui, Show, h55 w510
    Output .= "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
} Else If (Unit = "MB") {
    Gui, Add, Progress, x5 y5 w500 h20 Range0-1024 vFileProgress
    Gui, Add, Text, x5 y30 w500 h20 +Center vProgressLabel, 0/1024 KB
    Gui, Show, h55 w510
    Loop 1024 {
        Output .= "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
        GuiControl,, FileProgress, +1
        GuiControl, Text, ProgressLabel, %A_Index%/1024 KB
    }
} Else If (Unit = "GB") {
    Gui, Add, Progress, x5 y5 w500 h20 Range0-1048576 vFileProgress
    Gui, Add, Text, x5 y30 w500 h20 +Center vProgressLabel, 0/1048576 KB
    Gui, Show, h55 w510
    Loop 1048576 {
        Output .= "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
        GuiControl,, FileProgress, +1
        GuiControl, Text, ProgressLabel, %A_Index%/1048576 KB
    }
}


;make file(s)
OGName := Name
If !(IsCopy) {
    OGName .= "1"
    GuiControl,, FileProgress, 0
    GuiControl, -Range, FileProgress
    GuiControl, +Range0-%FileSize%, FileProgress
    Loop % FileSize {
        FileAppend, %Output%, %OGName%.%Ext%
        GuiControl,, FileProgress, +1
        GuiControl, Text, ProgressLabel, %A_Index%/%FileSize% KB
    }
    FileAppend, %Output%, %OGName%.%Ext%
}

GuiControl,, FileProgress, 0
GuiControl, -Range, FileProgress
GuiControl, +Range0-%Amount%, FileProgress
Loop % Amount - 1 {
    OutputName := Name
    OutputName .= A_Index + 1
    FileCopy, %OGName%.%Ext%, %OutputName%.%Ext%
    GuiControl,, FileProgress, +1
    Txt := A_Index + 1
    GuiControl, Text, ProgressLabel, %Txt%/%Amount% Files
    Output := ""
}
Gui, Submit
ExitApp
Return

ButtonNo:
GuiClose:
ExitApp