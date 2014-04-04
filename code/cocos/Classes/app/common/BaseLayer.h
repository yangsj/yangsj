//
//  BaseLayer.h
//  snake222
//
//  Created by yangsj on 14-3-25.
//
//

#ifndef __snake222__BaseLayer__
#define __snake222__BaseLayer__

#include <iostream>
#include "cocos2d.h"
USING_NS_CC;

class BaseLayer : public CCLayer
{
public:
    
    BaseLayer();
    ~BaseLayer();
    
    virtual void onEnter();
    virtual void onExit();
    
    virtual void keyBackClicked();//Android 返回键
    virtual void keyMenuClicked();//Android 菜单键
    
};




#endif /* defined(__snake222__BaseLayer__) */
