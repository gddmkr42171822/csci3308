#This file is for the project controller which ties the different actions with
#corresponding views and models


class ProjectsController < ApplicationController
  
  before_filter :correct_user,   only: :destroy

  #This method shows a single project

  def show
    #if current_user?
     # @project = current_user.projects.find(params[:id])
    #else
      #@project = current_user.projects.find(params[:id])
    #end
    if @user.nil? || current_user.nil?
      @project = Project.find(params[:id])
    end

   end

   #The method which initiates the form of creating a new project
  def new
  end

  #The action of creating the project itself
  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      redirect_to project_path(@project)
    else
      flash[:warning] = "it didn't work. try again."
      render 'static_pages/home'
    end
  end

#The searching method applied on projects
  def search
     @projects = Project.search(params[:search])
     if @projects.empty?
      flash.now[:warning] = "No result found"
    end
  end
  
    
#Showing the index or total list of projects

  def index
	  #@user = User.find(params[:id])
   if :search_query
      @projects = Project.search(params[:search_query])
       @projects = @projects.sort!{ |x, y| x["created_at"] <=> y["created_at"] }.reverse
     else
       @projects = Project.find(:all, :order => 'projects.created_at').reverse
    end

    # if signed_in?
    #   @projects = current_user.projects.paginate(page: params[:page])
    
    # else
    #   @projects = Project.all
    # end

  end

  def update
    @project = current_user.projects.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:success] = " #{@project.title} was successfully updated!"
      redirect_to project_path(@project)
    else
      render 'edit'
    end
  end

  def edit
	@project = current_user.projects.find(params[:id])
  end

  def destroy
    @project.destroy
    flash[:success] = "#{@project.title} was removed!"
    redirect_to work_url
  end

 


private
  def project_params
    params.require(:project).permit(:title, :location, :description)
  end
  def correct_user
      @project = current_user.projects.find(params[:id])
      redirect_to root_url if @project.nil?
    end

end
