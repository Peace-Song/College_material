package bank;

import security.Encryptor;
import security.Encrypted;
import security.Message;
import security.key.BankPublicKey;
import security.key.BankSymmetricKey;

public class MobileApp {

    private String randomUniqueStringGen(){
        return Encryptor.randomUniqueStringGen();
    }
    private final String AppId = randomUniqueStringGen();
    public String getAppId() {
        return AppId;
    }

    String id, password;
    BankSymmetricKey symmetricKey;
    public MobileApp(String id, String password){
        this.id = id;
        this.password = password;
    }

    public Encrypted<BankSymmetricKey> sendSymKey(BankPublicKey publickey){
        this.symmetricKey = new BankSymmetricKey(this.randomUniqueStringGen());
        
        return new Encrypted<BankSymmetricKey>(this.symmetricKey, publickey);
    }

    public Encrypted<Message> deposit(int amount){
        return new Encrypted<Message>(new Message("deposit", this.id, this.password, amount), this.symmetricKey);
    }

    public Encrypted<Message> withdraw(int amount){
        return new Encrypted<Message>(new Message("withdraw", this.id, this.password, amount), this.symmetricKey);
    }

    public boolean processResponse(Encrypted<Boolean> obj){
        if (obj == null) return false;
        Boolean response = obj.decrypt(this.symmetricKey);
        if (response == null) return false;

        return response;
    }

}

