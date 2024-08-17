class Email < ApplicationRecord
  belongs_to :user
  has_rich_text :body
  has_one :action_text_rich_text,
    class_name: 'ActionText::RichText',
    as: :record

  validates_presence_of :to_address, :subject, :body

  after_create_commit :broadcast_new_email

  private

  def broadcast_new_email
    broadcast_prepend_to(user, :emails, target: "emails-list", partial: "emails/email", locals: { email: self })
  end
end
