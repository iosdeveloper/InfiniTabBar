//
//  ViewController.h
//  Created by http://github.com/iosdeveloper
//

#import <UIKit/UIKit.h>
#import "InfiniTabBar.h"

@interface ViewController : UIViewController <InfiniTabBarDelegate> {
	InfiniTabBar *tabBar;
	
	// UI
	UILabel *dLabel;
	UILabel *fLabel;
}

@property (nonatomic, retain) InfiniTabBar *tabBar;

// UI
@property (nonatomic, retain) UILabel *dLabel;
@property (nonatomic, retain) UILabel *fLabel;

@end