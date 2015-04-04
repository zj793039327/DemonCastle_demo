//
//  Zombie.m
//  DemonCastle
//
//  Created by 尚德机构 on 13-5-20.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Zombie.h"
#import "GameScene0.h"


@implementation Zombie

@synthesize zombieLeg;
@synthesize zombieHead;
@synthesize zombieWaist;
@synthesize zombieWalkAction;
@synthesize zombieHeadAction;

-(id)init
{
    if(self=[super init]){
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"Zombie.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"Zombie.png"];
        [self addChild:spriteSheet];
        
        self.scale=1.2;
        
        zombieLeg = [CCSprite spriteWithSpriteFrameName:@"Zombie-leg-1.png"];
        zombieHead = [CCSprite spriteWithSpriteFrameName:@"Zombie-head-1.png"];
        zombieWaist = [CCSprite spriteWithSpriteFrameName:@"Zombie-waist-1.png"];
        zombieLeg.position = ccp(0.0f,0.0f);
        zombieWaist.position = ccpAdd(zombieLeg.position, ccp(-1.0f,9.0f));
        zombieHead.position =ccpAdd(zombieWaist.position, ccp(-6.0f,-2.0f));
        
        //-------------------------------
        zombieHead.scale=winSCALE;
        zombieWaist.scale=winSCALE;
        zombieLeg.scale=winSCALE;
        //-------------------------------
        [self addChild:zombieHead];
        [self addChild:zombieWaist];
        [self addChild:zombieLeg];
        
        NSMutableArray *zombieLegFrames=[NSMutableArray array];
        for(int i =1; i <= 2; ++i) {[zombieLegFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Zombie-leg-%d.png",i]]];}
        CCAnimation *zombieWalkAnim=[CCAnimation animationWithSpriteFrames:zombieLegFrames delay:0.5f];
        zombieWalkAction =[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:zombieWalkAnim]];
        [self.zombieLeg runAction:zombieWalkAction];
    }
    return self;
}

-(void)ZombieHit
{
    NSMutableArray *zombieHeadFrames=[NSMutableArray array];
    for(int i =1; i <= 2; ++i) {[zombieHeadFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Zombie-head-%d.png",i]]];}
    CCAnimation *zombieHeadAnim=[CCAnimation animationWithSpriteFrames:zombieHeadFrames delay:0.1f];
    CCAction *zombieHitAction =[CCAnimate actionWithAnimation:zombieHeadAnim];
    blood=[CCSprite spriteWithSpriteFrameName:@"Zombie-blood-1.png"];
    blood.position=zombieHead.position;
    if(zombieLeg.flipX==NO){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,0.1*NSEC_PER_SEC),dispatch_get_main_queue(),^(void){
            zombieHead.position=ccpAdd(zombieWaist.position, ccp(3.0f,7.0f));
        });
        [blood runAction:[CCJumpTo actionWithDuration:0.5 position:ccp(self.zombieHead.position.x+30,-10) height:20 jumps:1]];
    }
    else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,0.1*NSEC_PER_SEC),dispatch_get_main_queue(),^(void){
            zombieHead.position=ccpAdd(zombieWaist.position, ccp(-1.0f,7.0f));
        });
        [blood runAction:[CCJumpTo actionWithDuration:0.5 position:ccp(self.zombieHead.position.x-30,-10) height:20 jumps:1]];
    }
    [self.zombieHead runAction:zombieHitAction];
    
    //-------------------------------
    blood.scale=winSCALE;
    //-------------------------------
    [self addChild:blood];
}


@end
