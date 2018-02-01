/*
Submitted by: Nick Petro
Partner: Kevin Gilboy
0147 Midterm Project
This program solves Project Euler problem 150, where the smallest subtriangle must be identified out of a large triangle
*/

public class Euler150{
	private static int numRows = 1000, minSum, sumTri = 0;
	private static int [] data; //Array to contain triangle data
	private static int [] runSum; //Array to contain cumulative row sums

	public static void main(String [] args){
		//Initialize array with random numbers
		int numElements = (int) (.5*(Math.pow(numRows,2)+numRows));
		data = new int[numElements+1];
		Random rand = new Random();
		data[0] = numRows;
		for(int i=1; i<=numElements; i++){
			data[i] = rand.next();
		}
		minSum = data[1];
		
		
		//Create array of cumulative sums
		int sum = 0; //Cumulative row sum
		runSum = new int[data.length-1];
		for (int row = 0; row < numRows; row++){
			sum = 0; //Reset cumulative row sum
			for (int col = 0; col <= row; col++){
				int elNum = ((row*row+row)/2)+col;
				sum += data[elNum+1]; //Add element to cumulative row sum
				runSum[elNum] = sum; //Store cumulative row sum to runSum
			}
		}
		
		//Test all apexes and their subtriangles
		for (int row = 0; row < numRows; row++){
			for (int col = 0; col <= row; col++){
				sumTri = calculate(row,col); //returns the smallest sum of all subtriangles for the given apex
				if (sumTri < minSum)
					minSum = sumTri;
			}
		}
		System.out.println("The answer is: "+minSum);
	}

	//Test all subtriangles of a given apex and return the minimum sum
	public static int calculate(int row, int col){
		int tempSum = data[((row*row+row)/2)+col], tempCol = col+1, count = 1, sum = 0; //Store apex as initial minsum
		for (int botRow = row+1; botRow < numRows; botRow++){ //cycle through adding a row at a time
			int toAdd = ((botRow*botRow+botRow)/2)+tempCol; //Number of elements to skip
			//Add row onto bottom of running triangle
			if (col > 0)
				sum += (runSum[toAdd]-runSum[toAdd-count]);
			else
				sum += runSum[toAdd];
			//Test tempSum and store if its the smallest subtriangle
			if (sum < tempSum)
				tempSum = sum;
			tempCol++;
			count++;
		}
		return tempSum;
	}
	
	//Private inner class for generating psuedo-random numbers
	private static class Random {		
		private int num;	
		public Random() {
			num = 0;
		}		
		public int next() {
			num = (615949 * num + 797807) & ((int)Math.pow(2, 20)-1) ;
			return (int) (num - (Math.pow(2, 19)));
		}		
	}
}
