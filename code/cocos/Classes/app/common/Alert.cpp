//
//  Alert.cpp
//  snake222
//
//  Created by yangsj on 14-3-25.
//
//

#include "Alert.h"

Alert::Alert()
{
    callFun = NULL;
}

Alert::~Alert()
{
}

void Alert::show(const char *msg, CCObject* target, AlertCallBack callBack, const char *yesLabel, const char *noLabel)
{
    CCSize visiSize = CCDirector::sharedDirector()->getVisibleSize();
    CCPoint origin = CCDirector::sharedDirector()->getVisibleOrigin();
    
    CCLayerColor* node = NULL;
    node = CCLayerColor::create();
    node->setColor(ccColor3B(ccc3(0, 0, 0)));
    node->setAnchorPoint(CCPoint(0.5,0.5));
    node->setPosition(CCPoint(visiSize.width * 0.5 + origin.x, visiSize.height * 0.5 + origin.y));
    node->setContentSize(CCSize(480, 320));
    this->addChild(node);
    

    CCLog("width = %f    ====    height = %f", visiSize.width, visiSize.height);
    
    CCLabelTTF* ttfMsg = CCLabelTTF::create(msg, "宋体", 40);
    ttfMsg->setContentSize(CCSize(360, 140));
    ttfMsg->setPosition(CCPoint(45, 90));
    ttfMsg->setDimensions(CCSize(360, 140));
    node->addChild(ttfMsg);
    
    CCLabelTTF* label01 = CCLabelTTF::create(yesLabel, "宋体", 60);
    CCLabelTTF* label02 = CCLabelTTF::create(noLabel , "宋体", 60);
    
    CCMenuItemLabel* menuItem01 = CCMenuItemLabel::create(label01, this, menu_selector(Alert::onButtonClicked));
    CCMenuItemLabel* menuItem02 = CCMenuItemLabel::create(label02, this, menu_selector(Alert::onButtonClicked));
    
    menuItem01->setTag(ALERT_YES);
    menuItem02->setTag(ALERT_NO );
    
    menuItem01->setAnchorPoint(CCPoint(0.5, 0.5));
    menuItem02->setAnchorPoint(CCPoint(0.5, 0.5));
    
    menuItem01->setPosition(CCPoint(node->getContentSize().width * 0.25, 0));
    menuItem02->setPosition(CCPoint(node->getContentSize().height* 0.75, 0));
    
    // create menu, it's an autorelease object
    CCMenu* pMenu = CCMenu::create(menuItem01, menuItem02, NULL);
    pMenu->setPosition(CCPoint(0, menuItem01->getContentSize().height * 0.5));
    node->addChild(pMenu, 1);
    
    targetObj = target;
    callFun   = callBack;
    
    showPanel();
}

void Alert::onButtonClicked(cocos2d::CCObject *sender)
{
    int tag = ((CCNode*)sender)->getTag();
    if (targetObj && callFun)
    {
        AlertType type = ( tag == ALERT_YES) ? ALERT_YES : ALERT_NO;
        (targetObj->*callFun)(type);
    }
    
    if ( this->getParent() )
    {
        this->removeFromParentAndCleanup(true);
    }
}

void Alert::setPrioriryType()
{
    prioriryType = PRIORITY_TYPE_ALERT;
}

void Alert::setLevelType()
{
    levelType = LAYER_LEVEL_ALERT;
}

///////

void Alert::showAlert(const char *msg, CCObject* target, AlertCallBack callBack)
{
    showAlert(msg, target, callBack, "确定", "取消");
}

void Alert::showAlert(const char *msg, CCObject* target, AlertCallBack callBack, const char *yesLabel, const char *noLabel)
{
    Alert* alert = Alert::create();
    alert->show(msg, target, callBack, yesLabel, noLabel);
}