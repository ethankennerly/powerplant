package com.finegamedesign.powerplant 
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.Event;
    
    /**
     * A place for a card, that may be clicked to swap with the selected cursor.
     * @author Ethan Kennerly
     */
    public class Spot extends Card 
    {
        public function Spot(cardValue:int = Card.NULL) {
            super(cardValue);
            this.addEventListener(MouseEvent.MOUSE_OVER, this.gotoMouseEvent);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.gotoMouseEvent);
            this.addEventListener(MouseEvent.CLICK, this.select);
            this.buttonMode = true; 
            this.stop();
        }

        public function gotoMouseEvent(mouseEvent:MouseEvent):void {
            this.gotoAndPlay(mouseEvent.type);
        }
        
        public function select(mouseEvent:MouseEvent):void {
            trace("Spot.select:  The card by the cursor and this card swap places.");
            // trace("Spot.select: this.value = " + this.value.toString());
            // if (Card.NULL != this.value) {
                if (Selected.cursor is Selected) {
                    this.swap(Selected.cursor);
/*                    var cursorValue:int = Selected.cursor.value;
                    Selected.cursor.swapImage(this.value);
                    this.swapImage(cursorValue);
*/                }
                else {
                    trace("Spot.select:  Is there no cursor?");
                    this.swapImage(Card.NULL);
                }
            // }
        }
        
    }

}
