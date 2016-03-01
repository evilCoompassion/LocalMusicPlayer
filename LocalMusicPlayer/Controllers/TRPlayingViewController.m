//
//  TRPlayingViewController.m
//  LocalMusicPlayer
//
//  Created by tarena on 16/3/1.
//  Copyright © 2016年 EvilCompssion. All rights reserved.
//

#import "TRPlayingViewController.h"
#import "UIView+Extension.h"
#import "TRMusic.h"
#import "TRMusicTool.h"
#import "UIImage+Circle.h"
#import "TRAudioTool.h"
#import <AVFoundation/AVFoundation.h>
@interface TRPlayingViewController ()

@property (weak, nonatomic) IBOutlet UILabel *songNameLabel;
//专辑封面视图
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;

@property (weak, nonatomic) IBOutlet UITableView *lrcTableView;
@property (weak, nonatomic) IBOutlet UILabel *currentDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalDurationLabel;
//sliderControl
@property (weak, nonatomic) IBOutlet UISlider *sliderControl;

@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) NSTimer *progressTimer;
@property (nonatomic, strong) TRMusic *currentPlayingMusic;

@end

@implementation TRPlayingViewController

- (TRMusic *)currentPlayingMusic {
    if (!_currentPlayingMusic) {
        _currentPlayingMusic = [TRMusicTool currentPlayingMusic];
    }
    return _currentPlayingMusic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - button action function
- (IBAction)clickBackButton:(id)sender {
    
    //视图回收
    [UIView animateWithDuration:1 animations:^{
        self.view.y = [[UIApplication sharedApplication] keyWindow].bounds.size.height;
        
    } completion:^(BOOL finished) {
        
    }];
    
}
//词图转换
- (IBAction)clickChangeButton:(id)sender {
}

- (IBAction)clickPreviousButton:(id)sender {
}
//点中播放按钮
- (IBAction)clickPlayButton:(id)sender {
}

- (IBAction)clickNextButton:(id)sender {
}

#pragma mark - 显示视图
- (void)showPlayingView {
    //获取window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //view添加到window
    [window addSubview:self.view];
    //设置添加的frame
    self.view.frame = window.bounds;
    //设置view的y值
    
    self.view.y = window.bounds.size.height;
    //执行动画
    [UIView animateWithDuration:1 animations:^{
        self.view.y = 0;
    } completion:^(BOOL finished) {
        //updata view and play
        [self startPlayingMusic];
        
    }];
}


#pragma mark - playing and update View
- (void) startPlayingMusic {
    
    //获取正在播放音乐对象
    TRMusic *music = [TRMusicTool currentPlayingMusic];
    if (self.currentPlayingMusic != music) {
        //把现在正在播放的音乐停止
        [self resetPlayingMusic];
    }
    self.currentPlayingMusic = music;
    //play
   self.player = [TRAudioTool playerMusicWithFileName:music.filename];
    [self addTargetToSlider];
   //启动定时器（监听播放进度）
    [self addprogressTimer];
    //更新歌曲名字
    self.songNameLabel.text = music.name;
    //imageView显示
    self.albumImageView.hidden = NO;
    UIImage *image = [UIImage imageNamed:music.icon];
    image = [UIImage scaleToSize:image size:self.albumImageView.frame.size];
    self.albumImageView.image = [UIImage circleImageWithImage:image borderWidth:5 borderColor:[UIColor lightGrayColor]];
    //旋转动画
    [self.albumImageView rotate:30];
    //跟新时长
    self.totalDurationLabel.text = [self stringFormatWithTimeInterval:self.player.duration];
    
}
//添加触发方法
- (void) addTargetToSlider {
    [self.sliderControl addTarget:self action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
}
//用户滑动slider并停止触发
- (void) touchUpInside {
    NSLog(@".....");
    //获取移动到的value
    //重新更新sliderValue值
    
    //跟新当前已播放时长
    self.player.currentTime = self.sliderControl.value *self.player.duration;
    self.currentDurationLabel.text = [self stringFormatWithTimeInterval:self.player.currentTime];
    //跟新player属性（currentTime）
    
    
}
//添加一个定时器
- (void)addprogressTimer {
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCurrentSliderValue) userInfo:nil repeats:YES];
    
}
//定时器出发方法（每隔一秒）
- (void)updateCurrentSliderValue {
        //跟新已经播放的时长
    self.currentDurationLabel.text = [self stringFormatWithTimeInterval:self.player.currentTime];
        //跟新slier
    float progress = self.player.currentTime/self.player.duration;
    self.sliderControl.value = progress;
    
}

- (NSString *)stringFormatWithTimeInterval:(NSTimeInterval)duration {
    int minute = (int) duration/60;
    int seconds = (int) duration%60;
    return [NSString stringWithFormat:@"%02d:%02d",minute,seconds];
    
}


- (void)resetPlayingMusic {
    
    [TRAudioTool stopMusicWithFileName:self.currentPlayingMusic.filename];
    self.currentDurationLabel.text = @"00:00";
    self.totalDurationLabel.text = @"00:00";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
