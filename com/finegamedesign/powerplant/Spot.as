package com.finegamedesign.powerplant 
{
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.Event;
    
    /**
     * A place for a card, that may be clicked to swap with the selected cursor.
     * @author Ethan Kennerly
     */
    public class Spot extends Card 
    {
        public function Spot(cardValue:int = Card.NULL) 
        {
            super(cardValue);
            mayPick(this, select);
        }

        public static function mayPick(card:Card, onClick:Function):void
        {
            card.addEventListener(MouseEvent.MOUSE_OVER, gotoMouseEvent);
            card.addEventListener(MouseEvent.MOUSE_OUT, gotoMouseEvent);
            card.addEventListener(MouseEvent.CLICK, onClick);
            card.buttonMode = true; 
            card.stop();
        }

        public static function gotoMouseEvent(event:MouseEvent):void {
            event.currentTarget.gotoAndPlay(event.type);
        }
        
        public static function select(event:MouseEvent):void {
            trace("Spot.select:  The card by the cursor and this card swap places.");
            if (Selected.cursor is Selected) {
                event.currentTarget.swap(Selected.cursor);
            }
            else {
                trace("Spot.select:  Is there no cursor?");
                event.currentTarget.swapImage(Card.NULL);
            }
        }

        public static function place(event:MouseEvent):void {
            event.currentTarget.removeEventListener(MouseEvent.CLICK, place);
            event.currentTarget.gotoAndPlay(MouseEvent.MOUSE_OUT);
            event.currentTarget.buttonMode = false; 
            if (Selected.cursor is Selected) {
                event.currentTarget.swap(Selected.cursor);
            }
            else {
                event.currentTarget.swapImage(Card.NULL);
            }
            var next:CardStack = new CardStack();
            StackContainer.offset(event.currentTarget as DisplayObject, next);
            event.currentTarget.parent.addChild(next);
        }
    }
}
