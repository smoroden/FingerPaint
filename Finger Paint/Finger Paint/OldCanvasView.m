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
@property (nonatomic) UIImage *cachedImage;

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
        
        

    }
    return self;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [[UIColor colorWithRed:0.309 green:0.521 blue:0.6 alpha:1] setStroke];
    
    [self.cachedImage drawInRect:rect];
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

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self cacheTheLines];
}

-(void)cacheTheLines {
    
    // We set a new context so that this doesn't get shown on the screen / the current lines are saved
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    
    // If we dont have a cache we need to make one
    if (self.cachedImage == nil) {
        // since it is the first time we make it start with a white square
        
        // set the size of the background properly
        UIBezierPath *backgroundPath = [UIBezierPath bezierPathWithRect:self.bounds];
        
        // set the fill to white
        [[UIColor whiteColor] setFill];
        
        // actually fill it
        [backgroundPath fill];
        
    }
    
    // draw the last cache image
    [self.cachedImage drawAtPoint:CGPointZero];
    
    // add the current path to the image
    [self.path stroke];
    
    // Save the image
    self.cachedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context so new stuff isn't painted on it.
    UIGraphicsEndImageContext();
    
}


@end
