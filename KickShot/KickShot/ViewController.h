//
//  ViewController.h
//  KickShot
//
//  Created by Austin on 3/27/13.
//  Copyright (c) 2013 Austin Enfield. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "Game.h"

@interface ViewController : UIViewController
{
    Game * game;
    
    IBOutlet UIImage *hPass, *aPass, *hIntercept, *aIntercept;
    IBOutlet UIImage *hGBRight, *hGBLeft, *hGSRight, *hGSLeft;
    IBOutlet UIImage *aGBRight, *aGBLeft, *aGSRight, *aGSLeft;
    IBOutlet UIImage *oDirectFreeKick;
    
}
@property (weak, nonatomic) IBOutlet UILabel *MainLabel;
@property (weak, nonatomic) IBOutlet UILabel *hScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *aScoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *HomePitch;
@property (weak, nonatomic) IBOutlet UIImageView *AwayPitch;
@property (weak, nonatomic) IBOutlet UIButton *EndGameButton;
@property (weak, nonatomic) IBOutlet UILabel *WinLabel;

@property (weak, nonatomic) IBOutlet UIImageView *LeftCard;
@property (weak, nonatomic) IBOutlet UIImageView *CenterCard;
@property (weak, nonatomic) IBOutlet UIImageView *RightCard;
@property (weak, nonatomic) IBOutlet UIButton *EndButtonQualities;

@property (nonatomic, retain) UIImage *hPass, *aPass, *hIntercept, *aIntercept;
@property (nonatomic, retain) UIImage *hGBRight, *hGBLeft, *hGSRight, *hGSLeft;
@property (nonatomic, retain) UIImage *aGBRight, *aGBLeft, *aGSRight, *aGSLeft;
@property (nonatomic, retain) UIImage *oDirectFreeKick;



- (IBAction)PlayCardButton:(UIButton *)sender;
- (IBAction)SkipButton:(UIButton *)sender;
- (IBAction)SwipeRightGesture:(UISwipeGestureRecognizer *)sender;
- (IBAction)SwipeLeftGesture:(UISwipeGestureRecognizer *)sender;
- (IBAction)PlayButton:(UIButton *)sender;
- (IBAction)EndButton:(UIButton *)sender;


- (void) updateGraphics;
- (void) updateCards;

@end
