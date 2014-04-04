//
//  Challenge2048Scene.cpp
//  snake222
//
//  Created by yangsj on 14-3-21.
//
//

#include "Challenge2048Scene.h"
#include "Challenge2048Layer.h"
#include "../../HelloWorldScene.h"


Challenge2048Scene::Challenge2048Scene()
{
    
}

Challenge2048Scene::~Challenge2048Scene()
{
    
}

bool Challenge2048Scene::init()
{
    if ( BaseGameScene::init())
    {
        start();
        
        CCTextureCache::sharedTextureCache()->dumpCachedTextureInfo();
        
        return true;
    }
    return false;
}

void Challenge2048Scene::onEnter()
{
    BaseGameScene::onEnter();
    
    CCNotificationCenter::sharedNotificationCenter()->addObserver(this, callfuncO_selector(Challenge2048Scene::backHome), NotificationBackToHome, NULL);
    CCNotificationCenter::sharedNotificationCenter()->addObserver(this, callfuncO_selector(Challenge2048Scene::restart), NotificationRestartGame, NULL);
}

void Challenge2048Scene::onExit()
{
    BaseGameScene::onExit();
    
    CCNotificationCenter::sharedNotificationCenter()->removeObserver(this, NotificationRestartGame);
    CCNotificationCenter::sharedNotificationCenter()->removeObserver(this, NotificationBackToHome);
}

void Challenge2048Scene::start()
{
    this->removeAllChildrenWithCleanup(true);
    
    //=================================================
    CCSize visiSize = CCDirector::sharedDirector()->getVisibleSize();
    CCPoint origin  = CCDirector::sharedDirector()->getVisibleOrigin();
    
    CCSprite* pSprite = CCSprite::create("bg06.jpg");
    pSprite->setPosition(ccp(visiSize.width/2 + origin.x, visiSize.height/2 + origin.y));
    this->addChild(pSprite);
    
    this->addChild(Challenge2048Layer::create());
}

void Challenge2048Scene::backHome(cocos2d::CCObject *pSender)
{
    CCLog("notification back home!!!");
    HelloWorld::create()->runThisScene();
}

void Challenge2048Scene::restart(cocos2d::CCObject *pSender)
{
    CCLog("notification restart game####");
    start();
}

