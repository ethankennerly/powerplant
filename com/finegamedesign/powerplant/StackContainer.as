package com.finegamedesign.powerplant
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;

    /* Query objects in display list by their class. */
    public class StackContainer extends Sprite
    {
        /**
         * Flash compiler complains that class from SWC was not found.
         * So here is value copy and pasted from FLA StackOffset.
         */
        public static function offset(stack:DisplayObject, next:DisplayObject):void
        {
            next.y = stack.y + 24;
        }

        /**
         * Array of card values within a field.  May be recursive.
         * For example @see TestStackContainer.as
         */
        public static function values(field:StackContainer):Array
        {
            var stackValues:Array = [];
            var cards:Array = Container.getChildren(field, Card);
            for each (var card:Card in cards) {
                if (Card.NULL != card.value) {
                    stackValues.push(card.value);
                }
            }
            var children:Array = Container.getChildren(field, StackContainer);
            for each (var child:StackContainer in children) {
                stackValues.push( values(child) );
            }
            return stackValues;
        }

        /**
         * The card in stack container whose value equals the given value. 
         * Compiler complains about default constant Card.NULL, so pass in "value".
         */
        public static function findLowest(container:DisplayObjectContainer, 
                FieldStackContainerClass:Class, value:int, stackIndex:int=0):Card 
        {
            var found:Card;
            var field:* = Container.getLowestClass(container, [FieldStackContainerClass]);
            var stacks:Array = Container.getChildren(field, StackContainer);
            var cards:Array = Container.getChildren(stacks[stackIndex], Card);
            for each (var card:Card in cards) {
                if (value == card.value) {
                    found = card;
                    break;
                }
            }
            return found;
        }
    }
}
