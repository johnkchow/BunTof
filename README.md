#Valentines App!

An Instagram-like app developed as a 2014 Valentines gift for my girlfriend :D. This app was originally targeted for iOS 7.

So why did I give my girlfriend an app instead of something physical like jewelry?

1. I'm a nerd and wanted to dive deeper into iOS development
2. My girlfriend loves Instagram and photos
3. BONUS: I also didn't have to spend any money!


##Goals

- Learn about iOS's flavor for MVC paradigm
- Fetch remote data via HTTP
- Deserialize data payloads into model objects
- Basic animations
- Create dynamically sized `UITableViewCell`
- Play audio file

##Technologies/Libraries Used
- UIKIT's Dynamics for the gravity animation on the loading screen
- MediaPlayer framework to play an MP3 file for the loading screen
- Auto Layout to layout each "post"
- [rootd/AMAAttributedHighlightLabel](https://github.com/johnkchow/AMAttributedHighlightLabel) for the stylized hashtag text
- [AFNetworking/AFNetworking](https://github.com/AFNetworking/AFNetworking) to fetch payload JSON and images from S3
- [Mantle/Mantle](https://github.com/Mantle/Mantle) for JSON deserialization
- [ReactiveCocoa/ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) to handle async ops i.e. networking and UI events
- A [custom Ruby script](https://github.com/johnkchow/BunTof/blob/master/bin/update_info_plist) to inject PList values based on current configuration (i.e. `Debug` vs `Release`)
