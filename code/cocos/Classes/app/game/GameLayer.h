//
//  GameLayer.h
//  snake222
//
//  Created by yangsj on 14-3-13.
//
//

#ifndef __snake222__GameLayer__
#define __snake222__GameLayer__

#include <iostream>
#include "cocos2d.h"
#include "GameItemNode.h"
#include "GameOverLayer.h"

USING_NS_CC;


class GameLayer: public CCLayer
{
public:
    
    GameLayer();
    ~GameLayer();

    virtual bool init();
    virtual void draw();
    virtual void visit(void);
    virtual void onEnter();
    virtual void onExit();
    
    virtual bool ccTouchBegan(CCTouch *pTouch, CCEvent *pEvent);
    //virtual void ccTouchMoved(CCTouch *pTouch, CCEvent *pEvent);
    //virtual void ccTouchEnded(CCTouch *pTouch, CCEvent *pEvent);
    
    virtual void registerWithTouchDispatcher(void);
    
    CREATE_FUNC(GameLayer);
    
private:
    
    //functions
    
    void startSchedule();
    void cleanSchedule();
    void gameOver();
    
    void initialize();
    void logic01(float t);
    void menuBackToMain(CCObject* pSender);
    
    void resumeGame(CCObject* pSender);
    void pauseGame( CCObject* pSender);
    void restartGame( CCObject* pSender);
    
    void testDelayCall( float t);
    
    GameItemNode* sHead;
    GameItemNode* sFood;
    CCArray* allBody;
    
    CCMenuItem* menuResume;
    CCMenuItem* menuPause;
    
    CCLabelTTF* txtResultNum;
    
    CCSize winSize;
    CCPoint origin;
    
    float startPointX;
    float startPointY;
    float endPointX;
    float endPointY;
    float timeSceond;
    
    int rowNum;
    int colNum;
    
    bool isPauseGame;
    bool isGameOver;
    
    
    static const int gapDist = 32;
};

#endif /* defined(__snake222__GameLayer__) */
