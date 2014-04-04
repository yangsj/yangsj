//
//  GameScene.cpp
//  snake222
//
//  Created by yangsj on 14-3-13.
//
//

#include "GameScene.h"
#include "GameLayer.h"
#include "../NotificationNames.h"

bool GameScene::init()
{
    if ( !CCScene::init())
    {
        return false;
    }
    
    CCSize winSize = CCDirector::sharedDirector()->getVisibleSize();
    CCPoint origin = CCDirector::sharedDirector()->getVisibleOrigin();
    
    CCSprite* pSprite = CCSprite::create("bg02.jpg");
    pSprite->setPosition(ccp(winSize.width/2 + origin.x, winSize.height/2 + origin.y));
    this->addChild(pSprite);
    
    this->addChild(GameLayer::create());
    
    CCTextureCache::sharedTextureCache()->dumpCachedTextureInfo();
    
    return true;
}

void GameScene::gameOver()
{
    this->addChild(GameOverLayer::create());
    CCLog("GameScene::gameOver()+++");
}

void GameScene::onEnter()
{
    CCScene::onEnter();
    CCNotificationCenter::sharedNotificationCenter()->addObserver(this, callfuncO_selector(GameScene::gameOver), NotificationGameOver, NULL);
}

void GameScene::onExit()
{
    CCScene::onExit();
    CCNotificationCenter::sharedNotificationCenter()->removeObserver(this, NotificationGameOver);
}