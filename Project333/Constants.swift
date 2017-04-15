//
//  Constants.swift
//  Project333
//
//  Created by Eric Wei on 2017-03-30.
//  Copyright © 2017 EricWei. All rights reserved.
//

import Foundation

extension WeatherClient {
    
    // MARK: Weather
    struct Weather {
        static let APIScheme = "http"
        static let APIHost = "api.openweathermap.org"
        static let APIPath = "/data/2.5/weather"
        
    }
    
    // MARK: Weather Parameter Keys
    struct WeatherParameterKeys {
        static let cityName = "q"
        static let APPID = "APPID"
    }
    
    // MARK: Weather Parameter Values
    struct WeatherParameterValues {
        static let cityName = "Waterloo"
        static let APPID = "89cdb96cbfd0e31c2574e88e3ab555d7"
    }
    
    // MARK: Weather Response Keys
    struct WeatherResponseKeys {
        static let Status = "stat"
        static let Photos = "photos"
        static let Photo = "photo"
        static let Title = "title"
        static let MediumURL = "url_m"
        static let Pages = "pages"
        static let Total = "total"
    }
    
    // MARK: Weather Response Values
    struct WeatherResponseValues {
        static let OKStatus = "ok"
    }
}
