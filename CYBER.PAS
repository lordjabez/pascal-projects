PROGRAM Cybernetic_Wars (input, output);



USES
	Crt,
	MsGraph;



CONST
	ScreenWidth=320;
	ScreenHeight=200;



TYPE
	MaximumX=0..ScreenWidth-1;
	MaximumY=0..ScreenHeight-1;

	RobotTypes=(Player, Enemy);


	{These are the two main objects, robots and lasers.}
	Robot=OBJECT
		{Location of robot}
		x : MaximumX;
		y : MaximumY;

		{Type of robot}
		Robot_Type : RobotTypes;


	END;

	Laser=OBJECT
		{Location of laser}
		x : MaximumX;
		y : MaximumY;


	END;



BEGIN
END.
