class Location < ActiveRecord::Base
    def self.addlocation(loc,lati,longi)
        self.where(:location => loc).first_or_create(:location => loc,:latitude => lati,:langitude=>longi)
    end
end
