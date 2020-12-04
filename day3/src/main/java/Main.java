import java.io.*;
import java.math.BigInteger;
import java.util.ArrayList;

public class Main {
    private static Integer width = 0;
    private static String str;
    private static Long multiplicant;

    static ClassLoader classloader = Thread.currentThread().getContextClassLoader();
    static InputStream inputStream = classloader.getResourceAsStream("input.txt");
    static InputStreamReader isReader = new InputStreamReader(inputStream);
    static BufferedReader reader = new BufferedReader(isReader);
    static StringBuffer stringBuffer = new StringBuffer();

    public static void main(String[] args) throws IOException {
        while((str = reader.readLine())!= null){
            width = str.length();
            stringBuffer.append(str);
        }

        String[] map;
        map = stringBuffer.toString().split("");

        multiplicant = count_trees(map, 1, 1);
        multiplicant *= count_trees(map, 3, 1);
        multiplicant *= count_trees(map, 5, 1);
        multiplicant *= count_trees(map, 7, 1);
        multiplicant *= count_trees(map, 1, 2);
        System.out.println(multiplicant);
    }

    private static Long count_trees(String[] map, Integer offsetX, Integer offsetY) {
        //System.out.println(map[6 + width * 2]);

        Integer dots = 0;
        Integer trees = 0;
        Integer x = 0;

        for (Integer y = 1; map.length / width > y; y += offsetY) {

            x += offsetX;
            if (x >= width) {
                x = 0 + (x - width);
            }

            if (map[x + width * y].equals(".")) {
                dots++;
            } else if (map[x + width * y].equals("#")) {
                trees++;
            }
        }

        System.out.printf("%s, %s\n", dots, trees);
        return Long.valueOf(trees);
    }
}
