//
//  InfiniTabBar.h
//  Created by http://github.com/iosdeveloper
//

#import <UIKit/UIKit.h>

@protocol InfiniTabBarDelegate;

@interface InfiniTabBar : UIScrollView

@property (nonatomic, weak) id<InfiniTabBarDelegate> infiniTabBarDelegate;
@property (nonatomic, strong) NSMutableArray *tabBars;
@property (nonatomic, strong) UITabBar *aTabBar;
@property (nonatomic, strong) UITabBar *bTabBar;

- (id)initWithItems:(NSArray *)items;
- (void)setBounces:(BOOL)bounces;
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