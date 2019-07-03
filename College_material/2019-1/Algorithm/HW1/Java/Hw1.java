import java.lang.Math;
import java.util.Arrays;

public class Hw1{
    //find the "k"th smallest element in array "a" with "n" elements by using Randomized-select in CLRS
    public static int randomizedSelect(int[] a, int n, int k){
        if(n == 1){
			return a[0];
		}

		int pivot_index = partition(a, a[(int)(a.length * Math.random())]);

		if(pivot_index == k){
			return a[pivot_index];
		}
		else if(pivot_index > k)
			return randomizedSelect(Arrays.copyOfRange(a, 0, pivot_index), pivot_index, k);
		else if(pivot_index < k)
			return randomizedSelect(Arrays.copyOfRange(a, pivot_index+1, n), n-pivot_index-1, k-pivot_index-1);
		else return -1;
    }

    //find the "k"th smallest element in array "a" with "n" elements by using the worst-case linear-time algorithm in CLRS
    public static int deterministicSelect(int[] a, int n, int k){
		if(n <= 5){
			Arrays.sort(a);
			return a[k];
		}

		int numGroup = (int)Math.ceil((a.length+0.0)/5);
		int mList[] = new int[numGroup];
		int median;
		int pivot_index;
		
		for(int i = 0; i < numGroup-1; i++)
			mList[i] = deterministicSelect(Arrays.copyOfRange(a, 5*i, 5*(i+1)), 5, 2);
		if(a.length % 5 == 0)
			mList[numGroup-1] = deterministicSelect(Arrays.copyOfRange(a, 5*(numGroup-1), a.length), 5, 2);
		else
			mList[numGroup-1] = deterministicSelect(Arrays.copyOfRange(a, 5*(numGroup-1), a.length), a.length%5, (a.length%5-1)/2);

		median = deterministicSelect(mList, numGroup, (numGroup-1)/2);

		pivot_index = partition(a, median);

		if(pivot_index == k)
			return a[pivot_index];
		else if(pivot_index > k)
			return deterministicSelect(Arrays.copyOfRange(a, 0, pivot_index), pivot_index, k);
		else if(pivot_index < k)
			return deterministicSelect(Arrays.copyOfRange(a, pivot_index+1, n), n-pivot_index-1, k-pivot_index-1);
		else return -1;
	}

    //check whether the "k"th smallest element in array "a" with "n" elements is the "ans"
    public static boolean Checker(int[] a, int n, int k, int ans){
		int counter = 0;
		
		for(int i = 0; i < n; i++)
			if(a[i] < ans) counter++;

		if(counter == k) return true;
		else return false;
    }

	private static int partition(int[] a, int pivot){
		int p = -1;

		for(int q = 0; q < a.length-1; q++){

			if(a[q] == pivot){
				swap(a, q, a.length-1);
			}
			if(a[q] < pivot){
				p++;
				swap(a, p, q);
			}
		}
		swap(a, p+1, a.length-1);

		return p+1;
	}

	private static void swap(int[] a, int indexA, int indexB){
		int temp;
		temp = a[indexA];
		a[indexA] = a[indexB];
		a[indexB] = temp;
	}
}
