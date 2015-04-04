//
//  Zombie.h
//  DemonCastle
//
//  Created by 尚德机构 on 13-5-20.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Zombie : CCSprite {
    CCSprite *zombieLeg;
    CCSprite *zombieHead;
    CCSprite *zombieWaist;
    CCAction *zombieWalkAction;
    CCAction *zombieHeadAction;
    CCSprite *blood;
}

@property (nonatomic,retain)CCSprite *zombieLeg;
@property (nonatomic,retain)CCSprite *zombieHead;
@property (nonatomic,retain)CCSprite *zombieWaist;
@property (nonatomic,retain)CCAction *zombieWalkAction;
@property (nonatomic,retain)CCAction *zombieHeadAction;

-(void)ZombieHit;
@end
