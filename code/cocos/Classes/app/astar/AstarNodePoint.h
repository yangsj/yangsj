//
//  AstarNodePoint.h
//  snake222
//
//  Created by yangsj on 14-3-26.
//
//

#ifndef __snake222__AstarNodePoint__
#define __snake222__AstarNodePoint__

#include <iostream>

class AstarNodePoint
{
public:
    
    AstarNodePoint( int sx, int sy )
    {
        x = sx;
        y = sy;
    }
    
    int x;
    int y;
};

#endif /* defined(__snake222__AstarNodePoint__) */
