
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

public class Test {
    public static void main(String[] args) {
        System.out.println("1.1 Test Cases -----------------------------");
        testSubproblem1();
        System.out.println("1.2 Test Cases -----------------------------");
        testSubproblem2();
        System.out.println("1.3 Test Cases -----------------------------");
        testSubproblem3();
        System.out.println("1.4 Test Cases -----------------------------");
        testSubproblem4();
    }
    static void testSubproblem1() {
        MovieApp movieApp = new MovieApp();
        printOX("1.1.1. findMovie null on empty MovieApp",
                movieApp.findMovie("Joker") == null);
        printOX("1.1.2. findUser null on empty MovieApp",
                movieApp.findUser("George") == null);
        printOX("1.1.3. addUser true on empty MovieApp",
                movieApp.addUser("George"));
        printOX("1.1.4. addUser false on a User with the same name",
                !movieApp.addUser("George"));
        printOX("1.1.5. addUser true on non-empty MovieApp",
                movieApp.addUser("Eva"));
        printOX("1.1.6. addUser true on with several consecutive",
                movieApp.addUser("Michael") &&
                        movieApp.addUser("Ab") &&
                        movieApp.addUser("T"));
        printOX("1.1.7. findUser returning User non-empty MovieApp",
                movieApp.findUser("Michael")
                        .toString().equals("Michael") &&
                        movieApp.findUser("Eva")
                                .toString().equals("Eva")
        );
        printOX("1.1.8. findUser null on non-empty MovieApp",
                movieApp.findUser("Travis") == null);
        movieApp.addMovie("Avatar",new String[]{"3D", "Fantasy", "Alien"});
        movieApp.addMovie("Joker",new String[]{"Criminal","Thriller","Art"});
        movieApp.addMovie("Hurt Locker",new String[]{"Thriller","War"});
        movieApp.addMovie("La La Land", new String[] {"romance", "love"});
        printOX("1.1.9. findMovie not null on existing Movie",
                movieApp.findMovie("Joker")
                        .toString().equals("Joker") &&
                        movieApp.findMovie("Avatar")
                                .toString().equals("Avatar"));
        printOX("1.1.10. findUser null on nonexistent Movie",
                movieApp.findMovie("The Devil's Advocate") == null &&
                        movieApp.findMovie("Hutr Locker") == null &&
                        movieApp.findMovie("Locker") == null);
        int numLoad = 300;
        for(int i = 0; i < numLoad; i++){
            movieApp.addMovie(Integer.toString(i),
                    new String[]{Integer.toString(i),
                            Integer.toString(i+1),Integer.toString(i+2)});
        }
        boolean load = true;
        for(int i = 0; i < numLoad; i++){
            Movie temp = movieApp.findMovie(Integer.toString(i));
            load = load && temp != null && temp.toString().equals(Integer.toString(i));
        }
        for(int i = numLoad; i < 2 * numLoad; i++){
            Movie temp = movieApp.findMovie(Integer.toString(i));
            load = load && temp == null ;
        }
        printOX("1.1.11. Loads of findMovie", load);

        load = true;
        for(int i = 0; i < numLoad; i++){
            boolean temp = movieApp.addUser(Integer.toString(i));
            load = load && temp;

        }
        for(int i = 0; i < numLoad; i++){
            User temp = movieApp.findUser(Integer.toString(i));
            load = load && temp != null && temp.toString().equals(Integer.toString(i));
        }
        for(int i = numLoad; i < 2 * numLoad; i++){
            User temp = movieApp.findUser(Integer.toString(i));
            load = load && temp == null ;
        }
        printOX("1.1.12. Loads of findUser", load);
    }

    static void testSubproblem2() {
        MovieApp movieApp = new MovieApp();
        movieApp.addMovie("Avatar",new String[]{"3D", "Fantasy", "Alien"});
        movieApp.addMovie("Joker",new String[]{"Criminal","Thriller","Art"});
        movieApp.addMovie("Hurt Locker",new String[]{"Thriller","War"});
        movieApp.addMovie("La La Land", new String[] {"romance", "love"});
        movieApp.addMovie("Zero Dark 30", new String[] {"War", "Art"});
        movieApp.addMovie("LOTR", new String[] {"Fantasy", "War"});
        movieApp.addMovie("Terminator", new String[] {"Thriller", "War","Fantasy", "Art"});

        printOX("1.2.1. Single tag findMoviesWithTags",
                compareMovieList(movieApp.findMoviesWithTags(new String[]{"Thriller",}),
                        Arrays.asList( new Movie("Hurt Locker"),
                                new Movie("Joker"),
                                new Movie("Terminator")))
        );
        printOX("1.2.2. Single tag findMoviesWithTags",
                compareMovieList(movieApp.findMoviesWithTags(new String[]{"War",}),
                        Arrays.asList(new Movie("Hurt Locker"),
                                new Movie("LOTR"),
                                new Movie("Terminator"),
                                new Movie("Zero Dark 30")
                        ))
        );
        printOX("1.2.3. Two tags findMoviesWithTags",
                compareMovieList(movieApp.findMoviesWithTags(new String[]{"War","Thriller"}),
                        Arrays.asList( new Movie("Hurt Locker"),
                                new Movie("Terminator")))
        );
        printOX("1.2.4. Four tags findMoviesWithTags",
                compareMovieList(movieApp.findMoviesWithTags(new String[]{"War","Thriller","Fantasy",  "Art"}),
                        Arrays.asList(new Movie("Terminator")))
        );
        printOX("1.2.5. No movies containing all the tags findMoviesWithTags",
                compareMovieList(movieApp.findMoviesWithTags(new String[]{"War","Thriller","romance"}),
                        new ArrayList<>())
        );
        printOX("1.2.6. Wrong tag name findMoviesWithTags",
                compareMovieList(movieApp.findMoviesWithTags(new String[]{"Unknown",}),
                        new ArrayList<>())
        );
        printOX("1.2.7. All weird tag names findMoviesWithTags",
                compareMovieList(movieApp.findMoviesWithTags(new String[]{"292","232","Hello"}),
                        new ArrayList<>())
        );
        printOX("1.2.8. One weird tag name among the tags findMoviesWithTags",
                compareMovieList(movieApp.findMoviesWithTags(new String[]{"Fantasy","War","Hello"}),
                        new ArrayList<>())
        );
        printOX("1.2.9. typo tag name findMoviesWithTags",
                compareMovieList(movieApp.findMoviesWithTags(new String[]{"Thrlller"}),
                        new ArrayList<>())
        );
        printOX("1.2.10. Zero-length tags findMoviesWithTags",
                compareMovieList(movieApp.findMoviesWithTags(new String[]{}),
                        new ArrayList<>())
        );

    }

    static void testSubproblem3() {
        MovieApp movieApp = new MovieApp();

        movieApp.addMovie("Avatar",new String[]{"3D", "Fantasy", "Alien"});
        movieApp.addMovie("Joker",new String[]{"Criminal","Thriller","Art"});
        movieApp.addMovie("Hurt Locker",new String[]{"Thriller","War"});
        movieApp.addMovie("La La Land", new String[] {"romance", "love"});
        movieApp.addMovie("Zero Dark 30", new String[] {"War", "Art"});
        movieApp.addMovie("LOTR", new String[] {"Fantasy", "War"});
        movieApp.addMovie("Terminator", new String[] {"Thriller", "War","Fantasy", "Art"});
        movieApp.addUser("George");
        movieApp.addUser("Alice");
        movieApp.addUser("Fredrich 2");
        movieApp.addUser("John II the GOOD");

        User alice = movieApp.findUser("Alice");
        User george = movieApp.findUser("George");
        User fredrich = movieApp.findUser("Fredrich 2");
        User john = movieApp.findUser("John II the GOOD");

        printOX("1.3.1. Successful rateMovie",movieApp.rateMovie(alice, "Joker", 5) );
        printOX("1.3.2. Successful getUserRating", movieApp.getUserRating(alice,"Joker") == 5);
        printOX("1.3.3. getUserRating Before Rating", movieApp.getUserRating(fredrich,"Joker") == 0);
        printOX("1.3.4. Nonexistent User on getUserRating", movieApp.getUserRating(movieApp.findUser("Hello"),"Joker") == -1);
        printOX("1.3.5. Nonexistent Movie on getUserRating", movieApp.getUserRating(fredrich,"Zero Dark 3O") ==-1);

        printOX("1.3.6. Nonexistent User on rateMovie",!movieApp.rateMovie(movieApp.findUser("Man"), "Joker", 5));

        printOX("1.3.7. Nonexistent Movie on rateMovie",!movieApp.rateMovie(george, "LOTR2", 5) );

        printOX("1.3.8. Rating out of range",
                !movieApp.rateMovie(george, "LOTR", 11) &&
                        !movieApp.rateMovie(george, "LOTR", 0));

        printOX("1.3.9. Weird User Names",movieApp.rateMovie(fredrich, "Terminator", 6)
                && movieApp.rateMovie(john, "La La Land", 10)
                && movieApp.getUserRating(fredrich,"Terminator") == 6
                && movieApp.getUserRating(john,"La La Land") == 10);

        printOX("1.3.10. Only the Last Rating",movieApp.rateMovie(fredrich, "Avatar", 3)
                &&movieApp.rateMovie(fredrich, "Avatar", 4)
                && movieApp.getUserRating(fredrich,"Avatar") == 4);


        movieApp.rateMovie(fredrich
                , "La La Land", 4);
        movieApp.rateMovie(alice
                , "LOTR", 9);
        movieApp.rateMovie(john
                ,"Avatar" , 10);
        movieApp.rateMovie(george
                , "LOTR", 6);;
        movieApp.rateMovie(alice
                , "LOTR", 3);
        movieApp.rateMovie(george
                , "Joker", 3);
        movieApp.rateMovie(john
                ,"Joker" , 6);
        movieApp.rateMovie(fredrich
                , "LOTR", 4);
        movieApp.rateMovie(john
                , "La La Land", 2);
        movieApp.rateMovie(fredrich
                , "Avatar", 1);
        movieApp.rateMovie(alice
                , "Joker", 9);
        movieApp.rateMovie(george
                , "LOTR", 8);
        movieApp.rateMovie(john
                ,"Avatar" , 8);
        movieApp.rateMovie(alice
                ,"La La Land" , 5);
        movieApp.rateMovie(george
                ,"Avatar" , 1);
        movieApp.rateMovie(george
                , "Joker", 5);
        movieApp.rateMovie(john
                ,"Joker" , 3);
        movieApp.rateMovie(fredrich
                , "La La Land", 4);
        movieApp.rateMovie(fredrich
                , "LOTR", 2);
        movieApp.rateMovie(alice
                ,"La La Land" , 5);
        movieApp.rateMovie(george
                ,"Avatar" , 8);
        movieApp.rateMovie(john
                , "La La Land", 10);
        movieApp.rateMovie(fredrich
                , "Avatar", 3);
        movieApp.rateMovie(alice, "Joker", 9);
        printOX("1.3.11. Fredrich rating with consecutive rating",
                movieApp.getUserRating(fredrich,"LOTR") == 2
                        && movieApp.getUserRating(fredrich,"La La Land") == 4
                        && movieApp.getUserRating(fredrich,"Joker") == 0
                        && movieApp.getUserRating(fredrich,"Avatar") == 3);
        printOX("1.3.12. Alice rating with consecutive rating",
                movieApp.getUserRating(alice,"LOTR") == 3
                        && movieApp.getUserRating(alice,"La La Land") == 5
                        && movieApp.getUserRating(alice,"Joker") == 9
                        && movieApp.getUserRating(alice,"Avatar") == 0);

        printOX("1.3.13. John rating with consecutive rating",
                movieApp.getUserRating(john,"LOTR") == 0
                        && movieApp.getUserRating(john,"La La Land") == 10
                        && movieApp.getUserRating(john,"Joker") == 3
                        && movieApp.getUserRating(john,"Avatar") == 8);

        printOX("1.3.14. George rating with consecutive rating",
                movieApp.getUserRating(george,"LOTR") == 8
                        && movieApp.getUserRating(george,"La La Land") == 0
                        && movieApp.getUserRating(george,"Joker") == 5
                        && movieApp.getUserRating(george,"Avatar") == 8);
    }

    static void testSubproblem4() {
        MovieApp movieApp = new MovieApp();

        movieApp.addMovie("Avatar",new String[]{"3D", "Fantasy", "Alien"});
        movieApp.addMovie("Joker",new String[]{"Criminal","Thriller","Art"});
        movieApp.addMovie("Hurt Locker",new String[]{"Thriller","War"});
        movieApp.addMovie("La La Land", new String[] {"romance", "love"});
        movieApp.addMovie("Zero Dark 30", new String[] {"War", "Art"});
        movieApp.addMovie("LOTR", new String[] {"Fantasy", "War"});
        movieApp.addMovie("Terminator", new String[] {"Thriller", "War","Fantasy", "Art"});
        movieApp.addUser("George");
        movieApp.addUser("Alice");
        movieApp.addUser("Fredrich 2");
        movieApp.addUser("John II the GOOD");

        User alice = movieApp.findUser("Alice");
        User george = movieApp.findUser("George");
        User fredrich = movieApp.findUser("Fredrich 2");
        User john = movieApp.findUser("John II the GOOD");

        printOX("1.4.1. Single tag findUserMoviesWithTags",
                compareMovieList(movieApp.findUserMoviesWithTags(alice,new String[]{"Thriller",}),
                        Arrays.asList( new Movie("Hurt Locker"),
                                new Movie("Joker"),
                                new Movie("Terminator")))
        );
        printOX("1.4.2. Four tags findUserMoviesWithTags",
                compareMovieList(movieApp.findUserMoviesWithTags(john,new String[]{"War","Thriller","Fantasy",  "Art"}),
                        Arrays.asList(new Movie("Terminator")))
        );
        movieApp.rateMovie(fredrich
                , "La La Land", 4);
        movieApp.rateMovie(alice
                , "LOTR", 9);
        movieApp.rateMovie(john
                ,"Avatar" , 10);

        printOX("1.4.3. Single tag findUserMoviesWithTags",
                compareMovieList(movieApp.findUserMoviesWithTags(george, new String[]{"War",}),
                        Arrays.asList(new Movie("Hurt Locker"),
                                new Movie("LOTR"),
                                new Movie("Terminator"),
                                new Movie("Zero Dark 30")
                        ))
        );
        movieApp.rateMovie(george
                , "LOTR", 6);;
        movieApp.rateMovie(alice
                , "LOTR", 3);
        movieApp.rateMovie(alice
                , "Avatar", 1);

        movieApp.rateMovie(john
                ,"Joker" , 3);
        movieApp.rateMovie(fredrich
                , "La La Land", 4);
        movieApp.rateMovie(fredrich
                , "LOTR", 2);
        movieApp.rateMovie(alice
                ,"La La Land" , 5);
        movieApp.rateMovie(george
                ,"Avatar" , 8);
        movieApp.rateMovie(george
                ,"La La Land" , 9);
        movieApp.rateMovie(john
                , "La La Land", 10);
        movieApp.rateMovie(john
                , "LOTR", 2);

        printOX("1.4.4. Single tag findYserMoviesWithTags",
                compareMovieList(movieApp.findUserMoviesWithTags(fredrich, new String[]{"Art",}),
                        Arrays.asList(new Movie("Joker"),
                                new Movie("Terminator"),
                                new Movie("Zero Dark 30")
                        ))
        );
        movieApp.rateMovie(fredrich
                , "Avatar", 3);
        movieApp.rateMovie(george
                , "Joker", 3);
        movieApp.rateMovie(john
                ,"Joker" , 6);

        printOX("1.4.5. Two tags findUserMoviesWithTags",
                compareMovieList(movieApp.findUserMoviesWithTags(fredrich,new String[]{"War","Thriller"}),
                        Arrays.asList( new Movie("Hurt Locker"),
                                new Movie("Terminator")))
        );
        movieApp.rateMovie(fredrich
                , "LOTR", 4);
        movieApp.rateMovie(john
                , "La La Land", 2);
        movieApp.rateMovie(fredrich
                , "Zero Dark 30", 10);
        movieApp.rateMovie(fredrich
                , "Terminator", 1);
        movieApp.rateMovie(fredrich
                , "Avatar", 1);
        movieApp.rateMovie(alice
                , "Joker", 9);

        printOX("1.4.6. Wrong tag name findUserMoviesWithTags",
                compareMovieList(movieApp.findUserMoviesWithTags(john,new String[]{"Unknown",}),
                        new ArrayList<>())
        );
        movieApp.rateMovie(george
                , "LOTR", 8);
        movieApp.rateMovie(john
                ,"Avatar" , 8);
        movieApp.rateMovie(alice
                ,"La La Land" , 5);
        movieApp.rateMovie(george
                ,"Avatar" , 1);
        movieApp.rateMovie(george
                , "Joker", 5);

        printOX("1.4.7. Fredrich Recommendation",
                compareMovieList(movieApp.recommend(fredrich),
                        Arrays.asList(
                                new Movie("Zero Dark 30"),
                                new Movie("Joker"),
                                new Movie("Terminator")
                        ))
        );
        printOX("1.4.8. Alice Recommendation",
                compareMovieList(movieApp.recommend(alice),
                        Arrays.asList(
                                new Movie("Joker"),
                                new Movie("Terminator"),
                                new Movie("Hurt Locker")
                        ))
        );

        printOX("1.4.9. George Recommendation",
                compareMovieList(movieApp.recommend(george),
                        Arrays.asList(
                                new Movie("Zero Dark 30"),
                                new Movie("LOTR"),
                                new Movie("Terminator")
                        ))
        );
        printOX("1.4.10. John Recommendation",
                compareMovieList(movieApp.recommend(john),
                        Arrays.asList(
                                new Movie("Terminator")
                        ))
        );
        printOX("1.4.11. Wrong user Recommendation",
                compareMovieList(movieApp.recommend(movieApp.findUser("Hello")),
                        new LinkedList<>()
                ));
    }
    static void printOX(String prompt,boolean condition){
        if(condition){
            System.out.println("" + prompt + " | O");
        }
        else{
            System.out.println("" + prompt + " | X");
        }
    }
    static void print(Object o){
        System.out.println(o);
    }

    static boolean compareMovieList(List<Movie> in, List<Movie> comp){
        if(in.size() != comp.size())
            return false;

        for(int i = 0; i < in.size(); i++){
            if (!in.get(i).toString().equals(comp.get(i).toString()))
                return false;
        }
        return true;
    }
}
