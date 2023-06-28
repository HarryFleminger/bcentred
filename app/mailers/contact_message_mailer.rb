class ContactMessageMailer < ApplicationMailer
  def contact_message(contact_message)
    @contact_message = contact_message
    mail(to: 'henry.fleminger@gmail.com', subject: "New B—Centred contact message from #{@contact_message.name}")
  end
end
