function neighbors = neighborhood(in, row, col)
	%	i is the row
	%	j is the column
	[y x] = size(in);
	%	rows
	if row == 1
		top = y;
		btm = row + 1;
	elseif row == y
		top = row - 1;
		btm = 1;
	else
		top = row - 1;
		btm = row + 1;
	end

	%	column
	if col == 1
		left = x;
		right = col + 1;
	elseif col == x
		left = col - 1;
		right = 1;
	else
		left = col - 1;
		right = col + 1;
	end

	neighbors = [in(top, left),	in(top,col),	in(top, right);
				 in(row, left),	in(row,col),	in(row,right);
				 in(btm,left),	in(btm,col),	in(btm, right)];
end