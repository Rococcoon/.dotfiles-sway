# ProjectTemplate

## Example Test File

```java
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;
import utils.Calculator;

public class MainTest {
  @Test
  void testAddition() {
    assertEquals(15, Calculator.add(10, 5), "10 + 5 should be 15");
  }
}
```
