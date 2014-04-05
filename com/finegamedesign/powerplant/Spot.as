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
        /**
         * Refer to what was placed.
         */
        public static var placedValue:int = Card.NULL;
        public static var placedStack:int = Card.NULL;

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
            card.mouseEnabled = true;
            card.mouseChildren = true;
            card.buttonMode = true; 
            card.stop();
        }

        public static function place(event:MouseEvent):void {
            var card:Card = event.currentTarget as Card;
            card.removeEventListener(MouseEvent.CLICK, place);
            card.removeEventListener(MouseEvent.MOUSE_OVER, gotoMouseEvent);
            card.removeEventListener(MouseEvent.MOUSE_OUT, gotoMouseEvent);
            card.gotoAndPlay(MouseEvent.MOUSE_OUT);
            card.buttonMode = false; 
            card.mouseEnabled = false; 
            card.mouseChildren = false; 
            if (Selected.cursor is Selected) {
                placedValue = Selected.cursor.value;
                placedStack = parseInt(card.parent.name.split("_")[1]);
                card.swap(Selected.cursor);
            }
            else {
                card.swapImage(Card.NULL);
            }
            var next:CardStack = new CardStack();
            StackContainer.offset(card, next);
            card.parent.addChild(next);
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
    }
}
