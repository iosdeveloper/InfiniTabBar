//
//  VSTabBar.h
//
//  Created by Vincent Saluzzo on 25/05/12.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSTabBarItem.h"
#import "UIImage+ImageProcessing.h"

@class VSTabBar;

@protocol VSTabBarDelegate <NSObject>

-(void) tabBar:(VSTabBar*)tabBar selectedItemWithIndex:(NSInteger)index;

@end


@interface VSTabBar : UIView {
    

}

@property (nonatomic, readonly) NSArray *itemList;
@property (nonatomic, readonly) VSTabBarItem *selectedItem;

@property (nonatomic, assign) BOOL drawTitle;
@property (nonatomic, assign) BOOL drawImage;
@property (nonatomic, assign) BOOL showCurrentSelected;
@property (nonatomic, assign) BOOL showSeparationBetweenItems;
@property (nonatomic, assign) BOOL showSelectedItem;
@property (nonatomic, assign) BOOL isTopBar;
@property (nonatomic, retain) UIColor* backgroundColor;
@property (nonatomic, retain) UIColor* selectionGradientColor;
@property (nonatomic, retain) UIColor* currentSelectionIndicatorColor;
@property (nonatomic, retain) UIColor* separatorColor;
@property (nonatomic, retain) UIColor* foregroundColor;
@property (nonatomic, assign) id<VSTabBarDelegate> delegate;

-(void) setItems:(NSArray*)items;
-(void) selectItem:(NSInteger)index;
@end
