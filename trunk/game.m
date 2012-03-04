//
//  game.m
//  cards
//
//  Created by Warren Holybee on 1/19/11.
//  Copyright 2011 Warren Holybee. All rights reserved.
//

#import "game.h"
#import "GameView.h"
#import "Deck.h"
#import "Card.h"
#import "Player.h"
#import "AIPlayer.h"
#import "Hand.h"
#import "Thinker.h"

@implementation game
@synthesize players;
@synthesize delegate;
@synthesize gameView;
@synthesize aWindow;
@synthesize playersSheet;
@synthesize numberOfPlayersText, nextStep, showAICards, showWinChance;;
@synthesize minField, maxField, startFundsField, bigBlindField, littleBlindField, blindButton, prefs;
@synthesize showAICardsButton, showWinChanceButton;

#pragma mark init/dealloc

-(void) dealloc {
	[gameView release];
	[deck release];
	[players release];
	[flop release];
	[super dealloc];
}

-(id) init {
	// set up the gameView
    NSLog(@"[game init]");
    [self registerUserDefaults];
    inGame = NO;
	return self;
}	

#pragma mark User Defaults

-(void) registerUserDefaults {
    NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
    [defaultValues setObject:[NSNumber numberWithFloat:10.0] forKey:@"minBet"];
    [defaultValues setObject:[NSNumber numberWithFloat:50.0] forKey:@"maxBet"];
    [defaultValues setObject:[NSNumber numberWithFloat:100.0] forKey:@"startFunds"];
    [defaultValues setObject:[NSNumber numberWithFloat:5.0] forKey:@"littleBlind"];
    [defaultValues setObject:[NSNumber numberWithFloat:10.0] forKey:@"bigBlind"];
    [defaultValues setObject:[NSNumber numberWithInt:NSOffState] forKey:@"useBlind"];
    [defaultValues setObject:[NSNumber numberWithInt:NSOffState] forKey:@"showAICards"];
    [defaultValues setObject:[NSNumber numberWithInt:NSOffState] forKey:@"showChance"];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];

    
}

-(void) showPrefs {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    minField.floatValue = [[defaults objectForKey:@"minBet"] floatValue];
    maxField.floatValue = [[defaults objectForKey:@"maxBet"] floatValue];
    startFundsField.floatValue = [[defaults objectForKey:@"startFunds"] floatValue];
    littleBlindField.floatValue = [[defaults objectForKey:@"littleBlind"] floatValue];
    bigBlindField.floatValue = [[defaults objectForKey:@"bigBlind"] floatValue];
    blindButton.state = [[defaults objectForKey:@"useBlind"] intValue];
    showAICardsButton.state = [[defaults objectForKey:@"showAICards"] intValue];
    showWinChanceButton.state = [[defaults objectForKey:@"showChance"] intValue];
    
    [prefs orderFront:self];
}

-(void) closePrefs {

    minBet = [minField floatValue];
    maxBet = [maxField floatValue];
    startFunds = [startFundsField floatValue];
    littleBlind = [littleBlindField floatValue];
    bigBlind = [bigBlindField floatValue];
    useBlind = [blindButton state];
    showWinChance = [showWinChanceButton state];
    showAICards = [showAICardsButton state];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithFloat:minBet] forKey:@"minBet"];
    [defaults setObject:[NSNumber numberWithFloat:maxBet] forKey:@"maxBet"];
    [defaults setObject:[NSNumber numberWithFloat:startFunds] forKey:@"startFunds"];
    [defaults setObject:[NSNumber numberWithFloat:littleBlind] forKey:@"littleBlind"];
    [defaults setObject:[NSNumber numberWithFloat:bigBlind] forKey:@"bigBlind"];
    [defaults setObject:[NSNumber numberWithInt:useBlind] forKey:@"useBlind"];
    [defaults setObject:[NSNumber numberWithInt:showAICards] forKey:@"showAICards"];
    [defaults setObject:[NSNumber numberWithInt:showWinChance] forKey:@"showChance"];
    
    [prefs orderOut:self];

}

-(void) readDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    minBet = [[defaults objectForKey:@"minBet"] floatValue];
    maxBet = [[defaults objectForKey:@"maxBet"] floatValue];
    startFunds = [[defaults objectForKey:@"startFunds"] floatValue];
    littleBlind = [[defaults objectForKey:@"littleBlind"] floatValue];
    bigBlind = [[defaults objectForKey:@"bigBlind"] floatValue];
    useBlind = [[defaults objectForKey:@"useBlind"] intValue];
    showAICards = [[defaults objectForKey:@"showAICards"] intValue];
    showWinChance = [[defaults objectForKey:@"showChance"] intValue];
}

#pragma mark Deal Cards

-(void)deal2cards {
	NSLog(@"Deal 2 cards");
	// deal 2 cards to players
	for (int i=0; i< numberOfPlayers; i++) {
		Player *temp = [players objectAtIndex:i];
		[temp.playerHand addCard:[deck dealCard]];
		[temp.playerHand addCard:[deck dealCard]];
		
	}

   	[gameView display];
}


-(void)dealFlop {
	// deal flop
	NSLog(@"Deal Flop");
	[flop addObject:[deck dealCard]];
	[flop addObject:[deck dealCard]]; 
	[flop addObject:[deck dealCard]];
	for (int i=0;i<numberOfPlayers;i++)
	{
		Player *temp = [players objectAtIndex:i];
		[temp.playerHand addCard:[flop objectAtIndex:0]];
		[temp.playerHand addCard:[flop objectAtIndex:1]];
		[temp.playerHand addCard:[flop objectAtIndex:2]];
	}
	gameView.flop = flop;
    
	[gameView display];
	[self setPlayerChanceToWin];
}	
	
-(void)dealTurn {
	// deal the turn
	NSLog(@"Deal turn");
	[flop addObject:[deck dealCard]];
	for (int i=0;i<numberOfPlayers;i++)
	{
		Player *temp = [players objectAtIndex:i];
		[temp.playerHand addCard:[flop objectAtIndex:3]];
	}
	[gameView display];
    [self setPlayerChanceToWin];
	

}

-(void) dealRiver {
	// deal river
	NSLog(@"Deal River");
	
	[flop addObject:[deck dealCard]];
	for (int i=0;i<numberOfPlayers;i++)
	{
		Player *temp = [players objectAtIndex:i];
		[temp.playerHand addCard:[flop objectAtIndex:4]];
	}
	[gameView display];
    [self setPlayerChanceToWin];
}	
	


#pragma mark Start Hand hand or Game


-(void)openPlayersSheet {
    NSLog(@"aWindow = %@",aWindow);
    [NSApp beginSheet:playersSheet
     modalForWindow:aWindow
        modalDelegate:nil
       didEndSelector:NULL
          contextInfo:NULL];
}

-(IBAction)endPlayersSheet:(id) sender {
    numberOfPlayers = [numberOfPlayersText intValue];  

    [NSApp endSheet:playersSheet];
    [playersSheet orderOut:sender];

    [self setupDeckFlopPlayers];
    [gameView addPlayersToWindow:aWindow];	
    inGame = YES;
    [self startHand];
    

}

-(void)setupDeckFlopPlayers {
    
	// Set up the Deck
	
	[self setupNewDeck];
	if (flop) [flop release];
    
	flop = [[NSMutableArray alloc] init];
	
	// how many players?
	
    
	
	gameView.numberOfPlayers = numberOfPlayers;
	
	// create players
	players = [[NSMutableArray alloc] init];
	gameView.players = self.players;
	
	for ( int i=0;i<numberOfPlayers;i++) {
        Player *newPlayer;
        if (i==0) {
            newPlayer = [[Player alloc] init];
        } else {
            newPlayer = [[AIPlayer alloc] init];
        }
		newPlayer.name = [NSString stringWithFormat:@"Player %d",i+1];	
		newPlayer.gameView = gameView;
        newPlayer.money = startFunds;
		[players addObject:newPlayer];
		[newPlayer release];
		
	}
	
	((Player *)[players objectAtIndex:0]).name = [NSString stringWithFormat:@"Dealer"];
	
}	

-(void)setupNewDeck {
	// Set up the Deck
	if (deck) [deck release];
    
	deck = [[Deck alloc] init];
	[deck shuffle];
	
}




-(void)endHand {
    NSLog(@"endHand");
	// clear player hands and flop
	for (int i =0;i<numberOfPlayers;i++) {
		
		((Player *)[players objectAtIndex:i]).playerHand = [[[Hand alloc] init] autorelease];
	}
	[flop release];
	flop = [[NSMutableArray alloc] init];
	gameView.flop = flop;
	
	if (((numberOfPlayers*2)+5) > [deck.cards count]) { // do we have enough cards for another hand?
		NSLog(@"shuffling a new deck");
		[self setupNewDeck];
	}
	
	// any players out of money?
	for (int i = 0;i < [players count];i++) {
		Player *player = ((Player *)[players objectAtIndex:i]); 
		float pMoney = (player.money);
		
		if ( pMoney <= 0 ) {
			[gameView removePlayer:player fromWindow:aWindow];
			[players removeObjectAtIndex:i--];
			numberOfPlayers--;
		}
        
        	}
        if ([players count]==1) {
        [self playAgain];
    }

}

-(void)playAgain {
    NSLog(@"playAgain");
    int play = NSRunAlertPanel(@"Do You want to Play Again?",@"", @"Yes", @"Quit", nil);
    if (play==NSAlertDefaultReturn) {
        [self endGame];
        [self startGame];
    } else {
        [[NSApplication sharedApplication] terminate:self];
    }
}

-(void)endGame {
    NSLog(@"endGame");
	//remove remaining objects from window
    for (int i=0; i<[players count]; i++) {
        [gameView removePlayer:[players objectAtIndex:i] fromWindow:aWindow];
    }
	
	[gameView removeBoard];
    [gameView release];
    
    inGame = NO;

	
}	

-(void)startGame {
    
    NSLog(@"startGame");
	if (inGame == YES) {
        
        [self endGame];
        
    }
	gameView = [[GameView alloc] init];
	
    [self readDefaults];
    [self openPlayersSheet];


}

-(void)startHand { 
    NSLog(@"startHand");
    for (int i=0;i<[players count];i++) {
        [[players objectAtIndex:i] setLastBet:0];
    }
   	currentBet = -1.0;
	lastBet = -1.0;
	bettingPlayer = 0;
	nextStep = wDeal2Cards;
	[self deal2cards];
	nextStep += 1;
	allPlayersBet = NO;
    betType = wCheckOrBet;
    [self setPlayerChanceToWin];
	[gameView getBetFromPlayer:[players objectAtIndex:0] ofType:betType withCurrentBetOf:0];
}

#pragma mark Game Logic




-(void)gotBetFromPlayer:(Player *) player {
	
	
    // is bet from player we expect?
    if (player != [players objectAtIndex:bettingPlayer]) {
        NSLog(@"Error! wrong player Bet!");
        return;
    } 
	if ((player.currentBet>=lastBet) 
        && (player.currentBet>=minBet)
        && (player.currentBet<=maxBet))
    
    { 	// is bet valid?
  		currentBet = player.currentBet;
        if (currentBet>0) {
            betType=wCallOrRaise;
        }

		lastBet = currentBet;
		[self subtractMoneyFromPlayer:player];
        
		// advance to next betting player - if all players have bet, set flag and go back to player 0		
		if ((++bettingPlayer)==[players count]) {
			bettingPlayer = 0;
			allPlayersBet = YES;
		}
		
		if (allPlayersBet == YES) {
			if ([self betsAreSquare]) {
                betType = wCheckOrBet;
                [self advanceGame];
            }
			
        }   
            // if the hand isn't over, get bet from the next player
            if (nextStep!=wHandOver) {
            [[gameView statusOne] setStringValue:@""];
            [gameView getBetFromPlayer:[players objectAtIndex:bettingPlayer] ofType:betType withCurrentBetOf:currentBet];
        } 			
		
	} else { 
		// this is not a valid bet - notifiy player and get another bet
		[gameView invalidBet:lastBet];
		[gameView getBetFromPlayer:[players objectAtIndex:bettingPlayer] ofType:betType withCurrentBetOf:currentBet];
    }
} // gotBetFromPlayer

-(BOOL) betsAreSquare {
	BOOL square = TRUE;
	for (int i=1;i<[players count];i++) {
		if (  
			(((Player *)[players objectAtIndex:i]).currentBet) !=
			(((Player *)[players objectAtIndex:i-1]).currentBet)
			) {
			square = FALSE;
		}
	}
	
	return square;
}

-(void)determineWinner {
	NSLog(@"Determine Winner");  
	
	[gameView display];
	
	// create array of hands, and rank them

	NSMutableArray *allHands = [[NSMutableArray alloc] init];
	for (int i=0;i<numberOfPlayers;i++) {
		Player *thePlayer = [players objectAtIndex:i];
		[thePlayer.playerHand rank];
		[allHands addObject:thePlayer.playerHand];
	}
	
	
	
	// sort the array
	
	[allHands sortUsingSelector:@selector(compare:)];
	
	// loop through players
	// compare winning hand (last object in array) with players hand
	// if they are the same, that player is the winner
	
	int winner;
	for (winner = 0;([((Player*)[players objectAtIndex:winner]) getPlayerHand] != [allHands lastObject]); winner++ )
	{ 
		// NSLog(@"%d",winner); // this should be replaced with error handling code to prevent an infinite loop.
	}
	[allHands release];
	
	
	
	// give money to winner player		
	((Player *)[players objectAtIndex:winner]).money+= pot;
	
	pot = 0;
	[gameView updatePot:pot];
	[gameView winner:winner];
    [self playAgain];
	
}


-(void) subtractMoneyFromPlayer:(Player *) player {
    // subtract money from player
    
    float amt = player.currentBet-player.lastBet;
    
    if ( amt < player.money ) { // dont put more money in pot than player has
        player.money -= amt;
        pot += amt;
    } else {
        pot += player.money;
        player.money = 0;
    }
    player.lastBet = player.currentBet;
    [gameView updatePot:pot]; // display new pot amount	
    [player display];	
 
}
-(void) advanceGame {
    allPlayersBet = NO;
    bettingPlayer = 0;
    lastBet = -1.0;
    
    for (int i=0;i<[players count];i++) {
        [[players objectAtIndex:i] setLastBet:0];
    }
    
    switch (nextStep) {
        case wDealFlop:
            [self dealFlop];
            
            nextStep++;
            break;
        case wDealTurn:
            [self dealTurn];
            
            nextStep++;
            break;
        case wDealRiver:
            [self dealRiver];
            
            nextStep++;
            break;
        case wDetermineWinner:
            [self determineWinner];
            nextStep++;
            break;
        default:
            break;
    }
    
    
    

}

-(void) setPlayerChanceToWin {
    for (int i=0;i<numberOfPlayers;i++) { // outer loop to rate all players
        
        for (int j=0; j<numberOfPlayers; j++) { // in loop to rate a single player aganist all others
            if (i != j) {
                Thinker *thinker = [[Thinker alloc] initWithI:i andJ:j];
                [NSThread detachNewThreadSelector:@selector(think) toTarget:thinker withObject:nil];    
                }
            
            }
            
        }
        
    }

-(float) currentBet {
    return currentBet;
}

@end
