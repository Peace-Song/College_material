import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

public class Hw2{ // insert red black tree instead of arraylist
    static ArrayList < Integer > A; // int in [1, 9999] and initially tree empty
    
    public static void init(){
        A = new ArrayList<Integer>();
    }
    
    public static int osInsert(int x){ // returns x if x not in tree, 0 otherwise
    
    }
    
    public static int osDelete(int x){ // returns x if x in tree, 0 otherwise
    
    }
    
    public static int osSelect(int i){ // returns i-th smallest int in tree if |T|>=i, 0 otherwise
    
    }
    
    public static int osRank(int x){ // returns the rank of x if x in tree, 0 otherwise
    
    }
    
    public static boolean check(int[] opt_seq, int[] in_seq, int[] out_seq, int n){
    
    }
}

class RBT{
    void RBT(){}
    private Node root;
    public static Node leftRotate(Node x);
    public static Node rightRotate(Node x); 
}

class Node{
    private boolean color; // 0: black, 1: red
    public boolean getColor(){return color;}
    public void setColor(boolean color){this.color = color;}

}
