package com.finegamedesign.powerplant
{
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.Sprite;

    /**
     * ...
     * @author Ethan Kennerly
     */
    public class Example extends Sprite
    {
        
        public function Example() 
        {
            this.addEventListener(Event.ADDED_TO_STAGE, this.test);
        }
        
        public function test(event:Event) {
            this.removeEventListener(Event.ADDED_TO_STAGE, this.test);
            this.Card_swapImage();
            this.Selected_swapImage();
            this.InHand_select();
            
            // Tear down
            this.parent.removeChild(this);
        }
        /**
         * Swap one card with empty card.
         */
        public function Card_swapImage() {
            var card:Card = new Card(1);
            card.x = 1;
            card.y = 2;
            if (! (card.visible)) {
                trace("Example.Card_swapImage: after var card:Card = new Card(1); expect (card.visible)");
            }
            card.swapImage(Card.NULL);
            if (! (null == card.mc)) {
                trace("Example.Card_swapImage: after card.swapImage(Card.NULL); expect (null == card.mc)");
            }
            if (! (Card.NULL == card.value)) {
                trace("Example.Card_swapImage: after card.swapImage(Card.NULL); expect (Card.NULL == card.value)");
            }
            card.swapImage(0);
            if (! (card.visible)) {
                trace("Example.Card_swapImage: after card.swapImage(0); expect (card.visible)");
            }
            if (! (0 == card.value)) {
                trace("Example.Card_swapImage: after card.swapImage(0); expect (0 == card.value)");
            }
        }
        
        /**
         * Swap one card with empty card.
         */
        public function Selected_swapImage() {
            var card:Selected = new Selected(1);
            card.x = 1;
            card.y = 2;
            if (! (card.visible)) {
                trace("Example.Selected_swapImage: after var card:Card = new Card(1); expect (card.visible)");
            }
            card.swapImage(Card.NULL);
            if (! (null == card.mc)) {
                trace("Example.Selected_swapImage: after card.swapImage(Card.NULL); expect (null == card.mc)");
            }
            card.swapImage(0);
            if (! (card.visible)) {
                trace("Example.Selected_swapImage: after card.swapImage(0); expect (card.visible)");
            }
        }
        
        /**
         * Select 1-card in hand, which swaps with 0-card selected.
         */
        public function InHand_select() {
            var root:DisplayObjectContainer = this.root as DisplayObjectContainer;
            var game:Game = new Game();
            var selected:Selected = new Selected();
            selected.swapImage(0);
            selected.x = 1;
            selected.y = 2;
            root.addChild(selected);
            var hand:Spot = new Spot();
            hand.swapImage(1);
            hand.x = 3;
            hand.y = 4;
            root.addChild(hand);
            var mouseClick:MouseEvent = new MouseEvent(MouseEvent.CLICK);
            hand.dispatchEvent(mouseClick);
            if (! (0 == hand.value)) {
                trace("Example.InHand_select: after hand.select(mouseClick); expect (0 == hand.value)");
            }
            if (! (1 == selected.value)) {
                trace("Example.InHand_select: after hand.select(mouseClick); expect (0 == hand.value)");
            }
            root.removeChild(selected);
            root.removeChild(hand);
            selected = null;
            hand = null;
        }
        
    }
}
