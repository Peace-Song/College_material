package hand.market;

import hand.agent.Buyer;
import hand.agent.Seller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Random;

class Pair<K,V> {
    public K key;
    public V value;
    Pair(K key, V value) {
        this.key = key;
        this.value = value;
    }
}

public class Market {
    public ArrayList<Buyer> buyers;
    public ArrayList<Seller> sellers;

    public Market(int nb, ArrayList<Double> fb, int ns, ArrayList<Double> fs) {
        buyers = createBuyers(nb, fb);
        sellers = createSellers(ns, fs);
    }
    
    private ArrayList<Buyer> createBuyers(int n, ArrayList<Double> f) {
        ArrayList<Buyer> buyers = new ArrayList<Buyer>();

        for (int idx = 1; idx <= n; idx++) {
            buyers.add(new Buyer(this.computePriceLimit(idx / (double)n, f)));
        }

        return buyers;
    }

    private ArrayList<Seller> createSellers(int n, ArrayList<Double> f) {
        ArrayList<Seller> sellers = new ArrayList<Seller>();

        for (int idx = 1; idx <= n; idx++) {
            sellers.add(new Seller(this.computePriceLimit(idx / (double)n, f)));
        }

        return sellers;
    }

    private double computePriceLimit(double x, ArrayList<Double> f) {
        double val = 0.0;

        for (int idx = 0; idx < f.size(); idx++) {
            int exp = f.size() - 1 - idx;
            double coef = f.get(idx);

            val += coef * Math.pow(x, exp);
        }

        return val;
    }

    private ArrayList<Pair<Seller, Buyer>> matchedPairs(int day, int round) {
        ArrayList<Seller> shuffledSellers = new ArrayList<>(sellers);
        ArrayList<Buyer> shuffledBuyers = new ArrayList<>(buyers);
        Collections.shuffle(shuffledSellers, new Random(71 * day + 43 * round + 7));
        Collections.shuffle(shuffledBuyers, new Random(67 * day + 29 * round + 11));
        ArrayList<Pair<Seller, Buyer>> pairs = new ArrayList<>();
        for (int i = 0; i < shuffledBuyers.size(); i++) {
            if (i < shuffledSellers.size()) {
                pairs.add(new Pair<>(shuffledSellers.get(i), shuffledBuyers.get(i)));
            }
        }
        return pairs;
    }

    public double simulate() {
        double lastDayXchgSum = 0.0;
        int lastDayXchgNum = 0;

        for (int day = 1; day <= 1000; day++) { // do not change this line
            for (int round = 1; round <= 10; round++) { // do not change this line
                ArrayList<Pair<Seller, Buyer>> pairs = matchedPairs(day, round); // do not change this line
                
                for (Pair<Seller, Buyer> pair : pairs) {
                    double sellerExpectedPrice = pair.key.getExpectedPrice();
                    
                    if (pair.key.willTransact(sellerExpectedPrice) && pair.value.willTransact(sellerExpectedPrice)) {
                        pair.key.makeTransaction();
                        pair.value.makeTransaction();

                        if (day == 1000) {
                            lastDayXchgSum += sellerExpectedPrice;
                            lastDayXchgNum++;
                        }
                    }
                }
            }

            for (Buyer buyer : buyers) buyer.reflect();
            for (Seller seller: sellers) seller.reflect();
        }
        
        return lastDayXchgSum / lastDayXchgNum;
    }
}
