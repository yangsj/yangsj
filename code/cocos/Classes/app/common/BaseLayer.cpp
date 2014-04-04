//
//  BaseLayer.cpp
//  snake222
//
//  Created by yangsj on 14-3-25.
//
//

#include "BaseLayer.h"

BaseLayer::BaseLayer()
{
    
}

BaseLayer::~BaseLayer()
{
    
}

void BaseLayer::onEnter()
{
    CCLayer::onEnter();
    this->setKeypadEnabled(true);
}

void BaseLayer::onExit()
{
    CCLayer::onExit();
    this->setKeypadEnabled(false);
}

void BaseLayer::keyBackClicked()
{
    CCLog("!@!@!@!@!@!@!@!@@@@!@!@!@!@!@!@!@!@!@!@!@!@  keyBackClicked");
}

void BaseLayer::keyMenuClicked()
{
    CCLog("!@!@!@!@!@!@!@!@@@@!@!@!@!@!@!@!@!@!@!@!@!@  keyMenuClicked");
}