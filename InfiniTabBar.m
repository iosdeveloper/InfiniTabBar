//
//  InfiniTabBar.m
//  Created by http://github.com/iosdeveloper
//

#import "InfiniTabBar.h"

@implementation InfiniTabBar

@synthesize infiniTabBarDelegate;

- (id)initWithItems:(NSArray *)items {
	self = [super initWithFrame:CGRectMake(0.0, 411.0, 320.0, 49.0)];
	// TODO:
	//self = [super initWithFrame:CGRectMake([[self superview] frame].origin.x + [[self superview] frame].size.width - 320.0, [[self superview] frame].origin.y + [[self superview] frame].size.height - 49.0, 320.0, 49.0)];
	// Doesn't work. self is nil at this point.
	
    if (self) {
		[self setPagingEnabled:YES];
		[self setDelegate:self];
		
		float x = 0.0;
		
		for (double d = 0; d < ceil([items count] / 5.0); d ++) {
			UITabBar *tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(x, 0.0, 320.0, 49.0)];
			[tabBar setTag:d];
			[tabBar setDelegate:self];
			
			int len = 0;
			
			for (int i = d * 5; i < d * 5 + 5; i ++)
				if (i < [items count])
					len ++;
			
			[tabBar setItems:[items objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(d * 5, len)]]];
			
			[self addSubview:tabBar];
			
			[tabBar release];
			
			x += 320.0;
		}
		
		[self setContentSize:CGSizeMake(x, 49.0)];
	}
	
    return self;
}

- (void)setBounces:(BOOL)bounces {
	if (bounces) {
		int tags = 0;
		
		for (UIView *subview in [self subviews])
			if ([subview class] == [UITabBar class] && [subview tag] + 1 > tags)
				tags = [subview tag] + 1;
		
		if (tags > 0) {
			UITabBar *aTabBar = [[UITabBar alloc] initWithFrame:CGRectMake(-320.0, 0.0, 320.0, 49.0)];
			[aTabBar setTag:998];
			
			[self addSubview:aTabBar];
			
			[aTabBar release];
			
			UITabBar *bTabBar = [[UITabBar alloc] initWithFrame:CGRectMake(tags * 320.0, 0.0, 320.0, 49.0)];
			[bTabBar setTag:999];
			
			[self addSubview:bTabBar];
			
			[bTabBar release];
		}
	} else {
		[[self viewWithTag:998] removeFromSuperview];
		[[self viewWithTag:999] removeFromSuperview];
	}
	
	[super setBounces:bounces];
}

- (void)setItems:(NSArray *)items animated:(BOOL)animated {
	for (UIView *subview in [self subviews])
		if ([subview class] == [UITabBar class]) {
			int len = 0;
			
			for (int i = [subview tag] * 5; i < [subview tag] * 5 + 5; i ++)
				if (i < [items count])
					len ++;
			
			[(UITabBar *)subview setItems:[items objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange([subview tag] * 5, len)]] animated:animated];
		}
	
	[self setContentSize:CGSizeMake(ceil([items count] / 5.0) * 320.0, 49.0)];
}

- (int)currentTabBarTag {
	return [self contentOffset].x / 320.0;
}

- (int)selectedItemTag {
	for (UIView *subview in [self subviews])
		if ([subview class] == [UITabBar class] && [(UITabBar *)subview selectedItem] != nil)
			return [[(UITabBar *)subview selectedItem] tag];
	
	// No item selected
	return 0;
}

- (BOOL)scrollToTabBarWithTag:(int)tag animated:(BOOL)animated {
	for (UIView *subview in [self subviews])
		if ([subview class] == [UITabBar class] && tag == [subview tag]) {
			[self scrollRectToVisible:[subview frame] animated:animated];
			
			if (animated == NO)
				[self scrollViewDidEndDecelerating:self];
			
			return YES;
		}
	
	return NO;
}

- (BOOL)selectItemWithTag:(int)tag {
	for (UIView *subview in [self subviews])
		if ([subview class] == [UITabBar class])
			for (UITabBarItem *item in [(UITabBar *)subview items])
				if ([item tag] == tag) {
					[(UITabBar *)subview setSelectedItem:item];
					
					[self tabBar:(UITabBar *)subview didSelectItem:item];
					
					return YES;
				}
	
	return NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	[infiniTabBarDelegate infiniTabBar:self didScrollToTabBarWithTag:[scrollView contentOffset].x / 320.0];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
	[self scrollViewDidEndDecelerating:scrollView];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
	// Act like a single tab bar
	for (UIView *subview in [self subviews])
		if ([subview class] == [UITabBar class] && subview != tabBar)
			[(UITabBar *)subview setSelectedItem:nil];
	
	[infiniTabBarDelegate infiniTabBar:self didSelectItemWithTag:[item tag]];
}

- (void)dealloc {
	[super dealloc];
}

@end