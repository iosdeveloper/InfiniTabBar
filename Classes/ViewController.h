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

@property (nonatomic, strong) InfiniTabBar *tabBar;

// UI
@property (nonatomic, strong) UILabel *dLabel;
@property (nonatomic, strong) UILabel *fLabel;

@end