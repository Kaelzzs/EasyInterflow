//
//  MyRCConversationListViewController.m
//  易交流
//
//  Created by Kael on 16/6/19.
//  Copyright © 2016年 创维海通. All rights reserved.
//

#import "MyRCConversationListViewController.h"

@implementation MyRCConversationListViewController



//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = @"想显示的会话标题";
    [self.navigationController pushViewController:conversationVC animated:YES];
}


@end
