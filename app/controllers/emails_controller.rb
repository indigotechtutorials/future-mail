class EmailsController < ApplicationController
  def index
    @emails = current_user.emails.with_rich_text_body_and_embeds.order(created_at: :desc)
    if params[:search].present?
      query = "lower(subject) like lower(?) or lower(action_text_rich_texts.body) like lower(?)"
      @emails = @emails.joins(:action_text_rich_text).where(query, "%#{params[:search]}%", "%#{params[:search]}%")
    end
  end

  def new
    @email = current_user.emails.new 
  end

  def show
    @email = current_user.emails.find(params[:id])
  end

  def create
    @email = current_user.emails.create(email_params)
    if @email.save
      EmailMailer.with(email: @email).email_delivery.deliver_later
      redirect_to emails_path
    else
      render :new
    end
  end

  private

  def email_params
    params.require(:email).permit(:subject, :body, :to_address)
  end
end
