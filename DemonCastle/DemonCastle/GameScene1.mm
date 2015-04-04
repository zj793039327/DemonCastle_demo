//
//  GameScence1.m
//  DemonCastle
//
//  Created by macbook on 13-5-12.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//
#import "GameScene1.h"

#import "IntroLayer.h"
#import "AppDelegate.h"
#import "b2Contact.h"
#import "GameScene0.h"
#import "GameScene2.h"

@implementation GameScene1
@synthesize hud = _hud;

#pragma mark -
#pragma mark scene
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	GameScene1 *layer = [GameScene1 node];
	[scene addChild: layer];
    
    GameHud *hud = [GameHud node];
    [scene addChild: hud];
    layer.hud = hud;
    hud.gameLayer1 = layer;
	return scene;
}

#pragma mark -
#pragma mark box2d-world
-(void) setupPhysicsWorld {
    b2Vec2 gravity = b2Vec2(0.0f, -9.8f);
    world = new b2World(gravity);
    world->SetAllowSleeping(true);
    world->SetContinuousPhysics(true);
    m_debugDraw = new GLESDebugDraw(PTM_RATIO);
    world->SetDebugDraw(m_debugDraw);
    uint32 flags = 0;
    flags += b2Draw::e_shapeBit;
    m_debugDraw->SetFlags(flags);
    contactListener = new b2ContactListener();
    world->SetContactListener(contactListener);
}
-(void) createBox2dObjectForPlayer{
    b2BodyDef playerBodyDef;
	playerBodyDef.type = b2_dynamicBody;
	playerBodyDef.position.Set(player.position.x/PTM_RATIO, player.position.y/PTM_RATIO);
	playerBodyDef.userData = player;
	playerBodyDef.fixedRotation = true;
	playerbody = world->CreateBody(&playerBodyDef);
    //--------------------------------------------------------------------
    b2PolygonShape dynamicBox;
    int num = 6;
    b2Vec2 verts[] = {b2Vec2(-0.35f, 0.1f),
        b2Vec2(-0.05f, -0.6f),
        b2Vec2(0.05f, -0.6f),
        b2Vec2(0.35f, 0.1f),
        b2Vec2(0.2f, 0.5f),
        b2Vec2(-0.2f, 0.5f)};
    dynamicBox.Set(verts, num);
    //--------------------------------------------------------------------
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &dynamicBox;
	fixtureDef.density = 2.0f;
	fixtureDef.friction = 0.5f;
	fixtureDef.restitution =  0.2f;
	playerbody->CreateFixture(&fixtureDef);
}
-(void) createBox2dObjectForPlayerCrouch{
    b2BodyDef playerBodyDef;
	playerBodyDef.type = b2_dynamicBody;
	playerBodyDef.position.Set(player.position.x/PTM_RATIO, player.position.y/PTM_RATIO);
	playerBodyDef.userData = player;
	playerBodyDef.fixedRotation = true;
	playerbody = world->CreateBody(&playerBodyDef);
    //--------------------------------------------------------------------
    b2PolygonShape dynamicBox;
    int num = 4;
    b2Vec2 verts[] = {b2Vec2(-0.3f, 0.0f),
        b2Vec2(-0.3f, -0.6f),
        b2Vec2(0.3f, -0.6f),
        b2Vec2(0.3f, 0.0f)};
    dynamicBox.Set(verts,num);
    //--------------------------------------------------------------------
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &dynamicBox;
	fixtureDef.density = 2.0f;
	fixtureDef.friction = 0.5f;
	fixtureDef.restitution =  0.2f;
	playerbody->CreateFixture(&fixtureDef);
}
-(void) createBox2dObjectForPlayerCrouchAttack{
    b2BodyDef playerBodyDef;
	playerBodyDef.type = b2_dynamicBody;
	playerBodyDef.position.Set(player.position.x/PTM_RATIO, player.position.y/PTM_RATIO);
	playerBodyDef.userData = player;
	playerBodyDef.fixedRotation = true;
	playerbody = world->CreateBody(&playerBodyDef);
    //--------------------------------------------------------------------
    b2PolygonShape dynamicBox;
    int num = 6;
    b2Vec2 verts[] = {b2Vec2(-0.35f, 0.1f),
        b2Vec2(-0.05f, -0.36f),
        b2Vec2(0.05f, -0.36f),
        b2Vec2(0.35f, 0.1f),
        b2Vec2(0.2f, 0.5f),
        b2Vec2(-0.2f, 0.5f)};
    dynamicBox.Set(verts, num);
    //--------------------------------------------------------------------
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &dynamicBox;
	fixtureDef.density = 2.0f;
	fixtureDef.friction = 0.5f;
	fixtureDef.restitution =  0.2f;
	playerbody->CreateFixture(&fixtureDef);
}

- (void) makeBox2dObjAt:(CGPoint)p withSize:(CGPoint)size
{
	b2BodyDef bodyDef;
	bodyDef.type = b2_staticBody;
	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
    CCSprite *groundBox = [[CCSprite alloc] init];
	bodyDef.userData = groundBox;
	b2Body *body = world->CreateBody(&bodyDef);
	b2PolygonShape dynamicBox;
	dynamicBox.SetAsBox(size.x/2/PTM_RATIO, size.y/2/PTM_RATIO);
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &dynamicBox;
	fixtureDef.density = 0;
	fixtureDef.friction = 0.5;
	fixtureDef.restitution = 0;
	body->CreateFixture(&fixtureDef);
}
- (void) drawRectCollisionTiles {
	CCTMXObjectGroup *objects = [tileMap objectGroupNamed:@"Collision"];
    CCTMXObjectGroup *objects1 = [tileMap objectGroupNamed:@"Collision1"];
    CCTMXObjectGroup *objects2 = [tileMap objectGroupNamed:@"Collision2"];
	NSMutableDictionary * objPoint;
	int x, y, w, h;
    int i=0,j=0;
	for (objPoint in [objects objects]) {
		x = [[objPoint valueForKey:@"x"] intValue];
		y = [[objPoint valueForKey:@"y"] intValue];
		w = [[objPoint valueForKey:@"width"] intValue];
		h = [[objPoint valueForKey:@"height"] intValue];
		CGPoint _point=ccp(x+w/2,y+h/2);
		CGPoint _size=ccp(w,h);
		[self makeBox2dObjAt:_point withSize:_size];
	}
    for (objPoint in [objects1 objects]) {
		x = [[objPoint valueForKey:@"x"] intValue];
		y = [[objPoint valueForKey:@"y"] intValue];
		w = [[objPoint valueForKey:@"width"] intValue];
		h = [[objPoint valueForKey:@"height"] intValue];
		CGPoint _point=ccp(x+w/2,y+h/2);
		CGPoint _size=ccp(w,h);
        b2BodyDef bodyDef;
        bodyDef.type = b2_staticBody;
        bodyDef.position.Set(_point.x/PTM_RATIO, _point.y/PTM_RATIO);
        CCSprite *rightHalfBoxSprite = [[CCSprite alloc] init];
        bodyDef.userData = rightHalfBoxSprite;
        rhbbody[i] = world->CreateBody(&bodyDef);
        b2PolygonShape dynamicBox;
        int num = 4;
        b2Vec2 verts[] = {b2Vec2(-_size.x/2/PTM_RATIO, -_size.y/2/PTM_RATIO),
            b2Vec2(_size.x/2/PTM_RATIO, -_size.y/2/PTM_RATIO),
            b2Vec2(_size.x/2/PTM_RATIO, _size.y/2/PTM_RATIO),
            b2Vec2((_size.x/2-3)/PTM_RATIO, _size.y/2/PTM_RATIO)};
        dynamicBox.Set(verts, num);
        b2FixtureDef fixtureDef;
        fixtureDef.shape = &dynamicBox;
        fixtureDef.density = 0;
        fixtureDef.friction = 0.0;
        fixtureDef.restitution = 0;
        rhbbody[i]->CreateFixture(&fixtureDef);
        i++;
	}
    for (objPoint in [objects2 objects]) {
		x = [[objPoint valueForKey:@"x"] intValue];
		y = [[objPoint valueForKey:@"y"] intValue];
		w = [[objPoint valueForKey:@"width"] intValue];
		h = [[objPoint valueForKey:@"height"] intValue];
		CGPoint _point=ccp(x+w/2,y+h/2);
		CGPoint _size=ccp(w,h);
        b2BodyDef bodyDef;
        bodyDef.type = b2_staticBody;
        bodyDef.position.Set(_point.x/PTM_RATIO, _point.y/PTM_RATIO);
        CCSprite *leftHalfBoxSprite = [[CCSprite alloc] init];
        bodyDef.userData = leftHalfBoxSprite;
        lhbbody[j] = world->CreateBody(&bodyDef);
        b2PolygonShape dynamicBox;
        int num = 4;
        b2Vec2 verts[] = {b2Vec2(-_size.x/2/PTM_RATIO, -_size.y/2/PTM_RATIO),
            b2Vec2(_size.x/2/PTM_RATIO, -_size.y/2/PTM_RATIO),
            b2Vec2((3-_size.x/2)/PTM_RATIO, _size.y/2/PTM_RATIO),
            b2Vec2(-_size.x/2/PTM_RATIO, _size.y/2/PTM_RATIO)};
        dynamicBox.Set(verts, num);
        b2FixtureDef fixtureDef;
        fixtureDef.shape = &dynamicBox;
        fixtureDef.density = 0;
        fixtureDef.friction = 0.0;
        fixtureDef.restitution = 0;
        lhbbody[j]->CreateFixture(&fixtureDef);
        j++;
	}
}
-(void)createAllPlatformbody
{
    CCTMXObjectGroup *objects3 = [tileMap objectGroupNamed:@"Collision3"];
    NSMutableDictionary * objPoint;
    int i=0;
    int x, y, w, h;
    for (objPoint in [objects3 objects]) {
        x = [[objPoint valueForKey:@"x"] intValue];
        y = [[objPoint valueForKey:@"y"] intValue];
        w = [[objPoint valueForKey:@"width"] intValue];
        h = [[objPoint valueForKey:@"height"] intValue];
        CGPoint _point=ccp(x+w/2,y+h/2);
        CGPoint _size=ccp(w,h);
        b2BodyDef bodyDef;
        bodyDef.position.Set(_point.x/PTM_RATIO, _point.y/PTM_RATIO);
        platformSprite = [[CCSprite alloc] init];
        bodyDef.userData = platformSprite;
        platformbody[i] = world->CreateBody(&bodyDef);
        b2PolygonShape dynamicBox;
        dynamicBox.SetAsBox(_size.x/2/PTM_RATIO, _size.y/2/PTM_RATIO);
        b2FixtureDef fixtureDef;
        fixtureDef.shape = &dynamicBox;
        fixtureDef.density = 0;
        fixtureDef.friction = 0.5;
        fixtureDef.restitution = 0;
        platformbody[i]->CreateFixture(&fixtureDef);
        i++;
    }
}
-(void)destroyAllPlatformbody
{
    int i=0;
    CCTMXObjectGroup *objects3 = [tileMap objectGroupNamed:@"Collision3"];
    NSMutableDictionary * objPoint;
    for (objPoint in [objects3 objects]) {
        if(platformbody[i]!=NULL){
            platformbody[i]->SetUserData(NULL);
            [self removeChild:platformSprite cleanup:YES];
            world->DestroyBody(platformbody[i]);
            i++;
        }
    }
}

#pragma mark -
#pragma mark init
-(id) init
{
	if( (self=[super init])) {
        myDefaults = [NSUserDefaults standardUserDefaults];
        curLife=[myDefaults floatForKey:@"playerCurLife"];
        curMagic=[myDefaults floatForKey:@"playerCurMagic"];
        playerScore=[myDefaults integerForKey:@"playerScore"];
		self.isTouchEnabled = NO;
        moving=NO;
        longmoving=NO;
        timerIsLock=NO;
        tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"gamescene1.tmx"];
        CCTMXLayer *_background1 = [tileMap layerNamed:@"Background1"];
        CCTMXLayer *_background2 = [tileMap layerNamed:@"Background2"];
        CCTMXLayer *_foreground = [tileMap layerNamed:@"Foreground"];
        [_foreground setZOrder:-1];
        [_background1 setZOrder:-2];
        [_background2   setZOrder:-3];
        tileMap.anchorPoint = ccp(0, 0);
        //-------------------------------
        _background1.scale=winSCALE;
        _background2.scale=winSCALE;
        _foreground.scale=winSCALE;
        //-------------------------------
        [self addChild:tileMap z:-1];
        [self setupPhysicsWorld];
		[self drawRectCollisionTiles];
        [self createAllPlatformbody];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"richter.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"richter.png"];
        [self addChild:spriteSheet];
        player = [CCSprite spriteWithSpriteFrameName:@"richter-1.png"];
        float startX=[myDefaults floatForKey:@"startX"];
        float startY=[myDefaults floatForKey:@"startY"];
        bool startFace=[myDefaults boolForKey:@"startFace"];
        CCLOG(@"startPosition=(%.2f,%.2f)",startX,startY);
        player.flipX=startFace;
        player.position = ccp(startX, startY);
        [self createBox2dObjectForPlayer];
        //-------------------------------
        player.scale=winSCALE;
        //-------------------------------
        [self addChild:player];
        [self setViewpointCenter:player.position];
        chooseAction=[[ActionAnim alloc] init];
        [self scheduleUpdate];
        [self schedule:@selector(canPlayerRunHolding) interval:0.1];
	}
	return self;
}
-(void) update: (ccTime) dt
{
	float maxX=max(-150, player.position.x/1.2-350);
    maxX=min(maxX,720);
    CCTMXLayer *_background1 = [tileMap layerNamed:@"Background1"];
	[_background1 setPosition:ccp(maxX/8,0)];
    CCTMXLayer *_background2 = [tileMap layerNamed:@"Background2"];
	[_background2 setPosition:ccp(maxX,0)];
    int32 velocityIterations = 8;
	int32 positionIterations = 1;
	world->Step(dt, velocityIterations, positionIterations);
	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext()) {
		if (b->GetUserData() ==player) {
			CCSprite *myActor = (CCSprite*)b->GetUserData();
			myActor.position = CGPointMake( b->GetPosition().x * PTM_RATIO,b->GetPosition().y * PTM_RATIO);
			myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
		}
	}
    //------------------------------------------------------------------------------
    if(curMagic<[myDefaults floatForKey:@"playerTotleMagic"])curMagic=curMagic+0.01f;
    [myDefaults setFloat:curMagic forKey:@"playerCurMagic"];
    //------------------------------------------------------------------------------
    int i=0,j=0;
    walkStauts=0;
    CCTMXObjectGroup *objects1 = [tileMap objectGroupNamed:@"Collision1"];
    CCTMXObjectGroup *objects2 = [tileMap objectGroupNamed:@"Collision2"];
    NSMutableDictionary * objPoint;
    for (objPoint in [objects1 objects]) {
        if(rhbbody[i]->GetContactList()){
            if(longmoving && player.flipX==NO){
                playerbody->SetLinearVelocity(b2Vec2(2.0f, 0.0f));
                walkStauts=1;
            }
            if(longmoving && player.flipX==YES){
                playerbody->SetLinearVelocity(b2Vec2(-2.0f, -2.5f));
                walkStauts=2;
            }
            if(!moving){
                playerbody->SetLinearVelocity(b2Vec2(0.0f, -4.9f));
                walkStauts=0;
            }
        } else {i++;}
    }
    for (objPoint in [objects2 objects]) {
        if(lhbbody[j]->GetContactList()){
            if(longmoving && player.flipX==NO){
                playerbody->SetLinearVelocity(b2Vec2(2.0f, -2.5f));
                walkStauts=2;
            }
            if(longmoving && player.flipX==YES){
                playerbody->SetLinearVelocity(b2Vec2(-2.0f, 0.0f));
                walkStauts=1;
            }
            if(!moving){
                playerbody->SetLinearVelocity(b2Vec2(0.0f, -4.9f));
                walkStauts=0;
            }
        } else {j++;}
    }
    //------------------------------------------------------------------------------
    [self setViewpointCenter:player.position];
    //------------------------------------------------------------------------------
    CGRect playerRect=CGRectMake(player.position.x-11, player.position.y-22, 22, 45);
    if(crouching){playerRect=CGRectMake(player.position.x-11, player.position.y-22, 22, 22);}
    CGRect monsterRect=CGRectMake(monster.position.x-10,monster.position.y-20,21,40);
    if(monster && CGRectIntersectsRect(playerRect,monsterRect)){[self playerHit];}
    if(rush){if(monster && CGRectIntersectsRect(playerRect,monsterRect)){[self monsterHit];}}
    //------------------------------------------------------------------------------
    if(longmoving){
        if(!playerbody->GetContactList()){
            [self playerMoveEnded];
        }
    }
    if(player.position.x<0) {
        [myDefaults setFloat:600.0f forKey:@"startX"];
        [myDefaults setFloat:220.0f forKey:@"startY"];
        [myDefaults setBool:YES forKey:@"startFace"];
        [[CCDirector sharedDirector] runWithScene:[GameScene0 scene]];
    }
    if(player.position.x>1530) {
        [myDefaults setFloat:20.0f forKey:@"startX"];
        [myDefaults setFloat:380.0f forKey:@"startY"];
        [myDefaults setBool:NO forKey:@"startFace"];
        [[CCDirector sharedDirector] runWithScene:[GameScene2 scene]];
    }
}
-(void)setViewpointCenter:(CGPoint) position {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    int x = MAX(position.x, winSize.width / 2);
    int y = MAX(position.y, winSize.height / 2);
    x = MIN(x, (tileMap.mapSize.width * tileMap.tileSize.width)- winSize.width / 2);
    y = MIN(y, (tileMap.mapSize.height * tileMap.tileSize.height) - winSize.height/2+65);
    CGPoint actualPosition = ccp(x, y);
    CGPoint centerOfView = ccp(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
    self.position = viewPoint;
}
-(void)canPlayerRunHolding
{
    if(!moving && !timerIsLock){
        timer++;
        timer=timer%5;
        if(timer==4){
            [player runAction:chooseAction.holdAction];
            timerIsLock=YES;
        }
    }
    if (moving) {
        timer=0;
        timerIsLock=NO;
    }
}

#pragma mark -
#pragma mark create-monster
-(void)onEnter
{
    [super onEnter];
    [self createMonster];
}
-(void)createMonster
{
    if(!monster){
        int randomX=arc4random()%200;
        if(player.flipX==NO){
            monster=[[Zombie alloc] init];
            monster.position=ccp(min(player.position.x+100+randomX,1399.99),21);
            monster.zombieLeg.flipX=NO;
            monster.zombieHead.flipX=NO;
            [self addChild:monster];
        } else {
            monster=[[Zombie alloc] init];
            monster.position=ccp(max(player.position.x-100-randomX,120.11),21);
            monster.zombieLeg.flipX=YES;
            monster.zombieHead.flipX=YES;
            [self addChild:monster];
        }
    }
    [self monsterUpdate];
}
-(void)monsterUpdate
{
    if(monster){
        float distance=player.position.x-monster.position.x;
        if(distance<0)distance=-distance;
        if(weapon){
            [monster runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.2],
                                [CCDelayTime actionWithDuration:distance/500],
                                [CCCallFunc actionWithTarget:self selector:@selector(monsterHit)],nil]];
        }
        if(swingLeg){
            [monster runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.2],
                                [CCCallFunc actionWithTarget:self selector:@selector(monsterHit)],nil]];
        }
        if(monster.position.x<player.position.x){
            monster.zombieLeg.flipX=YES;
            monster.zombieHead.flipX=YES;
            monster.zombieHead.position =ccpAdd(monster.zombieWaist.position, ccp(6.0f,-2.0f));
            
        } else {
            monster.zombieLeg.flipX=NO;
            monster.zombieHead.flipX=NO;
            monster.zombieHead.position =ccpAdd(monster.zombieWaist.position, ccp(-6.0f,-2.0f));
        }
        if(distance>400){
            [self removeChild:monster cleanup:YES];
            monster=nil;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,1*NSEC_PER_SEC),dispatch_get_main_queue(),^(void){[self createMonster];});
        }
        id actionMove = [CCMoveBy actionWithDuration:0.5 position:ccpMult(ccpNormalize(ccp(min(max(120,player.position.x),1400)-monster.position.x,0)), 5)];
        id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(monsterUpdate)];
        [monster runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
    }
}
-(void)monsterHit
{
    CGRect weaponToRightRect,weaponToLeftRect;
    if (crouchAttackCanBeActive) {
        weaponToRightRect=CGRectMake(player.position.x-10,player.position.y-15,100,10);
        weaponToLeftRect=CGRectMake(player.position.x-110,player.position.y-15,100,10);
    } else if(swingLeg){
        weaponToRightRect=CGRectMake(player.position.x-10,player.position.y-22,45,45);
        weaponToLeftRect=CGRectMake(player.position.x-35,player.position.y-22,45,45);
    } else {
        weaponToRightRect=CGRectMake(player.position.x+10,player.position.y,100,10);
        weaponToLeftRect=CGRectMake(player.position.x-110,player.position.y,100,10);
    }
    CGRect monsterRect=CGRectMake(monster.position.x-10,monster.position.y-20,21,40);
    if(player.flipX==NO && CGRectIntersectsRect(weaponToRightRect,monsterRect)){
        [monster stopAllActions];
        [monster ZombieHit];
        playerScore=playerScore+10;
        [myDefaults setInteger:playerScore forKey:@"playerScore"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,1*NSEC_PER_SEC),dispatch_get_main_queue(),^(void){
            [self removeChild:monster cleanup:YES];
            monster=nil;
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,5*NSEC_PER_SEC),dispatch_get_main_queue(),^(void){[self createMonster];});
    }
    if(player.flipX==YES && CGRectIntersectsRect(weaponToLeftRect,monsterRect)){
        [monster stopAllActions];
        [monster ZombieHit];
        playerScore=playerScore+10;
        [myDefaults setInteger:playerScore forKey:@"playerScore"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,1*NSEC_PER_SEC),dispatch_get_main_queue(),^(void){
            [self removeChild:monster cleanup:YES];
            monster=nil;
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,5*NSEC_PER_SEC),dispatch_get_main_queue(),^(void){[self createMonster];});
  
    }
}
-(void)playerHit
{
    int i=0,j=0,hitWay=0;
    CCTMXObjectGroup *objects1 = [tileMap objectGroupNamed:@"Collision1"];
    CCTMXObjectGroup *objects2 = [tileMap objectGroupNamed:@"Collision2"];
    NSMutableDictionary * objPoint;
    if(hitLock==NO && monster.zombieHead.flipX==NO){
        hitLock=YES;moving=YES;
        curLife=curLife-2.0f;[myDefaults setFloat:curLife forKey:@"playerCurLife"];
        player.flipX=NO;
        if(!jumping){
            [player stopAllActions];
            playerbody->SetLinearVelocity(b2Vec2(-4,0));
            //----------------------------------------------------------------------
            if(crouching && hitWay==0){
                world->DestroyBody(playerbody);[self createBox2dObjectForPlayer];
                playerbody->SetLinearVelocity(b2Vec2(-4,0));
                [player runAction:chooseAction.crouchHitAction];
                hitWay=3;
            }
            for (objPoint in [objects1 objects]) {
                if(rhbbody[i]->GetContactList() && hitWay==0){
                    [player runAction:chooseAction.walkUpHitAction];
                    hitWay=1;
                }else{i++;}
            }
            for (objPoint in [objects2 objects]) {
                if(lhbbody[j]->GetContactList() && hitWay==0){
                    [player runAction:chooseAction.walkDownHitAction];
                    hitWay=2;
                }else{j++;}
            }
            if(hitWay==0){[player runAction:chooseAction.hitAction];}
            //------------------------------------------------------------------
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,1*NSEC_PER_SEC),dispatch_get_main_queue(),^(void){hitLock=NO,moving=NO;});
        } else {
            [player stopAllActions];
            [player runAction:chooseAction.jumpHitAction];
            playerbody->SetLinearVelocity(b2Vec2(-3,3));
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,2*NSEC_PER_SEC),dispatch_get_main_queue(),^(void){hitLock=NO;moving=NO;});
        }
    }
    if(hitLock==NO && monster.zombieHead.flipX==YES){
        hitLock=YES;moving=YES;
        curLife=curLife-2.0f;[myDefaults setFloat:curLife forKey:@"playerCurLife"];
        player.flipX=YES;
        if(!jumping){
            [player stopAllActions];
            playerbody->SetLinearVelocity(b2Vec2(4,0));
            //----------------------------------------------------------------------
            if(crouching && hitWay==0){
                world->DestroyBody(playerbody);[self createBox2dObjectForPlayer];
                playerbody->SetLinearVelocity(b2Vec2(4,0));
                [player runAction:chooseAction.crouchHitAction];
                hitWay=3;
            }
            for (objPoint in [objects1 objects]) {
                if(rhbbody[i]->GetContactList()  && hitWay==0){
                    [player runAction:chooseAction.walkDownHitAction];
                    hitWay=2;
                }else{i++;}
            }
            for (objPoint in [objects2 objects]) {
                if(lhbbody[j]->GetContactList() && hitWay==0){
                    [player runAction:chooseAction.walkUpHitAction];
                    hitWay=1;
                }else{j++;}
            }
            if(hitWay==0){[player runAction:chooseAction.hitAction];}
            //------------------------------------------------------------------
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,1*NSEC_PER_SEC),dispatch_get_main_queue(),^(void){hitLock=NO;moving=NO;});
        } else {
            [player stopAllActions];
            [player runAction:chooseAction.jumpHitAction];
            playerbody->SetLinearVelocity(b2Vec2(3,3));
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,2*NSEC_PER_SEC),dispatch_get_main_queue(),^(void){hitLock=NO;moving=NO;});
        }
    }
}

#pragma mark -
#pragma mark controll
-(void)rightButtonTapped
{
    if(moving==NO){
        moving=YES;
        player.flipX=NO;
        [player stopAllActions];
        [player runAction:chooseAction.walkAction];
        [player runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.3],[CCCallFunc actionWithTarget:self selector:@selector(playerMoveEnded)],nil]];
        playerbody->SetLinearVelocity(b2Vec2(2.0f, 0.0f));
    }
}
-(void)leftButtonTapped
{
    if(moving==NO){
        moving=YES;
        player.flipX=YES;
        [player stopAllActions];
        [player runAction:chooseAction.walkAction];
        [player runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.3],[CCCallFunc actionWithTarget:self selector:@selector(playerMoveEnded)],nil]];
        playerbody->SetLinearVelocity(b2Vec2(-2.0f, 0.0f));
    }
}
-(void)rightButtonDoubleTapped
{
    if(moving==NO){
        moving=YES;jumping=YES;
        player.flipX=NO;
        [player stopAllActions];
        [player runAction:chooseAction.jumpAction];
        playerbody->SetLinearVelocity(b2Vec2(0.0f, -4.9f));
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            playerbody->SetLinearVelocity(b2Vec2(2.5f, 6.0f));
            [self destroyAllPlatformbody];
        });
        dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){
            [player stopAllActions];[player runAction:chooseAction.jumpStopAction];
            [self createAllPlatformbody];
            [player runAction:[CCSequence actions:[CCCallFunc actionWithTarget:self selector:@selector(playerJumpEnded)],nil]];
        });
    }
}
-(void)leftButtonDoubleTapped
{
    if(moving==NO){
        moving=YES;jumping=YES;
        player.flipX=YES;
        [player stopAllActions];
        [player runAction:chooseAction.jumpAction];
        playerbody->SetLinearVelocity(b2Vec2(0.0f, -4.9f));
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            playerbody->SetLinearVelocity(b2Vec2(-2.5f, 6.0f));
            [self destroyAllPlatformbody];
        });
        dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){
            [player stopAllActions];[player runAction:chooseAction.jumpStopAction];
            [self createAllPlatformbody];
            [player runAction:[CCSequence actions:[CCCallFunc actionWithTarget:self selector:@selector(playerJumpEnded)],nil]];
        });
    }
}
-(void)middleButtonDoubleTapped
{
    if(moving==NO){
        moving=YES;jumping=YES;
        [player stopAllActions];
        [player runAction:chooseAction.jumpAction];
        playerbody->SetLinearVelocity(b2Vec2(0.0f, -4.9f));
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            playerbody->SetLinearVelocity(b2Vec2(0.0f, 7.0f));
            [self destroyAllPlatformbody];
        });
        dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){
            [player stopAllActions];[player runAction:chooseAction.jumpStopAction];
            [self createAllPlatformbody];
            [player runAction:[CCSequence actions:[CCCallFunc actionWithTarget:self selector:@selector(playerJumpEnded)],nil]];
        });
    }
}
-(void)rightButtonLongPress
{
    if(moving==NO){
        moving=YES;longmoving=YES;
        player.flipX=NO;
        [player stopAllActions];
        [self continueMovingToRight];
    }
}
-(void)continueMovingToRight
{
    if(moving==YES){
        if(!playerbody->GetContactList()){[self playerMoveEnded];}
        else {
            playerbody->SetLinearVelocity(b2Vec2(2.0f, 0.0f));
            //--------------------------------------------------------------------
            if(walkStauts==0 && walkStauts0Lock==NO) {
                [player stopAllActions];
                walkStauts1Lock=NO;walkStauts2Lock=NO;
                [player runAction:chooseAction.walkAction];
                walkStauts0Lock=YES;
            }
            if(walkStauts==1 && walkStauts1Lock==NO){
                [player stopAllActions];
                walkStauts0Lock=NO;walkStauts2Lock=NO;
                [player runAction:chooseAction.walkUpAction];
                walkStauts1Lock=YES;
            }
            if (walkStauts==2 && walkStauts2Lock==NO) {
                [player stopAllActions];
                walkStauts0Lock=NO;walkStauts1Lock=NO;
                [player runAction:chooseAction.walkDownAction];
                walkStauts2Lock=YES;
            }
            //--------------------------------------------------------------------
            [player runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f],[CCCallFunc actionWithTarget:self selector:@selector(continueMovingToRight)],nil]];
        }
    }
}
-(void)leftButtonLongPress
{
    if(moving==NO){
        moving=YES;longmoving=YES;
        player.flipX=YES;
        [player stopAllActions];
        [self continueMovingToLeft];
    }
}
-(void)continueMovingToLeft
{
    if(moving==YES){
        if(!playerbody->GetContactList()){[self playerMoveEnded];}
        else {
            playerbody->SetLinearVelocity(b2Vec2(-2.0f, 0.0f));
            //--------------------------------------------------------------------
            if(walkStauts==0 && walkStauts0Lock==NO) {
                [player stopAllActions];
                walkStauts1Lock=NO;walkStauts2Lock=NO;
                [player runAction:chooseAction.walkAction];
                walkStauts0Lock=YES;
            }
            if(walkStauts==1 && walkStauts1Lock==NO){
                [player stopAllActions];
                walkStauts0Lock=NO;walkStauts2Lock=NO;
                [player runAction:chooseAction.walkUpAction];
                walkStauts1Lock=YES;
            }
            if (walkStauts==2 && walkStauts2Lock==NO) {
                [player stopAllActions];
                walkStauts0Lock=NO;walkStauts1Lock=NO;
                [player runAction:chooseAction.walkDownAction];
                walkStauts2Lock=YES;
            }
            //--------------------------------------------------------------------
            [player runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f],[CCCallFunc actionWithTarget:self selector:@selector(continueMovingToLeft)],nil]];
        }
    }
}
-(void)playerMoveEnded
{
    if(moving==YES){
        [player stopAllActions];
        longmoving=NO;crouching=NO;
        walkStauts0Lock=NO;walkStauts1Lock=NO;walkStauts2Lock=NO;
        if(!crouchAttackCanBeActive){[player runAction:chooseAction.walkStopAction];moving=NO;}
        else {dispatch_after(dispatch_time(DISPATCH_TIME_NOW,0.8*NSEC_PER_SEC),dispatch_get_main_queue(),^(void){moving=NO;});}
        crouchAttackCanBeActive=NO;
    }
}
-(void)playerJumpEnded
{
    if(moving==YES){
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (playerbody->GetContactList()) {
                moving=NO;jumping=NO;
            } else {[self playerJumpEnded];}
        });
    }
}

-(void)leftButtonSwipeToLeft
{
    if(crouching){crouchAttackCanBeActive=YES;}
    if(moving==NO){
        moving=YES;
        player.flipX=YES;
        [player stopAllActions];
        //----------------------------------------------------------------------
        int i=0,j=0,attackWay=0;
        CCTMXObjectGroup *objects1 = [tileMap objectGroupNamed:@"Collision1"];
        CCTMXObjectGroup *objects2 = [tileMap objectGroupNamed:@"Collision2"];
        NSMutableDictionary * objPoint;
        for (objPoint in [objects1 objects]) {
            if(rhbbody[i]->GetContactList() && attackWay==0){
                [player runAction:chooseAction.walkDownAttackAction];
                attackWay=2;
            } else {i++;}
        }
        for (objPoint in [objects2 objects]) {
            if(lhbbody[j]->GetContactList() && attackWay==0){
                [player runAction:chooseAction.walkUpAttackAction];
                attackWay=1;
            } else {j++;}
        }
        if(attackWay==0){[player runAction:chooseAction.attackAction];}
        //------------------------------------------------------------------
        playerbody->SetLinearVelocity(b2Vec2(0.0f, -4.9f));
        weapon =[CCSprite spriteWithSpriteFrameName:@"attack-whip-1.png"];
        [weapon setPosition:ccpAdd(player.position, ccp(26,35-42))];
        //-------------------------------
        weapon.scale=winSCALE;
        //-------------------------------
        [self addChild:weapon];
        weapon.flipX=YES;
        [weapon runAction:chooseAction.whipAction];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(18,33-40))]];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(29,52-36))]];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(12,67-40))]];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.4 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(-45,56-44))]];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(-47,50-42))]];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.6 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(-65,50-38))]];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.7 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            [self removeChild:weapon cleanup:YES];weapon=nil;
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.9 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            [player stopAllActions];moving=NO;
        });
    }
}
-(void)rightButtonSwipeToRight
{
    if(crouching){crouchAttackCanBeActive=YES;}
    if(moving==NO){
        moving=YES;
        player.flipX=NO;
        [player stopAllActions];
        //----------------------------------------------------------------------
        int i=0,j=0,attackWay=0;
        CCTMXObjectGroup *objects1 = [tileMap objectGroupNamed:@"Collision1"];
        CCTMXObjectGroup *objects2 = [tileMap objectGroupNamed:@"Collision2"];
        NSMutableDictionary * objPoint;
        for (objPoint in [objects1 objects]) {
            if(rhbbody[i]->GetContactList() && attackWay==0){
                [player runAction:chooseAction.walkUpAttackAction];
                attackWay=1;
            } else {i++;}
        }
        for (objPoint in [objects2 objects]) {
            if(lhbbody[j]->GetContactList() && attackWay==0){
                [player runAction:chooseAction.walkDownAttackAction];
                attackWay=2;
            } else {j++;}
        }
        if(attackWay==0){[player runAction:chooseAction.attackAction];}
        //------------------------------------------------------------------
        playerbody->SetLinearVelocity(b2Vec2(0.0f, -4.9f));
        weapon =[CCSprite spriteWithSpriteFrameName:@"attack-whip-1.png"];
        [weapon setPosition:ccpAdd(player.position, ccp(-26,35-42))];
        //-------------------------------
        weapon.scale=winSCALE;
        //-------------------------------
        [self addChild:weapon];
        weapon.flipX=NO;
        [weapon runAction:chooseAction.whipAction];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(-18,33-40))]];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(-29,52-36))]];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(-12,67-40))]];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.4 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(44,56-44))]];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(47,50-42))]];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.6 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(65,50-38))]];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.7 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            [self removeChild:weapon cleanup:YES];weapon=nil;
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.9 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            [player stopAllActions];moving=NO;
        });
    }
}

-(void)rightButtonSwipeToDown
{
    if(moving==NO){
        moving=YES;
        if(curMagic>=10.0f){
            hitLock=YES;swingLeg=YES;
            player.flipX=NO;
            curMagic=curMagic-10.0f;
            [myDefaults setFloat:curMagic forKey:@"playerCurMagic"];
            [player stopAllActions];
            [player runAction:chooseAction.swingLegAction];
            playerbody->SetLinearVelocity(b2Vec2(2.0f, 3.0f));
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [player stopAllActions];
                hitLock=NO;swingLeg=NO;
                [self playerMoveEnded];
            });
        }
    }
}
-(void)leftButtonSwipeToDown
{
    if(moving==NO){
        moving=YES;
        if(curMagic>=10.0f){
            hitLock=YES;swingLeg=YES;
            player.flipX=YES;
            curMagic=curMagic-10.0f;
            [myDefaults setFloat:curMagic forKey:@"playerCurMagic"];
            [player stopAllActions];
            [player runAction:chooseAction.swingLegAction];
            playerbody->SetLinearVelocity(b2Vec2(-2.0f, 3.0f));
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [player stopAllActions];
                hitLock=NO;swingLeg=NO;
                [self playerMoveEnded];
            });
        }
    }
}
-(void)rightButtonSwipeToLeft
{
    if(moving==NO){
        moving=YES;
        if(player.flipX==YES && curMagic>=20.0f){
            hitLock=YES;rush=YES;
            curMagic=curMagic-20.0f;
            [myDefaults setFloat:curMagic forKey:@"playerCurMagic"];
            [player stopAllActions];
            [player runAction:chooseAction.rushAction];
            playerbody->SetLinearVelocity(b2Vec2(-7.0f, 1.0f));
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.7 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [player stopAllActions];
                hitLock=NO;rush=NO;
                [self playerMoveEnded];
            });
        } else if(player.flipX==NO){
            [player stopAllActions];
            [player runAction:chooseAction.rollBackAction];
            playerbody->SetLinearVelocity(b2Vec2(-2.0f, 4.0f));
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.9 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [player stopAllActions];
                [self playerJumpEnded];
            });
        }
    }
}
-(void)leftButtonSwipeToRight
{
    if(moving==NO){
        moving=YES;
        if(player.flipX==NO && curMagic>=20.0f){
            hitLock=YES;rush=YES;
            curMagic=curMagic-20.0f;
            [myDefaults setFloat:curMagic forKey:@"playerCurMagic"];
            [player stopAllActions];
            [player runAction:chooseAction.rushAction];
            playerbody->SetLinearVelocity(b2Vec2(7.0f, 1.0f));
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.7 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [player stopAllActions];
                hitLock=NO;rush=NO;
                [self playerMoveEnded];
            });
        } else if(player.flipX==YES){
            [player stopAllActions];
            [player runAction:chooseAction.rollBackAction];
            playerbody->SetLinearVelocity(b2Vec2(2.0f, 4.0f));
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.9 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [player stopAllActions];
                [self playerJumpEnded];
            });
        }
    }
}
-(void)rightButtonSwipeToUp
{
    if(moving==NO && curMagic>=5.0f){
        moving=YES;jumping=YES;hitLock=YES;
        player.flipX=NO;
        curMagic=curMagic-5.0f;
        [myDefaults setFloat:curMagic forKey:@"playerCurMagic"];
        [player stopAllActions];
        [player runAction:chooseAction.jumpAction];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [player stopAllActions];
            [player runAction:chooseAction.attackUpAction];
            playerbody->SetLinearVelocity(b2Vec2(1.5f, 7.0f));
            [self destroyAllPlatformbody];
        });
        dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){
            [self createAllPlatformbody];
            [player runAction:[CCSequence actions:[CCCallFunc actionWithTarget:self selector:@selector(attackUpStop)],nil]];
        });
    }
}
-(void)leftButtonSwipeToUp
{
    if(moving==NO && curMagic>=5.0f){
        moving=YES;jumping=YES;hitLock=YES;
        player.flipX=YES;
        curMagic=curMagic-5.0f;
        [myDefaults setFloat:curMagic forKey:@"playerCurMagic"];
        [player stopAllActions];
        [player runAction:chooseAction.jumpAction];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [player stopAllActions];
            [player runAction:chooseAction.attackUpAction];
            playerbody->SetLinearVelocity(b2Vec2(-1.5f, 7.0f));
            [self destroyAllPlatformbody];
        });
        dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){
            [self createAllPlatformbody];
            [player runAction:[CCSequence actions:[CCCallFunc actionWithTarget:self selector:@selector(attackUpStop)],nil]];
        });
    }
}
-(void)attackUpStop
{
    if(moving==YES){
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (playerbody->GetContactList()) {
                moving=NO;jumping=NO;hitLock=NO;
                [player stopAllActions];
                [player runAction:chooseAction.attackUpStopAction];
            } else {[self attackUpStop];}
        });
    }
}
//============================================================================================================
-(void)rightBottomButtonTapped
{
    if(moving==NO){
        moving=YES;crouching=YES;
        player.flipX=YES;
        [player stopAllActions];
        [player runAction:chooseAction.crouchAction];
        [player runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.5],[CCCallFunc actionWithTarget:self selector:@selector(playerMoveEnded)],nil]];
        playerbody->SetLinearVelocity(b2Vec2(0.0f, -4.9f));
    }
}
-(void)leftBottomButtonTapped
{
    if(moving==NO){
        moving=YES;crouching=YES;
        player.flipX=NO;
        [player stopAllActions];
        [player runAction:chooseAction.crouchAction];
        [player runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.5],[CCCallFunc actionWithTarget:self selector:@selector(playerMoveEnded)],nil]];
        playerbody->SetLinearVelocity(b2Vec2(0.0f, -4.9f));
    }
}
-(void)rightBottomButtonDoubleTapped
{
    int i=0;
    if(moving==NO){
        CCTMXObjectGroup *objects3 = [tileMap objectGroupNamed:@"Collision3"];
        NSMutableDictionary * objPoint;
        for (objPoint in [objects3 objects]) {
            if(platformbody[i]->GetContactList()){
                moving=YES;
                player.flipX=NO;
                [player stopAllActions];
                [player runAction:chooseAction.jumpDownAction];
                playerbody->SetLinearVelocity(b2Vec2(1.0f, -2.0f));
                [self destroyAllPlatformbody];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                    [self createAllPlatformbody];
                    [player stopAllActions];
                    [player runAction:[CCSequence actions:[CCCallFunc actionWithTarget:self selector:@selector(playerMoveEnded)],nil]];
                });
            } else {i++;}
        }
    }
}
-(void)leftBottomButtonDoubleTapped
{
    int i=0;
    if(moving==NO){
        CCTMXObjectGroup *objects3 = [tileMap objectGroupNamed:@"Collision3"];
        NSMutableDictionary * objPoint;
        for (objPoint in [objects3 objects]) {
            if(platformbody[i]->GetContactList()){
                moving=YES;
                player.flipX=YES;
                [player stopAllActions];
                [player runAction:chooseAction.jumpDownAction];
                playerbody->SetLinearVelocity(b2Vec2(-1.0f, -2.0f));
                [self destroyAllPlatformbody];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                    [self createAllPlatformbody];
                    [player stopAllActions];
                    [player runAction:[CCSequence actions:[CCCallFunc actionWithTarget:self selector:@selector(playerMoveEnded)],nil]];
                });
            } else {i++;}
        }
    }
}
-(void)rightBottomButtonLongPress
{
    if(moving==NO){
        moving=YES;crouching=YES;
        player.flipX=YES;
        [player stopAllActions];
        [player runAction:chooseAction.crouchAction];
        playerbody->SetLinearVelocity(b2Vec2(0.0f, -4.9f));
        [player runAction:[CCSequence actions:[CCCallFunc actionWithTarget:self selector:@selector(crouchAttackListener)],nil]];
    }
}
-(void)leftBottomButtonLongPress
{
    if(moving==NO){
        moving=YES;crouching=YES;
        player.flipX=NO;
        [player stopAllActions];
        [player runAction:chooseAction.crouchAction];
        playerbody->SetLinearVelocity(b2Vec2(0.0f, -4.9f));
        [player runAction:[CCSequence actions:[CCCallFunc actionWithTarget:self selector:@selector(crouchAttackListener)],nil]];
    }
}
-(void)crouchAttackListener
{
    if(moving==YES && crouching==YES){
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (crouchAttackCanBeActive) {
                if(player.flipX==NO){
                    world->DestroyBody(playerbody);
                    [self createBox2dObjectForPlayerCrouchAttack];
                    [player runAction:chooseAction.crouchAttackAction];
                    //------------------------------------------------------------------
                    playerbody->SetLinearVelocity(b2Vec2(0.0f, -4.9f));
                    weapon =[CCSprite spriteWithSpriteFrameName:@"attack-whip-1.png"];
                    [weapon setPosition:ccpAdd(player.position, ccp(-26,35-42))];
                    //-------------------------------
                    weapon.scale=winSCALE;
                    //-------------------------------
                    [self addChild:weapon];
                    weapon.flipX=NO;
                    [weapon runAction:chooseAction.whipAction];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                        [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(-18,33-40))]];
                    });
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                        [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(-29,52-36))]];
                    });
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                        [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(-12,67-40))]];
                    });
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.4 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                        [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(44,56-54))]];
                    });
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                        [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(47,50-52))]];
                    });
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.6 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                        [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(65,50-48))]];
                    });
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.7 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                        [self removeChild:weapon cleanup:YES];weapon=nil;
                        world->DestroyBody(playerbody);
                        [self createBox2dObjectForPlayer];
                        [self crouchAttackListener];
                        crouchAttackCanBeActive=NO;
                    });
                } else {
                    world->DestroyBody(playerbody);
                    [self createBox2dObjectForPlayerCrouchAttack];
                    [player runAction:chooseAction.crouchAttackAction];
                    //------------------------------------------------------------------
                    playerbody->SetLinearVelocity(b2Vec2(0.0f, -4.9f));
                    weapon =[CCSprite spriteWithSpriteFrameName:@"attack-whip-1.png"];
                    [weapon setPosition:ccpAdd(player.position, ccp(26,35-42))];
                    //-------------------------------
                    weapon.scale=winSCALE;
                    //-------------------------------
                    [self addChild:weapon];
                    weapon.flipX=YES;
                    [weapon runAction:chooseAction.whipAction];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                        [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(18,33-40))]];
                    });
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                        [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(29,52-36))]];
                    });
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                        [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(12,67-40))]];
                    });
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.4 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                        [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(-45,56-54))]];
                    });
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                        [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(-47,50-52))]];
                    });
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.6 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                        [weapon runAction:[CCPlace actionWithPosition:ccpAdd(player.position, ccp(-65,50-48))]];
                    });
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.7 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                        [self removeChild:weapon cleanup:YES];weapon=nil;
                        world->DestroyBody(playerbody);
                        [self createBox2dObjectForPlayer];
                        [self crouchAttackListener];
                        crouchAttackCanBeActive=NO;
                    });
                }
            } else {[self crouchAttackListener];}
        });
    }
}
-(void)rightBottomButtonPan
{
    if(moving==NO && curMagic>=10.0f){
        moving=YES;crouching=YES;hitLock=YES;
        player.flipX=NO;
        [player stopAllActions];
        [player runAction:chooseAction.sweepingLegAction];
        [player runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1],[CCCallFunc actionWithTarget:self selector:@selector(playerSweepingLegEnded)],nil]];
        world->DestroyBody(playerbody);
        [self createBox2dObjectForPlayerCrouch];
        playerbody->SetLinearVelocity(b2Vec2(6.0f, 0.0f));
        curMagic=curMagic-10.0f;
        [myDefaults setFloat:curMagic forKey:@"playerCurMagic"];
    }
}
-(void)leftBottomButtonPan
{
    if(moving==NO && curMagic>=10.0f){
        moving=YES;crouching=YES;hitLock=YES;
        player.flipX=YES;
        [player stopAllActions];
        [player runAction:chooseAction.sweepingLegAction];
        [player runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1],[CCCallFunc actionWithTarget:self selector:@selector(playerSweepingLegEnded)],nil]];
        world->DestroyBody(playerbody);
        [self createBox2dObjectForPlayerCrouch];
        playerbody->SetLinearVelocity(b2Vec2(-6.0f, 0.0f));
        curMagic=curMagic-10.0f;
        [myDefaults setFloat:curMagic forKey:@"playerCurMagic"];
    }
}
-(void)playerSweepingLegEnded
{
    [player stopAllActions];
    if(player.flipX==NO){playerbody->SetLinearVelocity(b2Vec2(3.0f, 0.0f));}
    else{playerbody->SetLinearVelocity(b2Vec2(-3.0f, 0.0f));}
    [player runAction:chooseAction.sweepingLegEndAction];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        moving=NO;crouching=NO;
        world->DestroyBody(playerbody);
        [self createBox2dObjectForPlayer];
        hitLock=NO;
    });
}
//============================================================================================================
#pragma mark -
#pragma mark draw-box2d-world
/*
-(void) draw
{
 [super draw];
 ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
 kmGLPushMatrix();
 world->DrawDebugData();
 kmGLPopMatrix();
}*/

#pragma mark -
#pragma mark dealloc
-(void) dealloc
{
	delete world;
	world = NULL;
	delete m_debugDraw;
	m_debugDraw = NULL;
    contactListener=nil;
    
	[super dealloc];
}

@end

