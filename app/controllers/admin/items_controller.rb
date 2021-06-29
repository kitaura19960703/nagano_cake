class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end
  def new
    @item = Item.new
  end
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      render action: :new
    end
  end
  def show
    @item = Item.find(params[:id])
    # (params[:id])はrails routesでidが記載されてあるものはつける
    # form_withなどがない場合はつけなくていい
    @new_item = Item.new
  end
  def edit
    @item = Item.find(params[:id])
  end
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
     redirect_to admin_item_path(@item.id)
    else
      render action: :edit
    end
  end
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to admin_items_path
  end
  private
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
    # (item_params)とアクションの後ろにつけることでrequireのpermit(カラム)を変更したりできる
  end
end
