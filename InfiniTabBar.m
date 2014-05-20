//
//  InfiniTabBar.m
//  Created by http://github.com/iosdeveloper
//  Edited by https://github.com/tolgatanriverdi
//

#import "InfiniTabBar.h"

@interface InfiniTabBar()
@property (nonatomic, retain) NSMutableArray *tabBars;
@property (nonatomic, retain) UITabBar *aTabBar;
@property (nonatomic, retain) UITabBar *bTabBar;
@end

@implementation InfiniTabBar

@synthesize infiniTabBarDelegate;
@synthesize tabBars;
@synthesize aTabBar;
@synthesize bTabBar;

#define CONTENT_HEIGHT 49.0f
#define ITEMS_PER_PAGE 5.0f
#define TAB_BAR_WIDTH 320.0/ITEMS_PER_PAGE

- (id)initWithItems:(NSArray *)items {
	self = [super initWithFrame:CGRectMake(0.0, 411.0, 320.0, CONTENT_HEIGHT)];
	
    if (self) {
		self.pagingEnabled = YES;
		self.delegate = self;
		
		self.tabBars = [[[NSMutableArray alloc] init] autorelease];
		
		float x = 0.0;
        //NSLog(@"%s PAGE COUNT: %f",__PRETTY_FUNCTION__,ceil(items.count / ITEMS_PER_PAGE) );
		
		for (double d = 0; d < ceil(items.count / ITEMS_PER_PAGE); d ++) {
			int len = 0;
			
			for (int i = d * ITEMS_PER_PAGE; i < d * ITEMS_PER_PAGE + ITEMS_PER_PAGE; i ++) {
				if (i < items.count) {
					len ++;
                }
            }
            
            UITabBar *tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(x, 0.0, TAB_BAR_WIDTH*len, CONTENT_HEIGHT)];
			tabBar.delegate = self;
			
			tabBar.items = [items objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(d * ITEMS_PER_PAGE, len)]];
            NSLog(@"NEW TABBAR ITEM COUNT: %d",tabBar.items.count);
			
			[self addSubview:tabBar];
			
			[self.tabBars addObject:tabBar];
			
			
			x += TAB_BAR_WIDTH*tabBar.items.count;
            [tabBar release];
		}
		
		self.contentSize = CGSizeMake(x, CONTENT_HEIGHT);
	}
	
    return self;
}

- (void)setBounces:(BOOL)bounces {
	if (bounces) {
		int count = self.tabBars.count;
		
		if (count > 0) {
			if (self.aTabBar == nil) {
				self.aTabBar = [[[UITabBar alloc] initWithFrame:CGRectMake(-320.0, 0.0, 320.0, CONTENT_HEIGHT)]autorelease];
            }
			
			[self addSubview:self.aTabBar];
			
			if (self.bTabBar == nil) {
				self.bTabBar = [[[UITabBar alloc] initWithFrame:CGRectMake(count * 320.0, 0.0, 320.0, CONTENT_HEIGHT)] autorelease];
            }
			
			[self addSubview:self.bTabBar];
		}
	} else {
		[self.aTabBar removeFromSuperview];
		[self.bTabBar removeFromSuperview];
	}
	
	[super setBounces:bounces];
}

- (void)setItems:(NSArray *)items animated:(BOOL)animated {
	for (UITabBar *tabBar in self.tabBars) {
		int len = 0;
		
		for (int i = [self.tabBars indexOfObject:tabBar] * ITEMS_PER_PAGE; i < [self.tabBars indexOfObject:tabBar] * ITEMS_PER_PAGE + ITEMS_PER_PAGE; i ++) {
			if (i < items.count) {
				len ++;
            }
        }
		
		[tabBar setItems:[items objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange([self.tabBars indexOfObject:tabBar] * ITEMS_PER_PAGE, len)]] animated:animated];
	}
	
	self.contentSize = CGSizeMake(ceil(items.count / ITEMS_PER_PAGE) * 320.0, CONTENT_HEIGHT);
}

- (int)currentTabBarTag {
	return self.contentOffset.x / 320.0;
}

- (int)selectedItemTag {
	for (UITabBar *tabBar in self.tabBars)
		if (tabBar.selectedItem != nil)
			return tabBar.selectedItem.tag;
	
	// No item selected
	return 0;
}

- (BOOL)scrollToTabBarWithTag:(int)tag animated:(BOOL)animated {
	for (UITabBar *tabBar in self.tabBars)
		if ([self.tabBars indexOfObject:tabBar] == tag) {
			UITabBar *tabBar = [self.tabBars objectAtIndex:tag];
			
			[self scrollRectToVisible:tabBar.frame animated:animated];
			
			if (animated == NO)
				[self scrollViewDidEndDecelerating:self];
			
			return YES;
		}
		
	return NO;
}

- (BOOL)selectItemWithTag:(int)tag {
	for (UITabBar *tabBar in self.tabBars)
		for (UITabBarItem *item in tabBar.items)
			if (item.tag == tag) {
				tabBar.selectedItem = item;
				
				[self tabBar:tabBar didSelectItem:item];
				
				return YES;
			}
	
	return NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	[infiniTabBarDelegate infiniTabBar:self didScrollToTabBarWithTag:scrollView.contentOffset.x / 320.0];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
	[self scrollViewDidEndDecelerating:scrollView];
}

- (void)tabBar:(UITabBar *)cTabBar didSelectItem:(UITabBarItem *)item {
	// Act like a single tab bar
	for (UITabBar *tabBar in self.tabBars)
		if (tabBar != cTabBar)
			tabBar.selectedItem = nil;
	
	[infiniTabBarDelegate infiniTabBar:self didSelectItemWithTag:item.tag];
}

- (void)dealloc {
	[bTabBar release];
	[aTabBar release];
	[tabBars release];
	
	[super dealloc];
}

@end