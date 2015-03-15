# Introduction #

Basic Skeleton for a Texas Hold'em game. All UI elements should be in GameView and Player, which right now are text based. But once working I'd like to easily make both an iPhone and Mac version by only replacing those files.

At this stage it only has human players on the console, so it is rather pointless as players see everyones card. Hopefully it will develop an AI and or network play.

# Details #

## Model: ##

The relationship between Cards, the Deck and Hand should be obvious.

A Hand can rank itself, to create a pair of numbers that can be used to compare itself to another hand and determine a winner. The two numbers represent the hands rank, and in the event two hands tie, the order of high cards.

A compare method has been implemented to an array of hands can sort itself from biggest loser to the winner.

A strengthAgainst: method has been implemented to assist a future AI in playing. The method compares a full 5 card hand to a partial hand to determine the likely chance of a win.

## View: ##
GameView makes up the bulk of the user interaction. From the controllers standpoint, GameView is the View, although in reality it asks Players to to a lot of the work.

Players handle input from the Player. The idea was/is that I can create additional player classes for AI players, or network players etc., with minimal if any changes to the Controler parts of the code.

## Controller: ##

The controller is in game.m. It simply steps though a poker round, asking the gameview for bets, dealing cards, repeating, and choosing a winner.

cards.m is the program entry point. It has the initial code used for testing the model classes, then it creates a game object and starts the gameloop.