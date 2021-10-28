import java.io.IOException;
import java.io.InputStream;

public class OneByteInputStream extends InputStream {

    private final InputStream inputStream;

    public OneByteInputStream(InputStream inputStream)
        {
            this.inputStream = inputStream;
        }

    @Override
    public int read() throws IOException {
        return inputStream.read();
    }

    @Override
    public int read(byte[] b, int off, int len) throws IOException {
        return super.read(b, off, 1);
    }
}
