//
//  Challenge2048ItemNode.cpp
//  snake222
//
//  Created by yangsj on 14-3-21.
//
//

#include "Challenge2048ItemNode.h"
#include <map>

Challenge2048ItemNode::Challenge2048ItemNode()
{
    
}

Challenge2048ItemNode::~Challenge2048ItemNode()
{
    
}

void Challenge2048ItemNode::onEnter()
{
    CCLayer::onEnter();
    
    this->setContentSize(CCSize(ITEM_SIZE, ITEM_SIZE));
    this->setAnchorPoint(CCPoint(0.5f, 0.5f));
    
    this->scaleSelf( false );
}

bool Challenge2048ItemNode::init()
{
    if ( CCLayer::init() )
    {
//        ttfNum = CCLabelTTF::create("123", "Courier New", 40)；
//        ttfNum = CCLabelTTF::create("123", "Verdana", 40);
        ttfNum = CCLabelTTF::create("123", "Helvetica-Oblique", 40);
        ttfNum->setPosition(CCPoint(ITEM_SIZE * 0.5, ITEM_SIZE * 0.5));
        ttfNum->setFontFillColor(ccColor3B(ccc3(0, 0, 0)));
        this->addChild(ttfNum);
        
        return true;
    }
    return false;
}

void Challenge2048ItemNode::draw()
{
    std::map<int, ccColor3B> colorMap;
    colorMap.insert(std::map<int, ccColor3B>::value_type(0,     ccc3(255,102,102)));
    colorMap.insert(std::map<int, ccColor3B>::value_type(2,     ccc3(255,255,255)));
    colorMap.insert(std::map<int, ccColor3B>::value_type(4,     ccc3(255,255,204)));
    colorMap.insert(std::map<int, ccColor3B>::value_type(8,     ccc3(255,255,153)));
    colorMap.insert(std::map<int, ccColor3B>::value_type(16,    ccc3(255,255,102)));
    colorMap.insert(std::map<int, ccColor3B>::value_type(32,    ccc3(255,255,51 )));
    colorMap.insert(std::map<int, ccColor3B>::value_type(64,    ccc3(255,255,0  )));
    colorMap.insert(std::map<int, ccColor3B>::value_type(128,   ccc3(255,204,0  )));
    colorMap.insert(std::map<int, ccColor3B>::value_type(256,   ccc3(255,153,0  )));
    colorMap.insert(std::map<int, ccColor3B>::value_type(512,   ccc3(255,102,0  )));
    colorMap.insert(std::map<int, ccColor3B>::value_type(1024,  ccc3(255,51 ,0  )));
    colorMap.insert(std::map<int, ccColor3B>::value_type(2048,  ccc3(153,255,204)));
    colorMap.insert(std::map<int, ccColor3B>::value_type(4096,  ccc3(153,255,153)));
    colorMap.insert(std::map<int, ccColor3B>::value_type(8192,  ccc3(153,255,102)));
    colorMap.insert(std::map<int, ccColor3B>::value_type(16384, ccc3(153,255,51 )));
    
    /*
     255,255,255
     255,255,204
     255,255,153
     255,255,102
     255,255,51
     255,255,0
     
     255,204,0
     255,153,0
     255,102,0
     255,51,0
     
     153,255,204
     153,255,153
     153,255,102
     153,255,51
     */
    ::ccDrawSolidRect(CCPoint(0, 0), CCPoint(ITEM_SIZE, ITEM_SIZE), ccc4FFromccc3B(colorMap.find(colorIndex)->second));
    
    CCLayer::draw();
}

int Challenge2048ItemNode::getNum()
{
    return num;
}

void Challenge2048ItemNode::setNum(int n)
{
    num = n;
    colorIndex = n;
    if ( colorIndex < 0 || colorIndex > 16384)
    {
        colorIndex = 0;
    }
    
    if ( ttfNum )
    {
        char temp[64];
        sprintf(temp, "%d", num);
        ttfNum->setString(temp);
    }
}

int Challenge2048ItemNode::getRow()
{
    return row;
}

void Challenge2048ItemNode::setRow(int r)
{
    row = r;
}

int Challenge2048ItemNode::getCol()
{
    return col;
}

void Challenge2048ItemNode::setCol(int c)
{
    col = c;
}

void Challenge2048ItemNode::setRowAndCol(int r, int c)
{
    setRow(r);
    setCol(c);
}

void Challenge2048ItemNode::setStartPoint(float xx, float yy)
{
    itemStartX = xx;
    itemStartY = yy;
}

CCPoint Challenge2048ItemNode::getPoint()
{
    CCPoint origin = CCDirector::sharedDirector()->getVisibleOrigin();
    float sx = itemStartX + origin.x + (ITEM_SIZE + ITEM_GAP) * col;// + ITEM_SIZE * 0.5;
    float sy = itemStartY + origin.y + (ITEM_SIZE + ITEM_GAP) * row;// + ITEM_SIZE * 0.5;
    return CCPoint(sx, sy);
}

void Challenge2048ItemNode::moveToEnd()
{
    this->setScale(1.0f);
    this->stopActionByTag(1);
    this->setPosition(getPoint());
}

void Challenge2048ItemNode::moveTween()
{
    this->setScale(1.0f);
    this->stopActionByTag(1);
    
    CCMoveTo* actionMoveTo = CCMoveTo::create(0.2f, getPoint());
    actionMoveTo->setTag(1);
    this->runAction(actionMoveTo);
}

void Challenge2048ItemNode::removeSelf()
{
    moveTween();
    scheduleOnce(schedule_selector(Challenge2048ItemNode::delayRemoved), 0.16f);
}

void Challenge2048ItemNode::delayRemoved(cocos2d::CCObject *pSender)
{
    removeFromParentAndCleanup(true);
}

void Challenge2048ItemNode::addSelfOnce()
{
    scheduleOnce(schedule_selector(Challenge2048ItemNode::delayAddSelf), 0.16f);
}

void Challenge2048ItemNode::delayAddSelf(cocos2d::CCObject *pSender)
{
    setNum(num * 2);
    scaleSelf( true );
}

void Challenge2048ItemNode::scaleSelf(bool isAddSelf)
{
    CCScaleTo* scaleTo = CCScaleTo::create(0.2f, 1.0f);
    scaleTo->setTag(1);
    
    this->setScale(isAddSelf ? 1.2f : 0.1f);
    this->runAction(scaleTo);
}


