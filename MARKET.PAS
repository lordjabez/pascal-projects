PROGRAM Stock_Market (input, output);
	{This is a simulation of the Stock Market game.}

USES
	Crt, MsGraph;

TYPE
	directions=(Either, Left, Right);

	companies=(None, Alcoa, American_Motors, John_Deere, General_Mills,
		International_Shoe, Maytag, Western_Publishing, Woolworth);

	stocks=ARRAY [Alcoa..Woolworth] OF integer;

	board=RECORD
		kind       :STRING;
		stock      :companies;
		direction  :directions;
		market	   :integer;
	      END; {record}

	space=ARRAY [1..48] OF board;

	player=RECORD
		name    :STRING;
		position:integer;
		stocks  :stocks;
		money   :integer;
		END; {record}

	persons=ARRAY [1..6] OF player;

	points=ARRAY [Alcoa..Woolworth,1..51] OF integer;

VAR

	players:persons;
	spaces:space;
	counter:integer;
	board_data, palette:text;
	tests:integer;
	dud:STRING;

CONST
	STOCK_VALUES:points=((30,34,38,42,46,50,54,58,62,66,70, {Alcoa}
				74,78,82,86,90,94,98,102,106,110,114,
				118,122,126,130,134,138,142,146,150,154,
				158,162,166,170,174,178,182,186,190,194,
				198,202,206,210,214,218,222,226,230),
			     (10,12,14,16,18,20,22,24,26,28,30, {American Motors}
				32,34,36,38,40,42,44,46,48,50,52,54,56,
				58,60,62,64,66,68,70,72,74,76,78,80,82,
				84,86,88,90,92,94,96,98,100,102,104,106,
				108,110),
			     (15,16,17,18,19,20,21,22,23,24,25, {John Deere}
				26,27,28,29,30,31,32,33,34,35,37,39,
				41,43,45,47,49,51,53,55,56,57,58,59,
				60,61,62,63,64,65,66,67,68,69,70,71,
				72,73,74,75),
			     (18,18,19,19,20,20,21,21,22,22,23, {General Mills}
				23,24,24,25,25,26,26,27,27,28,28,29,29,
				30,30,30,31,31,32,32,33,33,34,34,35,35,
				36,36,37,37,38,38,39,39,40,40,41,41,42,
				42),

			     (18,18,19,19,20,20,21,21,22,22,23, {International Shoe}
				23,24,24,25,25,26,26,27,27,28,28,29,29,
				30,30,30,31,31,32,32,33,33,34,34,35,35,
				36,36,37,37,38,38,39,39,40,40,41,41,42,
				42),
			     (15,16,17,18,19,20,21,22,23,24,25, {Maytag}
				26,27,28,29,30,31,32,33,34,35,37,39,
				41,43,45,47,49,51,53,55,56,57,58,59,
				60,61,62,63,64,65,66,67,68,69,70,71,
				72,73,74,75),
			     (10,12,14,16,18,20,22,24,26,28,30, {Western Publishing}
				32,34,36,38,40,42,44,46,48,50,52,54,56,
				58,60,62,64,66,68,70,72,74,76,78,80,82,
				84,86,88,90,92,94,96,98,100,102,104,106,
				108,110),
			     (30,34,38,42,46,50,54,58,62,66,70, {Woolworth}
				74,78,82,86,90,94,98,102,106,110,114,
				118,122,126,130,134,138,142,146,150,154,
				158,162,166,170,174,178,182,186,190,194,
				198,202,206,210,214,218,222,226,230));
{---------------------------------------------------------------------------}

FUNCTION AreYouSure:integer;

	VAR
		are_you_sure:char;

	BEGIN
		writeln ('Are you sure?');
		readln (are_you_sure);
		IF (are_you_sure='Y') THEN AreYouSure:=1
END; {function}

{---------------------------------------------------------------------------}

PROCEDURE SetPalette;

	VAR
		hex_code:longint;

	BEGIN
		assign (palette, 'PALETTE.DAT');
		reset (palette);
		FOR counter:=1 TO 10 DO BEGIN
			readln (palette, hex_code);
			tests:=_RemapPalette (counter, hex_code);
		END;
END; {procedure}

{---------------------------------------------------------------------------}

PROCEDURE BoardInitialization (VAR spaces:space);

	VAR
		board_kind:STRING;
		board_stock_num:integer;
		board_stock_name:companies;
		board_direction_num:integer;
		board_direction_name:directions;
		board_market:integer;
		board_null:STRING;

	BEGIN
		assign (board_data, 'BOARD.DAT');
		reset (board_data);
		FOR counter:=1 TO 48 DO BEGIN
			readln (board_data, board_kind);
			spaces [counter].kind:=board_kind;
			readln (board_data, board_stock_num);
			CASE board_stock_num OF
				0:board_stock_name:=None;
				1:board_stock_name:=Alcoa;
				2:board_stock_name:=American_Motors;
				3:board_stock_name:=John_Deere;
				4:board_stock_name:=General_Mills;
				5:board_stock_name:=International_Shoe;
				6:board_stock_name:=Maytag;
				7:board_stock_name:=Western_Publishing;
				8:board_stock_name:=Woolworth;
			     END;
			spaces [counter].stock:=board_stock_name;
			readln (board_data, board_direction_num);
			CASE board_direction_num OF
				0:board_direction_name:=Either;
				1:board_direction_name:=Left;
				2:board_direction_name:=Right;
			     END;
			spaces [counter].direction:=board_direction_name;
			readln (board_data, board_market);
			spaces [counter].market:=board_market;
			readln (board_data, board_null);
		END;
END; {procedure}

{---------------------------------------------------------------------------}

PROCEDURE DrawGameScreen (spaces:space);

	VAR
		counter_phase, fillX, fillY :integer;

	BEGIN
	_SetColor (10);
	_Rectangle (_GBorder,0,0,639, 479);
	_Rectangle (_GBorder,15,15,624,464);
	_FloodFill (1,1,10);
	_SetColor (9);
	_FloodFill (16,16,10);
	_SetColor (0);
	FOR counter:=1 TO 8 DO
		_Rectangle (_GBorder,32,40,32+(counter*72),54);
	_MoveTo (53,25);  _OutGText ('Alcoa');
	_MoveTo (107,25); _OutGText ('Amer. Motors');
	_MoveTo (185,25); _OutGText ('John Deere');
	_MoveTo (259,25); _OutGText ('Gen. Mills');
	_MoveTo (334,25); _OutGText ('Int. Shoe');
	_MoveTo (410,25); _OutGText ('Maytag');
	_MoveTo (467,25); _OutGText ('Western Pub.');
	_MoveTo (546,25); _OutGText ('Woolworth');
	_Rectangle (_GBorder,49,70,361,356);
	_Rectangle (_GBorder,73,70,337,356);
	_Rectangle (_GBorder,49,92,361,334);
	FOR counter:=1 TO 13 DO
		_Rectangle (_GBorder,49,70,49+(counter*24),92);
	FOR counter:=1 TO 13 DO
		_Rectangle (_GBorder,49,334,49+(counter*24),356);
	FOR counter:=1 TO 13 DO
		_Rectangle (_GBorder,49,70,73,70+(counter*22));
	FOR counter:=1 TO 13 DO
		_Rectangle (_GBorder,337,70,361,70+(counter*22));
	counter_phase:=1; fillX:=349; fillY:=345;
	FOR counter:=1 TO 48 DO BEGIN
		CASE spaces [counter].stock OF
			None              :_SetColor (15);
			Alcoa             :_SetColor (1);
			American_Motors   :_SetColor (2);
			John_Deere        :_SetColor (3);
			General_Mills     :_SetColor (4);
			International_Shoe:_SetColor (5);
			Maytag            :_SetColor (6);
			Western_Publishing:_SetColor (7);
			Woolworth	  :_SetColor (8);
		 END;

		 _FloodFill (fillX, fillY,0);
		 CASE counter OF
			13:counter_phase:=2;
			25:counter_phase:=3;
			37:counter_phase:=4;
		 END;
		 CASE counter_phase OF
			1:fillX:=fillX-24;
			2:fillY:=fillY-22;
			3:fillX:=fillX+24;
			4:fillY:=fillY+22;
		 END;
	END;
	_SetColor (15);
	_FloodFill (200,200,0);
	_SetColor (0);
	_Rectangle (_GBorder,121,92,289,114);
	_Rectangle (_GBorder,145,92,265,102);
	_Rectangle (_GBorder,121,312,289,334);
	_Rectangle (_GBorder,145,323,265,334);
	_Rectangle (_GBorder,73,136,97,290);
	_Rectangle (_GBorder,73,158,85,268);
	_Rectangle (_GBorder,337,136,313,290);
	_Rectangle (_GBorder,337,158,325,268);
	FOR counter:=1 TO 7 DO
		_Rectangle (_GBorder,121,102,121+(counter*24),114);
	FOR counter:=1 TO 7 DO
		_Rectangle (_GBorder,121,312,121+(counter*24),323);
	FOR counter:=1 TO 7 DO
		_Rectangle (_GBorder,85,136,97,136+(counter*22));
	FOR counter:=1 TO 7 DO
		_Rectangle (_GBorder,313,136,325,136+(counter*22));
	_Rectangle (_GBorder,141,126,269,299);
	FOR counter:=1 TO 4 DO
		_Rectangle (_GBorder,141,126,141+(counter*13),299);
	FOR counter:=1 TO 4 DO
		_Rectangle (_GBorder,217,126,217+(counter*13),299);
	FOR counter:=1 TO 4 DO BEGIN
		_SetColor (counter);
		_FloodFill (129+counter*13,127,0);
	END;
	FOR counter:=5 TO 8 DO BEGIN
		_SetColor (counter);
		_FloodFill (155+counter*13,127,0);
	END;
	_SetColor (0);
	FOR counter:=1 TO 51 DO BEGIN
		_MoveTo (141,134+(counter*3));
		_LineTo (269,134+(counter*3));
	END;
	_Rectangle (_GFillInterior,195,212,215,215);
	_SetGTextVector(0,1);
	_MoveTo (120,120);
	_OutGText ('Stock Market');

END; {procedure}

{===========================================================================}

BEGIN {Main Program}
	_ClearScreen (_GClearScreen);
	tests:=_SetVideoMode (_VRes16Color);
	IF (tests=0) THEN BEGIN {Graphics falure routine}
		writeln ('This program requires VGA graphics');
		tests:=_SetVideoMode (_DefaultMode);
		halt(1);
	END;
	SetPalette;
	tests:=_RegisterFonts ('*.FON');
	IF (tests<0) THEN BEGIN {Font falure routine}
		writeln ('Falure in registering fonts.');
		halt(1);
	END;
	tests:=_SetFont ('t''Modern''h12w6');
	IF (tests<0) THEN BEGIN {Font falure routine}
		writeln ('Falure in setting font.');
		halt(1);
	END;
	BoardInitialization(spaces);
	DrawGameScreen (spaces);
	readln (counter);
	tests:=_SetVideoMode (_DefaultMode);
END.

