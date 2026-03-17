import java.util.Arrays;
class Solution {
    public int findGCD(int[] nums) {
        int min=Arrays.stream(nums).min().getAsInt();
        int max=Arrays.stream(nums).max().getAsInt();
        int a=min;
        int b=max;
        while(a!=0){
           int temp=a;
            a=b%a;
            b=temp;
        }   
        return b;
    }
}