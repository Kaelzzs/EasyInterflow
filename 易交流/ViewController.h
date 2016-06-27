//
//  ViewController.h
//  易交流
//
//  Created by Kael on 16/6/14.
//  Copyright © 2016年 创维海通. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HShakeAlertView.h"
#import "MBProgressHUD.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *coversationListBtn;



- (IBAction)coversationListAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *kefuBtn;
- (IBAction)kefuAction:(id)sender;

@end

