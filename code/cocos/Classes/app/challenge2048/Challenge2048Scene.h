//
//  Challenge2048Scene.h
//  snake222
//
//  Created by yangsj on 14-3-21.
//
//

#ifndef __snake222__Challenge2048Scene__
#define __snake222__Challenge2048Scene__

#include <iostream>
#include "../common/BaseGameScene.h"
#include "Challenge2048Const.h"


class Challenge2048Scene : public BaseGameScene
{
    
public:
    
    Challenge2048Scene();
    ~Challenge2048Scene();
    
    virtual bool init();
    virtual void onEnter();
    virtual void onExit();
    
    CREATE_FUNC(Challenge2048Scene);
    
private:
    
    void backHome( CCObject* pSender);
    void restart( CCObject* pSender);
    
    void start();
    
};


#endif /* defined(__snake222__Challenge2048Scene__) */
