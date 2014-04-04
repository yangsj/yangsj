//
//  GameLayer.cpp
//  snake222
//
//  Created by yangsj on 14-3-13.
//
//

#include "GameLayer.h"
#include "HelloWorldScene.h"
#include "GameScene.h"
#include "GameOverLayer.h"
#include "../NotificationNames.h"

GameLayer::GameLayer()
{
    sHead = NULL;
    sFood = NULL;
    allBody = NULL;
    menuPause = NULL;
    menuResume = NULL;
    isGameOver = false;
    
    startPointX = 0;
    startPointY = 0;
    endPointX   = 0;
    endPointX   = 0;
    rowNum  = 0;
    colNum  = 0;
}

GameLayer::~GameLayer()
{
    CC_SAFE_RELEASE_NULL(sHead);
    CC_SAFE_RELEASE_NULL(sFood);
    CCLog("GameLayer 析构函数");
}

void GameLayer::onEnter()
{
    CCLayer::onEnter();
    CCNotificationCenter::sharedNotificationCenter()->addObserver(this, callfuncO_selector(GameLayer::menuBackToMain), NotificationBackToHome,  NULL);
    CCNotificationCenter::sharedNotificationCenter()->addObserver(this, callfuncO_selector(GameLayer::restartGame),    NotificationRestartGame, NULL);
}

void GameLayer::onExit()
{
    CCLayer::onExit();
    
    CCNotificationCenter::sharedNotificationCenter()->removeAllObservers(this);
}

bool GameLayer::init()
{
    if ( !CCLayer::init())
    {
        return false;
    }
    
    initialize();
    
    txtResultNum = CCLabelTTF::create();
    txtResultNum->setPosition(CCPoint(winSize.width * 0.5 + origin.x, winSize.height * 0.95 + origin.y));
    this->addChild(txtResultNum);
    txtResultNum->setString("result");
    txtResultNum->setFontSize(25);
    
    CCLabelTTF* menuLabel = CCLabelTTF::create("返回", "宋体", 50);
    CCMenuItemLabel* menuItem = CCMenuItemLabel::create(menuLabel, this, menu_selector(GameLayer::menuBackToMain));
    menuItem->setPosition(CCPoint(winSize.width - (menuItem->getContentSize().width * 0.5) - 10 + origin.x, menuItem->getContentSize().height * 0.5 + 10 + origin.y));
    
    CCLabelTTF* resumeLabel = CCLabelTTF::create("继续", "宋体", 50);
    menuResume = CCMenuItemLabel::create(resumeLabel, this, menu_selector(GameLayer::resumeGame));
    menuResume->setPosition(CCPoint(winSize.width - (menuResume->getContentSize().width * 0.5) - 10 + origin.x, menuResume->getContentSize().height * 1.5 + 10 + origin.y));
    
    CCLabelTTF* pauseLabel = CCLabelTTF::create("暂停", "宋体", 50);
    menuPause = CCMenuItemLabel::create(pauseLabel, this, menu_selector(GameLayer::pauseGame));
    menuPause->setPosition(CCPoint(winSize.width - (menuPause->getContentSize().width * 0.5) - 10 + origin.x, menuPause->getContentSize().height * 1.5 + 10 + origin.y));
    
    CCMenu* menu = CCMenu::create(menuItem, menuResume, menuPause, NULL);
    menu->setPosition(CCPoint(0,0));
    this->addChild(menu);
    
    menuPause->setVisible(true);
    menuResume->setVisible(false);
    
    sHead = new GameItemNode();
    sFood = new GameItemNode();
    
    srand((int)time(0));
    
    sHead->row = rand()%(rowNum - 1);
    sHead->col = rand()%(colNum - 1);
    
    sFood->row = rand()%(rowNum - 1);
    sFood->col = rand()%(colNum - 1);

    CCLog("====================================sFood->row = %d ,  sFood->col = %d  , rand() = %d", sFood->row, sFood->col, rand());
    
    allBody = CCArray::create();
    allBody->retain();
    
    isGameOver = false;
    
    startSchedule();
    
    return true;
}

void GameLayer::initialize()
{
    winSize = CCDirector::sharedDirector()->getVisibleSize();
    origin = CCDirector::sharedDirector()->getVisibleOrigin();
    
    timeSceond = 0.1;
    rowNum = ((winSize.height - 150) / gapDist);
    colNum = ((winSize.width  - 50)  / gapDist);
    float moveLineNumX = (colNum - 1.0f) / 2.0;
    float moveLineNumY = (rowNum - 1.0f) / 2.0;
    startPointX = winSize.width * 0.5 - gapDist * moveLineNumX + origin.x;
    startPointY = winSize.height* 0.5 - gapDist * moveLineNumY + origin.y + 30.0;
    endPointX   = winSize.width * 0.5 + gapDist * moveLineNumX + origin.x;
    endPointY   = winSize.height* 0.5 + gapDist * moveLineNumY + origin.y + 30.0;
    
    isPauseGame = false;
}

void GameLayer::resumeGame(cocos2d::CCObject *pSender)
{
    isPauseGame = false;
    startSchedule();
}

void GameLayer::pauseGame(cocos2d::CCObject *pSender)
{
    CCLog("clicked pause game");
    isPauseGame = true;
    cleanSchedule();
}

void GameLayer::restartGame(cocos2d::CCObject *pSender)
{
    CCLog("clicked restart game");
    this->removeAllChildrenWithCleanup(true);
    if ( allBody )
    {
        allBody->removeAllObjects();
        allBody->release();
    }
    init();
}

void GameLayer::visit()
{
    CCLayer::visit();
    
    menuPause->setVisible(!isPauseGame);
    menuResume->setVisible(isPauseGame);
}

void GameLayer::menuBackToMain(cocos2d::CCObject *pSender)
{
    HelloWorld::runThisScene();
}

void GameLayer::testDelayCall(float t)
{
    gameOver();
}

void GameLayer::gameOver()
{
    CCLog("GameOver!!!!!!!!!!!!!!!!!!!!!!");
    
    cleanSchedule();
    
    GameOverLayer::create()->showPanel();
    
    isGameOver = true;
    
}

void GameLayer::logic01(float t)
{
    for ( int i = allBody->count() - 1; i >= 0; i-- )
	{
		GameItemNode* sn = (GameItemNode*)allBody->objectAtIndex(i);
        if (sn->row == sHead->row && sn->col == sHead->col)
        {
            gameOver();
            return ;
        }
		if ( i > 0 )
		{
			GameItemNode* snpre = (GameItemNode*)allBody->objectAtIndex( i - 1 );
			sn->dir = snpre->dir;
			sn->row = snpre->row;
			sn->col = snpre->col;
		}
		else
		{
			sn->dir = sHead->dir;
			sn->row = sHead->row;
			sn->col = sHead->col;
		}
	}
    
	switch (sHead->dir)
	{
		case UP:
			sHead->row++;
			if ( sHead->row >= rowNum - 1)
			{
				sHead->row = 0;
			}
			break;
		case DOWN:
			sHead->row--;
			if ( sHead->row < 0)
			{
				sHead->row = rowNum - 2;
			}
			break;
		case LEFT:
			sHead->col--;
			if ( sHead->col < 0)
			{
				sHead->col = colNum - 2;
			}
			break;
		case RIGHT:
			sHead->col++;
			if ( sHead->col >= colNum - 1)
			{
				sHead->col = 0;
			}
			break;
		default:
			break;
	}

	if ( sHead->row == sFood->row  && sHead->col == sFood->col )
	{
		sFood->row = rand()%(rowNum - 1);
		sFood->col = rand()%(colNum - 1);
        
		GameItemNode* sn = new GameItemNode();
		GameItemNode* lastNode = NULL;
        sn->autorelease();
        
        CCLog("==========================================sFood->row = %d ,     sFood->col = %d", sFood->row, sFood->col);
        
		lastNode = allBody->count() > 0 ? (GameItemNode*)allBody->lastObject() : sHead;
        
		switch (lastNode->dir)
		{
			case UP:
				sn->row = lastNode->row - 1;
				sn->col = lastNode->col;
				break;
			case DOWN:
				sn->row = lastNode->row + 1;
				sn->col = lastNode->col;
				break;
			case LEFT:
				sn->row = lastNode->row;
				sn->col = lastNode->col + 1;
				break;
			case RIGHT:
				sn->row = lastNode->row;
				sn->col = lastNode->col - 1;
				break;
			default:
				break;
		}
		this->allBody->addObject(sn);
        
        if ( allBody->count() <= 150 && allBody->count() % 5 == 0 && timeSceond > 0.10)
        {
            timeSceond -= 0.02;
            timeSceond = MAX(timeSceond, 0.10);
            startSchedule();
            CCLog("===================================================== move speed : %f", timeSceond);
        }
	}
    char temp[128];
    sprintf(temp, "已连接数量：%d    time:%f", allBody->count(), timeSceond);
    txtResultNum->setString(temp);
}

void GameLayer::startSchedule()
{
    cleanSchedule();
    schedule(schedule_selector(GameLayer::logic01), timeSceond);
    setTouchEnabled(true);
}

void GameLayer::cleanSchedule()
{
    unschedule(schedule_selector(GameLayer::logic01));
    setTouchEnabled(false);
}

void GameLayer::draw()
{
//    ::glLineWidth(1);
	for ( int i = 0; i < rowNum; i++ )
	{
		::ccDrawLine(CCPoint(startPointX,startPointY+i*gapDist),CCPoint(endPointX, startPointY+i*gapDist)); // heng
	}
    
	for ( int i = 0; i < colNum; i++ )
	{
		::ccDrawLine(CCPoint(startPointX+i*gapDist,startPointY),CCPoint(startPointX+i*gapDist, endPointY));  // shu
	}
    
	::ccDrawSolidRect(CCPoint(sHead->col*gapDist + startPointX + 1, sHead->row*gapDist + startPointY + 1),
                      CCPoint(sHead->col*gapDist + gapDist + startPointX - 1, sHead->row*gapDist + gapDist + startPointY - 1),
                      ccc4FFromccc3B(ccc3(255,0,0))
                      );
    
	for ( int i = 0; i < allBody->count(); i++)
	{
		GameItemNode* node = (GameItemNode*)allBody->objectAtIndex(i);
		::ccDrawSolidRect(CCPoint(node->col*gapDist + startPointX + 1, node->row*gapDist + startPointY + 1),
                          CCPoint(node->col*gapDist + gapDist + startPointX - 1, node->row*gapDist + gapDist + startPointY- 1),
                          ccc4FFromccc4B(ccc4(0,0,255, 250))
                          );
	}
    
	::ccDrawSolidRect(CCPoint(sFood->col*gapDist + startPointX, sFood->row*gapDist + startPointY),
                      CCPoint(sFood->col*gapDist + gapDist + startPointX, sFood->row*gapDist + gapDist + startPointY),
                      ccc4FFromccc3B(ccc3(0,255,255))
                      );
    
    CCLayer::draw();
}

void GameLayer::registerWithTouchDispatcher()
{
    CCDirector::sharedDirector()->getTouchDispatcher()->addTargetedDelegate(this, 0, true);
}

bool GameLayer::ccTouchBegan(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent)
{
    CCPoint p = pTouch->getLocation();
	int nowRow = ((int)p.y - startPointY)/gapDist;
	int nowCol = ((int)p.x - startPointX)/gapDist;
    
	if ( abs(nowRow - sHead->row) > abs(nowCol - sHead->col))
	{
		if ( nowRow > sHead->row)
		{
            if ( sHead->dir != DOWN)
            {
                sHead->dir = UP;
            }
            else if ( nowCol > sHead->col)
            {
                sHead->dir = RIGHT;
            }
            else
            {
                sHead->dir = LEFT;
            }
		}
		else
		{
            if ( sHead->dir != UP)
            {
                sHead->dir = DOWN;
            }
            else if ( nowCol > sHead->col)
            {
                sHead->dir = RIGHT;
            }
            else
            {
                sHead->dir = LEFT;
            }
		}
	}
	else
	{
		if ( nowCol > sHead->col)
		{
            if (sHead->dir != LEFT)
            {
                sHead->dir = RIGHT;
            }
            else if ( nowRow > sHead->row)
            {
                sHead->dir = UP;
            }
            else
            {
                sHead->dir = DOWN;
            }
		}
		else
		{
            if ( sHead->dir != RIGHT )
            {
                sHead->dir = LEFT;
            }
            else if ( nowRow > sHead->row)
            {
                sHead->dir = UP;
            }
            else
            {
                sHead->dir = DOWN;
            }
		}
	}
    
	return true;
}



