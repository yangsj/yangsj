//
//  Challenge2048Layer.h
//  snake222
//
//  Created by yangsj on 14-3-21.
//
//

#ifndef __snake222__Challenge2048Layer__
#define __snake222__Challenge2048Layer__

#include <iostream>
#include <vector>
#include <math.h>
#include "Challenge2048Const.h"
#include "Challenge2048ItemNode.h"
#include "cocos2d.h"
#include "SimpleAudioEngine.h"
#include "../common/ShowTip.h"
#include "../common/SoundType.h"
#include "../common/BaseLayer.h"
USING_NS_CC;

typedef std::vector<Challenge2048ItemNode*> VectorItems;

enum
{
    LEFT = 1,
    RIGHT,
    UP,
    DOWN
};

class Challenge2048Layer : public BaseLayer
{
    
public:
    
    Challenge2048Layer();
    ~Challenge2048Layer();
    
    virtual bool init();
    virtual void draw();
    virtual void onEnter();
    virtual void onExit();
    
    virtual bool ccTouchBegan(CCTouch *pTouch, CCEvent *pEvent);
    virtual void ccTouchMoved(CCTouch *pTouch, CCEvent *pEvent);
    virtual void ccTouchEnded(CCTouch *pTouch, CCEvent *pEvent);
    virtual void ccTouchCancelled(CCTouch *pTouch, CCEvent *pEvent);
    virtual void registerWithTouchDispatcher(void);
    
    CREATE_FUNC(Challenge2048Layer);
    
private:
    
    void directionAction(CCObject* pSender);
    void directionAction(int dir);
    void touchEndAction(CCPoint pt);
    void addScorePerClick(int score);
    
    void menuBackToMain();
    void addNewItemNodeDelay();
    void displayScoreInfo();
    void delayShowGameOver();
    
    ////move
    bool pressLeft();
    bool pressRifht();
    bool pressUp();
    bool pressDown();
    
    bool isGameOver();
    bool isFullAll();
    
    Challenge2048ItemNode* getItemNode();
    
    
    std::vector<VectorItems> list;
    
    float itemStartX;
    float itemStartY;
    
    int totalScore;
    int bestScore;
    int challengeNum;
    
    CCLabelTTF* ttfScoreLabel;
    CCLabelTTF* ttfBestScore;
    CCLabelTTF* ttfChallengeNum;
    
    CCPoint centerPoint;
    CCPoint prevTouchPt;
    CCPoint startTouchPt;
};


#endif /* defined(__snake222__Challenge2048Layer__) */
