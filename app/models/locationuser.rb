class Locationuser < ActiveRecord::Base
    def self.addsharelocation(loc,curentuser,shareto)
         if shareto == "public"
            self.create(location_id: loc,shared_by_id: curentuser,shared_to_id: 0,is_public: 1)
         else
            self.create(location_id: loc,shared_by_id: curentuser,shared_to_id: shareto,is_public: 0)
         end
    end
end
