//
//  HelpGameLayer.cpp
//  snake222
//
//  Created by yangsj on 14-3-13.
//
//

#include "HelpGameLayer.h"
#include "HelloWorldScene.h"


bool HelpGameLayer::init()
{
    if ( !CCLayer::init())
    {
        return false;
    }
    
    CCSize visibleSize = CCDirector::sharedDirector()->getVisibleSize();
    CCPoint origin = CCDirector::sharedDirector()->getVisibleOrigin();
    
    CCLabelTTF* labelTitle = CCLabelTTF::create("Put square grid connected.\n the random head collided with their own.\n The head hit their game over", "Zapfino", 35);
    labelTitle->setPosition(CCPoint(visibleSize.width * 0.5 + origin.x, visibleSize.height * 0.80 + origin.y));
    labelTitle->setFontFillColor(ccc3(0,0,0));
    this->addChild( labelTitle, 1 );
    
    CCLabelTTF* menuLabel = CCLabelTTF::create("Back", "宋体", 45);
    CCMenuItemLabel* menuItem = CCMenuItemLabel::create(menuLabel, this, menu_selector(HelpGameLayer::menuBackToMain));
    menuItem->setPosition(CCPoint(visibleSize.width - (menuItem->getContentSize().width * 0.5)-10 + origin.x, origin.y + menuItem->getContentSize().height * 0.5 + 10));
    
    CCMenu* menu = CCMenu::create(menuItem, NULL);
    menu->setPosition(CCPoint(0,0));
    this->addChild( menu, 1 );
    
    CCSprite* pSprite = CCSprite::create("bg03.jpg");
    pSprite->setPosition(ccp(visibleSize.width/2 + origin.x, visibleSize.height/2 + origin.y));
    this->addChild(pSprite, 0);
    
    return true;
}

void HelpGameLayer::menuBackToMain(cocos2d::CCObject *pSender)
{
    HelloWorld::runThisScene();
}