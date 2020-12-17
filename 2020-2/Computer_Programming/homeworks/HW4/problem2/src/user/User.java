package user;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import course.Bidding;
import server.Server;

public class User {
    private String id;
    private List<Bidding> biddings;
    
    public User(String id) {
        this.id = id;
        this.biddings = new ArrayList<Bidding>();
    }

    public String getUserId() { return this.id; }
    public List<Bidding> getBiddings() { return this.biddings; }

    public Bidding findBiddingByCourseId(int courseId) {
        for (Bidding bidding : this.biddings) {
            if (bidding.courseId == courseId) return bidding;
        }

        return null;
    }

    public void addBidding(Bidding bidding) {
        this.biddings.add(bidding);
    }

    public void addBiddingAndWrite(Bidding bidding) throws FileNotFoundException {
        this.biddings.add(bidding);
        this.writeBidding();
    }
    
    public void removeBiddingAndWrite(Bidding bidding) throws FileNotFoundException {
        this.biddings.remove(bidding);
        this.writeBidding();
    }

    private void writeBidding() throws FileNotFoundException {
        File biddingFile = new File(Server.userPath + "/" + this.id + "/bid.txt");
        PrintWriter writer = new PrintWriter(new FileOutputStream(biddingFile, false));
        for (Bidding bidding : this.biddings) {
            writer.printf("%d|%d\n", bidding.courseId, bidding.mileage);
        }
        writer.close();
    }

    public void appendBiddingToFinalBid(Bidding bidding) throws FileNotFoundException {
        File biddingFile = new File(Server.userPath + "/" + this.id + "/final_bid.txt");
        PrintWriter writer = new PrintWriter(new FileOutputStream(biddingFile, true));
        writer.printf("%d|%d\n", bidding.courseId, bidding.mileage);
        writer.close();
    }
}
