//
//  TouchEffectLayer.h
//  snake222
//
//  Created by yangsj on 14-3-24.
//
//

#ifndef __snake222__TouchEffectLayer__
#define __snake222__TouchEffectLayer__

#include <iostream>
#include "cocos2d.h"
#include "PriorityType.h"
USING_NS_CC;

class TouchEffectLayer : public CCLayer
{
    
public:
    
    TouchEffectLayer();
    ~TouchEffectLayer();
    
    void onEnter();
    void onExit();
	virtual bool ccTouchBegan(CCTouch *pTouch, CCEvent *pEvent);
	virtual void ccTouchMoved(CCTouch *pTouch, CCEvent *pEvent);
	virtual void ccTouchEnded(CCTouch *pTouch, CCEvent *pEvent);
    
    CREATE_FUNC(TouchEffectLayer);
    
    static TouchEffectLayer* getInstance();
    
private:
    
    CCParticleSystemQuad* m_emitter;
    
};

#endif /* defined(__snake222__TouchEffectLayer__) */
