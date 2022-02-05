; Setup
#SingleInstance, Force

; Read and initialize variables
SetWorkingDir, %A_ScriptDir%

FileReadLine, Amount, Jobs.txt, 1
FileReadLine, Name, Jobs.txt, 6
FileReadLine, OGName, Jobs.txt, 7
FileReadLine, Ext, Jobs.txt, 8

SetWorkingDir, %A_ScriptDir%\File Maker Output

Loop % Amount - 1 {
    OutputName := Name
    OutputName .= A_Index + 1
    FileCopy, %OGName%.%Ext%, %OutputName%.%Ext%
}