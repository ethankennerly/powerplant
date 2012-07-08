package com.finegamedesign.powerplant
{
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import flash.events.MouseEvent;
    
    /**
     * ...
     * @author Ethan Kennerly
     */
    public class NextFrameButton extends SimpleButton 
    {
        
        public function NextFrameButton(upState:DisplayObject = null, overState:DisplayObject = null, downState:DisplayObject = null, hitTestState:DisplayObject = null) 
        {
            super(upState, overState, downState, hitTestState);
            this.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            //this.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
        }

        //public function onKeyUp(keyEvent:KeyboardEvent) {
            //if (keyEvent.charCode == Keyboard.RIGHT) {
                //this.onMouseUp(keyEvent);
            //}
        //}
        public function onMouseUp(mouseEvent:MouseEvent) {
            if (null != this.parent && this.parent is MovieClip) {
                var mc:MovieClip = (this.parent as MovieClip);
                // trace("NextFrameButton: onMouseUp: next frame or first.  this.name = " + this.name);
                if (mc.currentFrame <= mc.totalFrames - 1) {
                    mc.nextFrame();                    
                }
                else {
                    mc.gotoAndStop(1);
                }
            }
        }
    }

}
