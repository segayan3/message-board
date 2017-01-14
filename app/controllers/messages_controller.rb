class MessagesController < ApplicationController
  def index
    # モデルインスタンスを初期化
    @message = Message.new
    
    # モデルから全データを取得
    @messages = Message.all
  end
  
  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to root_path, notice: 'メッセージを保存しました'
    else
      # メッセージ保存に失敗した時
      @messages = Message.all
      flash.now[:alert] = "メッセージの保存に失敗しました。"
      render 'index'
    end
  end
  
  private
  def message_params
    params.require(:message).permit(:name, :body)
  end
end
