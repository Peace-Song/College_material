public class CardGameSimulator {
    private static final Player[] players = new Player[2];
    private static final Card[] drawnCards = new Card[2];

    public static void simulateCardGame(String inputA, String inputB) {
        int turn_idx = 0;

        initialize(inputA, inputB);

        // player A draws the first card
        drawnCards[0] = players[0].drawCard(null);
        players[0].playCard(drawnCards[0]);

        turn_idx = 1;
        while (true) {
            // takes turn drawing cards
            drawnCards[turn_idx] = players[turn_idx].drawCard(drawnCards[(turn_idx + 1) % 2]);
            if (drawnCards[turn_idx] == null) {
                printLoseMessage(players[turn_idx]);
                break;
            }

            players[turn_idx].playCard(drawnCards[turn_idx]);

            // change turn
            turn_idx = (turn_idx + 1) % 2;
        }
    }

    // assigns actual instances to players
    private static void initialize(String inputA, String inputB) {
        String[] cardsA = inputA.split(" ");
        String[] cardsB = inputB.split(" ");
        
        players[0] = new Player();
        players[0].setName("A");
        players[0].initializeDeck();
        players[1] = new Player();
        players[1].setName("B");
        players[1].initializeDeck();

        for (int idx = 0; idx < 10; idx++) {
            String cardA = cardsA[idx];
            String cardB = cardsB[idx];

            players[0].getDeck()[idx].setNumber((int)(cardA.charAt(0) - '0'));
            players[0].getDeck()[idx].setShape(cardA.charAt(1));
            players[1].getDeck()[idx].setNumber((int)(cardB.charAt(0) - '0'));
            players[1].getDeck()[idx].setShape(cardB.charAt(1));
        }
    }

    // prints decks for debug purpose
    private static void printDecks() {
        System.out.print("A: [");
        for (int idx = 0; idx < 10; idx++) {
            if (players[0].getDeck()[idx] == null) {
                System.out.print("NA ");
            } else {
                System.out.print(players[0].getDeck()[idx] + " ");
            }
        }
        System.out.print("] | ");
        
        System.out.print("B: [");
        for (int idx = 0; idx < 10; idx++) {
            if (players[1].getDeck()[idx] == null) {
                System.out.print("NA ");
            } else {
                System.out.print(players[1].getDeck()[idx] + " ");
            }
        }
        System.out.println("]");
    }

    private static void printLoseMessage(Player player) {
        System.out.printf("Player %s loses the game!\n", player);
    }
}


class Player {
    private String name;
    private Card[] deck;

    public void playCard(Card card) {
        System.out.printf("Player %s: %s\n", name, card);
    }

    public void setName(String name) {
        this.name = name;
    }

    public void initializeDeck() {
        this.deck = new Card[10];
        for (int idx = 0; idx < 10; idx++) {
            this.deck[idx] = new Card();
        }
    }

    public Card[] getDeck() {
        return this.deck;
    }
    
    // return the next card to draw. returns null if got nothing to draw.
    public Card drawCard(Card enemyCard) {
        Card card;
        int draw_idx = 0;
        boolean isUndrawable;

        // initial card draw by A
        if (enemyCard == null) {
            for (int idx = 0; idx < 10; idx++) {
                if (
                    this.deck[idx] != null && (
                        this.deck[idx].getNumber() > this.deck[draw_idx].getNumber() ||
                        (
                            this.deck[idx].getNumber() == this.deck[draw_idx].getNumber() &&
                            this.deck[idx].getShape() == 'O'
                        )
                    )
                ) {
                    draw_idx = idx;
                }
            }
            card = this.deck[draw_idx];
            this.deck[draw_idx] = null;
            return card;
        }

        // if there is a card with the same number, draw it
        for (int idx = 0; idx < 10; idx++) {
            if (this.deck[idx] != null && this.deck[idx].getNumber() == enemyCard.getNumber()) {
                draw_idx = idx;
                card = this.deck[draw_idx];
                this.deck[draw_idx] = null;
                return card;
            } 
        }

        // if there is no card with the same shape neither, set isUndrawable flag as true.
        // else, set draw_idx as the first index with the same shape.
        isUndrawable = true;
        for (int idx = 0; idx < 10; idx++) {
            if (this.deck[idx] != null && this.deck[idx].getShape() == enemyCard.getShape()) {
                draw_idx = idx;
                isUndrawable = false;
                break;
            }
        }

        if (isUndrawable) {
            return null;
        }

        // set draw_idx as the index with the maximum number and the same shape
        for (int idx = 0; idx < 10; idx++) {
            if (
                this.deck[idx] != null && 
                this.deck[idx].getShape() == enemyCard.getShape() && 
                this.deck[idx].getNumber() > this.deck[draw_idx].getNumber()
            ) {
                draw_idx = idx;
            }
        }

        // mark the element as null and return the card
        card = this.deck[draw_idx];
        this.deck[draw_idx] = null;
        return card;
    }

    @Override
    public String toString() {
        return name;
    }
}


class Card {
    private int number;
    private char shape;

    public void setNumber(int number) {
        this.number = number;
    }

    public void setShape(char shape) {
        this.shape = shape;
    }

    public int getNumber() {
        return this.number;
    }

    public char getShape() {
        return this.shape;
    }

    @Override
    public String toString() {
        return "" + number + shape;
    }
}
