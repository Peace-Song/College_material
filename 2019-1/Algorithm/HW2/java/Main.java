import java.util.*;
import java.lang.*;
import java.io.*;

public class Main{
    public static void main(String[] args){
        int[] opt_seq = { 0, 0, 0, 0, 0 }; // 0: ins | 1: del | 2: sel | 3: rank
        int[] in_seq = { 1, 2, 3, 3, 1 };
        int[] out_seq = { 1, 2, 3, 0, 1 };
        if(Hw2.check(opt_seq, in_seq, out_seq, 5)){
            System.out.println("correct");
        }
        else{
            System.out.println("incorrect");
        }
        
        Hw2.init();

        int[] opt_seq2 = { 0, 1, 0, 0, 2, 3 };
        int[] in_seq2 = { 1, 1, 1, 2, 1, 2 };
        int[] out_seq2 = new int[6];
        
        for(int i=0;i<6;i++){
            if(opt_seq2[i]==0){
                out_seq2[i] = Hw2.osInsert(in_seq2[i]);
            }
            else if(opt_seq2[i]==1){
                out_seq2[i] = Hw2.osDelete(in_seq2[i]);
            }
            else if(opt_seq2[i]==2){
                out_seq2[i] = Hw2.osSelect(in_seq2[i]);
            }
            else if(opt_seq2[i]==3){
                out_seq2[i] = Hw2.osRank(in_seq2[i]);
            }
        }

        if(Hw2.check(opt_seq2,in_seq2,out_seq2,6)){
            System.out.println("correct");
        }
        else{
            System.out.println("incorrect");
        }
    }
}
