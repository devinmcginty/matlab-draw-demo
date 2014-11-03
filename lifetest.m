%{
	Rules:
	Any live cell with fewer than two live neighbours dies.
	Any live cell with two or three live neighbours lives.
	Any live cell with more than three live neighbours dies.
	Any dead cell with exactly three live neighbours becomes a live cell.	
%}

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
		lGrid = ones(50);
		lGrid(22,23) = 0;
		lGrid(24,22:23) = 0;
		lGrid(23,25) = 0;
		lGrid(24,26:28) = 0;
	%	Random
	case 6
		lGrid = randi([0 1],20,20);
	otherwise
		fprintf('Error encountered\n');
end


figure;
hold on;
while 1
	cla reset;
    imshow(lGrid,'InitialMagnification','fit');
    lGrid = generation(lGrid);
    pause(0.05);
    %drawnow;
end