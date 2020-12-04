import java.io.*;

public class FileReader {
    private static BufferedReader reader;

    public FileReader(String fileName) {
        ClassLoader classloader = Thread.currentThread().getContextClassLoader();
        InputStream inputStream = classloader.getResourceAsStream(fileName);
        assert inputStream != null;
        InputStreamReader isReader = new InputStreamReader(inputStream);
        reader = new BufferedReader(isReader);
    }

    public BufferedReader getReader() {
        return reader;
    }
}