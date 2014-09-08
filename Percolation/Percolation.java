public class Percolation {
   public Percolation(int N)                // create N-by-N grid, with all sites blocked (false)
       boolean[][] a = new boolean[N][N];
   public void open(int i, int j)           // open site (row i, column j) if it is not already
       a[i][j] = True;
       // Union Operation
   public boolean isOpen(int i, int j)      // is site (row i, column j) open?
       return a[i][j] == True
   public boolean isFull(int i, int j)      // is site (row i, column j) full?
       // Find Operation
   public boolean percolates()              // does the system percolate?
       // Union top to bottom
   public static void main(String[] args)   // test client, optional
}