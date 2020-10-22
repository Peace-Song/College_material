import java.io.File;
import java.util.*;

public class Diary {
    private ArrayList<DiaryEntry> entries;
    
    private static String PATH = "../data/";
    
	public Diary() {
        this.entries = new ArrayList<DiaryEntry>();
        this.loadEntries();
	}
	
    public void createEntry() {
        String entryName;
        String content;
        DiaryEntry entry;

        // Practice 2 - Store the created entry in a file
        entryName = DiaryUI.input("title: ");
        
        content = DiaryUI.input("content: ");

        entry = new DiaryEntry(entryName, content);
        this.entries.add(entry);
        this.saveEntry(entry);
        DiaryUI.print("The entry is saved.");
    }

    public void listEntries() {
        // Practice 2 - Your list should contain previously stored files

        for (int idx = this.entries.size() - 1; idx >= 0; idx--) {
            DiaryEntry entry = this.entries.get(idx);

            if (entry != null) {
                DiaryUI.print(entry.getShortString());
            }
        }
    }

    public void readEntry(int id) {
        // Practice 2 - Your read should contain previously stored files

        for (int idx = 0; idx < this.entries.size(); idx++) {
            DiaryEntry entry = this.entries.get(idx);
            if (entry.getID() == id) {
                DiaryUI.print(entry.getFullString());
                return;
            }
        }

        DiaryUI.print("There is no entry with id " + id + ".");
        return;
    }

    public void deleteEntry(int id) {
        // Practice 2 - Delete the file of the entry

        for (int idx = 0; idx < this.entries.size(); idx++) {
            DiaryEntry entry = this.entries.get(idx);
            if (entry.getID() == id) {
                StorageManager.deleteFile(Diary.PATH + entry.getFileName());
                this.entries.remove(entry);
                
                DiaryUI.print("Entry " + id + " is deleted.");
                return;
            }
        }

        DiaryUI.print("There is no entry with id " + id + ".");
        return;
    }

    public void searchEntry(String keyword) {
        // Practice 2 - Your search should contain previously stored files
        boolean hitFlag = false;
        for (int idx = 0; idx < this.entries.size(); idx++) {
            if (this.isMatched(this.entries.get(idx), keyword)) {
                DiaryUI.print(this.entries.get(idx).getFullString());
                System.out.println();
                hitFlag = true;
            }
        }

        if (!hitFlag) DiaryUI.print("There is no entry that contains \"" + keyword + "\".");
    }

    private boolean isMatched(DiaryEntry entry, String keyword) {
        String[] title_list = entry.getTitle().split("\\s");
        String[] content_list = entry.getContent().split("\\s");

        for (String title_elem : title_list) {
            if (title_elem.equals(keyword)) return true;
        }
        
        for (String content_elem : content_list) {
            if (content_elem.equals(keyword)) return true;
        }

        return false;
    }

    private void loadEntries() {
        List<List<String>> entries = StorageManager.directoryChildrenLines(Diary.PATH);

        for (List<String> entry_list : entries) {
            if (entry_list.size() < 4) {
                continue;
            }

            int id = Integer.parseInt(entry_list.get(0));
            String createdTime = entry_list.get(1);
            String title = entry_list.get(2);
            String content = entry_list.get(3);

            DiaryEntry entry = new DiaryEntry(id, title, content, createdTime);
            this.entries.add(entry);
        }
    }

    private void saveEntry(DiaryEntry entry) {
        String fname = Diary.PATH + entry.getFileName();
        List<String> fdata = entry.getFileData();
        StorageManager.writeLines(fname, fdata);
    }
}
