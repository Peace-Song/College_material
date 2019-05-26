import java.util.ArrayList;

public class Hw3{
        
//parameters
//adj : adjacent list of graph where the smallest element is the 0th element.
	//in array adj[i], neighbors of the ith vertecies are inserted.
//num_v : the number of vertecies.
//num_e : the number of edges.
//ans : ans[i] means that ith vertex is included in the ans[i]th strongly connected component.
    //ans[i] should be non-negative integer.
	//if there are multiple answers, please find the lexicoraphically smallest sequence.

//This function should return the number of strongly connnected components.
    
    public static int find_scc_with_adj_list(
            ArrayList < ArrayList < Integer > > adj,
            int num_v,
            int num_e,
            int[] ans
        )
    {
        
        ArrayList <ArrayList <Integer>> adj_transpose = new ArrayList <ArrayList <Integer>>(num_v);
        for(int i = 0; i < num_v; i++)
            adj_transpose.add(new ArrayList <Integer>());
        
        int[] finish_time = new int[num_v];

        
        

        DFS_adj_list(adj, num_v, finish_time);
       
        // Compute G_transpose
        for(int i = 0; i < adj.size(); i++)
            for(int j = 0; j < adj.get(i).size(); j++)
                adj_transpose.get(adj.get(i).get(j)).add(i);

                
       
       
       
       
       
       
       
       
       
       
       
       
        
        System.out.print("DEBUG: finish_time = ");
        for(int i = 0; i < finish_time.length; i++)
            System.out.print(finish_time[i]);

        System.out.println("");
        
        
        
        
        ans[0] = 0;
        ans[1] = 0;
        ans[2] = 0;
        ans[3] = 1;
        return 2;
    }

    public static void DFS_adj_list(ArrayList <ArrayList <Integer>> adj, int num_v, int[] finish_time){

    int time = 0;
    boolean[] visited = new boolean[num_v];

    for(int v = 0; v < num_v; v++)
        visited[v] = false;

    for(int v = 0; v < num_v; v++)
        if(visited[v] == false)
            time = aDFS_adj_list(adj, v, finish_time, visited, time);
    }

    public static int aDFS_adj_list(ArrayList <ArrayList <Integer>> adj, int v, int[] finish_time, boolean[] visited, int time){
       
        time++; 
        visited[v] = true;
        
        for(int i = 0; i < adj.get(v).size(); i++){
            int x = adj.get(v).get(i);

            if(visited[x] == false)
                time = aDFS_adj_list(adj, x, finish_time, visited, time);
        }

        finish_time[v] = ++time;
        System.out.println("DEBUG: finish_time of "+v+" is "+time);
        return time;
    }
    

//adj : num_v x num_v dimension adjacency matrix of the given graph
//the other parameters have same as above function.

    public static int find_scc_with_adj_mat(
            int[][] adj,
            int num_v,
            int num_e,
            int[] ans
        )
    {
        ans[0] = 0;
        ans[1] = 0;
        ans[2] = 0;
        ans[3] = 1;
        return 2;
    }
}
