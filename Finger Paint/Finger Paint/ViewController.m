//
//  ViewController.m
//  Finger Paint
//
//  Created by Zach Smoroden on 2016-05-13.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import "ViewController.h"
#import "CanvasView.h"
#import "GHContextMenuView.h"

@interface ViewController () <GHContextOverlayViewDataSource, GHContextOverlayViewDelegate>


@property (strong, nonatomic) IBOutlet CanvasView *canvasView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    GHContextMenuView* overlay = [[GHContextMenuView alloc] init];
    overlay.dataSource = self;
    overlay.delegate = self;
    UILongPressGestureRecognizer* _longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:overlay action:@selector(longPressDetected:)];
    [self.view addGestureRecognizer:_longPressRecognizer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)longPress:(UILongPressGestureRecognizer *)sender {
    
}

// Implementing data source methods
- (NSInteger) numberOfMenuItems
{
    return 2;
}

-(UIImage*) imageForItemAtIndex:(NSInteger)index
{
    NSString* imageName = nil;
    switch (index) {
        case 0:
            imageName = @"ColorWheel";
            break;
        case 1:
            imageName = @"width.png";
            break;
            
        default:
            break;
    }
    return [UIImage imageNamed:imageName];
}
- (void) didSelectItemAtIndex:(NSInteger)selectedIndex forMenuAtPoint:(CGPoint)point
{
    NSString* msg = nil;
    switch (selectedIndex) {
        case 0:
            msg = @"Colour Wheel";
            break;
        case 1:
            msg = @"Width";
            break;
            
        default:
            break;
    }
    
    NSLog(@"%@", msg);
}



@end
