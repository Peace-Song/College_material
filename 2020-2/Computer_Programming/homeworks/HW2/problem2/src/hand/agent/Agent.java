package hand.agent;

public abstract class Agent {
    protected double priceLimit;
    protected double expectedPrice;
    protected double adjustment;
    protected boolean hadTransaction;

    Agent(double priceLimit) {
        this.priceLimit = priceLimit;
        expectedPrice = priceLimit;
        adjustment = 10;
        hadTransaction = false;
    }

    public double getExpectedPrice() {
        return expectedPrice;
    }

    public void makeTransaction() {
        hadTransaction = true;
    }

    abstract public boolean willTransact(double price);

    abstract public void reflect();
}
