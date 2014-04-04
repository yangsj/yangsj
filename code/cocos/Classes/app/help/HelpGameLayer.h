//
//  HelpGameLayer.h
//  snake222
//
//  Created by yangsj on 14-3-13.
//
//

#ifndef __snake222__HelpGameLayer__
#define __snake222__HelpGameLayer__

#include <iostream>
#include "cocos2d.h"
USING_NS_CC;

class HelpGameLayer: public CCLayer
{
public:
    virtual bool init();
    
    void menuBackToMain(CCObject* pSender);
    
    CREATE_FUNC(HelpGameLayer);
    
};


#endif /* defined(__snake222__HelpGameLayer__) */
