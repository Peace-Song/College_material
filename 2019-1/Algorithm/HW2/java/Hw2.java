import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

public class Hw2{ // insert red black tree instead of arraylist
    static RBT rbtree; // int in [1, 9999] and initially tree empty
    
    public static void init(){
        rbtree = new RBT();
    }
    
    public static int osInsert(int x){ // returns x if x not in tree, 0 otherwise
        if(!rbtree.search(x)){
            rbtree.insert(x);

            // System.out.println("DEBUG: osInsert returns " + x);
            return x;
        }

        // System.out.println("DEBUG: osInsert returns " + 0);

        return 0;
    }
    
    public static int osDelete(int x){ // returns x if x in tree, 0 otherwise
        if(rbtree.search(x)){
            rbtree.delete(x);

            // System.out.println("DEBUG: osDelete returns " + x);
            return x;
        }

        // System.out.println("DEBUG: osDelete returns " + 0);

        return 0;
    }
    
    public static int osSelect(int i){ // returns i-th smallest int in tree if |T|>=i, 0 otherwise
        if(rbtree.size >= i){
            // System.out.println("DEBUG: osSelect returns " + rbtree.select(i));
            return rbtree.select(i);
        }

        // System.out.println("DEBUG: osSelect returns " + 0);

        return 0;
    }
    
    public static int osRank(int x){ // returns the rank of x if x in tree, 0 otherwise
        if(rbtree.search(x)){
            // System.out.println("DEBUG: osRank returns " + rbtree.rank(x));
            return rbtree.rank(x);
        }

        // System.out.println("DEBUG: osRank   returns " + 0);

        return 0;
    }
    
    public static boolean check(int[] opt_seq, int[] in_seq, int[] out_seq, int n){
        ArrayList<Integer> list = new ArrayList<Integer>();
        int target = 0;

        for(int i = 0; i < n; i++){
            switch(opt_seq[i]){
                case 0: // insert 
                    if(list.contains(in_seq[i])) target = 0;
                    else{
                        list.add(in_seq[i]);
                        list.sort(Comparator.naturalOrder());
                        target = in_seq[i];
                    }
                    break;
                case 1: // delete
                    if(!list.contains(in_seq[i])) target = 0;
                    else{
                        list.remove(Integer.valueOf(in_seq[i]));
                        list.sort(Comparator.naturalOrder());
                        target = in_seq[i];
                    }
                    break;
                case 2: // select
                    if(!(list.size() >= in_seq[i])) target = 0;
                    else target = list.get(in_seq[i] - 1);                        
                    break;
                case 3: // rank
                    if(!list.contains(in_seq[i])) target = 0;
                    else target = list.indexOf(in_seq[i]) + 1;
                    break;
            }
            
            // System.out.println("DEBUG: target = " + target);
            //printlist(list);

            if(out_seq[i] != target) return false;
        }

        return true;
    }

    /*private static void printlist(ArrayList<Integer> list){
        System.out.print("DEBUG: ArrayList = ");
        for(int i = 0; i < list.size(); i++)
            System.out.print(list.get(i));
        System.out.println("");
    }*/
}

class RBT{ 
    private Node root;
    static Node nil; 

    static final int BLACK = 0;
    static final int RED = 1;

    int size;

    public RBT(){
        nil = new Node(0, null, null, null);
        nil.left = nil;
        nil.right = nil;
        nil.size = 0;
        nil.color = BLACK;

        root = nil;

        size = 0;
    }

    public RBT(int element){
        nil = new Node(0, null, null, null); // nil's parent is set to null
        nil.left = nil;
        nil.right = nil;
        nil.size = 0;
        nil.color = BLACK;

        root = new Node(element, nil, nil, nil);
        root.color = BLACK;

        size = 1;
    }

    public void print(){
        printInorder(root);
        System.out.println("");
    }

    public void printInorder(Node node){
        if(node == nil) return;
        printInorder(node.left);
        System.out.print(node.element + " ");
        printInorder(node.right);
    }

    public int select(int i){
        //System.out.println("DEBUG: select " + i);
        return select_helper(root, i);
    }

    public int select_helper(Node node, int i){
        int rank = node.left.size + 1;
        
        if(i == rank) return node.element;
        else if(i < rank) return select_helper(node.left, i);
        else return select_helper(node.right, i - rank);
    }

    public int rank(int element){
        //System.out.println("DEBUG: rank " + element);
        Node node = search_node(element);
        Node current = node;
        int rank = node.left.size + 1;
        
        while(current != root){
            if(current == current.parent.right)
                rank = rank + current.parent.left.size + 1;

            current = current.parent;
        }

        return rank;
    }

    public boolean search(int element){
        Node current = root;
        Node parent;

        while(current.element != element){
            parent = current;
            current = current.element < element ? current.right : current.left;

            if(current == nil)
                return false;
        }

        return true;
    }

    public Node search_node(int element){
        Node current = root;
        Node parent;

        while(current.element != element){
            parent = current;
            current = current.element < element ? current.right : current.left;

            if(current == nil){
                // System.out.println("No such element exists. Returning nil.");
                return current;
            }
            
        }

        return current;
    }

    public Node search_delete(int element){
        Node current = root;
        Node parent;

        while(current.element != element){
            current.size--;
            parent = current;
            current = current.element < element ? current.right : current.left;

            if(current == nil){
                // System.out.println("No such element exists. Returning nil.");
                return current;
            }
            
        }

        return current;
    }

    public void insert(int element){
        Node current = root;    
        Node parent = current.parent;

        // System.out.println("DEBUG: insert " + element);

        if(root == nil){
            root = new Node(element, nil, nil, nil);
            root.color = BLACK;
            size++;

            return;
        }
        
        while(current != nil){ // if loop out, current is nil
            // System.out.println("DEBUG: current.element = " + current.element);
            
            current.size++;
            parent = current;
            current = current.element < element ? current.right : current.left;

            // System.out.println("DEBUG: current.element = " + current.element);
        }

        // System.out.println(root.element + "|" + root.left.element + "|" + root.right.element + "");

        if(parent.left == nil && parent.right == nil){
            if(parent.element < element){
                parent.right = new Node(element, nil, nil, parent);
                current = parent.right;
            }
            else{
                parent.left = new Node(element, nil, nil, parent);
                current = parent.left;
            }
        }
        else if(parent.left == nil){
            parent.left = new Node(element, nil, nil, parent);
            current = parent.left;
        }
        else{
            parent.right = new Node(element, nil, nil, parent);
            current = parent.right;
        }

        // System.out.println(root.element + "|" + root.left.element + "|" + root.right.element + "");

        //System.out.println("insert: current = " + current.element);

        insertFixup(current);

        size++;

        return;
    }

    public void delete(int element){
        // System.out.println("DEBUG: delete " + element);
        Node rightLeftmost;
        Node node = search_delete(element);
        Node fixup_node;

        int node_color = node.color;

        if(node == nil) return; // no such element

        if(node.right == nil && node.left == nil){ // leaf
            if(node == root){
                root = nil;

                size--;
                return;
            }

            if(node.parent.left == node) node.parent.left = nil;
            else node.parent.right = nil;
            
            fixup_node = node.parent;
        }

        else if(node.right == nil){ // has only left child
            if(node == root){
                root = node.left;
                root.parent = nil;
                root.color = BLACK;

                size--;
                return;
            }

            if(node.parent.right == node){
                node.parent.right = node.left;
                node.left.parent = node.parent;
            }
            else{
                node.parent.left = node.left;
                node.left.parent = node.parent;
            }

            fixup_node = node.left;
        }

        else if(node.left == nil){ // has only right child
            if(node == root){
                root = node.right;
                root.parent = nil;
                root.color = BLACK;

                size--;
                return;
            }

            if(node.parent.right == node){
                node.parent.right = node.right;
                node.right.parent = node.parent;
            }
            else{
                node.parent.left = node.right;
                node.right.parent = node.parent;
            }

            fixup_node = node.right;
        }

        else{ // has two children
            rightLeftmost = node.right;
            while(rightLeftmost.left != nil)
                rightLeftmost = rightLeftmost.left;
            
            node_color = rightLeftmost.color;
            fixup_node = rightLeftmost.right;

            node.element = rightLeftmost.element; // no need to redirect root
            
            rightLeftmost.parent.left = rightLeftmost.right;
            rightLeftmost.right.parent = rightLeftmost.parent;
        }

        if(node_color == BLACK)
            deleteFixup(fixup_node);
        
        size--;

        return;
    }

     
    public void insertFixup(Node node){
        //System.out.println("DEBUG: insertFixup: node.element = " + node.element);
        Node parent = node.parent;
        //System.out.println("DEBUG: insertFixup: parent.element = " + parent.element);
        Node grand = node != root ? parent.parent : nil;
        Node uncle = parent == grand.left ? grand.right : grand.left;
        Node sibling = node == parent.left ? parent.right : parent.left;

        if(node == root){
            node.color = BLACK;

            return;
        }

        if(node.parent == root) return; // good as root is black.
            
        if(parent.color == BLACK) return; // good as it is

        if(uncle != nil && uncle.color == RED){ // p.c = R, u.c = R
            parent.color = BLACK;
            uncle.color = BLACK;
            grand.color = RED;
            
            insertFixup(grand);

            return;
        }
        
        if(parent == grand.left){ // p.c = R, u.c = B
            if(node == parent.right){
                leftRotate(parent);
                rightRotate(grand);

                node.color = BLACK;
                grand.color = RED;
                
                return;
            }
            else{
                rightRotate(grand);
                
                parent.color = BLACK;
                grand.color = RED;

                return;
            }
        }
        else{
            if(node == parent.left){
                rightRotate(parent);
                leftRotate(grand);

                node.color = BLACK;
                grand.color = RED;

                return;
            }
            else{
                leftRotate(grand);

                parent.color = BLACK;
                grand.color = RED;

                return;
            }
        }
    }

    public void deleteFixup(Node node){
        Node sibling;

        while(node != root && node.color == BLACK){
            if(node == node.parent.left){
                sibling = node.parent.right;
                if(sibling.color == RED){
                    sibling.color = BLACK;
                    node.parent.color = RED;
                    leftRotate(node.parent);
                    sibling = node.parent.right;
                }
                if(sibling.left.color == BLACK && sibling.right.color == BLACK){
                    sibling.color = RED;
                    node = node.parent;
                    continue;
                }
                else if(sibling.right.color == BLACK){
                    sibling.left.color = BLACK;
                    sibling.color = RED;
                    rightRotate(sibling);
                    sibling = sibling.parent.left;
                }
                if(sibling.right.color == RED){
                    sibling.color = node.parent.color;
                    node.parent.color = BLACK;
                    sibling.right.color = BLACK;
                    leftRotate(node.parent);
                    node = root; // to finalize in the next loop
                }
            }
            else{
                sibling = node.parent.left;
                if(sibling.color == RED){
                    sibling.color = BLACK;
                    node.parent.color = RED;
                    rightRotate(node.parent);
                    sibling = node.parent.left;
                }
                if(sibling.left.color == BLACK && sibling.right.color == BLACK){
                    sibling.color = RED;
                    node = node.parent;
                    continue;
                }
                else if(sibling.left.color == BLACK){
                    sibling.right.color = BLACK;
                    sibling.color = RED;
                    leftRotate(sibling);
                    sibling = sibling.parent.left;
                }
                if(sibling.left.color == RED){
                    sibling.color = node.parent.color;
                    node.parent.color = BLACK;
                    sibling.left.color = BLACK;
                    rightRotate(node.parent);
                    node = root; // to finalize in the next loop
                }
            }
        }

        node.color = BLACK;
    }

    public void leftRotate(Node node){
        if(node != root){
            if(node == node.parent.left)
                node.parent.left = node.right;
            else
                node.parent.right = node.right;

            node.right.parent = node.parent;
            node.parent = node.right;
            
            if(node.right.left != nil)
                node.right.left.parent = node;

            node.right = node.right.left;
            node.parent.left = node;

            node.size = node.left.size + node.right.size + 1;
            node.parent.size = node.parent.left.size + node.parent.right.size + 1;

            return;
        }
    
        else{
            Node right = root.right;

            root.right = root.right.left;
            right.left.parent = root;
            root.parent = right;
            right.left = root;
            right.parent = nil;
            root = right;

            root.left.size = root.left.left.size + root.left.right.size + 1;
            root.size = root.left.size + root.right.size + 1;

            return;
        }
    }

    public void rightRotate(Node node){
         if(node != root){
            if(node == node.parent.left)
                node.parent.left = node.left;
            else
                node.parent.right = node.left;

            node.left.parent = node.parent;
            node.parent = node.left;
            
            if(node.left.right != nil)
                node.left.right.parent = node;

            node.left = node.left.right;
            node.parent.right = node;

            node.size = node.left.size + node.right.size + 1;
            node.parent.size = node.parent.left.size + node.parent.right.size + 1;

            return;
        }
    
        else{
            Node left = root.left;

            root.left = root.left.right;
            left.right.parent = root;
            root.parent = left;
            left.right = root;
            left.parent = nil;
            root = left;

            root.left.size = root.left.left.size + root.left.right.size + 1;
            root.size = root.left.size + root.right.size + 1;

            return;
        }
    }
}

class Node{

    Node parent;
    Node left, right;
    int element;
    int size;
    int color;

    public Node(int element){
        this(element, null, null, null);
    }

    public Node(int element, Node left, Node right, Node parent){
        this.element = element;
        this.left = left;
        this.right = right;
        this.parent = parent;
        this.size = 1;
        this.color = 1;
    }
}
