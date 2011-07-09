//
//  InfiniTabBar.m
//  Created by http://github.com/iosdeveloper
//

#import "InfiniTabBar.h"

@implementation InfiniTabBar

@synthesize infiniTabBarDelegate;
@synthesize tabBars;
@synthesize aTabBar;
@synthesize bTabBar;

- (id)initWithItems:(NSArray *)items {
	self = [super initWithFrame:CGRectMake(0.0, 411.0, 320.0, 49.0)];
	// TODO:
	//self = [super initWithFrame:CGRectMake(self.superview.frame.origin.x + self.superview.frame.size.width - 320.0, self.superview.frame.origin.y + self.superview.frame.size.height - 49.0, 320.0, 49.0)];
	// Doesn't work. self is nil at this point.
	
    if (self) {
		self.pagingEnabled = YES;
		self.delegate = self;
		
		self.tabBars = [[[NSMutableArray alloc] init] autorelease];
		
		float x = 0.0;
		
		for (double d = 0; d < ceil(items.count / 5.0); d ++) {
			UITabBar *tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(x, 0.0, 320.0, 49.0)];
			tabBar.delegate = self;
			
			int len = 0;
			
			for (int i = d * 5; i < d * 5 + 5; i ++)
				if (i < items.count)
					len ++;
			
			tabBar.items = [items objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(d * 5, len)]];
			
			[self addSubview:tabBar];
			
			[self.tabBars addObject:tabBar];
			
			[tabBar release];
			
			x += 320.0;
		}
		
		self.contentSize = CGSizeMake(x, 49.0);
	}
	
    return self;
}

- (void)setBounces:(BOOL)bounces {
	if (bounces) {
		int count = self.tabBars.count;
		
		if (count > 0) {
			if (self.aTabBar == nil)
				self.aTabBar = [[[UITabBar alloc] initWithFrame:CGRectMake(-320.0, 0.0, 320.0, 49.0)]autorelease];
			
			[self addSubview:self.aTabBar];
			
			if (self.bTabBar == nil)
				self.bTabBar = [[[UITabBar alloc] initWithFrame:CGRectMake(count * 320.0, 0.0, 320.0, 49.0)] autorelease];
			
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
		
		for (int i = [self.tabBars indexOfObject:tabBar] * 5; i < [self.tabBars indexOfObject:tabBar] * 5 + 5; i ++)
			if (i < items.count)
				len ++;
		
		[tabBar setItems:[items objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange([self.tabBars indexOfObject:tabBar] * 5, len)]] animated:animated];
	}
	
	self.contentSize = CGSizeMake(ceil(items.count / 5.0) * 320.0, 49.0);
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