//
//  GameHud.h
//  DemonCastle
//
//  Created by macbook on 13-5-12.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Level;
@class GameScene0, GameScene1, GameScene2,GameScene3;
@interface GameHud : CCLayer <UIGestureRecognizerDelegate>{
    NSUserDefaults *myDefaults;
    
    UIView *rightButtonView;
    UIView *leftButtonView;
    UIView *middleButtonView;
    UIView *rightBottomButtonView;
    UIView *leftBottomButtonView;
    UIButton *settingsButton;
    Level *level;
    CCMenuItemSprite *MenuItemLevelNumber0,*MenuItemLevelNumber1;
    CCMenuItemSprite *MenuItemLife,*MenuItemMagic;
    CCMenuItemSprite *MenuItemScoreNumber1,*MenuItemScoreNumber2,*MenuItemScoreNumber3,*MenuItemScoreNumber4,*MenuItemScoreNumber5,*MenuItemScoreNumber6;
   
    GameScene0 *_gameLayer0;GameScene1 *_gameLayer1;GameScene2 *_gameLayer2;GameScene3 *_gameLayer3;

}
@property (nonatomic, retain) GameScene0 *gameLayer0;
@property (nonatomic, retain) GameScene1 *gameLayer1;
@property (nonatomic, retain) GameScene2 *gameLayer2;
@property (nonatomic, retain) GameScene3 *gameLayer3;
@end