//
//  ActionAnim.m
//  DemonCastle
//
//  Created by macbook on 13-5-12.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "ActionAnim.h"


@implementation ActionAnim
@synthesize holdAction,restAction;
@synthesize walkAction,runAction,walkDownAction,walkUpAction;
@synthesize walkStopAction,jumpStopAction,runStopAction,attackUpStopAction;
@synthesize jumpAction,jumpDownAction,rollBackAction,rollForwardAction;
@synthesize attackAction,rushAction,sunAction,attackUpAction,pointSkyAction,walkDownAttackAction,walkUpAttackAction;
@synthesize crouchAction,crouchAttackAction,sweepingLegAction,sweepingLegEndAction,swingLegAction;
@synthesize whipAction;
@synthesize hitAction,crouchHitAction,jumpHitAction,walkDownHitAction,walkUpHitAction,dieAction;
-(id)init
{
    if(self=[super init]){
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"richter.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"richter.png"];
        [self addChild:spriteSheet];
        //holding
        NSMutableArray *richterHoldFrames=[NSMutableArray array];
        for(int i =1; i <= 3; ++i) {[richterHoldFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-%d.png",i]]];}
        CCAnimation *richterHoldAnim=[CCAnimation animationWithSpriteFrames:richterHoldFrames delay:0.1f];
        self.holdAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:richterHoldAnim]];
        //resting
        NSMutableArray *richterRestFrames=[NSMutableArray array];
        for(int i =1; i <= 31; ++i) {[richterRestFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-rest-%d.png",i]]];}
        CCAnimation *richterRestAnim=[CCAnimation animationWithSpriteFrames:richterRestFrames delay:0.1f];
        self.RestAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:richterRestAnim]];
        //walking
        NSMutableArray *richterWalkFrames=[NSMutableArray array];
        for(int i =1; i <= 8; ++i) {[richterWalkFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-walk-%d.png",i]]];}
        CCAnimation *richterWalkAnim=[CCAnimation animationWithSpriteFrames:richterWalkFrames delay:0.1f];
        self.walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:richterWalkAnim]];
        //walking-down
        NSMutableArray *richterWalkDownFrames=[NSMutableArray array];
        for(int i =1; i <= 9; ++i) {[richterWalkDownFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-walkdown-%d.png",i]]];}
        CCAnimation *richterWalkDownAnim=[CCAnimation animationWithSpriteFrames:richterWalkDownFrames delay:0.1f];
        self.walkDownAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:richterWalkDownAnim]];
        //walking-up
        NSMutableArray *richterWalkUpFrames=[NSMutableArray array];
        for(int i =1; i <= 9; ++i) {[richterWalkUpFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-walkup-%d.png",i]]];}
        CCAnimation *richterWalkUpAnim=[CCAnimation animationWithSpriteFrames:richterWalkUpFrames delay:0.1f];
        self.walkUpAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:richterWalkUpAnim]];
        //running
        NSMutableArray *richterRunFrames=[NSMutableArray array];
        for(int i =1; i <= 9; ++i) {[richterRunFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-run-%d.png",i]]];}
        CCAnimation *richterRunAnim=[CCAnimation animationWithSpriteFrames:richterRunFrames delay:0.1f];
        self.runAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:richterRunAnim]];
        //run-stop
        NSMutableArray *richterRunStopFrames=[NSMutableArray array];
        for(int i =1; i <= 2; ++i) {[richterRunStopFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-runstop-%d.png",i]]];}
        CCAnimation *richterRunStopAnim=[CCAnimation animationWithSpriteFrames:richterRunStopFrames delay:0.1f];
        self.runStopAction = [CCAnimate actionWithAnimation:richterRunStopAnim];

        //walkstop
        NSMutableArray *richterWalkStopFrames=[NSMutableArray array];
        for(int i =1; i <= 4; ++i) {[richterWalkStopFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-walkstop-%d.png",i]]];}
        CCAnimation *richterWalkStopAnim=[CCAnimation animationWithSpriteFrames:richterWalkStopFrames delay:0.1f];
        self.walkStopAction = [CCAnimate actionWithAnimation:richterWalkStopAnim];
        //jumping
        NSMutableArray *richterJumpFrames=[NSMutableArray array];
        for(int i =1; i <= 7; ++i) {[richterJumpFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-jump-%d.png",i]]];}
        CCAnimation *richterJumpAnim=[CCAnimation animationWithSpriteFrames:richterJumpFrames delay:0.1f];
        self.jumpAction =[CCAnimate actionWithAnimation:richterJumpAnim];
        //jump-down
        NSMutableArray *richterJumpDownFrames=[NSMutableArray array];
        for(int i =1; i <= 2; ++i) {[richterJumpDownFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-jumpdown-%d.png",i]]];}
        CCAnimation *richterJumpDownAnim=[CCAnimation animationWithSpriteFrames:richterJumpDownFrames delay:0.3f];
        self.jumpDownAction =[CCAnimate actionWithAnimation:richterJumpDownAnim];
        //rollback
        NSMutableArray *richterRollBackFrames=[NSMutableArray array];
        for(int i =1; i <= 9; ++i) {[richterRollBackFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-rollback-%d.png",i]]];}
        CCAnimation *richterRollBackAnim=[CCAnimation animationWithSpriteFrames:richterRollBackFrames delay:0.1f];
        self.rollBackAction =[CCAnimate actionWithAnimation:richterRollBackAnim];
        //rollforward
        NSMutableArray *richterRollForwardFrames=[NSMutableArray array];
        for(int i =1; i <= 7; ++i) {[richterRollForwardFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-rollforward-%d.png",i]]];}
        CCAnimation *richterRollForwardAnim=[CCAnimation animationWithSpriteFrames:richterRollForwardFrames delay:0.1f];
        self.rollForwardAction =[CCAnimate actionWithAnimation:richterRollForwardAnim];
        //jumpstop
        NSMutableArray *richterJumpStopFrames=[NSMutableArray array];
        [richterJumpStopFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-jump-%d.png",8]]];
        for(int i =1; i <= 4; ++i) {[richterJumpStopFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-walkstop-%d.png",i]]];}
        CCAnimation *richterJumpStopAnim=[CCAnimation animationWithSpriteFrames:richterJumpStopFrames delay:0.2f];
        self.jumpStopAction =[CCAnimate actionWithAnimation:richterJumpStopAnim];
        //attack
        NSMutableArray *richterAttackFrames=[NSMutableArray array];
        for(int i =1; i <= 9; ++i) {[richterAttackFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-attack-%d.png",i]]];}
        CCAnimation *richterAttackAnim=[CCAnimation animationWithSpriteFrames:richterAttackFrames delay:0.1f];
        self.attackAction =[CCAnimate actionWithAnimation:richterAttackAnim];
        //walk-down-attack
        NSMutableArray *richterWalkDownAttackFrames=[NSMutableArray array];
        for(int i =1; i <= 9; ++i) {[richterWalkDownAttackFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-walkdownattack-%d.png",i]]];}
        CCAnimation *richterWalkDownAttackAnim=[CCAnimation animationWithSpriteFrames:richterWalkDownAttackFrames delay:0.1f];
        self.WalkDownAttackAction =[CCAnimate actionWithAnimation:richterWalkDownAttackAnim];
        //walk-up-attack
        NSMutableArray *richterWalkUpAttackFrames=[NSMutableArray array];
        for(int i =1; i <= 9; ++i) {[richterWalkUpAttackFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-walkupattack-%d.png",i]]];}
        CCAnimation *richterWalkUpAttackAnim=[CCAnimation animationWithSpriteFrames:richterWalkUpAttackFrames delay:0.1f];
        self.WalkUpAttackAction =[CCAnimate actionWithAnimation:richterWalkUpAttackAnim];
        //whipthrow
        NSMutableArray *attackWhipFrames=[NSMutableArray array];
        for(int i =1; i <= 7; ++i) {[attackWhipFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"attack-whip-%d.png",i]]];}
        CCAnimation *attackWhipAnim=[CCAnimation animationWithSpriteFrames:attackWhipFrames delay:0.1f];
        self.whipAction =[CCAnimate actionWithAnimation:attackWhipAnim];
        //rushing
        NSMutableArray *richterRushFrames=[NSMutableArray array];
        for(int i =1; i <= 8; ++i) {[richterRushFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-rush-%d.png",i]]];}
        CCAnimation *richterRushAnim=[CCAnimation animationWithSpriteFrames:richterRushFrames delay:0.1f];
        self.rushAction =[CCAnimate actionWithAnimation:richterRushAnim];
        //sun
        NSMutableArray *richterSunFrames=[NSMutableArray array];
        for(int i =1; i <= 22; ++i) {[richterSunFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-sun-%d.png",i]]];}
        CCAnimation *richterSunAnim=[CCAnimation animationWithSpriteFrames:richterSunFrames delay:0.1f];
        self.sunAction =[CCAnimate actionWithAnimation:richterSunAnim];
        //attack-up
        NSMutableArray *richterAttackUpFrames=[NSMutableArray array];
        for(int i =1; i <= 6; ++i) {[richterAttackUpFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-attackup-%d.png",i]]];}
        CCAnimation *richterAttackUpAnim=[CCAnimation animationWithSpriteFrames:richterAttackUpFrames delay:0.1f];
        self.attackUpAction =[CCAnimate actionWithAnimation:richterAttackUpAnim];
        //attack-up-stop
        NSMutableArray *richterAttackUpStopFrames=[NSMutableArray array];
        for(int i =1; i <= 4; ++i) {[richterAttackUpStopFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-attackupstop-%d.png",i]]];}
        CCAnimation *richterAttackUpStopAnim=[CCAnimation animationWithSpriteFrames:richterAttackUpStopFrames delay:0.1f];
        self.attackUpStopAction =[CCAnimate actionWithAnimation:richterAttackUpStopAnim];
        //crouch
        NSMutableArray *richterCrouchFrames=[NSMutableArray array];
        for(int i =1; i <= 3; ++i) {[richterCrouchFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-crouch-%d.png",i]]];}
        CCAnimation *richterCrouchAnim=[CCAnimation animationWithSpriteFrames:richterCrouchFrames delay:0.1f];
        self.crouchAction =[CCAnimate actionWithAnimation:richterCrouchAnim];
        //crouch-attacking
        NSMutableArray *richterCrouchAttackFrames=[NSMutableArray array];
        for(int i =1; i <= 7; ++i) {[richterCrouchAttackFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-crouchattack-%d.png",i]]];}
        [richterCrouchAttackFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-crouch-3.png"]]];
        CCAnimation *richterCrouchAttackAnim=[CCAnimation animationWithSpriteFrames:richterCrouchAttackFrames delay:0.1f];
        self.crouchAttackAction =[CCAnimate actionWithAnimation:richterCrouchAttackAnim];
        //sweeping-leg
        NSMutableArray *richterSweepingLegFrames=[NSMutableArray array];
        for(int i =1; i <= 7; ++i) {[richterSweepingLegFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-sweepingleg-%d.png",i]]];}
        CCAnimation *richterSweepingLegAnim=[CCAnimation animationWithSpriteFrames:richterSweepingLegFrames delay:0.1f];
        self.sweepingLegAction =[CCAnimate actionWithAnimation:richterSweepingLegAnim];
        //sweeping-leg-end
        NSMutableArray *richterSweepingLegEndFrames=[NSMutableArray array];
        for(int i =8; i <= 10; ++i) {[richterSweepingLegEndFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-sweepingleg-%d.png",i]]];}
        CCAnimation *richterSweepingLegEndAnim=[CCAnimation animationWithSpriteFrames:richterSweepingLegEndFrames delay:0.1f];
        self.sweepingLegEndAction =[CCAnimate actionWithAnimation:richterSweepingLegEndAnim];
        //swing-leg
        NSMutableArray *richterSwingLegFrames=[NSMutableArray array];
        for(int i =1; i <= 10; ++i) {[richterSwingLegFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-swingleg-%d.png",i]]];}
        CCAnimation *richterSwingLegAnim=[CCAnimation animationWithSpriteFrames:richterSwingLegFrames delay:0.1f];
        self.swingLegAction =[CCAnimate actionWithAnimation:richterSwingLegAnim];
        //point-sky
        NSMutableArray *richterPointSkyFrames=[NSMutableArray array];
        for(int i =1; i <= 4; ++i) {[richterPointSkyFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-pointsky-%d.png",i]]];}
        CCAnimation *richterPointSkyAnim=[CCAnimation animationWithSpriteFrames:richterPointSkyFrames delay:0.1f];
        self.pointSkyAction =[CCAnimate actionWithAnimation:richterPointSkyAnim];
        //hit
        NSMutableArray *richterHitFrames=[NSMutableArray array];
        for(int i =1; i <= 5; ++i) {[richterHitFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-hit-%d.png",i]]];}
        CCAnimation *richterHitAnim=[CCAnimation animationWithSpriteFrames:richterHitFrames delay:0.2f];
        self.hitAction =[CCAnimate actionWithAnimation:richterHitAnim];
        //crouch-hit
        NSMutableArray *richterCrouchHitFrames=[NSMutableArray array];
        for(int i =1; i <= 4; ++i) {[richterCrouchHitFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-crouchhit-%d.png",i]]];}
        CCAnimation *richterCrouchHitAnim=[CCAnimation animationWithSpriteFrames:richterCrouchHitFrames delay:0.2f];
        self.crouchHitAction =[CCAnimate actionWithAnimation:richterCrouchHitAnim];
        //jump-hit
        NSMutableArray *richterJumpHitFrames=[NSMutableArray array];
        for(int i =1; i <= 2; ++i) {[richterJumpHitFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-jumphit-%d.png",i]]];}
        CCAnimation *richterJumpHitAnim=[CCAnimation animationWithSpriteFrames:richterJumpHitFrames delay:0.2f];
        self.jumpHitAction =[CCAnimate actionWithAnimation:richterJumpHitAnim];
        //walkdown-hit
        NSMutableArray *richterWalkDownHitFrames=[NSMutableArray array];
        for(int i =1; i <= 5; ++i) {[richterWalkDownHitFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-walkdownhit-%d.png",i]]];}
        CCAnimation *richterWalkDownHitAnim=[CCAnimation animationWithSpriteFrames:richterWalkDownHitFrames delay:0.2f];
        self.walkDownHitAction =[CCAnimate actionWithAnimation:richterWalkDownHitAnim];
        //walkup-hit
        NSMutableArray *richterWalkUpHitFrames=[NSMutableArray array];
        for(int i =1; i <= 5; ++i) {[richterWalkUpHitFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-walkuphit-%d.png",i]]];}
        CCAnimation *richterWalkUpHitAnim=[CCAnimation animationWithSpriteFrames:richterWalkUpHitFrames delay:0.2f];
        self.walkUpHitAction =[CCAnimate actionWithAnimation:richterWalkUpHitAnim];
        //die
        NSMutableArray *richterDieFrames=[NSMutableArray array];
        for(int i =1; i <= 4; ++i) {[richterDieFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"richter-die-%d.png",i]]];}
        CCAnimation *richterDieAnim=[CCAnimation animationWithSpriteFrames:richterDieFrames delay:0.5f];
        self.dieAction =[CCAnimate actionWithAnimation:richterDieAnim];
    }
    return self;
}
-(void)dealloc
{
    holdAction=nil;
    walkAction=nil;walkStopAction=nil;walkDownAction=nil;walkUpAction=nil;
    jumpAction=nil;jumpDownAction=nil;jumpStopAction=nil;
    attackAction=nil;walkDownAttackAction=nil;walkUpAttackAction=nil;
    restAction=nil;
    runAction=nil;runStopAction=nil;
    rollBackAction=nil;
    rollForwardAction=nil;
    rushAction=nil;
    sunAction=nil;
    attackUpAction=nil;attackUpStopAction=nil;pointSkyAction=nil;
    crouchAction=nil;crouchAttackAction=nil;sweepingLegAction=nil;sweepingLegEndAction=nil;swingLegAction=nil;
    hitAction=nil;crouchHitAction=nil;jumpHitAction=nil;walkDownHitAction=nil;walkUpHitAction=nil;dieAction=nil;
    [super dealloc];
}
@end

