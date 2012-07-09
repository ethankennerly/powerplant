package com.finegamedesign.powerplant 
{
    import flash.events.MouseEvent;

    /**
     * @author Ethan Kennerly
     */
    public class Stack extends Spot
    {
        /* only put a card on a stack.  do not select to take off. */
        override public function select(mouseEvent:MouseEvent):void {
            super.select(mouseEvent);
            if (Card.NULL != this.value) {
                this.gotoAndPlay(MouseEvent.MOUSE_OUT);
                this.mouseEnabled = false;
                this.mouseChildren = false;
            }
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
        public static function describePower(powers:Array, pronoun:String="I", possessive:String="MY"):String
        {
            var description:String;
            var arithmetic:String = "";
            var product:int;
            if (0 == powers.length) {
                description = pronoun + " HAVE NO CARDS IN PLAY";
                product = 0;
            }
            else {
                description = pronoun + " PLAY " + powers[powers.length - 1].toString();
                product = powers[0];
                if (2 <= powers.length) {
                    description += " ON " + possessive;
                    arithmetic = powers[0].toString();
                    for (var i:int=1; i < powers.length; i++) {
                        description += " " + powers[i-1].toString();
                        if (i < powers.length - 1) {
                            description += " AND";
                        }
                        arithmetic += " x " + powers[i].toString();
                        product *= powers[i];
                    }
                    arithmetic += " = " + product.toString();
                }
            }
            description += ".\n" + arithmetic 
                + "\n" + pronoun + " MAKE " + product.toString() + " POWER.";
            return description;
        }
    }
}
