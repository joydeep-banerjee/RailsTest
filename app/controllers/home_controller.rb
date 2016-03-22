class HomeController < ApplicationController
  def index 
        if user_signed_in?   
                    @sql1="Select locations.id as locid,locations.location,locations.latitude,locations.langitude,users.id as shared_by_id,users.email as sharebyemail,shareuser.id as shared_to_id,shareuser.email as sharetoemail from locationusers join locations
             on locationusers.location_id=locations.id join users on users.id=locationusers.shared_by_id join users as shareuser on shareuser.id=locationusers.shared_to_id where locationusers.shared_to_id=#{current_user.id}"
                    @shareToloc=User.connection.select_all(@sql1)
                    
                    @sql2="Select locations.id as locid,locations.location,locations.latitude,locations.langitude,users.id as shared_by_id,users.email as sharebyemail,shareuser.id as shared_to_id,shareuser.email as sharetoemail from locationusers join locations
             on locationusers.location_id=locations.id join users on users.id=locationusers.shared_by_id join users as shareuser on shareuser.id=locationusers.shared_to_id where locationusers.shared_by_id=#{current_user.id}"
                    @shareByloc=User.connection.select_all(@sql2)
                    
                    @sql3="Select locations.id as locid,locations.location,locations.latitude,locations.langitude,users.id as shared_by_id,users.username as sharebyname,users.email as sharebyemail,locationusers.is_public from locationusers join locations
             on locationusers.location_id=locations.id join users on users.id=locationusers.shared_by_id where locationusers.is_public=1"
                    @publicloc=User.connection.select_all(@sql3)
        end
  end
  def sharelocation
     if user_signed_in?
        @sql="Select users.id as userid,users.username,users.email as usermail,fusers.id,fusers.username,fusers.email from users join friends on friends.friend_id=users.id join users as fusers on fusers.id=friends.user_id 
where (friends.friend_id=#{current_user.id} or friends.user_id=#{current_user.id})"
        @userfriend=User.connection.select_all(@sql)
      else
        redirect_to controller: "home", action: "index"
      end        
  end
  def addshare
        #render html: "<p>#{@c}#{params[:key]}</p>".html_safe 
        #render html: "<p>#{params}</p>".html_safe
        loc=Location.addlocation(params[:location],params[:latitude],params[:longitude])
        $i=0
        while $i < params[:shareto].length
            Locationuser.addsharelocation(loc.id,params[:userid],params[:shareto][$i])
            $i +=1
        end
        
        #render html: "<p>#{loc.id}</p>".html_safe
        redirect_to controller: "home", action: "index"
  end
  def shareto_loc  
     if user_signed_in?    
        @sqltoloc="select * from locations join locationusers on locations.id=locationusers.location_id where locationusers.is_public!=1 and locationusers.shared_to_id=#{current_user.id} and locationusers.location_id=#{params[:locid]}"
        @qtoloc=Location.connection.select_all(@sqltoloc)
        @qtoloc.each do |dtt|
            @lat=dtt["latitude"]
            @longi=dtt["langitude"]
            @place=dtt["location"]
        end
        render layout: "share"
      else
        redirect_to controller: "home", action: "index"
      end      
  end
  def shareby_loc
    if user_signed_in?
        @sqlbyloc="select * from locations join locationusers on locations.id=locationusers.location_id where locationusers.is_public!=1 and locationusers.shared_by_id=#{current_user.id} and locationusers.location_id=#{params[:locid]}"
        @qbyloc=Location.connection.select_all(@sqlbyloc)
        @qbyloc.each do |dt|
            @lat=dt["latitude"]
            @longi=dt["langitude"]
            @place=dt["location"]
        end
        render layout: "share"
     else
        redirect_to controller: "home", action: "index"
      end         
  end
  def public_loc
    if user_signed_in?
        @sqlpublic="select * from locations join locationusers on locations.id=locationusers.location_id join users 
on locationusers.shared_by_id=users.id where locationusers.is_public=1 and users.email='#{params["usernm"]}.com'"
        @qpublic=Location.connection.select_all(@sqlpublic)
        @latpub=[]
        @longipub=[]
        @placepub=[]
        @qpublic.each do |pub|
            @latpub.push(pub["latitude"])
            @longipub.push(pub["langitude"])
            @placepub.push(pub["location"])
        end
          #render html: "<p>#{@placepub}</p>".html_safe
          render layout: "public"
        else
        redirect_to controller: "home", action: "index"
      end   
  end
  def makefriend
      if user_signed_in?
      @user=User.all
      
      
  @sql="Select users.id as userid,users.username,users.email as usermail,fusers.id,fusers.username,fusers.email from users join friends on friends.friend_id=users.id join users as fusers on fusers.id=friends.user_id 
where (friends.friend_id=#{current_user.id} or friends.user_id=#{current_user.id})"
        @userfriend=User.connection.select_all(@sql)
        else
        redirect_to controller: "home", action: "index"
      end      
  end
  def addfriend
      #loc=Location.addlocation(params[:location],)
        $i=0
        while $i < params[:friend].length
            Friend.addfrd(params[:userid],params[:friend][$i])
            $i +=1
        end
    redirect_to controller: "home", action: "makefriend"  
     #redirect_to controller: "home", action: "index"
     #render html: "<p>#{params}</p>".html_safe
  end
end