package bank;

import bank.event.Event;
import security.*;
import security.key.*;
import java.util.HashMap;

public class Bank {
    private int numAccounts = 0;
    final static int maxAccounts = 100;
    private BankAccount[] accounts = new BankAccount[maxAccounts];
    private String[] ids = new String[maxAccounts];

    public void createAccount(String id, String password) {
        createAccount(id, password, 0);
    }

    public void createAccount(String id, String password, int initBalance) {
        int accountId = numAccounts;
        accounts[accountId] = new BankAccount(id, password, initBalance);
        ids[accountId] = id;
        numAccounts+=1;
    }

    public boolean deposit(String id, String password, int amount) {
        BankAccount account = this.find(id);
        if (account == null) return false;

        if (!account.authenticate(password)) return false;

        account.deposit(amount);

        return true;
    }

    public boolean withdraw(String id, String password, int amount) {
        BankAccount account = this.find(id);
        if (account == null) return false;

        if (!account.authenticate(password)) return false;

        return account.withdraw(amount);
    }

    public boolean transfer(String sourceId, String password, String targetId, int amount) {
        BankAccount sourceAccount = this.find(sourceId);
        BankAccount targetAccount = this.find(targetId);
        if (sourceAccount == null || targetAccount == null) return false;

        if (!sourceAccount.authenticate(password)) return false;

        if (!sourceAccount.send(amount)) return false;
        targetAccount.receive(amount);

        return true;
    }

    public Event[] getEvents(String id, String password) {
        BankAccount account = this.find(id);
        if (account == null) return null;

        if (!account.authenticate(password)) return null;

        return account.getEvents();
    }

    public int getBalance(String id, String password) {
        BankAccount account = this.find(id);
        if (account == null) return -1;

        if (!account.authenticate(password)) return -1;

        return account.getBalance();
    }

    private static String randomUniqueStringGen(){
        return Encryptor.randomUniqueStringGen();
    }
    private BankAccount find(String id) {
        for (int i = 0; i < numAccounts; i++) {
            if(ids[i].equals(id)){return accounts[i];};
        }
        return null;
    }
    final static int maxSessionKey = 100;
    int numSessionKey = 0;
    String[] sessionKeyArr = new String[maxSessionKey];
    BankAccount[] bankAccountmap = new BankAccount[maxSessionKey];
    String generateSessionKey(String id, String password){
        BankAccount account = find(id);
        if(account == null || !account.authenticate(password)){
            return null;
        }
        String sessionkey = randomUniqueStringGen();
        sessionKeyArr[numSessionKey] = sessionkey;
        bankAccountmap[numSessionKey] = account;
        numSessionKey += 1;
        return sessionkey;
    }
    BankAccount getAccount(String sessionkey){
        for(int i = 0 ;i < numSessionKey; i++){
            if(sessionKeyArr[i] != null && sessionKeyArr[i].equals(sessionkey)){
                return bankAccountmap[i];
            }
        }
        return null;
    }

    boolean deposit(String sessionkey, int amount) {
        BankAccount account = this.getAccount(sessionkey);
        if (account == null) return false;

        account.deposit(amount);

        return true;
    }

    boolean withdraw(String sessionkey, int amount) {
        BankAccount account = this.getAccount(sessionkey);
        if (account == null) return false;

        return account.withdraw(amount);
    }

    boolean transfer(String sessionkey, String targetId, int amount) {
        BankAccount sourceAccount = this.getAccount(sessionkey);
        BankAccount targetAccount = this.find(targetId);
        if (sourceAccount == null || targetAccount == null) return false;

        if (!sourceAccount.send(amount)) return false;
        targetAccount.receive(amount);

        return true;
    }

    private BankSecretKey secretKey;
    private HashMap<String, BankSymmetricKey> appIdSymKeyMap = new HashMap<String, BankSymmetricKey>();
    public BankPublicKey getPublicKey(){
        BankKeyPair keypair = Encryptor.publicKeyGen();
        secretKey = keypair.deckey;
        return keypair.enckey;
    }

    public void fetchSymKey(Encrypted<BankSymmetricKey> encryptedKey, String AppId){
        BankSymmetricKey symKey = encryptedKey.decrypt(this.secretKey);
        
        if (symKey == null || encryptedKey == null) return;

        this.appIdSymKeyMap.put(AppId, symKey);
    }

    public Encrypted<Boolean> processRequest(Encrypted<Message> messageEnc, String AppId){
        Message msg;
        BankSymmetricKey symKey = this.appIdSymKeyMap.get(AppId);

        if (symKey == null) return null;
        msg = messageEnc.decrypt(symKey);
        if (messageEnc == null || msg == null) return null;

        if (msg.getRequestType().equals("deposit")) {
            return new Encrypted<Boolean>(this.deposit(msg.getId(), msg.getPassword(), msg.getAmount()), symKey);
        }
        else if (msg.getRequestType().equals("withdraw")) {
            return new Encrypted<Boolean>(this.withdraw(msg.getId(), msg.getPassword(), msg.getAmount()), symKey);
        }
        else {
            // must not reach here
            return null;
        }
    }


}