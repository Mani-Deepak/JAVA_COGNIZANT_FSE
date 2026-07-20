import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class AAAPatternTest {
    private StringBuilder builder;

    @Before
    public void setUp() {
        builder = new StringBuilder();
    }

    @Test
    public void testAppend() {
        // Arrange
        String text = "Hello";
        
        // Act
        builder.append(text);
        
        // Assert
        assertEquals("Hello", builder.toString());
    }

    @After
    public void tearDown() {
        builder = null;
    }
}
