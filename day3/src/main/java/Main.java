import java.io.*;
import java.util.ArrayList;

public class Main {
    public static void main(String[] args) throws IOException {
        ClassLoader classloader = Thread.currentThread().getContextClassLoader();
        InputStream inputStream = classloader.getResourceAsStream("input.txt");
        InputStreamReader isReader = new InputStreamReader(inputStream);
        BufferedReader reader = new BufferedReader(isReader);
        StringBuffer stringBuffer = new StringBuffer();

        // get width from first line
        Integer width = 0;
        String str;
        while((str = reader.readLine())!= null){
            width = str.length();
            stringBuffer.append(str);
        }
        //System.out.println(stringBuffer.toString());
        //System.out.println(width);

        String[] map;
        map = stringBuffer.toString().split("");

        //System.out.println(map[6 + width * 2]);
        Integer dots = 0;
        Integer trees = 0;
        Integer x = 0;
        for (Integer y = 1; map.length / width > y; y += 1) {

            x += 3;
            if (x >= width) x = 0 + (x - width);

            if (map[x + width * y].equals(".")) {
                dots++;
            } else if (map[x + width * y].equals("#")) {
                trees++;
            }
        }

        System.out.println(dots);
        System.out.println(trees);
    }
}
