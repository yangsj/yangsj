//
//  Alert.h
//  snake222
//
//  Created by yangsj on 14-3-25.
//
//

#ifndef __snake222__Alert__
#define __snake222__Alert__

#include <iostream>
#include "cocos2d.h"
#include "PriorityType.h"
#include "BasePanelLayer.h"
USING_NS_CC;

enum AlertType
{
    ALERT_YES = 1,
    ALERT_NO = 2
};

typedef void (CCObject::*AlertCallBack)(AlertType);
#define alert_callback(_callback) (AlertCallBack)(&_callback)

class Alert : public BasePanelLayer
{
    
public:
    
    Alert();
    ~Alert();
    
    CREATE_FUNC(Alert);

    void onButtonClicked(CCObject* sender);
    void show(const char* msg, CCObject* target, AlertCallBack callBack, const char* yesLabel, const char* noLabel);

    static void showAlert(const char* msg, CCObject* target, AlertCallBack callBack);
    static void showAlert(const char* msg, CCObject* target, AlertCallBack callBack, const char* yesLabel, const char* noLabel);

private:

    CCObject* targetObj;
    AlertCallBack callFun;
    
protected:
    
    virtual void setPrioriryType();
    virtual void setLevelType();
};


#endif /* defined(__snake222__Alert__) */
