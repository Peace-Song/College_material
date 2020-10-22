import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

class DiaryEntry {
    private static int incrementId = 0;
    private int id;
    private String title;
    private String content;
    private LocalDateTime createdAt;

    public DiaryEntry(String title, String content) {
        this.id = ++incrementId;
        this.title = title;
        this.content = content;
        this.createdAt = LocalDateTime.now();
    }

    public DiaryEntry(int id, String title, String content, String createdTime) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.createdAt = parseDateTimeString(createdTime);
    }

    public String getShortString() {
        return String.format("id: %d, created at: %s, title: %s", id, getDateTimeString(), title);
    }

    public String getFullString() {
        return String.format("id: %d\n\tcreated at: %s\n\ttitle: %s\n\tcontent: %s", id, getDateTimeString(), title, content);
    }

    public String getFileName() {
        return String.format("%s-%02d-%s.txt", getDateString(), id, title);
    }

    public List<String> getFileData() {
        List<String> data = new ArrayList<>();
        data.add(Integer.toString(this.id));
        data.add(this.createdAt.toString());
        data.add(this.title);
        data.add(this.content);
        return data;
    }

    public int getID() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }

    public String getDateString() {
        return createdAt.format(DateTimeFormatter.ofPattern("yyyy.MM.dd"));
    }

    public String getDateTimeString() {
        return createdAt.format(DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss"));
    }

    private static LocalDateTime parseDateTimeString(String dateTimeString) {
        return LocalDateTime.parse(dateTimeString);
    }

    public static void updateIncrementId(int id) {
        if (id > incrementId) {
            incrementId = id;
        }
    }
}
