package bank;

import bank.event.*;

class BankAccount {
    private Event[] events = new Event[maxEvents];
    final static int maxEvents = 100;
    private String id;
    private String password;
    private int balance;
    private int numEvents;

    BankAccount(String id, String password, int balance) {
        this.id = id;
        this.password = password;
        this.balance = balance;
        this.numEvents = 0;
    }

    boolean authenticate(String password) {
        return this.password.equals(password) ? true : false;
    }

    void deposit(int amount) {
        this.events[this.numEvents++] = new DepositEvent();
        this.balance += amount;
    }

    boolean withdraw(int amount) {
        if (this.balance < amount) return false;

        this.events[this.numEvents++] = new WithdrawEvent();
        this.balance -= amount;

        return true;
    }

    void receive(int amount) {
        this.events[this.numEvents++] = new ReceiveEvent();
        this.balance += amount;
    }

    boolean send(int amount) {
        if (this.balance < amount) return false;

        this.events[this.numEvents++] = new SendEvent();
        this.balance -= amount;

        return true;
    }

    /* getters */
    public Event[] getEvents() {
        Event[] _events = new Event[this.numEvents];
        for (int idx = 0; idx < this.numEvents; idx++) {
            _events[idx] = this.events[idx];
        }
        return _events;
    }

    public int getBalance() {
        return this.balance;
    }

}
