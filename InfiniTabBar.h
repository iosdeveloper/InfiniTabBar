//
//  InfiniTabBar.h
//  Created by http://github.com/iosdeveloper
//  Edited by https://github.com/tolgatanriverdi
//

#import <UIKit/UIKit.h>

@protocol InfiniTabBarDelegate;

@interface InfiniTabBar : UIScrollView <UIScrollViewDelegate, UITabBarDelegate>


@property (nonatomic, assign) id infiniTabBarDelegate;


- (id)initWithItems:(NSArray *)items;
- (void)setBounces:(BOOL)bounces;
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