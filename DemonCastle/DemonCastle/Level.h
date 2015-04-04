//
//  Level.h
//  DemonCastle
//
//  Created by macbook on 13-6-19.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject {
    NSUserDefaults *myDefaults;
    int level,baseLife,baseMagic;
}

@property (nonatomic,assign) int nextLevelRequiredExp;
-(void)levelListener;
@end
