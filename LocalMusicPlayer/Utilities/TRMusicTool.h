//
//  TRMusicTool.h
//  LocalMusicPlayer
//
//  Created by tarena on 16/3/1.
//  Copyright © 2016年 EvilCompssion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRMusic.h"
@interface TRMusicTool : NSObject

//返回所有歌曲数组
+ (NSArray *)getMusicArray;
//设置当前正在播放歌曲(TRMusic)
+ (void) setCurrentPlayingMusic:(TRMusic *)music;
//返回当前正在播放歌曲对象（TRMusic）
+ (TRMusic *)currentPlayingMusic;
@end
