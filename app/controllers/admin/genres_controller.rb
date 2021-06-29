class Admin::GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.new
  end
  def create
    @genres = Genre.all
    @genre = Genre.new(genre_params)
    if @genre.save
    flash[:notice] = '投稿しました'
    redirect_to admin_genres_path
    # noticeはredirect_toの前に書く
    else
    render action: :index
    # createを設定する時はストロングパラメータとsaveとredirect先がセット
    end
  end
  def edit
    @genre = Genre.find(params[:id])
  end
  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
    flash[:notice] = '保存しました'
    redirect_to admin_genres_path
    else
     render action: :edit
    # redirect_to(成功)とrender(失敗)した時の飛ぶ場所は同じでもいい
    end
    # rails routesでupdateを見るとputchとputが出るがこの違いは？
  end
  private
  def genre_params
    params.require(:genre).permit(:name)
  end
end
