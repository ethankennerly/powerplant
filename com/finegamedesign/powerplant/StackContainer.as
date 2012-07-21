package com.finegamedesign.powerplant
{
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;

    /* Query objects in display list by their class. */
    public class StackContainer extends Sprite
    {
        /**
         * Array of card values within a stack container.  May be recursive.
         * For example @see TestStackContainer.as
         */
        public static function values(parent:DisplayObjectContainer, ContainerClass:Class):Array
        {
            var stackValues:Array = [];
            var cards:Array = Container.getChildren(parent, Card);
            for each (var card:Card in cards) {
                stackValues.push(card.value);
            }
            var children:Array = Container.getChildren(parent, ContainerClass);
            for each (var child:* in children) {
                stackValues.push( values(child, ContainerClass) );
            }
            return stackValues;
        }
    }
}
