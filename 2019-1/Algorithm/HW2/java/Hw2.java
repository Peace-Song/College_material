import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

public class Hw2{ // insert red black tree instead of arraylist
    static ArrayList < Integer > A; // int in [1, 9999] and initially tree empty
    
    public static void init(){
        A = new ArrayList<Integer>();
    }
    
    public static int osInsert(int x){ // returns x if x not in tree, 0 otherwise
        return 0;
    }
    
    public static int osDelete(int x){ // returns x if x in tree, 0 otherwise
        return 0;
    }
    
    public static int osSelect(int i){ // returns i-th smallest int in tree if |T|>=i, 0 otherwise
        return 0;
    }
    
    public static int osRank(int x){ // returns the rank of x if x in tree, 0 otherwise
        return 0;
    }
    
    public static boolean check(int[] opt_seq, int[] in_seq, int[] out_seq, int n){
        return 0;
    }
}

class RBT{
    
    private Node root;
    static Node nil; 

    static final int BLACK = 0;
    static final int RED = 1;

    public RBT(int element){
        nil = new Node(0, nil, nil, null); // nil's parent is set to null

        root = new Node(element, nil, nil, null);
        root.parent = root;
    }

    public void insert(int element){
        Node current = root;    
        
        
        
    }
     
    public static Node leftRotate(Node x);
    public static Node rightRotate(Node x); 
}

class Node{

    Node parent;
    Node left, right;
    int element;
    int color;

    public Node(int element){
        this(element, null, null, null);
    }

    public Node(int element, Node left, Node right, Node parent){
        this.element = element;
        this.left = left;
        this.right = right;
        this.parent = parent;
        this.color = 0;
    }
}
