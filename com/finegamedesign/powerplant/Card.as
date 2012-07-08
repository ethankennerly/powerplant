package com.finegamedesign.powerplant 
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent; 

    /**
     * @author Ethan Kennerly
     */
    public class Card extends MovieClip
    {
        public static var debug:Boolean = false;

        public static var imageClasses:Array = [
            Card0, Card1, Card2, Card3, Card4, Card5, Card6, Card7, Card8, Card9];
        public static const NULL:int = -1;
        public static const RANDOM:int = -2;

        protected var _value:int;

        public function get value():int
        {
            return this._value;
        }

        /** Replace card holder child card 0 with card image at index of value. 
         * @param    cardValue        -1 null, -2 random
         */
        public function set value(cardValue:int):void
        {
            if (Card.RANDOM == cardValue) {
                cardValue = int(Math.random() * Card.imageClasses.length);
                if (debug) {
                    trace("Card.set value: random = " + cardValue);
                }
            }
            if (debug) {
                trace("Card.set value: from " + this._value.toString() + " to " + cardValue.toString() 
                     + " at x, y (" + this.x + ", " + this.y + ")");
            }
            this._value = cardValue;
            var holder:Holder = Container.getLowestClass(this, [Holder]);
            var image:* = Container.getLowestClass(holder, Card.imageClasses);
            if (null != image) {
                holder.removeChild(image);
            }
	    if (Card.NULL == cardValue) {
		holder.visible = false;
		this.gotoAndPlay(MouseEvent.MOUSE_OUT);
	    }
	    else {
		var imageClass:Class = Card.imageClasses[cardValue];
		holder.addChild(new imageClass());
		holder.visible = true;
	    }
        }

        /* Image of card value or null. */
        public function get mc():MovieClip
        {
            var holder:Holder = Container.getLowestClass(this, [Holder]);
            return Container.getLowestClass(holder, Card.imageClasses);
        }
        
        /* Hide.  Add to stage.  Swap image.  Then show. */
        public function Card(cardValue:int = Card.NULL) {
            this.visible = false;
            super();
            if (null == Container.getLowestClass(this, [Holder])) {
                this.addChild(new Holder());
            }
            this.value = cardValue;
            this.visible = true;
            this.cacheAsBitmap = true;
        }
      
        public function swapImage(cardValue:int):void {
            trace("Card.swapImage: deprecate for set value.");
            this.value = cardValue;
        } 

        /* Swap values */
        public function swap(that:Card) {
            var thatOldValue:int = that.value;
            that.value = this.value;
            this.value = thatOldValue;
        }
    }
}
