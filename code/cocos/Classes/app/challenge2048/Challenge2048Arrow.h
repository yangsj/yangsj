//
//  Challenge2048Arrow.h
//  snake222
//
//  Created by yangsj on 14-3-21.
//
//

#ifndef __snake222__Challenge2048Arrow__
#define __snake222__Challenge2048Arrow__

#include <iostream>
#include "cocos2d.h"
#include "../NotificationNames.h"
USING_NS_CC;


class Challenge2048Arrow : public CCLayer
{
  
public:
    
    Challenge2048Arrow();
    ~Challenge2048Arrow();
    
    virtual bool init();
//    virtual void draw();
    
    int  getDirection();
    void setDirection(int dir);
    
    CREATE_FUNC(Challenge2048Arrow);
    
private:
    
    int direction;
    
//    CCMenuItemFont* menuItem;
    CCMenuItemImage* itemImage;
    
    void onDirectionAction(CCObject* pSender);
    
};


#endif /* defined(__snake222__Challenge2048Arrow__) */
