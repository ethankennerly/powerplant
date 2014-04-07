package com.finegamedesign.powerplant
{
    import flash.utils.ByteArray;
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
         * Multiply cards in stack.  Add stack products.
         * Example @see TestCalculate.as
         */
        public static function describe(stacks:Array):String
        {
            var description:String = "";
            var termCount:int = 0;
            var products:Array = [];
            var trimmed:Array = clone(stacks);
            removeEmpty(trimmed);
            for (var s:int=0; s < trimmed.length; s++) {
                var product:String = "";
                termCount += trimmed[s].length;
                if (2 <= trimmed.length && 2 <= trimmed[s].length) {
                    product += "(";
                }
                product += trimmed[s].join(" x ")
                if (2 <= trimmed.length && 2 <= trimmed[s].length) {
                    product += ")";
                }
                products.push(product);
            }
            if (2 <= termCount) {
                description += products.join(" + ") 
                    + " = " + power(trimmed).toString();
            }
            return description;
        }

        private static function removeEmpty(stacks:Array):void
        {
            for (var s:int = stacks.length - 1; 0 <= s; s--) {
                if (stacks[s].length <= 0) {
                    stacks.splice(s, 1);
                }
            }
        }

        /**
         * Select a card from hand that plays on a stack to match contract,
         * or most nearly approaches contract without going over.
         * Example @see TestCalculate.as
         */
        public static function stacksUnderContract(value:int, stacks:Array, contract:int):Array
        {
            var stacksValid:Array = [];
            var hypothetical_stacks:Array = clone(stacks);
            if (hypothetical_stacks.length <= 0 || 1 <= hypothetical_stacks[hypothetical_stacks.length - 1].length) {
                hypothetical_stacks.push([]);
            }
            for (var s:int=0; s < hypothetical_stacks.length; s++) {
                hypothetical_stacks[s].push(value);
                var hypothetical_power:int = power(hypothetical_stacks);
                stacksValid.push(hypothetical_power <= contract);
                hypothetical_stacks[s].pop();
            }
            return stacksValid;
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
            var hypothetical_stacks:Array = clone(stacks);
            hypothetical_stacks.push([]);
            for (var h:int=0; h < hand.length; h++) {
                for (var s:int=0; s < hypothetical_stacks.length; s++) {
                    hypothetical_stacks[s].push(hand[h]);
                    var power:int = power(hypothetical_stacks);
                    if (max < power && power <= contract) {
                        max = power;
                        value_and_stack = [hand[h], s];
                    }
                    hypothetical_stacks[s].pop();
                }
            }
            return value_and_stack;
        }
 
        public static function clone(source:Object):*
        {
            var myBA:ByteArray = new ByteArray();
            myBA.writeObject(source);
            myBA.position = 0;
            return(myBA.readObject());
        }
    }
}
