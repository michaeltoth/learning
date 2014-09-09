import java.util.Arrays;

public class Percolation {
   private int size;
   private boolean[][] op;
   private int[][] id;
   private WeightedQuickUnionUF uf;
   
   private int xyTo1D(int i, int j) {
       return size * (i - 1) + j;
   }
   
   private void check_bounds(int i, int j) {
       if (i <= 0 || i > size) throw new IndexOutOfBoundsException("row index i out of bounds");
       if (j <= 0 || j > size) throw new IndexOutOfBoundsException("column index j out of bounds");
   }
   
   public Percolation(int N) {               // create N-by-N grid, with all sites blocked (false)
       if (N <= 0) throw new IllegalArgumentException("Grid size must be > 0");
       op = new boolean[N + 1][N + 1];
       size = N;
       id = new int[N + 1][N + 1];  // This will make it easier to deal with 0-based indexing
       
       for (int i = 0; i < id.length; i++) {
           for (int j = 0; j < id[i].length; j++) {
               id[i][j] = xyTo1D(i,j);
           }
       }
       
       // Add 2 for top and bottom virtual sites
       uf = new WeightedQuickUnionUF(N * N + 2);
   }
       
   public void open(int i, int j) {           // open site (row i, column j) if it is not already
       check_bounds(i,j);
       op[i][j] = true;
       
       // Connect with open neighbors
       if (i != 1     && isOpen(i-1, j  )) { uf.union(id[i][j], id[i-1][j  ]); }
       if (i != size  && isOpen(i+1, j  )) { uf.union(id[i][j], id[i+1][j  ]); }
       if (j != 1     && isOpen(i  , j-1)) { uf.union(id[i][j], id[i  ][j-1]); }
       if (j != size  && isOpen(i  , j+1)) { uf.union(id[i][j], id[i  ][j+1]); }
       
       // If in top or bottom row, connect to virtual sites
       if (i == 1) { uf.union(id[i][j], 0); }
       if (i == size) { uf.union(id[i][j], size * size + 1); }
   }
   
   public boolean isOpen(int i, int j) {      // is site (row i, column j) open?
       check_bounds(i,j);
       return op[i][j];  // Dealing with 0-based indexing and 1-based requests to function
   }
   
   public boolean isFull(int i, int j) {      // is site (row i, column j) full?
       check_bounds(i,j);
       return uf.connected(id[i][j], 0);
   }
   
   public boolean percolates() {              // does the system percolate?
       return uf.connected(0, size * size + 1);
       // Union top to bottom
   }
   public static void main(String[] args) {   // test client, optional
       Percolation my_perc = new Percolation(3);
       System.out.println(Arrays.deepToString(my_perc.id));
       System.out.println(Arrays.deepToString(my_perc.op));
       my_perc.open(3,2);
       System.out.println("Opened First One");
       my_perc.open(3,3);
       System.out.println(my_perc.uf.connected(9,8));
       System.out.println(Arrays.deepToString(my_perc.id));
       System.out.println(Arrays.deepToString(my_perc.op));
   }
}