class RoomsController < ApplicationController
  def show
    @room = Room.find(params[:id]) # ルーム情報の取得
    @message = Message.new # 新規メッセージ投稿
    @messages = @room.messages # このルームのメッセージを全て取得
    if user_signed_in?
      if @room.user.id == current_user.id
        @company = @room.company
      else
        redirect_to "/"
      end
    elsif company_signed_in?
      if @room.company.id == current_company.id
        @user = @room.user
      else
        redirect_to "/"
      end
    else
      redirect_to "/"
    end
  end

  def create
    if user_signed_in?
      @room = Room.new(room_company_params)
      @room.user_id = current_user.id
    elsif company_signed_in?
      @room = Room.new(room_user_params)
      @room.company_id = current_company.id
    else
      redirect_to "/"
    end

    if @room.save
      redirect_to :action => "show", :id => @room.id
    else
      redirect_to "/"
    end
  end

  private

  def room_company_params
    params.require(:room).permit(:company_id)
  end

  def room_user_params
    params.require(:room).permit(:user_id)
  end
end
