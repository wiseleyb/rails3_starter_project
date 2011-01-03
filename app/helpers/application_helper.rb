module ApplicationHelper

  def editor?(obj, id = current_user.id, options = {})
    options[:field] ||= :user_id
    options[:check_signed_in] ||= true
    (user_signed_in? || options[:check_signed_in] == false) && obj[options[:field]] == id
  end
  
end
