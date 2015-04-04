//
//  GameHud.m
//  DemonCastle
//
//  Created by macbook on 13-5-12.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameHud.h"
#import "settings.h"
#import "UIView+MDCShineEffect.h"
#import "Level.h"
#import "GameScene0.h"
#import "GameScene1.h"
#import "GameScene2.h"
#import "GameScene3.h"

@implementation GameHud
@synthesize gameLayer0 = _gameLayer0,gameLayer1 = _gameLayer1,gameLayer2 = _gameLayer2,gameLayer3=_gameLayer3;

-(id)init
{
    if(self=[super init]) {
        //可触控
        self.isTouchEnabled=YES;
        level=[[Level alloc]init];
        [level levelListener];
        myDefaults = [NSUserDefaults standardUserDefaults];
        //生命条和分数，等级栏
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"Bars.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"Bars.png"];
        [self addChild:spriteSheet];
        CCMenuItemSprite *MenuItemLifeBar=[CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"lifebar.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"lifebar.png"]];
        MenuItemLifeBar.position=ccp(60,260);
        //-------------------------------
        MenuItemLifeBar.scale=winSCALE;
        //-------------------------------
        [self addChild:MenuItemLifeBar];
        MenuItemLife=[CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"life.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"life.png"]];
        //-------------------------------
        MenuItemLife.scale=winSCALE;
        //-------------------------------
        [self addChild:MenuItemLife];
        //等级01-99
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"number.plist"];
        CCSpriteBatchNode *spriteSheet1 = [CCSpriteBatchNode batchNodeWithFile:@"number.png"];
        [self addChild:spriteSheet1];
        int playerLevel=[myDefaults integerForKey:@"playerLevel"];
        NSString *levelUnit=[NSString stringWithFormat:@"number-%d.png",playerLevel%10];
        NSString *levelDecade=[NSString stringWithFormat:@"number-%d.png",(playerLevel-playerLevel%10)/10];
        MenuItemLevelNumber0=[CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:levelUnit] selectedSprite:[CCSprite spriteWithSpriteFrameName:levelUnit]];
        MenuItemLevelNumber0.position=ccp(31.5,301);
        //-------------------------------
        MenuItemLevelNumber0.scale=winSCALE;
        //-------------------------------
        [self addChild:MenuItemLevelNumber0];     //个位
        MenuItemLevelNumber1=[CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:levelDecade] selectedSprite:[CCSprite spriteWithSpriteFrameName:levelDecade]];
        MenuItemLevelNumber1.position=ccp(23.5,301);
        //-------------------------------
        MenuItemLevelNumber1.scale=winSCALE;
        //-------------------------------
        [self addChild:MenuItemLevelNumber1];  //十位
        //分数(7位数)
        
        int playerScore=[myDefaults integerForKey:@"playerScore"];
        NSString *score1=[NSString stringWithFormat:@"number-%d.png",(playerScore%100)/10];
        NSString *score2=[NSString stringWithFormat:@"number-%d.png",(playerScore%1000-playerScore%100)/100];
        NSString *score3=[NSString stringWithFormat:@"number-%d.png",(playerScore%10000-playerScore%1000)/1000];
        NSString *score4=[NSString stringWithFormat:@"number-%d.png",(playerScore%100000-playerScore%10000)/10000];
        NSString *score5=[NSString stringWithFormat:@"number-%d.png",(playerScore%1000000-playerScore%100000)/100000];
        NSString *score6=[NSString stringWithFormat:@"number-%d.png",(playerScore%10000000-playerScore%1000000)/1000000];
        CCMenuItemSprite *MenuItemScoreNumber0=[CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"number-0.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"number-0.png"]];
        MenuItemScoreNumber0.position=ccp(96,299);
        MenuItemScoreNumber1=[CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:score1]
                                                     selectedSprite:[CCSprite spriteWithSpriteFrameName:score1]];
        MenuItemScoreNumber2=[CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:score2]
                                                     selectedSprite:[CCSprite spriteWithSpriteFrameName:score2]];
        MenuItemScoreNumber3=[CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:score3]
                                                     selectedSprite:[CCSprite spriteWithSpriteFrameName:score3]];
        MenuItemScoreNumber4=[CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:score4]
                                                     selectedSprite:[CCSprite spriteWithSpriteFrameName:score4]];
        MenuItemScoreNumber5=[CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:score5]
                                                     selectedSprite:[CCSprite spriteWithSpriteFrameName:score5]];
        MenuItemScoreNumber6=[CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:score6]
                                                     selectedSprite:[CCSprite spriteWithSpriteFrameName:score6]];
        MenuItemScoreNumber1.position=ccp(88,299);
        MenuItemScoreNumber2.position=ccp(80,299);
        MenuItemScoreNumber3.position=ccp(72,299);
        MenuItemScoreNumber4.position=ccp(64,299);
        MenuItemScoreNumber5.position=ccp(56,299);
        MenuItemScoreNumber6.position=ccp(48,299);
        //-------------------------------
        MenuItemScoreNumber0.scale=winSCALE;
        MenuItemScoreNumber1.scale=winSCALE;
        MenuItemScoreNumber2.scale=winSCALE;
        MenuItemScoreNumber3.scale=winSCALE;
        MenuItemScoreNumber4.scale=winSCALE;
        MenuItemScoreNumber5.scale=winSCALE;
        MenuItemScoreNumber6.scale=winSCALE;
        //-------------------------------
        [self addChild:MenuItemScoreNumber0];
        [self addChild:MenuItemScoreNumber1];
        [self addChild:MenuItemScoreNumber2];
        [self addChild:MenuItemScoreNumber3];
        [self addChild:MenuItemScoreNumber4];
        [self addChild:MenuItemScoreNumber5];
        [self addChild:MenuItemScoreNumber6];
        
        //魔力栏
        CCMenuItemSprite *MenuItemMagicBar=[CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"magicbar.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"magicbar.png"]];
        MenuItemMagicBar.position=ccp(460,260);
        //-------------------------------
        MenuItemMagicBar.scale=winSCALE;
        //-------------------------------
        [self addChild:MenuItemMagicBar];
        MenuItemMagic=[CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"magic.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"magic.png"]];
        //-------------------------------
        MenuItemMagic.scale=winSCALE;
        //-------------------------------
        [self addChild:MenuItemMagic];
        
        //属性面板
        CCMenuItemSprite *MenuItemSettings=[CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"magicbook.png"] selectedSprite:[CCSprite spriteWithFile:@"magicbook.png"]];
        MenuItemSettings.position=ccp(415,285);
        //-------------------------------
        MenuItemSettings.scale=winSCALE/2.0;
        //-------------------------------
        [self addChild:MenuItemSettings];
//----------------------------------------------------------------------------------------------------------
        [self scheduleUpdate];
    }
    return self;
}
-(void) update: (ccTime) dt
{
    [level levelListener];
    
    float playerCurLife=[myDefaults floatForKey:@"playerCurLife"];
    float playerTotleLife=[myDefaults floatForKey:@"playerTotleLife"];
    float lifePercent=playerCurLife/playerTotleLife;
    if(lifePercent<0.0f)lifePercent=0.0f;
    if(lifePercent>playerTotleLife)lifePercent=playerTotleLife;
    MenuItemLife.scaleY=lifePercent*winSCALE;
    MenuItemLife.position=ccp(12.5,261-(1-MenuItemLife.scaleY/winSCALE)*92/2);
    
    int playerLevel=[myDefaults integerForKey:@"playerLevel"];
    NSString *levelUnit=[NSString stringWithFormat:@"number-%d.png",playerLevel%10];
    NSString *levelDecade=[NSString stringWithFormat:@"number-%d.png",(playerLevel-playerLevel%10)/10];
    [MenuItemLevelNumber0 setNormalImage:[CCSprite spriteWithSpriteFrameName:levelUnit]];
    [MenuItemLevelNumber1 setNormalImage:[CCSprite spriteWithSpriteFrameName:levelDecade]];
    
    int playerScore=[myDefaults integerForKey:@"playerScore"];
    NSString *score1=[NSString stringWithFormat:@"number-%d.png",(playerScore%100)/10];
    NSString *score2=[NSString stringWithFormat:@"number-%d.png",(playerScore%1000-playerScore%100)/100];
    NSString *score3=[NSString stringWithFormat:@"number-%d.png",(playerScore%10000-playerScore%1000)/1000];
    NSString *score4=[NSString stringWithFormat:@"number-%d.png",(playerScore%100000-playerScore%10000)/10000];
    NSString *score5=[NSString stringWithFormat:@"number-%d.png",(playerScore%1000000-playerScore%100000)/100000];
    NSString *score6=[NSString stringWithFormat:@"number-%d.png",(playerScore%10000000-playerScore%1000000)/1000000];
    [MenuItemScoreNumber1 setNormalImage:[CCSprite spriteWithSpriteFrameName:score1]];
    [MenuItemScoreNumber2 setNormalImage:[CCSprite spriteWithSpriteFrameName:score2]];
    [MenuItemScoreNumber3 setNormalImage:[CCSprite spriteWithSpriteFrameName:score3]];
    [MenuItemScoreNumber4 setNormalImage:[CCSprite spriteWithSpriteFrameName:score4]];
    [MenuItemScoreNumber5 setNormalImage:[CCSprite spriteWithSpriteFrameName:score5]];
    [MenuItemScoreNumber6 setNormalImage:[CCSprite spriteWithSpriteFrameName:score6]];
    
    float playerCurMagic=[myDefaults floatForKey:@"playerCurMagic"];
    float playerTotleMagic=[myDefaults floatForKey:@"playerTotleMagic"];
    float magicPercent=playerCurMagic/playerTotleMagic;
    if(magicPercent<0.0f)magicPercent=0.0f;
    if(magicPercent>playerTotleMagic)magicPercent=playerTotleMagic;
    MenuItemMagic.scaleY=magicPercent*winSCALE;
    MenuItemMagic.position=ccp(463,261-(1-MenuItemMagic.scaleY/winSCALE)*92/2);
}

-(void)onEnter
{
    [super onEnter];
    //-------------------------------------------------------------------------------------------------------
    //右键
    rightButtonView=[[UIView alloc] initWithFrame:CGRectMake(300,0,180,250)];
    rightButtonView.backgroundColor=[UIColor lightGrayColor];
    rightButtonView.alpha=0.011;
    [[[CCDirector sharedDirector] view] addSubview:rightButtonView];
    //右键单击
    UITapGestureRecognizer *toRight =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightButtonTapped:)];
    toRight.numberOfTapsRequired=1;
    [rightButtonView addGestureRecognizer:toRight];
    //右键双击
    UITapGestureRecognizer *toRightDouble =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightButtonDoubleTapped:)];
    toRightDouble.numberOfTapsRequired=2;
    [rightButtonView addGestureRecognizer:toRightDouble];
    //右键双击判定
    [toRight requireGestureRecognizerToFail:toRightDouble];
    //右键常按
    UILongPressGestureRecognizer *toRightLongPress;
    toRightLongPress= [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(rightButtonLongPress:)];
    [toRightLongPress setMinimumPressDuration:0.5];
    [rightButtonView addGestureRecognizer:toRightLongPress];
    //右键向右滑动
    UISwipeGestureRecognizer *toRightSwipe1=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightButtonSwipeToRight:)];
    [toRightSwipe1 setDirection:UISwipeGestureRecognizerDirectionRight];
    [rightButtonView addGestureRecognizer:toRightSwipe1];
    //右键向下滑动
    UISwipeGestureRecognizer *toRightSwipe2=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightButtonSwipeToDown:)];
    [toRightSwipe2 setDirection:UISwipeGestureRecognizerDirectionDown];
    [rightButtonView addGestureRecognizer:toRightSwipe2];
    //右键向左滑动
    UISwipeGestureRecognizer *toRightSwipe3=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightButtonSwipeToLeft:)];
    [toRightSwipe3 setDirection:UISwipeGestureRecognizerDirectionLeft];
    [rightButtonView addGestureRecognizer:toRightSwipe3];
    //右键向上滑动
    UISwipeGestureRecognizer *toRightSwipe4=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightButtonSwipeToUp:)];
    [toRightSwipe4 setDirection:UISwipeGestureRecognizerDirectionUp];
    [rightButtonView addGestureRecognizer:toRightSwipe4];
    //释放空间
    [toRight release];
    [toRightDouble release];
    [toRightLongPress release];
    [toRightSwipe1 release];
    [toRightSwipe2 release];
    [toRightSwipe3 release];
    [toRightSwipe4 release];
    //-------------------------------------------------------------------------------------------------------
    //左键
    leftButtonView=[[UIView alloc] initWithFrame:CGRectMake(0,0,180,250)];
    leftButtonView.backgroundColor=[UIColor lightGrayColor];
    leftButtonView.alpha=0.011;
    [[[CCDirector sharedDirector] view] addSubview:leftButtonView];
    //左键单击
    UITapGestureRecognizer *toLeft =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftButtonTapped:)];
    toLeft.numberOfTapsRequired=1;
    [leftButtonView addGestureRecognizer:toLeft];
    //左键双击
    UITapGestureRecognizer *toLeftDouble=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftButtonDoubleTapped:)];
    toLeftDouble.numberOfTapsRequired=2;
    [leftButtonView addGestureRecognizer:toLeftDouble];
    //左键双击判定
    [toLeft requireGestureRecognizerToFail:toLeftDouble];
    //左键常按
    UILongPressGestureRecognizer *toLeftLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(leftButtonLongPress:)];
    [toLeftLongPress setMinimumPressDuration:0.5];
    [leftButtonView addGestureRecognizer:toLeftLongPress];
    //左键向左滑动
    UISwipeGestureRecognizer *toLeftSwipe1=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftButtonSwipeToLeft:)];
    [toLeftSwipe1 setDirection:UISwipeGestureRecognizerDirectionLeft];
    [leftButtonView addGestureRecognizer:toLeftSwipe1];
    //左键向下滑动
    UISwipeGestureRecognizer *toLeftSwipe2=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftButtonSwipeToDown:)];
    [toLeftSwipe2 setDirection:UISwipeGestureRecognizerDirectionDown];
    [leftButtonView addGestureRecognizer:toLeftSwipe2];
    //左键向右滑动
    UISwipeGestureRecognizer *toLeftSwipe3=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftButtonSwipeToRight:)];
    [toLeftSwipe3 setDirection:UISwipeGestureRecognizerDirectionRight];
    [leftButtonView addGestureRecognizer:toLeftSwipe3];
    //左键向上滑动
    UISwipeGestureRecognizer *toLeftSwipe4=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftButtonSwipeToUp:)];
    [toLeftSwipe4 setDirection:UISwipeGestureRecognizerDirectionUp];
    [leftButtonView addGestureRecognizer:toLeftSwipe4];
    //释放空间
    [toLeft release];
    [toLeftDouble release];
    [toLeftLongPress release];
    [toLeftSwipe1 release];
    [toLeftSwipe2 release];
    [toLeftSwipe3 release];
    [toLeftSwipe4 release];
    //-------------------------------------------------------------------------------------------------------
    //中键
    middleButtonView=[[UIView alloc] initWithFrame:CGRectMake(180,0,120,250)];
    middleButtonView.backgroundColor=[UIColor lightGrayColor];
    middleButtonView.alpha=0.011;
    [[[CCDirector sharedDirector] view] addSubview:middleButtonView];
    //中键单击
    UITapGestureRecognizer *toMiddle=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(middleButtonTapped:)];
    toMiddle.numberOfTapsRequired=1;
    [middleButtonView addGestureRecognizer:toMiddle];
    [toMiddle release];
    //中键双击
    UITapGestureRecognizer *toMiddleDouble=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(middleButtonDoubleTapped:)];
    toMiddleDouble.numberOfTapsRequired=2;
    [middleButtonView addGestureRecognizer:toMiddleDouble];
    [toMiddleDouble release];
    //中键双击判定
    [toMiddle requireGestureRecognizerToFail:toMiddleDouble];
    //-------------------------------------------------------------------------------------------------------
    //右下键
    rightBottomButtonView=[[UIView alloc] initWithFrame:CGRectMake(240,250,240,70)];
    rightBottomButtonView.backgroundColor=[UIColor lightGrayColor];
    rightBottomButtonView.alpha=0.011;
    [[[CCDirector sharedDirector] view] addSubview:rightBottomButtonView];
    //右下键单击
    UITapGestureRecognizer *toRightBottom=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightBottomButtonTapped:)];
    toRightBottom.numberOfTapsRequired=1;
    [rightBottomButtonView addGestureRecognizer:toRightBottom];
    //右下键双击
    UITapGestureRecognizer *toRightBottomDouble=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightBottomButtonDoubleTapped:)];
    toRightBottomDouble.numberOfTapsRequired=2;
    [rightBottomButtonView addGestureRecognizer:toRightBottomDouble];
    //右下键双击判定
    [toRightBottom requireGestureRecognizerToFail:toRightBottomDouble];
    //右下键常按
    UILongPressGestureRecognizer *toRightBottomLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(rightBottomButtonLongPress:)];
    [toRightBottomLongPress setMinimumPressDuration:0.5];
    [rightBottomButtonView addGestureRecognizer:toRightBottomLongPress];
    //右下键向右滑动
    UISwipeGestureRecognizer *toRightBottomSwipe=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightBottomButtonSwipeToRight:)];
    [toRightBottomSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [rightBottomButtonView addGestureRecognizer:toRightBottomSwipe];
    //释放空间
    [toRightBottom release];
    [toRightBottomDouble release];
    [toRightBottomLongPress release];
    [toRightBottomSwipe release];
    //-------------------------------------------------------------------------------------------------------
    //左下键
    leftBottomButtonView=[[UIView alloc] initWithFrame:CGRectMake(0,250,240,70)];
    leftBottomButtonView.backgroundColor=[UIColor lightGrayColor];
    leftBottomButtonView.alpha=0.011;
    [[[CCDirector sharedDirector] view] addSubview:leftBottomButtonView];
    //左下键单击
    UITapGestureRecognizer *toLeftBottom=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftBottomButtonTapped:)];
    toLeftBottom.numberOfTapsRequired=1;
    [leftBottomButtonView addGestureRecognizer:toLeftBottom];
    //左下键双击
    UITapGestureRecognizer *toLeftBottomDouble=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftBottomButtonDoubleTapped:)];
    toLeftBottomDouble.numberOfTapsRequired=2;
    [leftBottomButtonView addGestureRecognizer:toLeftBottomDouble];
    //左下键双击判定
    [toLeftBottom requireGestureRecognizerToFail:toLeftBottomDouble];
    //左下键常按
    UILongPressGestureRecognizer *toLeftBottomLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(leftBottomButtonLongPress:)];
    [toLeftBottomLongPress setMinimumPressDuration:0.5];
    [leftBottomButtonView addGestureRecognizer:toLeftBottomLongPress];
    //左下键向右滑动
    UISwipeGestureRecognizer *toLeftBottomSwipe=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftBottomButtonSwipeToLeft:)];
    [toLeftBottomSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [leftBottomButtonView addGestureRecognizer:toLeftBottomSwipe];
    //释放空间
    [toLeftBottom release];
    [toLeftBottomDouble release];
    [toLeftBottomLongPress release];
    [toLeftBottomSwipe release];
    //-------------------------------------------------------------------------------------------------------
    //属性面板
    
    settingsButton=[[UIButton alloc]initWithFrame:CGRectMake(385, 10, 60, 55)];
    [UIButton buttonWithType:UIButtonTypeCustom];
    settingsButton.backgroundColor=[UIColor clearColor];
    [settingsButton addTarget:self action:@selector(goToStatusMenu:) forControlEvents:UIControlEventTouchUpInside];
    [[[CCDirector sharedDirector]view] addSubview:settingsButton];
}
-(void)goToStatusMenu:(id)sender{
    CCLOG(@"Go to StatusMenu");
    [[CCDirector sharedDirector] pushScene:[CCTransitionMoveInR transitionWithDuration:1 scene:[settings scene]]];
}


-(void)rightButtonTapped:(UIGestureRecognizer *)sender{
    [_gameLayer0 rightButtonTapped];[_gameLayer1 rightButtonTapped];[_gameLayer2 rightButtonTapped];
    [_gameLayer3 rightButtonTapped];
}
-(void)rightButtonDoubleTapped:(UIGestureRecognizer *)sender{
    [_gameLayer0 rightButtonDoubleTapped];[_gameLayer1 rightButtonDoubleTapped];[_gameLayer2 rightButtonDoubleTapped];
    [_gameLayer3 rightButtonDoubleTapped];
}
-(void)rightButtonLongPress:(UIGestureRecognizer *)sender
{
    if(sender.state==UIGestureRecognizerStateBegan){
        [_gameLayer0 rightButtonLongPress];[_gameLayer1 rightButtonLongPress];[_gameLayer2 rightButtonLongPress];
        [_gameLayer3 rightButtonLongPress];
    }
    if(sender.state==UIGestureRecognizerStateEnded){
        
        [_gameLayer0 playerMoveEnded];[_gameLayer1 playerMoveEnded];[_gameLayer2 playerMoveEnded];
        [_gameLayer3 playerMoveEnded];
    }
}
-(void)rightButtonSwipeToRight:(UIGestureRecognizer *)sender{
    [_gameLayer0 rightButtonSwipeToRight];[_gameLayer1 rightButtonSwipeToRight];[_gameLayer2 rightButtonSwipeToRight];
    [_gameLayer3 rightButtonSwipeToRight];
}
-(void)rightButtonSwipeToDown:(UIGestureRecognizer *)sender{
    [_gameLayer0 rightButtonSwipeToDown];[_gameLayer1 rightButtonSwipeToDown];[_gameLayer2 rightButtonSwipeToDown];
    [_gameLayer3 rightButtonSwipeToDown];
}
-(void)rightButtonSwipeToLeft:(UIGestureRecognizer *)sender{
    [_gameLayer0 rightButtonSwipeToLeft];[_gameLayer1 rightButtonSwipeToLeft];[_gameLayer2 rightButtonSwipeToLeft];
    [_gameLayer3 rightButtonSwipeToLeft];
}
-(void)rightButtonSwipeToUp:(UIGestureRecognizer *)sender{
    [_gameLayer0 rightButtonSwipeToUp];[_gameLayer1 rightButtonSwipeToUp];[_gameLayer2 rightButtonSwipeToUp];
    [_gameLayer3 rightButtonSwipeToUp];
}

-(void)leftButtonTapped:(UIGestureRecognizer *)sender{
    [_gameLayer0 leftButtonTapped];[_gameLayer1 leftButtonTapped];[_gameLayer2 leftButtonTapped];
    [_gameLayer3 leftButtonTapped];
}
-(void)leftButtonDoubleTapped:(UIGestureRecognizer *)sender{
    [_gameLayer0 leftButtonDoubleTapped];[_gameLayer1 leftButtonDoubleTapped];[_gameLayer2 leftButtonDoubleTapped];
    [_gameLayer3 leftButtonDoubleTapped];
}
-(void)leftButtonLongPress:(UIGestureRecognizer *)sender
{
    if(sender.state==UIGestureRecognizerStateBegan){
        [_gameLayer0 leftButtonLongPress];[_gameLayer1 leftButtonLongPress];[_gameLayer2 leftButtonLongPress];
        [_gameLayer3 leftButtonLongPress];
    }
    if(sender.state==UIGestureRecognizerStateEnded){
        [_gameLayer0 playerMoveEnded];[_gameLayer1 playerMoveEnded];[_gameLayer2 playerMoveEnded];
        [_gameLayer3 playerMoveEnded];
    }
}
-(void)leftButtonSwipeToLeft:(UIGestureRecognizer *)sender{
    [_gameLayer0 leftButtonSwipeToLeft];[_gameLayer1 leftButtonSwipeToLeft];[_gameLayer2 leftButtonSwipeToLeft];
    [_gameLayer3 leftButtonSwipeToLeft];
}
-(void)leftButtonSwipeToDown:(UIGestureRecognizer *)sender{
    [_gameLayer0 leftButtonSwipeToDown];[_gameLayer1 leftButtonSwipeToDown];[_gameLayer2 leftButtonSwipeToDown];
    [_gameLayer3 leftButtonSwipeToDown];
}
-(void)leftButtonSwipeToRight:(UIGestureRecognizer *)sender{
    [_gameLayer0 leftButtonSwipeToRight];[_gameLayer1 leftButtonSwipeToRight];[_gameLayer2 leftButtonSwipeToRight];
    [_gameLayer3 leftButtonSwipeToRight];
}
-(void)leftButtonSwipeToUp:(UIGestureRecognizer *)sender{
    [_gameLayer0 leftButtonSwipeToUp];[_gameLayer1 leftButtonSwipeToUp];[_gameLayer2 leftButtonSwipeToUp];
    [_gameLayer3 leftButtonSwipeToUp];
}

-(void)middleButtonDoubleTapped:(UIGestureRecognizer *)sender{
    [_gameLayer0 middleButtonDoubleTapped];[_gameLayer1 middleButtonDoubleTapped];[_gameLayer2 middleButtonDoubleTapped];
    [_gameLayer3 middleButtonDoubleTapped];
}
-(void)middleButtonTapped:(UIGestureRecognizer *)sender{
    [_gameLayer3 middleButtonTapped];
}
//-----------------------------------------------------------------------------------------------------
-(void)rightBottomButtonTapped:(UIGestureRecognizer *)sender{
    [_gameLayer0 rightBottomButtonTapped];[_gameLayer1 rightBottomButtonTapped];[_gameLayer2 rightBottomButtonTapped];
    [_gameLayer3 rightBottomButtonTapped];
}
-(void)rightBottomButtonDoubleTapped:(UIGestureRecognizer *)sender{
    [_gameLayer0 rightBottomButtonDoubleTapped];[_gameLayer1 rightBottomButtonDoubleTapped];[_gameLayer2 rightBottomButtonDoubleTapped];
    [_gameLayer3 rightBottomButtonDoubleTapped];
}
-(void)rightBottomButtonLongPress:(UIGestureRecognizer *)sender
{
    if(sender.state==UIGestureRecognizerStateBegan){
        [_gameLayer0 rightBottomButtonLongPress];[_gameLayer1 rightBottomButtonLongPress];[_gameLayer2 rightBottomButtonLongPress];
        [_gameLayer3 rightBottomButtonLongPress];
    }
    if(sender.state==UIGestureRecognizerStateEnded){
        [_gameLayer0 playerMoveEnded];[_gameLayer1 playerMoveEnded];[_gameLayer2 playerMoveEnded];
        [_gameLayer3 playerMoveEnded];
    }
}
-(void)rightBottomButtonSwipeToRight:(UIGestureRecognizer *)sender{
    [_gameLayer0 rightBottomButtonPan];[_gameLayer1 rightBottomButtonPan];[_gameLayer2 rightBottomButtonPan];
    [_gameLayer3 rightBottomButtonPan];
}
-(void)leftBottomButtonTapped:(UIGestureRecognizer *)sender{
    [_gameLayer0 leftBottomButtonTapped];[_gameLayer1 leftBottomButtonTapped];[_gameLayer2 leftBottomButtonTapped];
    [_gameLayer3 leftBottomButtonTapped];
}
-(void)leftBottomButtonDoubleTapped:(UIGestureRecognizer *)sender{
    [_gameLayer0 leftBottomButtonDoubleTapped];[_gameLayer1 leftBottomButtonDoubleTapped];[_gameLayer2 leftBottomButtonDoubleTapped];
    [_gameLayer3 leftBottomButtonDoubleTapped];
}
-(void)leftBottomButtonLongPress:(UIGestureRecognizer *)sender
{
    if(sender.state==UIGestureRecognizerStateBegan){
        [_gameLayer0 leftBottomButtonLongPress];[_gameLayer1 leftBottomButtonLongPress];[_gameLayer2 leftBottomButtonLongPress];
        [_gameLayer3 leftBottomButtonLongPress];
    }
    if(sender.state==UIGestureRecognizerStateEnded){
        [_gameLayer0 playerMoveEnded];[_gameLayer1 playerMoveEnded];[_gameLayer2 playerMoveEnded];
        [_gameLayer3 playerMoveEnded];
    }
}
-(void)leftBottomButtonSwipeToLeft:(UIGestureRecognizer *)sender{
    [_gameLayer0 leftBottomButtonPan];[_gameLayer1 leftBottomButtonPan];[_gameLayer2 leftBottomButtonPan];
    [_gameLayer3 leftBottomButtonPan];
}

-(void)onExit
{
    [super onExit];
    CCLOG(@"hello");
    [rightButtonView removeFromSuperview];rightButtonView=nil;
    [leftButtonView removeFromSuperview];leftButtonView=nil;
    [middleButtonView removeFromSuperview];middleButtonView=nil;
    [rightBottomButtonView removeFromSuperview];rightBottomButtonView=nil;
    [leftBottomButtonView removeFromSuperview];leftBottomButtonView=nil;
    [settingsButton removeFromSuperview];settingsButton=nil;
}

-(void)dealloc
{
    [super dealloc];
}
@end
