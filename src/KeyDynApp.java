import java.io.IOException;

public class KeyDynApp {

    private static InputCharacteristics getInput() {
        InputStreamReaderUnbuffered in = new InputStreamReaderUnbuffered(System.in);
        InputCharacteristics inchar = new InputCharacteristics();
        char[] chars = new char[1];
        try {
            in.read(chars, 0, 1);
            while (chars[0] != 10) {
                System.out.print((int) chars[0] + " ");
                inchar.addMillis(System.currentTimeMillis());
                inchar.addLetter(chars[0]);
                in.read(chars, 0, 1);
            }
        } catch (IOException e) {
            System.err.println("Oh no!\n" + e.getMessage());
        }

        try {
            in.close();
        } catch (IOException e) {
            System.err.println("Oh no!\n" + e.getMessage());
        }

        return inchar;
    }

    public static void main(String[] args) {
        System.out.println("Hello, user!");
        System.out.print("Enter password> ");
        InputCharacteristics test = getInput();
        System.out.println("");
        System.out.println(test);
    }
}
