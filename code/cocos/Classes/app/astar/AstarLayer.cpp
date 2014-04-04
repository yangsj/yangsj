//
//  AstarLayer.cpp
//  snake222
//
//  Created by yangsj on 14-3-26.
//
//

#include "AstarLayer.h"

AstarLayer::AstarLayer()
{
    startPoint = NULL;
}

AstarLayer::~AstarLayer()
{
    delete astar;
    if ( startPoint ) delete startPoint;
}

bool AstarLayer::init()
{
    if ( BaseLayer::init() )
    {
        initialize();
        
        this->setTouchEnabled(true);
        
        return true;
    }
    return false;
}

void AstarLayer::initialize()
{
    CCSize viewSize = CCDirector::sharedDirector()->getVisibleSize();
    CCPoint origin = CCDirector::sharedDirector()->getVisibleOrigin();
    
    // init vars value
    xTotal = (viewSize.width - 0) / GRID_SIZE;
    yTotal = (viewSize.height- 100) / GRID_SIZE;
    startX = origin.x + ( viewSize.width * 0.5 - (xTotal - 0.0f) * 0.5 * GRID_SIZE );
    startY = origin.y + ( viewSize.height* 0.5 - (yTotal - 0.0f) * 0.5 * GRID_SIZE );
    
    CCLog("xTotal = %d , yTotal = %d , startX = %f , startY = %f", xTotal, yTotal, startX, startY);
    
    // create back home button
    CCLabelTTF* menuLabel = CCLabelTTF::create("Back", "宋体", 45);
    CCMenuItemLabel* menuItem = CCMenuItemLabel::create(menuLabel, this, menu_selector(AstarLayer::backToHome));
    menuItem->setPosition(CCPoint(viewSize.width - (menuItem->getContentSize().width * 0.5)-10 + origin.x, origin.y + menuItem->getContentSize().height * 0.5 + 10));
    CCMenu* menu = CCMenu::create(menuItem, NULL);
    menu->setPosition(CCPoint(0,0));
    this->addChild( menu, 1 );
    ///////////////////////////
    
    VecChild tempChild(yTotal, 0);
    VecMap tempMap(xTotal, tempChild);
    mapList.clear();
    mapList = tempMap;
    
    for ( int x = 0; x < xTotal; x++ )
    {
        for (int y = 0; y < yTotal; y++ )
        {
            int num = (rand() % 3 == 0 ? 0 : 1);
            AstarGridShape* gridShape = AstarGridShape::create();
            gridShape->isBlock = ( num == 0 );
            gridShape->setPosition(startX + GRID_SIZE * x, startY + GRID_SIZE * y);
            this->addChild(gridShape);
            mapList[x][y] = num;
            CCLog(" [ x=%d , y=%d] num == %d", x, y, num);
        }
    }
    astar = new Astar();
    astar->initMapList(mapList);
    
    drawLine = AstarDrawLine::create();
    drawLine->startX = startX;
    drawLine->startY = startY;
    this->addChild(drawLine);
    
//    VecChild vec;
//    CCLog("------------------------------------------123456 start");
//    CCLog("vec.size = %d", (int)vec.size());
//    for (VecChild::size_type i = 0; i < 100; i++)
//    {
//        vec.push_back(i);
//    }
//    CCLog("vec.size = %d", (int)vec.size());
//    while (!vec.empty()) {
//        CCLog("      :: %d", (int)vec.back());
//        vec.pop_back();
//    }
//    CCLog("------------------------------------------123456 end");
    
}

void AstarLayer::registerWithTouchDispatcher()
{
    CCDirector::sharedDirector()->getTouchDispatcher()->addTargetedDelegate(this, 0, true);
}

bool AstarLayer::ccTouchBegan(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent)
{
    return true;
}

void AstarLayer::ccTouchEnded(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent)
{
    CCPoint point = pTouch->getLocation();
    int x = ( point.x - startX ) / GRID_SIZE;
    int y = ( point.y - startY ) / GRID_SIZE;
    CCLog("clicked: x = %d , y = %d", x, y);
    if ( x >= 0 && y >= 0 && x < xTotal && y < yTotal)
    {
        if ( startPoint )
        {
            if ( mapList[x][y] == 0)
            {
                CCLog("位置不能到达！！！");
                ShowTip::showTipCenter("位置不能到达！！！", 30, 2);
                return ;
            }
            
            if (x == startPoint->x && y == startPoint->y)
            {
                CCLog("结束点和起始点相等， 不移动");
                ShowTip::showTipCenter("结束点和起始点相等，不移动", 30, 2);
                return ;
            }
            
            AstarNodePoint* endPoint = new AstarNodePoint(x,y);
            
            VecAstarPoint findResult = astar->find(startPoint, endPoint);
            
            if (findResult.empty() || findResult.size() == 1)
            {
                CCLog("位置不能到达！！！");
                ShowTip::showTipCenter("位置不能到达！！！", 30, 2);
                return ;
            }
            
            startPoint->x = x;
            startPoint->y = y;
            CCLog("print find result--------start");
            for (VecAstarPoint::iterator iter = findResult.begin(); iter != findResult.end(); ++iter)
            {
                AstarNodePoint* cell = *iter;
                CCLog("x = %d , y = %d", cell->x, cell->y);
            }
            CCLog("print find result-------- end");
            
            drawLine->setPoints(findResult);
            
            delete endPoint;
            endPoint = NULL;
        }
        else
        {
            startPoint = new AstarNodePoint(x,y);
            
            drawLine->setRoleStartPoint(startPoint);
        }
    }
    else
    {
        CCLog("位置不能到达！！！");
        ShowTip::showTipCenter("位置不能到达！！！", 30, 2);
    }
}

