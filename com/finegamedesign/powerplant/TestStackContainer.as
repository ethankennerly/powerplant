package com.finegamedesign.powerplant
{
    import flash.display.Sprite;
    import flash.events.MouseEvent;

    import asunit.framework.TestCase;

    public class TestStackContainer extends TestCase
    {
        /**
         * stacks with cards []
         * stacks with cards [[]]
         * stacks with cards [[], [2, 3], [1]]
         */
        public function testValues():void
        {
            var field:StackContainer = new StackContainer();
            assertEqualsArrays("No child", [], StackContainer.values(field));
            field.addChild(new StackContainer());
            assertEqualsArrays("Empty stack", [], StackContainer.values(field)[0]);
            var stack:StackContainer = new StackContainer();
            stack.addChild(new Stack(2));
            stack.addChild(new Stack(3));
            field.addChild(stack);
            var stack2:StackContainer = new StackContainer();
            stack2.addChild(new Stack(1));
            field.addChild(stack2);
            var values:Array = StackContainer.values(field);
            assertEqualsArrays([], values[0]);
            assertEqualsArrays([2, 3], values[1]);
            assertEqualsArrays([1], values[2]);
            assertEquals(3, values.length);
        }

        /**
         * stacks with cards []
         * stacks with cards [[]]
         * stacks with cards [[], [2, 3], [1]]
         */
        public function testFindLowest():void
        {
            var field:StackContainer = new StackContainer();
            var table:Sprite = new Sprite();
            table.addChild(field);
            assertEquals("No child", null, 
                StackContainer.findLowest(table, StackContainer, Card.NULL));
            var stack0:StackContainer = new StackContainer();
            field.addChild(stack0);
            assertEquals("Empty stack", null, 
                StackContainer.findLowest(table, StackContainer, Card.NULL));
            var stack1:StackContainer = new StackContainer();
            stack1.addChild(new Stack(2));
            stack1.addChild(new Stack(3));
            field.addChild(stack1);
            var stack2:StackContainer = new StackContainer();
            var cardNull:Stack = new Stack();
            stack2.addChild(cardNull);
            field.addChild(stack2);
            assertEquals("Empty card value", Card.NULL, cardNull.value); 
            assertEquals("First stack", null, 
                StackContainer.findLowest(table, StackContainer, Card.NULL));
            assertEquals("Second stack", null, 
                StackContainer.findLowest(table, StackContainer, Card.NULL, 1));
            assertEquals("Third stack", cardNull, 
                StackContainer.findLowest(table, StackContainer, Card.NULL, 2));
        }
    }
}
