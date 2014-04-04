//
//  Challenge2048GameOverLayer.h
//  snake222
//
//  Created by yangsj on 14-3-21.
//
//

#ifndef __snake222__Challenge2048GameOverLayer__
#define __snake222__Challenge2048GameOverLayer__

#include <iostream>
#include "../common/BasePanelLayer.h"


class Challenge2048GameOver : public BasePanelLayer
{
    
public:
    
    Challenge2048GameOver();
    ~Challenge2048GameOver();
    
    virtual bool init();
    virtual void onEnter();
    
    CREATE_FUNC(Challenge2048GameOver);
    
private:
    
    void backHome(CCObject* pSender);
    void restart( CCObject* pSender);
    
};


#endif /* defined(__snake222__Challenge2048GameOverLayer__) */
