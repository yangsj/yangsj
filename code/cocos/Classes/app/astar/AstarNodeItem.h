//
//  AstarNodeItem.h
//  snake222
//
//  Created by yangsj on 14-3-26.
//
//

#ifndef __snake222__AstarNodeItem__
#define __snake222__AstarNodeItem__

#include <iostream>

class AstarNodeItem
{
public:
    
    // 是否是阻挡节点
    bool isBlock;
    
    // 是否是能通过节点
    bool isCan;
    
    // cols
    int x;
    
    // rows
    int y;
    
    // f
    int f;
    
    // g
    int g;
    
    // h
    int h;
    
    // 查找中的当前父节点
    AstarNodeItem* parentNode;
    
};


#endif /* defined(__snake222__AstarNodeItem__) */
