import java.util.*;
import java.lang.*;
import java.io.*;

public class Main{
    public static void main(String[] args){
        int num_v = 4;
        int num_e = 4;
        
        ArrayList<ArrayList<Integer>> adj_list = new ArrayList<ArrayList<Integer>> (num_v);
        for(int i=0;i<num_v;i++){
            adj_list.add(new ArrayList < Integer > ());
        }

        int[][] adj_mat = new int[num_v][num_v];
        
        for(int i=0;i<num_v;i++){
            for(int j=0;j<num_v;j++){
                adj_mat[i][j] = 0;
            }
        }


        int[] in_a = new int[1];
        int[] in_b = new int[1];

        try{
            File file = new File("./in4.txt");
            FileReader reader = new FileReader(file);
            BufferedReader b_reader = new BufferedReader(reader);

            int i = 0;

            String line = b_reader.readLine();
            num_v = Integer.parseInt(line.split(" ")[0]);
            num_e = Integer.parseInt(line.split(" ")[1]);
            in_a = new int[num_e];
            in_b = new int[num_e];

            while((line = b_reader.readLine()) != null){
                in_a[i] = Integer.parseInt(line.split(" ")[0]);
                in_b[i] = Integer.parseInt(line.split(" ")[1]);
                i++;
            }
        }catch(Exception e){
            System.out.println("An exception occured.");
        }

        //int[] in_a = { 0, 1, 2, 0 };
        //int[] in_b = { 1, 2, 0, 3 };

        adj_list = new ArrayList<ArrayList<Integer>> (num_v);
        for(int i=0;i<num_v;i++){
            adj_list.add(new ArrayList < Integer > ());
        }

        adj_mat = new int[num_v][num_v];
        
        for(int i=0;i<num_v;i++){
            for(int j=0;j<num_v;j++){
                adj_mat[i][j] = 0;
            }
        }

        for(int i=0;i<num_e;i++){
            adj_mat[in_a[i]][in_b[i]] = 1;
            adj_list.get(in_a[i]).add(in_b[i]);
        }


        long start = System.currentTimeMillis();
        int[] ans1 = new int[num_v];
        int scc1 = Hw3.find_scc_with_adj_list(adj_list,num_v,num_e,ans1);
        long end = System.currentTimeMillis();
        System.out.println("Execution time with adjacency list is:      " + (end-start) + "ms.");
        for(int i=0;i<scc1;i++){
            for(int j=0;j<num_v;j++){
                if(ans1[j]==i){
                    System.out.print(Integer.toString(j) + " ");
                }
            }
            System.out.println("");
        }
        //answer should be
            //0 1 2
            //3


        start = System.currentTimeMillis();
        int[] ans2 = new int[num_v];
        int scc2 = Hw3.find_scc_with_adj_mat(adj_mat,num_v,num_e,ans2);
        end = System.currentTimeMillis();
        System.out.println("Execution time with adjacency matrix is:    " + (end-start) + "ms.");
        for(int i=0;i<scc2;i++){
            for(int j=0;j<num_v;j++){
                if(ans2[j]==i){
                    System.out.print(Integer.toString(j) + " ");
                }
            }
            System.out.println("");
        }

        boolean same = true;

        for(int i = 0; i < num_v; i++)
            if(ans1[i] != ans2[i])
                same = false;

        if(scc1 != scc2) same = false;

        //System.out.println("DEBUG: list and mat same?" + same);
        //answer should be 
            //0 1 2 
            //3
    }
}
