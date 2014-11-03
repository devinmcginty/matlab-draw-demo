function gameOfLife()
%GAMEOFLIFE - Generates and plays Conway's Game of Life
%
%	Rules of Conway's Game of Life:
%		Any live cell with fewer than two live neighbours dies.
%		Any live cell with two or three live neighbours lives.
%		Any live cell with more than three live neighbours dies.
%		Any dead cell with exactly three live neighbours becomes a live cell.
%
%	Created by:
%		Devin McGinty
%
%	Most recent edit March 14, 2014
%		Nested all functions in parent function
%

% ----- CODE BEGINS ----- %

	% ----- BEGIN SUBROUTINE DEFINITIONS ----- %

	function ret = life(neighborhood)
	%LIFE - Decides whether a given square lives or dies in the next generation
	%
	%Arguments:
	%	neighborhood - 9x9 grid around central square
	%
	%Returns:
	%	ret - Value of central grid after generation
		%
		%Note:	1 IS DEAD
		%		0 IS ALIVE
		nVal = sum(sum(neighborhood));
		%	Central cell is dead
		if neighborhood(2,2) == 1
			%	Generate dead cell with exactly three live neighbours.
			if nVal == 6
				ret = 0;
			else
			%	Otherwise, cell remains dead
				ret = 1;
			end
		%	Central cell is alive
		elseif neighborhood(2,2) == 0
			%	Kill cell with less than 2 neighbors
			if nVal >= 7
				ret = 1;
			%	Kill cell with more than 3 neighbors
			elseif nVal <= 4
				ret = 1;
			%	Survival
			else
				ret = 0;
			end
		end
	end

	function neighbors = neighborhood(in, row, col)
	%NEIGHBORHOOD - Creates a 9x9 grid of cells neighboring center cell
	%Wraps squares from the top to bottom, and left to right.
	%
	%Arguments:
	%	in - Complete game of life grid
	%	row - Row number to be evaluated
	%	col - Column number to be evaluated
	%
	%Returns:
	%	neighbors = 9x9 neighborhood around [col,row] in "in" matrix
		[y x] = size(in);

		%Top row wraps down
		if row == 1
			top = y;
			btm = row + 1;
		%Bottom row wraps up
		elseif row == y
			top = row - 1;
			btm = 1;
		%Any central row
		else
			top = row - 1;
			btm = row + 1;
		end

		%Left column wraps right.
		if col == 1
			left = x;
			right = col + 1;
		%Right column wraps left
		elseif col == x
			left = col - 1;
			right = 1;
		%Any central column
		else
			left = col - 1;
			right = col + 1;
		end

		%Neighborhood generation
		neighbors = [in(top, left),	in(top,col),	in(top, right);
					 in(row, left),	in(row,col),	in(row,right);
					 in(btm,left),	in(btm,col),	in(btm, right)];
	end

	function outGrid = generation(inGrid)
	%GENERATION - Creates new generation for given grid
	%
	%Arguments:
	%	inGrid - Full game of life grid
	%
	%Returns:
	%	outGrid - Next generation of life grid
		%	Find the size of the grid
		[y x] = size(inGrid);
		for row = 1:y
			for col = 1:x
				%	creates 3x3 grid for neighboring points
				neighbors = neighborhood(inGrid,row,col);
				outGrid(row,col) = life(neighbors);
			end
		end
	end

	function lGrid = genGrid(inGame)
	%GENGRID Generates a generation 0 game of life grid
	%
	%Arguments:
	%	inGame - Generation 0 integer from getStart
	%
	%Returns:
	%	lGrid - Generation 0 game of life grid
		switch inGame
			%	Glider
			case 1
				lGrid = ones(20);
				lGrid(3,2) = 0;
				lGrid(4,3) = 0;
				lGrid(2:4,4) = 0;
			%	LWSS
			case 2
				lGrid = ones(20);
				lGrid(10,9) = 0;
				lGrid(10,12) = 0;
				lGrid(11:13,8) = 0;
				lGrid(13,9:11) = 0;
				lGrid(12,12) = 0;
			%	Pulsar
			case 3
				lGrid = ones(21);
				lGrid(5,7:9) = 0;
				lGrid(5,13:15) = 0;
				lGrid(10,7:9) = 0;
				lGrid(10,13:15) = 0;
				lGrid(12,7:9) = 0;
				lGrid(12,13:15) = 0;
				lGrid(17,7:9) = 0;
				lGrid(17,13:15) = 0;
				lGrid(7:9,5) = 0;
				lGrid(13:15,5) = 0;
				lGrid(7:9,10) = 0;
				lGrid(13:15,10) = 0;
				lGrid(7:9,12) = 0;
				lGrid(13:15,12) = 0;
				lGrid(7:9,17) = 0;
				lGrid(13:15,17) = 0;
			%	Diehard
			case 4
				lGrid = ones(20);
				lGrid(5,8:9) = 0;
				lGrid(6,9) = 0;
				lGrid(4,14) = 0;
				lGrid(6,13:15) = 0;
			%	Acorn
			case 5
				fprintf('WUTFDSBO')
				lGrid = ones(50)
				lGrid(6:7,2:3) = 0;
				lGrid(4,14:15) = 0;
				lGrid(5,13) = 0;
				lGrid(5,17) = 0;
				lGrid(6:8,12) = 0;
				lGrid(6:8,18) = 0;
				lGrid(7,16) = 0;
				lGrid(7,19) = 0;
				lGrid(9,13) = 0;
				lGrid(9,17) = 0;
				lGrid(10,14:15) = 0;
				lGrid(4:6,22:23) = 0;
				lGrid(3,24) = 0;
				lGrid(7,24) = 0;
				lGrid(2:3,26) = 0;
				lGrid(7:8,26) = 0;
				lGrid(4:5,36:37) = 0;
			%	Random
			case 6
				lGrid = randi([0 1],40,40)
			otherwise
				fprintf('Error encountered\n');
		end
	end

	function inGame = getStart()
	%GETSTART - Prompts user for starting parameters for Game of Life
	%
	%Returns:
	%	inGame - Generation 0 integer
		inGame = 0;

		while inGame < 1 | inGame > 6
			clear all;
			close all;
			clc;
			fprintf('\n\n\tChoose game state:\n\n');
			fprintf('\t\t1. Glider (period 4 ship)\n')
			fprintf('\t\t2. LWSS (period 4 ship)\n')
			fprintf('\t\t3. Pulsar (period 3 oscillator)\n')
			fprintf('\t\t4. Diehard (130 gen Methuselah)\n')
			fprintf('\t\t5. Acorn (5206 gen Methuselah)\n')
			fprintf('\t\t6. Random spore\n\n\t')
			inGame = input('> ');
		end
	end

	function drawGame(lGrid,delay)
	%DRAWGAME Plays out game of life.
	%
	%Arguments:
	%	lGrid - Generation 0 Game of Life grid
	%	delay - Pause time (0.05ms seems to run fine for most situations)
		figure;
		hold on;
		while 1
			%cla reset is used to clear the image from stack memory
			cla reset;
		    imshow(lGrid,'InitialMagnification','fit');
		    lGrid = generation(lGrid);
		    pause(delay);
		end
	end

	% ----- END SUBROUTINE DEFINITIONS ----- %

	PAUSE = 0.05;
	inGame = getStart;
	lGrid = genGrid(inGame);
	drawGame(lGrid,PAUSE);

% ----- CODE ENDS ----- %

end



