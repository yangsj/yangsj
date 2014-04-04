//
//  Challenge2048ItemNode.h
//  snake222
//
//  Created by yangsj on 14-3-21.
//
//

#ifndef __snake222__Challenge2048ItemNode__
#define __snake222__Challenge2048ItemNode__

#include <iostream>
#include "cocos2d.h"
#include "Challenge2048Const.h"

USING_NS_CC;


class Challenge2048ItemNode : public CCLayer
{
    
public:
    
    Challenge2048ItemNode();
    ~Challenge2048ItemNode();
    
    virtual bool init();
    virtual void draw();
    virtual void onEnter();
    
    CCPoint getPoint();
    
    int   getNum();
    void  setNum( int n );
    int   getRow();
    void  setRow( int r );
    int   getCol();
    void  setCol( int c );
    void  setRowAndCol( int r, int c );
    void  setStartPoint( float xx, float yy );
    
    void moveToEnd();
    void moveTween();
    void removeSelf();
    void addSelfOnce();
    void scaleSelf(bool isAddSelf);
    void delayAddSelf(CCObject* pSender);
    
    CREATE_FUNC(Challenge2048ItemNode);
    
private:
    
    int num;
    int row;
    int col;
    float itemStartX;
    float itemStartY;
    
    int colorIndex;
    
    void delayRemoved(CCObject* pSender);
    
    CCLabelTTF* ttfNum;
    
};


#endif /* defined(__snake222__Challenge2048ItemNode__) */
