;initialization
#SingleInstance, Force
SetWorkingDir, C:\Users\Nathan Sellers\OneDrive\Desktop\File Maker Output

;starter gui
Gui, New
Gui, Add, Edit, x5 y5 w100 h20 vSize, Size
Gui, Add, DropDownList, x105 y5 w60 h20 r3 Choose1 vUnit, KB|MB|GB
Gui, Add, Edit, x5 y30 w160 h20 vAmount, Amount
Gui, Add, Edit, x5 y55 w160 h20 vName, Name
Gui, Add, Button, x5 y80 w160 h20 Default, OK
Gui, Show, w170 h105
Return

ButtonOK: ;ok button pressed
Gui, Submit
If (!((Size-Size)=0)) ;check if number
    ExitApp

;convert units
If (Unit = "KB") {
    Size *= 1
} Else If (Unit = "MB") {
    Size *= 1024
} Else If (Unit = "GB") {
    Size *= 1048576
}

Size := Round(Size)

;progress gui
Gui, New
Gui, Add, Progress, x5 y5 w500 h20 Range0-%Size% vFileProgress
Gui, Add, Text, x5 y30 w500 h20 +Center vFileProgressLabel, 0/%Size%KB
Gui, Add, Progress, x5 y55 w500 h20 Range0-%Amount% vTotalProgress
Gui, Add, Text, x5 y80 w500 h20 +Center vTotalProgressLabel, 0/%Amount% Files
Gui, Show, h105 w510

OutputName := ""

;make file(s)
Loop % Amount {
    Loop % Size {
        Output .= "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
        GuiControl,, FileProgress, +1
        GuiControl, Text, FileProgressLabel, %A_Index%/%Size%KB
    }

    GuiControl,, FileProgress, 0
    GuiControl,, TotalProgress, +1
    GuiControl, Text, TotalProgressLabel, %A_Index%/%Amount% Files
    OutputName := Name
    OutputName .= A_Index
    FileAppend, %Output%, %OutputName%.txt
    Output := ""
}
ExitApp
Return

GuiClose:
ExitApp