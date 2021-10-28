import java.util.LinkedList;

public class InputCharacteristics {

    private LinkedList<Integer> letters = new LinkedList<>();
    private LinkedList<Long> millis = new LinkedList<>();

    public void addLetter(int letter) {
        letters.add(letter);
    }

    public void addMillis(long milli) {
        millis.add(milli);
    }

    public String toString() {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < millis.size() - 1; i++) {
            System.out.print(String.format("%d: %d, ", letters.get(i), millis.get(i)));
        }
        System.out.print(String.format("%d: %d", letters.getLast(), millis.getLast()));
        /*
         * for (int i = 0; i < letters.size() - 1; i++) { builder.append(new String(new
         * char[] { letters.get(i), letters.get(i + 1) }) + ": " + (millis.get(i + 1) -
         * millis.get(i)) + "ms"); }
         */
        return builder.toString();
    }

}
