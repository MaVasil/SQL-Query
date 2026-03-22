class Solution {
    public int findTheWinner(int n, int k) {
        return josephus(n, k) + 1; // convert 0-based to 1-based
    }

    private int josephus(int n, int k) {
        if (n == 1)
            return 0;  // base case (0-based index)

        return (josephus(n - 1, k) + k) % n;
    }
}