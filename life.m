function ret = life(neighborhood)
%	NOTE:	1 IS DEAD
%			0 IS ALIVE
	nVal = sum(sum(neighborhood));
	%	dead
	if neighborhood(2,2) == 1
%		Any dead cell with exactly three live neighbours becomes a live cell.	
		if nVal == 6
			ret = 0;
		else
			ret = 1;
		end
	%	alive
	elseif neighborhood(2,2) == 0
%		Any live cell with fewer than two live neighbours dies.
		if nVal >= 7
			ret = 1;
%		Any live cell with more than three live neighbours dies.
		elseif nVal <= 4
			ret = 1;
%		Any live cell with two or three live neighbours lives.
		else
			ret = 0;
		end
	end
end