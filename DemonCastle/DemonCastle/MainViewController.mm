//
//  MainViewController.m
//  myFirstGame
//
//  Created by macbook on 13-4-24.
//  Copyright (c) 2013年 QianKang. All rights reserved.
//
#import "MainViewController.h"
#import <QuartzCore/CoreAnimation.h>
#import "MCSteamView.h"
#import "LEffectLabel.h"
#import "URBAlertView.h"
#import "UIImage (scale).h"

#import "SaveAndLoad.h"
#import "HelpViewController.h"
#import "GameScene0.h"
#import "GameScene3.h"

@interface MainViewController()
@property (nonatomic, strong) URBAlertView *alertView;
@end

@implementation MainViewController

@synthesize fireEmitter;
@synthesize smokeEmitter;
@synthesize heartsEmitter;

#pragma mark -
#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithWhite:0.1 alpha:0.1];
    UIImageView *mainMenuBackground=[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"mainMenuBackground.jpg"] scaleToSize:CGSizeMake(480, 320)]];
    mainMenuBackground.alpha=0.4;
    [self.view addSubview:mainMenuBackground];
    //--------------------------------------------------------------------------------------
    CGRect sidaiFrame = CGRectMake(200,0,361,600);
    UIView *sidai = [[UIView alloc]initWithFrame:sidaiFrame];
    [sidai setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"vampire.png"]]];
    sidai.alpha=0.4;
    sidai.tag=4;
    UIView *sidai1 = [[UIView alloc]initWithFrame:sidaiFrame];
    [sidai1 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"vampire.png"]]];
    sidai1.alpha=0.3;
    sidai1.tag=5;
    UIView *sidai2 = [[UIView alloc]initWithFrame:sidaiFrame];
    [sidai2 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"vampire.png"]]];
    sidai2.alpha=0.2;
    sidai2.tag=6;

    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:2.0];
    [[sidai viewWithTag:4] setAlpha:0.2];
    [[sidai viewWithTag:4] setTransform:CGAffineTransformMakeTranslation(50, 0)];
    [[sidai1 viewWithTag:5] setAlpha:0.0];
    [[sidai1 viewWithTag:5] setTransform:CGAffineTransformMakeTranslation(25, 0)];
    [[sidai2 viewWithTag:6] setAlpha:0.0];
    [[sidai2 viewWithTag:6] setTransform:CGAffineTransformMakeTranslation(0, 0)];
    [UIView commitAnimations];
    
    [self.view addSubview:sidai2];
    [self.view addSubview:sidai1];
    [self.view addSubview:sidai];
    //--------------------------------------------------------------------------------------
	CGRect viewBounds = self.view.layer.bounds;
	// Create the emitter layers
	self.fireEmitter	= [CAEmitterLayer layer];
	self.smokeEmitter	= [CAEmitterLayer layer];
	
	// Place layers just above the tab bar
	self.fireEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0-100, viewBounds.size.height -300);
	self.fireEmitter.emitterSize	= CGSizeMake(viewBounds.size.width/2.0, 0);
	self.fireEmitter.emitterMode	= kCAEmitterLayerOutline;
	self.fireEmitter.emitterShape	= kCAEmitterLayerLine;
	// with additive rendering the dense cell distribution will create "hot" areas
	self.fireEmitter.renderMode		= kCAEmitterLayerAdditive;
	
	self.smokeEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0-100, viewBounds.size.height -300);
	self.smokeEmitter.emitterMode	= kCAEmitterLayerPoints;
	
	// Create the fire emitter cell
	CAEmitterCell* fire = [CAEmitterCell emitterCell];
	[fire setName:@"fire"];
    
	fire.birthRate			= 100;
	fire.emissionLongitude  = M_PI/2;
	fire.velocity			= -80;
	fire.velocityRange		= 30;
	fire.emissionRange		= 1.1;
	fire.yAcceleration		= -200;
	fire.scaleSpeed			= 0.3;
	fire.lifetime			= 50;
	fire.lifetimeRange		= (50.0 * 0.35);
    
	fire.color = [[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1] CGColor];
	fire.contents = (id) [[UIImage imageNamed:@"DazFire"] CGImage];
	
	// Create the smoke emitter cell
	CAEmitterCell* smoke = [CAEmitterCell emitterCell];
	[smoke setName:@"smoke"];
    
	smoke.birthRate			= 11;
	smoke.emissionLongitude = -M_PI/2;
	smoke.lifetime			= 10;
	smoke.velocity			= -40;
	smoke.velocityRange		= 20;
	smoke.emissionRange		= M_PI/4;
	smoke.spin				= 1;
	smoke.spinRange			= 6;
	smoke.yAcceleration		= -160;
	smoke.contents			= (id) [[UIImage imageNamed:@"DazSmoke"] CGImage];
	smoke.scale				= 0.1;
	smoke.alphaSpeed		= -0.12;
	smoke.scaleSpeed		= 0.7;
	
	// Add the smoke emitter cell to the smoke emitter layer
	self.smokeEmitter.emitterCells	= [NSArray arrayWithObject:smoke];
	self.fireEmitter.emitterCells	= [NSArray arrayWithObject:fire];
	[self.view.layer addSublayer:self.smokeEmitter];
	[self.view.layer addSublayer:self.fireEmitter];
	
	[self setFireAmount:0.5 withAngle:M_PI];
    //---------------------------------------------------------------------------------------
    // Configure the particle emitter to the top edge of the screen
	CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
	snowEmitter.emitterPosition = CGPointMake(self.view.bounds.size.width / 2.0, -30);
	snowEmitter.emitterSize		= CGSizeMake(self.view.bounds.size.width * 2.0, 0.0);;
	
	// Spawn points for the flakes are within on the outline of the line
	snowEmitter.emitterMode		= kCAEmitterLayerOutline;
	snowEmitter.emitterShape	= kCAEmitterLayerLine;
	
	// Configure the snowflake emitter cell
	CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
	
	snowflake.birthRate		= 1.0;
	snowflake.lifetime		= 120.0;
	
	snowflake.velocity		= -10;				// falling down slowly
	snowflake.velocityRange = 20;
	snowflake.yAcceleration = 2;
	snowflake.emissionRange = 0.5 * M_PI;		// some variation in angle
	snowflake.spinRange		= 0.25 * M_PI;		// slow spin
	
	snowflake.contents		= (id) [[UIImage imageNamed:@"DazFlake"] CGImage];
	snowflake.color			= [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:0.095] CGColor];
    
	// Make the flakes seem inset in the background
	snowEmitter.shadowOpacity = 1.0;
	snowEmitter.shadowRadius  = 0.0;
	snowEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
	snowEmitter.shadowColor   = [[UIColor whiteColor] CGColor];
	
	// Add everything to our backing layer below the UIContol defined in the storyboard
	snowEmitter.emitterCells = [NSArray arrayWithObject:snowflake];
	[self.view.layer insertSublayer:snowEmitter atIndex:0];
    //---------------------------------------------------------------------------------------
    // Configure the particle emitter
    CGRect candiFrame = CGRectMake(35,170,50,180);
    UIView *candi = [[UIView alloc]initWithFrame:candiFrame];
    [candi setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"candi.png"] scaleToSize:CGSizeMake(50,180)]]];
    candi.alpha=0.5;
    [self.view addSubview:candi];
    
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
	likeButton.frame = CGRectMake(40,210,40,120);
	self.heartsEmitter = [CAEmitterLayer layer];
	self.heartsEmitter.emitterPosition = CGPointMake(likeButton.frame.origin.x + likeButton.frame.size.width/2.0-100,
													 likeButton.frame.origin.y + likeButton.frame.size.height/2.0);
	self.heartsEmitter.emitterSize = likeButton.bounds.size;
	
	// Spawn points for the hearts are within the area defined by the button frame
	self.heartsEmitter.emitterMode = kCAEmitterLayerVolume;
	self.heartsEmitter.emitterShape = kCAEmitterLayerRectangle;
	self.heartsEmitter.renderMode = kCAEmitterLayerAdditive;
	
	// Configure the emitter cell
	CAEmitterCell *heart = [CAEmitterCell emitterCell];
	heart.name = @"heart";
	
	heart.emissionLongitude = M_PI/1.1; // up
	heart.emissionRange = 0.25 * M_PI;  // in a wide spread
	heart.birthRate		= 0.0;			// emitter is deactivated for now
	heart.lifetime		= 10.0;			// hearts vanish after 10 seconds
    
	heart.velocity		= -120;			// particles get fired up fast
	heart.velocityRange = 120;			// with some variation
	heart.yAcceleration = 10;			// but fall eventually
	
	heart.contents		= (id) [[UIImage imageNamed:@"DazHeart"] CGImage];
	heart.color			= [[UIColor colorWithRed:1 green:0.5 blue:0.5 alpha:0.2] CGColor];
	heart.redRange		= 0.3;			// some variation in the color
	heart.blueRange		= 0.3;
	heart.alphaSpeed	= -0.5 / heart.lifetime;  // fade over the lifetime

	heart.scale			= 0.15;			// let them start small
	heart.scaleSpeed	= 0.5;			// but then 'explode' in size
	heart.spinRange		= 2.0 * M_PI;	// and send them spinning from -180 to +180 deg/s
	
    // Add everything to our backing layer
	self.heartsEmitter.emitterCells = [NSArray arrayWithObject:heart];
	[self.view.layer addSublayer:heartsEmitter];
//    [likeButton setTitle:@"" forState:UIControlStateNormal];
//	  [likeButton addTarget:self action:@selector(showHeart) forControlEvents:UIControlEventTouchUpInside];
//    likeButton.layer.cornerRadius=10;
//    [self.view addSubview:likeButton];
    
    //-----------------------------------------------------------------------------------------
    //全屏雾效果
//    CGRect frame1 = CGRectMake(0,250,320,10);
//    MCSteamView * steamView1 = [[MCSteamView alloc] initWithFrame:frame1];
//    [self.view addSubview:steamView1];
    //-----------------------------------------------------------------------------------------
    LEffectLabel *effectLabel = [[LEffectLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 10)];
    [self.view addSubview:effectLabel];
    effectLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    effectLabel.font =[UIFont italicSystemFontOfSize:30];
    effectLabel.text = @"晓月圆舞曲";
    
    effectLabel.textColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.8];
    effectLabel.effectColor = [UIColor whiteColor];
    //effectLabel.effectDirection = EffectDirectionTopLeftToBottomRight;
    effectLabel.effectDirection = 3;
    
    effectLabel.center = CGPointMake(240, 50);
    
    for (int i = 0; i <64; i++)
    {
        int64_t delayInSeconds = 3 * i;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            effectLabel.effectDirection =i%8;
            [effectLabel performEffectAnimation];
        });
    }    
    //-----------------------------------------------------------------------------------------
    tipLary = [CATextLayer layer];
    tipLary.bounds = CGRectMake(0, 0, 320, 20);
    tipLary.fontSize = 14.f; //字体的大小
    tipLary.alignmentMode = kCAAlignmentCenter;//字体的对齐方式
    tipLary.position = CGPointMake(240, 280);
    tipLary.foregroundColor = [UIColor whiteColor].CGColor;//字体的颜色
    tipLary.hidden=NO;
    [self.view.layer addSublayer:tipLary];
    
    for (int i = 0; i <301; i++)
    {
        int64_t delayInSeconds = 1 * i;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if(i%2==0){tipLary.string = @"点击火焰继续";}
            else if(i%2==1){tipLary.string = @"";}
        });
    }
    //-----------------------------------------------------------------------------------------
    dcPathButton = [[DCPathButton alloc]
                    initDCPathButtonWithSubButtons:3
                    totalRadius:80
                    centerRadius:25
                    subRadius:20
                    centerImage:@""
                    centerBackground:nil
                    subImages:^(DCPathButton *dc){
                        [dc subButtonImage:@"dc-button_2" withTag:0];
                        [dc subButtonImage:@"dc-button_4" withTag:1];
                        [dc subButtonImage:@"dc-button_1" withTag:2];
                    }
                    subImageBackground:nil
                    inLocationX:60 locationY:170 toParentView:self.view];
    dcPathButton.delegate = self;
    dcPathButton.hidden=NO;
    dcPathButton.alpha=0.6;
    //------自定义---------------------------------------------------------------------------------------
    CGRect buttonFrame = CGRectMake(0,0,100,50);
    dcPathButton.startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dcPathButton.startButton.frame = CGRectMake(120,80, CGRectGetWidth(buttonFrame), CGRectGetHeight(buttonFrame));
    dcPathButton.startButton.alpha=0.8;
    [dcPathButton.startButton setTitle:@"新的开始" forState:UIControlStateNormal];
    [dcPathButton.startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dcPathButton.startButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [dcPathButton.startButton addTarget:dcPathButton.delegate action:@selector(button_0_action) forControlEvents:UIControlEventTouchUpInside];
    dcPathButton.loadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dcPathButton.loadButton.frame = CGRectMake(120,145, CGRectGetWidth(buttonFrame), CGRectGetHeight(buttonFrame));
    dcPathButton.loadButton.alpha=0.8;
    [dcPathButton.loadButton setTitle:@"读取记忆" forState:UIControlStateNormal];
    [dcPathButton.loadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dcPathButton.loadButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [dcPathButton.loadButton addTarget:dcPathButton.delegate action:@selector(button_1_action) forControlEvents:UIControlEventTouchUpInside];
    dcPathButton.helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dcPathButton.helpButton.frame = CGRectMake(120,210, CGRectGetWidth(buttonFrame), CGRectGetHeight(buttonFrame));
    dcPathButton.helpButton.alpha=0.8;
    [dcPathButton.helpButton setTitle:@"操作说明" forState:UIControlStateNormal];
    [dcPathButton.helpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dcPathButton.helpButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [dcPathButton.helpButton addTarget:dcPathButton.delegate action:@selector(button_2_action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dcPathButton.startButton];
    [self.view addSubview:dcPathButton.loadButton];
    [self.view addSubview:dcPathButton.helpButton];
    dcPathButton.startButton.hidden=YES;
    dcPathButton.loadButton.hidden=YES;
    dcPathButton.helpButton.hidden=YES;
    //---------------------------------------------------------------------------------------------------
    magicCircle=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"magicCircle.png"]];
    [magicCircle setCenter:CGPointMake(360, 170)];
    [magicCircle setBounds:CGRectMake(0, 0, 300, 225)];
    magicCircle.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [self.view addSubview:magicCircle];
    magicCircle.transform = CGAffineTransformMakeRotation(0.0);
    magicCircle.alpha=0.5;
    magicCircle.hidden=YES;
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
    //---------------------------------------------------------------------------------------------------
    load1Button = [UIButton buttonWithType:UIButtonTypeCustom];
    load1Button.frame = CGRectMake(300,80, 120, 50);
    load1Button.alpha=0.8;
    [load1Button setTitle:@"记忆一" forState:UIControlStateNormal];
    [load1Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [load1Button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [load1Button addTarget:self action:@selector(loadMemory1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:load1Button];
    load2Button = [UIButton buttonWithType:UIButtonTypeCustom];
    load2Button.frame = CGRectMake(300,145, 120, 50);
    load2Button.alpha=0.8;
    [load2Button setTitle:@"记忆二" forState:UIControlStateNormal];
    [load2Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [load2Button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [load2Button addTarget:self action:@selector(loadMemory2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:load2Button];
    load3Button = [UIButton buttonWithType:UIButtonTypeCustom];
    load3Button.frame = CGRectMake(300,210, 120, 50);
    load3Button.alpha=0.8;
    [load3Button setTitle:@"记忆三" forState:UIControlStateNormal];
    [load3Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [load3Button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [load3Button addTarget:self action:@selector(loadMemory3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:load3Button];
    load1Button.hidden=YES;
    load2Button.hidden=YES;
    load3Button.hidden=YES;
}

float angle=0.0;
- (void) handleTimer: (NSTimer *) timer
{
    angle += 0.01;
    if (angle > 6.283) {angle = 0;}
    [magicCircle setTransform:CGAffineTransformMakeRotation(angle)];
}
#pragma mark -
#pragma mark Interaction
- (void) setFireAmount:(float)zeroToOne withAngle:(float)angle
{
	// Update the fire properties
	[self.fireEmitter setValue:[NSNumber numberWithInt:(zeroToOne * 500)]
					forKeyPath:@"emitterCells.fire.birthRate"];
	[self.fireEmitter setValue:[NSNumber numberWithFloat:zeroToOne]
					forKeyPath:@"emitterCells.fire.lifetime"];
	[self.fireEmitter setValue:[NSNumber numberWithFloat:(zeroToOne * 0.35)]
					forKeyPath:@"emitterCells.fire.lifetimeRange"];
	[self.fireEmitter setValue:[NSNumber numberWithFloat:(angle)]
					forKeyPath:@"emitterCells.fire.emissionLongitude"];
    self.fireEmitter.emitterSize = CGSizeMake(50 * zeroToOne, 0);
	[self.smokeEmitter setValue:[NSNumber numberWithInt:zeroToOne * 4]
					 forKeyPath:@"emitterCells.smoke.lifetime"];
	[self.smokeEmitter setValue:(id)[[UIColor colorWithRed:1 green:1 blue:1 alpha:zeroToOne * 0.3] CGColor]
					 forKeyPath:@"emitterCells.smoke.color"];
}

- (void) showHeart
{
    // Fires up some hearts to rain on the view
	CABasicAnimation *heartsBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.heart.birthRate"];
	heartsBurst.fromValue		= [NSNumber numberWithFloat:50.0];
	heartsBurst.toValue			= [NSNumber numberWithFloat:  0.0];
	heartsBurst.duration		= 5.0;
	heartsBurst.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	[self.heartsEmitter addAnimation:heartsBurst forKey:@"heartsBurst"];
}

- (void)showDialogWithTumble {
    [self showHeart];
    [self.alertView showWithAnimation:URBAlertAnimationTumble];
    [self setFireAmount:0.1 withAngle:M_PI];
}
- (void)viewDidAppear:(BOOL)animated{
    URBAlertView *alertView = [URBAlertView dialogWithTitle:@"开始游戏" subtitle:@"提示:如果你是第一次玩\n建议先看操作说明！"];
    alertView.blurBackground = NO;
    [alertView addButtonWithTitle:@"取消"];
    [alertView addButtonWithTitle:@"确定"];
    [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
        NSLog(@"button tapped: index=%i", buttonIndex);
        if(buttonIndex==0)
        {
            [self setFireAmount:0.5 withAngle:M_PI];
            dcPathButton.hidden=NO;
            dcPathButton.startButton.hidden=NO;
            dcPathButton.loadButton.hidden=NO;
            dcPathButton.helpButton.hidden=NO;
            CATransition *animation = [CATransition animation];
            animation.delegate = self;
            animation.duration = 2;
            //animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = @"rippleEffect";
            [[self.view layer] addAnimation:animation forKey:@"animation"];
            for (int i = 1; i <2; i++)
            {
                int64_t delayInSeconds = 1 * i;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [alertView removeFromSuperview];
                    alertView.window.hidden=YES;
                });
            }
        }
        if(buttonIndex==1)
        {
            [self animationFinished];
            for (int i = 1; i <2; i++)
            {
                int64_t delayInSeconds = 1 * i;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [alertView removeFromSuperview];
                    alertView.window.hidden=YES;
                });
            }
        }
        [self.alertView hideWithCompletionBlock:^{}];
    }];
    self.alertView = alertView;
}
-(void)animationFinished
{
    [self hideUIViewController:self];
}
- (void) hideUIViewController:(UIViewController *) controller
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animDone:finished:context:)];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:[[CCDirector sharedDirector] view] cache:YES];
    [controller.view removeFromSuperview];
    controller.view=nil;
    [UIView commitAnimations];
}
-(void)animDone:(NSString*) animationID finished:(BOOL) finished context:(void*) context
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    [accountDefaults setFloat:150.0f forKey:@"startX"];
    [accountDefaults setFloat:200.0f forKey:@"startY"];
    [accountDefaults setBool:NO forKey:@"startFace"];
    [accountDefaults setInteger:0 forKey:@"playerScore"];
    [accountDefaults setInteger:1 forKey:@"playerLevel"];
    
    [accountDefaults setFloat:20.0f forKey:@"playerTotleLife"];
    [accountDefaults setFloat:20.0f forKey:@"playerCurLife"];
    [accountDefaults setFloat:100.0f forKey:@"playerTotleMagic"];
    [accountDefaults setFloat:100.0f forKey:@"playerCurMagic"];

    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[GameScene0 scene] withColor:ccc3(255, 255, 255)]];
}

-(void)loadMemory1
{
    SaveAndLoad *load1=[[SaveAndLoad alloc]init];
    sqlTestList *data1=[load1 searchTestList:1];
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    [accountDefaults setFloat:data1.sqlStartX forKey:@"startX"];
    [accountDefaults setFloat:data1.sqlStartY forKey:@"startY"];
    [accountDefaults setInteger:data1.sqlPlayerScore forKey:@"playerScore"];
    [accountDefaults setInteger:data1.sqlPlayerLevel forKey:@"playerLevel"];
    
    [accountDefaults setFloat:data1.sqlPlayerTotleLife forKey:@"playerTotleLife"];
    [accountDefaults setFloat:data1.sqlPlayerTotleLife forKey:@"playerCurLife"];
    [accountDefaults setFloat:data1.sqlPlayerTotleMagic forKey:@"playerTotleMagic"];
    [accountDefaults setFloat:data1.sqlPlayerTotleMagic forKey:@"playerCurMagic"];
    
    if(data1.sqlSaveWay==1){
        [accountDefaults setBool:YES forKey:@"startFace"];
        [self.view removeFromSuperview];self.view=nil;
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[GameScene3 scene] withColor:ccc3(255, 255, 255)]];        
    }
}
-(void)loadMemory2
{
    SaveAndLoad *load2=[[SaveAndLoad alloc]init];
    sqlTestList *data2=[load2 searchTestList:2];
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    [accountDefaults setFloat:data2.sqlStartX forKey:@"startX"];
    [accountDefaults setFloat:data2.sqlStartY forKey:@"startY"];
    [accountDefaults setInteger:data2.sqlPlayerScore forKey:@"playerScore"];
    [accountDefaults setInteger:data2.sqlPlayerLevel forKey:@"playerLevel"];
    
    [accountDefaults setFloat:data2.sqlPlayerTotleLife forKey:@"playerTotleLife"];
    [accountDefaults setFloat:data2.sqlPlayerTotleLife forKey:@"playerCurLife"];
    [accountDefaults setFloat:data2.sqlPlayerTotleMagic forKey:@"playerTotleMagic"];
    [accountDefaults setFloat:data2.sqlPlayerTotleMagic forKey:@"playerCurMagic"];
    
    if(data2.sqlSaveWay==1){
        [accountDefaults setBool:YES forKey:@"startFace"];
        [self.view removeFromSuperview];self.view=nil;
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[GameScene3 scene] withColor:ccc3(255, 255, 255)]];
    }
    
}
-(void)loadMemory3
{
    SaveAndLoad *load3=[[SaveAndLoad alloc]init];
    sqlTestList *data3=[load3 searchTestList:3];
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    [accountDefaults setFloat:data3.sqlStartX forKey:@"startX"];
    [accountDefaults setFloat:data3.sqlStartY forKey:@"startY"];
    [accountDefaults setInteger:data3.sqlPlayerScore forKey:@"playerScore"];
    [accountDefaults setInteger:data3.sqlPlayerLevel forKey:@"playerLevel"];
    
    [accountDefaults setFloat:data3.sqlPlayerTotleLife forKey:@"playerTotleLife"];
    [accountDefaults setFloat:data3.sqlPlayerTotleLife forKey:@"playerCurLife"];
    [accountDefaults setFloat:data3.sqlPlayerTotleMagic forKey:@"playerTotleMagic"];
    [accountDefaults setFloat:data3.sqlPlayerTotleMagic forKey:@"playerCurMagic"];
    
    if(data3.sqlSaveWay==1){
        [accountDefaults setBool:YES forKey:@"startFace"];
        [self.view removeFromSuperview];self.view=nil;
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[GameScene3 scene] withColor:ccc3(255, 255, 255)]];
    }
    
}

- (void) dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DCPathButton delegate
- (void)button_center_action{
    tipLary.hidden=YES;
    load1Button.hidden=YES;
    load2Button.hidden=YES;
    load3Button.hidden=YES;
    magicCircle.hidden=YES;
}
- (void)button_0_action{
    NSLog(@"Button Press Tag 0!!");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,0.5*NSEC_PER_SEC),dispatch_get_main_queue(),^(void){
        dcPathButton.hidden=YES;
        dcPathButton.startButton.hidden=YES;
        dcPathButton.loadButton.hidden=YES;
        dcPathButton.helpButton.hidden=YES;
        load1Button.hidden=YES;
        load2Button.hidden=YES;
        load3Button.hidden=YES;
        magicCircle.hidden=YES;
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,1*NSEC_PER_SEC),dispatch_get_main_queue(),^(void){[self showDialogWithTumble];});
}
- (void)button_1_action{
    NSLog(@"Button Press Tag 1!!");
    if (load1Button.hidden==YES) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,0.2*NSEC_PER_SEC),dispatch_get_main_queue(),^(void){
            CATransition *animation = [CATransition animation];
            animation.delegate = self;
            animation.duration = 2;
            animation.type = @"rippleEffect";
            [magicCircle.layer addAnimation:animation forKey:@"animation"];
            magicCircle.hidden=NO;
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,1*NSEC_PER_SEC),dispatch_get_main_queue(),^(void){
            load1Button.hidden=NO;
            load2Button.hidden=NO;
            load3Button.hidden=NO;
        });
    } else {
        load1Button.hidden=YES;
        load2Button.hidden=YES;
        load3Button.hidden=YES;
        magicCircle.hidden=YES;
    }
    
}
- (void)button_2_action{
    NSLog(@"Button Press Tag 2!!");
    load1Button.hidden=YES;
    load2Button.hidden=YES;
    load3Button.hidden=YES;
    magicCircle.hidden=YES;
    HelpViewController *hvc=[[HelpViewController alloc]init];
    [[[CCDirector sharedDirector] view] addSubview:hvc.view];
}
@end
