package com.finegamedesign.powerplant
{
    /**
     * @author Ethan Kennerly
     */
    public class Calculate
    {
        /**
         * Multiply cards in stack.  Add stack products.
         * Example @see TestCalculate.as
         */
        public static function power(stacks:Array):int
        {
            var power:int = 0;
            for (var s:int=0; s < stacks.length; s++) {
                var product:int = 0;
                for (var c:int=0; c < stacks[s].length; c++) {
                    if (0 == c) {
                        product = stacks[s][c];
                    }
                    else {
                        product *= stacks[s][c];
                    }
                }
                power += product;
            }
            return power;
        }

        /**
         * Select a card from hand that plays on a stack to match contract,
         * or most nearly approaches contract without going over.
         * Example @see TestCalculate.as
         */
        public static function select_value_and_stack(hand:Array, stacks:Array, contract:int):Array
        {
            var value_and_stack:Array;
            var max:int = 0;
            for (var h:int=0; h < hand.length; h++) {
                var original_stacks:Array = stacks.concat();
                if (original_stacks.length == 0) {
                    original_stacks.push([]);
                }
                for (var s:int=0; s < original_stacks.length; s++) {
                    var hypothetical_stacks:Array = original_stacks.concat();
                    hypothetical_stacks[s] = hypothetical_stacks[s].concat(hand[h]);
                    var power:int = power(hypothetical_stacks);
                    if (max < power && power <= contract) {
                        max = power;
                        value_and_stack = [hand[h], s];
                    }
                }
            }
            return value_and_stack;
        }
    }
}
