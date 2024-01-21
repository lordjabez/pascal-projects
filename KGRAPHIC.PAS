UNIT Karate_Graphics;

INTERFACE

USES Crt, MSGraph;

VAR thickness:integer;

			{Frames of Animation}
PROCEDURE RightStandStill (x,y,color:integer);
PROCEDURE LeftStandStill (x,y,color:integer);
PROCEDURE RightKickFrame1 (x,y,color:integer);
PROCEDURE RightKickFrame2 (x,y,color:integer);
PROCEDURE LeftKickFrame1 (x,y,color:integer);
PROCEDURE LeftKickFrame2 (x,y,color:integer);
PROCEDURE RightPunchFrame1 (x,y,color:integer);
PROCEDURE LeftPunchFrame1 (x,y,color:integer);
PROCEDURE LeftHit (x,y,color:integer);
PROCEDURE RightHit (x,y,color:integer);
PROCEDURE LeftFallBackFrame1 (x,y,color:integer);
PROCEDURE LeftFallBackFrame2 (x,y,color:integer);
PROCEDURE RightFallBackFrame1 (x,y,color:integer);
PROCEDURE RightFallBackFrame2 (x,y,color:integer);
PROCEDURE DuckLeft (x,y,color:integer);
PROCEDURE DuckRight (x,y,color:integer);
PROCEDURE LeftLowPunchFrame1 (x,y,color:integer);
PROCEDURE RightLowPunchFrame1 (x,y,color:integer);
PROCEDURE LeftLowKickFrame1 (x,y,color:integer);
PROCEDURE LeftLowKickFrame2 (x,y,color:integer);
PROCEDURE RightLowKickFrame1 (x,y,color:integer);
PROCEDURE RightLowKickFrame2 (x,y,color:integer);


IMPLEMENTATION

PROCEDURE RightStandStill (x,y,color: integer);

	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
			_SetColor (color);
			_MoveTo (x+thickness,y+0);
			_LineTo (x+thickness-10,y+0+35); {------------------------------Left leg}
			_MoveTo (x+thickness,y+0);
			_LineTo (x+thickness+10,y+0+35); {------------------------------Right leg}
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness,y+0);
			_LineTo (x+thickness,y+0-20);  {--------------------------------Torso}
			_MoveTo (x+thickness+4,y+0-5);
			_LineTo (x+thickness-9,y+0-8); {--------------------------------Right forearm}
			_LineTo (x+thickness,y+0-18); {---------------------------------Right upper arm}
			_LineTo (x+thickness+8,y+0-10); {-------------------------------Left upper arm}
			_LineTo (x+thickness+18,y+0-14); {------------------------------Left forearm}
			_Ellipse (_GFillInterior,x-5,y-30,x+5,y-20); {------Head}
		END;
	END;

{-----------------------------------------------------------}

PROCEDURE LeftStandStill(x,y,color: integer);
	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
			_SetColor (color);
			_MoveTo (x+thickness,y+0);
			_LineTo (x+thickness-10,y+0+35); {------------------------------Left leg}
			_MoveTo (x+thickness,y+0);
			_LineTo (x+thickness+10,y+0+35); {------------------------------Right leg}
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness,y+0);
			_LineTo (x+thickness,y+0-20);  {--------------------------------Torso}
			_MoveTo (x+thickness-4,y+0-5);
			_LineTo (x+thickness+9,y+0-8); {--------------------------------Right forearm}
			_LineTo (x+thickness,y+0-18); {---------------------------------Right upper arm}
			_LineTo (x+thickness-8,y+0-10); {-------------------------------Left upper arm}
			_LineTo (x+thickness-18,y+0-14); {------------------------------Left forearm}
			_Ellipse (_GFillInterior,x-5,y-30,x+5,y-20); {------Head}
		END;
	END;

PROCEDURE RightKickFrame1 (x,y,color: integer);
	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
			_SetColor (color);
			_MoveTo (x+thickness-6,y+0);
			_LineTo (x+thickness-10,y+0+35); {--------------------------Left leg}
			_MoveTo (x+thickness-6,y+0);
			_LineTo (x+thickness+8,y+0+8); {----------------------------Right thigh}
			_LineTo (x+thickness+12,y+0+24); {--------------------------Right calf}
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness-6,y+0);
			_LineTo (x+thickness-12,y+0-20); {--------------------------Torso}
			_MoveTo (x+thickness-4,y+0-18);
			_LineTo (x+thickness-10,y+0-5); {---------------------------Right forearm}
			_LineTo (x+thickness-12,y+0-18); {--------------------------Right upper arm}
			_LineTo (x+thickness-6,y+0-10); {---------------------------Left upper arm}
			_LineTo (x+thickness-1,y+0-2); {----------------------------Left forearm}
			_Ellipse (_GFillInterior,x-18,y-29,x-8,y-19); {-Head}
		END;
	END;

PROCEDURE RightKickFrame2 (x,y,color: integer);
	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
			_SetColor (color);
			_MoveTo (x+thickness-8,y+0+2);
			_LineTo (x+thickness-10,y+0+35); {--------------------------Left leg}
			_MoveTo (x+thickness-8,y+0+2);
			_LineTo (x+thickness+30,y+0-14); {--------------------------Kicking leg}
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness-8,y+0);
			_LineTo (x+thickness-15,y+0-15); {--------------------------Torso}
			_MoveTo (x+thickness+4,y+0-26);
			_LineTo (x+thickness-1,y+0-16); {---------------------------Right forearm}
			_LineTo (x+thickness-12,y+0-13); {--------------------------Right upper arm}
			_LineTo (x+thickness-18,y+0+4); {---------------------------Left arm}
			_Ellipse (_GFillInterior,x-21,y-25,x-11,y-15); {Head}
		END;
	END;

PROCEDURE LeftKickFrame1 (x,y,color: integer);
	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
			_SetColor (color);
			_MoveTo (x+thickness+6,y+0);
			_LineTo (x+thickness+10,y+0+35); {--------------------------Left leg}
			_MoveTo (x+thickness+6,y+0);
			_LineTo (x+thickness-8,y+0+8); {----------------------------Right thigh}
			_LineTo (x+thickness-12,y+0+24); {--------------------------Right calf}
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness+6,y+0);
			_LineTo (x+thickness+12,y+0-20); {--------------------------Torso}
			_MoveTo (x+thickness+4,y+0-18);
			_LineTo (x+thickness+10,y+0-5); {---------------------------Right forearm}
			_LineTo (x+thickness+12,y+0-18); {--------------------------Right upper arm}
			_LineTo (x+thickness+6,y+0-10); {---------------------------Left upper arm}
			_LineTo (x+thickness+1,y+0-2); {----------------------------Left forearm}
			_Ellipse (_GFillInterior,x+18,y-29,x+8,y-19); {-Head}
		END;
	END;

PROCEDURE LeftKickFrame2 (x,y,color: integer);
	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
			_SetColor (color);
			_MoveTo (x+thickness+8,y+0+2);
			_LineTo (x+thickness+10,y+0+35); {--------------------------Left leg}
			_MoveTo (x+thickness+8,y+0+2);
			_LineTo (x+thickness-30,y+0-14); {--------------------------Kicking leg}
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness+8,y+0);
			_LineTo (x+thickness+15,y+0-15); {--------------------------Torso}
			_MoveTo (x+thickness-4,y+0-26);
			_LineTo (x+thickness+1,y+0-16); {---------------------------Right forearm}
			_LineTo (x+thickness+12,y+0-13); {--------------------------Right upper arm}
			_LineTo (x+thickness+18,y+0+4); {---------------------------Left arm}
			_Ellipse (_GFillInterior,x+21,y-25,x+11,y-15); {Head}
		END;
	END;

PROCEDURE RightPunchFrame1 (x,y,color:integer);
	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
			_SetColor (color);
			_MoveTo (x+thickness,y+0);
			_LineTo (x+thickness-10,y+0+35); {--------------------------Left leg}
			_MoveTo (x+thickness,y+0);
			_LineTo (x+thickness+10,y+0+35); {--------------------------Right leg}
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness,y+0);
			_LineTo (x+thickness+4,y+0-20);  {--------------------------Torso}
			_MoveTo (x+thickness+6,y+0-5);
			_LineTo (x+thickness-6,y+0-8);   {--------------------------Right forearm}
			_LineTo (x+thickness+4,y+0-18);  {--------------------------Right upper arm}
			_LineTo (x+thickness+28,y+0-18); {--------------------------Punching arm}
			_Ellipse (_GFillInterior,x-1,y-30,x+9,y-20); {--Head}
		END;
	END;

PROCEDURE LeftPunchFrame1 (x,y,color:integer);
	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
		_SetColor (color);
		_MoveTo (x+thickness,y+0);
		_LineTo (x+thickness-10,y+0+35); {--------------------------Left leg}
		_MoveTo (x+thickness,y+0);
		_LineTo (x+thickness+10,y+0+35); {--------------------------Right leg}
		IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
		_MoveTo (x+thickness,y+0);
		_LineTo (x+thickness-4,y+0-20);  {--------------------------Torso}
		_MoveTo (x+thickness-6,y+0-5);
		_LineTo (x+thickness+6,y+0-8);   {--------------------------Right forearm}
		_LineTo (x+thickness-4,y+0-18);  {--------------------------Right upper arm}
		_LineTo (x+thickness-28,y+0-18); {--------------------------Punching arm}
		_Ellipse (_GFillInterior,x+1,y-30,x-9,y-20); {--Head}
		END;
	END;

PROCEDURE LeftHit (x,y,color:integer);
	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
		_SetColor (color);
		_MoveTo (x+thickness,y+0);
		_LineTo (x+thickness-10,y+0+35); {--------------------------Left leg}
		_MoveTo (x+thickness,y+0);
		_LineTo (x+thickness+10,y+0+35); {--------------------------Right leg}
		IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
		_MoveTo (x+thickness,y+0);
		_LineTo (x+thickness-6,y+0-20);  {--------------------------Torso}
		_MoveTo (x+thickness-8,y+0-5);
		_LineTo (x+thickness+4,y+0-8);   {--------------------------Right forearm}
		_LineTo (x+thickness-6,y+0-18);  {--------------------------Right upper arm}
		_LineTo (x+thickness-14,y+0-10); {--------------------------Left upper arm}
		_LineTo (x+thickness-24,y+0-14); {--------------------------Left forearm}
		_Ellipse (_GFillInterior,x-3,y-29,x-13,y-19); {--Head}
		END;
	END;

PROCEDURE RightHit (x,y,color:integer);
	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
		_SetColor (color);
		_MoveTo (x+thickness,y+0);
		_LineTo (x+thickness-10,y+0+35); {--------------------------Left leg}
		_MoveTo (x+thickness,y+0);
		_LineTo (x+thickness+10,y+0+35); {--------------------------Right leg}
		IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
		_MoveTo (x+thickness,y+0);
		_LineTo (x+thickness+6,y+0-20);  {--------------------------Torso}
		_MoveTo (x+thickness+8,y+0-5);
		_LineTo (x+thickness-4,y+0-8);   {--------------------------Right forearm}
		_LineTo (x+thickness+6,y+0-18);  {--------------------------Right upper arm}
		_LineTo (x+thickness+14,y+0-10); {--------------------------Left upper arm}
		_LineTo (x+thickness+24,y+0-14); {--------------------------Left forearm}
		_Ellipse (_GFillInterior,x+3,y-29,x+13,y-19); {--Head}
		END;
	END;

PROCEDURE DuckLeft (x,y,color:integer);
	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness,y);
			_LineTo (x+thickness,y-20);  {----------------------Torso}
			_SetColor (color);
			_MoveTo (x+thickness,y+4);
			_LineTo (x+thickness-6,y-8); {----------------------Left leg}
			_LineTo (x+thickness-10,y+13);
			_MoveTo (x+thickness,y+4);
			_LineTo (x+thickness+6,y-8);
			_LineTo (x+thickness+10,y+13); {--------------------Right leg}
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness-4,y-1);
			_LineTo (x+thickness+9,y-4); {----------------------Right forearm}
			_LineTo (x+thickness,y-14); {-----------------------Right upper arm}
			_LineTo (x+thickness-8,y-6); {----------------------Left upper arm}
			_LineTo (x+thickness-18,y-10); {--------------------Left forearm}
			_Ellipse (_GFillInterior,x-5,y-26,x+5,y-16); {------Head}
		END;
	END;

PROCEDURE DuckRight (x,y,color:integer);
	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness,y);
			_LineTo (x+thickness,y-20);  {----------------------Torso}
			_SetColor (color);
			_MoveTo (x+thickness,y+4);
			_LineTo (x+thickness+6,y-8); {----------------------Left leg}
			_LineTo (x+thickness+10,y+13);
			_MoveTo (x+thickness,y+4);
			_LineTo (x+thickness-6,y-8);
			_LineTo (x+thickness-10,y+13); {--------------------Right leg}
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness+4,y-1);
			_LineTo (x+thickness-9,y-4); {----------------------Right forearm}
			_LineTo (x+thickness,y-14); {-----------------------Right upper arm}
			_LineTo (x+thickness+8,y-6); {----------------------Left upper arm}
			_LineTo (x+thickness+18,y-10); {--------------------Left forearm}
			_Ellipse (_GFillInterior,x-5,y-26,x+5,y-16); {------Head}
		END;
	END;



PROCEDURE LeftLowPunchFrame1 (x,y,color:integer);
	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness,y);
			_LineTo (x+thickness-3,y-20);  {----------------------Torso}
			_SetColor (color);
			_MoveTo (x+thickness,y+4);
			_LineTo (x+thickness-6,y-8); {----------------------Left leg}
			_LineTo (x+thickness-10,y+13);
			_MoveTo (x+thickness,y+4);
			_LineTo (x+thickness+6,y-8);
			_LineTo (x+thickness+10,y+13); {--------------------Right leg}
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness-7,y-1);
			_LineTo (x+thickness+6,y-4); {----------------------Right forearm}
			_LineTo (x+thickness,y-14); {-----------------------Right upper arm}
			_LineTo (x+thickness-27,y-14); {--------------------Punching arm}
			_Ellipse (_GFillInterior,x-8,y-26,x+2,y-16); {------Head}
		END;
	END;

PROCEDURE RightLowPunchFrame1 (x,y,color:integer);
	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness,y);
			_LineTo (x+thickness+3,y-18);  {----------------------Torso}
			_SetColor (color);
			_MoveTo (x+thickness,y+4);
			_LineTo (x+thickness+6,y-8); {----------------------Left leg}
			_LineTo (x+thickness+10,y+13);
			_MoveTo (x+thickness,y+4);
			_LineTo (x+thickness-6,y-8);
			_LineTo (x+thickness-10,y+13); {--------------------Right leg}
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness+7,y-1);
			_LineTo (x+thickness-6,y-4); {----------------------Right forearm}
			_LineTo (x+thickness+3,y-14); {---------------------Right upper arm}
			_LineTo (x+thickness+27,y-14); {--------------------Punching arm}
			_Ellipse (_GFillInterior,x-2,y-26,x+8,y-16); {------Head}
		END;
	END;


PROCEDURE RightLowKickFrame1 (x,y,color:integer);
	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness,y+3);
			_LineTo (x+thickness-4,y-18);  {----------------------Torso}
			_SetColor (color);
			_MoveTo (x+thickness,y+3);
			_LineTo (x+thickness+12,y-1); {----------------------Left leg}
			_LineTo (x+thickness+20,y+13);
			_MoveTo (x+thickness,y+3);
			_LineTo (x+thickness-12,y+1);
			_LineTo (x+thickness-2,y+13); {---------------------Right leg}
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness,y+2);
			_LineTo (x+thickness-13,y-1); {----------------------Right forearm}
			_LineTo (x+thickness-4,y-11); {-----------------------Right upper arm}
			_LineTo (x+thickness+4,y-3); {----------------------Left upper arm}
			_LineTo (x+thickness+14,y-7); {--------------------Left forearm}
			_Ellipse (_GFillInterior,x-7,y-23,x+3,y-13); {------Head}
		END;
	END;


PROCEDURE RightLowKickFrame2 (x,y,color:integer);
	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness,y+6);
			_LineTo (x+thickness-8,y-14); {---------------------Torso}
			_SetColor (color);
			_MoveTo (x+thickness,y+6);
			_LineTo (x+thickness+30,y+11); {----------------------Left leg}
			_MoveTo (x+thickness,y+6);
			_LineTo (x+thickness-12,y+6);
			_LineTo (x+thickness,y+13); {---------------------Right leg}
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness-4,y+5);
			_LineTo (x+thickness-17,y+2); {----------------------Right forearm}
			_LineTo (x+thickness-8,y-8); {-----------------------Right upper arm}
			_LineTo (x+thickness,y); {----------------------Left upper arm}
			_LineTo (x+thickness+10,y-4); {--------------------Left forearm}
			_Ellipse (_GFillInterior,x-11,y-20,x-1,y-10); {------Head}
		END;
	END;


PROCEDURE LeftLowKickFrame1 (x,y,color:integer);
	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness,y+3);
			_LineTo (x+thickness+4,y-18);  {----------------------Torso}
			_SetColor (color);
			_MoveTo (x+thickness,y+3);
			_LineTo (x+thickness-12,y-1); {----------------------Left leg}
			_LineTo (x+thickness-20,y+13);
			_MoveTo (x+thickness,y+3);
			_LineTo (x+thickness+12,y+1);
			_LineTo (x+thickness+2,y+13); {---------------------Right leg}
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness,y+2);
			_LineTo (x+thickness+13,y-1); {----------------------Right forearm}
			_LineTo (x+thickness+4,y-11); {-----------------------Right upper arm}
			_LineTo (x+thickness-4,y-3); {----------------------Left upper arm}
			_LineTo (x+thickness-14,y-7); {--------------------Left forearm}
			_Ellipse (_GFillInterior,x+7,y-23,x-3,y-13); {------Head}
		END;
	END;


PROCEDURE LeftLowKickFrame2 (x,y,color:integer);
	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness,y+6);
			_LineTo (x+thickness+8,y-14); {---------------------Torso}
			_SetColor (color);
			_MoveTo (x+thickness,y+6);
			_LineTo (x+thickness-30,y+11); {----------------------Left leg}
			_MoveTo (x+thickness,y+6);
			_LineTo (x+thickness+12,y+6);
			_LineTo (x+thickness,y+13); {---------------------Right leg}
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness+4,y+5);
			_LineTo (x+thickness+17,y+2); {----------------------Right forearm}
			_LineTo (x+thickness+8,y-8); {-----------------------Right upper arm}
			_LineTo (x+thickness,y); {----------------------Left upper arm}
			_LineTo (x+thickness-10,y-4); {--------------------Left forearm}
			_Ellipse (_GFillInterior,x+11,y-20,x+1,y-10); {------Head}
		END;
	END;

PROCEDURE LeftFallBackFrame1 (x,y,color:integer);
	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness,y+3);
			_LineTo (x+thickness+4,y-18);  {----------------------Torso}
			_SetColor (color);
			_MoveTo (x+thickness,y+3);
			_LineTo (x+thickness-12,y-1); {----------------------Left leg}
			_LineTo (x+thickness-20,y+13);
			_MoveTo (x+thickness,y+3);
			_LineTo (x+thickness+12,y+1);
			_LineTo (x+thickness+2,y+13); {---------------------Right leg}
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness,y+2);
			_LineTo (x+thickness+13,y-1); {----------------------Right forearm}
			_LineTo (x+thickness+4,y-11); {-----------------------Right upper arm}
			_LineTo (x+thickness-4,y-3); {----------------------Left upper arm}
			_LineTo (x+thickness-14,y-7); {--------------------Left forearm}
			_Ellipse (_GFillInterior,x+7,y-23,x-3,y-13); {------Head}
		END;
	END;

PROCEDURE LeftFallBackFrame2 (x,y,color:integer);
	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness,y+6);
			_LineTo (x+thickness+12,y-10); {---------------------Torso}
			_SetColor (color);
			_MoveTo (x+thickness,y+6);
			_LineTo (x+thickness-30,y+11); {----------------------Left leg}
			_MoveTo (x+thickness,y+6);
			_LineTo (x+thickness+12,y+6);
			_LineTo (x+thickness,y+13); {---------------------Right leg}
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness+4,y+5);
			_LineTo (x+thickness+17,y+2); {----------------------Right forearm}
			_LineTo (x+thickness+8,y-8); {-----------------------Right upper arm}
			_LineTo (x+thickness,y); {----------------------Left upper arm}
			_LineTo (x+thickness-10,y-4); {--------------------Left forearm}
			_Ellipse (_GFillInterior,x+17,y-16,x+7,y-6); {------Head}
		END;
	END;

PROCEDURE RightFallBackFrame1 (x,y,color:integer);
	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness,y+3);
			_LineTo (x+thickness-4,y-18);  {----------------------Torso}
			_SetColor (color);
			_MoveTo (x+thickness,y+3);
			_LineTo (x+thickness+12,y-1); {----------------------Left leg}
			_LineTo (x+thickness+20,y+13);
			_MoveTo (x+thickness,y+3);
			_LineTo (x+thickness-12,y+1);
			_LineTo (x+thickness-2,y+13); {---------------------Right leg}
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness,y+2);
			_LineTo (x+thickness-13,y-1); {----------------------Right forearm}
			_LineTo (x+thickness-4,y-11); {-----------------------Right upper arm}
			_LineTo (x+thickness+4,y-3); {----------------------Left upper arm}
			_LineTo (x+thickness+14,y-7); {--------------------Left forearm}
			_Ellipse (_GFillInterior,x-7,y-23,x+3,y-13); {------Head}
		END;
	END;

PROCEDURE RightFallBackFrame2 (x,y,color:integer);
	BEGIN
		FOR thickness:=-1 TO 1 DO BEGIN
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness,y+6);
			_LineTo (x+thickness-12,y-10); {---------------------Torso}
			_SetColor (color);
			_MoveTo (x+thickness,y+6);
			_LineTo (x+thickness+30,y+11); {----------------------Left leg}
			_MoveTo (x+thickness,y+6);
			_LineTo (x+thickness-12,y+6);
			_LineTo (x+thickness,y+13); {---------------------Right leg}
			IF (color=0) THEN _SetColor (0) ELSE _SetColor (90);
			_MoveTo (x+thickness-4,y+5);
			_LineTo (x+thickness-17,y+2); {----------------------Right forearm}
			_LineTo (x+thickness-8,y-8); {-----------------------Right upper arm}
			_LineTo (x+thickness,y); {----------------------Left upper arm}
			_LineTo (x+thickness+10,y-4); {--------------------Left forearm}
			_Ellipse (_GFillInterior,x-15,y-16,x-5,y-6); {------Head}
		END;
	END;

END.
