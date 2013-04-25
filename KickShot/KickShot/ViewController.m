//
//  ViewController.m
//  KickShot
//
//  Created by Austin on 3/27/13.
//  Copyright (c) 2013 Austin Enfield. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize MainLabel;
@synthesize hScoreLabel;
@synthesize aScoreLabel;
@synthesize HomePitch;
@synthesize AwayPitch;
@synthesize LeftCard;
@synthesize CenterCard;
@synthesize RightCard;
@synthesize WinLabel;
@synthesize EndButtonQualities;

@synthesize hPass, aPass, hIntercept, aIntercept;
@synthesize hGBRight, hGBLeft, hGSRight, hGSLeft;
@synthesize aGBRight, aGBLeft, aGSRight, aGSLeft;
@synthesize oDirectFreeKick;


- (void)viewDidLoad
{
    hPass = [UIImage imageNamed:@"Pass.jpg"];
    aPass = [UIImage imageNamed:@"Pass2.jpg"];
    
    hIntercept = [UIImage imageNamed:@"Intercept.jpg"];
    aIntercept = [UIImage imageNamed:@"Intercept2.jpg"];
    
    hGBRight = [UIImage imageNamed:@"GoalBlocked4.jpg" ];
    hGBLeft = [UIImage imageNamed:@"GoalBlocked3.jpg" ];
    aGBRight = [UIImage imageNamed:@"GoalBlocked2.jpg" ];
    aGBLeft = [UIImage imageNamed:@"GoalBlocked1.jpg" ];
    
    hGSRight = [UIImage imageNamed:@"GoalShot1.jpg"];
    hGSLeft = [UIImage imageNamed:@"GoalShot2.jpg"];
    aGSRight = [UIImage imageNamed:@"GoalShot3.jpg"];
    aGSLeft = [UIImage imageNamed:@"GoalShot4.jpg"];
    
    oDirectFreeKick = [UIImage imageNamed:@"DirectFreeKick.jpg"];
    
    
    game = [[Game alloc]init];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PlayCardButton:(UIButton *)sender {
    //MainLabel.text = @"Play Button Hit";
    [game playActive];
    [self updateGraphics];
    if(game.checkWin)
    {
        HomePitch.hidden = true;
        AwayPitch.hidden = true;
        EndButtonQualities.hidden = false;
        if(game.hScore == game.aScore)
        {
            int temp = rand()%1;
            if(temp == 0)
                game.hScore++;
            else
                game.aScore++;
        }
        if(game.hScore>game.aScore)
        {
            NSString * temp = [[NSString alloc]initWithFormat:(@"Congratulations Player 1 Wins!")];
            WinLabel.text = temp;
        }
        else
        {
            NSString * temp = [[NSString alloc]initWithFormat:(@"Congratulations Player 2 Wins!")];
            WinLabel.text = temp;
        }
    }
}

- (IBAction)SkipButton:(UIButton *)sender {
    //MainLabel.text = @"Skip Button Hit";
    [game skipTurn];
    [self updateGraphics];
}

- (IBAction)SwipeRightGesture:(UISwipeGestureRecognizer *)sender {
    //MainLabel.text = @"swipe right";
    if(game.activeCard > 0)
        game.activeCard--;
    [self updateGraphics];
}

- (IBAction)SwipeLeftGesture:(UISwipeGestureRecognizer *)sender {
    //MainLabel.text = @"swipe left";
    if(game.activeCard < 6)
        game.activeCard++;
    [self updateGraphics];
}

- (IBAction)PlayButton:(UIButton *)sender {
    [self updateGraphics];
}

- (IBAction)EndButton:(UIButton *)sender {
}

- (void) updateGraphics
{
    NSString *hscore =[[NSString alloc]initWithFormat:(@"Home: %i"),game.hScore];
    hScoreLabel.text = hscore;
    NSString *ascore =[[NSString alloc]initWithFormat:(@"Away: %i"),game.aScore];
    aScoreLabel.text = ascore;
    if(game.isHomeBall)
    {
        HomePitch.hidden = false;
        AwayPitch.hidden = true;
    }
    else
    {
        HomePitch.hidden = true;
        AwayPitch.hidden = false;
    }
    int ball = game.ballPosition;
    if (ball == 0)
    {
        NSString * ballPosition = [[NSString alloc]initWithFormat:(@"Rolled:%d,%d Ball on the center line"),game.roll1,game.roll2];
        MainLabel.text = ballPosition;
    }
    else if (ball > 0)
    {
        NSString * ballPosition = [[NSString alloc]initWithFormat:(@"Rolled:%d,%d Ball on Away %d line"),game.roll1,game.roll2,12-ball];
        MainLabel.text = ballPosition;
    }
    else
    {
        
        NSString * ballPosition = [[NSString alloc]initWithFormat:(@"Rolled:%d,%d Ball on Home %d line"),game.roll1,game.roll2,12+ball];
        MainLabel.text = ballPosition;
        
    }
    [self updateCards];
    
}

- (void) updateCards
{
    int tempL, tempC, tempR;
    if(game.Player1Active)
    {
        switch (game.activeCard) {
            case 0:
                tempL = endCName;
                tempC = [game hDeck:0];
                tempR = [game hDeck:1];
                break;
            case 1:
                tempL = [game hDeck:0];
                tempC = [game hDeck:1];
                tempR = [game hDeck:2];
                break;
            case 2:
                tempL = [game hDeck:1];
                tempC = [game hDeck:2];
                tempR = [game hDeck:3];
                break;
            case 3:
                tempL = [game hDeck:2];
                tempC = [game hDeck:3];
                tempR = [game hDeck:4];
                break;
            case 4:
                tempL = [game hDeck:3];
                tempC = [game hDeck:4];
                if(game.oDeckRemaining>1)
                    tempR = [game oDeck:0];
                else
                    tempR = [game hDeck:5];
                break;
            case 5:
                NSLog(@"ther are how many in hDeck?: %d",game.hDeckRemaining);
                tempL = [game hDeck:4];
                if(game.oDeckRemaining>1)
                    tempC = [game oDeck:0];
                else
                    tempC = [game hDeck:5];
                if(game.oDeckRemaining>1)
                    tempR = [game oDeck:1];
                else if(game.oDeckRemaining>0)
                {
                    tempR = [game oDeck:0];
                }
                else
                {
                    tempR = [game hDeck:6];
                }
                break;
            case 6:
                NSLog(@"ther are how many remaining?: %d",game.oDeckRemaining);
                if(game.oDeckRemaining>1)
                    tempL = [game oDeck:0];
                else
                    tempL = [game hDeck:5];
                if(game.oDeckRemaining>1)
                    tempC = [game oDeck:1];
                else if(game.oDeckRemaining>0)
                {
                    tempC = [game oDeck:0];
                }
                else
                {
                    tempC = [game hDeck:6];
                }
                tempR = endCName;
                break;
            default:
                tempL = tempC = tempR = 0;
                break;
        }
        switch (tempR) {
            case pass:
                RightCard.image = hPass;
                break;
            case intercept:
                RightCard.image = hIntercept;
                break;
            case goalShotRight:
                RightCard.image = hGSRight;
                break;
            case goalShotLeft:
                RightCard.image = hGSLeft;
                break;
            case goalBlockedRight:
                RightCard.image = hGBRight;
                break;
            case goalBlockedLeft:
                RightCard.image = hGBLeft;
                break;
            case directFreeKick:
                RightCard.image = oDirectFreeKick;
                break;
            default:
                RightCard.image = Nil;
                break;
        }
        switch (tempC) {
            case pass:
                CenterCard.image = hPass;
                break;
            case intercept:
                CenterCard.image = hIntercept;
                break;
            case goalShotRight:
                CenterCard.image = hGSRight;
                break;
            case goalShotLeft:
                CenterCard.image = hGSLeft;
                break;
            case goalBlockedRight:
                CenterCard.image = hGBRight;
                break;
            case goalBlockedLeft:
                CenterCard.image = hGBLeft;
                break;
            case directFreeKick:
                CenterCard.image = oDirectFreeKick;
                break;
            default:
                CenterCard.image = Nil;
                break;
        }
        switch (tempL) {
            case pass:
                LeftCard.image = hPass;
                break;
            case intercept:
                LeftCard.image = hIntercept;
                break;
            case goalShotRight:
                LeftCard.image = hGSRight;
                break;
            case goalShotLeft:
                LeftCard.image = hGSLeft;
                break;
            case goalBlockedRight:
                LeftCard.image = hGBRight;
                break;
            case goalBlockedLeft:
                LeftCard.image = hGBLeft;
                break;
            case directFreeKick:
                LeftCard.image = oDirectFreeKick;
                break;
            default:
                LeftCard.image = Nil;
                break;
        }
    }
    else
    {
        switch (game.activeCard) {
            case 0:
                tempL = endCName;
                tempC = [game aDeck:0];
                tempR = [game aDeck:1];
                break;
            case 1:
                tempL = [game aDeck:0];
                tempC = [game aDeck:1];
                tempR = [game aDeck:2];
                break;
            case 2:
                tempL = [game aDeck:1];
                tempC = [game aDeck:2];
                tempR = [game aDeck:3];
                break;
            case 3:
                tempL = [game aDeck:2];
                tempC = [game aDeck:3];
                tempR = [game aDeck:4];
                break;
            case 4:
                tempL = [game aDeck:3];
                tempC = [game aDeck:4];
                if(game.oDeckRemaining>1)
                    tempR = [game oDeck:0];
                else
                    tempR = [game aDeck:5];
                break;
            case 5:
                NSLog(@"ther are how many in aDeck?: %d",game.aDeckRemaining);
                tempL = [game aDeck:4];
                if(game.oDeckRemaining>1)
                    tempC = [game oDeck:0];
                else
                    tempC = [game aDeck:5];
                if(game.oDeckRemaining>1)
                    tempR = [game oDeck:1];
                else if(game.oDeckRemaining>0)
                {
                    tempR = [game oDeck:0];
                }
                else
                {
                    tempR = [game aDeck:6];
                }
                break;
            case 6:
                NSLog(@"ther are how many remaining?: %d",game.oDeckRemaining);
                if(game.oDeckRemaining>1)
                    tempL = [game oDeck:0];
                else
                    tempL = [game aDeck:5];
                if(game.oDeckRemaining>1)
                    tempC = [game oDeck:1];
                else if(game.oDeckRemaining>0)
                {
                    tempC = [game oDeck:0];
                }
                else
                {
                    tempC = [game aDeck:6];
                }
                tempR = endCName;
                break;
            default:
                tempL = tempC = tempR = 0;
                break;
        }
        switch (tempR) {
            case pass:
                RightCard.image = aPass;
                break;
            case intercept:
                RightCard.image = aIntercept;
                break;
            case goalShotRight:
                RightCard.image = aGSRight;
                break;
            case goalShotLeft:
                RightCard.image = aGSLeft;
                break;
            case goalBlockedRight:
                RightCard.image = aGBRight;
                break;
            case goalBlockedLeft:
                RightCard.image = aGBLeft;
                break;
            case directFreeKick:
                RightCard.image = oDirectFreeKick;
                break;
            default:
                RightCard.image = Nil;
                break;
        }
        switch (tempC) {
            case pass:
                CenterCard.image = aPass;
                break;
            case intercept:
                CenterCard.image = aIntercept;
                break;
            case goalShotRight:
                CenterCard.image = aGSRight;
                break;
            case goalShotLeft:
                CenterCard.image = aGSLeft;
                break;
            case goalBlockedRight:
                CenterCard.image = aGBRight;
                break;
            case goalBlockedLeft:
                CenterCard.image = aGBLeft;
                break;
            case directFreeKick:
                CenterCard.image = oDirectFreeKick;
                break;
            default:
                CenterCard.image = Nil;
                break;
        }
        switch (tempL) {
            case pass:
                LeftCard.image = aPass;
                break;
            case intercept:
                LeftCard.image = aIntercept;
                break;
            case goalShotRight:
                LeftCard.image = aGSRight;
                break;
            case goalShotLeft:
                LeftCard.image = aGSLeft;
                break;
            case goalBlockedRight:
                LeftCard.image = aGBRight;
                break;
            case goalBlockedLeft:
                LeftCard.image = aGBLeft;
                break;
            case directFreeKick:
                LeftCard.image = oDirectFreeKick;
                break;
            default:
                LeftCard.image = Nil;
                break;
        }
    }
    
}

@end
