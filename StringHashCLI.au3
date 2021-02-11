#NoTrayIcon
#include <Crypt.au3>
#include <cmdline.au3>

If Not StringInStr($CmdLineRaw, "str") Or $CmdLineRaw == "" Then
	ConsoleWrite("String Hash Tool - ALBANESE Lab " & Chr(184) & " 2018-2019" & @CRLF & @CRLF) ;
	ConsoleWrite("Usage:      " & @ScriptName & " --str <string> --alg <algorithm>" & @CRLF & @CRLF) ;
	ConsoleWrite("Algorithms: ") ;
	ConsoleWrite("MD2, MD4, MD5, SHA1, SHA-256, SHA-384, SHA-512" & @CRLF & @CRLF) ;
	ConsoleWrite("Example:    " & @ScriptName & " --str MyString001 (Default MD5)" & @CRLF) ;
	ConsoleWrite("            " & @ScriptName & ' --str "MyString 002" --alg sha-256' & @CRLF & @CRLF) ;
	ConsoleWrite("Written by Pedro Albanese" & @CRLF) ;
	ConsoleWrite("http://albanese.atwebpages.com" & @CRLF) ;
	Exit
Else
	If _CmdLine_KeyExists('alg') Then
		Local $algo = _CmdLine_Get('alg')
		If $algo = "MD2" Then
			$alg = $CALG_MD2
		ElseIf $algo = "MD4" Then
			$alg = $CALG_MD4
		ElseIf $algo = "MD5" Then
			$alg = $CALG_MD5
		ElseIf $algo = "SHA1" Then
			$alg = $CALG_SHA1
		ElseIf $algo = "SHA-256" Then
			$alg = $CALG_SHA_256
		ElseIf $algo = "SHA-384" Then
			$alg = $CALG_SHA_384
		ElseIf $algo = "SHA-512" Then
			$alg = $CALG_SHA_512
		Else
			ConsoleWrite("Error: Unknown Algorithm." & @CRLF) ;
			Exit
		EndIf
		Global $string = _CmdLine_Get('str')
	Else
		$alg = $CALG_MD5
		Global $string = _CmdLine_Get('str')
	EndIf
EndIf

_Crypt_Startup()

Example()

Func Example()
	Local $sOutput
	While True
		$sOutput &= ConsoleRead()
		If @error Then ExitLoop
		Sleep(25)
	WEnd
	If $sOutput == "" Then
		$sOutput = $string
	EndIf
	ConsoleWrite(StringReplace(StringLower(_Crypt_HashData($sOutput, $alg)), "0x", "")) ;
EndFunc   ;==>Example
