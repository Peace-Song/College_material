import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

public class Hw2{
    static ArrayList < Integer > A;
    public static void init(){
        A = new ArrayList<Integer>();
    }
    public static int osInsert(int x){
        if(A.contains(x)){
            return 0;
        }
        else{
            A.add(x);
            return x;
        }
    }
    public static int osDelete(int x){
        for(int i=0;i<A.size();i++){
            if(A.get(i)==x){
                A.remove(i);
                return x;
            }
        }
       return 0; 
    }
    public static int osSelect(int i){
        Collections.sort(A);
        if(i - 1 < A.size()){
            return A.get(i-1);
        }
        else{
            return 0;
        }
    }
    public static int osRank(int x){
        Collections.sort(A);
        if(A.contains(x)){
            for(int i = 0;i < A.size();i++){
                if(A.get(i)==x){
                    return i + 1;   
                }
            }
        }
        return 0;
    }
    public static boolean check(int[] opt_seq, int[] in_seq, int[] out_seq, int n){
        init();
        for(int i=0;i<n;i++){
            if(opt_seq[i]==0){
                if(osInsert(in_seq[i])!=out_seq[i]){
                    return false;
                }
            }
            else if(opt_seq[i]==1){
                if(osDelete(in_seq[i])!=out_seq[i]){
                    return false;
                }
            }
            else if(opt_seq[i]==2){
                if(osSelect(in_seq[i])!=out_seq[i]){
                    return false;
                }
            }
            else if(opt_seq[i]==3){
                if(osRank(in_seq[i])!=out_seq[i]){
                    return false;
                }
            }
        }
        return true;
    }
}
