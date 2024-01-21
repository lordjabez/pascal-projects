{=============================================================================================================}
{=============================================================================================================}
{                                                                    
                                        {
}	PROGRAM The_Game(input,output);                               
                                           {
{                                                                    
                                        }
{=============================================================================================================}
{                                                                    
                                        }
{		Writen by Jud Neer                                    
                                               }
{                                                                    
                                        }
{		Features yet to be implemented: Data saving, screen
formatting                                        }
{                                                                    
                                        }
{		Duplicate solutions removed: Same operations with
identical results                                   }
{                                                                    
                                        }
{		Last Compile: January 21, 1999                        
                                               }
{                                                                    
                                        }
{=============================================================================================================}
{=============================================================================================================}


CONST

	 Version = 'v1.33';  {Must be three digits}

	 NumberOfDice = 5;  {If this is adjusted, MaxSolutions must be
inversely adjusted also to compensate}
	 MaxDigit = 6;  {This can be set as high as 9}

	 NumberOfOperations = NumberOfDice-1;

	 MaxSolutions = 2000;  {Number of unique solutions that can be
stored in memory}


{=============================================================================================================}
{=============================================================================================================}


TYPE

	digits = ARRAY[1..NumberOfDice] OF integer;
	operator_names = (addition, subtraction, multiplication,
division, exponentiation_forwards, exponentiation_backwards);
	operations = ARRAY[1..NumberOfOperations] OF RECORD
					 a, b: integer;
					 operator: operator_names;
				 END; {RECORD}
	expressions = RECORD
					  die: digits;
					  operation: operations;
					  result: integer;
				  END; {RECORD}
	solutions = ARRAY[1..MaxSolutions] OF expressions;


{=============================================================================================================}
{=============================================================================================================}


CONST
	 LastOperator: operator_names = exponentiation_backwards; 
{The most complex operation the solver use}


{=============================================================================================================}
{=============================================================================================================}


VAR
	goal: byte;
	solution_count: word;
	expression: expressions;
	solution: solutions;
	another: char;


{=============================================================================================================}
{=============================================================================================================}


PROCEDURE Initialize;

  
{==================================================================================}

	VAR
		counter: byte;

  
{==================================================================================}

	BEGIN {Initialize}

		goal:=0;
		solution_count:=0;

	END; {Initialize}


{=============================================================================================================}
{=============================================================================================================}


PROCEDURE GetValues (VAR expression: expressions; VAR goal: byte);

  
{==================================================================================}

	CONST
		ASCIIShift = ord('0');

  
{==================================================================================}

	VAR
		counter: word;

  
{==================================================================================}

	FUNCTION GetDigit: byte;

		VAR
			value: char;
			value_good: boolean;

	   {-------------------------------------------------------}

		BEGIN {GetDigit}
			REPEAT
				write('Digit ',counter,' = ');
				readln(value);
				IF (1<=ord(value)-ASCIIShift) AND
(ord(value)-ASCIIShift<=MaxDigit) THEN
					value_good:=true;
			UNTIL value_good;
			GetDigit:=ord(value)-ASCIIShift;
		END; {GetDigit}

  
{==================================================================================}

	BEGIN {GetValues}
		writeln('Please enter ',NumberOfDice,' digits (from 1
to ',MaxDigit,'), pressing ENTER after each one.');
		FOR counter:=1 TO NumberOfDice DO
			expression.die[counter]:=GetDigit;
		writeln;

		writeln('Please enter the goal number.');
		write('Goal = ');
		readln(goal);
		writeln;

	END; {GetValues}


{=============================================================================================================}
{=============================================================================================================}


PROCEDURE DisplayExpression (expression: expressions);

  
{==================================================================================}

	VAR
		counter: byte;

  
{==================================================================================}

	BEGIN {DisplayExpression}
		FOR counter:=1 TO NumberOfDice-1 DO
			write(expression.die[counter],', ');
		writeln(expression.die[NumberOfDice]);

		FOR counter:=1 TO NumberOfOperations DO
			WITH expression.operation[counter] DO
			CASE operator OF
				addition: write('(',a,'+',b,')  ');
				subtraction: IF a>b THEN
								 
write('(',a,'-',b,')  ')
							  ELSE
								 
write('(',b,'-',a,')  ');
				multiplication: write('(',a,'*',b,') 
');
				division: IF a>b THEN
								 
write('(',a,'/',b,')  ')
							  ELSE
								 
write('(',b,'/',a,')  ');
				exponentiation_forwards:
write('(',a,'^',b,')  ');
				exponentiation_backwards:
write('(',b,'^',a,')  ');
			END; {CASE operator}

		writeln('=  ', expression.result);
		writeln;
	END; {DisplayExpression}


{=============================================================================================================}
{=============================================================================================================}


PROCEDURE Solve (die: digits);

  
{==================================================================================}

	TYPE
		digit_grid = ARRAY[1..NumberOfDice,1..NumberOfDice] OF
integer;
		good_operations = ARRAY[1..NumberOfOperations] OF
boolean;

	VAR
		digit: digit_grid;
		counter1, counter2: integer;
		operation_good: good_operations;
		expression_good, expression_unique: boolean;

  
{==================================================================================}

	PROCEDURE Evaluate (number_of_digits: byte);

		VAR
			first, second: byte;
			operator: operator_names;
			counter: byte;

	   {-------------------------------------------------------}

		FUNCTION CalculateOperation (a,b: integer; operator:
operator_names): integer;

		   {-----------------------------}

			FUNCTION Exponentiate (x, n: integer):
integer;
				CONST
					MaxExponent = 15;
					MaxValue = 65535;
				VAR
					power: integer;
				BEGIN
					IF n<MaxExponent THEN
							BEGIN
								FOR
power:=2 TO n DO
									BEGIN
										x:=x*x;
										IF
x>MaxValue THEN
											operation_good[NumberOfDice+1-number_of_digits]:=false;
									END;
{FOR}
								Exponentiate:=x;
							END {IF
n<MaxExponent}
						ELSE
							BEGIN
								Exponentiate:=0;
								operation_good[NumberOfDice+1-number_of_digits]:=false;
							END; {ELSE}
				END;

		   {-----------------------------}

			BEGIN {CalculateOperation}
				CASE operator OF
					addition:
CalculateOperation:=a+b;
					subtraction:
CalculateOperation:=abs (a-b);
					multiplication:
CalculateOperation:=a*b;
					division: IF (a*b>0) AND ((a
MOD b=0) OR (b MOD a=0)) THEN
									
 CASE a>b OF
										
 True: CalculateOperation:=a DIV b;
										
 False: CalculateOperation:=b DIV a;
									
 END {CASE digit[first]>digit[second]}
								 
ELSE
									
 BEGIN
										
 CalculateOperation:=0;
										
 operation_good[NumberOfDice+1-number_of_digits]:=false;
									
 END;
					exponentiation_forwards:
CalculateOperation:=Exponentiate(a,b);
					exponentiation_backwards:
CalculateOperation:=Exponentiate(b,a);
				END; {CASE operator}
			END; {CalculateOperation}

	   {-------------------------------------------------------}

		PROCEDURE ShiftDigits (number_of_digits: byte; pick:
byte; VAR digit: digit_grid);

			VAR
				counter: byte;

			BEGIN {ShiftDigits}
				FOR counter:=1 TO number_of_digits DO
					IF counter>=pick THEN
							digit[counter,number_of_digits-1]:=digit[counter+1,number_of_digits]
						ELSE
							digit[counter,number_of_digits-1]:=digit[counter,number_of_digits];
			END; {ShiftDigits}

	   {-------------------------------------------------------}

		PROCEDURE CheckResult (expression: expressions);

			VAR
				counter: word;

		   {-----------------------------}

			FUNCTION OperationsIdentical (operation1,
operation2: operations): boolean;
				VAR
					counter: byte;
				BEGIN {OperationsIdentical}
					OperationsIdentical:=true;
					FOR counter:=1 TO
NumberOfOperations DO
						BEGIN
							IF 
CalculateOperation(operation1[counter].a, operation1[counter].b,
operation1[counter].operator) <>
								CalculateOperation(operation2[counter].a,
operation2[counter].b, operation2[counter].operator) THEN
									OperationsIdentical:=false;
						END; {FOR}
				END; {OperationsIdentical}

		   {-----------------------------}

			PROCEDURE AddToSolutions;
				BEGIN {AddToSolutions}
					solution_count:=solution_count+1;
					IF
solution_count<=MaxSolutions THEN
							solution[solution_count]:=expression
						ELSE
							BEGIN
								writeln('WARNING
- Maximum solutions exceeded.  Current solution has been
truncated.');
								writeln;
							END; {ELSE}
				END; {AddToSolutions}

	   {-------------------------------------------------------}

			BEGIN {CheckResult}
				IF expression.result=goal THEN  {First
the result must match the goal}
					BEGIN
						FOR counter:=1 TO
NumberOfOperations DO
							IF
operation_good[counter]=false THEN
								expression_good:=false;
						IF expression_good
THEN  {Then the expression must be valid}
							IF
solution_count=0 THEN  {Then either it must be the first solution}
									AddToSolutions
								ELSE
									BEGIN
										FOR
counter:=1 TO solution_count DO
											IF
OperationsIdentical(expression.operation, solution[counter].operation)
THEN
												expression_unique:=false;
										IF
expression_unique THEN  {Or it must be unique}
											AddToSolutions;
									END;
{ELSE}
					END; {IF
expression.result=goal}
			END; {CheckResult}

	   {-------------------------------------------------------}

		BEGIN {Evaluate}
			FOR first:=1 TO number_of_digits-1 DO
				 FOR second:=first+1 TO
number_of_digits DO
					FOR operator:=addition TO
LastOperator DO
						BEGIN
							expression.operation[NumberOfDice+1-number_of_digits].a:=digit[first,number_of_digits];
							expression.operation[NumberOfDice+1-number_of_digits].b:=digit[second,number_of_digits];
							expression.operation[NumberOfDice+1-number_of_digits].operator:=operator;

							ShiftDigits
(number_of_digits, second, digit);
							digit[first,number_of_digits-1]:=CalculateOperation(digit[first,number_of_digits],
																				digit[second,number_of_digits],
operator);
							expression.result:=digit[1,1];

							IF
number_of_digits=2 THEN
									CheckResult(expression)
								ELSE
									Evaluate(number_of_digits-1);

							operation_good[NumberOfDice+1-number_of_digits]:=true;
							expression_good:=true;
							expression_unique:=true;

						END; {operator}

		END; {Evaluate}

  
{==================================================================================}

	BEGIN {Solve}
		FOR counter1:=1 TO NumberOfDice DO
			BEGIN
				FOR counter2:=1 TO NumberOfDice-1 DO
					digit[counter1,counter2]:=0;
				digit[counter1,NumberOfDice]:=die[counter1];
			END;

		FOR counter1:=1 TO NumberOfOperations DO
			operation_good[counter1]:=true;
		expression_good:=true;

		Evaluate(NumberOfDice);
	END; {Solve}


{=============================================================================================================}
{=============================================================================================================}


PROCEDURE PickDigits (iteration: byte);

  
{==================================================================================}

	VAR
		counter: byte;

  
{==================================================================================}

	BEGIN {PickDigits}
		WITH expression DO
			BEGIN
				FOR counter:=die[iteration] TO 3 DO
					IF (iteration<NumberOfDice)
AND (die[iteration+1]<=die[iteration]) THEN
							PickDigits
(iteration+1)
						ELSE
							BEGIN
								die[iteration]:=counter;
								Solve(die);
							END; {ELSE}
				FOR counter:=iteration TO NumberOfDice
DO
					die[counter]:=die[iteration-1]+1;
				die[iteration-1]:=die[iteration];
			END; {WITH}
	END; {PickDigits}


{=============================================================================================================}
{=============================================================================================================}


PROCEDURE DisplayResults;

  
{==================================================================================}

	CONST
		 ScreenRows = 25;
		 SolutionsPerScreen = (ScreenRows-4) DIV 3;

  
{==================================================================================}

	VAR
		counter: word;
		display_individually: char;

  
{==================================================================================}

	BEGIN {DisplayResults}
		IF solution_count>0 THEN
			BEGIN
				write('Digits: ');
				FOR counter:=1 TO NumberOfDice DO
					write(expression.die[counter],
' ');
				writeln;
				writeln('Goal: ',goal);
				writeln;

				write('A total of ',solution_count,'
unique solution');
				IF solution_count>1 THEN
						writeln ('s were
found.')
					ELSE
						writeln (' was
found.');
				writeln;

				write('Display each one individually?
');
				readln(display_individually);
				writeln;
				IF (display_individually='y') OR
(display_individually='Y') THEN
					FOR counter:=1 TO
solution_count DO
						BEGIN
							write('Solution
#',counter,' for ');
							DisplayExpression(solution[counter]);
							IF (counter
MOD SolutionsPerScreen)=0 THEN
								BEGIN
									writeln('Press
ENTER for more solutions.');
									readln;
								END;
{IF}
						END;
			END {IF solution_count>0}
			ELSE
				BEGIN
					writeln('No solutions
found!');
					writeln;
				END;
	END; {DisplayResults}


{=============================================================================================================}
{=============================================================================================================}


PROCEDURE CloseDown;

	BEGIN {CloseDown}

		writeln('Thanks for playing . . . have a great
day!');
		writeln;

	END; {CloseDown}


{=============================================================================================================}
{=============================================================================================================}


BEGIN {The Game}

	another:='y';

	writeln;
	writeln('|=======================|');
	writeln('| The Game Solver ',Version,' |');
	writeln('|  Written by Jud Neer  |');
	writeln('|=======================|');
	writeln;

	WHILE (another='Y') OR (another='y') DO
		BEGIN
			Initialize;
			GetValues(expression,goal);
			Solve(expression.die);
			DisplayResults;
			write('Enter another set of digits? ');
			readln(another);
			writeln;
		END; {WHILE another}

	CloseDown;

END. {Main Program}


{=============================================================================================================}
{=============================================================================================================}