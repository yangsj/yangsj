//
//  HelpGameScene.cpp
//  snake222
//
//  Created by yangsj on 14-3-13.
//
//

#include "HelpGameScene.h"
#include "HelpGameLayer.h"

bool HelpGameScene::init()
{
    if ( !CCScene::init())
    {
        return false;
    }
    
    this->addChild(HelpGameLayer::create());
    
    CCTextureCache::sharedTextureCache()->dumpCachedTextureInfo();
    
    return true;
}