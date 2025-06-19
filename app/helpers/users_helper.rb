module UsersHelper

    def gravatar_for(user, options = {size: 80})
        # Assume you manually set the email_address here or get it from user input
        email_address = user.email.downcase
 
        # Create the SHA256 hash
        hash = Digest::SHA256.hexdigest(email_address)

        size = options[:size]
 
        image_src = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"

        image_tag(image_src, alt: user.username, class: "rounded shadow mx-auto d-block")
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
        !!current_user
    end
end
