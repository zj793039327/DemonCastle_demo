//
//  settings.m
//  DemonCastle
//
//  Created by 尚德机构 on 13-5-31.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "settings.h"

#define winSCALE ([[UIScreen mainScreen] bounds].size.height*[[UIScreen mainScreen] scale]/480)

@implementation settings
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	settings *layer = [settings node];
	[scene addChild: layer];
	return scene;
}

-(CCSprite *)spriteWithColor:(ccColor4F)bgColor textureSize:(float)textureSize
{
    // 1: Create new CCRenderTexture
    CCRenderTexture *rt = [CCRenderTexture renderTextureWithWidth:textureSize height:textureSize];
    // 2: Call CCRenderTexture:begin
    [rt beginWithClear:bgColor.r g:bgColor.g b:bgColor.b a:bgColor.a];
    
    CCSprite *noise = [CCSprite spriteWithFile:@"Noise.png"];
    noise.scaleX=2;noise.scaleY=1.25;
    [noise setBlendFunc:(ccBlendFunc){GL_DST_COLOR, GL_ZERO}];
    noise.position = ccp(textureSize/2, textureSize/2);
    [noise visit];
    // 4: Call CCRenderTexture:end
    [rt end];
    // 5: Create a new Sprite from the texture
    return [CCSprite spriteWithTexture:rt.sprite.texture];
}

- (void)genBackground {
    [_background removeFromParentAndCleanup:YES];
    ccColor4F bgColor = ccc4FFromccc4B(ccc4(184,134,21,160));
    _background = [self spriteWithColor:bgColor textureSize:512];
    _background.scaleX = 0.94;
    CGSize winSize = [CCDirector sharedDirector].winSize;
    _background.position = ccp(winSize.width/2, winSize.height/2);
    
    ccTexParams tp = {GL_LINEAR, GL_LINEAR, GL_REPEAT, GL_REPEAT};
    [_background.texture setTexParameters:&tp];
    
    [self addChild:_background];
}

-(id)init
{
    if(self=[super init]) {
        self.isTouchEnabled = YES;
        level=[[Level alloc]init];
        [level levelListener];
        //古代羊皮书背景-------------------------------------------------------------------------------------------
        CCSprite *background=[CCSprite spriteWithFile:@"settingBook.jpg"];
        background.anchorPoint=CGPointZero;
        background.scaleX=0.94*winSCALE/2;
        background.scaleY=1.3*winSCALE/2;
        [self addChild:background];
        //属性，经验-----------------------------------------------------------------------------------------------
        CCLabelTTF *hpLabel=[CCLabelTTF labelWithString:@"耐力" fontName:@"Arial" fontSize:14];
        [hpLabel setPosition:ccp(155,280)];[hpLabel setColor:ccc3(100, 20, 30)];
        [self addChild:hpLabel];
        CCLabelTTF *mpLabel=[CCLabelTTF labelWithString:@"魔力" fontName:@"Arial" fontSize:14];
        [mpLabel setPosition:ccp(155,250)];[mpLabel setColor:ccc3(100, 20, 30)];
        [self addChild:mpLabel];
        CCLabelTTF *attackLabel=[CCLabelTTF labelWithString:@"攻击力" fontName:@"Arial" fontSize:14];
        [attackLabel setPosition:ccp(160,220)];[attackLabel setColor:ccc3(100, 20, 30)];
        [self addChild:attackLabel];
        CCLabelTTF *defanceLabel=[CCLabelTTF labelWithString:@"防御力" fontName:@"Arial" fontSize:14];
        [defanceLabel setPosition:ccp(160,190)];[defanceLabel setColor:ccc3(100, 20, 30)];
        [self addChild:defanceLabel];
        CCLabelTTF *expLabel=[CCLabelTTF labelWithString:@"当前经验" fontName:@"Arial" fontSize:14];
        [expLabel setPosition:ccp(50,130)];[expLabel setColor:ccc3(100, 20, 30)];
        [self addChild:expLabel];
        CCLabelTTF *nextExpLabel=[CCLabelTTF labelWithString:@"下次升级" fontName:@"Arial" fontSize:14];
        [nextExpLabel setPosition:ccp(50,100)];[nextExpLabel setColor:ccc3(100, 20, 30)];
        [self addChild:nextExpLabel];
        //属性数值-------------------------------------------------------------------------------------------------
        NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];
        float playerCurLife=[myDefaults floatForKey:@"playerCurLife"];
        float playerTotleLife=[myDefaults floatForKey:@"playerTotleLife"];
        float playerCurMagic=[myDefaults floatForKey:@"playerCurMagic"];
        float playerTotleMagic=[myDefaults floatForKey:@"playerTotleMagic"];
        NSString *hpValueS=[NSString stringWithFormat:@"%.0f/%.0f",playerCurLife,playerTotleLife];
        NSString *mpValueS=[NSString stringWithFormat:@"%.0f/%.0f",playerCurMagic,playerTotleMagic];
        
        CCLabelTTF *hpValue=[CCLabelTTF labelWithString:hpValueS fontName:@"Arial" fontSize:14];
        [hpValue setPosition:ccp(200,280)];[hpValue setColor:ccc3(0, 0, 255)];
        [self addChild:hpValue];
        CCLabelTTF *mpValue=[CCLabelTTF labelWithString:mpValueS fontName:@"Arial" fontSize:14];
        [mpValue setPosition:ccp(200,250)];[mpValue setColor:ccc3(0, 0, 255)];
        [self addChild:mpValue];
        CCLabelTTF *attackValue=[CCLabelTTF labelWithString:@"999" fontName:@"Arial" fontSize:14];
        [attackValue setPosition:ccp(200,220)];[attackValue setColor:ccc3(0, 0, 255)];
        [self addChild:attackValue];
        CCLabelTTF *defanceValue=[CCLabelTTF labelWithString:@"999" fontName:@"Arial" fontSize:14];
        [defanceValue setPosition:ccp(200,190)];[defanceValue setColor:ccc3(0, 0, 255)];
        [self addChild:defanceValue];
        //经验数值----------------------------------------------------------------------------------------------------
        int playerScore=[myDefaults integerForKey:@"playerScore"];
        NSString *expS=[NSString stringWithFormat:@"%d",playerScore/10];
        CCLabelTTF *exp=[CCLabelTTF labelWithString:expS fontName:@"Arial" fontSize:14];
        [exp setPosition:ccp(110,130)];[exp setColor:ccc3(0,0,255)];
        [self addChild:exp];
        NSString *nextExpS=[NSString stringWithFormat:@"%d",level.nextLevelRequiredExp-playerScore/10];
        CCLabelTTF *nextExp=[CCLabelTTF labelWithString:nextExpS fontName:@"Arial" fontSize:14];
        [nextExp setPosition:ccp(110,100)];[nextExp setColor:ccc3(0,0,255)];
        [self addChild:nextExp];
        //等级-------------------------------------------------------------------------------------------------------
        int playerLevel=[myDefaults integerForKey:@"playerLevel"];
        NSString *playerLevelS;
        if(playerLevel<10){playerLevelS=[NSString stringWithFormat:@"LV.0%d",playerLevel];}
        else {playerLevelS=[NSString stringWithFormat:@"LV.%d",playerLevel];}
        CCLabelTTF *playerLevelLabel=[CCLabelTTF labelWithString:playerLevelS fontName:@"Arial" fontSize:20];
        [playerLevelLabel setPosition:ccp(70,160)];[playerLevelLabel setColor:ccc3(250,20,30)];
        [self addChild:playerLevelLabel];
        //背景遮罩----------------------------------------------------------------------------------------------------
        [self genBackground];
        //头像,名字---------------------------------------------------------------------------------------------------
        CCSprite *playerImg=[CCSprite spriteWithFile:@"settingBookImg.jpg"];
        playerImg.position=CGPointMake(70, 245);
        playerImg.scale=winSCALE;
        [self addChild:playerImg];
        CCLabelTTF *playerName=[CCLabelTTF labelWithString:@"理查德 贝尔蒙特" fontName:@"Arial" fontSize:14];
        [playerName setPosition:ccp(70,185)];[playerName setColor:ccc3(250,20,30)];
        [self addChild:playerName];
        //----------------------------------------------------------------------------------------------------------
        //全屏键
        AllView=[[UIView alloc] initWithFrame:CGRectMake(0,0,480,320)];
        AllView.backgroundColor=[UIColor whiteColor];
        AllView.alpha=0.011;
        [[[CCDirector sharedDirector] view] addSubview:AllView];
        //全屏键返回
        UITapGestureRecognizer *pinch=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goStautusView:)];
        [AllView addGestureRecognizer:pinch];
        [pinch release];

    }
    return self;
}

-(void)goStautusView:(UIGestureRecognizer *)sender{
    [[CCDirector sharedDirector]popScene];
    [AllView removeFromSuperview];
}
@end
