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
@synthesize pageControl;
@synthesize theScrollView;

- (id)initWithItems:(NSArray *)items {
	self = [super initWithFrame:CGRectMake(0.0, 300.0, 320.0, 130.0)];
	// TODO:
	//self = [super initWithFrame:CGRectMake(self.superview.frame.origin.x + self.superview.frame.size.width - 320.0, self.superview.frame.origin.y + self.superview.frame.size.height - 59.0, 320.0, 59.0)];
	// Doesn't work. self is nil at this point.
	
    if (self) {
        [self setBackgroundColor:[UIColor blackColor]];
        theScrollView = [[UIScrollView alloc]  initWithFrame:CGRectMake(0.0, 0, 320.0, 130.0)];
		theScrollView.pagingEnabled = YES;
		theScrollView.delegate = self;
		
		self.tabBars = [[[NSMutableArray alloc] init] autorelease];
		
		float x = 0.0;
		
		for (double d = 0; d < ceil(items.count / 4.0); d ++) {
			UITabBar *tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(x, 0.0, 320.0, 100.0)];
			tabBar.delegate = self;
			
			int len = 0;
			
			for (int i = d * 4; i < d * 4 + 4; i ++)
				if (i < items.count)
					len ++;
			
			tabBar.items = [items objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(d * 4, len)]];
			
			[self.theScrollView addSubview:tabBar];
			
			[self.tabBars addObject:tabBar];
			
			[tabBar release];
			
			x += 320.0;
		}
		
		self.theScrollView.contentSize = CGSizeMake(x, 130.0);
        [self addSubview:self.theScrollView];
        [self setShowsPageControl:YES];
	}
	
    return self;
}

- (void)setBounces:(BOOL)bounces {
	if (bounces) {
		int count = self.tabBars.count;
		
		if (count > 0) {
			if (self.aTabBar == nil)
				self.aTabBar = [[[UITabBar alloc] initWithFrame:CGRectMake(-320.0, 0.0, 320.0, 130.0)]autorelease];
			
			[[self theScrollView] addSubview:self.aTabBar];
			
			if (self.bTabBar == nil)
				self.bTabBar = [[[UITabBar alloc] initWithFrame:CGRectMake(count * 320.0, 0.0, 320.0, 130.0)] autorelease];
			
			[[self theScrollView] addSubview:self.bTabBar];
		}
	} else {
		[self.aTabBar removeFromSuperview];
		[self.bTabBar removeFromSuperview];
	}
	
	[self.theScrollView setBounces:bounces];
}

- (void)setShowsPageControl:(BOOL)showsPageControl {
    if(showsPageControl) {
        if(!self.pageControl) {
            self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-30, self.frame.size.width, 20)];
            
            [self addSubview:self.pageControl];
        }
        int count = self.tabBars.count;
        [self.pageControl setNumberOfPages:count];

    } else if(pageControl) {
            [self.pageControl removeFromSuperview];
            self.pageControl = nil;

    }
}

-(void)setShowsHorizontalScroller:(BOOL)show {
    [self.theScrollView setShowsHorizontalScrollIndicator:show];
}

- (void)setItems:(NSArray *)items animated:(BOOL)animated {
	for (UITabBar *tabBar in self.tabBars) {
		int len = 0;
		for (int i = [self.tabBars indexOfObject:tabBar] * 4; i < [self.tabBars indexOfObject:tabBar] * 4 + 4; i ++)
			if (i < items.count)
				len ++;
		
		[tabBar setItems:[items objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange([self.tabBars indexOfObject:tabBar] * 4, len)]] animated:animated];
	}
	
	self.theScrollView.contentSize = CGSizeMake(ceil(items.count / 4.0) * 320.0, 130.0);
    if(self.pageControl != nil) {
        [self.pageControl setNumberOfPages:ceil(items.count / 4.0)];
    }
    
}

- (int)currentTabBarTag {
	return self.theScrollView.contentOffset.x / 320.0;
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
			
			[self.theScrollView scrollRectToVisible:tabBar.frame animated:animated];
			
			if (animated == NO)
				[self scrollViewDidEndDecelerating:self.theScrollView];
			
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


-(void)selectFirstItem:(BOOL)animated {
    [self scrollToTabBarWithTag:0 animated:animated];
    UITabBarItem *firstItem = [[[self.tabBars objectAtIndex:0] items] objectAtIndex:0];
    [self selectItemWithTag:firstItem.tag];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if(pageControl) {
        [pageControl setCurrentPage:scrollView.contentOffset.x / 320.0];
    }
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