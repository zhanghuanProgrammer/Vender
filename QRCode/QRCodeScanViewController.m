
#import "QRCodeScanViewController.h"
#import <AVFoundation/AVFoundation.h>

#define MAINSCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SYSTEM_VERSION_FLOAT [[UIDevice currentDevice]systemVersion].floatValue

@interface QRCodeScanViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>
{
    AVCaptureSession *avSession;
    AVCaptureDevice  *avDevice;
    AVCaptureDeviceInput *avInput;
    AVCaptureMetadataOutput *avOutput;
    AVCaptureVideoPreviewLayer *preViewLayer;
    BOOL isQRCode;
    CGRect drawRect;
    UIImageView *blueImageView;
    NSString *tiaoxinmaString;
}
@property (strong, nonatomic) UILabel *descriptionLabel;

@end

@implementation QRCodeScanViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
     
    isQRCode = YES;
    [self createScanner];
    [self.view insertSubview:[self makeScanCameraShadowViewWithRect:[self makeScanReaderInterrestRect]] atIndex:1];
    
    self.title = @"扫描二维码";
    [TabBarAndNavagation setTitleColor:[UIColor whiteColor] forNavagationBar:self];
    [TabBarAndNavagation setLeftBarButtonItemCustom:[self createNavigationBarBackbBtn] TintColor:[UIColor whiteColor] target:self action:@selector(clickBackBtn)];
}

//返回按钮
- (UIButton *)createNavigationBarBackbBtn{
    CGFloat btnW=11;
    CGFloat btnH=20;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, btnW, btnH)];
    UIImage *backImage=[UIImage imageNamed:@"BackWhite"];
    imageView.image=backImage;
    UIButton  *backBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0,44, 44)];
    [backBtn addSubview:imageView];
    imageView.centerY=backBtn.centerY;
    return backBtn;
}
- (void)clickBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tiaoxingmaBtn{
    isQRCode = !isQRCode;
    NSArray *arr = [self.view subviews];
    for (UIView *view in arr) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    [self.view insertSubview:[self makeScanCameraShadowViewWithRect:[self makeScanReaderInterrestRect]] atIndex:1];
    
}

 //扫码框frame
- (CGRect)makeScanReaderInterrestRect {
    CGFloat size = MIN(MAINSCREEN_BOUNDS.size.width, MAINSCREEN_BOUNDS.size.height)*3.5/5;
    CGRect scanRect = CGRectMake(0, 0, size, size);
    scanRect.origin.x = MAINSCREEN_BOUNDS.size.width/2 - scanRect.size.width / 2;
    scanRect.origin.y = MAINSCREEN_BOUNDS.size.height / 3 - scanRect.size.height / 2;
    return scanRect;
}


 //生成扫码框
- (UIImageView *)makeScanCameraShadowViewWithRect:(CGRect)rect {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:MAINSCREEN_BOUNDS];
    UIGraphicsBeginImageContext(imgView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0, 0, 0, 0.3);
    drawRect = MAINSCREEN_BOUNDS;
    CGContextFillRect(context, drawRect);
    
    if (isQRCode) {
        [self.descriptionLabel removeFromSuperview];
        drawRect = CGRectMake(rect.origin.x - imgView.frame.origin.x, rect.origin.y - imgView.frame.origin.y+60, rect.size.width, rect.size.height);
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(drawRect.origin.x, drawRect.origin.y+drawRect.size.height+20, drawRect.size.width, 100.0)];
        self.descriptionLabel.font = [UIFont systemFontOfSize:12];
//        self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
        self.descriptionLabel.textColor= [UIColor whiteColor];
        self.descriptionLabel.numberOfLines=0;
        self.descriptionLabel.text = @"在浏览器中打开网址sao.cjol.com，扫描网页中的二维码，可在网页中更轻松的填写简历";
        [self.view addSubview:self.descriptionLabel];
    }
    else {
        [self.descriptionLabel removeFromSuperview];
        drawRect = CGRectMake(rect.origin.x - imgView.frame.origin.x-rect.size.width/6, rect.origin.y - imgView.frame.origin.y+rect.size.height/3, rect.size.width*4/3, rect.size.height*2/3);
         self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(drawRect.origin.x, drawRect.origin.y+drawRect.size.height, drawRect.size.width, 60.0)];
        self.descriptionLabel.font = [UIFont systemFontOfSize:12];
        self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
        self.descriptionLabel.textColor= [UIColor whiteColor];
        self.descriptionLabel.text = @"将条码放入框内，即可自动扫描";
        [self.view addSubview:self.descriptionLabel];
    }
    [self createMovingBlueViewWithFrame:drawRect];
    [self createCornerView:drawRect];
    CGContextClearRect(context, drawRect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imgView.image = image;
    return imgView;
}


 //扫码移动蓝条
- (void)createMovingBlueViewWithFrame:(CGRect)frame {
    UIImage *image = [UIImage imageNamed:@"line@2x"];
    frame.size.height = 4.0f;
    blueImageView = [[UIImageView alloc] initWithFrame:frame];
    [self.view addSubview:blueImageView];
    blueImageView.image = image;
    if (isQRCode) {
        frame.origin.y += frame.size.width-frame.size.height;
    }
    else {
        frame.origin.y += frame.size.width*2/3-55;
    }
    
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveEaseOut animations:^{
        blueImageView.frame = frame;
    } completion:nil];
}


 //四边角

- (void)createCornerView:(CGRect)frame {
    UIImage *upLeftImg = [UIImage imageNamed:@"leftCorner"];
    UIImageView *upleftimgView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x-8 , frame.origin.y-8, 20.0, 20.0)];
    upleftimgView.image = upLeftImg;
    UIImageView *downLeftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x-8 , frame.origin.y+8 + frame.size.height-20.0, 20.0, 20.0)];
    downLeftImgView.image = [UIImage imageNamed:@"downLeftCorner"];
    UIImageView *upRightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x+8 + frame.size.width-20.0, frame.origin.y-8, 20.0, 20.0)];
    upRightImgView.image = [UIImage imageNamed:@"rightCorner"];
    UIImageView *downRightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x + frame.size.width-20.0+8, frame.origin.y + frame.size.height-20.0+8, 20.0, 20.0)];
    downRightImgView.image = [UIImage imageNamed:@"downRightCorner"];
    [self.view addSubview:upRightImgView];
    [self.view addSubview:downRightImgView];
    [self.view addSubview:downLeftImgView];
    [self.view addSubview:upleftimgView];
}


 //生成扫码器

- (void)createScanner {
    avDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    avInput = [AVCaptureDeviceInput deviceInputWithDevice:avDevice error:nil];
    avOutput = [[AVCaptureMetadataOutput alloc] init];
    [avOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    avSession = [[AVCaptureSession alloc] init];
    [avSession setSessionPreset:AVCaptureSessionPresetHigh];
    if ([avSession canAddInput:avInput]) {
        [avSession addInput:avInput];
    }
    if ([avSession canAddOutput:avOutput]) {
        [avSession addOutput:avOutput];
    }
    
    if (SYSTEM_VERSION_FLOAT < 8.0) {
        avOutput.metadataObjectTypes = @[AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeQRCode,AVMetadataObjectTypeAztecCode,/*AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode*/];
    }
    else {
        avOutput.metadataObjectTypes = @[AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeQRCode,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode];
    }
    
    preViewLayer = [AVCaptureVideoPreviewLayer layerWithSession:avSession];
    preViewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    preViewLayer.frame = CGRectMake(0, 0, MAINSCREEN_BOUNDS.size.width, MAINSCREEN_BOUNDS.size.height);
    [self.view.layer insertSublayer:preViewLayer atIndex:0];
    [avSession startRunning];
}



 //扫码完成后代理

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    [avSession stopRunning];
    [blueImageView.layer removeAllAnimations];
    if (stringValue.length > 0) {
        tiaoxinmaString = stringValue;
        
     }
}

/*
 注：若添加alert 注意添加tag值区分
 */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1001) {
//        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma clang diagnostic pop

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!avSession.isRunning) {
        [avSession startRunning];
        [self createMovingBlueViewWithFrame:drawRect];
    }
}

@end
