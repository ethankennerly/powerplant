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
         * 5 outside a container and stacks [[], [2, 3], [1]]
         */
        public function testValues():void
        {
            var field:StackContainer = new StackContainer();
            assertEqualsArrays("No child", [], StackContainer.values(field, StackContainer));
            field.addChild(new StackContainer());
            assertEqualsArrays("Empty stack", [], StackContainer.values(field, StackContainer)[0]);
            var stack:StackContainer = new StackContainer();
            stack.addChild(new Stack(2));
            stack.addChild(new Stack(3));
            field.addChild(stack);
            var stack2:StackContainer = new StackContainer();
            stack2.addChild(new Stack(1));
            field.addChild(stack2);
            var values:Array = StackContainer.values(field, StackContainer);
            assertEqualsArrays([], values[0]);
            assertEqualsArrays([2, 3], values[1]);
            assertEqualsArrays([1], values[2]);
            assertEquals(3, values.length);

            var sprite:Sprite = new Sprite();
            sprite.addChild(field);
            sprite.addChild(new Stack());
            sprite.addChild(new Stack(5));
            var values:Array = StackContainer.values(sprite, StackContainer);
            assertEqualsArrays([], values[0]);
            assertEquals(5, values[1]);
        }

        /**
         * stacks with cards []
         * stacks with cards [[]]
         * stacks with cards [[], [2, 3], [1]]
         */
        public function testFindLowest():void
        {
            var field:StackContainer = new StackContainer();
            assertEquals("No child", null, 
                StackContainer.findLowest(field, StackContainer, Card, Card.NULL));
            field.addChild(new StackContainer());
            assertEquals("Empty stack", null, 
                StackContainer.findLowest(field, StackContainer, Card, Card.NULL));
            var stack:StackContainer = new StackContainer();
            stack.addChild(new Stack(2));
            stack.addChild(new Stack(3));
            field.addChild(stack);
            var stack2:StackContainer = new StackContainer();
            var cardNull:Stack = new Stack();
            stack2.addChild(cardNull);
            field.addChild(stack2);
            assertEquals("Two stacks", cardNull, 
                StackContainer.findLowest(field, StackContainer, Card, Card.NULL));
        }
    }
}
