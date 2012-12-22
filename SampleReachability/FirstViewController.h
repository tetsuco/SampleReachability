//
//  FirstViewController.h
//  SampleReachability
//
//  Created by tetsuco on 11/09/01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"


@class Reachability;

@interface FirstViewController : UIViewController {
    Reachability* hostReach;		// ホスト接続
    Reachability* internetReach;	// 3Gネットワーク
    Reachability* wifiReach;		// Wi-Fi
}

@end
