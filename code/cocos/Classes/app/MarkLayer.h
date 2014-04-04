//
//  MarkLayer.h
//  snake222
//
//  Created by yangsj on 14-3-18.
//
//

#ifndef __snake222__MarkLayer__
#define __snake222__MarkLayer__

#include <iostream>
#include "cocos2d.h"
USING_NS_CC;

class MarkLayer: public CCLayer
{
public:
    
    virtual bool init();
    
    virtual bool ccTouchBegan(CCTouch *pTouch, CCEvent *pEvent);
    
    virtual void registerWithTouchDispatcher(void);
    
    CREATE_FUNC(MarkLayer);
    
};


#endif /* defined(__snake222__MarkLayer__) */
