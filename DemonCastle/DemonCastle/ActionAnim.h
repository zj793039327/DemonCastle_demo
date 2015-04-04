//
//  ActionAnim.h
//  DemonCastle
//
//  Created by macbook on 13-5-12.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ActionAnim : CCNode {
    CCAction *holdAction,*restAction;
    CCAction *walkAction,*runAction,*walkDownAction,*walkUpAction;
    CCAction *walkStopAction,*jumpStopAction,*runStopAction,*attackUpStopAction;
    CCAction *jumpAction,*jumpDownAction,*rollBackAction,*rollForwardAction;
    CCAction *attackAction,*rushAction,*sunAction,*attackUpAction,*pointSkyAction,*walkDownAttackAction,*walkUpAttackAction;
    CCAction *crouchAction,*crouchAttackAction,*sweepingLegAction,*sweepingLegEndAction,*swingLegAction;
    CCAction *whipAction;
    CCAction *hitAction,*crouchHitAction,*jumpHitAction,*walkDownHitAction,*walkUpHitAction,*dieAction;
}
@property(nonatomic,retain)CCAction *holdAction,*restAction;
@property(nonatomic,retain)CCAction *walkAction,*runAction,*walkDownAction,*walkUpAction;
@property(nonatomic,retain)CCAction *walkStopAction,*jumpStopAction,*runStopAction,*attackUpStopAction;
@property(nonatomic,retain)CCAction *jumpAction,*jumpDownAction,*rollBackAction,*rollForwardAction;
@property(nonatomic,retain)CCAction *attackAction,*rushAction,*sunAction,*attackUpAction,*pointSkyAction,*walkDownAttackAction,*walkUpAttackAction;
@property(nonatomic,retain)CCAction *crouchAction,*crouchAttackAction,*sweepingLegAction,*sweepingLegEndAction,*swingLegAction;
@property(nonatomic,retain)CCAction *whipAction;
@property(nonatomic,retain)CCAction *hitAction,*crouchHitAction,*jumpHitAction,*walkDownHitAction,*walkUpHitAction,*dieAction;
@end
