package malten.sample;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

public class SampleTest {

    @Test
    @DisplayName("Run sample")
    public void testSample() {
        new Sample().run();
        assertEquals(1, 1); // dummy assertion
    }

}
