//
//  GameItemNode.h
//  snake222
//
//  Created by yangsj on 14-3-13.
//
//

#ifndef snake222_GameItemNode_h
#define snake222_GameItemNode_h

#include "cocos2d.h"

//typedef enum
//{
//    UP=1,
//    DOWN,
//    LEFT,
//    RIGHT
//} DIR_DEF;

class GameItemNode: public cocos2d::CCObject
{
public:
    int row;
    int col;
    int dir;
};

#endif
