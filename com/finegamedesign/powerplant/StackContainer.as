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
            return stackValues;
        }
    }
}
