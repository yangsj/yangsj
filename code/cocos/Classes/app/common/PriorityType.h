//
//  PriorityType.h
//  snake222
//
//  Created by yangsj on 14-3-18.
//
//

#ifndef snake222_PriorityType_h
#define snake222_PriorityType_h

enum
{
    PRIORITY_TYPE_SYS = INT_MIN + 10,
    PRIORITY_TYPE_WAITING = INT_MIN + 20,
    PRIORITY_TYPE_ALERT = INT_MIN + 30,
    PRIORITY_TYPE_PANEL = INT_MIN + 40,
    
    LAYER_LEVEL_SYS = INT_MAX,
    LAYER_LEVEL_WAITING = INT_MAX - 100,
    LAYER_LEVEL_ALERT = INT_MAX - 200,
    LAYER_LEVEL_PANEL = INT_MAX - 300
};

#endif
