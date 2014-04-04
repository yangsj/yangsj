//
//  ShowTip.h
//  snake222
//
//  Created by yangsj on 14-3-24.
//
//

#ifndef __snake222__ShowTip__
#define __snake222__ShowTip__

#include <iostream>
#include "cocos2d.h"
USING_NS_CC;


class ShowTip : public CCNode
{
    
public:
    
    ShowTip();
    ~ShowTip();
    
    virtual void onEnter();
    virtual void onExit();
    
    void show(const char* str, CCPoint& point, float fontSize, float delayTime, bool displayBg);
    
    static void showTipCenter( const char* str, float fontSize, float delayTime );
    static void showTip( const char* str, CCPoint& point, float fontSize );
    static void showTip( const char* str, CCPoint& point, float fontSize, float delayTime);
    
    CREATE_FUNC(ShowTip);
    
};


#endif /* defined(__snake222__ShowTip__) */
