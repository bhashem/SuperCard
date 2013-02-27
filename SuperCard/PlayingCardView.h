//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Basil Hashem on 2/13/13.
//  Copyright (c) 2013 Basil Hashem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong,nonatomic) NSString *suit;

@property (nonatomic) BOOL faceUp;

- (void) pinch:(UIPinchGestureRecognizer *)gesture;

@end
