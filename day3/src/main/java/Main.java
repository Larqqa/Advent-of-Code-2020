import java.io.*;
import java.util.ArrayList;
import java.util.Objects;

public class Main {
    private static Integer width = 0;
    private static Long multiplier = 1L;

    // part 1
    /*
    private static final int[][] slopes = {
        {3, 1},
    };
    */

    // part2
    private static final int[][] slopes = {
        {1, 1},
        {3, 1},
        {5, 1},
        {7, 1},
        {1, 2}
    };

    private static final FileReader inputFile = new FileReader("input.txt");
    private static final StringBuffer stringBuffer = new StringBuffer();

    public static void main(String[] args) throws IOException {

        String str = "";
        while(Objects.nonNull(str = inputFile.getReader().readLine())){
            width = str.length();
            stringBuffer.append(str);
        }

        String[] map = stringBuffer.toString().split("");

        for (int[] slope:slopes) {
            multiplier *= count_trees(map, slope[0], slope[1]);
        }

        System.out.println(multiplier);
    }

    private static Long count_trees(final String[] map, final Integer offsetX, final Integer offsetY) {
        int dots = 0;
        int trees = 0;
        int x = 0;
        int height = map.length / width;

        //System.out.println(map[6 + width * 2]);

        for (int y = 0; height > y; y += offsetY) {

            if (map[x + width * y].equals(".")) {
                dots++;
            } else if (map[x + width * y].equals("#")) {
                trees++;
            }

            x += offsetX;

            if (x >= width) {
                x = x - width;
            }
        }

        // System.out.printf("%s, %s\n", dots, trees);
        return (long) trees;
    }
}