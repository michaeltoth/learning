public class PercolationStats {
    private double[] site_fraction;
    private Percolation perc;
    private int grid_sz;
    private int num_runs;
    
    private void open_random() {
        int i = StdRandom.uniform(grid_sz) + 1;
        int j = StdRandom.uniform(grid_sz) + 1;
        if (perc.isOpen(i,j)) { open_random(); }
        else { perc.open(i,j); return; }
    }
    
    public PercolationStats(int N, int T) {    // perform T independent computational experiments on an N-by-N grid
        if (N <= 0 || T <= 0) throw new IllegalArgumentException("N and T must be > 0");
        
        site_fraction = new double[T];
        grid_sz = N;
        num_runs = T;
        
        for (int i = 0; i < T; i++) {
            perc = new Percolation(N);
            int c = 0;
            while (perc.percolates() == false) {
                open_random();
                c++;
            }
            site_fraction[i] = (float)c/(N*N);
        }
    }
    public double mean() {                     // sample mean of percolation threshold
        double sum = 0.0;
        for (double i: site_fraction)
            sum += i;
        return sum/num_runs;
    }
    
    public double stddev() {                   // sample standard deviation of percolation threshold
        double var_sum = 0.0;
        double mu = mean();
        for (double i: site_fraction)
            var_sum = Math.pow((i - mu),2.0);
        double variance = var_sum/(num_runs - 1);
        return Math.sqrt(variance);
    }
    
    public double confidenceLo() {             // returns lower bound of the 95% confidence interval
        double mu = mean();
        double sigma = stddev();
        return (mu - (1.96 * sigma / Math.sqrt(num_runs)));
    }
    
    public double confidenceHi() {             // returns upper bound of the 95% confidence interval
        double mu = mean();
        double sigma = stddev();
        return (mu + (1.96 * sigma / Math.sqrt(num_runs)));
    }
    public static void main(String[] args) {   // test client, described below
        int N = StdIn.readInt();
        int T = StdIn.readInt();
        PercolationStats ps = new PercolationStats(N, T);
        System.out.println("mean = " + ps.mean());
        System.out.println("stddev = " + ps.stddev());
        System.out.println("95% confidence interval = " + ps.confidenceLo() + ", " + ps.confidenceHi());
    }
}