//
//  SetCardView.m
//  SuperCard
//
//  Created by Basil Hashem on 2/26/13.
//  Copyright (c) 2013 Basil Hashem. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView


// Drawing Functions
#define CORNER_RADIUS 12.0
#define SYMBOL_WIDTH 0.67
#define SYMBOL_HEIGHT 0.21

- (void) drawSymbol:(SymbolType)symbol
         atLocation:(CGPoint)location
         usingColor:(UIColor *)color
       usingShading:(ShadingType)shading
{
    UIBezierPath *symbolShape;
    CGPoint p1, p2, p3;
    CGSize symbolSize = CGSizeMake(self.bounds.size.width * SYMBOL_WIDTH, self.bounds.size.height * SYMBOL_HEIGHT);
    CGRect symbolRect = CGRectMake(location.x,location.y,
                                   symbolSize.width, symbolSize.height);
    
    if (symbol == kOval) {
        symbolShape = [UIBezierPath bezierPathWithRoundedRect:symbolRect cornerRadius:(0.5 * symbolRect.size.height)];
    }
    if (symbol == kDiamond) {
        symbolShape = [UIBezierPath bezierPath];
        [symbolShape moveToPoint:CGPointMake(location.x, location.y+0.5*symbolSize.height)];
        [symbolShape addLineToPoint:CGPointMake(location.x+0.5*symbolSize.width, location.y)];
        [symbolShape addLineToPoint:CGPointMake(location.x+symbolSize.width, location.y+0.5*symbolSize.height)];
        [symbolShape addLineToPoint:CGPointMake(location.x+0.5*symbolSize.width, location.y+symbolSize.height)];
        [symbolShape closePath];
    }
    if (symbol == kSquiggle) {
        symbolShape = [UIBezierPath bezierPath];
        
        p1 = CGPointMake(location.x, location.y+0.5*symbolSize.height);
        [symbolShape moveToPoint:p1];
        
        p1 = CGPointMake(location.x+0.33*symbolSize.width, location.y);
        p2 = CGPointMake(location.x, location.y);
        [symbolShape addQuadCurveToPoint:p1 controlPoint:p2];
        
        p1 = CGPointMake(location.x+1.0*symbolSize.width, location.y+0.0*symbolSize.height);
        p2 = CGPointMake(location.x+0.5*symbolSize.width, location.y+0.5*symbolSize.height);
        p3 = CGPointMake(location.x+1.0*symbolSize.width, location.y+0.5*symbolSize.height);
        [symbolShape addCurveToPoint:p1 controlPoint1:p2 controlPoint2:p3];

        p1 = CGPointMake(location.x+0.67*symbolSize.width, location.y+symbolSize.height);
        p2 = CGPointMake(location.x+symbolSize.width, location.y+symbolSize.height);
        [symbolShape addQuadCurveToPoint:p1 controlPoint:p2];

        p1 = CGPointMake(location.x, location.y+0.5*symbolSize.height);
        p2 = CGPointMake(location.x+0.3*symbolSize.width, location.y+0.5*symbolSize.height);
        p3 = CGPointMake(location.x+0.5*symbolSize.width, location.y+0.3*symbolSize.height);
        [symbolShape addCurveToPoint:p1 controlPoint1:p2 controlPoint2:p3];
    }
#define SYMBOL_LINE_WIDTH 0.05

    // OK, now decide on the fill
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    symbolShape.lineWidth = symbolSize.width * SYMBOL_LINE_WIDTH;

    [symbolShape addClip];

    // We stroke every time
    [color setStroke];
    symbolShape.lineWidth = symbolSize.width * SYMBOL_LINE_WIDTH;
    [symbolShape stroke];

    if (shading == kFilled) {
        [color setFill];
        UIRectFill(symbolRect);
    }
    if (shading == kStriped) {
        [color setStroke];
        CGContextRef context2 = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context2);
        UIBezierPath *stripes = [UIBezierPath bezierPath];

        for (int i = 1; i <= 20; i++) {
            p1 = CGPointMake(symbolRect.origin.x+i*(symbolSize.width/20), self.bounds.origin.y);
            [stripes moveToPoint:p1];
            p2 = CGPointMake(symbolRect.origin.x+i*(symbolSize.width/20), self.bounds.origin.y+self.bounds.size.height);
            [stripes addLineToPoint:p2];
        }
        [color setStroke];
        [stripes stroke];
        CGContextRestoreGState(context2);
    }
    CGContextRestoreGState(context);
}

- (void)drawRect:(CGRect)rect
{
    // Draw the card outline
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CORNER_RADIUS];
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];

    // Draw one symbol
    /*

    [self drawSymbol:kSquiggle
          atLocation:CGPointMake(self.bounds.size.width * ((1 - SYMBOL_WIDTH) / 2), self.bounds.size.height * (0.5 - (0.5 * SYMBOL_HEIGHT)))
          usingColor:[UIColor purpleColor]
        usingShading:kStriped];

    // Draw two symbols
    [self drawSymbol:kDiamond
          atLocation:CGPointMake(self.bounds.size.width * ((1 - SYMBOL_WIDTH) / 2),
                 self.bounds.size.height * (1-2*SYMBOL_HEIGHT-((1-3*SYMBOL_HEIGHT)/4))/2)
          usingColor:[UIColor blueColor]
        usingShading:kStriped];
    [self drawSymbol:kSquiggle
          atLocation:CGPointMake(self.bounds.size.width * ((1-SYMBOL_WIDTH)/2),
                 self.bounds.size.height * (1-2*SYMBOL_HEIGHT-((1-3*SYMBOL_HEIGHT)/4)/2)+SYMBOL_HEIGHT+((1-3*SYMBOL_HEIGHT)/4))
          usingColor:[UIColor greenColor]
        usingShading:kFilled];
*/

    // Draw three symbols
    [self drawSymbol:kOval
          atLocation:CGPointMake(self.bounds.size.width * ((1-SYMBOL_WIDTH)/2),
                 self.bounds.size.height * ((1 - (3 * SYMBOL_HEIGHT))/4))
          usingColor:[UIColor blueColor]
        usingShading:kStriped];
    [self drawSymbol:kDiamond
          atLocation:CGPointMake(self.bounds.size.width * ((1 - SYMBOL_WIDTH) / 2),
                    self.bounds.size.height * (0.5 - (0.5 * SYMBOL_HEIGHT)))
          usingColor:[UIColor redColor]
        usingShading:kFilled];
    [self drawSymbol:kSquiggle
          atLocation:CGPointMake(self.bounds.size.width * ((1 - SYMBOL_WIDTH) / 2),
                 self.bounds.size.height * (1 - ((1 - (3 * SYMBOL_HEIGHT))/4) - SYMBOL_HEIGHT))
          usingColor:[UIColor yellowColor]
        usingShading:kOutlined];
}


// Setters for Set Card object
-(void)setNumber:(NSUInteger)number
{
    _number = number;
    [self setNeedsDisplay];
}

-(void)setSymbol:(SymbolType)symbol
{
    _symbol = symbol;
    [self setNeedsDisplay];
}

-(void)setShading:(ShadingType)shading
{
    _shading = shading;
    [self setNeedsDisplay];
}

-(void)setColor:(ColorType)color
{
    _color = color;
    [self setNeedsDisplay];
}

-(void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}


// View utility functions
-(void)setup
{
    // do initialization here
}

-(void)awakeFromNib
{
    [self setup];
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}


@end
