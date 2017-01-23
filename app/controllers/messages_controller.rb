class MessagesController < ApplicationController
  # editとupdateが呼ばれる前にset_messageを実行
  before_action :set_message, only: [:edit, :update, :destroy]
  
  def index
    # モデルインスタンスを初期化
    @message = Message.new
    
    # モデルから全データを取得
    @messages = Message.all
  end
  
  def edit
    
  end
  
  def update
    if @message.update(message_params)
      # 保存に成功した場合はトップページにリダイレクト
      redirect_to root_path, notice: 'メッセージを編集しました。'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  def destroy
    @message.destroy
    redirect_to root_path, notice: 'メッセージを削除しました。'
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
  def set_message
    @message = Message.find(params[:id])
  end
  
  def message_params
    params.require(:message).permit(:name, :body)
  end
end
