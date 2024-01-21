PROGRAM GradeBook (input, output);


USES
	Printer,
	Crt,
	Dos;


CONST
	{Maximums for the student arrays}
	MAXIMUM_ASSIGNMENTS=50;
	MAXIMUM_TESTS=10;
	MAXIMUM_STUDENTS=30;
	MAXIMUM_TOTAL_STUDENTS=MAXIMUM_STUDENTS*5;

	{Message for all menus}
	MENU_MESSAGE='Press the number of your choice.';

	{Extended key codes}
	Escape=#27;



TYPE
	{These declarations set up the student record files}
	AveragingTimes=(Current,
					FirstQuarterInterim, EndOfFirstQuarter,
					SecondQuarterInterim, EndOfSecondQuarter,EndOfFirstSemester,
					ThirdQuarterInterim, EndOfThirdQuarter,
					FourthQuarterInterim, EndOfFourthQuarter, EndOfYear);

	GradeLevels=(Kindergarten, First, Second, Third, Fourth, Fifth, Sixth,
				 Seventh, Eighth, Freshman, Sophmore, Junior, Senior);

	PersonalRecord=RECORD
		last_name  : STRING [10];
		first_name : STRING [10];
		grade      : GradeLevels
		END;

	StudentRecord=RECORD
		personal          : PersonalRecord;
		average           : ARRAY [Current..EndOfYear] OF Real;
		assignment_scores : ARRAY [1..MAXIMUM_ASSIGNMENTS] OF Real;
		test_scores       : ARRAY [1..MAXIMUM_TESTS] OF Real
		END;

	StudentArray=ARRAY [1..MAXIMUM_STUDENTS] OF StudentRecord;


	StudentList=PACKED ARRAY [1..MAXIMUM_TOTAL_STUDENTS, Kindergarten..Senior] OF PersonalRecord;


VAR
	Student           :FILE OF StudentList;
	Student_In_Book   :FILE OF StudentArray;
	Default_Directory :STRING;
	User_Choice		  :char;

{------------------------------------------------------}

PROCEDURE Initialize;

	VAR
		config       : text;
		Video_Config : STRING [3];
		Video		 : Boolean;

	PROCEDURE Load_Configuration;

		BEGIN
			Assign (config, 'grade.cfg');
			Reset (config);
			Readln (config);
			Readln (config, Default_Directory);
			Readln (config);
			Readln (config, Video_Config);
			IF (Video_Config='Yes') THEN Video:=True
				ELSE Video:=False;
		END;

	PROCEDURE Set_Text_Mode;

		BEGIN
			TextMode (C80);
			DirectVideo:=Video;
			ClrScr;
			TextBackground (Black);
		END;

	BEGIN
		Load_Configuration;
		Set_Text_Mode;
	END;

{------------------------------------------------------}

PROCEDURE Draw_Screen;

	CONST
		MAXIMUM_ROWS=24;
		MAXIMUM_COLUMNS=80;

		DARK_BLOCK=#178;
		SOLID_BLOCK=#219;

	VAR
		x_location, y_location: integer;

	BEGIN
		{Sets the coordinates to full screen}
		Window (1, 1, 80, 25);

		{Sets colors for screen borders}
		TextColor (DarkGray);
		TextBackground (White);

		{Top}
		FOR x_location:=1 TO MAXIMUM_COLUMNS DO
			BEGIN
				GotoXY (x_location, 1);
				write (DARK_BLOCK);
			END;

		{Right Side}
		FOR y_location:=1 TO MAXIMUM_ROWS DO
			BEGIN
				GotoXY (MAXIMUM_COLUMNS, y_location);
				write (DARK_BLOCK);
			END;

		{Bottom}
		FOR x_location:=MAXIMUM_COLUMNS DOWNTO 1 DO
			BEGIN
				GotoXY (x_location, MAXIMUM_ROWS);
				write (DARK_BLOCK);
			END;

		{Left Side}
		FOR y_location:=MAXIMUM_ROWS DOWNTO 1 DO
			BEGIN
				GotoXY (1, y_location);
				write (DARK_BLOCK);
			END;


		{Middle}
		FOR y_location:=2 TO MAXIMUM_ROWS-1 DO
			FOR x_location:=2 TO MAXIMUM_COLUMNS-1 DO
				BEGIN
					GotoXY (x_location, y_location);
					write (SOLID_BLOCK);
				END;

		{Titles}
		GotoXY (29,1);
		write ('Gradebook - Version 1.0');
		GotoXY (26,24);
		write ('Copyright (c)1993 by Jud Neer');
	END;

{------------------------------------------------------}

PROCEDURE Draw_Window (width, height, window_color: integer;
					   window_title:STRING);

	CONST
		MEDIUM_BLOCK =#177;
		DARK_BLOCK   =#178;
		SOLID_BLOCK  =#219;

	VAR
		x, y, x_location, y_location : integer;
		title_length, title_position : integer;

	BEGIN
		x:=WhereX;
		y:=WhereY;


		{Sets colors for window borders}
		TextColor (window_color);
		TextBackground (White);

		{Top}
		FOR x_location:=x TO x+width DO
			BEGIN
				GotoXY (x_location, y);
				write (DARK_BLOCK);
			END;

		{Right Side}
		FOR y_location:=y TO y+height DO
			BEGIN
				GotoXY (x+width, y_location);
				write (DARK_BLOCK);
			END;

		{Bottom}
		FOR x_location:=x+width DOWNTO x DO
			BEGIN
				GotoXY (x_location, y+height);
				write (DARK_BLOCK);
			END;

		{Left Side}
		FOR y_location:=y+height DOWNTO y DO
			BEGIN
				GotoXY (x, y_location);
				write (DARK_BLOCK);
			END;


		{Middle}
		FOR y_location:=y+1 TO y+height-1 DO
			FOR x_location:=x+1 TO x+width-1 DO
				BEGIN
					GotoXY (x_location, y_location);
					write (SOLID_BLOCK);
				END;


		{Sets colors for window shadow}
		TextColor (DarkGray);
		TextBackground (Black);

		{Right Side Shadow}
		FOR y_location:=y+1 TO y+height+1 DO
			BEGIN
				GotoXY (x+width+1, y_location);
				write (MEDIUM_BLOCK);
			END;

		{Bottom Shadow}
		FOR x_location:=x+1 TO x+width+1 DO
			BEGIN
				GotoXY (x_location, y+height+1);
				write (MEDIUM_BLOCK);
			END;


		{Sets colors for window title}
		TextColor (White);
		TextBackground (window_color);

		{Window Title}
		title_length:=length (window_title);
		title_position:=round (x+(width/2)-(title_length/2));
		GotoXY (title_position, y);
		write (window_title);

		{Sets window coordinates}
		Window (x+2, y+2, x+width-2, y+height-2);

	END;

{------------------------------------------------------}

PROCEDURE Create_A_New_Gradebook;

	BEGIN
		Draw_Screen;
	END;

{------------------------------------------------------}

PROCEDURE Open_An_Old_Gradebook;

	BEGIN

	END;


{------------------------------------------------------}

PROCEDURE Edit_Student_List;

	CONST
		OPTION_1='Add students to list.';
		OPTION_2='Delete students from list.';
		OPTION_3='Sort student list.';
		OPTION_4='Advance the grade levels.';

	PROCEDURE Add_Students_To_List;

		BEGIN

		END;

	PROCEDURE Delete_Students_From_List;

		BEGIN

		END;

	PROCEDURE Sort_Student_List;

		BEGIN

		END;

	PROCEDURE Advance_Students_Grade_Levels;

		BEGIN

		END;

	BEGIN
		Draw_Screen;
		Assign (Student, 'Students.lst');
		Rewrite (Student);
		Reset (Student);
		GotoXY (62,5);
		Draw_Window (27, 20, Blue, 'Student List');
		GotoXY (1,1);
		writeln ('1. ',OPTION_1);
		writeln;
		writeln ('2. ',OPTION_2);
		writeln;
		writeln ('3. ',OPTION_3);
		writeln;
		writeln ('4. ',OPTION_4);
		writeln; writeln;
		writeln (MENU_MESSAGE);
		REPEAT
			User_Choice:=ReadKey;
			CASE User_Choice OF
				'1'	   : Add_Students_To_List;
				'2'    : Delete_Students_From_List;
				'3'    : Sort_Student_List;
				'4'    : Advance_Students_Grade_Levels;
				Escape :
				ELSE ;
			END;
		UNTIL (User_Choice=Escape);
	END;


{------------------------------------------------------}

PROCEDURE Main_Menu;

	CONST
		OPTION_1='Create a new gradebook.';
		OPTION_2='Open an old gradebook.';
		OPTION_3='Edit student list.';
		OPTION_4='Exit to DOS.';

	BEGIN
		{Draws the background screen}
		Draw_Screen;

		{Draws the menu window}
		GotoXY (20, 5);
		Draw_Window (40, 14, 1, 'Main Menu');

		{Writes the options on the menu}
		GotoXY (1,1);
		writeln ('1. ', OPTION_1);
		writeln;
		writeln ('2. ', OPTION_2);
		writeln;
		writeln ('3. ', OPTION_3);
		writeln;
		writeln ('4. ', OPTION_4);
		writeln; writeln;
		writeln (MENU_MESSAGE);

		{Repeats until user enters a choice, and then branches approprietly}
		REPEAT
			User_Choice:=ReadKey;
			CASE User_Choice OF
				'1': Create_A_New_Gradebook;
				'2': Open_An_Old_Gradebook;
				'3': Edit_Student_List;
				'4': ;
				ELSE ;
			END;
		UNTIL (User_Choice='4');
	END;

{======================================================}

BEGIN {Main Program}
	Initialize;
	Main_Menu;
END.

