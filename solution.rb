
require 'Date'

string = "photo.jpg, Krakow, 2013-09-05 14:08:15
Mike.png, London, 2015-06-20 15:13:22
myFriends.png, Krakow, 2013-09-05 14:07:13
Eiffel.jpg, Florianopolis, 2015-07-23 08:03:02
pisatower.jpg, Florianopolis, 2015-07-22 23:59:59
BOB.jpg, London, 2015-08-05 00:02:03
notredame.png, Florianopolis, 2015-09-01 12:00:00
me.jpg, Krakow, 2013-09-06 15:40:22
a.png, Krakow, 2016-02-13 13:33:50
b.jpg, Krakow, 2016-01-02 15:12:22
c.jpg, Krakow, 2016-01-02 14:34:30
d.jpg, Krakow, 2016-01-02 15:15:01
e.png, Krakow, 2016-01-02 09:49:09
f.png, Krakow, 2016-01-02 10:55:32
g.jpg, Krakow, 2016-02-29 22:13:11"


def solution(str)
    arr = str.split("\n")
    photo_hash = {}
    arr_of_obj = build_photo_hash(arr, photo_hash)
    photo_hash.each do |key, val|
        val.sort! do |a, b| 
            DateTime.parse(a[:time]) <=> DateTime.parse(b[:time])
        end
    end
    photo_hash.each do |key, val|
        count = val.count
        nums = (count/10).to_i + 1
        val.each_with_index do |photo, index|
            i = index+1
            regex = /\..*\z/
            result = photo[:title].match(regex)[0]
            photo[:new_string] = "#{photo[:city]}#{i.to_s.rjust(nums, '0')}#{result}"
        end
    end
    arr_of_obj.map do |original|
        o_title = original[:title].strip
        o_city = original[:city].strip
        el = photo_hash[o_city].find { |i| i[:title] == o_title }
        el[:new_string]
    end
end

def build_photo_hash(arr, photo_hash)
    arr_of_objects = arr.map do |photo|
        photo_info = photo.split(",")
        title = photo_info[0]
        city = photo_info[1]
        time = photo_info[2]
        photo_data = {title: title, city: city, time: time}

        if photo_hash[city.strip]
            photo_hash[city.strip] << photo_data
        else 
            photo_hash[city.strip] = [photo_data]
        end

        photo_data
    end
    arr_of_objects
end

puts solution(string)