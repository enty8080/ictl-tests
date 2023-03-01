#import <AVFoundation/AVFoundation.h>

@interface CameraViewController () <AVCaptureVideoDataOutputSampleBufferDelegate>
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureDeviceInput *frontCameraInput;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize the capture session
    self.captureSession = [[AVCaptureSession alloc] init];
    
    // Set up the front camera as the input device
    AVCaptureDevice *frontCamera = nil;
    NSArray *captureDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in captureDevices) {
        if (device.position == AVCaptureDevicePositionFront) {
            frontCamera = device;
            break;
        }
    }
    self.frontCameraInput = [AVCaptureDeviceInput deviceInputWithDevice:frontCamera error:nil];
    [self.captureSession addInput:self.frontCameraInput];
    
    // Set up the video data output
    self.videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    [self.videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    [self.videoDataOutput setVideoSettings:@{(id)kCVPixelBufferPixelFormatTypeKey: @(kCVPixelFormatType_32BGRA)}];
    [self.captureSession addOutput:self.videoDataOutput];
    
    // Set up the preview layer
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.previewLayer];
    
    // Start the capture session
    [self.captureSession startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    // This method will be called each time a new video frame is captured
    
    // Extract the pixel buffer from the sample buffer
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(pixelBuffer, 0);
    
    // Get the width and height of the pixel buffer
    size_t width = CVPixelBufferGetWidth(pixelBuffer);
    size_t height = CVPixelBufferGetHeight(pixelBuffer);
    
    // Get the base address of the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer);
    
    // Do something with the pixel buffer, for example create a UIImage and display it
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8, CVPixelBufferGetBytesPerRow(pixelBuffer), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    UIImage *image = [UIImage imageWithCGImage:quartzImage];
    CGImageRelease(quartzImage);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // Unlock the base address of the pixel buffer
    CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
}

@end
