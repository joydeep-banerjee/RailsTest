module Fetchdata
    def self.getuser
      @sql="Select * from users join friends on friends.friend_id=users.id where users.id=#{current_user.id}"
      @query=User.connection.select_all(@sql)
    end
end