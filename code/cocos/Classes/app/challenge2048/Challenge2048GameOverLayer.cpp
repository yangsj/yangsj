//
//  Challenge2048GameOverLayer.cpp
//  snake222
//
//  Created by yangsj on 14-3-21.
//
//

#include "Challenge2048GameOverLayer.h"


Challenge2048GameOver::Challenge2048GameOver()
{
    CCLog("Challenge2048GameOver 构造函数");
}

Challenge2048GameOver::~Challenge2048GameOver()
{
    CCLog("Challenge2048GameOver  析构函数");
}

void Challenge2048GameOver::onEnter()
{
    BasePanelLayer::onEnter();
    
    CCFadeIn* fadeIn = CCFadeIn::create(2.0f);
    this->runAction(fadeIn);
}

bool Challenge2048GameOver::init()
{
    CCLog("bool Challenge2048GameOver::init()");
    if ( BasePanelLayer::init())
    {
        CCSize visiSize = CCDirector::sharedDirector()->getVisibleSize();
        CCPoint origin  = CCDirector::sharedDirector()->getVisibleOrigin();
        
        CCSprite* pSprite = CCSprite::create("bg06.jpg");
        pSprite->setPosition(ccp(visiSize.width/2 + origin.x, visiSize.height/2 + origin.y));
        this->addChild(pSprite);
        
        CCMenuItemFont* menuRestart = CCMenuItemFont::create("Restart", this, menu_selector(Challenge2048GameOver::restart));
        CCMenuItemFont* menuBack    = CCMenuItemFont::create("BackHome", this, menu_selector(Challenge2048GameOver::backHome));
        
        menuBack->setFontSizeObj(80);
        menuRestart->setFontSizeObj(80);
        
        float cw = visiSize.width * 0.5 + origin.x;
        
        menuRestart->setPosition(CCPoint(cw, visiSize.height * 0.57 + origin.y));
        menuBack->setPosition(CCPoint(cw, visiSize.height * 0.43 + origin.y));
        
        CCMenu* menus = CCMenu::create(menuRestart, menuBack, NULL);
        menus->setPosition(CCPoint(0,0));
        this->addChild(menus);
        
        return true;
    }
    return false;
}

void Challenge2048GameOver::backHome(cocos2d::CCObject *pSender)
{
    CCNotificationCenter::sharedNotificationCenter()->postNotification(NotificationBackToHome);
    
    CCLog("Back To Home Action");
}

void Challenge2048GameOver::restart(cocos2d::CCObject *pSender)
{
    CCNotificationCenter::sharedNotificationCenter()->postNotification(NotificationRestartGame);
    
    CCLog("Restart Game @@@@@@@@@@@@");
}


