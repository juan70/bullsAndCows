import java.util.Scanner;
import java.util.Random;


/**
 * A simple command line interface for the BullsAndCows class/game.
 */
public class MainCLI {
    /**
     * Keyword for leaving the program.
     */
    private final String QUIT = "quit";


    /**
     * Sole constructor.
     */
    public MainCLI() {}


    /**
     * Format the number of Bulls and Cows for printing.
     *
     * @param  guess  the string typed by the player.
     * @return  a string with a formatted message.
     */
    private String getBullsAndCows(BullsAndCows bc, String guess) {
        int bulls = bc.getBulls(guess);
        int cows = bc.getCows(guess);

        return String.format("%1$d bull%2$s, %3$d cow%4$s",
                             bulls, bulls == 1 ? "" : "s",
                             cows, cows == 1 ? "" : "s");
    }


    /**
     * Print out an informational banner.
     *
     * @return  a string with some information.
     */
    private String banner() {
        return "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
               + "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
               + "\n"
               + "Bulls and Cows: Guess the " + BullsAndCows.DIGITS
               + "-digits number."
               + "\n"
               + "Type \"" + QUIT + "\" at any moment to leave the game."
               + "\n"
               + "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
               + "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-";
    }


    /**
     * Cheat... Don't tell anybody this feature exists... ;-)
     *
     * @param  bc  BullsAndCows instance.
     */
    private void cheat(BullsAndCows bc) {
        String code = bc.getCode();
        StringBuilder result = new StringBuilder(code.length());

        // Choose only one digit
        int idx = new Random().nextInt(code.length());
        // Hide the others
        for (int i = 0; i < code.length(); i++) {
            result.append(i != idx ? "." : code.charAt(idx));
        }
        System.out.println(">>> Cheating? I give you only one digit randomly chosen: "
                           + result.toString());
    }


    /**
     * The program's entry point.
     *
     * @param  args  Command line arguments. Not used, actually.
     */
    public static void main(String[] args) {
        MainCLI cli = new MainCLI();
        Scanner stdin = new Scanner(System.in);
        BullsAndCows bc = new BullsAndCows();
        boolean cheated = false;

        System.out.println(cli.banner());

        int tries = 0;
        String guess;
        while (true) {
            System.out.print(String.format("%1$d. Enter a %2$d-digits number: ",
                                           ++tries, BullsAndCows.DIGITS));
            guess = stdin.nextLine().trim();

            if (guess.toLowerCase().equals(cli.QUIT)) {
                break;
            }
            if (guess.toLowerCase().equals("cheat")) {
                cli.cheat(bc);
                cheated = true;
                continue;
            }
            if (guess.matches(".*\\D+.*")) {
                System.out.println("Error: Only digits allowed. Try again.");
                continue;
            }
            if (guess.length() != BullsAndCows.DIGITS) {
                System.out.println("Error: " + bc.DIGITS + " digits are required. Try again.");
                continue;
            }

            System.out.println(cli.getBullsAndCows(bc, guess));
            System.out.println();

            if (bc.getBulls(guess) == BullsAndCows.DIGITS) {
                System.out.println("Congratulations!!!! You found the code "
                                   + bc.getCode() + ".");
                if (cheated) {
                    System.out.println("But you cheated, didn't you? "
                                       + "Yeah, you did, I know you did!!!!!");
                }
                System.out.println();
                break;
            }
        }
    }
}

