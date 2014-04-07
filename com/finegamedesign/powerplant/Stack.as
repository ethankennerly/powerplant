package com.finegamedesign.powerplant 
{
    import flash.display.DisplayObjectContainer;
    import flash.events.MouseEvent;

    /**
     * @author Ethan Kennerly
     */
    public class Stack extends Card
    {
        public function Stack(cardValue:int = Card.NULL) {
            super(cardValue);
        }

        /* Map values.
         * For example @see TestStack.as
         */
        public static function values(cards:Array):Array
        {
            var cardValues:Array = new Array();
            for (var i:int=0; i < cards.length; i++) {
                if (cards[i].value != Card.NULL) {
                    cardValues.push(cards[i].value);
                }
            }
            return cardValues;
        }

        /** For example @see TestStack.as
         */
        public static function describePower(stackPowers:Array, 
                pronoun:String="I", possessive:String="MY", stackIndex:int=0):String
        {
            var total:int = Calculate.power(stackPowers);
            var description:String = "";
            var arithmetic:String = "";
            var powers:Array;
            var cardCount:int = 0;
            for (var s:int; s < stackPowers.length; s++) {
                cardCount += stackPowers[s].length;
                if (stackIndex == s) {
                    powers = stackPowers[s];
                }
            }
            if (0 == cardCount || null == powers || 0 == powers.length) {
                description = pronoun + " HAVE NO CARDS IN PLAY.\n";
            }
            else {
                arithmetic = Calculate.describe(stackPowers);
            }
            if ("" != arithmetic) {
                description += arithmetic + ".\n";
            }
            description += pronoun + " MAKE " + total.toString() + " POWER.";
            return description;
        }
    }
}
