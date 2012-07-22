package com.finegamedesign.powerplant
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;

    /* Query objects in display list by their class. */
    public class StackContainer extends Sprite
    {
        public static function offset(stack:DisplayObject, next:DisplayObject):void
        {
            next.y = stack.y + 24;
        }

        /**
         * Array of card values within a stack container.  May be recursive.
         * For example @see TestStackContainer.as
         */
        public static function values(parent:DisplayObjectContainer, ContainerClass:Class):Array
        {
            var stackValues:Array = [];
            var cards:Array = Container.getChildren(parent, Card);
            for each (var card:Card in cards) {
                if (Card.NULL != card.value) {
                    stackValues.push(card.value);
                }
            }
            var children:Array = Container.getChildren(parent, ContainerClass);
            for each (var child:* in children) {
                stackValues.push( values(child, ContainerClass) );
            }
            return stackValues;
        }

        /**
         * The card in stack container whose value equals the given value. 
         * Compiler complains about default constant Card.NULL, so pass in "value".
         */
        public static function findLowest(container:DisplayObjectContainer, 
                FieldStackContainerClass:Class, value:int, stackIndex:int=0):Stack 
        {
            var found:Stack;
            var field:* = Container.getLowestClass(container, [FieldStackContainerClass]);
            var stacks:Array = Container.getChildren(field, StackContainer);
            var cards:Array = Container.getChildren(stacks[stackIndex], Stack);
            for each (var card:Stack in cards) {
                if (value == card.value) {
                    found = card;
                    break;
                }
            }
            return found;
        }
    }
}
