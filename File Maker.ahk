; Setup
#SingleInstance, Force

; Check if output directory exists
If !InStr(FileExist("File Maker Output"), "D") {
    MsgBox, Directory doesn't exist: File Maker Output!
    ExitApp
}

; Delete Jobs.txt file if it exists
If FileExist("Jobs.txt")
    FileDelete, Jobs.txt

SetWorkingDir, %A_ScriptDir%

; Starter gui
Gui, New
Gui, Add, Edit, x5 y5 w100 h20 vFileSize, Size
Gui, Add, DropDownList, x105 y5 w60 h20 r3 Choose1 vUnit, KB|MB|GB
Gui, Add, Edit, x5 y30 w160 h20 vAmount, Amount
Gui, Add, Edit, x5 y55 w130 h20 vName, Name
Gui, Add, Edit, x135 y55 w30 h20 vExt, Ext
Gui, Add, Checkbox, x5 y80 w160 h20 vHasCustomText, Fill files with custom text?
Gui, Add, Button, x5 y105 w160 h20 Default, OK
Gui, Show, w170 h130
Return

ButtonOK: ; Ok button pressed
Gui, Submit
Txt := Name
Txt .= "."
Txt .= Ext
If FileExist(Txt) { ; Check if the file already exists
    Gui, New
    Gui, Add, Text, x5 y5 w350 h20, File with the same name found. Do you want to copy that file instead?
    Gui, Add, Button, x5 y20 w175 h20 Default, Yes
    Gui, Add, Button, x180 y20 w175 h20, No
    Gui, Show, w360 h50
    IsCopy := True
    HasCustomText := False
} Else If HasCustomText { ; Ask for custom text if the user wanted it
    Gui, New
    Gui, Add, Edit, x5 y5 w350 h100 r6 Limit1024 vCustomText, Put custom text here
    Gui, Add, Button, x5 y105 w350 h20 Default, Done
    Gui, Show, w360 h130
} Else {
    IsCopy := False
    Gosub, ButtonYes
}
Return


ButtonDone: ; Label for custom text input
Gui, Submit
Gosub, ButtonYes
Return


ButtonYes: ; Label for making files
Gui, Submit

; Error Detection
If !(Mod(FileSize, 1) = 0) {
    MsgBox, FileSize must be a whole number!
    ExitApp
}
If !(Mod(Amount, 1) = 0) {
    MsgBox, Amount must be a whole number!
    ExitApp
}

; Convert units
Gui, New
Output := ""
If HasCustomText {
    If (Unit = "KB") {
        Gui, Add, Progress, x5 y5 w500 h20 Range0-1024 vFileProgress
        Gui, Add, Text, x5 y30 w500 h20 +Center vProgressLabel, 0/1024 Chars
        Gui, Show, h55 w510
        NeededLen := 1024
        Loop % NeededLen / StrLen(CustomText) {
            Output .= CustomText
            Txt = StrLen(CustomText)
            GuiControl,, FileProgress, +%Txt%
            Txt := A_Index * StrLen(CustomText)
            GuiControl, Text, ProgressLabel, %Txt%/1024 Chars
        }
    } Else If (Unit = "MB") {
        Gui, Add, Progress, x5 y5 w500 h20 Range0-1048576 vFileProgress
        Gui, Add, Text, x5 y30 w500 h20 +Center vProgressLabel, 0/1048576 Chars
        Gui, Show, h55 w510
        NeededLen := 1048576
        Loop % NeededLen / StrLen(CustomText) {
            Output .= CustomText
            Txt = StrLen(CustomText)
            GuiControl,, FileProgress, +%Txt%
            Txt := A_Index * StrLen(CustomText)
            GuiControl, Text, ProgressLabel, %Txt%/1048576 Chars
        }
    } Else If (Unit = "GB") {
        MsgBox, No.
        ExitApp
    }
    While !(StrLen(Output) = NeededLen) {
        Output .= " "
    }

} Else If IsCopy {
    Gui, Add, Progress, x5 y5 w500 h20 Range0-1 vFileProgress
    Gui, Add, Text, x5 y30 w500 h20 +Center vProgressLabel, 0/1 KB
    Gui, Show, h55 w510

} Else {
    If (Unit = "KB") {
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
}
Gui, Submit

; Make original file
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
}

; Create Jobs
AmountEach := Floor(Amount / 5)
AmountEachRemainder := Mod(Amount, 5)
Jobs := []
Loop, 5 {
    If (A_Index <= AmountEachRemainder)
        Jobs.push(AmountEach + 1)
    Else
        Jobs.push(AmountEach)
}

For Key, Num in Jobs {
    FileAppend, %Num%`n, Jobs.txt
}

; Add additional information to Jobs.txt
FileAppend, %Name%, Jobs.txt
FileAppend, %OGName%`n, Jobs.txt
FileAppend, %Ext%`n, Jobs.txt
ExitApp
Return

ButtonNo:
GuiClose:
ExitApp