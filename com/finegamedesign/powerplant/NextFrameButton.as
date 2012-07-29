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
        
        public function NextFrameButton(upState:DisplayObject = null, 
                overState:DisplayObject = null, downState:DisplayObject = null, 
                hitTestState:DisplayObject = null) 
        {
            super(upState, overState, downState, hitTestState);
            this.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }

        public function onMouseUp(mouseEvent:MouseEvent) {
            if (null != this.parent && this.parent is MovieClip) {
                var mc:MovieClip = (this.parent as MovieClip);
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
