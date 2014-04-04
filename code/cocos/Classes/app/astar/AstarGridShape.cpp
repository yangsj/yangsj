//
//  AstarGridShape.cpp
//  snake222
//
//  Created by yangsj on 14-3-26.
//
//

#include "AstarGridShape.h"


AstarGridShape::AstarGridShape()
{
    isRole = false;
}

AstarGridShape::~AstarGridShape()
{
 
}

void AstarGridShape::draw()
{
    if ( isRole )
    {
        ::ccDrawSolidRect(CCPoint(2, 2), CCPoint(GRID_SIZE - 2, GRID_SIZE - 2), ccc4FFromccc3B(ccYELLOW));
    }
    else
    {
        ::ccDrawSolidRect(CCPoint(0.5, 0.5), CCPoint(GRID_SIZE - 0.5, GRID_SIZE - 0.5), ccc4FFromccc3B(isBlock ? ccRED : ccGREEN));
    }
}