class MessagesController < ApplicationController

  def index
    @conversations = current_user.mailbox.conversations
    @notifications = current_user.mailbox.notifications.group_by &:sender_id
    @receipts = current_user.mailbox.receipts
    @message = current_user.mailbox.inbox.first.messages.first.body

  end

  def new
    @user = User.find(params[:user])
    @message = current_user.messages.new
  end
 
  def create
    binding.pry
    @recipient = User.find_by(params[:id])
    current_user.send_message(@recipient, params[:body], params[:subject])
    flash[:notice] = "Message has been sent"
    redirect_to :conversations
  end


end
