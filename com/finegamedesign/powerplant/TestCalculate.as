package com.finegamedesign.powerplant
{
    import asunit.framework.TestCase;

    /**
     * @author Ethan Kennerly
     */
    public class TestCalculate extends TestCase
    {
        /**
         * No stack.  Empty stack.
         * Stack of 2.  2 stacks.
         */
        public function testPower():void
        {
            assertEquals(0, Calculate.power([]));
            assertEquals(0, Calculate.power([[]]));
            assertEquals(0, Calculate.power([[3, 0]]));
            assertEquals(6, Calculate.power([[6]]));
            assertEquals(12, Calculate.power([[4, 3]]));
            assertEquals(24, Calculate.power([[6, 4]]));
            assertEquals(42, Calculate.power([[7, 6]]));
            assertEquals(22, Calculate.power([[2], [5, 1, 4]]));
        }

        /**
         * Match one stack.  Nearest to contract on one stack.  Exceed one stack.  No hand.
         * No stack.  Nearest to contract on second stack.
         */
        public function testSelectValueAndStack():void
        {
            assertEquals(null, Calculate.select_value_and_stack([], [], 25));
            assertEquals(null, Calculate.select_value_and_stack([], [[], []], 25));
            assertEquals(null, Calculate.select_value_and_stack([], [[6]], 25));
            assertEqualsArrays([7, 1], Calculate.select_value_and_stack([7], [[6]], 25));
            assertEqualsArrays([3, 0], Calculate.select_value_and_stack([2, 5, 3], [[4]], 12));
            assertEqualsArrays([4, 0], Calculate.select_value_and_stack([2, 5, 4, 7], [[6]], 25));
            assertEqualsArrays([7, 0], Calculate.select_value_and_stack([4, 5, 5, 7], [], 25));
            assertEqualsArrays([4, 1], Calculate.select_value_and_stack([4, 5, 5, 7], [[2], [5, 1]], 25));
            assertEqualsArrays([4, 2], Calculate.select_value_and_stack([4, 5, 5, 7], [[2], [], [5, 1]], 25));
            // Start new stack
            assertEqualsArrays([2, 0], Calculate.select_value_and_stack([2, 4, 5, 8], [[9]], 25));
            assertEqualsArrays([8, 1], Calculate.select_value_and_stack([4, 5, 8], [[9]], 25));
            assertEqualsArrays([5, 1], Calculate.select_value_and_stack([4, 5, 8], [[9]], 15));
        }
    }
}
