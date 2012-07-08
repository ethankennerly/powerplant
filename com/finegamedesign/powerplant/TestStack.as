package com.finegamedesign.powerplant
{
    import flash.events.MouseEvent;

    import asunit.framework.TestCase;

    /**
     * @author Ethan Kennerly
     */
    public class TestStack extends TestCase
    {
        /* Empty cursor clicks 2-card in hand and gains that 2-card.  */
        public function testClickSpot() {
            var mouseClick:MouseEvent = new MouseEvent(MouseEvent.CLICK);
            var mouseOver:MouseEvent = new MouseEvent(MouseEvent.MOUSE_OVER);
            Selected.cursor = new Selected();
            var cursor:Selected = Selected.cursor;
            assertEquals(Card.NULL, Selected.cursor.value);
            assertEquals(null, Selected.cursor.mc);
            var cardInHand:Spot = new Spot();
            cardInHand.swapImage(2);
            cardInHand.dispatchEvent(mouseOver);
            cardInHand.dispatchEvent(mouseClick);
            assertEquals(Card.NULL, cardInHand.value);
            assertEquals(null, cardInHand.mc);
            assertEquals(false, Container.getLowestClass(cardInHand, [Holder]).visible);
            assertEquals(2, Selected.cursor.value);
            assertEquals(true, Selected.cursor.mc is Card2);
            trace("testClickSpot: Click again.  Swap back, so 2-card is back in hand and cursor is empty.");
            cardInHand.dispatchEvent(mouseClick);
            assertEquals(Card.NULL, Selected.cursor.value);
            assertEquals(null, Selected.cursor.mc);
            assertEquals(false, Container.getLowestClass(Selected.cursor, [Holder]).visible);
            assertEquals(2, cardInHand.value);
            assertEquals(true, cardInHand.mc is Card2);
            assertEquals(true, Container.getLowestClass(cardInHand, [Holder]).visible);
        }

        /* 1-card cursor clicks stack.  Put card on stack.  
         * Click stack again.  Nothing happens. 
         * after putting card, card stack no longer responds to mouse over or mouse click.  
         * Stack does not have frame labels, but CardStack does.
         */
        public function testClickStack() {
            var mouseClick:MouseEvent = new MouseEvent(MouseEvent.CLICK);
            var mouseOver:MouseEvent = new MouseEvent(MouseEvent.MOUSE_OVER);
            var mouseOut:MouseEvent = new MouseEvent(MouseEvent.MOUSE_OUT);
            Selected.cursor = new Selected();
            Selected.cursor.swapImage(1);
            assertEquals(1, Selected.cursor.value);
            assertEquals(true, Selected.cursor.mc is Card1);
            var cardStack:Stack = new CardStack();
            assertEquals(Card.NULL, cardStack.value);
            assertEquals(null, cardStack.mc);
            assertTrue(cardStack.visible);
            cardStack.dispatchEvent(mouseOver);
            cardStack.dispatchEvent(mouseClick);
            assertEquals(Card.NULL, Selected.cursor.value);
            assertEquals(null, Selected.cursor.mc);
            assertEquals(1, cardStack.value);
            assertEquals(true, cardStack.mc is Card1);
            
            trace("testClickStack: Card stack no longer responds.");
            cardStack.dispatchEvent(mouseOut);
            assertEquals(MouseEvent.MOUSE_OUT, cardStack.currentLabel);
            if (cardStack.mouseEnabled || cardStack.mouseChildren) {
                cardStack.dispatchEvent(mouseOver);
            }
            assertEquals(MouseEvent.MOUSE_OUT, cardStack.currentLabel);
            if (cardStack.mouseEnabled || cardStack.mouseChildren) {
                cardStack.dispatchEvent(mouseClick);
            }
            assertEquals(Card.NULL, Selected.cursor.value);
            assertEquals(null, Selected.cursor.mc);
            assertEquals(1, cardStack.value);
            assertEquals(true, cardStack.mc is Card1);
        }
        
        /* Setup cards.  Deal first two cards from deck of six. */
        public function testDeal() {
            var game:Game = new Game();
            game.deck = [0, 1, 2, 3, 5];
            var cardInHand0:InHand = new InHand();
            var cardInHand1:InHand = new InHand();
            var hand:Array = [cardInHand0, cardInHand1];
            assertEquals(Card.NULL, cardInHand0.value);
            assertEquals(null, cardInHand0.mc);
            assertEquals(Card.NULL, cardInHand1.value);
            assertEquals(null, cardInHand1.mc);

            game.deal(hand);
            assertEquals(0, cardInHand0.value);
            assertTrue(cardInHand0.mc is Card0);
            assertEquals(Card.NULL, cardInHand1.value);
            assertEquals(null, cardInHand1.mc);

            game.deal(hand);
            assertEquals(0, cardInHand0.value);
            assertTrue(cardInHand0.mc is Card0);
            assertEquals(1, cardInHand1.value);
            assertTrue(cardInHand1.mc is Card1);
        }
    }
}
