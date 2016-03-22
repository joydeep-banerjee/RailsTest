class Friend < ActiveRecord::Base
    def self.addfrd(usrid,frnd)
        self.where("user_id = ? AND friend_id = ?", usrid, frnd).first_or_create(:user_id => usrid,:friend_id => frnd)
    end
end
