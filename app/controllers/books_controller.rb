class BooksController < ApplicationController
  before_action :authenticate_user!

  before_action :fraud_prevntion, only: [:edit, :update]

  # 不正アクセス防止
  def fraud_prevntion
    @book = Book.find(params[:id])
    unless current_user.id == @book.user.id
      redirect_to books_path
    end
  end



  def show
  	@book = Book.find(params[:id])
    @nil = Book.new #本の投稿がないとき
  end

  def index
    @book = Book.new
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
  end

  def create
  	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @book.user_id = current_user.id
    @books = Book.all
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to  book_path(@book.id), notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		redirect_to  books_path(@book.id), notice: "error !!!"
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end



  def update
  	book = Book.find(params[:id])
  	if book.update(book_params)
  		redirect_to book_path(book.id), notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		#render "edit"
      redirect_to  book_path(book.id), notice: "error !!!"
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
