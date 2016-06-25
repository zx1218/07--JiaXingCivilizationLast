//
//  ShareViewController.h
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/23.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareViewController : UIViewController
- (IBAction)touchShare:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@end
