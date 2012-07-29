package com.finegamedesign.powerplant 
{
    /**
     * Model of rules to play Power Plant without their appearance.
     * @author Ethan Kennerly
     */
    public class Rule
    {
        public var deck:Array;
        public var yourHand:Array;
        public var theirHand:Array;
        public var yourField:Array;
        public var theirField:Array;
        public var contract:int;

        public function Rule()
        {
            reset();
        }

        /* After hand appears. */
        public function reset():void 
        {
            trace("Rule.reset:  Now your cards will be dealt in the tutorial's starting order.");
            this.deck = new Array(1, 3, 2, 4, 3, 4, 4, 1, 2, 4, 3, 9, 2, 5, 6, 8, 4, 3, 7, 3, 2);
            yourHand = new Array();
            theirHand = new Array();
            yourField = new Array();
            theirField = new Array();
        }
        
        /* Deal one card to your hand. */
        public function deal(hand:Array):int
        {
            var dealt:int = this.deck.shift();
            hand.push(dealt);
            return dealt;
        }

        /* At least one frame beforehand, Contract must exist.  
         * Move card from deck to contract.  
         * DOES NOT yet check if deck has one or fewer cards.  */
        public function revealContract():Array {
            var tensValue:int = this.deck.shift();
            var onesValue:int = this.deck.shift();
            contract = 10 * tensValue + onesValue;
            return [tensValue, onesValue];
        }

        /* We keep our hand and score.  We discard the rest. 
         * Discard stacks and city contract.  */
        public function clear() {
            this.contract = 0;
            this.yourField = [];
            this.theirField = [];
        }
    }
}
