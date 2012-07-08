package com.finegamedesign.powerplant
{
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    
    /**
     * ...
     * @author Ethan Kennerly
     */
    public class PrevFrameButton extends SimpleButton 
    {
        
        public function PrevFrameButton(upState:DisplayObject = null, overState:DisplayObject = null, downState:DisplayObject = null, hitTestState:DisplayObject = null) 
        {
            super(upState, overState, downState, hitTestState);
            this.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }

        public function onMouseUp(mouseEvent:MouseEvent) {
            if (null != this.parent && this.parent is MovieClip) {
                var mc:MovieClip = (this.parent as MovieClip);
                trace("PrevFrameButton: onMouseUp: previous frame or last.  this.name = " + this.name);
                if (2 <= mc.currentFrame) {
                    mc.prevFrame();                    
                }
                else {
                    mc.gotoAndStop(mc.totalFrames);
                }
            }
        }
    }

}
