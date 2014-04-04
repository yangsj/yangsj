//
//  GameOverLayer.cpp
//  snake222
//
//  Created by yangsj on 14-3-14.
//
//

#include "GameOverLayer.h"
#include "../NotificationNames.h"
#include "../MarkLayer.h"

GameOverLayer::GameOverLayer()
{
    
}

GameOverLayer::~GameOverLayer()
{
    CCLog("GameOverLayer   析构函数");
    this->setTouchEnabled(false);
}

bool GameOverLayer::init()
{
    if ( !BasePanelLayer::init() )
    {
        return false;
    }
    
    CCSize winSize = CCDirector::sharedDirector()->getVisibleSize();
    CCPoint origin = CCDirector::sharedDirector()->getVisibleOrigin();
    
    CCSprite* pSprite = CCSprite::create("bg04.jpg");
    pSprite->setPosition(ccp(winSize.width/2 + origin.x, winSize.height/2 + origin.y));
    this->addChild(pSprite, 0);

    CCLabelTTF* txtTitle = CCLabelTTF::create("GameOver", "宋体", 70);
    txtTitle->setPosition(CCPoint(winSize.width * 0.5 + origin.x, winSize.height * 0.7 + origin.y));
    this->addChild(txtTitle);
    
    CCLabelTTF* label01 = CCLabelTTF::create("Restart ", "宋体", 50);
    CCLabelTTF* label02 = CCLabelTTF::create("BackHome", "宋体", 50);
    
    CCMenuItemLabel* restartItem  = CCMenuItemLabel::create(label01, this, menu_selector(GameOverLayer::onRestartCall));
    CCMenuItemLabel* backHomeItem = CCMenuItemLabel::create(label02, this, menu_selector(GameOverLayer::onBackHomeCall));
    
    restartItem->setPosition(CCPoint(winSize.width * 0.5 + origin.x, winSize.height * 0.5 + origin.y));
    backHomeItem->setPosition(CCPoint(winSize.width * 0.5 + origin.x, winSize.height * 0.35 + origin.y));
    
    CCMenu* menu = CCMenu::create(restartItem, backHomeItem, NULL);
    menu->setPosition(CCPoint(0,0));
    this->addChild(menu);
    
    return true;
}

//void GameOverLayer::draw()
//{
//        CCSize winSize = CCDirector::sharedDirector()->getVisibleSize();
//        CCPoint origin = CCDirector::sharedDirector()->getVisibleOrigin();
//    ::ccDrawSolidRect(CCPoint(winSize.width * 0.2 + origin.x, winSize.height * 0.2 + origin.y), CCPoint(winSize.width * 0.8, winSize.height * 0.8 + origin.y), ccc4FFromccc4B(ccc4(255,0,0,200)) );
//    
//    ::ccDrawSolidRect(origin, CCPoint(winSize.width + origin.x, winSize.height + origin.y), ccc4FFromccc4B(ccc4(0,0,0,150)) );
//}

void GameOverLayer::onRestartCall(cocos2d::CCObject *pSender)
{
    hidePanel();
    
    CCNotificationCenter::sharedNotificationCenter()->postNotification(NotificationRestartGame);
    CCLog("NotificationRestartGame");
}

void GameOverLayer::onBackHomeCall(cocos2d::CCObject *pSender)
{
    //hidePanel();
    
    CCNotificationCenter::sharedNotificationCenter()->postNotification(NotificationBackToHome);
    CCLog("        NotificationBackToHome");
}

