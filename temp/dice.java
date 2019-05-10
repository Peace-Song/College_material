import java.util.*;


public class dice{
    public static void main(String[] args){
        while(true){
            Scanner scan = new Scanner(System.in);
    
            int p = (int)(Math.random() * 6);
            System.out.println("주사위 던지기!");
            System.out.println("나의 예상은?");
            int e = scan.nextInt();
            System.out.println("주사위 눈: " + p);
            System.out.println("나의 예상: " + e);
            if(p == e) System.out.println("정답!");
            else System.out.println("오답...");
        }
    }
}


