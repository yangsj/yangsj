//
//  BaseGameScene.cpp
//  snake222
//
//  Created by yangsj on 14-3-18.
//
//

#include "BaseGameScene.h"
#include "TouchEffectLayer.h"

BaseGameScene::BaseGameScene()
{
    
}

BaseGameScene::~BaseGameScene()
{
    
}

void BaseGameScene::runScene()
{
//    CCDirector::sharedDirector()->replaceScene(CCTransitionMoveInL::create(0.5, this));
//    CCDirector::sharedDirector()->replaceScene(CCTransitionFlipX::create(2, this));
    CCDirector::sharedDirector()->replaceScene(CCTransitionSlideInL::create(0.5, this));
    
    this->addChild(TouchEffectLayer::create(), INT_MAX);
}