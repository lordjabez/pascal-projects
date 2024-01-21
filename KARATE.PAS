PROGRAM Karate_King (output);

USES Crt, MSGraph, KGraphic;

{-----------------------------------------------------------}

TYPE
	moves=(StandingStill, MovingRight, MovingLeft, DuckingDown, Ducking, StandingUp,
		   Punching, Kicking, LowPunching, LowKicking, BackFlipping,
		   GettingHit, FallingBack, OnTheGround);

	player_info=RECORD
		x,y:integer;  {Position of player.}
		hitrange:RECORD
			x1,y1,x2,y2:integer;
			END;
		direction:char;  {Which direction the player is facing.}
		status:RECORD
			move:moves;  {What action the player is currently in.}
			frame:integer;  {What frame of animation the player is in.}
			wait:integer;  {The current wait state of the player.}
			END;
		power:real;  {The remaining power of the player.}
		energy:real;
		power_bar_length:integer;  {The length of the power bar for the player.}
		energy_bar_length:integer;
		money:integer;  {Used by human player only to track money totals.}
		color:integer;  {Color of player's pants.}
		name:STRING;
		stamina:integer;  {How much damage a player can take.}
		strength, agility, quickness:real;  {Other self-explanitory stats.}
		END;

	players=ARRAY [1..4] OF player_info;

CONST
	UpArrow   = #72;  DownArrow  = #80;
	LeftArrow = #75;  RightArrow = #77;
	W=60;  {The wait state figure for all animation.}
	Step_Length=10;  {The length of each player's step.}
	Left_Border=20;
	Right_Border=299;

VAR
	player: players;  {The record that contains the player information.}
	video_check,font_check: integer;  {The variable that checks the video settings.}
	move, computer_move: char;  {The variables that hold the inputed moves.}
	p:integer;  {The variable used in the player loop.}
	pain:real;

{-----------------------------------------------------------}

PROCEDURE InitializeGame;

	VAR name_length:integer;

	PROCEDURE Players;
		BEGIN
			player[1].stamina:=50; player[1].strength:=1.0;
			player[1].agility:=1.0; player[1].quickness:=1.0;
			player[1].x:=75; player [1].y:=100;player[1].direction:='R';
			player[1].color:=41; player[1].status.move:=StandingStill;player[1].status.frame:=0;
			player[1].power:=player[1].stamina; player[1].energy:=player[1].stamina*4; player[1].status.wait:=0;
			player[1].hitrange.x1:=player[1].x-12; player[1].hitrange.x2:=player[1].x+12;
			player[1].hitrange.y1:=player[1].y-30; player[1].hitrange.y2:=player[1].y+35;
			player[1].name:='Jud';
			player[2].stamina:=50; player[2].strength:=1.0;
			player[2].agility:=1.0; player[2].quickness:=1.0;
			player[2].x:=245; player [2].y:=100;player[2].direction:='L';
			player[2].color:=33; player[2].status.move:=StandingStill;player[2].status.frame:=0;
			player[2].power:=player[2].stamina; player[2].energy:=player[2].stamina*4; player[2].status.wait:=0;
			player[2].quickness:=player[2].quickness*6;
			player[2].hitrange.x1:=player[2].x-12; player[2].hitrange.x2:=player[2].x+12;
			player[2].hitrange.y1:=player[2].y-30; player[2].hitrange.y2:=player[2].y+35;
			player[2].name:='Dave';
		END;

	PROCEDURE GraphicsMode;
		BEGIN
			video_check:=_SetVideoMode (_MRes256Color);
			IF (video_check=0) THEN BEGIN
				writeln ('Error, no VGA card detected.');
				video_check:=_SetVideoMode (_DefaultMode);
			halt (0);
			END;
			_ClearScreen (_GClearScreen);
		END;

	PROCEDURE Fonts;
		BEGIN
			font_check:=_RegisterFonts('*.Fon');
			IF (font_check<0) THEN BEGIN
				writeln ('Error, unable to register fonts.');
				halt (0);
			END;
		END;

	PROCEDURE Screen;
		BEGIN
			_SetColor (7);
			_Rectangle (_GFillInterior,0,136,319,199);
			font_check:=_SetFont ('t''Tms Rmn''h26w16'); _SetColor (0);
			_MoveTo (77,150);
			_OutGText ('Karate King');
			font_check:=_SetFont ('t''Tms Rmn''h16w9'); _SetColor (7);
			name_length:=length(player[1].name)*9;
			_MoveTo (90-(name_length DIV 2),0);
			_OutGText (player[1].name);
			name_length:=length(player[2].name);
			_MoveTo (230-(name_length DIV 2),0);
			_OutGText (player[2].name);
			FOR p:=1 TO 2 DO
				IF (player[p].direction='L') THEN LeftStandStill (player [p].x,player [p].y,player[p].color)
											 ELSE RightStandStill (player [p].x,player [p].y,player[p].color);

		END;

	BEGIN {Initialization procedure}
		Players;
		GraphicsMode;
		Fonts;
		Screen;
	END; {Initialization}

{-----------------------------------------------------------}

PROCEDURE TakingAHit (p:integer; d:char);

	VAR move_size:integer;

	BEGIN
		move_size:=round (pain);
		CASE d OF
			'L':BEGIN
					CASE player[p].status.frame OF
						0:	BEGIN
								LeftHit (player [p].x,player [p].y,0);
								player[p].x:=player[p].x+move_size; IF (player[p].x>Right_Border) THEN player[p].x:=Right_Border;
								player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
								player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
								LeftHit (player [p].x,player [p].y,player[p].color);
								player [p].status.frame:=1;player[p].status.wait:=round (W*pain*0.5);
							END;
						1:  BEGIN
								LeftHit (player [p].x,player [p].y,0);
								player[p].x:=player[p].x+move_size; IF (player[p].x>Right_Border) THEN player[p].x:=Right_Border;
								player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
								player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
								LeftHit (player [p].x,player[p].y,player[p].color);
								player [p].status.frame:=2;player[p].status.wait:=round (W*pain*0.5);
							END;
						2:	BEGIN
								LeftHit (player [p].x,player [p].y,0);
								player[p].x:=player[p].x+move_size; IF (player[p].x>Right_Border) THEN player[p].x:=Right_Border;
								player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
								player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
								LeftStandStill (player [p].x,player [p].y,player[p].color);
								player [p].status.move:=StandingStill;player[p].status.frame:=0;player[p].status.wait:=W*2;
							END;
					END;
				END;
			'R':BEGIN
					CASE player[p].status.frame OF
						0:	BEGIN
								RightHit (player [p].x,player [p].y,0);
								player[p].x:=player[p].x-move_size; IF (player[p].x<Left_Border) THEN player[p].x:=Left_Border;
								player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
								player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
								RightHit (player [p].x,player [p].y,player[p].color);
								player [p].status.frame:=1;player[p].status.wait:=round (W*pain*0.5);
							END;
						1:  BEGIN
								RightHit (player [p].x,player [p].y,0);
								player[p].x:=player[p].x-move_size; IF (player[p].x<Left_Border) THEN player[p].x:=Left_Border;
								player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
								player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
								RightHit (player [p].x,player[p].y,player[p].color);
								player [p].status.frame:=2;player[p].status.wait:=round (W*pain*0.5);
							END;
						2:	BEGIN
								RightHit (player [p].x,player [p].y,0);
								player[p].x:=player[p].x-move_size; IF (player[p].x<Left_Border) THEN player[p].x:=Left_Border;
								player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
								player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
								RightStandStill (player [p].x,player [p].y,player[p].color);
								player [p].status.move:=StandingStill;player[p].status.frame:=0;player[p].status.wait:=W*2;
							END;
					END;
				END;
		END;
	END;



PROCEDURE GetAHit (hitx,hity,p:integer; damage:real);
	BEGIN
		IF (p=1) THEN p:=2 ELSE p:=1;
		IF (hitx>player[p].hitrange.x1) AND (hitx<player[p].hitrange.x2)
								AND (hity>player[p].hitrange.y1)
								AND (hity<player[p].hitrange.y2)
		THEN BEGIN
			player[p].power:=player[p].power-damage;
			player[p].energy:=player[p].energy-damage*3;
			CASE player[p].status.move OF
				Kicking:BEGIN
						CASE player[p].direction OF
							'L':BEGIN
									CASE player[p].status.frame OF
										1:LeftKickFrame1 (player[p].x,player[p].y,0);
										2:LeftKickFrame2 (player[p].x,player[p].y,0);
										3:LeftKickFrame1 (player[p].x,player[p].y,0);
									END;
								END;
							'R':BEGIN
									CASE player[p].status.frame OF
										1:RightKickFrame1 (player[p].x,player[p].y,0);
										2:RightKickFrame2 (player[p].x,player[p].y,0);
										3:RightKickFrame1 (player[p].x,player[p].y,0);
									END;
								END;
						END;
					END;
				Punching:BEGIN
						CASE player[p].direction OF
							'L':LeftPunchFrame1 (player[p].x,player[p].y,0);
							'R':RightPunchFrame1 (player[p].x,player[p].y,0);
						END;
					END;
				StandingStill:BEGIN
						CASE player[p].direction OF
							'L':LeftStandStill (player[p].x,player[p].y,0);
							'R':RightStandStill (player[p].x,player[p].y,0);
						END;
					END;
				BackFlipping:BEGIN
						CASE player[p].direction OF
							'L':LeftStandStill (player[p].x,player[p].y,0);
							'R':RightStandStill (player[p].x,player[p].y,0);
						END;
					END;
				GettingHit:BEGIN
						CASE player[p].direction OF
							'L':LeftHit (player[p].x,player[p].y,0);
							'R':RightHit (player[p].x,player[p].y,0);
						END;
					END;
			END;
			player[p].status.frame:=0;
			player[p].status.move:=GettingHit;
			TakingAHit (p,player[p].direction);
		END
	END;

{-----------------------------------------------------------}

PROCEDURE StepLeft (p: integer;d: char);
	BEGIN
		player[p].energy:=player[p].energy-0.5;
		CASE d OF
			'L':BEGIN
					LeftStandStill (player [p].x,player [p].y,0);
					player[p].x:=player[p].x-Step_Length; IF (player[p].x<Left_Border) THEN player[p].x:=Left_Border;
					player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
					player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
					LeftStandStill (player [p].x,player [p].y,player[p].color);
					player[p].status.move:=StandingStill;player[p].status.wait:=round (player[p].quickness*0.05*W);
				END;
			'R':BEGIN
					RightStandStill (player [p].x,player [p].y,0);
					player[p].direction:='L';
					LeftStandStill (player [p].x,player [p].y,player[p].color);
					player[p].status.move:=StandingStill;player[p].status.wait:=round (player[p].quickness*0.05*W);
				END;
		END;
	END;



PROCEDURE StepRight (p: integer;d: char);
	BEGIN
		player[p].energy:=player[p].energy-0.5;
		CASE d OF
			'R':BEGIN
					RightStandStill (player [p].x,player [p].y,0);
					player[p].x:=player[p].x+Step_Length; IF (player[p].x>Right_Border) THEN player[p].x:=Right_Border;
					player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
					player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
					RightStandStill (player [p].x,player [p].y,player[p].color);
					player[p].status.move:=StandingStill;player[p].status.wait:=round (player[p].quickness*0.05*W);
				END;
			'L':BEGIN
					LeftStandStill (player [p].x,player [p].y,0);
					player[p].direction:='R';
					RightStandStill (player [p].x,player [p].y,player[p].color);
					player[p].status.move:=StandingStill;player[p].status.wait:=round (player[p].quickness*0.05*W);
				END;
		END;
	END;



PROCEDURE Duck (p:integer;d: char);
	BEGIN
		CASE d OF
			'L':BEGIN
					LeftStandStill (player[p].x,player[p].y,0);
					player[p].y:=player[p].y+22;
					player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
					player[p].hitrange.y1:=player[p].y-26; player[p].hitrange.y2:=player[p].y+13;
					DuckLeft (player[p].x,player[p].y,player[p].color);
					player[p].status.move:=Ducking;
				END;
			'R':BEGIN
					RightStandStill (player[p].x,player[p].y,0);
					player[p].y:=player[p].y+22;
					player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
					player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+20;
					DuckRight (player[p].x,player[p].y,player[p].color);
					player[p].status.move:=Ducking;
				END;
		END;
	END;


PROCEDURE StandUp (p:integer;d: char);
	BEGIN
		CASE d OF
			'L':BEGIN
					DuckLeft (player[p].x,player[p].y,0);
					player[p].y:=player[p].y-22;
					player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
					player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+20;
					LeftStandStill (player[p].x,player[p].y,player[p].color);
					player[p].status.move:=StandingStill;
				END;
			'R':BEGIN
					DuckRight (player[p].x,player[p].y,0);
					player[p].y:=player[p].y-22;
					player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
					player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+20;
					RightStandStill (player[p].x,player[p].y,player[p].color);
					player[p].status.move:=StandingStill;
				END;
		END;
	END;



PROCEDURE Kick (p: integer;d: char);

	VAR
		hitx,hity:integer;

	BEGIN {Kick procedure}
		player[p].energy:=player[p].energy-player[p].strength;
		CASE d OF
			'L':BEGIN
					CASE player[p].status.frame OF
						0:	BEGIN
								LeftStandStill (player [p].x,player [p].y,0);
								LeftKickFrame1 (player [p].x,player [p].y,player[p].color);
								player[p].status.frame:=1;player[p].status.wait:=round (player[p].agility*W*0.75);
							END;
						1:  BEGIN
								LeftKickFrame1 (player [p].x,player [p].y,0);
								LeftKickFrame2 (player [p].x,player [p].y,player[p].color);
								pain:=2.0*player[p].strength;
								hitx:=player[p].x-30; hity:=player[p].y-14;
								GetAHit (hitx,hity,p,pain);
								player[p].status.frame:=2;player[p].status.wait:=round (player[p].agility*W);
							END;
						2:	BEGIN
								LeftKickFrame2 (player [p].x,player [p].y,0);
								LeftKickFrame1 (player [p].x,player [p].y,player[p].color);
								player[p].status.frame:=3;player[p].status.wait:=round (player[p].agility*W*0.75);
							END;
						3:  BEGIN
								LeftKickFrame1 (player [p].x,player [p].y,0);
								LeftStandStill (player [p].x,player [p].y,player[p].color);
								player[p].status.move:=StandingStill;player[p].status.frame:=0;player[p].status.wait:=round (player[p].agility*2*W);
							END;
					END;
				END;
			'R':BEGIN
					CASE player[p].status.frame OF
						0:	BEGIN
								RightStandStill (player [p].x,player [p].y,0);
								RightKickFrame1 (player [p].x,player [p].y,player[p].color);
								player[p].status.frame:=1;player[p].status.wait:=round (player[p].agility*W*0.75);
							END;
						1:  BEGIN
								RightKickFrame1 (player [p].x,player [p].y,0);
								RightKickFrame2 (player [p].x,player [p].y,player[p].color);
								pain:=2.0*player[p].strength;
								hitx:=player[p].x+30; hity:=player[p].y-14;
								GetAHit (hitx,hity,p,pain);
								player[p].status.frame:=2;player[p].status.wait:=round (player[p].agility*W);
							END;
						2:	BEGIN
								RightKickFrame2 (player [p].x,player [p].y,0);
								RightKickFrame1 (player [p].x,player [p].y,player[p].color);
								player[p].status.frame:=3;player[p].status.wait:=round (player[p].agility*W*0.75);
							END;
						3:  BEGIN
								RightKickFrame1 (player [p].x,player [p].y,0);
								RightStandStill (player [p].x,player [p].y,player[p].color);
								player[p].status.move:=StandingStill;player[p].status.frame:=0;player[p].status.wait:=round (player[p].agility*2*W);
							END;
					END;
				END;
		END;
	END; {Kick}

{-----------------------------------------------------------}

PROCEDURE Punch (p:integer; d:char);

	VAR
		hitx,hity:integer;

	BEGIN {Punch procedure}
		player[p].energy:=player[p].energy-player[p].strength;
		CASE d OF
			'L':BEGIN
					CASE player[p].status.frame OF
						0:	BEGIN
								LeftStandStill (player [p].x,player [p].y,0);
								LeftPunchFrame1 (player [p].x,player [p].y,player[p].color);
								pain:=1.0*player[p].strength;
								hitx:=player[p].x-28; hity:=player[p].y-18;
								GetAHit (hitx,hity,p,pain);
								player [p].status.frame:=1;player[p].status.wait:=round (player[p].agility*W);
							END;
						1:  BEGIN
								LeftPunchFrame1 (player [p].x,player [p].y,0);
								LeftStandStill (player [p].x,player[p].y,player[p].color);
								player [p].status.move:=StandingStill;player[p].status.frame:=0;player[p].status.wait:=round (player[p].agility*W);
							END;
					END;
				END;
			'R':BEGIN
					CASE player[p].status.frame OF
						0:	BEGIN
								RightStandStill (player [p].x,player [p].y,0);
								RightPunchFrame1 (player [p].x,player [p].y,player[p].color);
								pain:=1.0*player[p].strength;
								hitx:=player[p].x+28; hity:=player[p].y-18;
								GetAHit (hitx,hity,p,pain);
								player [p].status.frame:=1;player[p].status.wait:=round (player[p].agility*W);
							END;
						1:  BEGIN
								RightPunchFrame1 (player [p].x,player [p].y,0);
								RightStandStill (player [p].x,player[p].y,player[p].color);
								player [p].status.move:=StandingStill;player[p].status.frame:=0;player[p].status.wait:=round (player[p].agility*W);
							END;
					END;
				END;
		END;
	END; {Punch}


PROCEDURE LowPunch (p:integer; d:char);

	VAR	hitx,hity:integer;

	BEGIN {Low punch procedure}
		player[p].energy:=player[p].energy-player[p].strength;
		CASE d OF
			'L':BEGIN
					CASE player[p].status.frame OF
						0:	BEGIN
								DuckLeft (player [p].x,player [p].y,0);
								LeftLowPunchFrame1 (player [p].x,player [p].y,player[p].color);
								pain:=0.75*player[p].strength;
								hitx:=player[p].x-26; hity:=player[p].y-14;
								GetAHit (hitx,hity,p,pain);
								player [p].status.frame:=1;player[p].status.wait:=round (player[p].agility*W);
							END;
						1:  BEGIN
								LeftLowPunchFrame1 (player [p].x,player [p].y,0);
								DuckLeft (player [p].x,player[p].y,player[p].color);
								player [p].status.move:=Ducking;player[p].status.frame:=0;player[p].status.wait:=round (player[p].agility*W);
							END;
					END;
				END;
			'R':BEGIN
					CASE player[p].status.frame OF
						0:	BEGIN
								DuckRight (player [p].x,player [p].y,0);
								RightLowPunchFrame1 (player [p].x,player [p].y,player[p].color);
								pain:=1.0*player[p].strength;
								hitx:=player[p].x+26; hity:=player[p].y-14;
								GetAHit (hitx,hity,p,pain);
								player [p].status.frame:=1;player[p].status.wait:=round (player[p].agility*W);
							END;
						1:  BEGIN
								RightLowPunchFrame1 (player [p].x,player [p].y,0);
								DuckRight (player [p].x,player[p].y,player[p].color);
								player [p].status.move:=Ducking;player[p].status.frame:=0;player[p].status.wait:=round (player[p].agility*W);
							END;
					END;
				END;
		END;
	END; {Low punch}


PROCEDURE LowKick (p:integer; d:char);

	VAR hitx,hity:integer;

	BEGIN
		player[p].energy:=player[p].energy-player[p].strength;
		CASE d OF
			'L':BEGIN
					CASE player[p].status.frame OF
						0:	BEGIN
								DuckLeft (player [p].x,player [p].y,0);
								LeftLowKickFrame1 (player [p].x,player [p].y,player[p].color);
								player[p].status.frame:=1;player[p].status.wait:=round (player[p].agility*W*0.5);
							END;
						1:  BEGIN
								LeftLowKickFrame1 (player [p].x,player [p].y,0);
								LeftLowKickFrame2 (player [p].x,player [p].y,player[p].color);
								pain:=1.25*player[p].strength;
								hitx:=player[p].x-30; hity:=player[p].y+11;
								GetAHit (hitx,hity,p,pain);
								player[p].status.frame:=2;player[p].status.wait:=round (player[p].agility*W);
							END;
						2:	BEGIN
								LeftLowKickFrame2 (player [p].x,player [p].y,0);
								LeftLowKickFrame1 (player [p].x,player [p].y,player[p].color);
								player[p].status.frame:=3;player[p].status.wait:=round (player[p].agility*W*0.75);
							END;
						3:  BEGIN
								LeftLowKickFrame1 (player [p].x,player [p].y,0);
								DuckLeft (player [p].x,player [p].y,player[p].color);
								player[p].status.move:=Ducking;player[p].status.frame:=0;player[p].status.wait:=round (player[p].agility*2.5*W);
							END;
					END;
				END;
			'R':BEGIN
					CASE player[p].status.frame OF
						0:	BEGIN
								DuckRight (player [p].x,player [p].y,0);
								RightLowKickFrame1 (player [p].x,player [p].y,player[p].color);
								player[p].status.frame:=1;player[p].status.wait:=round (player[p].agility*W*0.5);
							END;
						1:  BEGIN
								RightLowKickFrame1 (player [p].x,player [p].y,0);
								RightLowKickFrame2 (player [p].x,player [p].y,player[p].color);
								pain:=1.25*player[p].strength;
								hitx:=player[p].x+30; hity:=player[p].y+11;
								GetAHit (hitx,hity,p,pain);
								player[p].status.frame:=2;player[p].status.wait:=round (player[p].agility*W);
							END;
						2:	BEGIN
								RightLowKickFrame2 (player [p].x,player [p].y,0);
								RightLowKickFrame1 (player [p].x,player [p].y,player[p].color);
								player[p].status.frame:=3;player[p].status.wait:=round (player[p].agility*W*0.75);
							END;
						3:  BEGIN
								RightLowKickFrame1 (player [p].x,player [p].y,0);
								DuckRight (player [p].x,player [p].y,player[p].color);
								player[p].status.move:=Ducking;player[p].status.frame:=0;player[p].status.wait:=round (player[p].agility*2.5*W);
							END;
					END;
				END;
		END;
	END; {Low kick}




PROCEDURE BackFlip (p:integer; d:char);

	CONST step_size=15;

	BEGIN
		player[p].energy:=player[p].energy-1;
		CASE d OF
			'L':BEGIN
					CASE player[p].status.frame OF
						0:	BEGIN
								LeftStandStill (player [p].x,player [p].y,0);
								player[p].x:=player[p].x+step_size; IF (player[p].x>Right_Border) THEN player[p].x:=Right_Border;
								player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
								player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
								LeftStandStill (player [p].x,player [p].y,player[p].color);
								player [p].status.frame:=1;player[p].status.wait:=round (player[p].agility*W);
							END;
						1:  BEGIN
								LeftStandStill (player [p].x,player [p].y,0);
								player[p].x:=player[p].x+step_size; IF (player[p].x>Right_Border) THEN player[p].x:=Right_Border;
								player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
								player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
								LeftStandStill (player [p].x,player[p].y,player[p].color);
								player [p].status.frame:=2;player[p].status.wait:=round (player[p].agility*W);
							END;
						2:	BEGIN
								LeftStandStill (player [p].x,player [p].y,0);
								player[p].x:=player[p].x+step_size; IF (player[p].x>Right_Border) THEN player[p].x:=Right_Border;
								player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
								player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
								LeftStandStill (player [p].x,player [p].y,player[p].color);
								player [p].status.frame:=3;player[p].status.wait:=round (player[p].agility*W);
							END;
						3:	BEGIN
								LeftStandStill (player [p].x,player [p].y,0);
								player[p].x:=player[p].x+step_size; IF (player[p].x>Right_Border) THEN player[p].x:=Right_Border;
								player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
								player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
								LeftStandStill (player [p].x,player [p].y,player[p].color);
								player [p].status.frame:=4;player[p].status.wait:=round (player[p].agility*W);
							END;
						4:	BEGIN
								LeftStandStill (player [p].x,player [p].y,0);
								player[p].x:=player[p].x+step_size; IF (player[p].x>Right_Border) THEN player[p].x:=Right_Border;
								player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
								player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
								LeftStandStill (player [p].x,player [p].y,player[p].color);
								player [p].status.frame:=5;player[p].status.wait:=round (player[p].agility*W);
							END;
						5:	BEGIN
								LeftStandStill (player [p].x,player [p].y,0);
								player[p].x:=player[p].x+step_size; IF (player[p].x>Right_Border) THEN player[p].x:=Right_Border;
								player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
								player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
								LeftStandStill (player [p].x,player [p].y,player[p].color);
								player [p].status.frame:=6;player[p].status.wait:=round (player[p].agility*W);
							END;
						6:	BEGIN
								LeftStandStill (player [p].x,player [p].y,0);
								player[p].x:=player[p].x+step_size; IF (player[p].x>Right_Border) THEN player[p].x:=Right_Border;
								player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
								player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
								LeftStandStill (player [p].x,player [p].y,player[p].color);
								player [p].status.move:=StandingStill;player[p].status.frame:=0;player[p].status.wait:=round (player[p].agility*W);
							END;
					END;
				END;
			'R':BEGIN
					CASE player[p].status.frame OF
						0:	BEGIN
								RightStandStill (player [p].x,player [p].y,0);
								player[p].x:=player[p].x-step_size; IF (player[p].x<Left_Border) THEN player[p].x:=Left_Border;
								player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
								player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
								RightStandStill (player [p].x,player [p].y,player[p].color);
								player [p].status.frame:=1;player[p].status.wait:=round (player[p].agility*W);
							END;
						1:  BEGIN
								RightStandStill (player [p].x,player [p].y,0);
								player[p].x:=player[p].x-step_size; IF (player[p].x<Left_Border) THEN player[p].x:=Left_Border;
								player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
								player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
								RightStandStill (player [p].x,player[p].y,player[p].color);
								player [p].status.frame:=2;player[p].status.wait:=round (player[p].agility*W);
							END;
						2:	BEGIN
								RightStandStill (player [p].x,player [p].y,0);
								player[p].x:=player[p].x-step_size; IF (player[p].x<Left_Border) THEN player[p].x:=Left_Border;
								player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
								player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
								RightStandStill (player [p].x,player [p].y,player[p].color);
								player [p].status.frame:=3;player[p].status.wait:=round (player[p].agility*W);
							END;
						3:	BEGIN
								RightStandStill (player [p].x,player [p].y,0);
								player[p].x:=player[p].x-step_size; IF (player[p].x<Left_Border) THEN player[p].x:=Left_Border;
								player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
								player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
								RightStandStill (player [p].x,player [p].y,player[p].color);
								player [p].status.frame:=4;player[p].status.wait:=round (player[p].agility*W);
							END;
						4:	BEGIN
								RightStandStill (player [p].x,player [p].y,0);
								player[p].x:=player[p].x-step_size; IF (player[p].x<Left_Border) THEN player[p].x:=Left_Border;
								player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
								player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
								RightStandStill (player [p].x,player [p].y,player[p].color);
								player [p].status.frame:=5;player[p].status.wait:=round (player[p].agility*W);
							END;
						5:	BEGIN
								RightStandStill (player [p].x,player [p].y,0);
								player[p].x:=player[p].x-step_size; IF (player[p].x<Left_Border) THEN player[p].x:=Left_Border;
								player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
								player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
								RightStandStill (player [p].x,player [p].y,player[p].color);
								player [p].status.frame:=6;player[p].status.wait:=round (player[p].agility*W);
							END;
						6:	BEGIN
								RightStandStill (player [p].x,player [p].y,0);
								player[p].x:=player[p].x-step_size; IF (player[p].x<Left_Border) THEN player[p].x:=Left_Border;
								player[p].hitrange.x1:=player[p].x-12; player[p].hitrange.x2:=player[p].x+12;
								player[p].hitrange.y1:=player[p].y-30; player[p].hitrange.y2:=player[p].y+35;
								RightStandStill (player [p].x,player [p].y,player[p].color);
								player [p].status.move:=StandingStill;player[p].status.frame:=0;player[p].status.wait:=round (player[p].agility*W);
							END;
					END;
				END;
		END;
	END;


{-----------------------------------------------------------}

PROCEDURE GetComputerInput;

	CONST
		most=37; least=27;

	VAR
		distance_right,distance_left:integer;
		left_test,right_test,attack_test:boolean;
		facing_left_test,facing_right_test:boolean;
		randoms:integer;
		test:boolean;
		previous:char;

	BEGIN
		distance_right:=player[2].x-player[1].x;
		distance_left:=player[1].x-player[2].x;
		left_test:=(distance_right>most) OR (distance_left<least);
		right_test:=(distance_left>most) OR (distance_right<least);
		facing_left_test:=(distance_right>distance_left) AND (player[2].direction='R');
		facing_right_test:=(distance_left>distance_right) AND (player[2].direction='L');
		attack_test:=(distance_right<most) AND (distance_right>least) OR
					 (distance_left<most) AND (distance_left>least);
		test:=(player[2].energy>10) AND (player[2].status.move=StandingStill) AND (player[2].status.wait=0);
		IF test THEN BEGIN
			IF attack_test THEN BEGIN
				randoms:=trunc (random(2));
				CASE randoms OF
					0:computer_move:='m';
					1:computer_move:='n';
				END;
			END
			ELSE BEGIN
					IF left_test OR facing_left_test THEN computer_move:=LeftArrow ELSE
					IF right_test OR facing_right_test THEN computer_move:=RightArrow;
			END;
			CASE computer_move OF
				'm': IF (player[2].energy>0) THEN player[2].status.move:=Kicking;
				'n': IF (player[2].energy>0) THEN player[2].status.move:=Punching;
				'v': IF (player[2].energy>0) THEN player[2].status.move:=BackFlipping;
				RightArrow:	IF (player[2].energy>0) THEN player[2].status.move:=MovingRight;
				LeftArrow:	IF (player[2].energy>0) THEN player[2].status.move:=MovingLeft;
			END;
		END
		ELSE BEGIN
			player[2].status.wait:=player[2].status.wait-1;
			IF (player[2].status.wait<0) THEN player[2].status.wait:=0;
		END;
	END;

{-----------------------------------------------------------}

PROCEDURE GetHumanInput;

	VAR test:boolean;

	BEGIN
		test:=(KeyPressed) AND (player[1].status.wait=0);
		IF test THEN BEGIN
			CASE player[1].status.move OF
				StandingStill:BEGIN
					move:=ReadKey; IF move=chr(0) THEN move:=ReadKey;
					CASE move OF
						'm': IF (player[1].energy>0) THEN player[1].status.move:=Kicking;
						'n': IF (player[1].energy>0) THEN player[1].status.move:=Punching;
						'v': IF (player[1].energy>0) THEN player[1].status.move:=BackFlipping;
						RightArrow:	IF (player[1].energy>0) THEN player[1].status.move:=MovingRight;
						LeftArrow:	IF (player[1].energy>0) THEN player[1].status.move:=MovingLeft;
						DownArrow: player[1].status.move:=DuckingDown;
						'q': player [1].stamina:=0;
					END;
				END;
				Ducking:BEGIN
					move:=ReadKey; IF move=chr(0) THEN move:=ReadKey;
					CASE move OF
						'm': IF (player[1].energy>0) THEN player[1].status.move:=LowKicking;
						'n': IF (player[1].energy>0) THEN player[1].status.move:=LowPunching;
						UpArrow: player[1].status.move:=StandingUp;
						'q': player [1].stamina:=0;
					END;
				END;
			END;
		END
		ELSE BEGIN
			player[1].status.wait:=player[1].status.wait-1;
			IF (player[1].status.wait<0) THEN player[1].status.wait:=0;
		END;
	END; {Human loop}



PROCEDURE UpdateScreen;
	BEGIN
		player[1].power_bar_length:=round ((100/player[1].stamina)*player[1].power);
		IF (player[1].energy<0) THEN player[1].energy_bar_length:=0
			ELSE player[1].energy_bar_length:=round ((100/(player[1].stamina*4))*player[1].energy);
		_SetColor (player[1].color);
		_Rectangle (_GFillInterior,39,16,39+player[1].power_bar_length,21);
		_SetColor (15);
		_Rectangle (_GFillInterior,40+player[1].power_bar_length,16,140,21);
		_SetColor (player[1].color);
		_Rectangle (_GFillInterior,39,23,39+player[1].energy_bar_length,28);
		_SetColor (15);
		_Rectangle (_GFillInterior,40+player[1].energy_bar_length,23,140,28);
		player[2].power_bar_length:=round ((100/player[2].stamina)*player[2].power);
		IF (player[2].energy<0) THEN player[2].energy_bar_length:=0
			ELSE player[2].energy_bar_length:=round ((100/(player[2].stamina*4))*player[2].energy);
		_SetColor (player[2].color);
		_Rectangle (_GFillInterior,179,16,179+player[2].power_bar_length,21);
		_SetColor (15);
		_Rectangle (_GFillInterior,180+player[2].power_bar_length,16,280,21);
		_SetColor (player[2].color);
		_Rectangle (_GFillInterior,179,23,179+player[2].energy_bar_length,28);
		_SetColor (15);
		_Rectangle (_GFillInterior,180+player[2].energy_bar_length,23,280,28);
		FOR p:=1 TO 2 DO BEGIN
			IF (player[p].status.wait=0) THEN BEGIN
				CASE player[p].status.move OF
					MovingLeft:StepLeft (p,player[p].direction);
					MovingRight:StepRight (p,player[p].direction);
					Kicking:Kick (p,player[p].direction);
					Punching:Punch (p,player[p].direction);
					LowPunching:LowPunch (p,player[p].direction);
					LowKicking:LowKick (p,player[p].direction);
					BackFlipping:BackFlip (p,player[p].direction);
					GettingHit:TakingAHit (p,player[p].direction);
					DuckingDown:Duck (p,player[p].direction);
					StandingUp:StandUp (p,player[p].direction);
					Ducking:BEGIN
							player[p].energy:=player[p].energy+0.05;
							IF (player[p].energy>player[p].stamina*4) THEN player[p].energy:=player[p].stamina*4;
						END;
					StandingStill:BEGIN
							player[p].energy:=player[p].energy+0.05;
							IF (player[p].energy>player[p].stamina*4) THEN player[p].energy:=player[p].stamina*4;
						END;
				END;
			END;
		END;
	END;

{===========================================================}

BEGIN {Main program}
	InitializeGame;
	WHILE (player[1].power>0) AND (player[2].power>0) DO BEGIN
		GetHumanInput;
		GetComputerInput;
		UpdateScreen;
	END;
	video_check:=_SetVideoMode (_DefaultMode);
END.
