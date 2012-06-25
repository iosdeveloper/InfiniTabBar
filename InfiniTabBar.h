//
//  InfiniTabBar.h
//  Created by http://github.com/iosdeveloper
//

#import <UIKit/UIKit.h>

@protocol InfiniTabBarDelegate;

@interface InfiniTabBar : UIView <UIScrollViewDelegate, UITabBarDelegate> {
	id <InfiniTabBarDelegate> infiniTabBarDelegate;
	NSMutableArray *tabBars;
	UITabBar *aTabBar;
	UITabBar *bTabBar;
    UIScrollView * theScrollView;
    UIPageControl * pageControl;
}

@property (nonatomic, assign) id infiniTabBarDelegate;
@property (nonatomic, retain) NSMutableArray *tabBars;
@property (nonatomic, retain) UITabBar *aTabBar;
@property (nonatomic, retain) UITabBar *bTabBar;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) UIScrollView *theScrollView;

- (id)initWithItems:(NSArray *)items;
- (void)setBounces:(BOOL)bounces;
- (void)setShowsHorizontalScroller:(BOOL)show;
- (void)setShowsPageControl:(BOOL)showsPageControl;

// Don't set more items than initially
- (void)setItems:(NSArray *)items animated:(BOOL)animated;
- (int)currentTabBarTag;
- (int)selectedItemTag;
- (BOOL)scrollToTabBarWithTag:(int)tag animated:(BOOL)animated;
- (BOOL)selectItemWithTag:(int)tag;

@end

@protocol InfiniTabBarDelegate <NSObject>
- (void)infiniTabBar:(InfiniTabBar *)tabBar didScrollToTabBarWithTag:(int)tag;
- (void)infiniTabBar:(InfiniTabBar *)tabBar didSelectItemWithTag:(int)tag;
@end