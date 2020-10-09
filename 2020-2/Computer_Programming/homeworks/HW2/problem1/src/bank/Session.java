package bank;

public class Session {

    private String sessionKey;
    private Bank bank;
    private boolean valid;
    Session(String sessionKey,Bank bank){
        this.sessionKey = sessionKey;
        this.bank = bank;
        valid = true;
    }

    public boolean deposit(int amount) {
        if (!this.valid) return false;

        return this.bank.deposit(this.sessionKey, amount);
    }

    public boolean withdraw(int amount) {
        if (!this.valid) return false;

        return this.bank.withdraw(this.sessionKey, amount);
    }

    public boolean transfer(String targetId, int amount) {
        if (!this.valid) return false;

        return this.bank.transfer(this.sessionKey, targetId, amount);
    }

    /* setters */
    public void setValid(boolean valid) {
        this.valid = valid;
    }
}
