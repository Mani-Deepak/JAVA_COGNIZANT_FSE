import org.junit.Test;

import static org.junit.Assert.*;

public class AssertionsTest {

    @Test
    public void testAssertions() {

        // Checking expected value
        assertEquals(5, 2 + 3);

        // Condition should be true
        assertTrue(10 > 5);

        // Condition should be false
        assertFalse(10 < 5);

        // Object reference is null
        String name = null;
        assertNull(name);

        // Object reference is not null
        Object obj = new Object();
        assertNotNull(obj);
    }
}
