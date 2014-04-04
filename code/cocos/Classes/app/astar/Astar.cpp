//
//  Astar.cpp
//  snake222
//
//  Created by yangsj on 14-3-26.
//
//

#include "Astar.h"


Astar::Astar()
{
    
}

Astar::~Astar()
{
    VecAstarItemMap::iterator iter = mapAry.begin();
    while (iter != mapAry.end())
    {
        VecAstarItem items = *iter;
        VecAstarItem::iterator iter1 = items.begin();
        while (iter1 != items.end())
        {
            delete *iter1;
            iter1++;
        }
        iter++;
    }
}

void Astar::initMapList(VecMap args)
{
    int x = 0;
    int y = 0;
    
    if ( args.empty())
    {
        return ;
    }
    
    lengx = args.size();
    lengy = args[0].size();
    
    mapAry.clear();
    CCLog("???????????????????????????????????????");
    for ( VecMap::iterator iter = args.begin(); iter != args.end(); ++iter )
    {
        VecChild tempChild = *iter;
        VecAstarItem tempItems;
        for ( VecChild::iterator iter2 = tempChild.begin(); iter2 != tempChild.end(); ++iter2)
        {
            int val = (int)*iter2;
            AstarNodeItem* item = new AstarNodeItem();
            item->isBlock = val == 0;
            item->isCan = val != 0;
            item->x = x;
            item->y = y++;
            tempItems.push_back(item);
            
            CCLog("Astar [ x=%d , y=%d]  num = %d", item->x, item->y, val);
        }
        y = 0;
        x++;
        mapAry.push_back(tempItems);
    }
}

VecAstarPoint Astar::find(AstarNodePoint* sPoint, AstarNodePoint* ePoint)
{
    initSets();
    startPos = sPoint;
    endPos = ePoint;
    CCLog("start point (x = % d , y = %d)  ______  end point (x = % d , y = %d)", startPos->x, startPos->y, endPos->x, endPos->y);
//    if (sPoint->x != ePoint->x && sPoint->y != ePoint->y)
//    {
        loop();
//    }
    return getResult();
}

void Astar::initSets()
{
    openAry.clear();
    closeAry.clear();
    curItem = NULL;
    endItem = NULL;
}

void Astar::loop()
{
    AstarNodeItem* item = getAstarItem(startPos->x, startPos->y);
    while ( item && toFind(item->x, item->y) == false)
    {
        if ( openAry.empty() == false )
        {
            item = openAry.back();
            openAry.pop_back();
        }
        else
        {
            return ;
        }
    }
}

VecAstarPoint Astar::getResult()
{
    VecAstarPoint temp;
    if ( endItem )
    {
        temp.push_back(new AstarNodePoint(endItem->x, endItem->y));
        AstarNodeItem* item = endItem->parentNode;
        while ( item )
        {
            temp.push_back( new AstarNodePoint( item->x, item->y ));
            item = item->parentNode;
        }
        clearCheckMark();
    }
    else
    {
        temp.push_back(new AstarNodePoint(startPos->x, startPos->y));
    }
    return temp;
}

AstarNodeItem* Astar::getAstarItem(int x, int y)
{
    if ( x >= 0 && x < lengx && y >= 0 && y < lengy)
    {
        return mapAry[x][y];
    }
    return NULL;
}

bool Astar::toFind(int x, int y)
{
    AstarNodeItem* item = getAstarItem(x, y);
    if (item )
    {
        if ( closeAry.empty() )
        {
            item->parentNode = NULL;
        }
        curItem = item;
        closeAry.push_back(item);
        return check(item);
    }
    else
    {
        return true;
    }
}

bool Astar::check(AstarNodeItem *item)
{
    int itemx = item->x;
    int itemy = item->y;
    int x, y;
    
    bool canLeft  = false;
    bool canRight = false;
    bool canUp    = false;
    bool canDown  = false;
    CCLog("checking x = %d , y = %d", itemx, itemy);
    // 中左
    x = itemx - 1;
    y = itemy;
    item = getAstarItem( x, y );
    canLeft = item && item->isCan;
    if ( addToOpenAry( item, 10 ))
        return true;
    
    // 中右
    x = itemx + 1;
    item = getAstarItem( x, y );
    canRight = item && item->isCan;
    if ( addToOpenAry( item, 10 ))
        return true;
    
    // 中上
    x = itemx;
    y = itemy - 1;
    item = getAstarItem( x, y );
    canUp = item && item->isCan;
    if ( addToOpenAry( item, 10 ))
        return true;
    
    // 中下
    y = itemy + 1;
    item = getAstarItem( x, y );
    canDown = item && item->isCan;
    if ( addToOpenAry( item, 10 ))
        return true;
    
    // 左上
    x = itemx - 1;
    if ( canLeft && canUp )
    {
        y = itemy - 1;
        item = getAstarItem( x, y );
        if ( addToOpenAry( item, 14 ))
            return true;
    }
    
    // 左下
    if ( canLeft && canDown )
    {
        y = itemy + 1;
        item = getAstarItem( x, y );
        if ( addToOpenAry( item, 14 ))
            return true;
    }
    
    x = itemx + 1;
    // 右上
    if ( canRight && canUp )
    {
        y = itemy - 1;
        item = getAstarItem( x, y );
        if ( addToOpenAry( item, 14 ))
            return true;
    }
    
    // 右下
    if ( canRight && canDown )
    {
        y = itemy + 1;
        item = getAstarItem( x, y );
        if ( addToOpenAry( item, 14 ))
            return true;
    }
    
    return openAry.empty();
}

bool Astar::addToOpenAry(AstarNodeItem *item, int g)
{
    if ( item && item->isCan && !checkInCloseAry(item) && !checkInOpenAry(item))
    {
        int endx = endPos->x;
        int endy = endPos->y;
        int h = 10 * ( abs(endx - item->x) + abs(endy - item->y));
        int temp_g = curItem->g + g;
        int temp_f = temp_g + h;
        
        if ( item->parentNode == NULL || temp_f < item->f )
        {
            item->h = h;
            item->g = temp_g;
            item->f = temp_f;
            item->parentNode = curItem;
        }
        if ( h == 0)
        {
            endItem = item;
            return true;
        }
        openAry.push_back(item);
        
        openAryMinToFirst();
    }
    return false;
}

bool sortFunForOpenAry(AstarNodeItem* a, AstarNodeItem* b)
{
    return a->f >= b->f;
}

void Astar::openAryMinToFirst()
{
    std::sort(openAry.begin(), openAry.end(), sortFunForOpenAry);
}

bool Astar::checkInCloseAry(AstarNodeItem *item)
{
    for ( VecAstarItem::iterator iter = closeAry.begin(); iter != closeAry.end(); ++iter )
    {
        AstarNodeItem* temp = *iter;
        if ( temp->x == item->x && temp->y == item->y )
        {
            return true;
        }
    }
    return false;
}

bool Astar::checkInOpenAry(AstarNodeItem *item)
{
    for ( VecAstarItem::iterator iter = openAry.begin(); iter != openAry.end(); ++iter )
    {
        AstarNodeItem* temp = *iter;
        if ( temp->x == item->x && temp->y == item->y )
        {
            return true;
        }
    }
    return false;
}

void Astar::clearCheckMark()
{
    for (VecAstarItemMap::iterator iter = mapAry.begin(); iter != mapAry.end(); ++iter)
    {
        VecAstarItem temp = *iter;
        for (VecAstarItem::iterator iter2 = temp.begin(); iter2 != temp.end(); ++iter2)
        {
            AstarNodeItem* item = *iter2;
            if ( item ) item->parentNode = NULL;
        }
    }
}



