//
//  Astar.h
//  snake222
//
//  Created by yangsj on 14-3-26.
//
//

#ifndef __snake222__Astar__
#define __snake222__Astar__

#include <iostream>
#include <math.h>
#include "cocos2d.h"
#include "AstarNodeItem.h"
#include "AstarNodePoint.h"
#include "AstarDef.h"
#include <algorithm>
USING_NS_CC;

class Astar
{
    
public:
    
    Astar();
    ~Astar();
    
    void initMapList( VecMap args);
    
    VecAstarPoint find( AstarNodePoint* sPoint, AstarNodePoint* ePoint);

private:
    
    void initSets();
    void loop();
    void openAryMinToFirst();
    void clearCheckMark();
    
    bool toFind( int x, int y);
    bool check( AstarNodeItem* item);
    bool addToOpenAry( AstarNodeItem* item, int g );
    bool checkInOpenAry( AstarNodeItem* item );
    bool checkInCloseAry(AstarNodeItem* item );
    AstarNodeItem* getAstarItem( int x, int y );
    VecAstarPoint getResult();

    VecAstarItemMap mapAry;

    VecAstarItem openAry;
    VecAstarItem closeAry;

    AstarNodePoint* startPos;
    AstarNodePoint* endPos;

    int lengx;
    int lengy;

    AstarNodeItem* curItem;
    AstarNodeItem* endItem;
};




#endif /* defined(__snake222__Astar__) */
