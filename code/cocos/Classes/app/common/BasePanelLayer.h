//
//  BasePanelLayer.h
//  snake222
//
//  Created by yangsj on 14-3-18.
//
//

#ifndef __snake222__BasePanelLayer__
#define __snake222__BasePanelLayer__

#include <iostream>
#include "PriorityType.h"
#include "cocos2d.h"
#include "../NotificationNames.h"
USING_NS_CC;


class BasePanelLayer : public CCLayer
{
public:
    
    BasePanelLayer();
    ~BasePanelLayer();
    
    virtual bool init();
    
    void showPanel();
    void hidePanel();
    
    CCTouchDelegate* isTouchBegan(CCNode* pLayer, CCTouch *pTouch, CCEvent *pEvent);
    
    virtual bool ccTouchBegan(CCTouch *pTouch, CCEvent *pEvent);
    virtual void ccTouchMoved(CCTouch *pTouch, CCEvent *pEvent);
    virtual void ccTouchEnded(CCTouch *pTouch, CCEvent *pEvent);
    virtual void ccTouchCancelled(CCTouch *pTouch, CCEvent *pEvent);
    virtual void registerWithTouchDispatcher(void);
    
    
    int prioriryType;
    int levelType;
    
private:
    
    CCTouchDelegate* m_pTouchDelegate;
    
protected:
    
    virtual void setPrioriryType();
    virtual void setLevelType();
};


#endif /* defined(__snake222__BasePanelLayer__) */
