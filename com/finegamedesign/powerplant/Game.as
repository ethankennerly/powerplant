package com.finegamedesign.powerplant 
{
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.events.Event;

    /**
     * ...
     * @author Ethan Kennerly
     */
    public class Game extends MovieClip
    {
        public var deck:Array;
        public var hand:Array;
        public var their_hand:Array;
        public var update:Function = null;

        public function Game() 
        {
            this.addEventListener(Event.ADDED_TO_STAGE, this.start);
        }
        
        public function start(event:Event = null) {
            trace("Game.start:  You see the cover of Power Plant.");
            this.removeEventListener(Event.ADDED_TO_STAGE, this.start);
            this.stage.addEventListener(Event.ENTER_FRAME, this.enterFrame);
        }

        public function enterFrame(event:Event = null) {
            if (null != this.update) {
                this.update(event);
            }
        }
        
        /* pick a card.  card selected:  holding. */
        public function picking(event:Event = null) {
            var selected:Selected = Container.getLowestClass(this, [Selected]);
            if (null == selected) {
                trace("Game.picking:  Why is selected " + selected.toString() + "?");
            }
            else if (Card.NULL != selected.value) {
                trace("Game.picking:  You see a card by your cursor.");
                this.update = this["holding"];
                this.gotoAndStop("holding");
            }
        }
        
        /* cursor is empty and card played to stack:  powering. */
        public function holding(event:Event = null) {
            var selected:Selected = Container.getLowestClass(this, [Selected]);
            if (null == selected) {
                trace("Game.holding:  Why is selected " + selected.toString() + "?");
            }
            else if (Card.NULL == selected.value) {
                trace("Game.holding:  Card on stack.  You make power.  You may not select a card.");
                this.update = this["powering"];
                this.gotoAndStop("powering");
            }
        }
        
        /* if there is a stack of cards, multiply card values and update power text.  */
        public static function updatePower(container:DisplayObjectContainer,
                cards:Array, PowerTextClass:Class):void
        {
            var power:* = Container.getLowestClass(container, [PowerTextClass]);
            if (null == power) {
                trace("Game.updatePower:  Why is power " + power + "?");
            }
            else if (0 == cards.length) {
                power._txt.text = "";
            } else {
                var totalPower:int = 0;
                var previousValue:Boolean = false;
                for (var i:int = 0; i < cards.length; i++) 
                {
                    var card:Card = cards[i];
                    if (Card.NULL != card.value) {
                        if (! previousValue) {
                            totalPower = 1;
                            previousValue = true;
                        }
                        totalPower *= card.value;
                    }
                }
                power._txt.text = totalPower.toString();
            }
        }
        
        /* Update text of their power and your power. 
         * Update power for two cards on their stack.  */
        public function powering(event:Event = null) {
            Game.describePowering(this, CardStack, PowerText, 
                PowerDescription, "YOU", "YOUR");
            Game.describePowering(this, TheirStack, PowerTheirText, 
                TheirPowerDescription, "I", "MY");
        }

        public static function describePowering(container:DisplayObjectContainer, 
            StackClass:Class, TextClass:Class, DescriptionClass:Class, 
            pronoun:String, possessive:String):void
        {
            var stacks:Array = Container.getChildren(container, StackClass);
            updatePower(container, stacks, TextClass);
            var description:* = Container.getLowestClass(
                container, [DescriptionClass]);
            if (null != description && null != description.txt) {
                description.txt.text = Stack.describePower(
                    Stack.values(stacks), pronoun, possessive);
            }
        }

        /* After hand appears. */
        public function reset():void {
            trace("Game.reset:  Now your cards will be dealt in the tutorial's starting order.");
            this.deck = new Array(1, 3, 2, 4, 3, 5, 5, 1, 2, 4, 3, 9, 2, 5, 6, 8, 4, 3, 7, 3, 2);
            this.hand = Container.getChildren(this, InHand);
            this.their_hand = Container.getChildren(this, InTheirHand);
        }
        
        /* Deal one card to your hand. */
        public function deal(hand:Array):void 
        {
            var dealt:int = Card.NULL;
            for (var c:int = 0; c < hand.length; c++ ) {
                var card:Card = hand[c];
                if (Card.NULL == card.value) {
                    dealt = this.deck.shift();
                    if (this.hand == hand) {
                        trace("Game.deal:  You receive card number " + dealt);
                    }
                    else if (this.their_hand == hand) {
                        trace("Game.deal:  They receive card number " + dealt);                    
                    }
                    else {
                        trace("Game.deal:  WHO receives card number " + dealt + "?");                                            
                    }
                    card.swapImage(dealt);
                    break;
                }
            }
            if (Card.NULL == dealt) {
                trace("Game.deal:  Why was no card dealt?  Was your hand full?");
            }
        }

        /* The card whose value equals the given value. */
        public function findLowest(CardClass:Class, value:int):* {
            var children:Array = Container.getChildren(this, CardClass);
            var found:* = null;
            for (var c:int = 0; c < children.length; c ++) {
                var card = children[c] as CardClass;
                if (value == card.value) {
                    found = card;
                    break;
                }
            }
            return found;
        }
       
        /* At least one frame beforehand, TheirStack must exist.  
         * Move card from their hand to their stack */
        public function their_play(value:int) {
            var found:InTheirHand = null;
            for (var c:int = 0; c < this.their_hand.length; c ++) {
                var card:InTheirHand = this.their_hand[c];
                if (value == card.value) {
                    found = card;
                }
            }
            if (null == found) {
                trace("Game.their_play:  Do they have this card? " + value.toString());
                return;
            }
            var stack:TheirStack = this.findLowest(TheirStack, Card.NULL);
            if (null == stack) {
                trace("Game.their_play:  At least one frame beforehand, TheirStack must exist.");                
                return;
            }
            if (Card.NULL != stack.value) {
                trace("Game.their_play:  When I play " + found.value 
                    + ", why is stack " + stack.value.toString() + " not empty?");
            }
            found.swap(stack);            
        }

        /* At least one frame beforehand, Contract must exist.  
         * Move card from deck to contract.  
         * DOES NOT yet check if deck has one or fewer cards.  */
        public function revealContract() {
            var children:Array = Container.getChildren(this, Contract);
            if (2 != children.length) {
                trace("Game.revealContract:  Why are there not two contract cards?  There are " + children.length.toString());
            }
            var tensValue:int = this.deck.shift();
            var tens:Contract = children[0];
            if (Card.NULL != tens.value) {
                trace("Game.revealContract:  Why is tens place not null?  It is " + tens.value.toString());
            }
            tens.swapImage(tensValue);
            var onesValue:int = this.deck.shift();
            var ones:Contract = children[1];
            if (Card.NULL != ones.value) {
                trace("Game.revealContract:  Why is ones place not null?  It is " + ones.value.toString());
            }
            ones.swapImage(onesValue);
        }

        /* Set all cards in class to null. */
        public function clearChildren(CardClass:Class) {
            var children:Array = Container.getChildren(this, CardClass);
            if (0 == children.length) {
                trace("Game.clearChildren:  Why is this " + String(CardClass) + " class empty?");
            } else {
                for (var c:int = 0; c < children.length; c ++) {
                    var card:* = children[c] as CardClass;
                    if (Card.NULL != card.value) {
                        card.swapImage(Card.NULL);
                    }
                }
            }            
        }
        
        /* We keep our hand and score.  We discard the rest. 
         * Discard stacks and city contract.  */
        public function clear() {
            this.clearChildren(Stack);
            this.clearChildren(TheirStack);
            this.clearChildren(Contract);
        }
    }
}
