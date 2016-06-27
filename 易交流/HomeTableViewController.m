//
//  HomeTableViewController.m
//  易交流
//
//  Created by Kael on 16/6/19.
//  Copyright © 2016年 创维海通. All rights reserved.
//

#import "HomeTableViewController.h"

@implementation HomeTableViewController



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:
        {
            //新建一个聊天会话View Controller对象
            MyRCConversationViewController *chat = [[MyRCConversationViewController alloc]init];
            //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
            chat.conversationType = ConversationType_PRIVATE;
            //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
            chat.targetId = @"10101011";
            //设置聊天会话界面要显示的标题
            chat.title = @"想显示的会话标题";
            //显示聊天会话界面
            [self.navigationController pushViewController:chat animated:YES];
 
            
            break;
        }
        case 1:
        {
            MyRCConversationListViewController *chatListVC = [[MyRCConversationListViewController alloc] init];
            [chatListVC setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                                      @(ConversationType_DISCUSSION),
                                                      @(ConversationType_CHATROOM),
                                                      @(ConversationType_GROUP),
                                                      @(ConversationType_APPSERVICE),
                                                      @(ConversationType_SYSTEM)]];
            //设置需要将哪些类型的会话在会话列表中聚合显示
            [chatListVC setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                                        @(ConversationType_GROUP)]];
            [self.navigationController pushViewController:chatListVC animated:YES];
            

            
            break;
        }
        case 2:
        {
#define RCloud_KeFu_ID      @"KEFU146633202455070"
  
            //    RCDCustomServiceViewController *chatService = [[RCDCustomServiceViewController alloc] init];
            //    chatService.userName = @"客服";
            //    chatService.conversationType = ConversationType_CUSTOMERSERVICE;
            //    chatService.targetId = RCloud_KeFu_ID;
            //    chatService.title = chatService.userName;
            //    [self.navigationController pushViewController :chatService animated:YES];
            break;
        }
        case 3:
        {
            
            
            break;
        }
        case 4:
        {
            
            
            break;
        }
        case 5:
        {
            
            
            break;
        }
        case 6:
        {
            
            
            break;
        }
        case 7:
        {
            
            
            break;
        }
            
        default:
            break;
    }

}

@end
