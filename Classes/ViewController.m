//
//  ViewController.m
//  Created by http://github.com/iosdeveloper
//

#import "ViewController.h"
#import "VSTabBar.h"

@implementation ViewController

@synthesize tabBar;

// UI
@synthesize dLabel;
@synthesize fLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Items
    
    /*
	UITabBarItem *favorites = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:0];
	UITabBarItem *topRated = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:1];
	UITabBarItem *featured = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:2];
	UITabBarItem *recents = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemRecents tag:3];
	UITabBarItem *contacts = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:4];
	UITabBarItem *history = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:5];
	UITabBarItem *bookmarks = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:6];
	UITabBarItem *search = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:7];
	UITabBarItem *downloads = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:8]; downloads.badgeValue = @"2";
	UITabBarItem *mostRecent = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent tag:9];
	UITabBarItem *mostViewed = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:10];
    UITabBarItem *mostPopular = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:11];
    UITabBarItem *veryPopular = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:12];
    UITabBarItem *nazarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"topbar_icon"] tag:13];
     */
    
    
    /*
     UIColor *tabBGColor = [UIColor lightGrayColor];
     self.tabBar = [[InfiniTabBar alloc] initWithItems:[NSArray arrayWithObjects:favorites,
     topRated,
     featured,
     recents,
     contacts,
     history,
     bookmarks,
     search,
     downloads,
     mostRecent,
     mostViewed,
     mostPopular,
     veryPopular,
     nazarItem,
     nil] andBackgroundColor:tabBGColor];
     
     
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
     */
    
    
    VSTabBarItem *item1 = [[VSTabBarItem alloc] initWithImage:[UIImage imageNamed:@"nazar.png"] andTag:0];
    VSTabBarItem *item2 = [[VSTabBarItem alloc] initWithImage:[UIImage imageNamed:@"Beer.png"] andTag:1];
    VSTabBarItem *item3 = [[VSTabBarItem alloc] initWithImage:[UIImage imageNamed:@"Basket.png"] andTag:2];
    VSTabBarItem *item4 = [[VSTabBarItem alloc] initWithImage:[UIImage imageNamed:@"topbar_icon.png"] andTag:3];
    VSTabBarItem *item5 = [[VSTabBarItem alloc] initWithImage:[UIImage imageNamed:@"Money-Bag.png"] andTag:4];
    VSTabBarItem *item6 = [[VSTabBarItem alloc] initWithImage:[UIImage imageNamed:@"nazar.png"] andTag:5];
    VSTabBarItem *item7 = [[VSTabBarItem alloc] initWithImage:[UIImage imageNamed:@"Beer.png"] andTag:6];
    VSTabBarItem *item8 = [[VSTabBarItem alloc] initWithImage:[UIImage imageNamed:@"Basket.png"] andTag:7];
    VSTabBarItem *item9 = [[VSTabBarItem alloc] initWithImage:[UIImage imageNamed:@"topbar_icon.png"] andTag:8];
    VSTabBarItem *item10 = [[VSTabBarItem alloc] initWithImage:[UIImage imageNamed:@"Money-Bag.png"] andTag:9];
    VSTabBarItem *item11 = [[VSTabBarItem alloc] initWithImage:[UIImage imageNamed:@"nazar.png"] andTag:10];
    
	
    UIColor *tabBGColor = [UIColor lightGrayColor];
    self.tabBar = [[InfiniTabBar alloc] initWithItems:[NSArray arrayWithObjects:item1,
                                                       item2,
                                                       item3,
                                                       item4,
                                                       item5,
                                                       item6,
                                                       item7,
                                                       item8,
                                                       item9,
                                                       item10,
                                                       item11,
                                                       nil] andBackgroundColor:tabBGColor];
    
    
    [item1 release];
    [item2 release];
    [item3 release];
    [item4 release];
    [item5 release];
    [item6 release];
    [item7 release];
    [item8 release];
    [item9 release];
    [item10 release];
    [item11 release];
    

	
	// Don't show scroll indicator
	self.tabBar.showsHorizontalScrollIndicator = NO;
	self.tabBar.infiniTabBarDelegate = self;
	self.tabBar.bounces = NO;
	
	[self.view addSubview:self.tabBar];
	
	// UI
	UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 23.0, 178.0, 21.0)];
	aLabel.text = @"Bounces";
	
	[self.view addSubview:aLabel];
	
	[aLabel release];
	
	UISwitch *aSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(206.0, 20.0, 94.0, 27.0)];
	[aSwitch addTarget:self action:@selector(bounces:) forControlEvents:UIControlEventValueChanged];
	
	[self.view addSubview:aSwitch];
	
	[aSwitch release];
	
	UILabel *bLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 58.0, 178.0, 21.0)];
	bLabel.text = @"Shows scroll indicator";
	
	[self.view addSubview:bLabel];
	
	[bLabel release];
	
	UISwitch *bSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(206.0, 55.0, 94.0, 27.0)];
	[bSwitch addTarget:self action:@selector(showsScrollIndicator:) forControlEvents:UIControlEventValueChanged];
	
	[self.view addSubview:bSwitch];
	
	[bSwitch release];
	
	UIButton *aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[aButton addTarget:self action:@selector(setNewItems) forControlEvents:UIControlEventTouchUpInside];
	aButton.frame = CGRectMake(20.0, 90.0, 280.0, 37.0);
	[aButton setTitle:@"Set new items" forState:UIControlStateNormal];
	
	[self.view addSubview:aButton];
	
	UIButton *bButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[bButton addTarget:self action:@selector(setOldItemsAnimated) forControlEvents:UIControlEventTouchUpInside];
	bButton.frame = CGRectMake(20.0, 135.0, 280.0, 37.0);
	[bButton setTitle:@"Set old items animated" forState:UIControlStateNormal];
	
	[self.view addSubview:bButton];
	
	UIButton *cButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[cButton addTarget:self action:@selector(scrollToTabBar3) forControlEvents:UIControlEventTouchUpInside];
	cButton.frame = CGRectMake(20.0, 180.0, 280.0, 37.0);
	[cButton setTitle:@"Scroll to tab bar 3" forState:UIControlStateNormal];
	
	[self.view addSubview:cButton];
	
	UIButton *dButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[dButton addTarget:self action:@selector(scrollAnimatedToTabBar1) forControlEvents:UIControlEventTouchUpInside];
	dButton.frame = CGRectMake(20.0, 225.0, 280.0, 37.0);
	[dButton setTitle:@"Scroll animated to tab bar 1" forState:UIControlStateNormal];
	
	[self.view addSubview:dButton];
	
	UIButton *eButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[eButton addTarget:self action:@selector(selectItem8) forControlEvents:UIControlEventTouchUpInside];
	eButton.frame = CGRectMake(20.0, 270.0, 280.0, 37.0);
	[eButton setTitle:@"Select item 8" forState:UIControlStateNormal];
	
	[self.view addSubview:eButton];
	
	UILabel *cLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 315.0, 230.0, 21.0)];
	cLabel.text = @"Current tab bar:";
	
	[self.view addSubview:cLabel];
	
	[cLabel release];
	
	self.dLabel = [[UILabel alloc] initWithFrame:CGRectMake(258.0, 315.0, 42.0, 21.0)];
	self.dLabel.text = @"1";
	self.dLabel.textAlignment = UITextAlignmentRight;
	
	[self.view addSubview:self.dLabel];
	
	UILabel *eLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 344.0, 230.0, 21.0)];
	eLabel.text = @"Selected item:";
	
	[self.view addSubview:eLabel];
	
	[eLabel release];
	
	self.fLabel = [[UILabel alloc] initWithFrame:CGRectMake(258.0, 344.0, 42.0, 21.0)];
	self.fLabel.textAlignment = UITextAlignmentRight;
	
	[self.view addSubview:self.fLabel];
	
	UIButton *fButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[fButton addTarget:self action:@selector(scrollToPreviousTabBar) forControlEvents:UIControlEventTouchUpInside];
	fButton.transform = CGAffineTransformMakeRotation(M_PI);
	fButton.frame = CGRectMake(17.0, 364.0, 29.0, 31.0);
	
	[self.view addSubview:fButton];
	
	UIButton *gButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[gButton addTarget:self action:@selector(scrollToNextTabBar) forControlEvents:UIControlEventTouchUpInside];
	gButton.frame = CGRectMake(274.0, 364.0, 29.0, 31.0);
	
	[self.view addSubview:gButton];
}

- (void)bounces:(UISwitch *)sender {
	self.tabBar.bounces = sender.on;
}

- (void)showsScrollIndicator:(UISwitch *)sender {
	self.tabBar.showsHorizontalScrollIndicator = sender.on;
}

- (void)setNewItems {
	UITabBarItem *featured = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0]; featured.badgeValue = @"1";
	UITabBarItem *mostViewed = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:1];
	UITabBarItem *search = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:2];
	UITabBarItem *favorites = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:3];
	UITabBarItem *more = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:4];
	
	[self.tabBar setItems:[NSArray arrayWithObjects:featured,
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
	UITabBarItem *downloads = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:8]; downloads.badgeValue = @"2";
	UITabBarItem *mostRecent = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent tag:9];
	UITabBarItem *mostViewed = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:10];
	
	[self.tabBar setItems:[NSArray arrayWithObjects:favorites,
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
	[self.tabBar scrollToTabBarWithTag:2 animated:NO];
}

- (void)scrollAnimatedToTabBar1 {
	[self.tabBar scrollToTabBarWithTag:0 animated:YES];
}

- (void)selectItem8 {
	[self.tabBar selectItemWithTag:7];
}

- (void)scrollToPreviousTabBar {
	[self.tabBar scrollToTabBarWithTag:self.tabBar.currentTabBarTag - 1 animated:YES];
}

- (void)scrollToNextTabBar {
	[self.tabBar scrollToTabBarWithTag:self.tabBar.currentTabBarTag + 1 animated:YES];
}

- (void)infiniTabBar:(InfiniTabBar *)tabBar didScrollToTabBarWithTag:(int)tag {
	self.dLabel.text = [NSString stringWithFormat:@"%d", tag + 1];
}

- (void)infiniTabBar:(InfiniTabBar *)tabBar didSelectItemWithTag:(int)tag {
	self.fLabel.text = [NSString stringWithFormat:@"%d", tag + 1];
}

- (void)dealloc {
	// UI
	[fLabel release];
	[dLabel release];
	
	[tabBar release];
	
    [super dealloc];
}

@end