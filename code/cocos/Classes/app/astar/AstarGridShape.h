//
//  AstarGridShape.h
//  snake222
//
//  Created by yangsj on 14-3-26.
//
//

#ifndef __snake222__AstarGridShape__
#define __snake222__AstarGridShape__

#include <iostream>

#include "AstarNodePoint.h"
#include "cocos2d.h"
USING_NS_CC;

#define GRID_SIZE 50

class AstarGridShape : public CCNode
{
public:
    
    AstarGridShape();
    ~AstarGridShape();
    
    virtual void draw();
    
    // 是否标识为阻挡点
    bool isBlock;
    
    // 是否是role
    bool isRole;
    
    CREATE_FUNC(AstarGridShape);
    
};


#endif /* defined(__snake222__AstarGridShape__) */
