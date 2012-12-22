//
//  FirstViewController.m
//  SampleReachability
//
//  Created by tetsuco on 11/09/01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"


@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // ネットワーク接続状況確認
    [self reachabilityStart];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//--------------------------------------------------
// ネットワーク接続状況確認
//--------------------------------------------------
- (void) updateInterfaceWithReachability:(Reachability*)curReach
{
	// 接続状態を取得
	NetworkStatus status = [curReach currentReachabilityStatus];
	
    // ホスト接続
	if(curReach == hostReach)
	{
		if( status == NotReachable )
		{
			NSLog(@"Host connection is failed.");
		} else {
			NSLog(@"Host connection is successful.");
		}
    }
    
	// 3Gネットワーク接続
	if(curReach == internetReach)
	{
		if( status == NotReachable )
		{
			NSLog(@"3G network is failed.");
		} else {
			NSLog(@"3G network is successful.");
		}
	}
    
	// Wi-Fi接続
	if(curReach == wifiReach)
	{
		if( status == NotReachable )
		{
			NSLog(@"Wi-Fi is failed.");
		} else {
			NSLog(@"Wi-Fi is successful.");
		}
	}
}

// ネットワーク接続状況確認
- (void)reachabilityStart
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    
    // ホスト接続を確認
    hostReach = [[Reachability reachabilityWithHostName: @"www.apple.com"] retain];
    [hostReach startNotifier];
    [self updateInterfaceWithReachability: hostReach];
    
    // 3G接続を確認
    internetReach = [[Reachability reachabilityForInternetConnection] retain];
    [internetReach startNotifier];
    [self updateInterfaceWithReachability: internetReach];
    
    // Wi-Fi接続を確認
    wifiReach = [[Reachability reachabilityForLocalWiFi] retain];
    [wifiReach startNotifier];
    [self updateInterfaceWithReachability: wifiReach];
}

// ネットワーク接続の状態が変化したときに呼ばれる
- (void)reachabilityChanged:(NSNotification*)note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	[self updateInterfaceWithReachability: curReach];
}

@end
