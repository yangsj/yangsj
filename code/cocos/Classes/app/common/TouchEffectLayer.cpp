//
//  TouchEffectLayer.cpp
//  snake222
//
//  Created by yangsj on 14-3-24.
//
//

#include "TouchEffectLayer.h"

static TouchEffectLayer* instance = NULL;

TouchEffectLayer* TouchEffectLayer::getInstance()
{
    if ( instance == NULL )
    {
        instance = new TouchEffectLayer();
        instance->init();
    }
    return instance;
}

TouchEffectLayer::TouchEffectLayer()
{
    m_emitter = NULL;
}

TouchEffectLayer::~TouchEffectLayer()
{
    
}

void TouchEffectLayer::onEnter()
{
    CCLayer::onEnter();
    CCDirector::sharedDirector()->getTouchDispatcher()->addTargetedDelegate(this, PRIORITY_TYPE_SYS, false);
    if(m_emitter == NULL)
    {
//        m_emitter = new CCParticleSystemQuad();//  
//        m_emitter->initWithFile("ui/Galaxy.plist");
        m_emitter = CCParticleSystemQuad::create("ui/Galaxy.plist");
        addChild(m_emitter, INT_MAX);
        m_emitter->stopSystem();
        CCLog("m_emitter == NULL");
    }
    CCLog("void TouchEffectLayer::onEnter() ++++++++++++++++++++++++++++++++");
}

void TouchEffectLayer::onExit()
{
    CCLayer::onExit();
    CCDirector::sharedDirector()->getTouchDispatcher()->removeDelegate(this);
    CCLog("void TouchEffectLayer::onExit() ----------------------------------");
}
bool TouchEffectLayer::ccTouchBegan(CCTouch *pTouch, CCEvent *pEvent)
{
    if (m_emitter) {
        m_emitter->resetSystem();
        CCPoint location = pTouch->getLocation();
        m_emitter->setPosition(location);
        return true;
    }
	return false;
}

void TouchEffectLayer::ccTouchMoved(CCTouch *pTouch, CCEvent *pEvent)
{
    CCPoint location = pTouch->getLocation();
    m_emitter->setPosition(location);
}

void TouchEffectLayer::ccTouchEnded(CCTouch *pTouch, CCEvent *pEvent)
{
    CCPoint location = pTouch->getLocation();
    m_emitter->setPosition(location);
    m_emitter->stopSystem();
    CCLog("TouchEffectLayer::ccTouchEnded ----------- TouchEffectLayer::ccTouchEnded");
}



