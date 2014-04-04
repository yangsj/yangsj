//
//  ShowTip.cpp
//  snake222
//
//  Created by yangsj on 14-3-24.
//
//

#include "ShowTip.h"

ShowTip::ShowTip()
{
    this->setAnchorPoint(CCPoint(0, 0));
}

ShowTip::~ShowTip()
{
    
}

void ShowTip::onEnter()
{
    CCNode::onEnter();
    CCLog("ShowTip onEnter()");
}

void ShowTip::onExit()
{
    CCNode::onExit();
    CCLog("ShowTip onExit()");
}

void ShowTip::show(const char *str, cocos2d::CCPoint& point, float fontSize, float delayTime, bool displayBg)
{
    CCLabelTTF* ttfTip = CCLabelTTF::create(str, "宋体", fontSize);
    ttfTip->cocos2d::CCNode::setAnchorPoint(CCPoint(0, 0));
    
    CCSize size = ttfTip->getContentSize();
    CCLayerColor* bgColor = NULL;
    if (displayBg)
    {
        bgColor = CCLayerColor::create();
        bgColor->setColor(ccColor3B(ccc3(0, 0, 0)));
        bgColor->setAnchorPoint(CCPoint(0.5,0.5));
        bgColor->setPosition(CCPoint(point.x - size.width * 0.5, point.y - 40));
        bgColor->setContentSize(size);
        bgColor->addChild(ttfTip);
        this->addChild(bgColor);
        
        ttfTip->setFontFillColor(ccColor3B(ccc3(255, 255, 255)));
    }
    else
    {
        size = CCSize(0,0);
        ttfTip->setFontFillColor(ccColor3B(ccc3(0, 0, 0)));
        ttfTip->setPosition(CCPoint(point.x, point.y - 60));
        this->addChild(ttfTip);
    }
    
    
    CCAction*  moveTo  = CCMoveTo::create(delayTime, CCPoint(point.x - size.width * 0.5, point.y + 40));
    
    if ( displayBg && bgColor )
    {
        CCFadeIn* fadeIn  = CCFadeIn::create(delayTime * 0.25);
        CCScaleTo* scaleTo = CCScaleTo::create(delayTime * 0.5, 1);
        CCFadeOut* fadeOut = CCFadeOut::create(delayTime * 0.25);
        bgColor->runAction(CCSequence::create(fadeIn,scaleTo, fadeOut, NULL));
        bgColor->runAction(moveTo);
    }
    else
    {
        CCFadeIn* fadeIn  = CCFadeIn::create(delayTime * 0.5);
        CCFadeOut* fadeOut = CCFadeOut::create(delayTime * 0.5);
        ttfTip->runAction(CCSequence::create(fadeIn, fadeOut, NULL));
        ttfTip->runAction(moveTo);
    }
    
    scheduleOnce(schedule_selector(ShowTip::removeFromParent), delayTime);
}

void ShowTip::showTip(const char *str, cocos2d::CCPoint& point, float fontSize)
{
    ShowTip* tips = ShowTip::create();
    CCDirector::sharedDirector()->getRunningScene()->addChild(tips);
    tips->show(str, point, fontSize, 1.0f, false);
}

void ShowTip::showTip(const char *str, cocos2d::CCPoint& point, float fontSize, float delayTime)
{
    ShowTip* tips = ShowTip::create();
    CCDirector::sharedDirector()->getRunningScene()->addChild(tips);
    tips->show(str, point, fontSize, delayTime, true);
}

void ShowTip::showTipCenter(const char *str, float fontSize, float delayTime)
{
    CCSize visiSize = CCDirector::sharedDirector()->getVisibleSize();
    CCPoint origin  = CCDirector::sharedDirector()->getVisibleOrigin();
    CCPoint centerPoint = CCPoint(visiSize.width * 0.5 + origin.x, visiSize.height * 0.5 + origin.y);
    showTip(str, centerPoint, fontSize, delayTime);
}



