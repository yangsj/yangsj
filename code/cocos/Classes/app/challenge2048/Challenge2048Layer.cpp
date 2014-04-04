//
//  Challenge2048Layer.cpp
//  snake222
//
//  Created by yangsj on 14-3-21.
//
//

#include "Challenge2048Layer.h"
#include "Challenge2048GameOverLayer.h"
#include "Challenge2048ItemNode.h"
#include "Challenge2048Arrow.h"


Challenge2048Layer::Challenge2048Layer()
{
    ttfBestScore = NULL;
    ttfChallengeNum = NULL;
    ttfScoreLabel = NULL;
}

Challenge2048Layer::~Challenge2048Layer()
{
    
}

void Challenge2048Layer::onEnter()
{
    BaseLayer::onEnter();
    
    CCNotificationCenter::sharedNotificationCenter()->addObserver(this, callfuncO_selector(Challenge2048Layer::directionAction), NotificationArrowDirection, NULL);
    
    this->setTouchEnabled(true);
}

void Challenge2048Layer::onExit()
{
    BaseLayer::onExit();
    
    CCNotificationCenter::sharedNotificationCenter()->removeObserver(this, NotificationArrowDirection);
    
    this->setTouchEnabled(false);
}

bool Challenge2048Layer::init()
{
    if ( BaseLayer::init())
    {
        
        CCSize visiSize = CCDirector::sharedDirector()->getVisibleSize();
        CCPoint origin  = CCDirector::sharedDirector()->getVisibleOrigin();
        
        centerPoint = CCPoint(visiSize.width * 0.5 + origin.x, visiSize.height * 0.5 + origin.y);
        
        int distx = (ITEM_SIZE + ITEM_GAP) * ITEM_COLS * 0.5 - ITEM_GAP * 0.5;
        int disty = (ITEM_SIZE + ITEM_GAP) * ITEM_COLS * 0.5 - ITEM_GAP * 0.5;
        itemStartX = (visiSize.width * 0.5) - distx;
        itemStartY = (visiSize.height* 0.5) - disty + 60;

        CCLabelTTF* menuLabel = CCLabelTTF::create("Back", "宋体", 45);
        CCMenuItemLabel* menuItem = CCMenuItemLabel::create(menuLabel, this, menu_selector(Challenge2048Layer::menuBackToMain));
        menuItem->setPosition(CCPoint(visiSize.width - (menuItem->getContentSize().width * 0.5)-10 + origin.x, origin.y + menuItem->getContentSize().height * 0.5 + 10));
        
        CCMenu* menu = CCMenu::create(menuItem, NULL);
        menu->setPosition(CCPoint(0,0));
        this->addChild( menu, 1 );

        CCLog("**************************************************");
        
        for (int row = 0; row < ITEM_ROWS; row++)
        {
            VectorItems items;
            for (int col = 0; col < ITEM_COLS; col++)
            {
                items.push_back(NULL);
            }
            list.push_back(items);
        }
        
        /////////////  create the direction arrow button |   start
        
        Challenge2048Arrow* arrowLeft = Challenge2048Arrow::create();
        arrowLeft->setDirection(LEFT);
        arrowLeft->setPosition(CCPoint(origin.x + visiSize.width * 0.5 - 110, origin.y + 135));
        addChild(arrowLeft);
        
        Challenge2048Arrow* arrowRifht = Challenge2048Arrow::create();
        arrowRifht->setDirection(RIGHT);
        arrowRifht->setPosition(CCPoint(origin.x + visiSize.width * 0.5 + 110, origin.y + 135));
        addChild(arrowRifht);
        
        Challenge2048Arrow* arrowUp = Challenge2048Arrow::create();
        arrowUp->setDirection(UP);
        arrowUp->setPosition(CCPoint(origin.x + visiSize.width * 0.5, origin.y + 200));
        addChild(arrowUp);
        
        Challenge2048Arrow* arrowDown = Challenge2048Arrow::create();
        arrowDown->setDirection(DOWN);
        arrowDown->setPosition(CCPoint(origin.x + visiSize.width * 0.5, origin.y + 75));
        addChild(arrowDown);
        
        /////////////  create the direction arrow button |   end
        
        /////////////
        
        totalScore = 0;
        challengeNum = 8;
        bestScore = CCUserDefault::sharedUserDefault()->getIntegerForKey("bestScore");
        
        float h = visiSize.height + origin.y;
        
        CCLabelTTF* ttf01 = CCLabelTTF::create("挑战数字：", "宋体", 45);
        CCLabelTTF* ttf02 = CCLabelTTF::create("获得分数:", "宋体", 30);
        CCLabelTTF* ttf03 = CCLabelTTF::create("历史最高:", "宋体", 30);
        
        CCLog("********************************************************************");
        CCLog("width = %f  ,  height = %f ", ttf01->getContentSize().width, ttf01->getContentSize().height);
        CCLog("********************************************************************");
        
        ttf01->setAnchorPoint(CCPoint(1, 1));
        ttf02->setAnchorPoint(CCPoint(1, 1));
        ttf03->setAnchorPoint(CCPoint(1, 1));
        
        ttf01->setFontFillColor(ccColor3B(ccc3(0, 0, 0)));
        ttf02->setFontFillColor(ccColor3B(ccc3(0, 0, 0)));
        ttf03->setFontFillColor(ccColor3B(ccc3(0, 0, 0)));
        
        ttf01->setPosition(CCPoint(visiSize.width * 0.65 + origin.x, h - 20));
        ttf02->setPosition(CCPoint(visiSize.width * 0.3 + origin.x, h - 90));
        ttf03->setPosition(CCPoint(visiSize.width * 0.75 + origin.x, h - 90));
        
        this->addChild(ttf01);
        this->addChild(ttf02);
        this->addChild(ttf03);
        
        ttfChallengeNum = CCLabelTTF::create("2048 ", "Helvetica-Oblique", 45);
        ttfChallengeNum->setFontFillColor(ccColor3B(ccc3(0, 0, 0)));
        ttfChallengeNum->cocos2d::CCNode::setAnchorPoint(CCPoint(0,1));
        ttfChallengeNum->setPosition(CCPoint(visiSize.width * 0.65 + origin.x, h - 20));
        this->addChild(ttfChallengeNum);
        
        ttfScoreLabel = CCLabelTTF::create("100000 ", "Helvetica-Oblique", 30);
        ttfScoreLabel->setFontFillColor(ccColor3B(ccc3(0, 0, 0)));
        ttfScoreLabel->cocos2d::CCNode::setAnchorPoint(CCPoint(0,1));
        ttfScoreLabel->setPosition(CCPoint(visiSize.width * 0.3 + origin.x, h - 90));
        this->addChild(ttfScoreLabel);
        
        char t03[128];
        sprintf(t03, " %d ", bestScore);
        ttfBestScore = CCLabelTTF::create(t03, "Helvetica-Oblique", 30);
        ttfBestScore->setFontFillColor(ccColor3B(ccc3(0, 0, 0)));
        ttfBestScore->cocos2d::CCNode::setAnchorPoint(CCPoint(0,1));
        ttfBestScore->setPosition(CCPoint(visiSize.width * 0.75 + origin.x, h - 90));
        this->addChild(ttfBestScore);
        
        displayScoreInfo();
        
        ////////////
        
        Challenge2048ItemNode* node01 = getItemNode();
        Challenge2048ItemNode* node02 = getItemNode();
        if ( node01 ) this->addChild(node01);
        if ( node02 ) this->addChild(node02);
        
        return true;
    }
    return false;
}

void Challenge2048Layer::displayScoreInfo()
{
    char t01[128];
    char t02[128];
    char t03[128];
    
    sprintf(t01, " %d ", challengeNum);
    sprintf(t02, " %d ", totalScore);
    if ( totalScore > bestScore || bestScore == 0 )
    {
        bestScore = totalScore;
        CCUserDefault::sharedUserDefault()->setIntegerForKey("bestScore", bestScore);
        sprintf(t03, " %d ", bestScore);
        
        ttfBestScore->setString(t03);
    }
    ttfChallengeNum->setString(t01);
    ttfScoreLabel->setString(t02);
}

void Challenge2048Layer::addScorePerClick(int score)
{
    totalScore += score;
    if ( score * 2 == challengeNum )
    {
        char temp[512];
        sprintf(temp, "恭喜！达成了 %d", challengeNum);
        ShowTip::showTip(temp, centerPoint, 50, 2.0f);
        
        challengeNum *= 2;
    }
    displayScoreInfo();
}

bool Challenge2048Layer::isFullAll()
{
    for ( int i = 0; i < ITEM_ROWS; i++ )
    {
        for ( int j = 0; j < ITEM_COLS; j++ )
        {
            if (list[i][j] == NULL)
            {
                return false;
            }
        }
    }
    return true;
}

bool Challenge2048Layer::isGameOver()
{
    for ( int i = 0; i < ITEM_ROWS; i++ )
    {
        int lastNum1 = 0;
        int lastNum2 = 0;
        for ( int j = 0; j < ITEM_COLS; j++ )
        {
            if ( list[i][j] != NULL )
            {
                if ( lastNum1 == list[i][j]->getNum())
                {
                    return false;
                }
                lastNum1 = list[i][j]->getNum();
            }
            else
            {
                return false;
            }
            
            if ( list[j][i] != NULL )
            {
                if ( lastNum2 != 0 )
                {
                    if ( lastNum2 == list[j][i]->getNum())
                    {
                        return false;
                    }
                }
                lastNum2 = list[j][i]->getNum();
            }
            else
            {
                return false;
            }
        }
    }
    
    ShowTip::showTip("游戏结束！！！", centerPoint, 65, 2.0f);
    
    return true;
}

Challenge2048ItemNode* Challenge2048Layer::getItemNode()
{
    bool isExsit = true;
    int row;
    int col;
    int num = 0;
    while (isExsit)
    {
        row = rand() % ITEM_ROWS;
        col = rand() % ITEM_COLS;
        if ( list[row][col] == NULL)
        {
            isExsit = false;
        }
        if ( num >= ITEM_ROWS * ITEM_COLS) break;
        
        num++;
    }
    
    if ( isExsit )
    {
        for ( int i = ITEM_ROWS * ITEM_COLS - 1; i >= 0; i--)
        {
            row = i / ITEM_COLS;
            col = i % ITEM_COLS;
            if ( list[row][col] == NULL )
            {
                isExsit = false;
                break;
            }
        }
        if ( isExsit )
        {
            CCLog("Error--------");
            return NULL;
        }
    }
    
    Challenge2048ItemNode* itemNode = Challenge2048ItemNode::create();
    itemNode->setRowAndCol(row, col);
    itemNode->setStartPoint(itemStartX, itemStartY);
    itemNode->setNum(rand() % 7 == 6 ? 4 : 2);
    itemNode->moveToEnd();
    
    list[row][col] = itemNode;
    
    return itemNode;
}

void Challenge2048Layer::menuBackToMain()
{
    CCNotificationCenter::sharedNotificationCenter()->postNotification(NotificationBackToHome);
}

void Challenge2048Layer::directionAction(cocos2d::CCObject *pSender)
{
    Challenge2048Arrow* arrow = (Challenge2048Arrow*)pSender;
    if ( arrow )
    {
        directionAction(arrow->getDirection());
    }
}

void Challenge2048Layer::registerWithTouchDispatcher()
{
    CCDirector::sharedDirector()->getTouchDispatcher()->addTargetedDelegate(this, 0, true);
}

bool Challenge2048Layer::ccTouchBegan(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent)
{
    startTouchPt = pTouch->getLocation();
    return true;
}

void Challenge2048Layer::ccTouchMoved(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent)
{
    prevTouchPt = pTouch->getPreviousLocation();
}

void Challenge2048Layer::ccTouchEnded(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent)
{
    touchEndAction(pTouch->getLocation());
}

void Challenge2048Layer::ccTouchCancelled(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent)
{
    touchEndAction(pTouch->getLocation());
}

void Challenge2048Layer::touchEndAction(cocos2d::CCPoint pt)
{
    float dx = pt.x - prevTouchPt.x;
    float dy = pt.y - prevTouchPt.y;
    int dir = 0;
    if ( abs(dx) > 15 || abs(dy) > 15)
    {
        if ( abs(dx) >= abs(dy))
        {
            dir = dx > 0 ? RIGHT : LEFT;
        }
        else
        {
            dir = dy > 0 ? UP : DOWN;
        }
        directionAction(dir);
    }
    else
    {
        if ( prevTouchPt.x != startTouchPt.x && prevTouchPt.y != startTouchPt.y)
        {
            prevTouchPt = startTouchPt;
            touchEndAction(pt);
        }
    }
}

void Challenge2048Layer::directionAction(int dir)
{
    if ( isGameOver() )
    {
        return ;
    }
    int old = totalScore;
    bool result = false;
    switch (dir) {
        case LEFT:
            result = pressLeft();
            break;
        case RIGHT:
            result = pressRifht();
            break;
        case UP:
            result = pressUp();
            break;
        case DOWN:
            result = pressDown();
            break;
        default:
            return;
    }
    if (!isFullAll() && result )
    {
        scheduleOnce(schedule_selector(Challenge2048Layer::addNewItemNodeDelay), 0.2f);
        
        CocosDenshion::SimpleAudioEngine::sharedEngine()->playEffect(SOUND_CLICK_RIGHT);
    }
    else
    {
        CocosDenshion::SimpleAudioEngine::sharedEngine()->playEffect(SOUND_CLICK_ERROR);
    }
    
    int add = totalScore - old;
    if ( add > 0 )
    {
        char temp[32];
        sprintf(temp, "+%d", add);
        CCPoint point = CCPoint( ttfScoreLabel->getPosition().x + ttfScoreLabel->getContentSize().width * 0.5, ttfScoreLabel->getPosition().y - ttfScoreLabel->getContentSize().height * 0.5 );
        ShowTip::showTip(temp, point, ttfScoreLabel->getFontSize());
    }
}

void Challenge2048Layer::addNewItemNodeDelay()
{
    Challenge2048ItemNode* node = getItemNode();
    
    if ( node ) this->addChild(node);
    
    // 是否结束
    if ( isGameOver() )
    {
        scheduleOnce(schedule_selector(Challenge2048Layer::delayShowGameOver), 3);
    }
}

void Challenge2048Layer::delayShowGameOver()
{
    Challenge2048GameOver::create()->showPanel();
}

void Challenge2048Layer::draw()
{
    CCPoint origin = CCDirector::sharedDirector()->getVisibleOrigin();
    
    ccDrawSolidRect(CCPoint(origin.x + itemStartX - ITEM_GAP, origin.y + itemStartY - ITEM_GAP),
                      CCPoint(origin.x + itemStartX + DRAW_WIDTH, origin.y + itemStartY + DRAW_HEIGHT),
                      ccc4FFromccc3B(ccc3(78,78,78))
                      );
    
    for ( int i = 0; i < ITEM_ROWS * ITEM_COLS; i++)
    {
        int row = i / ITEM_COLS;
        int col = i % ITEM_COLS;
        float sx = itemStartX + origin.x + ITEM_SIZE_A_GAP * col;
        float sy = itemStartY + origin.y + ITEM_SIZE_A_GAP * row;
        float ex = itemStartX + origin.x + ITEM_SIZE_A_GAP * col + ITEM_SIZE;
        float ey = itemStartY + origin.y + ITEM_SIZE_A_GAP * row + ITEM_SIZE;
        
        ::ccDrawSolidRect(CCPoint(sx, sy),
                          CCPoint(ex, ey),
                          ccc4FFromccc4B(ccc4(102,102,102, 255))
                          );
    }
    BaseLayer::draw();
}

///////////////////////////////////////////

bool Challenge2048Layer::pressLeft()
{
    CCLog("pressLeft");
    bool result = false;
    for (int row = 0; row < ITEM_ROWS; row++)
    {
        Challenge2048ItemNode* lastNode = NULL;
        for (int col = 0; col < ITEM_COLS; col++)
        {
            Challenge2048ItemNode* itemNode = list[row][col];
            if ( itemNode != NULL )
            {
                if ( lastNode != NULL && itemNode->getNum() == lastNode->getNum())
                {
                    lastNode->addSelfOnce();
                    itemNode->setRow(lastNode->getRow());
                    itemNode->setCol(lastNode->getCol());
                    itemNode->removeSelf();
                    
                    addScorePerClick( itemNode->getNum() );
                    
                    list[row][col] = NULL;
                    lastNode = NULL;
                    result = true;
                    
                }
                else
                {
                    lastNode = itemNode;
                }
            }
        }
    }
    for (int row = 0; row < ITEM_ROWS; row++)
    {
        int num = 0;
        for (int col = 0; col < ITEM_COLS; col++)
        {
            Challenge2048ItemNode* itemNode = list[row][col];
            if ( itemNode != NULL )
            {
                itemNode->moveToEnd();
                itemNode->setRow(row);
                itemNode->setCol(num);
                itemNode->moveTween();
                list[row][col] = NULL;
                list[row][num] = itemNode;
                if ( num != col)
                {
                    result = true;
                }
                num++;
            }
        }
    }
    return result;
}

bool Challenge2048Layer::pressRifht()
{
    CCLog("pressRifht");
    bool result = false;
    for (int row = 0; row < ITEM_ROWS; row++)
    {
        Challenge2048ItemNode* lastNode = NULL;
        for (int col = ITEM_COLS - 1; col >= 0; col--)
        {
            Challenge2048ItemNode* itemNode = list[row][col];
            if ( itemNode != NULL )
            {
                if ( lastNode != NULL && itemNode->getNum() == lastNode->getNum())
                {
                    lastNode->addSelfOnce();
                    itemNode->setRow(lastNode->getRow());
                    itemNode->setCol(lastNode->getCol());
                    itemNode->removeSelf();
                    
                    addScorePerClick( itemNode->getNum() );
                    
                    list[row][col] = NULL;
                    lastNode = NULL;
                    result = true;
                }
                else
                {
                    lastNode = itemNode;
                }
            }
        }
    }
    for (int row = 0; row < ITEM_ROWS; row++)
    {
        int num = ITEM_COLS - 1;
        for (int col = ITEM_COLS - 1; col >= 0; col--)
        {
            Challenge2048ItemNode* itemNode = list[row][col];
            if ( itemNode != NULL )
            {
                itemNode->moveToEnd();
                itemNode->setRow(row);
                itemNode->setCol(num);
                itemNode->moveTween();
                list[row][col] = NULL;
                list[row][num] = itemNode;
                if ( num != col)
                {
                    result = true;
                }
                num--;
            }
        }
    }
    return result;
}

bool Challenge2048Layer::pressUp()
{
    CCLog("pressUp");
    bool result = false;
    for (int col = 0; col < ITEM_ROWS; col++)
    {
        Challenge2048ItemNode* lastNode = NULL;
        for (int row = ITEM_ROWS - 1; row >= 0; row--)
        {
            Challenge2048ItemNode* itemNode = list[row][col];
            if ( itemNode != NULL )
            {
                if ( lastNode != NULL && itemNode->getNum() == lastNode->getNum())
                {
                    lastNode->addSelfOnce();
                    itemNode->setRow(lastNode->getRow());
                    itemNode->setCol(lastNode->getCol());
                    itemNode->removeSelf();
                    
                    addScorePerClick( itemNode->getNum() );
                    
                    list[row][col] = NULL;
                    lastNode = NULL;
                    result = true;
                }
                else
                {
                    lastNode = itemNode;
                }
            }
        }
    }
    for (int col = 0; col < ITEM_ROWS; col++)
    {
        int num = ITEM_ROWS - 1;
        for (int row = num; row >= 0; row--)
        {
            Challenge2048ItemNode* itemNode = list[row][col];
            if ( itemNode != NULL )
            {
                itemNode->moveToEnd();
                itemNode->setRow(num);
                itemNode->setCol(col);
                itemNode->moveTween();
                list[row][col] = NULL;
                list[num][col] = itemNode;
                if ( num != row)
                {
                    result = true;
                }
                num--;
            }
        }
    }
    return result;
}

bool Challenge2048Layer::pressDown()
{
    CCLog("pressDown");
    bool result = false;
    for (int col = 0; col < ITEM_COLS; col++)
    {
        Challenge2048ItemNode* lastNode = NULL;
        for (int row = 0; row < ITEM_ROWS; row++)
        {
            Challenge2048ItemNode* itemNode = list[row][col];
            if ( itemNode != NULL )
            {
                if ( lastNode != NULL && itemNode->getNum() == lastNode->getNum())
                {
                    lastNode->addSelfOnce();
                    itemNode->setRow(lastNode->getRow());
                    itemNode->setCol(lastNode->getCol());
                    itemNode->removeSelf();
                    
                    addScorePerClick( itemNode->getNum() );
                    
                    list[row][col] = NULL;
                    lastNode = NULL;
                    result = true;
                }
                else
                {
                    lastNode = itemNode;
                }
            }
        }
    }
    for (int col = 0; col < ITEM_COLS; col++)
    {
        int num = 0;
        for (int row = 0; row < ITEM_ROWS; row++)
        {
            Challenge2048ItemNode* itemNode = list[row][col];
            if ( itemNode != NULL )
            {
                itemNode->moveToEnd();
                itemNode->setRow(num);
                itemNode->setCol(col);
                itemNode->moveTween();
                list[row][col] = NULL;
                list[num][col] = itemNode;
                if ( num != row)
                {
                    result = true;
                }
                num++;
            }
        }
    }
    return result;
}



