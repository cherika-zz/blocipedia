class WikisController < ApplicationController
  include Pundit

  def index
    # @wikis = Wiki.all
    # @wikis = Wiki.visible_to(current_user)
    @wikis = policy_scope(Wiki)
    authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.build(params.require(:wiki).permit(:title, :body, :private))
    authorize @wiki
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an error. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :private))
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error updating. Please try again."
      render :new
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    if @wiki.destroy
      flash[:notice] = "Wiki was deleted successfully."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting this wiki."
      render :show
    end
  end

  # def wiki_params
  #   params.require(:wiki).permit(policy(@wiki).permitted_attributes)
  # end

end

