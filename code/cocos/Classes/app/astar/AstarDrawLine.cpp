//
//  AstarDrawLine.cpp
//  snake222
//
//  Created by yangsj on 14-3-26.
//
//

#include "AstarDrawLine.h"

AstarDrawLine::AstarDrawLine()
{
    
}

AstarDrawLine::~AstarDrawLine()
{
    VecAstarPoint::iterator iter = findResult.begin();
    while (iter != findResult.end())
    {
        delete *iter;
        iter++;
    }
}

bool AstarDrawLine::init()
{
    if ( CCLayer::init() )
    {
        endPointX = -1;
        endPointY = -1;
        uintTime = 0.2;
        
        roleShape = AstarGridShape::create();
        roleShape->isRole = true;
        this->addChild(roleShape);
        roleShape->setVisible(false);
        return true;
    }
    return false;
}

void AstarDrawLine::setRoleStartPoint(AstarNodePoint *point)
{
    roleShape->setVisible(true);
    roleShape->setPosition(CCPoint(startX + GRID_SIZE * point->x, startY + GRID_SIZE * point->y));
}

void AstarDrawLine::setRoleEndedPoint(AstarNodePoint *point)
{
    endPointX = point->x;
    endPointY = point->y;
}

void AstarDrawLine::setPoints(VecAstarPoint points)
{
    if (points.empty()) return;
    
    if (endPointX != -1 && endPointY != -1)
    {
        AstarNodePoint* temp = new AstarNodePoint(endPointX, endPointY);
        setRoleStartPoint(temp);
        delete temp;
        temp = 0;
    }
    VecAstarPoint::iterator iter = findResult.begin();
    while (iter != findResult.end())
    {
        delete *iter;
        iter++;
    }
    findResult.clear();
    findResult = points;
    
    setRoleEndedPoint(points[0]);
    stopMoved();
    startMove();
}

void AstarDrawLine::stopMoved()
{
    unschedule(schedule_selector(AstarDrawLine::moveRole));
}

void AstarDrawLine::startMove()
{
    moveNum = (int)findResult.size() - 2;
    moveRole(uintTime);
}

void AstarDrawLine::moveRole(float f)
{
    CCLog("move Role********");
    if ( moveNum < 0 )
    {
        stopMoved();
    }
    else
    {
        AstarNodePoint* pos = findResult[moveNum];
        CCPoint newPos = CCPoint(startX + pos->x * GRID_SIZE, startY + pos->y * GRID_SIZE);
        CCPoint oldPos = roleShape->getPosition();
        
        float dx = abs(newPos.x - oldPos.x);
        float dy = abs(newPos.y - oldPos.y);
        
        float ds = sqrt(dx * dx + dy * dy);
        float timeMove = ds / (GRID_SIZE / uintTime);
        
        CCMoveTo* moveTo = CCMoveTo::create(timeMove, newPos);
        roleShape->runAction(moveTo);
        
        schedule(schedule_selector(AstarDrawLine::moveRole), timeMove);
        
        moveNum--;
    }
}

void AstarDrawLine::draw()
{
    for (int i = 1; i < findResult.size(); ++i)
    {
        AstarNodePoint* p1 = findResult[i-1];
        AstarNodePoint* p2 = findResult[i];
        ::ccDrawLine(CCPoint(startX + GRID_SIZE * ( p1->x + 0.5 ), startY + GRID_SIZE * (p1->y + 0.5)),
                     CCPoint(startX + GRID_SIZE * ( p2->x + 0.5 ), startY + GRID_SIZE * (p2->y + 0.5)));
    }
    
    CCLayer::draw();
}