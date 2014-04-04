//
//  AstarDrawLine.h
//  snake222
//
//  Created by yangsj on 14-3-26.
//
//

#ifndef __snake222__AstarDrawLine__
#define __snake222__AstarDrawLine__

#include <iostream>
#include "cocos2d.h"
#include <math.h>
#include "AstarDef.h"
#include "AstarGridShape.h"
#include "AstarNodePoint.h"
USING_NS_CC;

class AstarDrawLine : public CCLayer
{
  
public:
    
    AstarDrawLine();
    ~AstarDrawLine();
    
    void setPoints(VecAstarPoint points);
    void setRoleStartPoint(AstarNodePoint* point);
    void setRoleEndedPoint(AstarNodePoint* point);
    
    virtual bool init();
    virtual void draw();
    
    CREATE_FUNC(AstarDrawLine);
    
    int startX;
    int startY;
    
private:
    
    void startMove();
    void stopMoved();
    void moveRole(float f);
    
    VecAstarPoint findResult;
    AstarGridShape* roleShape;
    
    int endPointX;
    int endPointY;
    
    float uintTime;
    
    int moveNum;
};


#endif /* defined(__snake222__AstarDrawLine__) */
