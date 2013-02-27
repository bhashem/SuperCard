//
//  SetCardView.h
//  SuperCard
//
//  Created by Basil Hashem on 2/26/13.
//  Copyright (c) 2013 Basil Hashem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

typedef enum {
    kFilled,
    kOutlined,
    kStriped
} ShadingType;

typedef enum {
    kRed,
    kGreen,
    kPurple
} ColorType;

typedef enum {
    kOval,
    kSquiggle,
    kDiamond
} SymbolType;

@property (nonatomic) NSUInteger number;
@property (nonatomic) SymbolType symbol;
@property (nonatomic) ShadingType shading;
@property (nonatomic) ColorType color;

//+ (NSArray *)validShapes;

@property (nonatomic) BOOL faceUp;

//- (void) pinch:(UIPinchGestureRecognizer *)gesture;

@end
