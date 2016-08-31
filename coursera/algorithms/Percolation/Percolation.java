import java.util.Arrays;

public class Percolation {
   private int size;
   //private boolean percolatesFlag;
   private WeightedQuickUnionUF uf;
   private WeightedQuickUnionUF topUF;
   private boolean[][] opened;
   //private boolean[][] connectedToBottom;
   
   // Converts 2d (x, y) coordinates to single value, needed for union find object
   private int xyTo1D(int i, int j) {
       return size * (i - 1) + j;
   }
   
   private void checkBounds(int i, int j) {
       if (i <= 0 || i > size) throw new IndexOutOfBoundsException("row index i out of bounds");
       if (j <= 0 || j > size) throw new IndexOutOfBoundsException("column index j out of bounds");
   }
   
   // create N-by-N grid, with all sites blocked (false)
   public Percolation(int N) {               
       if (N <= 0) throw new IllegalArgumentException("Grid size must be > 0");
       
       // Union find library for operations. Add 2 for top and bottom virtual sites.
       uf = new WeightedQuickUnionUF(N * N + 2);
       topUF = new WeightedQuickUnionUF(N * N + 2);
   
       /* 
          Boolean array to indicate if opened.
          Size is N + 1 and 0-indexed values will not be used. Program will be
          passed 1-indexed values, but Java uses 0 indexing. This structure 
          makes code cleaner at the expense of a slight hit to memory.
       */
       opened = new boolean[N + 1][N + 1];
       //connectedToBottom = new boolean[N + 1][N + 1];
       size = N;
       
       // Mark bottom row as connected to bottom
       //for (int i = 0; i < connectedToBottom[N].length; i++) {
       //    connectedToBottom[N][i] = true;
       //}
   }
       
   public void open(int i, int j) {
       checkBounds(i, j);
       
       // Mark open in boolean array
       opened[i][j] = true;
       
       // Connect with open neighbors
       if (i != 1 && isOpen(i-1, j)) { 
           uf.union(xyTo1D(i, j), xyTo1D(i-1, j));
           topUF.union(xyTo1D(i, j), xyTo1D(i-1, j));
           //if (connectedToBottom[i-1][j]) { connectedToBottom[i][j] = true; }
           //else if (connectedToBottom[i][j]) { connectedToBottom[i-1][j] = true; }
       }
       if (i != size && isOpen(i+1, j)) { 
           uf.union(xyTo1D(i, j), xyTo1D(i+1, j));
           topUF.union(xyTo1D(i, j), xyTo1D(i+1, j));
           //if (connectedToBottom[i+1][j]) { connectedToBottom[i][j] = true; }
           //else if (connectedToBottom[i][j]) { connectedToBottom[i+1][j] = true; }
       }
       if (j != 1 && isOpen(i, j-1)) { 
           uf.union(xyTo1D(i, j), xyTo1D(i, j-1));
           topUF.union(xyTo1D(i, j), xyTo1D(i, j-1));
           //if (connectedToBottom[i][j-1]) { connectedToBottom[i][j] = true; }
           //else if (connectedToBottom[i][j]) { connectedToBottom[i][j-1] = true; }
       }
       if (j != size && isOpen(i, j+1)) { 
           uf.union(xyTo1D(i, j), xyTo1D(i, j+1));
           topUF.union(xyTo1D(i, j), xyTo1D(i, j+1));
           //if (connectedToBottom[i][j+1]) { connectedToBottom[i][j] = true; }
           //else if (connectedToBottom[i][j]) { connectedToBottom[i][j+1] = true; }
       }
       
       // If in top or bottom row, connect to virtual sites
       if (i == 1) { 
           uf.union(xyTo1D(i, j), 0); 
           topUF.union(xyTo1D(i, j), 0); 
       }
       if (i == size) { 
           uf.union(xyTo1D(i, j), size * size + 1); 
       }
       //if (isFull(i,j) && connectedToBottom[i][j]) {
       //    percolatesFlag = true;
       //}
       //System.out.println("("+i+","+j+") connected? "+connectedToBottom[i][j]);
       
   }
   
   public boolean isOpen(int i, int j) {
       checkBounds(i, j);
       return opened[i][j];
   }
   
   public boolean isFull(int i, int j) {
       checkBounds(i, j);
       return topUF.connected(xyTo1D(i, j), 0); // Full if connected to top virtual site
   }
   
   public boolean percolates() {
       return uf.connected(0, size * size + 1);
   }
   public static void main(String[] args) {
       
   }
}