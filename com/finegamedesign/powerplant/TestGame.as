package com.finegamedesign.powerplant
{
    import flash.display.Sprite;
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
            game.rule.deck = [0, 1, 2, 3, 5];
            var cardInHand0:InHand = new InHand();
            var cardInHand1:InHand = new InHand();
            game.addChild(cardInHand0);
            game.addChild(cardInHand1);
            assertEquals(Card.NULL, cardInHand0.value);
            assertEquals(null, cardInHand0.mc);
            assertEquals(Card.NULL, cardInHand1.value);
            assertEquals(null, cardInHand1.mc);

            game.deal(game.rule.yourHand, InHand);
            assertEquals(0, cardInHand0.value);
            assertTrue(cardInHand0.mc is Card0);
            assertEquals(Card.NULL, cardInHand1.value);
            assertEquals(null, cardInHand1.mc);

            game.deal(game.rule.yourHand, InHand);
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
         * Play from a hand of [1] to an empty stack.  Empty stack has an empty card.
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
            game.rule.theirHand = [1];
            var inTheirHand:InTheirHand = new InTheirHand();
            inTheirHand.value = 1;
            game.addChild(inTheirHand);
            assertEquals(1, stack.numChildren);
            game.playCard(StackContainer, 1);
            assertEqualsArrays([], game.rule.theirHand);
            assertEquals(1, (stack.getChildAt(0) as Stack).value);
            assertEquals(2, stack.numChildren);
            assertEquals(Card.NULL, (stack.getChildAt(1) as Stack).value);
        }

        /** 2 cards in 1 stack.  No cards in a second stack.  1 field on table.
         * clear fields.  1 card in first stack.  No second stack.
         */
        public function testClearFields():void
        {
            var table:Sprite = new Sprite();
            var card0:Stack = new Stack();
            var card1:Stack = new Stack();
            var field:StackContainer = new StackContainer();
            var stack0:StackContainer = new StackContainer();
            stack0.addChild(card0);
            stack0.addChild(card1);
            var stack1:StackContainer = new StackContainer();
            field.addChild(stack0);
            field.addChild(stack1);
            table.addChild(field);
            Game.clearFields(table);
            assertEquals(1, field.numChildren);
            assertEquals(stack0, field.getChildAt(0));
            assertEquals(1, stack0.numChildren);
            assertEquals(card0, stack0.getChildAt(0));
        }
    }
}
