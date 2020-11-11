package server;

import course.*;
import utils.ErrorCode;
import utils.Pair;

import java.util.*;

public class Server {

    public List<Course> search(Map<String,Object> searchConditions, String sortCriteria){
        // TODO Problem 2-1
        return new ArrayList<>();
    }

    public int bid(int courseId, int mileage, String userId){
        // TODO Problem 2-2
        return ErrorCode.IO_ERROR;
    }

    public Pair<Integer,List<Bidding>> retrieveBids(String userId){
        // TODO Problem 2-2
        return new Pair<>(ErrorCode.IO_ERROR,new ArrayList<>());
    }

    public boolean confirmBids(){
        // TODO Problem 2-3
        return false;
    }

    public Pair<Integer,List<Course>> retrieveRegisteredCourse(String userId){
        // TODO Problem 2-3
        return new Pair<>(ErrorCode.IO_ERROR,new ArrayList<>());
    }
}