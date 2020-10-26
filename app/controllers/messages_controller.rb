# frozen_string_literal: true

# This controller handles the mailer
class MessagesController < ApplicationController
  # create a new messsage
  def new
    @message = Message.new
  end

  # check message params and sent email
  def create
    @message = Message.new message_params

    if @message.valid?
      MessageMailer.contact(@message).deliver_now
      # render 'email_success'
      respond_to do |format|
        format.html
        format.js {render js: 'email_success'}
      end
    else
      respond_to do |format|
        format.html
        format.js {render js: 'email_failure'}
      end
    end
  end

  private

  # message parameters
  def message_params
    params.require(:message).permit(:name, :email, :return_address, :subject, :body)
  end
end
