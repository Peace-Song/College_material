import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class BackEnd extends ServerResourceAccessible {
    // Use getServerStorageDir() as a default directory
    // Create helper funtions to support FrontEnd class

    private final static DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");

    private static int postNum = 0;

    public boolean auth(String id, String pw) {
        try {
            Scanner scanner = new Scanner(new File(this.getServerStorageDir() + id + "/password.txt"));
            String truePw = scanner.nextLine();
            
            scanner.close();
            return truePw.equals(pw);
        } catch (FileNotFoundException fnfe) {
            return false;
        }
    }

    public void post(String id, String title, String content, LocalDateTime time) {
        try {
            int postNum = new File(this.getServerStorageDir() + id + "/post/").length() == 0 ? 0 : this.getPostNum();

            FileWriter fWriter = new FileWriter(new File(this.getServerStorageDir() + id + "/post/" + postNum + ".txt"));
            
            fWriter.write(time.format(BackEnd.formatter) + "\n");
            fWriter.write(title + "\n\n");
            fWriter.write(content + "\n");

            fWriter.close();
            return;
        } catch (IOException fnfe) {
            return;
        }
    }

    public List<Post> getFriendsPosts(String id) {
        ArrayList<String> friendNames = new ArrayList<String>();
        ArrayList<Post> friendPosts = new ArrayList<Post>();

        try {
            Scanner friendNameScanner = new Scanner(new File(this.getServerStorageDir() + id + "/friend.txt"));

            while (friendNameScanner.hasNextLine()) {
                friendNames.add(friendNameScanner.nextLine());
            }

            friendNameScanner.close();

            for (String friendName : friendNames) {
                File friendPostDir = new File(this.getServerStorageDir() + friendName + "/post/");

                for (File post : friendPostDir.listFiles()) {
                    Scanner postScanner = new Scanner(post);

                    String dateString = postScanner.nextLine();
                    String title = postScanner.nextLine();
                    postScanner.nextLine();
                    String content = "";
                    while (postScanner.hasNextLine()) {
                        content += postScanner.nextLine() + "\n";
                    }

                    friendPosts.add(new Post(Integer.parseInt(post.getName().split("[.]")[0]), Post.parseDateTimeString(dateString, formatter), title, content));

                    postScanner.close();
                }
            }

            friendPosts.sort(
                (Post p1, Post p2) -> -Post.parseDateTimeString(p1.getDate(), formatter).compareTo(Post.parseDateTimeString(p2.getDate(), formatter))
            );

            return friendPosts;

        } catch (FileNotFoundException fnfe) {
            return null;
        }
    }

    public List<Post> search(String[] keywords) {
        ArrayList<Pair<Post, Integer>> postOccurencePair = new ArrayList<Pair<Post, Integer>>();

        try {
            for (File userDir : new File(this.getServerStorageDir()).listFiles()) {
                File userPostDir = new File(userDir, "post/");

                for (File post : userPostDir.listFiles()) {
                    Scanner postScanner = new Scanner(post);
                    String dateString = postScanner.nextLine();
                    String title = postScanner.nextLine();
                    postScanner.nextLine();
                    String content = "";
                    while (postScanner.hasNextLine()) {
                        content += postScanner.nextLine() + " ";
                    }

                    int count = 0;
                    for (String keyword : keywords) {
                        for (String titleKw : title.split(" ")) {
                            if (titleKw.equals(keyword)) {
                                count++;
                            }
                        }

                        for (String contentKw : content.split(" ")) {
                            if (contentKw.equals(keyword)) {
                                count++;
                            }
                        }
                    }

                    if (count != 0) {
                        postOccurencePair.add(new Pair<Post, Integer>(new Post(Integer.parseInt(post.getName().split("[.]")[0]), Post.parseDateTimeString(dateString, formatter), title, content), count));
                    }
                    
                    postScanner.close();
                }
            }

            postOccurencePair.sort(
                (Pair<Post, Integer> p1, Pair<Post, Integer> p2) -> {
                    int cmp = Integer.compare(p1.value, p2.value);
                    if (cmp == 0) {
                        cmp = -Post.parseDateTimeString(p1.key.getDate(), formatter).compareTo(Post.parseDateTimeString(p2.key.getDate(), formatter));
                    }
                    return cmp;
                }
            );

            ArrayList<Post> result = new ArrayList<Post>();
            for (Pair<Post, Integer> pair : postOccurencePair) {
                result.add(pair.key);
            }

            return result;

        } catch (FileNotFoundException fnfe) {
            return null;
        }
        
    }

    private int getPostNum() {
        int maxId = 0;

        File dataDir = new File(this.getServerStorageDir());
        for (File userDir : dataDir.listFiles()) {
            if (userDir.isDirectory()) {
                File userPostDir = new File(userDir, "post/");

                for (File post : userPostDir.listFiles()) {
                    int postId = Integer.parseInt(post.getName().split("[.]")[0]);

                    if (postId > maxId) {
                        maxId = postId;
                    }
                }
            }
        }

        return maxId + 1;
    }
}
