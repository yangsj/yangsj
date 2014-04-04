//
//  Challenge2048Arrow.cpp
//  snake222
//
//  Created by yangsj on 14-3-21.
//
//

#include "Challenge2048Arrow.h"


Challenge2048Arrow::Challenge2048Arrow()
{
//    menuItem = NULL;
    itemImage = NULL;
}

Challenge2048Arrow::~Challenge2048Arrow()
{
    
}

bool Challenge2048Arrow::init()
{
    if ( CCLayer::init() )
    {
        itemImage = CCMenuItemImage::create("arrow01.png", "arrow01_select.png", this, menu_selector(Challenge2048Arrow::onDirectionAction));
        itemImage->setAnchorPoint(CCPoint(0.5,0.5));
        
//        menuItem = CCMenuItemFont::create("←", this, menu_selector(Challenge2048Arrow::onDirectionAction) );
//        menuItem->setScale(3);

        CCMenu* menu = CCMenu::create(itemImage, NULL);
        menu->setPosition(CCPoint(0,0));
        this->addChild(menu);
        
        setDirection(1);
        
        return true;
    }
    return false;
}

//void Challenge2048Arrow::draw()
//{
//    
////    ccDrawSolidRect(CCPoint(0, 0),
////                    CCPoint(100, 30),
////                    ccc4FFromccc3B(ccc3(78,78,78))
////                    );
//    
//    CCLayer::draw();
//}

int Challenge2048Arrow::getDirection()
{
    return direction;
}

void Challenge2048Arrow::setDirection(int dir)
{
    direction = dir;
    std::string str;
    int angle = 0;
    switch (dir)
    {
        case 1: // 270
            str = "←";
            angle = 270;
            break;
        case 2: // 90
            str = "→";
            angle = 90;
            break;
        case 3: // 0
            str = "↑";
            angle = 0;
            break;
        case 4: // 180
            str = "↓";
            angle = 180;
            break;
            
        default:
            break;
    }
//    if ( menuItem )
//    {
//        menuItem->setString(str.c_str());
//    }
    if ( itemImage )
    {
        itemImage->setRotation(angle);
    }
}

void Challenge2048Arrow::onDirectionAction(cocos2d::CCObject *pSender)
{
    CCNotificationCenter::sharedNotificationCenter()->postNotification(NotificationArrowDirection, this);
    CCLog("direction : %d", direction);
}

