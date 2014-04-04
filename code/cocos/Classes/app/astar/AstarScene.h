//
//  AstarScene.h
//  snake222
//
//  Created by yangsj on 14-3-26.
//
//

#ifndef __snake222__AstarScene__
#define __snake222__AstarScene__

#include <iostream>
#include "../common/BaseGameScene.h"
#include "AstarLayer.h"

class AstarScene : public BaseGameScene
{
public:
    
    AstarScene();
    ~AstarScene();
    
    virtual bool init();
    
    CREATE_FUNC(AstarScene);
    
};

#endif /* defined(__snake222__AstarScene__) */
