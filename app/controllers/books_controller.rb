class BooksController < ApplicationController

  before_action :logged_in_admin, only: [:edit, :update, :new, :add, :destroy]
  def home
    @books=Book.all
  end

  def show
  	@book=Book.find(params[:id])
  end

  def new
  	@book=Book.new
  	@book.authors.build
  end

  def create
  	@book=Book.new(book_params)
  	if @book.save
      flash[:success]="new book is added"
  		redirect_to @book

  	else
  		render 'new'
  	end
  end

  def edit
    @book=Book.find(params[:id])
  end

  def update
    @book=Book.find(params[:id])
    @authors=@book.authors.all
    if @book.update_attributes(book_params)
      flash[:success]="book is updated"
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    Book.find(params[:id]).destroy
    flash[:success] = "book is deleted"
    redirect_to home_url
  end

  def search
  end

  def find
    
  end


  def logged_in_admin
    unless logged_in?
      flash[:danger]="please log in"
      redirect_to login_url
    end
  end



  private

    def book_params
      params.require(:book).permit(:title, :publisher, :isbn,
                                   :publishing_date , :authors_attributes => [:id, :name])
    end
end
