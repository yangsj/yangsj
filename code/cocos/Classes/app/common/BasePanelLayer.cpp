//
//  BasePanelLayer.cpp
//  snake222
//
//  Created by yangsj on 14-3-18.
//
//

#include "BasePanelLayer.h"

BasePanelLayer::BasePanelLayer()
{
    m_pTouchDelegate = NULL;
    prioriryType = PRIORITY_TYPE_PANEL;
}

BasePanelLayer::~BasePanelLayer()
{
    
}

bool BasePanelLayer::init()
{
    if ( CCLayer::init())
    {
        this->setTouchEnabled(true);
        return true;
    }
    return false;
}

void BasePanelLayer::showPanel()
{
    CCScene* curScene = CCDirector::sharedDirector()->getRunningScene();
    if ( curScene )
    {
        setLevelType();
        curScene->addChild(this, levelType);
    }
}

void BasePanelLayer::hidePanel()
{
    if ( this->getParent() )
    {
        this->getParent()->removeChild(this, true);
    }
}

void BasePanelLayer::setPrioriryType()
{
    prioriryType = PRIORITY_TYPE_PANEL;
}

void BasePanelLayer::setLevelType()
{
    levelType = LAYER_LEVEL_PANEL;
}

void BasePanelLayer::registerWithTouchDispatcher()
{
    setPrioriryType();
    CCLog("prioriryType === %d", prioriryType);
    CCDirector::sharedDirector()->getTouchDispatcher()->addTargetedDelegate(this, prioriryType, true);
}

CCTouchDelegate* BasePanelLayer::isTouchBegan(CCNode* pLayer, CCTouch *pTouch, CCEvent *pEvent)
{
    CCObject* child = NULL;
    CCArray* children = pLayer->getChildren();
    CCARRAY_FOREACH(children, child)
    {
        CCNode* pNode = dynamic_cast<CCNode*>(child);
        if(pNode && pNode->isVisible())
        {
            //优先查找子类
            CCTouchDelegate* pTouchDelegate = isTouchBegan(pNode, pTouch, pEvent);
            if(pTouchDelegate)
            {
                return pTouchDelegate;
            }
            CCTouchDelegate* pDelegate = dynamic_cast<CCTouchDelegate*>(child);
            if(pDelegate)
            {
                CCLayer* pLayer = dynamic_cast<CCLayer*>(child);
                if(pLayer)
                {
                    if(pLayer->isTouchEnabled())
                    {
                        if(pLayer->ccTouchBegan(pTouch, pEvent))
                        {
                            return pLayer;
                        }
                    }
                }
                else
                {
                    if(pDelegate->ccTouchBegan(pTouch, pEvent))
                    {
                        return pDelegate;
                    }
                }
            }
        }
    }
    return NULL;
}
bool BasePanelLayer::ccTouchBegan(CCTouch* pTouch, CCEvent *pEvent)
{
    m_pTouchDelegate = isTouchBegan(this, pTouch, pEvent);
    return true;
}

void BasePanelLayer::ccTouchEnded(CCTouch *pTouch, CCEvent *pEvent)
{
    if(m_pTouchDelegate)
    {
        m_pTouchDelegate->ccTouchEnded(pTouch, pEvent);
    }
    m_pTouchDelegate = NULL;
    CCLog("BasePanelLayer ccTouchEnded");
}
void BasePanelLayer::ccTouchMoved(CCTouch *pTouch, CCEvent *pEvent)
{
    if(m_pTouchDelegate)
    {
        m_pTouchDelegate->ccTouchMoved(pTouch, pEvent);
    }
}
void BasePanelLayer::ccTouchCancelled(CCTouch *pTouch, CCEvent *pEvent)
{
    if(m_pTouchDelegate)
    {
        m_pTouchDelegate->ccTouchCancelled(pTouch, pEvent);
    }
    m_pTouchDelegate = NULL;
}

