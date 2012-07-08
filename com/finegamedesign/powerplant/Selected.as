package com.finegamedesign.powerplant 
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.Event;
    
    /**
     * @author Ethan Kennerly
     */
    public class Selected extends Card
    {
        /* only one cursor, ever */
        public static var cursor:Selected;
        
        /* complain argument count mismatch.  flash cs4 overwrites constructor? */
        public function Selected(cardValue:int = Card.NULL) {
            super(cardValue);
            Selected.cursor = this; // should only be one.
            this.addEventListener(Event.ADDED_TO_STAGE, this.followMouse);
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.stopFollowMouse);
        }
        
        /* root not acknowledged during constructor.  must be added first. */
        public function followMouse(event:Event) {
            this.removeEventListener(event.type, this.followMouse);
            this.cacheAsBitmap = true;
            if (this.root != null) {
                trace("Selected.followMouse:  You may see a card or nothing follow the cursor inside " + this.root.toString());
                Selected.cursor = this;
                this.x = int(this.root.mouseX);
                this.y = int(this.root.mouseY);
                this.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.snapToMouse);
                // not background
                // this.root.addEventListener(MouseEvent.MOUSE_MOVE, this.snapToMouse);
            }
            else {
                trace("Selected.followMouse:  root is null?");
            }
            
        }
        
        /* stop following, yet listen again for re-adding. */
        public function stopFollowMouse(event:Event) {
            this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.snapToMouse);
            this.addEventListener(Event.ADDED_TO_STAGE, this.followMouse);
        }
        
        public function snapToMouse(mouseEvent:MouseEvent) {
            if (this.root != null) {
                this.x = int(this.root.mouseX);
                this.y = int(this.root.mouseY);
                // smooth.  otherwise, choppy.  disturbs me.
                mouseEvent.updateAfterEvent();
            }
            else {
                trace("Selected.snapToMouse:  root is null? (" + this.x + ", " + this.y + ")"); // spam
            }
        }
    }
}
