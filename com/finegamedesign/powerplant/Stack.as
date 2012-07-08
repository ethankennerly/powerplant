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

        /* Map values */
        public static function values(cards:Array):Array
        {
            var cardValues:Array = new Array();
            for (var i:int=0; i < cards.length; i++) {
                cardValues.push(cards[i].value);
            }
            return cardValues;
        }

        /** For example @see TestStack.as
         */
        public static function describePower(values:Array):String
        {
            var description:String = "";
            for (var i:int=0; i < values.length; i++) {
            }
            return description;
        }
 
    }
}
