//
//  TRAudioTool.h
//  LocalMusicPlayer
//
//  Created by tarena on 16/3/1.
//  Copyright © 2016年 EvilCompssion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface TRAudioTool : NSObject

//给定mp3文件的名字，返回对应的player对象(本地音乐播放)
+ (AVAudioPlayer *)playerMusicWithFileName:(NSString *)fileName;
//给定mp3文件的名字
+ (void) stopMusicWithFileName:(NSString *)fileName;

@end
