//
//  IntroLayer.m
//  DemonCastle
//
//  Created by macbook on 13-5-12.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//
#import "IntroLayer.h"
#import "GameScene0.h"
#import "MainViewController.h"
#import "GameScene3.h"

#import "AppDelegate.h"
@implementation IntroLayer
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	IntroLayer *layer = [IntroLayer node];
	[scene addChild: layer];
	return scene;
}
-(void) onEnter
{
	[super onEnter];
	CGSize size = [[CCDirector sharedDirector] winSize];
	CCSprite *background;
	if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
		background = [CCSprite spriteWithFile:@"DefaultBlack.png"];
	} else {
		background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
	}
	background.position = ccp(size.width/2, size.height/2);
	[self addChild: background];
	[self scheduleOnce:@selector(makeTransition:) delay:1];
}
-(void) makeTransition:(ccTime)dt
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    [accountDefaults setFloat:150.0f forKey:@"startX"];
    [accountDefaults setFloat:182.0f forKey:@"startY"];    
    [accountDefaults setBool:NO forKey:@"startFace"];
    [accountDefaults setInteger:0 forKey:@"playerScore"];
    [accountDefaults setInteger:1 forKey:@"playerLevel"];
    
    [accountDefaults setFloat:20.0f forKey:@"playerTotleLife"];
    [accountDefaults setFloat:20.0f forKey:@"playerCurLife"];
    [accountDefaults setFloat:100.0f forKey:@"playerTotleMagic"];
    [accountDefaults setFloat:100.0f forKey:@"playerCurMagic"];

    //[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[GameScene3 scene] withColor:ccc3(255, 255, 255)]];
    MainViewController *mvc=[[MainViewController alloc]init];
    [[[CCDirector sharedDirector] view] addSubview:mvc.view];
}
@end
