module TracksHelper
  
  def find_email(user_id)
    User.find(user_id).email
  end

 

end
