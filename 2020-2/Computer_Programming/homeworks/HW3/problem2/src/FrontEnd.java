import java.util.*;
import java.io.FileInputStream;
import java.time.LocalDateTime;

public class FrontEnd {
    private UserInterface ui;
    private BackEnd backend;
    private User user;

    public FrontEnd(UserInterface ui, BackEnd backend) {
        this.ui = ui;
        this.backend = backend;
    }
    
    public boolean auth(String authInfo){
        // id + \n + pw
        String id = authInfo.split("\n")[0];
        String password = authInfo.split("\n")[1];

        if (this.backend.auth(id, password)) {
            this.user = new User(id, password);
            return true;
        } 
        else { 
            return false; 
        }
    }

    public void post(Pair<String, String> titleContentPair) {
        String title = titleContentPair.key;
        String content = titleContentPair.value;
        LocalDateTime time = LocalDateTime.now();
        
        this.backend.post(this.user.id, title, content, time);
    }
    
    public void recommend(){
        List<Post> posts = this.backend.getFriendsPosts(this.user.id);

        posts = posts.subList(0, Math.min(posts.size(), 10));

        for (Post post : posts) {
            ui.println(post.toString());
        }
    }

    public void search(String command) {
        String[] slices = command.split(" ");
        String[] keywords = new String[slices.length - 1];
        for (int idx = 1; idx < slices.length; idx++) {
            keywords[idx - 1] = slices[idx];
        }

        List<Post> posts = this.backend.search(keywords);

        posts = posts.subList(0, Math.min(posts.size(), 10));

        for (Post post : posts) {
            ui.println(post.getSummary());
        }
    }
    
    User getUser(){
        return this.user;
    }
}
