package com.finegamedesign.powerplant 
{
    import flash.events.Event;
    import flash.display.MovieClip;

    /**
     * @author Ethan Kennerly
     */
    public class Main extends MovieClip
    {
        public function Main() 
        {
            var example:Example = new Example();
            this.addChild(example);
            example = null;
        }
    }
}

