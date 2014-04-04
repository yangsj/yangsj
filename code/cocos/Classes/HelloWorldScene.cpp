#include "HelloWorldScene.h"
#include "app/help/HelpGameScene.h"
#include "app/game/GameScene.h"
#include "app/challenge2048/Challenge2048Scene.h"
#include "app/astar/AstarScene.h"
#include <algorithm>

USING_NS_CC;

void HelloWorld::runThisScene()
{
//    CCDirector::sharedDirector()->replaceScene(CCTransitionSlideInB::create(0.5, HelloWorld::scene()));
    HelloWorld::scene()->runScene();
}

BaseGameScene* HelloWorld::scene()
//CCScene* HelloWorld::scene()
{
    // 'scene' is an autorelease object
//    CCScene *scene = CCScene::create();
    BaseGameScene* scene = BaseGameScene::create();
    
    // 'layer' is an autorelease object
    HelloWorld *layer = HelloWorld::create();

    // add layer as a child to scene
    scene->addChild(layer);

    // return the scene
    return scene;
}

// on "init" you need to initialize your instance
bool HelloWorld::init()
{
    //////////////////////////////
    // 1. super init first
    if ( !CCLayer::init() )
    {
        return false;
    }
    
    CCSize visibleSize = CCDirector::sharedDirector()->getVisibleSize();
    CCPoint origin = CCDirector::sharedDirector()->getVisibleOrigin();
    
    CCLabelTTF* label01 = CCLabelTTF::create(" 贪吃蛇 ", "Helvetica-Oblique", 80);
    CCLabelTTF* label02 = CCLabelTTF::create(" 2048 ", "Helvetica-Oblique", 80);
    CCLabelTTF* label03 = CCLabelTTF::create(" A*寻路 ",  "Helvetica-Oblique", 80);
    CCLabelTTF* label04 = CCLabelTTF::create(" 帮助说明 ",  "Helvetica-Oblique", 80);
    CCLabelTTF* label05 = CCLabelTTF::create(" 退出游戏 ",  "Helvetica-Oblique", 80);
    
    CCMenuItemLabel* menuItem01 = CCMenuItemLabel::create(label01, this, menu_selector(HelloWorld::menuCloseCallback));
    CCMenuItemLabel* menuItem02 = CCMenuItemLabel::create(label02, this, menu_selector(HelloWorld::menuCloseCallback));
    CCMenuItemLabel* menuItem03 = CCMenuItemLabel::create(label03, this, menu_selector(HelloWorld::menuCloseCallback));
    CCMenuItemLabel* menuItem04 = CCMenuItemLabel::create(label04, this, menu_selector(HelloWorld::menuCloseCallback));
    CCMenuItemLabel* menuItem05 = CCMenuItemLabel::create(label05, this, menu_selector(HelloWorld::menuCloseCallback));
    
    int sx = visibleSize.width * 0.5 + origin.x;
    
    menuItem01->setTag(1);
    menuItem02->setTag(2);
    menuItem03->setTag(3);
    menuItem04->setTag(4);
    menuItem05->setTag(5);
    
    menuItem01->setPosition(CCPoint(sx, visibleSize.height * 0.50 + (menuItem01->getContentSize().height * 2.6) + origin.y));
    menuItem02->setPosition(CCPoint(sx, visibleSize.height * 0.50 + (menuItem02->getContentSize().height * 1.3) + origin.y));
    menuItem03->setPosition(CCPoint(sx, visibleSize.height * 0.50 + origin.y));
    menuItem04->setPosition(CCPoint(sx, visibleSize.height * 0.50 - (menuItem04->getContentSize().height * 1.3) + origin.y));
    menuItem05->setPosition(CCPoint(sx, visibleSize.height * 0.50 - (menuItem05->getContentSize().height * 2.6) + origin.y));

    // create menu, it's an autorelease object
    CCMenu* pMenu = CCMenu::create(menuItem01, menuItem02, menuItem03, menuItem04, menuItem05, NULL);
    pMenu->setPosition(CCPointZero);
    this->addChild(pMenu, 1);

    CCSprite* pSprite = CCSprite::create("bg01.jpg");
    pSprite->setPosition(ccp(visibleSize.width/2 + origin.x, visibleSize.height/2 + origin.y));
    this->addChild(pSprite, 0);
    
    time_t t = time(0);
    char tmp[64];
    strftime(tmp, sizeof(tmp), "%Y%m%d %X %A", localtime(&t));
    CCLog("%s", tmp);
    
    CCTextureCache::sharedTextureCache()->dumpCachedTextureInfo();
    
    
    CCLog("******************************************");
    std::string str("");
    int n = 3;
    std::vector<int> vec;
    vec.push_back(1);
    
    std::vector< std::vector<int> > vecs;
    vecs.push_back(vec);
    CCLog("----第%d行----", 0);
    CCLog(" 1");
    for ( int i = 0; i < n; i++ )
    {
        std::vector<int> temp;
        CCLog("----第%d行----", i + 1);
        for (int j = 0; j <= vec.size(); j++)
        {
            int num = ( j == 0 || j == vec.size()) ? 1 : vec[j] + vec[j-1];
            temp.push_back(num);
            char ts[16];
            sprintf(ts, " %d", num);
            CCLog(ts);
        }
        vec = temp;
        vecs.push_back(temp);
    }
    CCLog("******************************************");
    return true;
}


void HelloWorld::menuCloseCallback(CCObject* pSender)
{
    switch (((CCNode*)pSender)->getTag()) {
        case 1:
            CCLog("go start game snake");
            GameScene::create()->runScene();
            break;
        case 2:
            CCLog("go start game 2048");
            Challenge2048Scene::create()->runScene();
            break;
        case 3:
            CCLog("go game A*");
            AstarScene::create()->runScene();
            break;
        case 4:
            CCLog("go game help");
            HelpGameScene::create()->runScene();
            break;
        case 5:
            #if (CC_TARGET_PLATFORM == CC_PLATFORM_WINRT) || (CC_TARGET_PLATFORM == CC_PLATFORM_WP8)
                        CCMessageBox("You pressed the close button. Windows Store Apps do not implement a close button.","Alert");
            #else
                        CCDirector::sharedDirector()->end();
            #if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
                        exit(0);
            #endif
            #endif
            break;
        default:
            break;
    }
}

void HelloWorld::testAlertCall(int tag)
{
    CCLog("@@@@@++++++++====== %d", tag);
}

