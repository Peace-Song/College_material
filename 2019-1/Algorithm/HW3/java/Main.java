import java.util.ArrayList;
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

        int[] in_a = { 0, 1, 2, 0 };
        int[] in_b = { 1, 2, 0, 3 };
        
        for(int i=0;i<num_e;i++){
            adj_mat[in_a[i]][in_b[i]] = 1;
            adj_list.get(in_a[i]).add(in_b[i]);
        }

        int[] ans1 = new int[num_v];
        int scc1 = Hw3.find_scc_with_adj_list(adj_list,num_v,num_e,ans1);
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

        int[] ans2 = new int[num_v];
        int scc2 = Hw3.find_scc_with_adj_mat(adj_mat,num_v,num_e,ans2);
        for(int i=0;i<scc2;i++){
            for(int j=0;j<num_v;j++){
                if(ans2[j]==i){
                    System.out.print(Integer.toString(j) + " ");
                }
            }
            System.out.println("");
        }
        //answer should be 
            //0 1 2 
            //3
    }
}
