//
//  AstarScene.cpp
//  snake222
//
//  Created by yangsj on 14-3-26.
//
//

#include "AstarScene.h"


AstarScene::AstarScene()
{
    
}

AstarScene::~AstarScene()
{
    
}

bool AstarScene::init()
{
    if ( BaseGameScene::init() )
    {
        
        this->addChild(AstarLayer::create());
        
        return true;
    }
    return false;
}