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
        
        int count = 1;
        ArrayList <ArrayList <Integer>> adj_transpose = new ArrayList <ArrayList <Integer>>(num_v);
        for(int i = 0; i < num_v; i++)
            adj_transpose.add(new ArrayList <Integer>());
        
        int[] finish_time = new int[num_v];

        //print_adj_list(adj);   
        
        // DFS to determine finish time
        DFS_adj_list_determine_time(adj, num_v, finish_time);
       
        // Compute G_transpose
        for(int i = 0; i < adj.size(); i++)
            for(int j = 0; j < adj.get(i).size(); j++)
                adj_transpose.get(adj.get(i).get(j)).add(i);

        // DFS to divide into SSC sets
        DFS_adj_list_find_SCC(adj_transpose, num_v, finish_time, ans);



        //print_adj_list(adj_transpose);               

        /*System.out.print("DEBUG: finish_time = ");
        for(int i = 0; i < finish_time.length; i++)
            System.out.print(finish_time[i]);
        System.out.println("");*/
        
        int max_SCC = 0;
        for(int i = 0; i < num_v; i++)
            if(ans[i] > max_SCC)
                max_SCC = ans[i];
       
        System.out.println("DEBUG: ans[]");
        for(int i = 0; i < num_v; i++)
            System.out.println("ans[" + i + "] = " + ans[i] + " ");
        System.out.println("\nDEBUG: ans[] end");
        //System.out.println("DEBUG: max_SCC = " + max_SCC); 
        return max_SCC + 1;
        
        
        /*ans[0] = 0;
        ans[1] = 0;
        ans[2] = 0;
        ans[3] = 1;
        return 2;*/
    }


    public static void print_adj_list(ArrayList <ArrayList <Integer>> adj){
        System.out.println("DEBUG: printing adjacency list.");
        for(int i = 0; i < adj.size(); i++){
            System.out.print(i + "| ");
            
            for(int j = 0; j < adj.get(i).size(); j++)
                System.out.print(adj.get(i).get(j) + " ");
            System.out.println("");
        }
    }

    public static void DFS_adj_list_find_SCC(ArrayList <ArrayList <Integer>> adj_transpose, int num_v, int[] finish_time, int[] ans){
        int count = 0;
        int max_vertex = 0;
        boolean[] visited = new boolean[num_v];
        int[] finish_time_index_decreasing = new int[num_v];

        for(int v = 0; v < num_v; v++)
            visited[v] = false;

        for(int i = 0; i < num_v; i++){
            for(int v = 0; v < num_v; v++){
                if(finish_time[v] > finish_time[max_vertex])
                    max_vertex = v;
            }
            
            finish_time_index_decreasing[i] = max_vertex;
            finish_time[max_vertex] = -1;
        }
    
        System.out.print("DEBUG: finish_time_index_decreasing[] = ");
        for(int i = 0; i < num_v; i++)
            System.out.print(finish_time_index_decreasing[i] + " ");
        System.out.println("");

        int v = 0;
        for(int i = 0; i < num_v; i++){
            v = finish_time_index_decreasing[i];

            if(visited[v] == false){
                ans[v] = count;
                System.out.println("DEBUG: scc with id = " + count);
                aDFS_adj_list_find_SCC(adj_transpose, v, count, visited, ans);
                System.out.println("");
                count++;
            }

            //count++;
        }
    }

    public static void aDFS_adj_list_find_SCC(ArrayList <ArrayList <Integer>> adj_transpose, int v, int count, boolean[] visited, int[] ans){
        System.out.print(v + " ");
        visited[v] = true;

        for(int i = 0; i < adj_transpose.get(v).size(); i++){
            int x = adj_transpose.get(v).get(i);

            if(visited[x] == false){
                ans[v] = count;
                aDFS_adj_list_find_SCC(adj_transpose, x, count, visited, ans);
            }
        }

    }

    public static void DFS_adj_list_determine_time(ArrayList <ArrayList <Integer>> adj, int num_v, int[] finish_time){

        int time = 0;
        boolean[] visited = new boolean[num_v];

        for(int v = 0; v < num_v; v++)
            visited[v] = false;

        for(int v = 0; v < num_v; v++)
            if(visited[v] == false)
                time = aDFS_adj_list_determine_time(adj, v, finish_time, visited, time);
    }

    public static int aDFS_adj_list_determine_time(ArrayList <ArrayList <Integer>> adj, int v, int[] finish_time, boolean[] visited, int time){
       
        time++; 
        visited[v] = true;
        
        for(int i = 0; i < adj.get(v).size(); i++){
            int x = adj.get(v).get(i);

            if(visited[x] == false)
                time = aDFS_adj_list_determine_time(adj, x, finish_time, visited, time);
        }

        finish_time[v] = ++time;
        //System.out.println("DEBUG: finish_time of "+v+" is "+time);
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

        int count = 1;
        int[][] adj_transpose = new int[num_v][num_v];
        int[] finish_time = new int[num_v];

        DFS_adj_mat_determine_time(adj, num_v, finish_time);

        for(int i = 0; i < num_v; i++)
            for(int j = 0; j < num_v; j++)
                if(adj[i][j] == 1)
                    adj_transpose[j][i] = 1;

        DFS_adj_mat_find_SCC(adj_transpose, num_v, finish_time, ans);

        
        int max_SCC = 0;
        for(int i = 0; i < num_v; i++)
            if(ans[i] > max_SCC)
                max_SCC = ans[i];

        System.out.print("DEBUG: ans[] = ");
        for(int i = 0; i < num_v; i++)
            System.out.print(ans[i] + " ");
        System.out.println("\nDEBUG: ans[] end");
        //System.out.println("DEBUG: max_SCC = " + max_SCC);
        return max_SCC + 1;


        /*
        ans[0] = 0;
        ans[1] = 0;
        ans[2] = 0;
        ans[3] = 1;
        return 2;*/
    }

    public static void DFS_adj_mat_find_SCC(int[][] adj_transpose, int num_v, int[] finish_time, int[] ans){
        int count = 0;
        int max_vertex = 0;
        boolean[] visited = new boolean[num_v];
        int[] finish_time_index_decreasing = new int[num_v];
        int[] finish_time_index_discovered = new int[num_v];
        for(int v = 0; v < num_v; v++)
            visited[v] = false;

        for(int i = 0; i < num_v; i++){
            for(int v = 0; v < num_v; v++)
                if(finish_time[v] >= finish_time[max_vertex])
                    max_vertex = v;
            
            finish_time_index_decreasing[i] = max_vertex;
            finish_time[max_vertex] = -1;
        }

        //System.out.print("DEBUG: finish_time_index_decreasing[] = ");
        //for(int i = 0; i < num_v; i++)
        //    System.out.print(finish_time_index_decreasing[i] + " ");
        //System.out.println("");

        int v = 0;
        for(int i = 0; i < num_v; i++){
            v = finish_time_index_decreasing[i];

            if(visited[v] == false){
                ans[v] = count;
                aDFS_adj_mat_find_SCC(adj_transpose, v, count, visited, ans);
                count++;
            }

            //count++;
        }
    }

    public static void aDFS_adj_mat_find_SCC(int[][] adj_transpose, int v, int count, boolean[] visited, int[] ans){
        visited[v] = true;

        for(int w = 0; w < adj_transpose[v].length; w++)
            if(adj_transpose[v][w] == 1)
                if(visited[w] == false){
                    ans[v] = count;
                    aDFS_adj_mat_find_SCC(adj_transpose, w, count, visited, ans);
                }
    }



    public static void DFS_adj_mat_determine_time(int[][] adj, int num_v, int[] finish_time){

        int time = 0;
        boolean[] visited = new boolean[num_v];

        for(int v = 0; v < num_v; v++)
            visited[v] = false;

        for(int v = 0; v < num_v; v++)
            if(visited[v] == false)
                time = aDFS_adj_mat_determine_time(adj, v, finish_time, visited, time);
    }

    public static int aDFS_adj_mat_determine_time(int[][] adj, int v, int[] finish_time, boolean[] visited, int time){

        time++;
        visited[v] = true;

        for(int w = 0; w < adj[v].length; w++){
            if(adj[v][w] == 1)
                if(visited[w] == false)
                    time = aDFS_adj_mat_determine_time(adj, w, finish_time, visited, time);
        }
                
        finish_time[v] = ++time;
        //System.out.println("DEBUG: finish_time_of " + v + " is " + time);
        return time;
    }
}
