package com.finegamedesign.powerplant
{
    import asunit.framework.TestCase;

    /**
     * @author Ethan Kennerly
     */
    public class TestCalculate extends TestCase
    {
        /**
         * Match one stack.  Nearest to contract on one stack.  Exceed one stack.  No hand.
         * No stack.  Nearest to contract on second stack.
         */
        public function testSelectValueAndStack():void
        {
            assertEquals([3, 0], Calculate.select_value_and_stack([2, 5, 3], [[4]], 12));
            assertEquals([4, 0], Calculate.select_value_and_stack([2, 5, 4, 7], [[6]], 25));
            assertEquals(null, Calculate.select_value_and_stack([7], [[6]], 25));
            assertEquals(null, Calculate.select_value_and_stack([], [[6]], 25));
            assertEquals([7, 0], Calculate.select_value_and_stack([4, 5, 5, 7], [], 25));
            assertEquals([4, 1], Calculate.select_value_and_stack([4, 5, 5, 7], [[2], [5, 1]], 25));
        }
    }
}
