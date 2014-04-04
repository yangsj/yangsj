//
//  GameOverLayer.h
//  snake222
//
//  Created by yangsj on 14-3-14.
//
//

#ifndef __snake222__GameOverLayer__
#define __snake222__GameOverLayer__

#include <iostream>
#include "cocos2d.h"
#include "../common/BasePanelLayer.h"
USING_NS_CC;

class GameOverLayer: public BasePanelLayer
{
public:
    
    GameOverLayer();
    ~GameOverLayer();
    
    virtual bool init();
    //virtual void draw();
    
    CREATE_FUNC(GameOverLayer);
    
private:
    
    void onRestartCall( CCObject* pSender );
    void onBackHomeCall( CCObject* pSender);
};

#endif /* defined(__snake222__GameOverLayer__) */
