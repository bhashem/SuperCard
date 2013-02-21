//
//  SuperCardViewController.m
//  SuperCard
//
//  Created by Basil Hashem on 2/13/13.
//  Copyright (c) 2013 Basil Hashem. All rights reserved.
//

#import "SuperCardViewController.h"
#import "PlayingCardView.h"

@interface SuperCardViewController ()

@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;
@end

@implementation SuperCardViewController

- (void) setPlayingCardView:(PlayingCardView *)playingCardView
{
    _playingCardView = playingCardView;
    playingCardView.rank = 12;
    playingCardView.suit = @"♥";
    [playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:playingCardView action:@selector(pinch:)]];
}

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    
    [UIView transitionWithView:self.playingCardView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        self.playingCardView.faceUp = !self.playingCardView.faceUp;
                }
                    completion:NULL];
}
@end
