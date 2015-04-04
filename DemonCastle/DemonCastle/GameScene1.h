//
//  GameScence1.h
//  DemonCastle
//
//  Created by macbook on 13-5-12.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "b2ContactManager.h"

#import "GameHud.h"
#import "ActionAnim.h"
#import "Zombie.h"

@interface GameScene1 : CCLayer <UIApplicationDelegate>//<GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    NSUserDefaults *myDefaults;
    float curLife,curMagic;
    int playerScore;

	CCTexture2D *spriteTexture_;	// weak ref
	b2World* world;					// strong ref
	GLESDebugDraw *m_debugDraw;		// strong ref
    
    CCTMXTiledMap *tileMap;
    CCSprite *player;
    CCSprite *weapon;
    Zombie *monster;
    
    b2Body *playerbody;
    b2Body *platformbody[2];
    b2Body *rhbbody[10];
    b2Body *lhbbody[10];
    CCSprite *platformSprite;
    b2ContactListener *contactListener;
    
    GameHud *_hud;
    ActionAnim *chooseAction;
    
    bool moving;
    bool longmoving,jumping,crouching;
    int  timer;          //切换holding状态计时器
    bool timerIsLock;
    int  walkStauts;     //状态0是平地，状态1是上楼，状态2是下楼
    bool walkStauts0Lock,walkStauts1Lock,walkStauts2Lock;
    bool hitLock;
    bool crouchAttackCanBeActive;
    bool swingLeg,rush;
}
+(CCScene *) scene;
@property (nonatomic, retain) GameHud *hud;

-(void)rightButtonTapped;
-(void)rightButtonDoubleTapped;
-(void)rightButtonLongPress;
-(void)rightButtonSwipeToRight;
-(void)rightButtonSwipeToDown;
-(void)rightButtonSwipeToLeft;
-(void)rightButtonSwipeToUp;
-(void)leftButtonTapped;
-(void)leftButtonDoubleTapped;
-(void)leftButtonLongPress;
-(void)leftButtonSwipeToLeft;
-(void)leftButtonSwipeToDown;
-(void)leftButtonSwipeToRight;
-(void)leftButtonSwipeToUp;
-(void)middleButtonDoubleTapped;
-(void)playerMoveEnded;

-(void)rightBottomButtonTapped;
-(void)rightBottomButtonDoubleTapped;
-(void)rightBottomButtonLongPress;
-(void)rightBottomButtonPan;
-(void)leftBottomButtonTapped;
-(void)leftBottomButtonDoubleTapped;
-(void)leftBottomButtonLongPress;
-(void)leftBottomButtonPan;
@end

