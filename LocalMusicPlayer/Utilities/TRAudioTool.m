//
//  TRAudioTool.m
//  LocalMusicPlayer
//
//  Created by tarena on 16/3/1.
//  Copyright © 2016年 EvilCompssion. All rights reserved.
//

#import "TRAudioTool.h"

@implementation TRAudioTool
//记录mp3文件URL和player对应的关系
static NSMutableDictionary *_playerDic;
+(NSMutableDictionary *)playerDic {
    if (!_playerDic) {
        _playerDic = [NSMutableDictionary dictionary];
    }
    return _playerDic;
}

+ (AVAudioPlayer *)playerMusicWithFileName:(NSString *)fileName {
    //从字典中取player对象(fileName -> 本地URL)
   // NSString *urlPath = [NSString stringWithFormat:@"MP3s/%@",fileName];
   // NSString *url = [[NSBundle mainBundle] URLForResource:urlPath withExtension:nil];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];

    AVAudioPlayer *player =self.playerDic[url];
    //如果没有，在创建，存到字典中
    if (!player) {
        NSError *error = nil;
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        if (!error) {
           self.playerDic[url] = player;
        }
    }
    //播发音乐
    if (!player.playing) {
        [player play];
    }
    //通过player对象，回去总时长／当前播放时长
    return player;
}

+ (void)stopMusicWithFileName:(NSString *)fileName {
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    AVAudioPlayer *player = self.playerDic[url];
    if (player) {
        [player stop];
        //把player对象从字典中删除
        [self.playerDic removeObjectForKey:url];
    }
    
}

@end
