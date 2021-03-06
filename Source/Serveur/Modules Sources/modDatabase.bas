Attribute VB_Name = "modDatabase"
Option Explicit

Declare Function WritePrivateProfileString Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationname As String, ByVal lpKeyname As Any, ByVal lpString As String, ByVal lpfilename As String) As Long
Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationname As String, ByVal lpKeyname As Any, ByVal lpdefault As String, ByVal lpreturnedstring As String, ByVal nsize As Long, ByVal lpfilename As String) As Long

Public START_MAP As Long
Public START_X As Long
Public START_Y As Long

Public Const ADMIN_LOG = "logs\admin.txt"
Public Const PLAYER_LOG = "logs\player.txt"
Public Const GUILDE_LOG = "logs\guildes.txt"


Function GetVar(File As String, Header As String, Var As String) As String
Dim sSpaces As String   ' Max string length
Dim szReturn As String  ' Return default value if not found
  
    szReturn = vbNullString
  
    sSpaces = Space$(5000)
  
    Call GetPrivateProfileString(Header, Var, szReturn, sSpaces, Len(sSpaces), File)
  
    GetVar = RTrim$(sSpaces)
    GetVar = Left$(GetVar, Len(GetVar) - 1)
End Function

Sub PutVar(File As String, Header As String, Var As String, value As String)
    Call WritePrivateProfileString(Header, Var, value, File)
End Sub

Public Sub WriteINI(INISection As String, INIKey As String, INIValue As String, INIFile As String)
    Call WritePrivateProfileString(INISection, INIKey, INIValue, INIFile)
End Sub

Public Function ReadINI(INISection As String, INIKey As String, INIFile As String) As String
    Dim StringBuffer As String
    Dim StringBufferSize As Long
    
    StringBuffer = Space$(255)
    StringBufferSize = Len(StringBuffer)
    
    StringBufferSize = GetPrivateProfileString(INISection, INIKey, "", StringBuffer, StringBufferSize, INIFile)
    
    If StringBufferSize > 0 Then ReadINI = Left$(StringBuffer, StringBufferSize) Else ReadINI = vbNullString
End Function

Sub LoadExps()
Dim FileName As String
Dim i As Long

    Call CheckExps
    
    FileName = App.Path & "\experience.ini"
    
    For i = 1 To MAX_LEVEL
        Call SetStatus("Changement de l'experience... " & i & "/" & MAX_LEVEL)
        experience(i) = Val(GetVar(FileName, "experience", "Exp" & i))
        
        DoEvents
    Next i
End Sub

Sub CheckExps()
    If Not FileExist("experience.ini") Then
        Dim i As Long
    
        For i = 1 To MAX_LEVEL
            Call SetStatus("Sauvegarde de l'experience... " & i & "/" & MAX_LEVEL)
            DoEvents
            Call PutVar(App.Path & "\experience.ini", "experience", "Exp" & i, i * 1500)
        Next i
    End If
End Sub

Sub ClearExps()
Dim i As Long

    For i = 1 To MAX_LEVEL
        experience(i) = 0
    Next i
End Sub

Sub LoadEmos()
Dim FileName As String
Dim i As Long

    'Call CheckEmos
    Call ClearEmos
    
    FileName = App.Path & "\emoticons.ini"
    
    For i = 0 To MAX_EMOTICONS
        Call SetStatus("Chargement des �moticon... " & i & "/" & MAX_EMOTICONS)
        Emoticons(i).Pic = Val(GetVar(FileName, "EMOTICONS", "Emoticon" & i))
        Emoticons(i).Command = GetVar(FileName, "EMOTICONS", "EmoticonC" & i)
        
        DoEvents
    Next i
End Sub

Sub CheckEmos()
    If Not FileExist("emoticons.ini") Then
        Dim i As Long
    
        For i = 0 To MAX_EMOTICONS
            Call SetStatus("Sauvegarde des �moticons... " & i & "/" & MAX_EMOTICONS)
            DoEvents
            Call PutVar(App.Path & "\emoticons.ini", "EMOTICONS", "Emoticon" & i, 0)
            Call PutVar(App.Path & "\emoticons.ini", "EMOTICONS", "EmoticonC" & i, "")
        Next i
    End If
End Sub

Sub ClearEmos()
Dim i As Long

    For i = 0 To MAX_EMOTICONS
        Emoticons(i).Pic = 0
        Emoticons(i).Command = vbNullString
    Next i
End Sub

Sub SaveEmoticon(ByVal EmoNum As Long)
Dim FileName As String

    FileName = App.Path & "\emoticons.ini"
    
    Call PutVar(FileName, "EMOTICONS", "EmoticonC" & EmoNum, Trim$(Emoticons(EmoNum).Command))
    Call PutVar(FileName, "EMOTICONS", "Emoticon" & EmoNum, Val(Emoticons(EmoNum).Pic))
End Sub

Function FileExist(ByVal FileName As String, Optional dirapp As Boolean = True) As Boolean
    If dirapp = True Then
        If Dir(App.Path & "\" & FileName) = vbNullString Then FileExist = False Else FileExist = True
    Else
        If Dir(FileName) = vbNullString Then FileExist = False Else FileExist = True
    End If
End Function

Sub SavePlayer(ByVal index As Long)
Dim FileName As String
Dim i As Long
Dim n As Long

    FileName = App.Path & "\accounts\" & Trim$(Player(index).Login) & ".ini"
    
    Call PutVar(FileName, "GENERAL", "Login", Trim$(Player(index).Login))
    Call PutVar(FileName, "GENERAL", "Password", Trim$(Player(index).Password))

    For i = 1 To MAX_CHARS
        ' General
<<<<<<< HEAD
        Call PutVar(FileName, "CHAR" & i, "Name", Trim$(Player(index).Char(i).Name))
        Call PutVar(FileName, "CHAR" & i, "Class", STR$(Player(index).Char(i).Class))
        Call PutVar(FileName, "CHAR" & i, "Sex", STR$(Player(index).Char(i).Sex))
        Call PutVar(FileName, "CHAR" & i, "Sprite", STR$(Player(index).Char(i).sprite))
        Call PutVar(FileName, "CHAR" & i, "Level", STR$(Player(index).Char(i).Level))
        Call PutVar(FileName, "CHAR" & i, "Exp", STR$(Player(index).Char(i).Exp))
        Call PutVar(FileName, "CHAR" & i, "Access", STR$(Player(index).Char(i).Access))
        Call PutVar(FileName, "CHAR" & i, "PK", STR$(Player(index).Char(i).PK))
        Call PutVar(FileName, "CHAR" & i, "Guild", Trim$(Player(index).Char(i).Guild))
        Call PutVar(FileName, "CHAR" & i, "Guildaccess", STR$(Player(index).Char(i).Guildaccess))
=======
        Call PutVar(FileName, "CHAR" & i, "Name", Trim$(Player(Index).Char(i).Name))
        Call PutVar(FileName, "CHAR" & i, "Class", STR$(Player(Index).Char(i).Class))
        Call PutVar(FileName, "CHAR" & i, "Sex", STR$(Player(Index).Char(i).Sex))
        Call PutVar(FileName, "CHAR" & i, "Sprite", STR$(Player(Index).Char(i).sprite))
        Call PutVar(FileName, "CHAR" & i, "Level", STR$(Player(Index).Char(i).Level))
        Call PutVar(FileName, "CHAR" & i, "Exp", STR$(Player(Index).Char(i).Exp))
        Call PutVar(FileName, "CHAR" & i, "Access", STR$(Player(Index).Char(i).Access))
        Call PutVar(FileName, "CHAR" & i, "PK", STR$(Player(Index).Char(i).PK))
        Call PutVar(FileName, "CHAR" & i, "Guild", Trim$(Player(Index).Char(i).Guild))
        Call PutVar(FileName, "CHAR" & i, "Guildaccess", STR$(Player(Index).Char(i).Guildaccess))
>>>>>>> 78e891abe783f077a019bb7ae3b3f68bd63dddde

        
        ' Vitals
        Call PutVar(FileName, "CHAR" & i, "HP", STR$(Player(index).Char(i).HP))
        Call PutVar(FileName, "CHAR" & i, "MP", STR$(Player(index).Char(i).MP))
        Call PutVar(FileName, "CHAR" & i, "SP", STR$(Player(index).Char(i).SP))
        
        ' Stats
        Call PutVar(FileName, "CHAR" & i, "STR", STR$(Player(index).Char(i).STR))
        Call PutVar(FileName, "CHAR" & i, "DEF", STR$(Player(index).Char(i).def))
        Call PutVar(FileName, "CHAR" & i, "SPEED", STR$(Player(index).Char(i).Speed))
        Call PutVar(FileName, "CHAR" & i, "MAGI", STR$(Player(index).Char(i).magi))
        Call PutVar(FileName, "CHAR" & i, "POINTS", STR$(Player(index).Char(i).POINTS))
        
        ' Worn equipment
        Call PutVar(FileName, "CHAR" & i, "ArmorSlot", STR$(Player(index).Char(i).ArmorSlot))
        Call PutVar(FileName, "CHAR" & i, "WeaponSlot", STR$(Player(index).Char(i).WeaponSlot))
        Call PutVar(FileName, "CHAR" & i, "HelmetSlot", STR$(Player(index).Char(i).HelmetSlot))
        Call PutVar(FileName, "CHAR" & i, "ShieldSlot", STR$(Player(index).Char(i).ShieldSlot))
        Call PutVar(FileName, "CHAR" & i, "PetSlot", STR$(Player(index).Char(i).PetSlot))
        
        Call PutVar(FileName, "CHAR" & i, "PetDir", STR$(Player(index).Char(i).pet.Dir))
        Call PutVar(FileName, "CHAR" & i, "PetX", STR$(Player(index).Char(i).pet.X))
        Call PutVar(FileName, "CHAR" & i, "PetY", STR$(Player(index).Char(i).pet.Y))
        
        Call PutVar(FileName, "CHAR" & i, "Metier", STR$(Player(index).Char(i).metier))
        Call PutVar(FileName, "CHAR" & i, "MetierLvl", STR$(Player(index).Char(i).MetierLvl))
        Call PutVar(FileName, "CHAR" & i, "MetierExp", STR$(Player(index).Char(i).MetierExp))
        
        
        ' Check to make sure that they aren't on map 0, if so reset'm
        If Player(index).Char(i).Map = 0 Then
            Player(index).Char(i).Map = START_MAP
            Player(index).Char(i).X = START_X
            Player(index).Char(i).Y = START_Y
        End If
            
        ' Position
        Call PutVar(FileName, "CHAR" & i, "Map", STR$(Player(index).Char(i).Map))
        Call PutVar(FileName, "CHAR" & i, "X", STR$(Player(index).Char(i).X))
        Call PutVar(FileName, "CHAR" & i, "Y", STR$(Player(index).Char(i).Y))
        Call PutVar(FileName, "CHAR" & i, "Dir", STR$(Player(index).Char(i).Dir))
        
        ' Inventory
        For n = 1 To MAX_INV
            Call PutVar(FileName, "CHAR" & i, "InvItemNum" & n, STR$(Player(index).Char(i).Inv(n).num))
            Call PutVar(FileName, "CHAR" & i, "InvItemVal" & n, STR$(Player(index).Char(i).Inv(n).value))
            Call PutVar(FileName, "CHAR" & i, "InvItemDur" & n, STR$(Player(index).Char(i).Inv(n).Dur))
        Next n
        
        ' Spells
        For n = 1 To MAX_PLAYER_SPELLS
            Call PutVar(FileName, "CHAR" & i, "Spell" & n, STR$(Player(index).Char(i).Spell(n)))
        Next n
        
        ' coffre
        Dim cofr As Long
        For cofr = 1 To 30
            If Val(GetVar(FileName, "CHAR" & i, "cofitemnum" & cofr)) <= 0 Then
                Call PutVar(FileName, "CHAR" & i, "cofitemnum" & cofr, " 0")
                Call PutVar(FileName, "CHAR" & i, "cofitemval" & cofr, " 0")
                Call PutVar(FileName, "CHAR" & i, "cofitemdur" & cofr, " 0")
            End If
        Next cofr
        
        'Quete
        Call PutVar(FileName, "CHAR" & i, "QueteC", STR$(Player(index).Char(i).QueteEnCour))
        For n = 1 To MAX_QUETES
            
            Call PutVar(FileName, "CHAR" & i, "quete" & n, STR$(Player(index).Char(i).QueteStatut(n)))
        Next
    Next i
End Sub

Sub LoadPlayer(ByVal index As Long, ByVal Name As String)
Dim FileName As String
Dim i As Long
Dim n As Long
On Error GoTo er:
Call ClearPlayer(index)

With Player(index)
    FileName = App.Path & "\accounts\" & Trim$(Name) & ".ini"
    .Login = GetVar(FileName, "GENERAL", "Login")
    .Password = GetVar(FileName, "GENERAL", "Password")
    If .Login <> Trim$(Name) Then .Login = Name

    For i = 1 To MAX_CHARS
    With .Char(i)
        ' General
        .Name = GetVar(FileName, "CHAR" & i, "Name")
        .Sex = Val(GetVar(FileName, "CHAR" & i, "Sex"))
        .Class = Val(GetVar(FileName, "CHAR" & i, "Class"))
        .sprite = Val(GetVar(FileName, "CHAR" & i, "Sprite"))
        .Level = Val(GetVar(FileName, "CHAR" & i, "Level"))
        .Exp = Val(GetVar(FileName, "CHAR" & i, "Exp"))
        .Access = Val(GetVar(FileName, "CHAR" & i, "Access"))
        .PK = Val(GetVar(FileName, "CHAR" & i, "PK"))
        .Guild = GetVar(FileName, "CHAR" & i, "Guild")
        .Guildaccess = Val(GetVar(FileName, "CHAR" & i, "Guildaccess"))
        
        ' Vitals
        .HP = Val(GetVar(FileName, "CHAR" & i, "HP"))
        .MP = Val(GetVar(FileName, "CHAR" & i, "MP"))
        .SP = Val(GetVar(FileName, "CHAR" & i, "SP"))
        
        ' Stats
        .STR = Val(GetVar(FileName, "CHAR" & i, "STR"))
        .def = Val(GetVar(FileName, "CHAR" & i, "DEF"))
        .Speed = Val(GetVar(FileName, "CHAR" & i, "SPEED"))
        .magi = Val(GetVar(FileName, "CHAR" & i, "MAGI"))
        .POINTS = Val(GetVar(FileName, "CHAR" & i, "POINTS"))
        
        ' Worn equipment
        .ArmorSlot = Val(GetVar(FileName, "CHAR" & i, "ArmorSlot"))
        .WeaponSlot = Val(GetVar(FileName, "CHAR" & i, "WeaponSlot"))
        .HelmetSlot = Val(GetVar(FileName, "CHAR" & i, "HelmetSlot"))
        .ShieldSlot = Val(GetVar(FileName, "CHAR" & i, "ShieldSlot"))
        .PetSlot = Val(GetVar(FileName, "CHAR" & i, "PetSlot"))
        
        ' Position
        .Map = Val(GetVar(FileName, "CHAR" & i, "Map"))
        .X = Val(GetVar(FileName, "CHAR" & i, "X"))
        .Y = Val(GetVar(FileName, "CHAR" & i, "Y"))
        .Dir = Val(GetVar(FileName, "CHAR" & i, "Dir"))
        
        .pet.Dir = Val(GetVar(FileName, "CHAR" & i, "PetDir"))
        .pet.X = Val(GetVar(FileName, "CHAR" & i, "PetX"))
        .pet.Y = Val(GetVar(FileName, "CHAR" & i, "PetY"))
        
        .metier = Val(GetVar(FileName, "CHAR" & i, "Metier"))
        .MetierLvl = Val(GetVar(FileName, "CHAR" & i, "MetierLvl"))
        .MetierExp = Val(GetVar(FileName, "CHAR" & i, "MetierExp"))
        
        ' Check to make sure that they aren't on map 0, if so reset'm
        If .Map = 0 Then
            .Map = START_MAP
            .X = START_X
            .Y = START_Y
        End If
        
        ' Inventory
        For n = 1 To MAX_INV
            .Inv(n).num = Val(GetVar(FileName, "CHAR" & i, "InvItemNum" & n))
            .Inv(n).value = Val(GetVar(FileName, "CHAR" & i, "InvItemVal" & n))
            .Inv(n).Dur = Val(GetVar(FileName, "CHAR" & i, "InvItemDur" & n))
        Next n
        
        ' Spells
        For n = 1 To MAX_PLAYER_SPELLS
            .Spell(n) = Val(GetVar(FileName, "CHAR" & i, "Spell" & n))
        Next n
        
        'Quete
        .QueteEnCour = Val(GetVar(FileName, "CHAR" & i, "QueteC"))
        
        For n = 1 To MAX_QUETES
            .QueteStatut(n) = Val(GetVar(FileName, "CHAR" & i, "quete" & n))
        Next n
    
        End With
    Next i
End With

Exit Sub
er:
On Error Resume Next
If index < 0 Or index > MAX_PLAYERS Then Exit Sub
Call AddLog("le : " & Date & "     � : " & Time & "...Erreur pendant le chargement du joueur : " & Name & ",Compte : " & GetPlayerLogin(index) & ". D�tails : Num :" & Err.Number & " Description : " & Err.description & " Source : " & Err.Source & "...", "logs\Err.txt")
If IBErr Then Call IBMsg("Erreur pendant le chargement du joueur : " & Name, BrightRed, True)
Call PlainMsg(index, "Erreur du serveur, relancer SVP!(Pour tous probl�me r�curent visiter " & Trim$(GetVar(App.Path & "\Config\.ini", "CONFIG", "WebSite")) & ").", 3)
End Sub

Sub LoadPlayerQuete(ByVal index As Long)
Dim FileName As String
With Player(index)
    FileName = App.Path & "\accounts\" & Trim$(.Login) & ".ini"
    .Char(.CharNum).QueteEnCour = Val(GetVar(FileName, "CHAR" & .CharNum, "QueteC"))
End With
End Sub

Function AccountExist(ByVal Name As String) As Boolean
Dim FileName As String

    FileName = "accounts\" & Trim$(Name) & ".ini"
    
    If FileExist(FileName) Then AccountExist = True Else AccountExist = False
    
    FileName = "accounts\" & Trim$(LCase$(Name)) & ".ini"
    
    If FileExist(FileName) Then AccountExist = True Else AccountExist = False
    
    FileName = "accounts\" & Trim$(UCase$(Name)) & ".ini"
    
    If FileExist(FileName) Then AccountExist = True Else AccountExist = False
End Function

Function CharExist(ByVal index As Long, ByVal CharNum As Long) As Boolean
    If Trim$(Player(index).Char(CharNum).Name) <> vbNullString Then CharExist = True Else CharExist = False
End Function

Function PasswordOK(ByVal Name As String, ByVal Password As String) As Boolean
Dim FileName As String
Dim RightPassword As String

    PasswordOK = False
    
    If AccountExist(Name) Then
        FileName = App.Path & "\accounts\" & Trim$(Name) & ".ini"
        RightPassword = GetVar(FileName, "GENERAL", "Password")
        
        If UCase$(Trim$(MD5String(Password))) = UCase$(Trim$(RightPassword)) Then
            PasswordOK = True
        Else
            Password = Password
            If UCase$(Trim$(Password)) = UCase$(Trim$(RightPassword)) Then PasswordOK = True
        End If
    End If
End Function

Sub AddAccount(ByVal index As Long, ByVal Name As String, ByVal Password As String)
Dim i As Long

    Player(index).Login = Name
    Player(index).Password = MD5String(Password)
    
    For i = 1 To MAX_CHARS
        Call ClearChar(index, i)
    Next i
    
    Call SavePlayer(index)
End Sub

<<<<<<< HEAD
Sub AddChar(ByVal index As Long, ByVal Name As String, ByVal Sex As Byte, ByVal ClassNum As Byte, ByVal CharNum As Long)
=======
Sub AddChar(ByVal Index As Long, ByVal Name As String, ByVal Sex As Byte, ByVal ClassNum As Byte, ByVal CharNum As Long)
>>>>>>> 78e891abe783f077a019bb7ae3b3f68bd63dddde
Dim f As Long

    If Trim$(Player(index).Char(CharNum).Name) = vbNullString Then
    With Player(index)
        .CharNum = CharNum
        
        .Char(CharNum).Name = Name
        .Char(CharNum).Sex = Sex
        .Char(CharNum).Class = ClassNum
        
        If .Char(CharNum).Sex = SEX_MALE Then
            .Char(CharNum).sprite = Classe(ClassNum).MaleSprite
        Else
            .Char(CharNum).sprite = Classe(ClassNum).FemaleSprite
        End If
        
        .Char(CharNum).Level = 1
                    
        .Char(CharNum).STR = Classe(ClassNum).STR
        .Char(CharNum).def = Classe(ClassNum).def
        .Char(CharNum).Speed = Classe(ClassNum).Speed
        .Char(CharNum).magi = Classe(ClassNum).magi
        
        If Classe(ClassNum).Map <= 0 Then Classe(ClassNum).Map = 1
        If Classe(ClassNum).X < 0 Or Classe(ClassNum).X > MAX_MAPX Then Classe(ClassNum).X = Int(Classe(ClassNum).X / 2)
        If Classe(ClassNum).Y < 0 Or Classe(ClassNum).Y > MAX_MAPY Then Classe(ClassNum).Y = Int(Classe(ClassNum).Y / 2)
        .Char(CharNum).Map = Classe(ClassNum).Map
        .Char(CharNum).X = Classe(ClassNum).X
        .Char(CharNum).Y = Classe(ClassNum).Y
            
        .Char(CharNum).HP = GetPlayerMaxHP(index)
        .Char(CharNum).MP = GetPlayerMaxMP(index)
        .Char(CharNum).SP = GetPlayerMaxSP(index)
        
        'Objet de classe
        Dim ItemNum As Long
        Dim i As Long
            ItemNum = Val(GetVar(App.Path & "\" & "Classes\Class" & ClassNum & ".ini", "STARTUP", "Weapon"))
            If item(ItemNum).type = ITEM_TYPE_WEAPON Then
                i = FindOpenInvSlot(index, ItemNum)
                Call SetPlayerInvItemNum(index, i, ItemNum)
                Call SetPlayerInvItemValue(index, i, GetPlayerInvItemValue(index, i) + 1)
                Call SetPlayerInvItemDur(index, i, item(ItemNum).data1)
                Call SetPlayerWeaponSlot(index, i)
            End If
            ItemNum = Val(GetVar(App.Path & "\" & "Classes\Class" & ClassNum & ".ini", "STARTUP", "Shield"))
            If item(ItemNum).type = ITEM_TYPE_SHIELD Then
                i = FindOpenInvSlot(index, ItemNum)
                Call SetPlayerInvItemNum(index, i, ItemNum)
                Call SetPlayerInvItemValue(index, i, GetPlayerInvItemValue(index, i) + 1)
                Call SetPlayerInvItemDur(index, i, item(ItemNum).data1)
                Call SetPlayerShieldSlot(index, i)
            End If
            ItemNum = Val(GetVar(App.Path & "\" & "Classes\Class" & ClassNum & ".ini", "STARTUP", "Armor"))
            If item(ItemNum).type = ITEM_TYPE_ARMOR Then
                i = FindOpenInvSlot(index, ItemNum)
                Call SetPlayerInvItemNum(index, i, ItemNum)
                Call SetPlayerInvItemValue(index, i, GetPlayerInvItemValue(index, i) + 1)
                Call SetPlayerInvItemDur(index, i, item(ItemNum).data1)
                Call SetPlayerArmorSlot(index, i)
            End If
            ItemNum = Val(GetVar(App.Path & "\" & "Classes\Class" & ClassNum & ".ini", "STARTUP", "Helmet"))
            If item(ItemNum).type = ITEM_TYPE_HELMET Then
                i = FindOpenInvSlot(index, ItemNum)
                Call SetPlayerInvItemNum(index, i, ItemNum)
                Call SetPlayerInvItemValue(index, i, GetPlayerInvItemValue(index, i) + 1)
                Call SetPlayerInvItemDur(index, i, item(ItemNum).data1)
                Call SetPlayerHelmetSlot(index, i)
            End If
            
        ' Append name to file
        f = FreeFile
        Open App.Path & "\accounts\charlist.txt" For Append As #f
            Print #f, Name
        Close #f
        
        Call SavePlayer(index)
            
        Exit Sub
    End With
    End If
End Sub

Sub DelChar(ByVal index As Long, ByVal CharNum As Long)
Dim f1 As Long, f2 As Long
Dim s As String

    Call DeleteName(Player(index).Char(CharNum).Name)
    Call ClearChar(index, CharNum)
    Call SavePlayer(index)
End Sub

Function FindChar(ByVal Name As String) As Boolean
Dim f As Long
Dim s As String

    FindChar = False
    
    f = FreeFile
    Open App.Path & "\accounts\charlist.txt" For Input As #f
        Do While Not EOF(f)
            Input #f, s
            
            If Trim$(LCase$(s)) = Trim$(LCase$(Name)) Then
                FindChar = True
                Close #f
                Exit Function
            ElseIf Trim$(LCase$(s)) = Trim$(Name) Then
                FindChar = True
                Close #f
                Exit Function
            ElseIf Trim$(LCase$(s)) = Trim$(UCase$(Name)) Then
                FindChar = True
                Close #f
                Exit Function
            End If
        Loop
    Close #f
End Function

Sub SaveAllPlayersOnline()
Dim i As Long

    For i = 1 To MAX_PLAYERS
        If IsPlaying(i) Then Call SavePlayer(i)
    Next i
End Sub

Sub LoadClasses()
Dim FileName As String
Dim i As Long

    Call CheckClasses
    
    FileName = App.Path & "\Classes\info.ini"
    
    Max_Classes = Val(GetVar(FileName, "INFO", "MaxClasses"))
    If Max_Classes <= 0 Then Max_Classes = 1
    
    ReDim Classe(0 To Max_Classes) As ClassRec
    
    Call ClearClasses
    
    For i = 0 To Max_Classes
        Call SetStatus("Chargement des classes... " & i & "/" & Max_Classes)
        FileName = App.Path & "\Classes\Class" & i & ".ini"
        If FileExist(FileName, False) Then
            Classe(i).Name = GetVar(FileName, "CLASS", "Name")
            Classe(i).MaleSprite = Val(GetVar(FileName, "CLASS", "MaleSprite"))
            Classe(i).FemaleSprite = Val(GetVar(FileName, "CLASS", "FemaleSprite"))
            Classe(i).STR = Val(GetVar(FileName, "CLASS", "STR"))
            Classe(i).def = Val(GetVar(FileName, "CLASS", "DEF"))
            Classe(i).Speed = Val(GetVar(FileName, "CLASS", "SPEED"))
            Classe(i).magi = Val(GetVar(FileName, "CLASS", "MAGI"))
            Classe(i).Map = Val(GetVar(FileName, "CLASS", "MAP"))
            Classe(i).X = Val(GetVar(FileName, "CLASS", "X"))
            Classe(i).Y = Val(GetVar(FileName, "CLASS", "Y"))
            Classe(i).Locked = Val(GetVar(FileName, "CLASS", "Locked"))
        End If
        DoEvents
    Next i
End Sub

Sub SaveClasses()
Dim FileName As String
Dim i As Long

    FileName = App.Path & "\Classes\info.ini"
    
    If Not FileExist("Classes\info.ini") Then
        Call PutVar(FileName, "INFO", "MaxClasses", 3)
        Call PutVar(FileName, "INFO", "MaxSkills", 25)
        Call PutVar(FileName, "INFO", "StatPoints", 0)
        Call PutVar(FileName, "INFO", "SkillPoints", 0)
    End If
    
    If Max_Classes <= 0 Then Max_Classes = 3
    
    ReDim Classe(0 To Max_Classes) As ClassRec
    For i = 0 To Max_Classes
        Call SetStatus("Sauvegarde des classes... " & i & "/" & Max_Classes)
        DoEvents
        FileName = App.Path & "\Classes\Class" & i & ".ini"
        If Not FileExist("Classes\Class" & i & ".ini") Then
            Call PutVar(FileName, "CLASS", "Name", Trim$(Classe(i).Name))
            Call PutVar(FileName, "CLASS", "MaleSprite", STR$(Classe(i).MaleSprite))
            Call PutVar(FileName, "CLASS", "FemaleSprite", STR$(Classe(i).FemaleSprite))
            Call PutVar(FileName, "CLASS", "STR", STR$(Classe(i).STR))
            Call PutVar(FileName, "CLASS", "DEF", STR$(Classe(i).def))
            Call PutVar(FileName, "CLASS", "SPEED", STR$(Classe(i).Speed))
            Call PutVar(FileName, "CLASS", "MAGI", STR$(Classe(i).magi))
            Call PutVar(FileName, "CLASS", "MAP", STR$(Classe(i).Map))
            Call PutVar(FileName, "CLASS", "X", STR$(Classe(i).X))
            Call PutVar(FileName, "CLASS", "Y", STR$(Classe(i).Y))
            Call PutVar(FileName, "CLASS", "Locked", STR$(Classe(i).Locked))
        End If
    Next i
End Sub

Sub CheckClasses()
    If Not FileExist("Classes\info.ini") Then Call SaveClasses
End Sub

Sub SaveItems()
Dim i As Long
        
    Call SetStatus("Sauvegarde des objets... ")
    For i = 1 To MAX_ITEMS
        If Not FileExist("items\item" & i & ".fco") Then
            Call SetStatus("Sauvegarde l'objet... " & i & "/" & MAX_ITEMS)
            DoEvents
            Call SaveItem(i)
        End If
    Next i
End Sub

Sub SaveItem(ByVal ItemNum As Long)
Dim FileName As String
Dim f  As Long
FileName = App.Path & "\items\item" & ItemNum & ".fco"
        
    f = FreeFile
    Open FileName For Binary As #f
        Put #f, , item(ItemNum)
    Close #f
End Sub

Sub LoadItems()
Dim FileName As String
Dim i As Long
Dim f As Long

    'Call CheckItems
    Call ClearItems
    
    For i = 1 To MAX_ITEMS
        Call SetStatus("Chargement des objets... " & i & "/" & MAX_ITEMS)
        
        FileName = App.Path & "\Items\Item" & i & ".fco"
        If FileExist(FileName, False) Then
            f = FreeFile
            Open FileName For Binary As #f
                Get #f, , item(i)
            Close #f
        End If
        DoEvents
    Next i
End Sub

Sub CheckItems()
    Call SaveItems
End Sub

Sub SavePets()
Dim i As Long
        
    Call SetStatus("Sauvegarde des familliers... ")
    For i = 1 To MAX_PETS
        If Not FileExist("Pets\Pet" & i & ".fcf") Then
            Call SetStatus("Sauvegarde du famillier... " & i & "/" & MAX_PETS)
            DoEvents
            Call SavePet(i)
        End If
    Next i
End Sub

Sub SavePet(ByVal PetNum As Long)
Dim FileName As String
Dim f  As Long
FileName = App.Path & "\Pets\Pet" & PetNum & ".fcf"
        
    f = FreeFile
    Open FileName For Binary As #f
        Put #f, , Pets(PetNum)
    Close #f
End Sub

Sub LoadPets()
Dim i As Long
Dim FileName As String
Dim f  As Long

    'Call SavePets
    Call ClearPets
    
    For i = 1 To MAX_PETS
        Call SetStatus("Chargement des familliers... " & i & "/" & MAX_PETS)
        
        FileName = App.Path & "\Pets\Pet" & i & ".fcf"
        If FileExist(FileName, False) Then
            f = FreeFile
            Open FileName For Binary As #f
                Get #f, , Pets(i)
            Close #f
        End If
        DoEvents
    Next i
End Sub

Sub SaveMetiers()
Dim i As Long
        
    Call SetStatus("Sauvegarde des Metiers... ")
    For i = 1 To MAX_METIER
        If Not FileExist("Metiers\Metier" & i & ".fcm") Then
            Call SetStatus("Sauvegarde du Metiers... " & i & "/" & MAX_METIER)
            DoEvents
            Call SaveMetier(i)
        End If
    Next i
End Sub

Sub SaveMetier(ByVal metiernum As Long)
Dim FileName As String
Dim f  As Long
FileName = App.Path & "\Metiers\Metier" & metiernum & ".fcm"
        
    f = FreeFile
    Open FileName For Binary As #f
        Put #f, , metier(metiernum)
    Close #f
End Sub

Sub LoadMetiers()
Dim i As Long
Dim FileName As String
Dim f  As Long

    'Call SaveMetiers
    Call ClearMetiers
    
    For i = 1 To MAX_METIER
        Call SetStatus("Chargement des Metiers... " & i & "/" & MAX_METIER)
        
        FileName = App.Path & "\Metiers\Metier" & i & ".fcm"
        If FileExist(FileName, False) Then
            f = FreeFile
            Open FileName For Binary As #f
                Get #f, , metier(i)
            Close #f
        End If
        DoEvents
    Next i
End Sub

Sub Saverecettes()
Dim i As Long
        
    Call SetStatus("Sauvegarde des recettes... ")
    For i = 1 To MAX_RECETTE
        If Not FileExist("recettes\recette" & i & ".fcr") Then
            Call SetStatus("Sauvegarde du recettes... " & i & "/" & MAX_RECETTE)
            DoEvents
            Call Saverecette(i)
        End If
    Next i
End Sub

Sub Saverecette(ByVal recettenum As Long)
Dim FileName As String
Dim f  As Long
FileName = App.Path & "\recettes\recette" & recettenum & ".fcr"
        
    f = FreeFile
    Open FileName For Binary As #f
        Put #f, , recette(recettenum)
    Close #f
End Sub

Sub Loadrecettes()
Dim i As Long
Dim FileName As String
Dim f  As Long

    'Call Saverecettes
    Call ClearRecettes
    
    For i = 1 To MAX_RECETTE
        Call SetStatus("Chargement des recettes... " & i & "/" & MAX_RECETTE)
        
        FileName = App.Path & "\recettes\recette" & i & ".fcr"
        If FileExist(FileName, False) Then
            f = FreeFile
            Open FileName For Binary As #f
                Get #f, , recette(i)
            Close #f
        End If
        DoEvents
    Next i
End Sub

Sub SaveShops()
Dim i As Long

    Call SetStatus("Sauvegarde des magasins... ")
    For i = 1 To MAX_SHOPS
        If Not FileExist("shops\shop" & i & ".fcm") Then
            Call SetStatus("Sauvegarde des magasins... " & i & "/" & MAX_SHOPS)
            DoEvents
            Call SaveShop(i)
        End If
    Next i
End Sub

Sub SaveShop(ByVal ShopNum As Long)
Dim FileName As String
Dim f As Long

    FileName = App.Path & "\shops\shop" & ShopNum & ".fcm"
        
    f = FreeFile
    Open FileName For Binary As #f
        Put #f, , Shop(ShopNum)
    Close #f
End Sub

Sub LoadShops()
Dim FileName As String
Dim i As Long, f As Long

    'Call CheckShops
    Call ClearShops
    
    For i = 1 To MAX_SHOPS
        Call SetStatus("Chargement des magasins " & i & "/" & MAX_SHOPS)
        FileName = App.Path & "\shops\shop" & i & ".fcm"
        If FileExist(FileName, False) Then
            f = FreeFile
            Open FileName For Binary As #f
                Get #f, , Shop(i)
            Close #f
        End If
        DoEvents
    Next i
End Sub

Sub CheckShops()
    Call SaveShops
End Sub

Sub SaveSpell(ByVal SpellNum As Long)
Dim FileName As String
Dim f As Long

    FileName = App.Path & "\spells\spells" & SpellNum & ".fcg"
        
    f = FreeFile
    Open FileName For Binary As #f
        Put #f, , Spell(SpellNum)
    Close #f
End Sub

Sub SaveQuete(ByVal QueteNum As Long)
Dim FileName As String
Dim f As Long

    FileName = App.Path & "\quetes\quete" & QueteNum & ".fcq"
        
    f = FreeFile
    Open FileName For Binary As #f
        Put #f, , quete(QueteNum)
    Close #f
End Sub

Sub SaveSpells()
Dim i As Long

    Call SetStatus("Sauvegarde des sorts... ")
    For i = 1 To MAX_SPELLS
        If Not FileExist("spells\spells" & i & ".fcg") Then
            Call SetStatus("Sauvegarde des sorts... " & i & "/" & MAX_SPELLS)
            DoEvents
            Call SaveSpell(i)
        End If
    Next i
End Sub

Sub LoadSpells()
Dim FileName As String
Dim i As Long
Dim f As Long

    'Call CheckSpells
    Call ClearSpells
    
    For i = 1 To MAX_SPELLS
        Call SetStatus("Chargement des sorts... " & i & "/" & MAX_SPELLS)
        
        FileName = App.Path & "\spells\spells" & i & ".fcg"
        If FileExist(FileName, False) Then
            f = FreeFile
            Open FileName For Binary As #f
                Get #f, , Spell(i)
            Close #f
        End If
        DoEvents
    Next i
End Sub

Sub CheckSpells()
    Call SaveSpells
End Sub

Sub SaveNpcs()
Dim i As Long

    Call SetStatus("Sauvegarde des NPCs... ")
    
    For i = 1 To MAX_NPCS
        If Not FileExist("npcs\npc" & i & ".fcp") Then
            Call SetStatus("Sauvegarde des NPCs... " & i & "/" & MAX_NPCS)
            DoEvents
            Call SaveNpc(i)
        End If
    Next i
End Sub

Sub SaveNpc(ByVal npcnum As Long)
Dim FileName As String
Dim f As Long
FileName = App.Path & "\npcs\npc" & npcnum & ".fcp"
        
    f = FreeFile
    Open FileName For Binary As #f
        Put #f, , Npc(npcnum)
    Close #f
End Sub

Sub LoadNpcs()
Dim FileName As String
Dim i As Long
Dim z As Long
Dim f As Long

    'Call CheckNpcs
    Call ClearNpcs
    
    For i = 1 To MAX_NPCS
        Call SetStatus("Chargement des NPCs " & i & "/" & MAX_NPCS)
        FileName = App.Path & "\npcs\npc" & i & ".fcp"
        If FileExist(FileName, False) Then
            f = FreeFile
            Open FileName For Binary As #f
                Get #f, , Npc(i)
            Close #f
        End If
        DoEvents
    Next i
End Sub

Sub CheckNpcs()
    Call SaveNpcs
End Sub

Sub SaveMap(ByVal MapNum As Long)
Dim FileName As String
Dim f As Long

    FileName = App.Path & "\maps\map" & MapNum & ".fcc"
        
    f = FreeFile
    Open FileName For Binary As #f
        Put #f, , Map(MapNum)
    Close #f
End Sub

Sub LoadMaps()
Dim FileName As String
Dim i As Long
Dim f As Long

    'Call CheckMaps
    Call ClearMaps
    
    For i = 1 To MAX_MAPS
        Call SetStatus("Chargement des maps " & i & "/" & MAX_MAPS)
        FileName = App.Path & "\maps\map" & i & ".fcc"
        If FileExist(FileName, False) Then
            f = FreeFile
            Open FileName For Binary As #f
                Get #f, , Map(i)
            Close #f
        End If
        DoEvents
    Next i
End Sub

Sub LoadMap(ByVal MapNum As Long)
Dim FileName As String
Dim f As Long
            
    FileName = App.Path & "\maps\map" & MapNum & ".fcc"

    If Not FileExist("\maps\map" & MapNum & ".fcc") Then Exit Sub
    
    f = FreeFile
    Open FileName For Binary As #f
        Get #f, , Map(MapNum)
    Close #f
End Sub

Sub CheckMaps()
Dim FileName As String
Dim X As Long
Dim Y As Long
Dim i As Long
Dim n As Long

    Call ClearMaps
        
    For i = 1 To MAX_MAPS
        FileName = "maps\map" & i & ".fcc"
        
        ' Check to see if map exists, if it doesn't, create it.
        If Not FileExist(FileName) Then
            Call SetStatus("Sauvegarde des maps... " & i & "/" & MAX_MAPS)
            DoEvents
            
            Call SaveMap(i)
        End If
    Next i
End Sub

Sub LoadQuetes()
Dim FileName As String
Dim i As Long
Dim f As Long

    'Call CheckQuetes
    Call ClearQuetes
    
    For i = 1 To MAX_QUETES
        Call SetStatus("Chargement des Quetes " & i & "/" & MAX_QUETES)
        FileName = App.Path & "\quetes\quete" & i & ".fcq"
        If FileExist(FileName, False) Then
            f = FreeFile
            Open FileName For Binary As #f
                Get #f, , quete(i)
            Close #f
        End If
        DoEvents
    Next i
End Sub

Sub CheckQuetes()
Dim FileName As String
Dim X As Long
Dim Y As Long
Dim i As Long
Dim n As Long

    Call ClearQuetes
        
    For i = 1 To MAX_QUETES
        FileName = "quetes\quete" & i & ".fcq"
        
        ' Check to see if map exists, if it doesn't, create it.
        If Not FileExist(FileName) Then
            Call SetStatus("Sauvegarde des Quetes... " & i & "/" & MAX_QUETES)
            DoEvents
            
            Call SaveQuete(i)
        End If
    Next i
End Sub

Sub AddLog(ByVal text As String, ByVal FN As String)
Dim FileName As String
Dim f As Long
On Error Resume Next
    If ServerLog = True Then
        FileName = App.Path & "\" & FN
    
        If Not FileExist(FN) Then
            f = FreeFile
            Open FileName For Output As #f
            Close #f
        End If
    
        f = FreeFile
        Open FileName For Append As #f
            Print #f, Time & ": " & text
        Close #f
    End If
End Sub

Sub BanIndex(ByVal BanPlayerIndex As Long, ByVal BannedByIndex As Long)
Dim FileName, IP As String
Dim f As Long, i As Long

    FileName = App.Path & "\banlist.txt"
    
    ' Make sure the file exists
    If Not FileExist("banlist.txt") Then
        f = FreeFile
        Open FileName For Output As #f
        Close #f
    End If
    
    ' Cut off last portion of ip
    IP = GetPlayerIP(BanPlayerIndex)
            
    For i = Len(IP) To 1 Step -1
        If Mid$(IP, i, 1) = "." Then Exit For
    Next i
    IP = Mid$(IP, 1, i)
            
    f = FreeFile
    Open FileName For Append As #f
        Print #f, IP & "," & GetPlayerName(BannedByIndex)
    Close #f
    
    Call GlobalMsg(GetPlayerName(BanPlayerIndex) & " a �t� banni de " & GAME_NAME & " par " & GetPlayerName(BannedByIndex) & "!", White)
    Call AddLog(GetPlayerName(BannedByIndex) & " a banni " & GetPlayerName(BanPlayerIndex) & ".", ADMIN_LOG)
    Call IBMsg(GetPlayerName(BannedByIndex) & " a bannis " & GetPlayerName(BanPlayerIndex), IBCAdmin)
    Call AlertMsg(BanPlayerIndex, "Vous avez �t� banni par " & GetPlayerName(BannedByIndex) & "!")
End Sub

Sub DeleteName(ByVal Name As String)
Dim f1 As Long, f2 As Long
Dim s As String

    Call FileCopy(App.Path & "\accounts\charlist.txt", App.Path & "\accounts\chartemp.txt")
    
    ' Destroy name from charlist
    f1 = FreeFile
    Open App.Path & "\accounts\chartemp.txt" For Input As #f1
    f2 = FreeFile
    Open App.Path & "\accounts\charlist.txt" For Output As #f2
        
    Do While Not EOF(f1)
        Input #f1, s
        If Trim$(LCase$(s)) <> Trim$(LCase$(Name)) Then Print #f2, s
    Loop
    
    Close #f1
    Close #f2
    
    Call Kill(App.Path & "\accounts\chartemp.txt")
End Sub

Sub BanByServer(ByVal BanPlayerIndex As Long, ByVal Reason As String)
Dim FileName, IP As String
Dim f As Long, i As Long

    FileName = App.Path & "\banlist.txt"
    
    ' Make sure the file exists
    If Not FileExist("banlist.txt") Then
        f = FreeFile
        Open FileName For Output As #f
        Close #f
    End If
    
    ' Cut off last portion of ip
    IP = GetPlayerIP(BanPlayerIndex)
    
    For i = Len(IP) To 1 Step -1
        If Mid$(IP, i, 1) = "." Then Exit For
    Next i
    IP = Mid$(IP, 1, i)
            
    f = FreeFile
    Open FileName For Append As #f
        Print #f, IP & "," & "Server"
    Close #f
    
    If Trim$(Reason) <> vbNullString Then
        Call GlobalMsg(GetPlayerName(BanPlayerIndex) & " a �t� banni de " & GAME_NAME & " par l'admin du serveur! Raison:(" & Reason & ")", White)
        Call AlertMsg(BanPlayerIndex, "Vous avez �t� banni par l'admin du serveur!  Raison(" & Reason & ")")
        Call AddLog("Le serveur a banni " & GetPlayerName(BanPlayerIndex) & ".  Raison(" & Reason & ")", ADMIN_LOG)
    Else
        Call GlobalMsg(GetPlayerName(BanPlayerIndex) & " a �t� banni de " & GAME_NAME & " par l'admin du serveur!", White)
        Call AlertMsg(BanPlayerIndex, "Vous avez �t� banni par l'admin du serveur!")
        Call AddLog("Le serveur a banni " & GetPlayerName(BanPlayerIndex) & ".", ADMIN_LOG)
    End If
End Sub

Private Function Replace(strWord, strFind, strReplace, charAmount) As String
Dim a  As Integer

    a = InStr(1, UCase$(strWord), UCase$(strFind))
    On Error Resume Next
    strWord = Mid$(strWord, 1, a - 1) & strReplace & Right$(strWord, Len(strWord) - a - charAmount + 1)
    Replace = strWord
End Function

Sub SaveLogs()
Dim FileName As String
Dim i As String, C As String

    If LCase$(Dir(App.Path & "\logs", vbDirectory)) <> "logs" Then Call MkDir(App.Path & "\Logs")
    
    C = Time
    C = Replace(C, ":", ".", 1)
    C = Replace(C, ":", ".", 1)
    C = Replace(C, ":", ".", 1)
    
    i = Date
    i = Replace(i, "/", ".", 1)
    i = Replace(i, "/", ".", 1)
    i = Replace(i, "/", ".", 1)
    
    If LCase$(Dir(App.Path & "\logs\" & i, vbDirectory)) <> i Then Call MkDir(App.Path & "\Logs\" & i & "\")
    
    If LCase$(Dir(App.Path & "\logs\" & i & "\" & C, vbDirectory)) <> C Then Call MkDir(App.Path & "\Logs\" & i & "\" & C & "\")
        
    FileName = App.Path & "\Logs\" & i & "\" & C & "\Main.txt"
    Close
    Open FileName For Output As #1
        Print #1, frmServer.txtText(0).text
    Close #1
    
    FileName = App.Path & "\Logs\" & i & "\" & C & "\Broadcast.txt"
    Open FileName For Output As #1
        Print #1, frmServer.txtText(1).text
    Close #1
    
    FileName = App.Path & "\Logs\" & i & "\" & C & "\Global.txt"
    Open FileName For Output As #1
        Print #1, frmServer.txtText(2).text
    Close #1
    
    FileName = App.Path & "\Logs\" & i & "\" & C & "\Map.txt"
    Open FileName For Output As #1
        Print #1, frmServer.txtText(3).text
    Close #1
    
    FileName = App.Path & "\Logs\" & i & "\" & C & "\Private.txt"
    Open FileName For Output As #1
        Print #1, frmServer.txtText(4).text
    Close #1
    
    FileName = App.Path & "\Logs\" & i & "\" & C & "\Admin.txt"
    Open FileName For Output As #1
        Print #1, frmServer.txtText(5).text
    Close #1
    
    FileName = App.Path & "\Logs\" & i & "\" & C & "\Emote.txt"
    Open FileName For Output As #1
        Print #1, frmServer.txtText(6).text
    Close #1
End Sub

Sub LoadArrows()
Dim FileName As String
Dim i As Long

    'Call CheckArrows
    Call ClearArrows
    
    FileName = App.Path & "\Arrows.ini"
    
    For i = 1 To MAX_ARROWS
        Call SetStatus("Chargement des fl�ches... " & i & "/" & MAX_ARROWS)
        Arrows(i).Name = GetVar(FileName, "Arrow" & i, "ArrowName")
        Arrows(i).Pic = GetVar(FileName, "Arrow" & i, "ArrowPic")
        Arrows(i).Range = GetVar(FileName, "Arrow" & i, "ArrowRange")

        DoEvents
    Next i
End Sub

Sub CheckArrows()
    If Not FileExist("Arrows.ini") Then
        Dim i As Long
    
        For i = 1 To MAX_ARROWS
            Call SetStatus("Sauvegarde des fl�ches... " & i & "/" & MAX_ARROWS)
            DoEvents
            Call PutVar(App.Path & "\Arrows.ini", "Arrow" & i, "ArrowName", "")
            Call PutVar(App.Path & "\Arrows.ini", "Arrow" & i, "ArrowPic", 0)
            Call PutVar(App.Path & "\Arrows.ini", "Arrow" & i, "ArrowRange", 0)
        Next i
    End If
End Sub

Sub ClearArrows()
Dim i As Long

    For i = 1 To MAX_ARROWS
        Arrows(i).Name = vbNullString
        Arrows(i).Pic = 0
        Arrows(i).Range = 0
    Next i
End Sub

Sub SaveArrow(ByVal ArrowNum As Long)
Dim FileName As String

    FileName = App.Path & "\Arrows.ini"
    
    Call PutVar(FileName, "Arrow" & ArrowNum, "ArrowName", Trim$(Arrows(ArrowNum).Name))
    Call PutVar(FileName, "Arrow" & ArrowNum, "ArrowPic", Val(Arrows(ArrowNum).Pic))
    Call PutVar(FileName, "Arrow" & ArrowNum, "ArrowRange", Val(Arrows(ArrowNum).Range))
End Sub

Public Function GetPlayerQueteEtat(ByVal PIndex As Long, ByVal qindex As Long) As Boolean
    GetPlayerQueteEtat = False
    If Player(PIndex).Char(Player(PIndex).CharNum).QueteStatut(qindex) = 2 Then GetPlayerQueteEtat = True
End Function
