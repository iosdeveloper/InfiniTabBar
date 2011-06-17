//
//  ViewController.m
//  Created by http://github.com/iosdeveloper
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Items
	UITabBarItem *favorites = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:0];
	UITabBarItem *topRated = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:1];
	UITabBarItem *featured = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:2];
	UITabBarItem *recents = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemRecents tag:3];
	UITabBarItem *contacts = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:4];
	UITabBarItem *history = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:5];
	UITabBarItem *bookmarks = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:6];
	UITabBarItem *search = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:7];
	UITabBarItem *downloads = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:8];
	[downloads setBadgeValue:@"2"];
	UITabBarItem *mostRecent = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent tag:9];
	UITabBarItem *mostViewed = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:10];
	
	// Tab bar
	InfiniTabBar *tabBar = [[InfiniTabBar alloc] initWithItems:[NSArray arrayWithObjects:favorites,
																topRated,
																featured,
																recents,
																contacts,
																history,
																bookmarks,
																search,
																downloads,
																mostRecent,
																mostViewed, nil]];
	
	[favorites release];
	[topRated release];
	[featured release];
	[recents release];
	[contacts release];
	[history release];
	[bookmarks release];
	[search release];
	[downloads release];
	[mostRecent release];
	[mostViewed release];
	
	[tabBar setTag:100];
	// Don't show scroll indicator
	[tabBar setShowsHorizontalScrollIndicator:NO];
	[tabBar setInfiniTabBarDelegate:self];
	[tabBar setBounces:NO];
	
	[[self view] addSubview:tabBar];
	
	[tabBar release];
	
	// UI
	UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 23.0, 178.0, 21.0)];
	[aLabel setText:@"Bounces"];
	
	[[self view] addSubview:aLabel];
	
	[aLabel release];
	
	UISwitch *aSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(206.0, 20.0, 94.0, 27.0)];
	[aSwitch addTarget:self action:@selector(bounces:) forControlEvents:UIControlEventValueChanged];
	
	[[self view] addSubview:aSwitch];
	
	[aSwitch release];
	
	UILabel *bLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 58.0, 178.0, 21.0)];
	[bLabel setText:@"Shows scroll indicator"];
	
	[[self view] addSubview:bLabel];
	
	[bLabel release];
	
	UISwitch *bSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(206.0, 55.0, 94.0, 27.0)];
	[bSwitch addTarget:self action:@selector(showsScrollIndicator:) forControlEvents:UIControlEventValueChanged];
	
	[[self view] addSubview:bSwitch];
	
	[bSwitch release];
	
	UIButton *aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[aButton addTarget:self action:@selector(setNewItems) forControlEvents:UIControlEventTouchUpInside];
	[aButton setFrame:CGRectMake(20.0, 90.0, 280.0, 37.0)];
	[aButton setTitle:@"Set new items" forState:UIControlStateNormal];
	
	[[self view] addSubview:aButton];
	
	UIButton *bButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[bButton addTarget:self action:@selector(setOldItemsAnimated) forControlEvents:UIControlEventTouchUpInside];
	[bButton setFrame:CGRectMake(20.0, 135.0, 280.0, 37.0)];
	[bButton setTitle:@"Set old items animated" forState:UIControlStateNormal];
	
	[[self view] addSubview:bButton];
	
	UIButton *cButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[cButton addTarget:self action:@selector(scrollToTabBar3) forControlEvents:UIControlEventTouchUpInside];
	[cButton setFrame:CGRectMake(20.0, 180.0, 280.0, 37.0)];
	[cButton setTitle:@"Scroll to tab bar 3" forState:UIControlStateNormal];
	
	[[self view] addSubview:cButton];
	
	UIButton *dButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[dButton addTarget:self action:@selector(scrollAnimatedToTabBar1) forControlEvents:UIControlEventTouchUpInside];
	[dButton setFrame:CGRectMake(20.0, 225.0, 280.0, 37.0)];
	[dButton setTitle:@"Scroll animated to tab bar 1" forState:UIControlStateNormal];
	
	[[self view] addSubview:dButton];
	
	UIButton *eButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[eButton addTarget:self action:@selector(selectItem8) forControlEvents:UIControlEventTouchUpInside];
	[eButton setFrame:CGRectMake(20.0, 270.0, 280.0, 37.0)];
	[eButton setTitle:@"Select item 8" forState:UIControlStateNormal];
	
	[[self view] addSubview:eButton];
	
	UILabel *cLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 315.0, 230.0, 21.0)];
	[cLabel setText:@"Current tab bar:"];
	
	[[self view] addSubview:cLabel];
	
	[cLabel release];
	
	UILabel *dLabel = [[UILabel alloc] initWithFrame:CGRectMake(258.0, 315.0, 42.0, 21.0)];
	[dLabel setTag:200];
	[dLabel setText:@"1"];
	[dLabel setTextAlignment:UITextAlignmentRight];
	
	[[self view] addSubview:dLabel];
	
	[dLabel release];
	
	UILabel *eLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 344.0, 230.0, 21.0)];
	[eLabel setText:@"Selected item:"];
	
	[[self view] addSubview:eLabel];
	
	[eLabel release];
	
	UILabel *fLabel = [[UILabel alloc] initWithFrame:CGRectMake(258.0, 344.0, 42.0, 21.0)];
	[fLabel setTag:201];
	[fLabel setTextAlignment:UITextAlignmentRight];
	
	[[self view] addSubview:fLabel];
	
	[fLabel release];
	
	UIButton *fButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[fButton addTarget:self action:@selector(scrollToPreviousTabBar) forControlEvents:UIControlEventTouchUpInside];
	[fButton setTransform:CGAffineTransformMakeRotation(M_PI)];
	[fButton setFrame:CGRectMake(17.0, 364.0, 29.0, 31.0)];
	
	[[self view] addSubview:fButton];
	
	UIButton *gButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[gButton addTarget:self action:@selector(scrollToNextTabBar) forControlEvents:UIControlEventTouchUpInside];
	[gButton setFrame:CGRectMake(274.0, 364.0, 29.0, 31.0)];
	
	[[self view] addSubview:gButton];
}

- (void)bounces:(id)sender {
	[(InfiniTabBar *)[[self view] viewWithTag:100] setBounces:[(UISwitch *)sender isOn]];
}

- (void)showsScrollIndicator:(id)sender {
	[(InfiniTabBar *)[[self view] viewWithTag:100] setShowsHorizontalScrollIndicator:[(UISwitch *)sender isOn]];
}

- (void)setNewItems {
	UITabBarItem *featured = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
	[featured setBadgeValue:@"1"];
	UITabBarItem *mostViewed = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:1];
	UITabBarItem *search = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:2];
	UITabBarItem *favorites = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:3];
	UITabBarItem *more = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:4];
	
	[(InfiniTabBar *)[[self view] viewWithTag:100] setItems:[NSArray arrayWithObjects:featured,
															   mostViewed,
															   search,
															   favorites,
															   more, nil] animated:NO];
	
	[featured release];
	[mostViewed release];
	[search release];
	[favorites release];
	[more release];
}

- (void)setOldItemsAnimated {
	UITabBarItem *favorites = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:0];
	UITabBarItem *topRated = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:1];
	UITabBarItem *featured = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:2];
	UITabBarItem *recents = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemRecents tag:3];
	UITabBarItem *contacts = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:4];
	UITabBarItem *history = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:5];
	UITabBarItem *bookmarks = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:6];
	UITabBarItem *search = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:7];
	UITabBarItem *downloads = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:8];
	[downloads setBadgeValue:@"2"];
	UITabBarItem *mostRecent = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent tag:9];
	UITabBarItem *mostViewed = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:10];
	
	[(InfiniTabBar *)[[self view] viewWithTag:100] setItems:[NSArray arrayWithObjects:favorites,
															   topRated,
															   featured,
															   recents,
															   contacts,
															   history,
															   bookmarks,
															   search,
															   downloads,
															   mostRecent,
															   mostViewed, nil] animated:YES];
	
	[favorites release];
	[topRated release];
	[featured release];
	[recents release];
	[contacts release];
	[history release];
	[bookmarks release];
	[search release];
	[downloads release];
	[mostRecent release];
	[mostViewed release];
}

- (void)scrollToTabBar3 {
	[(InfiniTabBar *)[[self view] viewWithTag:100] scrollToTabBarWithTag:2 animated:NO];
}

- (void)scrollAnimatedToTabBar1 {
	[(InfiniTabBar *)[[self view] viewWithTag:100] scrollToTabBarWithTag:0 animated:YES];
}

- (void)selectItem8 {
	[(InfiniTabBar *)[[self view] viewWithTag:100] selectItemWithTag:7];
}

- (void)scrollToPreviousTabBar {
	InfiniTabBar *tabBar = (InfiniTabBar *)[[self view] viewWithTag:100];
	[tabBar scrollToTabBarWithTag:[tabBar currentTabBarTag] - 1 animated:YES];
}

- (void)scrollToNextTabBar {
	InfiniTabBar *tabBar = (InfiniTabBar *)[[self view] viewWithTag:100];
	[tabBar scrollToTabBarWithTag:[tabBar currentTabBarTag] + 1 animated:YES];
}

- (void)infiniTabBar:(InfiniTabBar *)tabBar didScrollToTabBarWithTag:(int)tag {
	[(UILabel *)[[self view] viewWithTag:200] setText:[NSString stringWithFormat:@"%i", tag + 1]];
}

- (void)infiniTabBar:(InfiniTabBar *)tabBar didSelectItemWithTag:(int)tag {
	[(UILabel *)[[self view] viewWithTag:201] setText:[NSString stringWithFormat:@"%i", tag + 1]];
}

- (void)dealloc {
    [super dealloc];
}

@end