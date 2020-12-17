package server;

import course.*;
import user.*;
import utils.Config;
import utils.ErrorCode;
import utils.Pair;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOError;
import java.io.IOException;
import java.util.*;

public class Server {
    public static final String coursePath = "data/Courses";
    public static final String userPath = "data/Users";

    private List<Course> courses;
    private List<User> users;

    public Server() {
        this.loadCourses();
    }

    public List<Course> search(Map<String,Object> searchConditions, String sortCriteria){
        List<Course> searchResult = this.searchCourses(searchConditions);
        this.sortCourses(searchResult, sortCriteria);

        return searchResult;
    }

    public int bid(int courseId, int mileage, String userId){
        User user;
        File userDir;
        File biddingFile;
        Course course;

        if (this.users == null) this.loadUsers();

        user = this.findUser(userId);
        if (user == null) return ErrorCode.USERID_NOT_FOUND;

        userDir = new File(Server.userPath + "/" + userId);
        if (!userDir.exists()) return ErrorCode.USERID_NOT_FOUND;

        biddingFile = userDir.listFiles()[0];
        if (!biddingFile.exists()) return ErrorCode.IO_ERROR;

        if (mileage > Config.MAX_MILEAGE_PER_COURSE) return ErrorCode.OVER_MAX_COURSE_MILEAGE;

        if (mileage < 0) return ErrorCode.NEGATIVE_MILEAGE;

        course = this.findCourse(courseId);
        if (course == null) return ErrorCode.NO_COURSE_ID;

        int spentMileages = 0;
        for (Bidding bidding : user.getBiddings()) {
            spentMileages += bidding.mileage;
        }

        if (!this.hasBid(userId, courseId) && spentMileages + mileage > Config.MAX_MILEAGE) return ErrorCode.OVER_MAX_MILEAGE;
        if (this.hasBid(userId, courseId) && spentMileages - user.findBiddingByCourseId(courseId).mileage + mileage > Config.MAX_MILEAGE) return ErrorCode.OVER_MAX_MILEAGE;
        
        try {
            if (mileage == 0 && this.hasBid(userId, courseId)) {
                Bidding bidding = user.findBiddingByCourseId(courseId);
                user.removeBiddingAndWrite(bidding);

                return ErrorCode.SUCCESS;
            }
            else if (mileage == 0) return ErrorCode.SUCCESS;

            if (this.hasBid(userId, courseId)) {
                Bidding bidding = user.findBiddingByCourseId(courseId);
                user.removeBiddingAndWrite(bidding);
                user.addBiddingAndWrite(new Bidding(courseId, mileage));

                return ErrorCode.SUCCESS;
            }

            user.addBiddingAndWrite(new Bidding(courseId, mileage));
        } catch (FileNotFoundException fnfe) {
            return ErrorCode.IO_ERROR;
        }

        return ErrorCode.SUCCESS;
    }

    public Pair<Integer,List<Bidding>> retrieveBids(String userId){
        if (this.users == null) this.loadUsers();

        User user = this.findUser(userId);
        if (user == null) return new Pair<Integer, List<Bidding>>(ErrorCode.USERID_NOT_FOUND, new ArrayList<Bidding>());

        return new Pair<Integer, List<Bidding>>(ErrorCode.SUCCESS, user.getBiddings());
    }

    public boolean confirmBids(){
        if (this.users == null) this.loadUsers();

        for (Course course : this.courses) {
            List<User> registeredUsers = new ArrayList<User>();

            for (User user : this.users) {
                List<Bidding> biddings = user.getBiddings();
                List<Integer> courseIds = new ArrayList<Integer>();
                biddings.forEach(
                    (Bidding bidding) -> { courseIds.add(bidding.courseId); }
                );
                
                if (courseIds.contains(course.courseId)) {
                    registeredUsers.add(user);
                }
            }

            if (registeredUsers.size() > course.quota) {
                registeredUsers.sort(
                    (User u1, User u2) -> {
                        int m1 = u1.findBiddingByCourseId(course.courseId).mileage;
                        int m2 = u2.findBiddingByCourseId(course.courseId).mileage;
                        if (m1 != m2) return Integer.compare(m2, m1); // decreasing
                        
                        int bl1 = u1.getBiddings().size();
                        int bl2 = u2.getBiddings().size();
                        if (bl1 != bl2) return Integer.compare(bl1, bl2); // increasing

                        return u1.getUserId().compareTo(u2.getUserId());
                    }
                );

                registeredUsers = registeredUsers.subList(0, course.quota);
            }

            for (User user : registeredUsers) {
                try {
                    user.appendBiddingToFinalBid(user.findBiddingByCourseId(course.courseId));
                } catch (FileNotFoundException fnfe) {
                    return false;
                }
            }
        }

        this.removeBidFiles();

        return true;
    }

    private void removeBidFiles() {
        for (User user : this.users) {
            File bidFile = new File(Server.userPath + "/" + user.getUserId() + "/bid.txt");
            bidFile.delete();
        }
    }

    public Pair<Integer,List<Course>> retrieveRegisteredCourse(String userId){
        if (this.users == null) this.loadUsers();

        User user = this.findUser(userId);
        if (user == null) return new Pair<Integer, List<Course>>(ErrorCode.USERID_NOT_FOUND, new ArrayList<Course>());

        List<Course> courses = new ArrayList<Course>();
        File finalBidFile = new File(Server.userPath + "/" + userId + "/final_bid.txt");
        try {
            Scanner biddingScanner = new Scanner(finalBidFile);

            while (biddingScanner.hasNext()) {
                String[] biddingInfo = biddingScanner.nextLine().split("\\|");
                Course course = this.findCourse(Integer.parseInt(biddingInfo[0]));
                courses.add(course);
            }

            biddingScanner.close();
        } catch (FileNotFoundException fnfe) {
            return new Pair<Integer, List<Course>>(ErrorCode.IO_ERROR, new ArrayList<Course>());
        }

        return new Pair<Integer, List<Course>>(ErrorCode.SUCCESS, courses);
    }

    private boolean hasBid(String userId, int courseId) {
        User user = this.findUser(userId);

        for (Bidding bidding : user.getBiddings()) {
            if (bidding.courseId == courseId) return true;
        }

        return false;
    }

    private Course findCourse(int courseId) {
        for (Course course : this.courses) {
            if (course.courseId == courseId) return course;
        }

        return null;
    }

    private User findUser(String userId) {
        for (User user : this.users) {
            if (userId.equals(user.getUserId())) return user;
        }
        
        return null;
    }

    private void loadUsers() {
        if (this.users == null) {
            this.users = new ArrayList<User>();
        }

        File usersDir = new File(Server.userPath);
        
        for (File userDir : usersDir.listFiles()) {
            String userId = userDir.getName();
            User user = new User(userId);
            this.users.add(user);

            File biddingFile = userDir.listFiles()[0];
            try {
                Scanner biddingScanner = new Scanner(biddingFile);

                while (biddingScanner.hasNext()) {
                    String[] biddingInfo = biddingScanner.nextLine().split("\\|");
                    Bidding bidding = new Bidding(Integer.parseInt(biddingInfo[0]), Integer.parseInt(biddingInfo[1]));
                    user.addBidding(bidding);
                }

                biddingScanner.close();
            } catch (IOException ioe) {
                // System.out.println("[DEBUG] " + ioe.getMessage());
            }
        }


    }

    private void loadCourses() {
        if (this.courses == null) {
            this.courses = new ArrayList<Course>();
        }

        File courseDir = new File(Server.coursePath);

        // supposedly have only 1 directory: 2020_Spring
        for (File semesterDir : courseDir.listFiles()) {
            for (File collegeDir : semesterDir.listFiles()) {
                for (File courseFile : collegeDir.listFiles()) {
                    try {
                        Scanner courseScanner = new Scanner(courseFile);
                        String[] courseContents = courseScanner.nextLine().split("\\|");

                        int    courseId       = Integer.parseInt(courseFile.getName().split("\\.")[0]);
                        String college        = collegeDir.getName();
                        String department     = courseContents[0];
                        String academicDegree = courseContents[1];
                        int    academicYear   = Integer.parseInt(courseContents[2]);
                        String courseName     = courseContents[3];
                        int    credit         = Integer.parseInt(courseContents[4]);
                        String location       = courseContents[5];
                        String instructor     = courseContents[6];
                        int    quota          = Integer.parseInt(courseContents[7]);

                        this.courses.add(
                            new Course(
                                courseId, college, department, academicDegree, academicYear, courseName, credit, location, instructor, quota
                            )
                        );

                        courseScanner.close();
                    } catch (IOException ioe) {
                        // System.out.println("[DEBUG] " + ioe.getMessage());
                    } catch (NumberFormatException nfe) {
                        // System.out.println("[DEBUG] " + nfe.getMessage());
                    }
                    
                }
            }
        }
    }

    private List<Course> searchCourses(Map<String, Object> searchConditions) {
        if (searchConditions == null || searchConditions.isEmpty()) {
            return new ArrayList<Course>(this.courses);
        }
        
        List<Course> result = this.courses;

        for (String searchKey : searchConditions.keySet()) {
            List<Course> _result = new ArrayList<Course>();

            if (searchKey.equals("dept")) {
                String searchValue = (String) searchConditions.get(searchKey);

                result.forEach(
                    (Course course) -> {
                        if (course.department.equals(searchValue)) {
                            _result.add(course);
                        }
                    }
                );
            }
            else if (searchKey.equals("ay")) {
                int searchValue = (int) searchConditions.get(searchKey);

                result.forEach(
                    (Course course) -> {
                        if (course.academicYear == searchValue) {
                            _result.add(course);
                        }
                    }
                );
            }
            else if (searchKey.equals("name")) {
                String searchValue = (String) searchConditions.get(searchKey);
                String[] keywords = searchValue.split(" ");

                result.forEach(
                    (Course course) -> {
                        if (this.isKeywordsInCourseName(course.courseName, keywords)) {
                            _result.add(course);
                        }
                    }
                );
            }
            else {
                // System.out.println("[DEBUG] invalid search key: " + searchKey);
            }

            result = _result;
        }

        return result;
    }

    private void sortCourses(List<Course> courses, String sortCriteria) {
        if (sortCriteria == null || sortCriteria.length() == 0 || sortCriteria.equals("id")) {
            courses.sort(
                (Course c1, Course c2) -> Integer.compare(c1.courseId, c2.courseId)
            );
        }
        else if (sortCriteria.equals("name")) {
            courses.sort(
                (Course c1, Course c2) -> {
                    String name1 = c1.courseName;
                    String name2 = c2.courseName;
                    if (!name1.equals(name2)) return name1.compareTo(name2);
                    else return Integer.compare(c1.courseId, c2.courseId);
                }
            );
        }
        else if (sortCriteria.equals("dept")) {
            courses.sort(
                (Course c1, Course c2) -> {
                    String dept1 = c1.department;
                    String dept2 = c2.department;
                    if (!dept1.equals(dept2)) return dept1.compareTo(dept2);
                    else return Integer.compare(c1.courseId, c2.courseId);
                }
            );
        }
        else if (sortCriteria.equals("ay")) {
            courses.sort(
                (Course c1, Course c2) -> {
                    int ay1 = c1.academicYear;
                    int ay2 = c2.academicYear;
                    if (ay1 != ay2) return Integer.compare(ay1, ay2);
                    else return Integer.compare(c1.courseId, c2.courseId);
                }
            );
        }
        else {
            // System.out.println("[DEBUG] invalid sort Criteria: " + sortCriteria);
        }
    }

    private boolean isKeywordsInCourseName(String courseName, String[] keywords) {
        String[] courseNameWords = courseName.split(" ");

        for (String keyword : keywords) {
            boolean isKeywordInCourseName = false;
            for (String courseNameWord : courseNameWords) {
                if (courseNameWord.equals(keyword)) {
                    isKeywordInCourseName = true;
                }
            }

            if (!isKeywordInCourseName) return false;
        }

        return true;
    }
}