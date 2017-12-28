class NotificationMailer < ApplicationMailer
    default from: 'no-reply@nerdster.com'
    
    def comment_added(comment)
        @place = comment.place
        @place_owner = @place.user
        mail(to: @place_owner, subject: "A comment has been added to #{@place.name}")
    end
end