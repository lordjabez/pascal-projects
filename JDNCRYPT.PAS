{=================================================================}

PROGRAM JDNCrypt (input, output);
	{This program is intended to encrypt and decrypt files.}

{=================================================================}

{$I-} {Error checking off}

{=================================================================}

USES
	Crt,
	Dos;

{=================================================================}

VAR
	menu_input: char;
	active_file: FILE OF byte;
	clearance: STRING;

{=================================================================}

PROCEDURE DisplayMenu;

	BEGIN {DisplayMenu}
		writeln ('Welcome to Jud''s encrypter.  Please make a selection.');
		writeln;
		writeln ('1. Encrypt a file');
		writeln ('2. Decrypt a file');
		writeln ('3. Exit the program');
	END; {DisplayMenu}

{------------------------------------}

PROCEDURE Beep (duration: word);

	BEGIN {Beep}
		Sound (440);
		Delay (duration);
		NoSound;
	END; {Beep}

{------------------------------------}

PROCEDURE PressKey;

	BEGIN {PressKey}
		writeln ('Press any key to continue');
		REPEAT UNTIL KeyPressed;
	END; {PressKey}

{------------------------------------}

PROCEDURE GetFile;

	TYPE
		Status=(Good, Bad);

	VAR
		file_name: STRING[12];
		file_status: Status;

	BEGIN {GetFile}
			REPEAT
				writeln ('Input the name of the file (with full path).');
				readln (file_name);
				assign (active_file, file_name);
				reset (active_file);
				IF (IOResult<>0) OR (length (file_name)=0)
					THEN BEGIN
						file_status:=Bad;
						writeln ('Invalid file name or file not found');
					END {THEN}
					ELSE file_status:=Good;
			UNTIL file_status=Good;
	END; {GetFile}

{------------------------------------}

FUNCTION Code: integer;

	VAR
		password: STRING[16];

	BEGIN {Code}
		writeln ('Enter a cool password (Sixteen characters maximum).');
		readln (Code);
	{Make the code here!!!}
	END; {Code}

{------------------------------------}

FUNCTION Rand (VAR seed: integer): integer;

	CONST
		MODULUS=65536;
		MULTIPLIER=25173;
		INCREMENT=13849;

	BEGIN {Rand}
		seed:=((MULTIPLIER*seed)+INCREMENT) MOD MODULUS;
		Rand:=round (seed/MODULUS*10);
	END; {Rand}

{------------------------------------}

PROCEDURE Crypt (shift_value: shortint);

	VAR
		b: byte;
		time_stamp: longint;
		password: integer;

	FUNCTION PercentageDone: Byte;
		BEGIN
			PercentageDone:=round (FilePos (active_file)/FileSize (active_file)*100)
		END; {PercentageDone}

	BEGIN {Crypt}
		ClrScr;
		GetFile;
		password:=Code;
		GetFTime (active_file, time_stamp);
		WHILE NOT Eof (active_file) DO
			BEGIN
				read (active_file, b);
				b:=b+(shift_value*Rand (password));
				Seek (active_file, FilePos (active_file)-1);
				write (active_file, b);
				{GotoXY (1,6);
				writeln (PercentageDone,'% Complete');}
			END; {WHILE}
		SetFTime (active_file, time_stamp);
		Close (active_file);
		writeln ('All done!');
		Beep (50);
		PressKey;
	END; {Crypt}

{=================================================================}

BEGIN {Main program}
	clearance:=ParamStr(1);
	IF clearance<>'StarWars' THEN Exit;
	REPEAT
		ClrScr;
		DisplayMenu;
		menu_input:=ReadKey;
		CASE menu_input OF
			'1': Crypt (1);
			'2': Crypt (-1);
		END;
	UNTIL menu_input='3';
END. {Main program}

{=================================================================}
