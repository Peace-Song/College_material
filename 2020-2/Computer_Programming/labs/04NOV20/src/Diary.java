import java.util.List;
import java.util.LinkedList;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;
import java.util.HashSet;
import java.util.Map;

public class Diary {
    private List<DiaryEntry> diaryEntries = new LinkedList<>();
    private Map<Integer, Set<String>> searchMap = new HashMap<>();

    private static String DATA_PATH = "data/";

    public Diary() throws NoDataDirectoryException {
        loadEntries();
    }

    public void createEntry() throws NoDataDirectoryException {
        String title = DiaryUI.input("title: ");
        String content = DiaryUI.input("content: ");
        DiaryEntry entry = new DiaryEntry(title, content);
        diaryEntries.add(entry);
        saveEntry(entry);
        addSearchKeyWords(entry);

        DiaryUI.print("The entry is saved.");
    }

    public void listEntries() {
        for (int i=diaryEntries.size()-1; i>=0; i--) {
            DiaryEntry entry = diaryEntries.get(i);
            DiaryUI.print(entry.getShortString());
        }
    }

    public void readEntry(int id) {
        DiaryEntry entry = findEntry(id);
        if (entry == null) {
            DiaryUI.print("There is no entry with id " + id);
            return;
        }

        DiaryUI.print(entry.getFullString());
    }

    public void deleteEntry(int id) {
        DiaryEntry entry = findEntry(id);
        if (entry == null) {
            DiaryUI.print("There is no entry with id " + id);
            return;
        }

        if (StorageManager.deleteFile(DATA_PATH + entry.getFileName())) {
            diaryEntries.remove(entry);
            searchMap.remove(id);
            DiaryUI.print("Entry " + id + " is removed.");
        }
    }

    public void searchEntry(String keyword) {
        List<DiaryEntry> searchRes = new ArrayList<DiaryEntry>();

        for (int id : searchMap.keySet()) {
            Set<String> keywords = searchMap.get(id);
            if (keywords.contains(keyword)) {
                searchRes.add(findEntry(id));
            }
        }

        if (searchRes.isEmpty()) {
            DiaryUI.print("There is no entry that contains \"" + keyword + "\"");
            return;
        }

        for (DiaryEntry entry : searchRes) {
            DiaryUI.print(entry.getFullString());
            DiaryUI.print("");
        }
    }

    private void addSearchKeyWords(DiaryEntry entry) {
        Set<String> keywords = new HashSet<>();
        searchMap.put(entry.getID(), keywords);

        for (String keyword : entry.getTitle().split("\\s")) {
            keywords.add(keyword);
        }

        for (String keyword : entry.getContent().split("\\s")) {
            keywords.add(keyword);
        }
    }

    private DiaryEntry findEntry(int id) {
        for (DiaryEntry entry : diaryEntries) {
            if (entry.getID() == id) {
                return entry;
            }
        }
        return null;
    }

    private void loadEntries() throws NoDataDirectoryException {
        List<List<String>> entryDataList = StorageManager.directoryChildrenLines(DATA_PATH);
        for (List<String> entryData : entryDataList) {
            if (entryData.size() < 4) {
                continue;
            }

            int id = Integer.parseInt(entryData.get(0));
            String createdTime = entryData.get(1);
            String title = entryData.get(2);
            String content = entryData.get(3);

            DiaryEntry entry = new DiaryEntry(id, title, content, createdTime);
            diaryEntries.add(entry);
            addSearchKeyWords(entry);

            DiaryEntry.updateIncrementId(id);
        }
    }

    private void saveEntry(DiaryEntry entry) throws NoDataDirectoryException {
        String filePath = DATA_PATH + entry.getFileName();
        List<String> fileData = entry.getFileData();
        StorageManager.writeLines(filePath, fileData);
    }
}
