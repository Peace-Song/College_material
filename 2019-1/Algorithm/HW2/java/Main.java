import java.util.*;
import java.lang.*;
import java.io.*;

public class Main{
    public static void main(String[] args){
        int[] opt_seq = { 0, 0, 0, 0, 0 }; // 0: ins | 1: del | 2: sel | 3: rank
        int[] in_seq = { 1, 2, 3, 3, 1 };
        int[] out_seq = { 1, 2, 3, 0, 0 };
        if(Hw2.check(opt_seq, in_seq, out_seq, 5)){
            System.out.println("correct");
        }
        else{
            System.out.println("incorrect");
        }
        
        Hw2.init();

        int[] opt_seq2 = { 0, 1, 0, 0, 2, 3, 0, 0,  0, 1, 0, 0,  0,  0, 0, 0, 0, 0 };
        int[] in_seq2  = { 1, 1, 1, 2, 1, 2, 3, 11, 5, 3, 6, 10, 12, 3, 7, 9, 4, 8 };
        int[] out_seq2 = new int[opt_seq2.length];
        
        for(int i=0;i<opt_seq2.length;i++){
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

        if(Hw2.check(opt_seq2,in_seq2,out_seq2,opt_seq2.length)){
            System.out.println("correct");
        }
        else{
            System.out.println("incorrect");
        }
    }
}
