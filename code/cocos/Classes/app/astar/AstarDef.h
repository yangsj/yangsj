//
//  AstarDef.h
//  snake222
//
//  Created by yangsj on 14-3-26.
//
//

#ifndef __snake222__AstarDef__
#define __snake222__AstarDef__

#include <iostream>
#include <vector>
#include "AstarNodePoint.h"
#include "AstarNodeItem.h"
#include <stdio.h>


typedef std::vector<int> VecChild;
typedef std::vector<VecChild> VecMap;
typedef std::vector<AstarNodePoint*> VecAstarPoint;
typedef std::vector<AstarNodeItem*> VecAstarItem;
typedef std::vector<VecAstarItem> VecAstarItemMap;



#endif /* defined(__snake222__AstarDef__) */
