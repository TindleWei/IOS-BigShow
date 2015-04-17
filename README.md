# IOS-BigShow

###第三方的库

####SDWebImage  
https://github.com/rs/SDWebImage

```
#import <SDWebImage/UIImageView+WebCache.h>

[cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.domain.com/path/to/image.jpg"]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
```
