class CollaboratorsController < ApplicationController
  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find(params[:user_id])
    @collaborator = Collaborator.new(wiki: @wiki, user: @user)
    if @collaborator.save
      flash[:notice] = "Your wiki was updated."
    else
      flash[:notice] = "There was an error updating your wiki."
    end
    redirect_to request.referer
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    @user = User.find(params[:user_id])
    @collaborator = Collaborator.where(user: @user, wiki: @wiki).take
    if @collaborator.destroy
      flash[:notice] = "Wiki was sucessfully updated."
      redirect_to edit_wiki_path
    else
      flash[:error] = "There was an error. Please try again."
      render :show
    end
  end
end