package com.finegamedesign.powerplant
{
    import flash.display.MovieClip;
    import flash.text.TextField;

    /* Query objects in display list by their class. 
     * This class specifies a description. @see TestGame.as
     */
    public class Description extends MovieClip
    {
        public var txt:TextField;

        public function Description()
        {
            txt = new TextField();
        }
    }
}
