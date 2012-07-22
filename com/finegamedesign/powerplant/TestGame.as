package com.finegamedesign.powerplant
{
    import flash.events.MouseEvent;

    import asunit.framework.TestCase;

    /**
     * @author Ethan Kennerly
     */
    public class TestGame extends TestCase
    {
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

        /* No stack.  Describe power.  */
        public function testDescribePowering():void
        {
            var game:Game = new Game();
            assertEqualsArrays([], Container.getChildren(game, StackContainer));
            assertEqualsArrays([], Container.getChildren(game, Description));
            var description:Description = new Description();
            game.addChild(description);
            Game.describePowering(game, StackContainer, PowerText, Description, "YOU", "YOUR");
            assertEquals("YOU HAVE NO CARDS IN PLAY.\r\rYOU MAKE 0 POWER.", description.txt.text);
        }

        /** 
         * Play from a hand of [1] to an empty stack. 
         * Expect 1 in stack container, placeholder for next card, and hand is empty.
         */
        public function testPlayCard():void
        {
            var game:Game = new Game();
            var stack:StackContainer = new StackContainer();
            stack.addChild(new Stack());
            var field:StackContainer = new StackContainer();
            field.addChild(stack);
            game.addChild(field);
            game.theirHand = [new InTheirHand()];
            game.theirHand[0].value = 1;
            game.playCard(StackContainer, 1);
            assertEquals(Card.NULL, game.theirHand[0].value);
            assertEquals(2, stack.numChildren);
            assertEquals(1, (stack.getChildAt(0) as Stack).value);
            assertEquals(Card.NULL, (stack.getChildAt(1) as Stack).value);
        }
    }
}
