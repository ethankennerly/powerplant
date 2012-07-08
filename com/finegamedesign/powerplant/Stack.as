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
/*            if (this.mc == null) {
                super.select(mouseEvent);
            }
*/        }
    }
}
