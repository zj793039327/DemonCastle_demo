//
//  settings.h
//  DemonCastle
//
//  Created by 尚德机构 on 13-5-31.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Level.h"

@interface settings : CCLayer{
    UIView *AllView;
    
    Level *level;
    CCSprite * _background;
}
+(CCScene *) scene;
@end
