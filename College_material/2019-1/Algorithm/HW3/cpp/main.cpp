#include <cstdio>
#include <vector>
#include <algorithm>

#include "hw3_cpp.h"

int main(){
    int num_v = 4, num_e = 4;
    
    std::vector < std::vector < int > > adj_list(num_v);
    std::vector < std::vector < int > > adj_mat(num_v);
    
    for(int i=0;i<num_v;i++){
        adj_mat[i].resize(num_v);
    }

    int in_a[] = { 0, 1, 2, 0 };
    int in_b[] = { 1, 2, 0, 3 };

    for(int i=0;i<num_e;i++){
        int x,y;
        x = in_a[i];
        y = in_b[i];
        adj_list[x].push_back(y);
        adj_mat[x][y] = 1;
    }
    
    std::vector < int > ans1(num_v);
    int scc1 = find_scc_with_adj_list(adj_list,num_v,num_e,ans1);
    for(int i=0;i<scc1;i++){
        for(int j=0;j<num_v;j++){
            if(ans1[j]==i){
                printf("%d ",j);
            }
        }
        printf("\n");
    }

    std::vector < int > ans2(num_v);
    int scc2 = find_scc_with_adj_mat(adj_mat,num_v,num_e,ans2);
    for(int i=0;i<scc2;i++){
        for(int j=0;j<num_v;j++){
            if(ans2[j]==i){
                printf("%d ",j);
            }
        }
        printf("\n");
    }

    return 0;
}
