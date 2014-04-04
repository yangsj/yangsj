//
//  BaseGameScene.h
//  snake222
//
//  Created by yangsj on 14-3-18.
//
//

#ifndef __snake222__BaseGameScene__
#define __snake222__BaseGameScene__

#include <iostream>
#include "PriorityType.h"
#include "cocos2d.h"
#include "../NotificationNames.h"
USING_NS_CC;


class BaseGameScene : public CCScene
{
public:
    BaseGameScene();
    ~BaseGameScene();
    
    virtual void runScene();
    
    
    CREATE_FUNC(BaseGameScene);
    
private:
    
    CCScene* curScene;
    
};


#endif /* defined(__snake222__BaseGameScene__) */
