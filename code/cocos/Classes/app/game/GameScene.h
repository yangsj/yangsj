//
//  GameScene.h
//  snake222
//
//  Created by yangsj on 14-3-13.
//
//

#ifndef __snake222__GameScene__
#define __snake222__GameScene__

#include <iostream>
#include "cocos2d.h"
#include "../common/BaseGameScene.h"
USING_NS_CC;

typedef enum
{
    UP=1,
    DOWN,
    LEFT,
    RIGHT
} DIR_DEF;


class GameScene:public BaseGameScene
{
public:
    virtual bool init();
    
    virtual void onEnter();
    virtual void onExit();
    
    void gameOver();
    
    CREATE_FUNC(GameScene);
};


#endif /* defined(__snake222__GameScene__) */
