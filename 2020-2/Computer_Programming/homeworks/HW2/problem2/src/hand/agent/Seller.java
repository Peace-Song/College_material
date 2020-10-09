package hand.agent;

public class Seller extends Agent {

    public Seller(double minimumPrice) {
        super(minimumPrice);
    }

    @Override
    public boolean willTransact(double price) {
        if (this.hadTransaction) return false;

        return price >= this.expectedPrice ? true : false;
    }

    @Override
    public void reflect() {
        if (this.hadTransaction) this.expectedPrice += this.adjustment;
        else this.expectedPrice -= this.adjustment;

        if (this.expectedPrice < this.priceLimit) this.expectedPrice = this.priceLimit;

        this.hadTransaction = false;
        
        return;
    }
}
