//
//  AppDelegate.swift
//  WeatherAppSwiftUI
//
//  Created by Ashok Devangam Yerra on 06/04/2021.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    var client = BGAPIService()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        application.setMinimumBackgroundFetchInterval(1800)
        registerForLocalNotifications()
        return true
    }
    
    func registerForLocalNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])  {
            success, error in
            if success {
                print("authorization granted")
            } else if let error = error {
                print(error)
            }
        }
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if application.backgroundRefreshStatus == .available {
            // yay!
            // fetch data from internet now
            fecthWeatherInBG {[weak self] (weatherData, error) in
                guard error == nil else {
                    completionHandler(.failed)
                    return
                }
                self?.setLocalNotification(weatherData: weatherData)
                completionHandler(.newData)
            }
        }
    }
    
    func fecthWeatherInBG(_ completionBlock:((_ result: WeatherData?, _ error: BGAPIError?) -> Void)?) {
        let lat = UserDefaults.standard.value(forKey: WeatherConstant.Strings.latitude) as? Double ?? 25.2048
        let lon = UserDefaults.standard.value(forKey: WeatherConstant.Strings.longitude) as? Double ?? 55.2708
        
        let climateRequest = BGWeatherRequest(lat, lon)
        client.performRequest(endpoint: climateRequest) { (response, error) in
            do {
                guard error == nil else {
                    completionBlock?(nil, error)
                    return
                }
                let weatherData: WeatherData? = try response?.getModel()
                completionBlock?(weatherData, nil)
            }
            catch let exception {
                let error = BGAPIError(code: 101, description: exception.localizedDescription)
                completionBlock?(nil, error)
            }
        }
    }
    
    func setLocalNotification(weatherData: WeatherData?) {
        
        let content = UNMutableNotificationContent()
        content.title = WeatherConstant.Strings.notificationTitle
        let contentBody = String(format: WeatherConstant.Strings.notificationBody, weatherData?.current.weather.first?.weatherDescription ?? "")
        content.body = contentBody
        content.sound = UNNotificationSound.default
        
        guard let imageURL = UIImage(named: WeatherConstant.Image.apple) else { return }
        let identifier = ProcessInfo.processInfo.globallyUniqueString
        
        if let attachment = UNNotificationAttachment.create(identifier: identifier, image: imageURL, options: nil) {
            // where myImage is any UIImage
            content.attachments = [attachment]
        }
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // 5.
        UNUserNotificationCenter.current().add(request)
    }
    
    func fetchSomeData() -> Bool? {
        return true
    }
}

extension UNNotificationAttachment {
    
    static func create(identifier: String, image: UIImage, options: [NSObject : AnyObject]?) -> UNNotificationAttachment? {
        let fileManager = FileManager.default
        let tmpSubFolderName = ProcessInfo.processInfo.globallyUniqueString
        let tmpSubFolderURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(tmpSubFolderName, isDirectory: true)
        do {
            try fileManager.createDirectory(at: tmpSubFolderURL, withIntermediateDirectories: true, attributes: nil)
            let imageFileIdentifier = identifier+".png"
            let fileURL = tmpSubFolderURL.appendingPathComponent(imageFileIdentifier)
            let imageData = UIImage.pngData(image)
            try imageData()?.write(to: fileURL)
            let imageAttachment = try UNNotificationAttachment.init(identifier: imageFileIdentifier, url: fileURL, options: options)
            return imageAttachment
        } catch {
            print("error " + error.localizedDescription)
        }
        return nil
    }
}
