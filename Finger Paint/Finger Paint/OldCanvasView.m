//
//  OldCanvasView.m
//  Finger Paint
//
//  Created by Zach Smoroden on 2016-05-13.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import "OldCanvasView.h"

@interface OldCanvasView ()

@property (nonatomic) UIBezierPath *path;

@end

@implementation OldCanvasView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setMultipleTouchEnabled:NO];
        [self setBackgroundColor:[UIColor whiteColor]];
        self.path = [UIBezierPath bezierPath];
        [self.path setLineWidth:2.0];
        
        [[UIColor colorWithRed:0.309 green:0.521 blue:0.6 alpha:1] setStroke];

    }
    return self;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self.path stroke];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    
    [self.path moveToPoint:p];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];

    [self.path addLineToPoint:p];
    
    [self setNeedsDisplay];
}


@end
