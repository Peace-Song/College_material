#include <cstdio>
#include "hw2_cpp.h"

int main(){
    //0 : insert
    //1 : delete
    //2 : select
    //3 : rank
    int opt_seq[5] = { 0, 0, 0, 0, 0 };
    int in_seq[5] = { 1, 2, 3, 3, 1 };
    int out_seq[5] = { 1, 2, 3, 0, 1};//4th element 1 -> 0
    
    if(check(opt_seq,in_seq,out_seq,5)){
        printf("correct\n");
    }
    else{
        printf("incorrect\n");
    }

    init();
    
    int opt_seq2[6] = { 0, 1, 0, 0, 2, 3 };
    int in_seq2[6] = { 1, 1, 1, 2, 1, 2 };
    int out_seq2[6];
    for(int i = 0;i < 6;i++){
        if(opt_seq2[i]==0){
            out_seq2[i] = os_insert(in_seq2[i]);
        }
        else if(opt_seq2[i]==1){
            out_seq2[i] = os_delete(in_seq2[i]);
        }
        else if(opt_seq2[i]==2){
            out_seq2[i] = os_select(in_seq2[i]);
        }
        else{
            out_seq2[i] = os_rank(in_seq2[i]);
        }
    }
    
    if(check(opt_seq2,in_seq2,out_seq2,6)){
        printf("correct\n");
    }
    else{
        printf("incorrect\n");
    }
    return 0;
}
