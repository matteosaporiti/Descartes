##
##            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
##                    Version 2, December 2004
## 
## Everyone is permitted to copy and distribute verbatim or modified
## copies of this license document, and changing it is allowed as long
## as the name is changed.
## 
##            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
##   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
## 
##  0. You just DO WHAT THE FUCK YOU WANT TO.
##

require 'open-uri'
require 'json'

class Descartes
  class Quotone
    include Cinch::Plugin

    match /quotone( [0-9]+){0,1}/

    def get(url)
      open(url) { |f|
        quote = JSON.parse f.read
        return "\##{quote['id']} - #{quote['source']} (#{quote['tags']})\n#{quote['quote'].nl2(' / ').decode}"
      }
    end

    def execute(m, num=-1)
      puts "ok, num = #{num}"
      if -1 == num
        m.reply get 'http://www.quotone.unsigned.it/api/random.json'
      else
        #should remove useless num
        num = num.to_i.to_s
        m.reply get "http://www.quotone.unsigned.it/api/get/#{num}.json"
      end 
    end
  end
end
