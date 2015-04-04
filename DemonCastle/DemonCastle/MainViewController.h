//
//  MainViewController.h
//  myFirstGame
//
//  Created by macbook on 13-4-24.
//  Copyright (c) 2013年 QianKang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCPathButton.h"

@class CAEmitterLayer;
@interface MainViewController : UIViewController<DCPathButtonDelegate>{
    DCPathButton *dcPathButton;
    CATextLayer *tipLary;
    UIButton *load1Button;
    UIButton *load2Button;
    UIButton *load3Button;
    UIImageView *magicCircle;
}
@property (strong) CAEmitterLayer *fireEmitter;
@property (strong) CAEmitterLayer *smokeEmitter;
@property (strong) CAEmitterLayer *heartsEmitter;
- (void) setFireAmount:(float)zeroToOne withAngle:(float)angle;
@end

