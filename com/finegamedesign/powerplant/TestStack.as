package com.finegamedesign.powerplant
{
    import flash.display.Sprite;
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

        /*
           I HAVE NO CARDS IN PLAY.I MAKE 0 POWER.
           I PLAY 4.I MAKE 4 POWER.
           I PLAY 3 ON MY 4.4 x 3 = 12I MAKE 12 POWER.
           I PLAY 2 ON MY 4 AND 3.4 x 3 x 2 = 24I MAKE 24 POWER.
         */
        public function testDescribePower():void
        {
            assertEquals(
                "I HAVE NO CARDS IN PLAY.\n\nI MAKE 0 POWER.",
                Stack.describePower([]));
            assertEquals(
                "I PLAY 4.\n\nI MAKE 4 POWER.",
                Stack.describePower([4]));
            assertEquals(
                "I PLAY 3 ON MY 4.\n4 x 3 = 12\nI MAKE 12 POWER.",
                Stack.describePower([4, 3]));
            assertEquals(
                "I PLAY 2 ON MY 4 AND 3.\n4 x 3 x 2 = 24\nI MAKE 24 POWER.",
                Stack.describePower([4, 3, 2]));
            assertEquals(
                "YOU PLAY 2 ON YOUR 4 AND 3.\n4 x 3 x 2 = 24\nYOU MAKE 24 POWER.",
                Stack.describePower([4, 3, 2], "YOU", "YOUR"));
        }

        public function testValues():void
        {
            assertEqualsArrays( [2, 3],
                Stack.values( [new Card(2), new Card(3)] ));
            var nulls:Array = [new Card(Card.NULL), new Card(Card.NULL)];
            assertEqualsArrays( [], Stack.values(nulls));
        }
    }
}
