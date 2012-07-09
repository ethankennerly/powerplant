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
            assertEqualsArrays([], Container.getChildren(game, Stack));
            assertEqualsArrays([], Container.getChildren(game, Description));
            var description:Description = new Description();
            game.addChild(description);
            Game.describePowering(game, Stack, PowerText, Description, "YOU", "YOUR");
            assertEquals("YOU HAVE NO CARDS IN PLAY.\r\rYOU MAKE 0 POWER.", description.txt.text);
        }
    }
}
