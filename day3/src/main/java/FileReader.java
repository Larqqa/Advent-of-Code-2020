import java.io.*;
import java.util.Objects;

public class FileReader {
    private static BufferedReader reader;

    public FileReader(final String fileName) {
        ClassLoader classloader = Thread.currentThread().getContextClassLoader();
        InputStream inputStream = classloader.getResourceAsStream(fileName);

        if (Objects.isNull(inputStream)) throw new IllegalStateException("Invalid input!");

        InputStreamReader isReader = new InputStreamReader(inputStream);
        reader = new BufferedReader(isReader);
    }

    public BufferedReader getReader() {
        return reader;
    }
}