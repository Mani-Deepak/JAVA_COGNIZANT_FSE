import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class CalculatorTest {

    private Calculator calculator;

    @Before
    public void setUp() {

        // Runs before every test
        calculator = new Calculator();
        System.out.println("Setting up test...");
    }

    @After
    public void tearDown() {

        // Runs after every test
        System.out.println("Test completed.");
    }

    @Test
    public void testAddition() {

        // Arrange
        int a = 20;
        int b = 30;

        // Act
        int result = calculator.add(a, b);

        // Assert
        assertEquals(50, result);
    }

    @Test
    public void testMultiplication() {

        // Arrange
        int a = 6;
        int b = 5;

        // Act
        int result = calculator.multiply(a, b);

        // Assert
        assertEquals(30, result);
    }
}
