require 'net/http'
require 'json'
require 'geocoder'

class Post < ActiveRecord::Base
  def self.search(search)
    if !search.to_s.empty?
      Geocoder.configure(lookup: :opencagedata, api_key: "add69afabff34cde9210d12ebcb78123")
      results = Geocoder.search(search)
      location = results.first
      
      url = "https://api.darksky.net/forecast/1b25a4505d653947f357272c630ac71c/#{location.latitude},#{location.longitude}"
      uri = URI(url)
      response = Net::HTTP.get(uri)
      result  = JSON.parse(response)
      weather = result.fetch("currently").fetch("icon")
      clothes = weatherClothes(weather)
      return clothes
    else
      puts "Please type in a Location"
    end
  end

  def self.weatherClothes(weather)
    if weather == "clear-day"
      return clearDay(weather)
    elsif weather == "clear-night"
      return clearNight(weather)
    elsif weather == "partly-cloudy-day"
      return partlyCloudyDay(weather)
    elsif weather == "partly-cloudy-night"
      return partlyCloudyNight(weather)
    elsif weather == "cloudy"
      return cloudy(weather)
    elsif weather == "rain"
      return rain(weather)
    elsif weather == "sleet"
      return sleet(weather)
    elsif weather == "snow"
      return snow(weather)
    elsif weather == "wind"
      return wind(weather)
    elsif weather == "fog"
      return fog(weather)
    else

    end
  end

  def self.clearDay(weather)
    array = Array[weather,["Shirt","BasicClothes/shirt"],["Shorts","BasicClothes/short-1"],["Sneakers","BasicClothes/shoe-2"]]
    return array
  end

    def self.clearNight(weather)
    array = Array[weather,["Shirt","BasicClothes/shirt-1"],["Shorts","BasicClothes/short-2"],["Sneakers","AutumnClothes/027-shoe"],["Thin Jacket","BasicClothes/jacket"]]
    return array
  end

  def self.partlyCloudyDay(weather)
    array = Array[weather,["Shirt","BasicClothes/shirt"],["Shorts","BasicClothes/short-1"],["Sneakers","BasicClothes/shoe"],["Thin Jacket","BasicClothes/jacket"]]
    return array
  end

  def self.partlyCloudyNight(weather)
    array = Array[weather,["Shirt","BasicClothes/shirt-1"],["Shorts","BasicClothes/short-2"],["Sneakers","BasicClothes/shoe-2"],["Hoodie","AutumnClothes/029-hoodie"]]
    return array
  end

  def self.cloudy(weather)
    array = Array[weather,["Shirt","AutumnClothes/038-shirt"],["Jeans","AutumnClothes/032-jean"],["Sneakers","AutumnClothes/027-shoe"],["Jacket","AutumnClothes/035-jacket"]]
    return array
  end

  def self.rain(weather)
    array = Array[weather,["Rain Coat","AutumnClothes/001-raincoat"],["Shirt","AutumnClothes/038-shirt"],["Trousers","AutumnClothes/034-trousers"],["Boots","BasicClothes/boot"],["Umbrella","AutumnClothes/008-umbrella"]]
    return array
  end

  def self.sleet(weather)
    array = Array[weather,["Hat","WinterClothes/011-winter-hat-2"],["Gloves","WinterClothes/033-gloves-1"],["Blouse/Jumper","ChristmasClothes/046-blouse-1"],["Trousers","ChristmasClothes/028-pants"],["Boots","ChristmasClothes/047-boot-2"],["Coat","WinterClothes/041-coat"]]
    return array
  end

  def self.snow(weather)
    array = Array[weather,["Earmuffs","WinterClothes/038-earmuffs"],["Gloves","WinterClothes/015-winter-gloves"],["Scalf","WinterClothes/007-winter-scarf-1"],["Sweater","ChristmasClothes/023-sweater"],["Trousers","ChristmasClothes/028-pants"],["Boots","ChristmasClothes/049-boot"],["Coat","WinterClothes/039-coat-2"]]
    return array
  end

  def self.wind(weather)
    array = Array[weather,["Scarf","AutumnClothes/031-scarf"],["Jumper","AutumnClothes/009-sweater-3"],["Jeans","AutumnClothes/032-jean"],["Shoes","AutumnClothes/019-shoe-1"],["Short Jacket","WinterClothes/016-jacket-1"]]
    return array
  end

  def self.fog(weather)
    array = Array[weather,["Scarf","AutumnClothes/011-scarf-1"],["Jumper","AutumnClothes/024-sweater-1"],["Trousers","AutumnClothes/012-trouser"],["Shoes","ChristmasClothes/019-shoe-1"],["Parka","BasicClothes/parka"]]
    return array
  end
end