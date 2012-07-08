package com.finegamedesign.powerplant
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;

    /**
     * Get a child of a display object container with a class.
     * @author Ethan Kennerly
     */
    public class Container 
    {
        /* Child with lowest display list index of any of theses classes. */
        public static function getLowestClass(container:DisplayObjectContainer, classes:Array):* 
        {
            for (var c:int=0; c < container.numChildren; c++) {
                var child:DisplayObject = container.getChildAt(c);
                for (var i:int=0; i < classes.length; i++) {
                     var aClass:Class = classes[i] as Class;
                     if (child is aClass) {
                         return child as aClass;
                     }
                }
            }
            return null;
        }

        /* All children of the given class. */
        public static function getChildren(container : DisplayObjectContainer, aClass : Class) : * {
            var children : Array = new Array();
            for (var c : int = 0; c < container.numChildren; c++ ) {
                var child : DisplayObject = container.getChildAt(c);
                if (child is aClass) {
                    children.push(child);
                }
            }
            return children;
        }
    }
}
