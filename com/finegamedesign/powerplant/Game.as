package com.finegamedesign.powerplant 
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.events.Event;

    /**
     * Controller
     * @author Ethan Kennerly
     */
    public class Game extends MovieClip
    {
        public var rule:Rule;
        public var update:Function;

        public function Game() 
        {
            rule = new Rule();
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
            if (null != selected && Card.NULL != selected.value) {
                trace("Game.picking:  You see a card by your cursor.");
                nextFrame();
                //this.update = this["holding"];
                //this.gotoAndStop("call_holdingExample");
            }
        }
        
        /* cursor is empty and card played to stack:  powering. */
        public function holding(event:Event = null) {
            var selected:Selected = Container.getLowestClass(this, [Selected]);
            if (null != selected && Card.NULL == selected.value) {
                trace("Game.holding:  Card on stack.  You make power.  You may not select a card.");
                nextFrame();
                //this.update = this["powering"];
                //this.gotoAndStop("call_poweringExample");
            }
        }
        
        /* Update text of their power and your power. 
         * Update power for two cards on their stack.  */
        public function powering(event:Event = null) {
            Game.describePowering(this, YourField, PowerText, 
                PowerDescription, "YOU", "YOUR");
            Game.describePowering(this, TheirField, PowerTheirText, 
                TheirPowerDescription, "I", "MY");
        }

        /**
         * Text of total power, description of card played on one stack.
         */ 
        public static function describePowering(table:DisplayObjectContainer, 
            FieldStackContainerClass:Class, PowerTextClass:Class, DescriptionClass:Class, 
            pronoun:String, possessive:String):void
        {
            var field:* = Container.getLowestClass(table, [FieldStackContainerClass]);
            var stackValues:Array = StackContainer.values(field);
            var powerText:* = Container.getLowestClass(table, [PowerTextClass]);
            if (null != powerText) {
                powerText._txt.text = Calculate.power([stackValues]).toString();
            }
            var description:* = Container.getLowestClass(table, [DescriptionClass]);
            if (null != description && null != description.txt) {
                description.txt.text = Stack.describePower(
                    stackValues, pronoun, possessive);
            }
        }

        /* After hand appears. */
        public function reset():void 
        {
            trace("Game.reset:  Now your cards will be dealt in the tutorial's starting order.");
            rule.reset();
            resetHand(InHand);
            resetHand(InTheirHand);
        }

        /** Cards in hand become empty. */
        public function resetHand(HandClass:Class):void
        {
            var cards:Array = Container.getChildren(this, HandClass);
            for each (var card:Card in cards) {
                card.value = Card.NULL;
            }
        }
       
        /** Integers in children of this class. */        
        public function evaluateHand(HandClass:Class):Array
        {
            var cards:Array = Container.getChildren(this, HandClass);
            var values:Array = new Array();
            for each (var card:Card in cards) {
                values.push(card);
            }
            return values;
        }

        /* Deal one card to your hand. */
        public function deal(hand:Array, HandClass:Class):void 
        {
            var dealt:int = rule.deal(hand);
            var cards:Array = Container.getChildren(this, HandClass);
            for (var c:int = 0; c < cards.length; c++ ) {
                var card:Card = cards[c];
                if (Card.NULL == card.value) {
                    card.value = dealt;
                    break;
                }
            }
            if (Card.NULL == dealt) {
                throw new Error("Game.deal:  Why no card?  Hand full?  Deck empty?");
            }
        }

        /**
         * At least one frame beforehand, TheirStackContainer must exist.  
         * Move card from their hand to stack in container of their stack container. 
         *      FieldStackContainer
         *          StackContainer
         *              Stack (ed Card)
         */
        public function playCard(FieldStackContainerClass:Class, value:int, stackIndex:int=0):void
        {
            rule.theirHand.splice(rule.theirHand.indexOf(value), 1);
            var found:InTheirHand = null;
            var theirHand:Array = Container.getChildren(this, InTheirHand);
            for (var c:int = 0; c < theirHand.length; c ++) {
                var card:InTheirHand = theirHand[c];
                if (value == card.value) {
                    found = card;
                }
            }
            if (null == found) {
                trace("Game.playCard:  Do they have this card? " + value.toString());
                return;
            }
            var empty:Stack = StackContainer.findLowest(this, FieldStackContainerClass, 
                Card.NULL, stackIndex);
            if (null == empty) {
                trace("Game.playCard:  At least one frame beforehand, FieldStackContainer must exist.");                
                return;
            }
            found.swap(empty);
            var next:CardStack = new CardStack();
            StackContainer.offset(empty, next);
            empty.parent.addChild(next);
        }

        /* At least one frame beforehand, Contract must exist.  
         * Move card from deck to contract.  
         * DOES NOT yet check if deck has one or fewer cards.  */
        public function revealContract():void {
            viewContract(rule.revealContract());
        }

        public function viewContract(values:Array):void {
            if (2 != values.length) {
                throw new Error("Game.viewContract:  Why are there not two values?  There are " + values.length.toString());
            }
            var children:Array = Container.getChildren(this, Contract);
            if (2 != children.length) {
                throw new Error("Game.viewContract:  Why are there not two contract cards?  There are " + children.length.toString());
            }
            for (var v:int = 0; v < values.length; v++) {
                var card:Contract = children[v];
                if (Card.NULL != card.value) {
                    trace("Game.viewContract:  Why is place " + v + " not null?  It is " + card.value.toString());
                }
                card.value = values[v];
            }
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
                        card.value = Card.NULL;
                    }
                }
            }
        }
        
        /* We keep our hand and score.  We discard the rest. 
         * Discard stacks and city contract.  */
        public function clear() {
            rule.clear();
            this.clearChildren(Contract);
            clearFields(this);
        }

        /**
         * One stack with one card remains.
         * The card is empty.
         */
        public static function clearFields(table:DisplayObjectContainer):void
        {
            var fields:Array = Container.getChildren(table, StackContainer);
            for each (var field:StackContainer in fields) {
                var stacks:Array = Container.getChildren(field, StackContainer);
                var cards:Array = Container.getChildren(stacks[0], Card);
                cards[0].value = Card.NULL;
                for (var c:int=1; c < cards.length; c++) {
                    cards[c].parent.removeChild(cards[c]);
                }
                for (var s:int=1; s < stacks.length; s++) {
                    stacks[s].parent.removeChild(stacks[s]);
                }
            }
        }

        /**
         * Rendering may occur before ActionScript on timeline.
         * So use a label to call ActionScript.
         * Flash Player 9 does not have currentFrameLabel, so expect label lasts 1 frame.
         */
        override public function nextFrame():void
        {
            super.nextFrame();
            if (null != this.currentLabel 
                    && 0 == this.currentLabel.indexOf("call_")) {
                this[this.currentLabel.substr(5)]();
            }
        }

        public function dealExample():void
        {
            this.reset();
            this.deal(this.rule.yourHand, InHand);
            this.deal(this.rule.theirHand, InTheirHand);
            this.deal(this.rule.yourHand, InHand);
            this.deal(this.rule.theirHand, InTheirHand);
            this.deal(this.rule.yourHand, InHand);
            this.deal(this.rule.theirHand, InTheirHand);
            this.deal(this.rule.yourHand, InHand);
        }

        public function drawTheirExample():void
        {
            this.deal(this.rule.theirHand, InTheirHand);
        }

        public function playCardExample():void
        {
            this.update = this["powering"];
            var theirField:StackContainer = Container.getLowestClass(this, [TheirField]);
            var value_and_stack:Array = Calculate.select_value_and_stack(rule.theirHand, 
                StackContainer.values(theirField), rule.contract);
            if (null == value_and_stack) {
                throw new Error("TODO: I cannot play");
            }
            else {
                this.playCard(TheirField, value_and_stack[0], value_and_stack[1]);
            }
        }

        public function drawExample():void
        {
            this.deal(this.rule.yourHand, InHand);
        }

        public function pickingExample():void
        {
            this.update = this.picking;
        }

        public function holdingExample():void
        {
            this.update = this.holding;
        }

        public function nextContractExample():void
        {
            this.gotoAndStop("call_revealContract");
            revealContract();
        }
    }
}
