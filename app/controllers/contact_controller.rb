class ContactController < MixedUseController
  skip_before_filter :auth_required

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    
    if @message.valid?
      admins = current_organization.nil? ? User.where(admin: true) : current_organization.users.where(admin: true)
      admins.each do |user|
        ContactMailer.contact_admins(@message, user, current_organization).deliver
      end
      redirect_to(root_path, :notice => "Message was successfully sent.")
    else
      flash.now.alert = "Please fill all fields."
      render :new
    end
  end
end
