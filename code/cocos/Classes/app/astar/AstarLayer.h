//
//  AstarLayer.h
//  snake222
//
//  Created by yangsj on 14-3-26.
//
//

#ifndef __snake222__AstarLayer__
#define __snake222__AstarLayer__

#include <iostream>
#include "../common/ShowTip.h"
#include "../common/BaseLayer.h"
#include "../../HelloWorldScene.h"

#include "AstarGridShape.h"
#include "AstarNodeItem.h"
#include "AstarNodePoint.h"
#include "AstarDef.h"
#include "Astar.h"
#include "AstarDrawLine.h"

class AstarLayer : public BaseLayer
{
public:
    
    AstarLayer();
    ~AstarLayer();
    
    virtual bool init();
    
    virtual bool ccTouchBegan(CCTouch *pTouch, CCEvent *pEvent);
    virtual void ccTouchEnded(CCTouch *pTouch, CCEvent *pEvent);
    virtual void registerWithTouchDispatcher(void);
    
    CREATE_FUNC(AstarLayer);
    
private:
    
    void backToHome(CCObject* sender) { HelloWorld::runThisScene(); }
    
    void initialize();
    
    int xTotal;
    int yTotal;
    float startX;
    float startY;
    
    Astar* astar;
    AstarNodePoint* startPoint;
    
    VecMap mapList;
    
    AstarDrawLine* drawLine;
};

#endif /* defined(__snake222__AstarLayer__) */
