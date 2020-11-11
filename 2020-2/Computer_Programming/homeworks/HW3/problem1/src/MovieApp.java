
import java.util.*;

public class MovieApp {
    private HashMap<Movie, String[]> movies;
    private HashSet<User> users; 
    private HashSet<Rating> ratings;
    private HashMap<User, List<List<Movie>>> searchHistory;

    public MovieApp() {
        this.movies = new HashMap<Movie, String[]>();
        this.users = new HashSet<User>();
        this.ratings = new HashSet<Rating>();
        this.searchHistory = new HashMap<User, List<List<Movie>>>();
    }

    public boolean addMovie(String title, String[] tags) {
        for (HashMap.Entry<Movie, String[]> movieEntry : this.movies.entrySet()) {
            if (movieEntry.getKey().toString().equals(title)) {
                return false;
            }
        }

        this.movies.put(new Movie(title), tags);

        return true;
    }

    public boolean addUser(String name) {
        for (User user : this.users) {
            if (user.toString().equals(name)) {
                return false;
            }
        }
        
        this.users.add(new User(name));

        return true;
    }

    public Movie findMovie(String title) {
        for (HashMap.Entry<Movie, String[]> movieEntry : this.movies.entrySet()) {
            if (movieEntry.getKey().toString().equals(title)) {
                return movieEntry.getKey();
            }
        }
        
        return null;
    }

    public User findUser(String username) {
        for (User user : this.users) {
            if (user.toString().equals(username)) {
                return user;
            }
        }

        return null;
    }

    public List<Movie> findMoviesWithTags(String[] tags) {
        LinkedList<Movie> result = new LinkedList<Movie>();

        if (tags.length == 0) return result;

        for (HashMap.Entry<Movie, String[]> movieEntry : this.movies.entrySet()) {
            String[] movieTags = movieEntry.getValue();
            
            if (this.isTagsInMovieTags(tags, movieTags)) {
                result.add(movieEntry.getKey());
            }
        }

        result.sort(
            (Movie m1, Movie m2) -> m1.toString().compareTo(m2.toString())
        );

        return result;
    }

    public boolean rateMovie(User user, String title, int rating) {
        if (user == null || 
            this.findUser(user.toString()) == null ||
            title == null ||
            this.findMovie(title) == null ||
            !(1 <= rating && rating <= 10)) {
            return false;
        }

        for (Rating ratingObj : this.ratings) {
            if (ratingObj.getRater() == user && ratingObj.getMovie().toString().equals(title)) {
                ratingObj.setRating(rating);
                return true;
            }
        }

        this.ratings.add(new Rating(this.findMovie(title), user, rating));
        return true;
    }

    public int getUserRating(User user, String title) {
        if (user == null ||
            this.findUser(user.toString()) == null ||
            title == null ||
            this.findMovie(title) == null) {
            return -1;
        }

        for (Rating ratingObj : this.ratings) {
            if (ratingObj.getRater() == user && ratingObj.getMovie().toString().equals(title)) {
                return ratingObj.getRating();
            }
        }

        return 0;
    }

    public List<Movie> findUserMoviesWithTags(User user, String[] tags) {
        if (user == null || this.findUser(user.toString()) == null) {
            return new LinkedList<Movie>();
        }

        List<Movie> searchResult = this.findMoviesWithTags(tags);

        if (!this.searchHistory.containsKey(user)) {
            this.searchHistory.put(user, new LinkedList<List<Movie>>());
        }

        this.searchHistory.get(user).add(searchResult);

        return searchResult;
    }

    public List<Movie> recommend(User user) {
        if (user == null || this.findUser(user.toString()) == null) {
            return new LinkedList<Movie>();
        }
        List<List<Movie>> userHistory = this.searchHistory.get(user);
        List<Movie> moviesSearched = new LinkedList<Movie>();

        for (List<Movie> searchResult : userHistory) {
            for (Movie movie : searchResult) {
                if (!moviesSearched.contains(movie)) {
                    moviesSearched.add(movie);
                }
            }
        }

        moviesSearched.sort(
            (Movie m1, Movie m2) -> m1.toString().compareTo(m2.toString())
        );

        List<Movie> sortedMovies = new LinkedList<Movie>();
        while (moviesSearched.size() > 0) {
            float bestRating = -1;
            Movie bestRatingMovie = null;

            for (Movie movie : moviesSearched) {
                float avgRating = this.getMovieAvgRating(movie);
                
                if (avgRating > bestRating) {
                    bestRating = avgRating;
                    bestRatingMovie = movie;
                }
            }

            sortedMovies.add(bestRatingMovie);
            moviesSearched.remove(bestRatingMovie);
        }
        
        return sortedMovies.subList(0, Math.min(sortedMovies.size(), 3));
    }

    private boolean isTagsInMovieTags(String[] tags, String[] movieTags) {
        int tagsIdx = 0;
        int movieTagsIdx = 0;
        for (tagsIdx = 0; tagsIdx < tags.length; tagsIdx++) {
            for (movieTagsIdx = 0; movieTagsIdx < movieTags.length; movieTagsIdx++) {
                if (tags[tagsIdx].equals(movieTags[movieTagsIdx])) {
                    break;
                }
            }

            if (movieTagsIdx == movieTags.length) {
                return false;
            }
        }

        return true;
    }

    private float getMovieAvgRating(Movie movie) {
        int ratingNum = 0;
        int ratingSum = 0;

        for (Rating rating : this.ratings) {
            if (rating.getMovie() == movie) {
                ratingNum++;
                ratingSum += rating.getRating();
            }
        }

        if (ratingNum == 0) { return 0; }

        return ratingSum / (float)ratingNum;
    }
}

class Rating {
    private Movie movie;
    private User rater;
    private int rating;

    public Rating(Movie movie, User rater, int rating) {
        this.movie = movie;
        this.rater = rater;
        this.rating = rating;
    }

    public Movie getMovie() { return this.movie; }
    public User getRater() { return this.rater; }
    public int getRating() { return this.rating; }

    public void setRating(int rating) { this.rating = rating; }
}