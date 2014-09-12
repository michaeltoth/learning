public class PercolationStats {
    // Instance variables to use in computations.
    private double[] siteFraction;
    private int numRuns;
    
    private void openRandom(int gridSize, Percolation perc) { // Open a site uniformly at random among closed sites
        int i = StdRandom.uniform(gridSize) + 1;
        int j = StdRandom.uniform(gridSize) + 1;
        
        // If site is already open, rerun this function.  Otherwise, open the site.
        if (perc.isOpen(i, j)) { 
            openRandom(gridSize, perc); 
        }
        else { 
            perc.open(i, j); 
            return; 
        }
    }
    
    public PercolationStats(int N, int T) {    // perform T independent computational experiments on an N-by-N grid
        if (N <= 0 || T <= 0) throw new IllegalArgumentException("N and T must be > 0");
        
        // Instantiating variables based on parameters N and T
        siteFraction = new double[T];
        numRuns = T;
        
        for (int i = 0; i < T; i++) {
            Percolation perc = new Percolation(N);
            int count = 0;
            
            // Open sites until the system percolates, counting the number of sites opened
            while (!perc.percolates()) {
                openRandom(N, perc);
                count++;
            }
            
            // Record the fraction of open sites for experiment i
            siteFraction[i] = (float) count/(N*N);
        }
    }
    public double mean() {                     // sample mean of percolation threshold
        return StdStats.mean(siteFraction);
    }
    
    public double stddev() {                   // sample standard deviation of percolation threshold
        return StdStats.stddev(siteFraction);
    }
    
    public double confidenceLo() {             // returns lower bound of the 95% confidence interval
        double mu = mean();
        double sigma = stddev();
        return (mu - (1.96 * sigma / Math.sqrt(numRuns)));
    }
    
    public double confidenceHi() {             // returns upper bound of the 95% confidence interval
        double mu = mean();
        double sigma = stddev();
        return (mu + (1.96 * sigma / Math.sqrt(numRuns)));
    }
    public static void main(String[] args) {
        // Read N (grid size) and T (number of samples) from standard input
        int N = StdIn.readInt();
        int T = StdIn.readInt();
        
        // Make PercolationStats object to runs statistics on N*N grid for T samples
        PercolationStats ps = new PercolationStats(N, T);
        
        System.out.println("mean = " + ps.mean());
        System.out.println("stddev = " + ps.stddev());
        System.out.println("95% confidence interval = " + ps.confidenceLo() + ", " + ps.confidenceHi());
    }
}