//
//  Level.m
//  DemonCastle
//
//  Created by macbook on 13-6-19.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Level.h"
@implementation Level
@synthesize nextLevelRequiredExp;

-(id)init
{
    if(self==[super init]){
        myDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}
-(void)levelListener
{
    int playerNowExp=[myDefaults integerForKey:@"playerScore"]/10;
    if (playerNowExp<10 && playerNowExp>0) {[myDefaults setInteger:1 forKey:@"playerLevel"];}
    if (playerNowExp>=10 && playerNowExp<30) {[myDefaults setInteger:2 forKey:@"playerLevel"];}
    if (playerNowExp>=30 && playerNowExp<60) {[myDefaults setInteger:3 forKey:@"playerLevel"];}
    if (playerNowExp>=60 && playerNowExp<120) {[myDefaults setInteger:4 forKey:@"playerLevel"];}
    if (playerNowExp>=120 && playerNowExp<240) {[myDefaults setInteger:5 forKey:@"playerLevel"];}
    
    level=[myDefaults integerForKey:@"playerLevel"];
    if(level==1){baseLife=20;baseMagic=100;nextLevelRequiredExp=10;}
    else if(level==2){baseLife=22;baseMagic=110;nextLevelRequiredExp=30;}
    else if(level==3){baseLife=25;baseMagic=120;nextLevelRequiredExp=60;}
    else if(level==4){baseLife=29;baseMagic=130;nextLevelRequiredExp=120;}
    else if(level==5){baseLife=44;baseMagic=140;nextLevelRequiredExp=240;}
    
    [myDefaults setFloat:baseLife forKey:@"playerTotleLife"];[myDefaults setFloat:baseMagic forKey:@"playerTotleMagic"];
    
}
@end