import java.util.*;
import java.lang.*;
import java.io.*;

public class Main{
    public static void main(String[] args){
		int n = 0;
		int k = 0;
        int a[] = new int[1];
		int b[] = new int[1];
		int i = 0;

		try{
			File file = new File("./4.txt");
			FileReader reader = new FileReader(file);
			BufferedReader b_reader = new BufferedReader(reader);

			String line = b_reader.readLine();
			n = Integer.parseInt(line.split(" ")[0]);
			k = Integer.parseInt(line.split(" ")[1]);
			a = new int[n];
			b = new int[n];

			while((line = b_reader.readLine()) != null){
				a[i] = Integer.parseInt(line);
				i++;
			}
			
			for(int j = 0; j < a.length; j++)
				b[j] = a[j];

		}catch(Exception e){
			System.out.println("EXCEPTION RAISED: " + e);
		}

		long start = System.currentTimeMillis();
        int ans1 = Hw1.randomizedSelect(a, n, k);
		long end = System.currentTimeMillis();

        if(Hw1.Checker(a, n, k, ans1)==true){
            System.out.println("correct");
			System.out.println("a["+k+"] = " + ans1);
			System.out.println("Execution time of randomizedSelect is:    " + (end - start) + "ms.");
        }
        else{
            System.out.println("incorrect");
        }

		//System.out.println("DEBUG: Array after randomizedSelect is: ");
		//for(int j = 0; j < a.length; j++) System.out.print("| "+a[j]+" |");
		//System.out.println("");

		for(int j = 0; j < b.length; j++)
			a[j] = b[j];

		start = System.currentTimeMillis();
        int ans2 = Hw1.deterministicSelect(a, n, k);
		end = System.currentTimeMillis();

        if(Hw1.Checker(a, n, k, ans2)==true){
            System.out.println("correct");
			System.out.println("a["+k+"] = " + ans2);
			System.out.println("Execution time of deterministicSelect is: " + (end - start) + "ms.");
        }
        else{
            System.out.println("incorrect");
        }

    }
}
