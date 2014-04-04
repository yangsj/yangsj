//
//  MarkLayer.cpp
//  snake222
//
//  Created by yangsj on 14-3-18.
//
//

#include "MarkLayer.h"

bool MarkLayer::init()
{
    if ( !CCLayer::init())
    {
        return false;
    }
    
    CCSize s = CCDirector::sharedDirector()->getWinSize();
    this->addChild( CCLayerColor::create(ccc4(0, 0, 0, 255), s.width, s.height));
    
    this->setTouchEnabled(true);
    
    return true;
}

void MarkLayer::registerWithTouchDispatcher()
{
    CCDirector::sharedDirector()->getTouchDispatcher()->addTargetedDelegate(this, -128, true);
}

bool MarkLayer::ccTouchBegan(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent)
{
    return true;
}